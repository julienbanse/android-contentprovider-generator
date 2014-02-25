<#if header??>
${header}
</#if>
package ${config.providerPackage}.wrapper.cursor;

import java.util.Date;

import android.database.Cursor;
import ${config.providerPackage}.table.${entity.nameCamelCase}Columns;
import ${config.projectPackage}.BuildConfig;

import ${config.providerPackage}.base.AbstractCursorWrapper;

/**
 * Cursor wrapper for the {@code ${entity.nameLowerCase}} table.
 */
public class ${entity.nameCamelCase}CursorWrapper extends AbstractCursorWrapper {
    public ${entity.nameCamelCase}CursorWrapper(Cursor cursor) {
        super(cursor);
    }
    <#list entity.fields as field>

    /**
     * Get the {@code ${field.nameLowerCase}} value.
     *
     */
    public ${field.type.javaType.simpleName} get${field.nameCamelCase}() {
        <#switch field.type.name()>
        <#case "STRING">
        Integer index = getCachedColumnIndexOrThrow(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        return getString(index);
        <#break>
        <#case "INTEGER">
        return getIntegerOrNull(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        <#break>
        <#case "INT">
        return getInt(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        <#break>
        <#case "LONG">
        return getLongOrNull(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        <#break>
        <#case "LONG_PRIMITIVE">
        return getLong(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        <#break>
        <#case "FLOAT">
        return getFloatOrNull(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        <#break>
        <#case "FLOAT_PRIMITIVE">
        return getFloat(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        <#break>
        <#case "DOUBLE">
        return getDoubleOrNull(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        <#break>
        <#case "DOUBLE_PRIMITIVE">
        return getDouble(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        <#break>
        <#case "BOOLEAN">
        <#case "BOOLEAN_PRIMITIVE">
        return getBoolean(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        <#break>
        <#case "DATE">
        return getDate(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        <#break>
        <#case "BLOB">
        Integer index = getCachedColumnIndexOrThrow(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        return getBlob(index);
        <#break>
        </#switch>
    }
    </#list>
}
