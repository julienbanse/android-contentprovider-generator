package org.jraf.androidcontentprovidergenerator.model;

import java.util.Date;
import java.util.HashMap;

/**
 * Created by jbanse on 25/02/2014.
 */
public enum Type {
    STRING(JsonConstants.TYPE_STRING, "TEXT", String.class),
    INTEGER(JsonConstants.TYPE_INTEGER, "INTEGER", Integer.class),
    INT(JsonConstants.TYPE_INT, "INTEGER", int.class),
    LONG(JsonConstants.TYPE_LONG, "INTEGER", Long.class),
    LONG_PRIMITIVE(JsonConstants.TYPE_LONG_PRIMITIVE, "INTEGER", long.class),
    FLOAT(JsonConstants.TYPE_FLOAT, "REAL", Float.class),
    FLOAT_PRIMITIVE(JsonConstants.TYPE_FLOAT_PRIMITIVE, "REAL", float.class),
    DOUBLE(JsonConstants.TYPE_DOUBLE, "REAL", Double.class),
    DOUBLE_PRIMITIVE(JsonConstants.TYPE_DOUBLE_PRIMITIVE, "REAL", double.class),
    BOOLEAN(JsonConstants.TYPE_BOOLEAN, "INTEGER", Boolean.class),
    BOOLEAN_PRIMITIVE(JsonConstants.TYPE_BOOLEAN_PRIMITIVE, "INTEGER", boolean.class),
    DATE(JsonConstants.TYPE_DATE, "INTEGER", Date.class),
    BYTE_ARRAY(JsonConstants.TYPE_BYTE_ARRAY, "BLOB", byte[].class);

    private static HashMap<String, Type> sJsonNames = new HashMap<String, Type>();

    private String mSqlType;

    private Class<?> mJavaType;

    private boolean mIsPrimitiveJavaType;

    private Type(String jsonName, String sqlType, Class<?> javaType) {
        mSqlType = sqlType;
        mJavaType = javaType;
        mIsPrimitiveJavaType = (javaType == int.class || javaType == long.class
                || javaType == float.class || javaType == boolean.class
                || javaType == boolean.class);
        putJsonTypeInCache(jsonName, this);
    }

    private static void putJsonTypeInCache(String jsonName, Type enumInstance) {
        sJsonNames.put(jsonName, enumInstance);
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
