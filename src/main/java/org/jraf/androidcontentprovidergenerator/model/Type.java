package org.jraf.androidcontentprovidergenerator.model;

import java.util.Date;
import java.util.HashMap;

/**
 * Created by jbanse on 25/02/2014.
 */
public enum Type {
    STRING(ColumnDataType.TYPE_STRING, "TEXT", String.class),
    INTEGER(ColumnDataType.TYPE_INTEGER, "INTEGER", Integer.class),
    INT(ColumnDataType.TYPE_INT, "INTEGER", int.class),
    LONG(ColumnDataType.TYPE_LONG, "INTEGER", Long.class),
    LONG_PRIMITIVE(ColumnDataType.TYPE_LONG_PRIMITIVE, "INTEGER", long.class),
    FLOAT(ColumnDataType.TYPE_FLOAT, "REAL", Float.class),
    FLOAT_PRIMITIVE(ColumnDataType.TYPE_FLOAT_PRIMITIVE, "REAL", float.class),
    DOUBLE(ColumnDataType.TYPE_DOUBLE, "REAL", Double.class),
    DOUBLE_PRIMITIVE(ColumnDataType.TYPE_DOUBLE_PRIMITIVE, "REAL", double.class),
    BOOLEAN(ColumnDataType.TYPE_BOOLEAN, "INTEGER", Boolean.class),
    BOOLEAN_PRIMITIVE(ColumnDataType.TYPE_BOOLEAN_PRIMITIVE, "INTEGER", boolean.class),
    DATE(ColumnDataType.TYPE_DATE, "INTEGER", Date.class),
    BYTE_ARRAY(ColumnDataType.TYPE_BYTE_ARRAY, "BLOB", byte[].class);

    private static HashMap<String, Type> sJsonNames = new HashMap<String, Type>();

    private String mSqlType;

    private Class<?> mJavaType;

    private boolean mIsPrimitiveJavaType;

    static {
        sJsonNames.put(ColumnDataType.TYPE_STRING, STRING);
        sJsonNames.put(ColumnDataType.TYPE_INTEGER, INTEGER);
        sJsonNames.put(ColumnDataType.TYPE_INT, INT);
        sJsonNames.put(ColumnDataType.TYPE_LONG, LONG);
        sJsonNames.put(ColumnDataType.TYPE_LONG_PRIMITIVE, LONG_PRIMITIVE);
        sJsonNames.put(ColumnDataType.TYPE_FLOAT, FLOAT);
        sJsonNames.put(ColumnDataType.TYPE_FLOAT_PRIMITIVE, FLOAT_PRIMITIVE);
        sJsonNames.put(ColumnDataType.TYPE_DOUBLE, DOUBLE);
        sJsonNames.put(ColumnDataType.TYPE_DOUBLE_PRIMITIVE, DOUBLE_PRIMITIVE);
        sJsonNames.put(ColumnDataType.TYPE_BOOLEAN, BOOLEAN);
        sJsonNames.put(ColumnDataType.TYPE_BOOLEAN_PRIMITIVE, BOOLEAN_PRIMITIVE);
        sJsonNames.put(ColumnDataType.TYPE_DATE, DATE);
        sJsonNames.put(ColumnDataType.TYPE_BYTE_ARRAY, BYTE_ARRAY);
    }

    private Type(String jsonName, String sqlType, Class<?> javaType) {
        mSqlType = sqlType;
        mJavaType = javaType;
        mIsPrimitiveJavaType = (javaType == int.class || javaType == long.class
                || javaType == float.class || javaType == boolean.class
                || javaType == boolean.class);
    }

//    private static void putJsonTypeInCache(String jsonName, Type enumInstance) {
//        sJsonNames.put(jsonName, enumInstance);
//    }

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
