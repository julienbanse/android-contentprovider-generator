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
