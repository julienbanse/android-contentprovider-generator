<#if header??>
${header}
</#if>
package ${config.providerPackage}.table;

import android.net.Uri;
import android.provider.BaseColumns;

import ${config.providerPackage}.${config.providerClassName};

/**
 * Columns for the {@code ${entity.nameLowerCase}} table.
 */
public interface ${entity.nameCamelCase}Columns extends BaseColumns {
    <#if entity.entityType == "view">
    String VIEW_NAME = "${entity.nameLowerCase}";
    Uri CONTENT_URI = Uri.parse(${config.providerClassName}.CONTENT_URI_BASE + "/" + VIEW_NAME);
    <#else>
    String TABLE_NAME = "${entity.nameLowerCase}";
    Uri CONTENT_URI = Uri.parse(${config.providerClassName}.CONTENT_URI_BASE + "/" + TABLE_NAME);
    </#if>

    <#list entity.fields as field>
    String ${field.newNameUpperCase} = "${field.newNameLowerCase}";
    </#list>

    String DEFAULT_ORDER = _ID;

    String[] FULL_PROJECTION = new String[] {
            <#if entity.entityType != "view">
            _ID,
            </#if>
            <#list entity.fields as field>
            ${field.newNameUpperCase}<#if field_has_next>,</#if>
            </#list>
    };

}