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
package org.jraf.androidcontentprovidergenerator.model;

import org.apache.commons.lang.WordUtils;

import java.util.Date;
import java.util.HashMap;

public class Field {

    public static class Json {

        public static final String NAME = "name";

        public static final String TYPE = "type";

        public static final String INDEX = "index";

        public static final String NULLABLE = "nullable";

        public static final String DEFAULT_VALUE = "default_value";

        private static final String TYPE_STRING = "String";

        private static final String TYPE_INTEGER = "Integer";

        private static final String TYPE_INT = "int";

        private static final String TYPE_LONG = "Long";

        private static final String TYPE_LONG_PRIMITIVE = "long";

        private static final String TYPE_FLOAT = "Float";

        private static final String TYPE_FLOAT_PRIMITIVE = "float";

        private static final String TYPE_DOUBLE = "Double";

        private static final String TYPE_DOUBLE_PRIMITIVE = "double";

        private static final String TYPE_BOOLEAN = "Boolean";

        private static final String TYPE_BOOLEAN_PRIMITIVE = "boolean";

        private static final String TYPE_DATE = "Date";

        private static final String TYPE_BYTE_ARRAY = "byte[]";


    }

    public static enum Type {
        // @formatter:off
        STRING(Json.TYPE_STRING, "TEXT", String.class),
        INTEGER(Json.TYPE_INTEGER, "INTEGER", Integer.class),
        INT(Json.TYPE_INT, "INTEGER", int.class),
        LONG(Json.TYPE_LONG, "INTEGER", Long.class),
        LONG_PRIMITIVE(Json.TYPE_LONG_PRIMITIVE, "INTEGER", long.class),
        FLOAT(Json.TYPE_FLOAT, "REAL", Float.class),
        FLOAT_PRIMITIVE(Json.TYPE_FLOAT_PRIMITIVE, "REAL", float.class),
        DOUBLE(Json.TYPE_DOUBLE, "REAL", Double.class),
        DOUBLE_PRIMITIVE(Json.TYPE_DOUBLE_PRIMITIVE, "REAL", double.class),
        BOOLEAN(Json.TYPE_BOOLEAN, "INTEGER", Boolean.class),
        BOOLEAN_PRIMITIVE(Json.TYPE_BOOLEAN_PRIMITIVE, "INTEGER", boolean.class),
        DATE(Json.TYPE_DATE, "INTEGER", Date.class),
        BYTE_ARRAY(Json.TYPE_BYTE_ARRAY, "BLOB", byte[].class),
        // @formatter:on
        ;

        private String mSqlType;

        private Class<?> mJavaType;

        private boolean mIsPrimitiveJavaType;

        private Type(String jsonName, String sqlType, Class<?> javaType) {
            mSqlType = sqlType;
            mJavaType = javaType;
            mIsPrimitiveJavaType = (javaType == int.class || javaType == long.class
                    || javaType == float.class || javaType == boolean.class
                    || javaType == boolean.class);
            sJsonNames.put(jsonName, this);
        }

        public static Type fromJsonName(String jsonName) {
            Type res = sJsonNames.get(jsonName);
            if (res == null) {
                throw new IllegalArgumentException("The type '" + jsonName + "' is unknown");
            }
            return res;
        }

        public String getSqlType() {
            return mSqlType;
        }

        public Class<?> getJavaType() {
            return mJavaType;
        }

        public boolean getIsPrimitiveJavaType() {
            return mIsPrimitiveJavaType;
        }
    }

    private static HashMap<String, Type> sJsonNames = new HashMap<String, Type>();

    private final String mName;

    private final Type mType;

    private boolean mIsIndex = false;

    private boolean mIsNullable = true;

    private String mDefaultValue;

    public Field(String name, String type, boolean isIndex, boolean isNullable,
            String defaultValue) {
        mName = name.toLowerCase();
        mType = Type.fromJsonName(type);
        mIsIndex = isIndex;
        if (mType.mIsPrimitiveJavaType) {
            mIsNullable = false;
            if (defaultValue == null || defaultValue.isEmpty()) {
                mDefaultValue = "0";
            } else {
                mDefaultValue = defaultValue;
            }
        } else {
            mIsNullable = isNullable;
            mDefaultValue = defaultValue;
        }
    }

    public String getNameUpperCase() {
        return mName.toUpperCase();
    }

    public String getNameLowerCase() {
        return mName;
    }

    public String getNameCamelCase() {
        return WordUtils.capitalizeFully(mName, new char[]{'_'}).replaceAll("_", "");
    }

    public String getNameCamelCaseLowerCase() {
        return WordUtils.uncapitalize(getNameCamelCase());
    }

    public Type getType() {
        return mType;
    }

    public boolean getIsIndex() {
        return mIsIndex;
    }

    public boolean getIsNullable() {
        return mIsNullable;
    }

    public String getDefaultValue() {
        return mDefaultValue;
    }

    public boolean getHasDefaultValue() {
        return mDefaultValue != null && mDefaultValue.length() > 0;
    }

    @Override
    public String toString() {
        return "Field [mName=" + mName + ", mType=" + mType + ", mIsIndex=" + mIsIndex
                + ", mIsNullable=" + mIsNullable + ", mDefaultValue=" + mDefaultValue
                + "]";
    }
}
