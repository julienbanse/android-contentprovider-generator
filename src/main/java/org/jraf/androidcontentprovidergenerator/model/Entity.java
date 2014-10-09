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

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Entity {

    protected final String mName;

    protected EntityType mEntityType = EntityType.table;

    protected final List<Field> mFields = new ArrayList<Field>();

    protected final List<Constraint> mConstraints = new ArrayList<Constraint>();

    protected String mViewWhereSelect;

    public Entity(String name, EntityType type) {
        mName = name.toLowerCase();
        mEntityType = type;
    }

    public void addField(Field field) {
        mFields.add(field);
    }

    public List<Field> getFields() {
        return Collections.unmodifiableList(mFields);
    }

    public String getNameCamelCase() {
        return WordUtils.capitalizeFully(mName, new char[]{'_'}).replaceAll("_", "");
    }

    public String getNameLowerCase() {
        return mName;
    }

    public String getNameUpperCase() {
        return mName.toUpperCase();
    }

    @Override
    public String toString() {
        return "Entity [mName=" + mName + ", mFields=" + mFields + ", mConstraints="
                + mConstraints
                + "]";
    }

    public EntityType getEntityType() {
        return mEntityType;
    }

    public void setEntityType(EntityType entityType) {
        mEntityType = entityType;
    }
}
