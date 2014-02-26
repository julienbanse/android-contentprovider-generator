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

public class Field {

    private final String mNewName;

    private String mEntityName;

    private final String mName;

    private final Type mType;

    private boolean mIsIndex = false;

    private boolean mIsNullable = true;

    private String mDefaultValue;

    /**
     * @param entityName field entity name
     * @param name       field name
     * @param newName    new field name (use in view)
     */
    public Field(String entityName, String name, String newName, String type, boolean isIndex,
            boolean isNullable,
            String defaultValue) {
        mEntityName = entityName;
        mName = name.toLowerCase();
        if (newName != null) {
            mNewName = newName.toLowerCase();
        } else {
            mNewName = mName;
        }
        mType = Type.fromJsonName(type);
        mIsIndex = isIndex;
        if (mType.getIsPrimitiveJavaType()) {
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

    /**
     * Default constructor : no new name and no associated entity.
     *
     * @param name field name
     */
    public Field(String name, String type, boolean isIndex, boolean isNullable,
            String defaultValue) {
        this(null, name, null, type, isIndex, isNullable, defaultValue);
    }

    /**
     * Constructor for field with no new name.
     *
     * @param entityName entity name
     * @param name       field name
     */
    public Field(String entityName, String name, String type, boolean isIndex, boolean isNullable,
            String defaultValue) {
        this(entityName, name, null, type, isIndex, isNullable, defaultValue);
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

    public String getFullName() {
        if (mEntityName != null) {
            return mEntityName.concat(".").concat(getNameLowerCase());
        }
        return getNameLowerCase();
    }

    @Override
    public String toString() {
        return "Field [mName=" + mName + ", mType=" + mType + ", mIsIndex=" + mIsIndex
                + ", mIsNullable=" + mIsNullable + ", mDefaultValue=" + mDefaultValue
                + "]";
    }

    public String getEntityName() {
        return mEntityName;
    }

    public void setEntityName(String table) {
        mEntityName = table;
    }

    public String getNewNameLowerCase() {
        return mNewName;
    }

    public String getNewNameCamelCase() {
        return WordUtils.capitalizeFully(mNewName, new char[]{'_'}).replaceAll("_", "");
    }

    public String getNewsNameCamelCaseLowerCase() {
        return WordUtils.uncapitalize(getNewNameCamelCase());
    }
}
