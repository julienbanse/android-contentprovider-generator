<#if header??>
${header}
</#if>
package ${config.providerPackage}.base;

import java.util.Date;
import java.util.HashMap;

import android.database.Cursor;
import android.database.CursorWrapper;
import android.provider.BaseColumns;

public abstract class AbstractCursorWrapper extends CursorWrapper {
	private HashMap<String, Integer> mColumnIndexes = new HashMap<String, Integer>();
	
    public AbstractCursorWrapper(Cursor cursor) {
        super(cursor);
    }

    public long getId() {
        return getLong(BaseColumns._ID);
    }

    public long getLong(String colName) {
        final int index = getCachedColumnIndexOrThrow(colName);
        return getLong(index);
    }

    public int getInt(String colName) {
        final int index = getCachedColumnIndexOrThrow(colName);
        return getInt(index);
    }

    public boolean getBoolean(String colName) {
        return (getInt(colName) == 1);
    }

    public double getDouble(String colName) {
        final int index = getCachedColumnIndexOrThrow(colName);
        return getDouble(index);
    }

    public float getFloat(String colName) {
        final int index = getCachedColumnIndexOrThrow(colName);
        return getFloat(index);
    }

    protected int getCachedColumnIndexOrThrow(String colName) {
      	Integer index = mColumnIndexes.get(colName);
          if (index == null) {
          	index = getColumnIndexOrThrow(colName);
        	mColumnIndexes.put(colName, Integer.valueOf(index));
          }
          return index.intValue();
    }

    public Integer getIntegerOrNull(String colName) {
       final int index = getCachedColumnIndexOrThrow(colName);
        if (isNull(index)) return null;
        return Integer.valueOf(getInt(index));
    }
    
    public Long getLongOrNull(String colName) {
        final int index = getCachedColumnIndexOrThrow(colName);
        if (isNull(index)) return null;
        return Long.valueOf(getLong(index));
    }
    
    public Float getFloatOrNull(String colName) {
        final int index = getCachedColumnIndexOrThrow(colName);
        if (isNull(index)) return null;
        return Float.valueOf(getFloat(index));
    }
    
    public Double getDoubleOrNull(String colName) {
        final int index = getCachedColumnIndexOrThrow(colName);
        if (isNull(index)) return null;
        return Double.valueOf(getDouble(index));
    }

    public Date getDate(String colName) {
        final int index = getCachedColumnIndexOrThrow(colName);
        if (isNull(index)) return null;
        return new Date(getLong(index));
    }
}