package org.jraf.androidcontentprovidergenerator.tools;

import org.jraf.androidcontentprovidergenerator.model.Entity;
import org.jraf.androidcontentprovidergenerator.model.EntityType;

import java.util.Comparator;

/**
 * Created by jbanse on 07/04/2014.
 */
public class EntityComparator implements Comparator<Entity> {

    @Override
    public int compare(Entity entity, Entity entity2) {
        if (entity.getEntityType() == EntityType.table
                && entity2.getEntityType() == EntityType.view) {
            return -1;
        } else if (entity2.getEntityType() == EntityType.table
                && entity.getEntityType() == EntityType.view) {
            return 1;
        }
        return 0;
    }

}
