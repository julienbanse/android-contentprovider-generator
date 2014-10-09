package org.jraf.androidcontentprovidergenerator.model;

/**
 * Created by jbanse on 26/02/2014.
 */
public class EntityView extends Entity {

    protected String mEntities;


    public EntityView(String name) {
        super(name, EntityType.view);
    }

    public boolean getHasSelect(){
        return mViewWhereSelect !=null && mViewWhereSelect.length()>0;
    }
    public String getViewWhereSelect() {
        return mViewWhereSelect;
    }

    public void setViewWhereSelect(String viewWhereSelect) {
        mViewWhereSelect = viewWhereSelect;
    }

    public void setFromEntity(String entity) {
        mEntities = entity;
    }

    public String getEntities() {
        return mEntities;
    }

}
