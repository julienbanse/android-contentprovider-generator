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
    public ${entity.nameCamelCase}Selection id(long... value) {
        addEquals(${entity.nameCamelCase}Columns._ID, toObjectArray(value));
        return this;
    }

<#list entity.fields as field>
<#switch field.type.name()>
    <#case "INT">
    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}(int value) {
        addEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, Integer.valueOf(value));
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Not(int value) {
        addNotEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, Integer.valueOf(value));
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}In(int[] value) {
        addEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, toObjectArray(value));
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}NotIn(int[] value) {
        addNotEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, toObjectArray(value));
        return this;
    }
     <#break>
     <#case "DOUBLE_PRIMITIVE">
     public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}(double value) {
         addEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, Double.valueOf(value));
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Not(double value) {
         addNotEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, Double.valueOf(value));
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}In(double[] value) {
         addEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, toObjectArray(value));
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}NotIn(double[] value) {
         addNotEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, toObjectArray(value));
         return this;
     }
     <#break>
     <#case "FLOAT_PRIMITIVE">
     public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}(float value) {
         addEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, Float.valueOf(value));
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Not(float value) {
         addNotEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, Float.valueOf(value));
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}In(float[] value) {
         addEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, toObjectArray(value));
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}NotIn(float[] value) {
         addNotEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, toObjectArray(value));
         return this;
     }
     <#break>
     <#case "LONG_PRIMITIVE">
     public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}(long value) {
         addEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, Long.valueOf(value));
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Not(long value) {
         addNotEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, Long.valueOf(value));
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}In(long[] value) {
         addEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, toObjectArray(value));
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}NotIn(long[] value) {
         addNotEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, toObjectArray(value));
         return this;
     }
     <#break>
     <#case "BOOLEAN_PRIMITIVE">
     <#case "BOOLEAN">
     public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}(boolean value) {
         addEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, Integer.valueOf(value ? 1 : 0));
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Not(boolean value) {
         addNotEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, Integer.valueOf(value ? 1 : 0));
         return this;
     }
      <#break>
     <#default>
     public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}(${field.type.javaType.simpleName} value) {
         addEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Not(${field.type.javaType.simpleName} value) {
         addNotEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
         return this;
     }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}In(${field.type.javaType.simpleName}... value) {
        addEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }
    
    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}NotIn(${field.type.javaType.simpleName}... value) {
        addNotEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }
    </#switch>

    <#switch field.type.name()>
    <#case "DATE">
    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}(<#if field.isNullable>Long<#else>long</#if>... value) {
        addEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, <#if field.isNullable>value<#else>toObjectArray(value)</#if>);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}After(Date value) {
        addGreaterThan(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}AfterEq(Date value) {
        addGreaterThanOrEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Before(Date value) {
        addLessThan(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}BeforeEq(Date value) {
        addLessThanOrEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }
    <#break>

    <#case "INT">
    <#case "INTEGER">
    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Gt(int value) {
        return ${field.newNameCamelCaseLowerCase}Gt(Integer.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}GtEq(int value) {
        return ${field.newNameCamelCaseLowerCase}GtEq(Integer.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Lt(int value) {
        return ${field.newNameCamelCaseLowerCase}Lt(Integer.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}LtEq(int value) {
        return ${field.newNameCamelCaseLowerCase}LtEq(Integer.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Gt(Integer value) {
        addGreaterThan(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}GtEq(Integer value) {
        addGreaterThanOrEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Lt(Integer value) {
        addLessThan(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}LtEq(Integer value) {
        addLessThanOrEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }
    <#break>
    <#case "LONG_PRIMITIVE">
    <#case "LONG">
    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Gt(long value) {
        return ${field.newNameCamelCaseLowerCase}Gt(Long.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}GtEq(long value) {
        return ${field.newNameCamelCaseLowerCase}GtEq(Long.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Lt(long value) {
        return ${field.newNameCamelCaseLowerCase}Lt(Long.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}LtEq(long value) {
        return ${field.newNameCamelCaseLowerCase}LtEq(Long.valueOf(value));
    }
    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Gt(Long value) {
        addGreaterThan(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}GtEq(Long value) {
        addGreaterThanOrEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Lt(Long value) {
        addLessThan(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}LtEq(Long value) {
        addLessThanOrEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }
    <#break>
    <#case "FLOAT_PRIMITIVE">
    <#case "FLOAT">
    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Gt(float value) {
        return ${field.newNameCamelCaseLowerCase}Gt(Float.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}GtEq(float value) {
        return ${field.newNameCamelCaseLowerCase}GtEq(Float.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Lt(float value) {
        return ${field.newNameCamelCaseLowerCase}Lt(Float.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}LtEq(float value) {
        return ${field.newNameCamelCaseLowerCase}LtEq(Float.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Gt(Float value) {
        addGreaterThan(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}GtEq(Float value) {
        addGreaterThanOrEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Lt(Float value) {
        addLessThan(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}LtEq(Float value) {
        addLessThanOrEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }
    <#break>
    <#case "DOUBLE">
    <#case "DOUBLE_PRIMITIVE">
    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Gt(Double value) {
        addGreaterThan(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}GtEq(Double value) {
        addGreaterThanOrEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Lt(Double value) {
        addLessThan(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}LtEq(Double value) {
        addLessThanOrEquals(${entity.nameCamelCase}Columns.${field.newNameUpperCase}, value);
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Gt(double value) {
        return ${field.newNameCamelCaseLowerCase}Gt(Double.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}GtEq(double value) {
        return ${field.newNameCamelCaseLowerCase}GtEq(Double.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}Lt(double value) {
        return ${field.newNameCamelCaseLowerCase}Lt(Double.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.newNameCamelCaseLowerCase}LtEq(double value) {
        return ${field.newNameCamelCaseLowerCase}LtEq(Double.valueOf(value));
    }
    <#break>
    </#switch>
    </#list>
}
