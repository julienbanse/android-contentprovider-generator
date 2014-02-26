package org.jraf.androidcontentprovidergenerator.model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Created by jbanse on 26/02/2014.
 */
public class EntityView extends Entity {

    public EntityView(String name) {
        super(name, EntityType.view);
    }

    public String getViewWhereSelect() {
        return mViewWhereSelect;
    }

    public void setViewWhereSelect(String viewWhereSelect) {
        mViewWhereSelect = viewWhereSelect;
    }

    public void addEntity(Entity entity) {
        mLinkedEntity.put(entity.getNameLowerCase(), entity);
    }

    public List<Entity> getEntities() {
        ArrayList<Entity> entities = new ArrayList<Entity>();
        entities.addAll(mLinkedEntity.values());
        return Collections.unmodifiableList(entities);
    }

    public Entity getEntity(String tableName) {
        return mLinkedEntity.get(tableName);
    }
}
