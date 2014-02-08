<#if header??>
${header}
</#if>
package ${config.providerPackage}.wrapper.contentvalues;

import java.util.Date;
import ${config.providerPackage}.table.${entity.nameCamelCase}Columns;

import ${config.providerPackage}.base.AbstractContentValuesWrapper;

/**
 * Content values wrapper for the {@code ${entity.nameLowerCase}} table.
 */
public class ${entity.nameCamelCase}ContentValues extends AbstractContentValuesWrapper {
    <#list entity.fields as field>

    public ${entity.nameCamelCase}ContentValues put${field.nameCamelCase}(${field.javaType.simpleName} value) {
        <#if !field.isNullable && !field.type.hasNotNullableJavaType()>
        if (value == null) throw new IllegalArgumentException("value for ${field.nameCamelCaseLowerCase} must not be null");
        </#if>        
        <#switch field.type.name()>
        <#case "DATE">
        mContentValues.put(${entity.nameCamelCase}Columns.${field.nameUpperCase}, <#if field.isNullable>value == null ? null : </#if>value.getTime());
        <#break>
        <#case "BOOLEAN">
        <#case "BOOLEAN_PRIMITIVE">
        mContentValues.put(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value ? 1 : 0);
        <#break>
        <#default>
        mContentValues.put(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        </#switch>
        return this;
    }

    <#if field.isNullable>
    public ${entity.nameCamelCase}ContentValues put${field.nameCamelCase}Null() {
        mContentValues.putNull(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        return this;
    }
    </#if>

    <#switch field.type.name()>
    <#case "DATE">
    public ${entity.nameCamelCase}ContentValues put${field.nameCamelCase}(<#if field.isNullable>Long<#else>long</#if> value) {
        mContentValues.put(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    <#break>
    </#switch>
    </#list>
}
