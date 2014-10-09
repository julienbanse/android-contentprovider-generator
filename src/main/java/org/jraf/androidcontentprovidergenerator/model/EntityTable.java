package org.jraf.androidcontentprovidergenerator.model;

import java.util.Collections;
import java.util.List;

/**
 * Created by jbanse on 26/02/2014.
 */
public class EntityTable extends Entity {

    public EntityTable(String name) {
        super(name, EntityType.table);
    }


    public void addConstraint(Constraint constraint) {
        mConstraints.add(constraint);
    }

    public List<Constraint> getConstraints() {
        return Collections.unmodifiableList(mConstraints);
    }
}
