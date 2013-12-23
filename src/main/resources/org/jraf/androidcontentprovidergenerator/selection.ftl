<#if header??>
${header}
</#if>
package ${config.providerPackage}.wrapper.select;

import ${config.providerPackage}.table.${entity.nameCamelCase}Columns;
import java.util.Date;

import ${config.providerPackage}.base.AbstractSelection;

/**
 * Selection for the {@code ${entity.nameLowerCase}} table.
 */
public class ${entity.nameCamelCase}Selection extends AbstractSelection<${entity.nameCamelCase}Selection> {
    public ${entity.nameCamelCase}Selection id(Long... value) {
        addEquals(${entity.nameCamelCase}Columns._ID, (Object[]) value);
        return this;
    }
    <#list entity.fields as field>

<#switch field.type.name()>
    <#case "INT">
    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}(int[] value) {
        addEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Not(int[] value) {
        addNotEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }
     <#break>
     <#case "DOUBLE_PRIMITIVE">
     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}(double[] value) {
         addEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Not(double[] value) {
         addNotEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
         return this;
     }
     <#break>
     <#case "FLOAT_PRIMITIVE">
     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}(float[] value) {
         addEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Not(float[] value) {
         addNotEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
         return this;
     }
     <#break>
     <#case "LONG_PRIMITIVE">
     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}(long[] value) {
         addEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Not(long[] value) {
         addNotEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
         return this;
     }
     <#break>
     <#case "BOOLEAN_PRIMITIVE">
     <#case "BOOLEAN">
     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}(boolean value) {
         addEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, Integer.valueOf(value ? 1 : 0));
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Not(boolean value) {
         addNotEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, Integer.valueOf(value ? 1 : 0));
         return this;
     }
      <#break>
     <#default>
    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}(${field.type.javaType.simpleName}... value) {
        addEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, (Object[]) value);
        return this;
    }
    
    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Not(${field.type.javaType.simpleName}... value) {
        addNotEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, (Object[]) value);
        return this;
    }
    </#switch>


    <#switch field.type.name()>
    <#case "DATE">
    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}(Long... value) {
        addEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, (Object[]) value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}After(Date value) {
        addGreaterThan(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}AfterEq(Date value) {
        addGreaterThanOrEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Before(Date value) {
        addLessThan(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}BeforeEq(Date value) {
        addLessThanOrEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }
    <#break>
    <#case "INTEGER">
    <#case "INT">
    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Gt(Integer value) {
        addGreaterThan(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}GtEq(Integer value) {
        addGreaterThanOrEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Lt(Integer value) {
        addLessThan(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}LtEq(Integer value) {
        addLessThanOrEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }
    <#break>
    <#case "LONG">
    <#case "LONG_PRIMITIVE">
    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Gt(Long value) {
        addGreaterThan(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}GtEq(Long value) {
        addGreaterThanOrEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Lt(Long value) {
        addLessThan(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}LtEq(Long value) {
        addLessThanOrEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }
    <#break>
    <#case "FLOAT">
    <#case "FLOAT_PRIMITIVE">
    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Gt(Float value) {
        addGreaterThan(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}GtEq(Float value) {
        addGreaterThanOrEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Lt(Float value) {
        addLessThan(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}LtEq(Float value) {
        addLessThanOrEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }
    <#break>
    <#case "DOUBLE">
    <#case "DOUBLE_PRIMITIVE">
    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Gt(Double value) {
        addGreaterThan(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}GtEq(Double value) {
        addGreaterThanOrEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Lt(Double value) {
        addLessThan(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}LtEq(Double value) {
        addLessThanOrEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }
    <#break>
    </#switch>
    </#list>
}
