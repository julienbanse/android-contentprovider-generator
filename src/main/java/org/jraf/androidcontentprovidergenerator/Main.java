/*
 * This source is part of the
 *      _____  ___   ____
 *  __ / / _ \/ _ | / __/___  _______ _
 * / // / , _/ __ |/ _/_/ _ \/ __/ _ `/
 * \___/_/|_/_/ |_/_/ (_)___/_/  \_, /
 *                              /___/
 * repository.
 * 
 * Copyright 2012 Benoit 'BoD' Lubek (BoD@JRAF.org).  All Rights Reserved.
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.jraf.androidcontentprovidergenerator;

import com.beust.jcommander.JCommander;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.jraf.androidcontentprovidergenerator.model.Constraint;
import org.jraf.androidcontentprovidergenerator.model.Entity;
import org.jraf.androidcontentprovidergenerator.model.EntityTable;
import org.jraf.androidcontentprovidergenerator.model.EntityType;
import org.jraf.androidcontentprovidergenerator.model.EntityView;
import org.jraf.androidcontentprovidergenerator.model.Field;
import org.jraf.androidcontentprovidergenerator.model.JsonConstants;
import org.jraf.androidcontentprovidergenerator.model.Model;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.FileFilter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class Main {

    private static String TAG = Constants.TAG + Main.class.getSimpleName();

    private static String FILE_CONFIG = "_config.json";

    public static class Json {

        public static final String TOOL_VERSION = "toolVersion";

        public static final String PROVIDER_PACKAGE = "providerPackage";

        public static final String PROVIDER_CLASS_NAME = "providerClassName";

        public static final String SQLITE_HELPER_CLASS_NAME = "sqliteHelperClassName";
    }

    private Configuration mFreemarkerConfig;

    private JSONObject mConfig;

    private Configuration getFreeMarkerConfig() {
        if (mFreemarkerConfig == null) {
            mFreemarkerConfig = new Configuration();
            mFreemarkerConfig.setClassForTemplateLoading(getClass(), "");
            mFreemarkerConfig.setObjectWrapper(new DefaultObjectWrapper());
        }
        return mFreemarkerConfig;
    }

    private void loadModel(File inputDir) throws IOException, JSONException {
        File[] entityFiles = inputDir.listFiles(new FileFilter() {
            @Override
            public boolean accept(File pathname) {
                return !pathname.getName().startsWith("_") && pathname.getName().endsWith(".json");
            }
        });
        for (File entityFile : entityFiles) {
            if (Config.LOGD) {
                Log.d(TAG, entityFile.getCanonicalPath());
            }
            String entityName = FilenameUtils.getBaseName(entityFile.getCanonicalPath());
            if (Config.LOGD) {
                Log.d(TAG, "entityName=" + entityName);
            }
            Entity entity;
            String fileContents = FileUtils.readFileToString(entityFile);
            JSONObject entityJson = new JSONObject(fileContents);
            EntityType entityType;
            //Entity type
            if (entityJson.has(JsonConstants.ENTITY_TYPE)) {
                entityType =
                        EntityType.valueOf(
                                entityJson.getString(JsonConstants.ENTITY_TYPE).toLowerCase());
                if (entityType == EntityType.view) {
                    entity = new EntityView(entityName);
                    ((EntityView) entity).setFromEntity(
                            entityJson.getString(JsonConstants.FROM_ENTITY));
                    ((EntityView) entity).setViewWhereSelect(
                            entityJson.optString(JsonConstants.WHERE_ENTITY));
                } else {
                    entity = new EntityTable(entityName);
                }//TODO add virtual table

            } else {
                entity = new EntityTable(entityName);
                entityType = EntityType.table;
            }
            // Fields
            JSONArray fieldsJson = entityJson.getJSONArray("fields");
            int len = fieldsJson.length();
            for (int i = 0; i < len; i++) {
                JSONObject fieldJson = fieldsJson.getJSONObject(i);
                if (Config.LOGD) {
                    Log.d(TAG, "fieldJson=" + fieldJson);
                }
                String name = fieldJson.getString(JsonConstants.NAME);
                String type = fieldJson.getString(JsonConstants.TYPE);
                boolean isIndex = fieldJson.optBoolean(JsonConstants.INDEX, false);
                boolean isNullable = fieldJson.optBoolean(JsonConstants.NULLABLE, true);
                String defaultValue = fieldJson.optString(JsonConstants.DEFAULT_VALUE);
                Field field;
                if (entityType == EntityType.view) {
                    final String newName = fieldJson.optString(JsonConstants.NEW_NAME, null);
                    String fromEntity = fieldJson.getString(JsonConstants.ENTITY_TABLE);
                    field = new Field(fromEntity, name, newName, type, isIndex, isNullable,
                            defaultValue);
                } else {
                    field = new Field(entityName, name, type, isIndex, isNullable, defaultValue);
                }
                entity.addField(field);
            }

            // Constraints (optional)
            if (entityType != EntityType.view) {
                JSONArray constraintsJson = entityJson.optJSONArray("constraints");
                if (constraintsJson != null) {
                    len = constraintsJson.length();
                    for (int i = 0; i < len; i++) {
                        JSONObject constraintJson = constraintsJson.getJSONObject(i);
                        if (Config.LOGD) {
                            Log.d(TAG, "constraintJson=" + constraintJson);
                        }
                        String name = constraintJson.getString(Constraint.Json.NAME);
                        String definition = constraintJson.getString(Constraint.Json.DEFINITION);
                        Constraint constraint = new Constraint(name, definition);
                        ((EntityTable) entity).addConstraint(constraint);
                    }
                }
            }

            Model.get().addEntity(entity);
        }
        // Header (optional)
        File headerFile = new File(inputDir, "header.txt");
        if (headerFile.exists()) {
            String header = FileUtils.readFileToString(headerFile).trim();
            Model.get().setHeader(header);
        }

        //set entity for each sql view exist
        for (Entity entity : Model.get().getEntities()) {
            if (entity.getEntityType() == EntityType.view) {
                EntityView entityView = (EntityView) entity;
                for (Field field : entityView.getFields()) {
                    field.setEntityAssociated(Model.get().getEntity(field.getEntityName()));
                }
            }
        }

        if (Config.LOGD) {
            Log.d(TAG, Model.get().toString());
        }
    }


    private JSONObject getConfig(File inputDir) throws IOException, JSONException {
        if (mConfig == null) {
            File configFile = new File(inputDir, FILE_CONFIG);
            String fileContents = FileUtils.readFileToString(configFile);
            mConfig = new JSONObject(fileContents);
        }
        // Ensure the input files are compatible with this version of the tool
        String configVersion;
        try {
            configVersion = mConfig.getString(Json.TOOL_VERSION);
        } catch (JSONException e) {
            throw new IllegalArgumentException(
                    "Could not find 'toolVersion' field in _config.json, which is mandatory and must be equals to '"
                            + Constants.VERSION + "'"
            );
        }
        if (!configVersion.equals(Constants.VERSION)) {
            throw new IllegalArgumentException(
                    "Invalid 'toolVersion' value in _config.json: found '" + configVersion
                            + "' but expected '" + Constants.VERSION
                            + "'"
            );
        }
        return mConfig;
    }

    private void generateColumns(Arguments arguments)
            throws IOException, JSONException, TemplateException {
        Template template = getFreeMarkerConfig().getTemplate("columns.ftl");
        JSONObject config = getConfig(arguments.inputDir);
        String providerPackageName = config.getString(Json.PROVIDER_PACKAGE);

        File providerPackageDir = new File(arguments.outputDir,
                providerPackageName.replace('.', '/').concat("/table"));
        providerPackageDir.mkdirs();
        Map<String, Object> root = new HashMap<String, Object>();
        root.put("config", getConfig(arguments.inputDir));
        root.put("header", Model.get().getHeader());

        // Entities
        for (Entity entity : Model.get().getEntities()) {
            File outputFile = new File(providerPackageDir,
                    entity.getNameCamelCase() + "Columns.java");
            Writer out = new OutputStreamWriter(new FileOutputStream(outputFile));

            root.put("entity", entity);

            template.process(root, out);
            IOUtils.closeQuietly(out);
        }
    }

    private void generateWrappers(Arguments arguments)
            throws IOException, JSONException, TemplateException {
        JSONObject config = getConfig(arguments.inputDir);
        String providerPackageName = config.getString(Json.PROVIDER_PACKAGE);
        File providerPackageDir = new File(arguments.outputDir,
                providerPackageName.replace('.', '/'));
        File baseClassesDir = new File(providerPackageDir, "base");
        baseClassesDir.mkdirs();

        File cursorWrapperPackageDir = new File(arguments.outputDir,
                providerPackageName.replace('.', '/').concat("/wrapper/cursor"));
        File contentValuesPackageDir = new File(arguments.outputDir,
                providerPackageName.replace('.', '/').concat("/wrapper/contentvalues"));
        File selectionPackageDir = new File(arguments.outputDir,
                providerPackageName.replace('.', '/').concat("/wrapper/select"));
        cursorWrapperPackageDir.mkdirs();
        contentValuesPackageDir.mkdirs();
        selectionPackageDir.mkdirs();

        Map<String, Object> root = new HashMap<String, Object>();
        root.put("config", getConfig(arguments.inputDir));
        root.put("header", Model.get().getHeader());

        // AbstractCursorWrapper
        Template template = getFreeMarkerConfig().getTemplate("abstractcursorwrapper.ftl");
        File outputFile = new File(baseClassesDir, "AbstractCursorWrapper.java");
        Writer out = new OutputStreamWriter(new FileOutputStream(outputFile));
        template.process(root, out);
        IOUtils.closeQuietly(out);

        // AbstractContentValuesWrapper
        template = getFreeMarkerConfig().getTemplate("abstractcontentvalueswrapper.ftl");
        outputFile = new File(baseClassesDir, "AbstractContentValuesWrapper.java");
        out = new OutputStreamWriter(new FileOutputStream(outputFile));
        template.process(root, out);
        IOUtils.closeQuietly(out);

        // AbstractSelection
        template = getFreeMarkerConfig().getTemplate("abstractselection.ftl");
        outputFile = new File(baseClassesDir, "AbstractSelection.java");
        out = new OutputStreamWriter(new FileOutputStream(outputFile));
        template.process(root, out);
        IOUtils.closeQuietly(out);

        // Entities
        for (Entity entity : Model.get().getEntities()) {
            // Cursor wrapper
            outputFile = new File(cursorWrapperPackageDir,
                    entity.getNameCamelCase() + "CursorWrapper.java");
            out = new OutputStreamWriter(new FileOutputStream(outputFile));
            root.put("entity", entity);
            template = getFreeMarkerConfig().getTemplate("cursorwrapper.ftl");
            template.process(root, out);
            IOUtils.closeQuietly(out);

            // ContentValues wrapper
            if (entity.getEntityType() == EntityType.table) {
                outputFile = new File(contentValuesPackageDir,
                        entity.getNameCamelCase() + "ContentValues.java");
                out = new OutputStreamWriter(new FileOutputStream(outputFile));
                root.put("entity", entity);
                template = getFreeMarkerConfig().getTemplate("contentvalueswrapper.ftl");
                template.process(root, out);
                IOUtils.closeQuietly(out);
            }
            // Selection builder
            outputFile = new File(selectionPackageDir,
                    entity.getNameCamelCase() + "Selection.java");
            out = new OutputStreamWriter(new FileOutputStream(outputFile));
            root.put("entity", entity);
            template = getFreeMarkerConfig().getTemplate("selection.ftl");
            template.process(root, out);
            IOUtils.closeQuietly(out);
        }
    }

    private void generateContentProvider(Arguments arguments)
            throws IOException, JSONException, TemplateException {
        Template template = getFreeMarkerConfig().getTemplate("contentprovider.ftl");
        JSONObject config = getConfig(arguments.inputDir);
        String providerPackageName = config.getString(Json.PROVIDER_PACKAGE);
        File providerPackageDir = new File(arguments.outputDir,
                providerPackageName.replace('.', '/'));
        providerPackageDir.mkdirs();
        File outputFile = new File(providerPackageDir,
                config.getString(Json.PROVIDER_CLASS_NAME) + ".java");
        Writer out = new OutputStreamWriter(new FileOutputStream(outputFile));

        Map<String, Object> root = new HashMap<String, Object>();
        root.put("config", config);
        root.put("model", Model.get());
        root.put("header", Model.get().getHeader());

        template.process(root, out);
    }

    private void generateSqliteHelper(Arguments arguments)
            throws IOException, JSONException, TemplateException {
        Template template = getFreeMarkerConfig().getTemplate("sqlitehelper.ftl");
        JSONObject config = getConfig(arguments.inputDir);
        String providerPackageName = config.getString(Json.PROVIDER_PACKAGE);
        File providerPackageDir = new File(arguments.outputDir,
                providerPackageName.replace('.', '/'));
        providerPackageDir.mkdirs();
        File outputFile = new File(providerPackageDir,
                config.getString(Json.SQLITE_HELPER_CLASS_NAME) + ".java");
        Writer out = new OutputStreamWriter(new FileOutputStream(outputFile));

        Map<String, Object> root = new HashMap<String, Object>();
        root.put("config", config);
        root.put("model", Model.get());
        root.put("header", Model.get().getHeader());

        template.process(root, out);
    }

    private void go(String[] args) throws IOException, JSONException, TemplateException {
        Arguments arguments = new Arguments();
        JCommander jCommander = new JCommander(arguments, args);
        jCommander.setProgramName("GenerateAndroidProvider");

        if (arguments.help) {
            jCommander.usage();
            return;
        }

        getConfig(arguments.inputDir);

        loadModel(arguments.inputDir);
        generateColumns(arguments);
        generateWrappers(arguments);
        generateContentProvider(arguments);
        generateSqliteHelper(arguments);
    }

    public static void main(String[] args) throws Exception {
        new Main().go(args);
    }
}
