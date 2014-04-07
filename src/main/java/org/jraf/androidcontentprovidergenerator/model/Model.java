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

import org.jraf.androidcontentprovidergenerator.tools.EntityComparator;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

public class Model {

    private static final Model INSTANCE = new Model();

    public static Model get() {
        return INSTANCE;
    }

    private Model() {
    }

    private final HashMap<String, Entity> mEntities = new HashMap<String, Entity>();

    private String mHeader;

    public void addEntity(Entity entity) {
        mEntities.put(entity.getNameLowerCase(), entity);
    }

    public List<Entity> getEntities() {
        ArrayList<Entity> entities = new ArrayList<Entity>();
        entities.addAll(mEntities.values());
        Collections.sort(entities, new EntityComparator());
        return Collections.unmodifiableList(entities);
    }

    public Entity getEntity(String tableName) {
        return mEntities.get(tableName);
    }

    public void setHeader(String header) {
        mHeader = header;
    }

    public String getHeader() {
        return mHeader;
    }

    @Override
    public String toString() {
        return mEntities.toString();
    }
}
