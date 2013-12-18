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

    public Long getId() {
        return getLongOrNull(BaseColumns._ID);
    }

    protected int getCachedColumnIndexOrThrow(String colName) {
      	Integer index = mColumnIndexes.get(colName);
          if (index == null) {
          	index = getColumnIndexOrThrow(colName);
          	mColumnIndexes.put(colName, index);
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

    public Boolean getBoolean(String colName) {
        final int index = getCachedColumnIndexOrThrow(colName);
        if (isNull(index)) return null;
        return Boolean.valueOf(getInt(index) != 0);
    }

    public Date getDate(String colName) {
        final int index = getCachedColumnIndexOrThrow(colName);
        if (isNull(index)) return null;
        return new Date(getLong(index));
    }
}