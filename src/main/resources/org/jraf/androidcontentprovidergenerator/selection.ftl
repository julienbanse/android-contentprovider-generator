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
    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}(int value) {
        addEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, Integer.valueOf(value));
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Not(int value) {
        addNotEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, Integer.valueOf(value));
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}In(int[] value) {
        addEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, toObjectArray(value));
        return this;
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}NotIn(int[] value) {
        addNotEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, toObjectArray(value));
        return this;
    }
     <#break>
     <#case "DOUBLE_PRIMITIVE">
     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}(double value) {
         addEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, Double.valueOf(value));
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Not(double value) {
         addNotEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, Double.valueOf(value));
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}In(double[] value) {
         addEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, toObjectArray(value));
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}NotIn(double[] value) {
         addNotEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, toObjectArray(value));
         return this;
     }
     <#break>
     <#case "FLOAT_PRIMITIVE">
     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}(float value) {
         addEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, Float.valueOf(value));
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Not(float value) {
         addNotEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, Float.valueOf(value));
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}In(float[] value) {
         addEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, toObjectArray(value));
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}NotIn(float[] value) {
         addNotEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, toObjectArray(value));
         return this;
     }
     <#break>
     <#case "LONG_PRIMITIVE">
     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}(long value) {
         addEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, Long.valueOf(value));
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Not(long value) {
         addNotEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, Long.valueOf(value));
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}In(long[] value) {
         addEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, toObjectArray(value));
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}NotIn(long[] value) {
         addNotEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, toObjectArray(value));
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
     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}(${field.type.javaType.simpleName} value) {
         addEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
         return this;
     }

     public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Not(${field.type.javaType.simpleName} value) {
         addNotEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
         return this;
     }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}In(${field.type.javaType.simpleName}... value) {
        addEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }
    
    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}NotIn(${field.type.javaType.simpleName}... value) {
        addNotEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }
    </#switch>


    <#switch field.type.name()>
    <#case "DATE">
    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}(<#if field.isNullable>Long<#else>long</#if>... value) {
        addEquals(${entity.nameCamelCase}Columns.${field.nameUpperCase}, <#if field.isNullable>value<#else>toObjectArray(value)</#if>);
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

    <#case "INT">
    <#case "INTEGER">
    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Gt(int value) {
        return ${field.nameCamelCaseLowerCase}Gt(Integer.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}GtEq(int value) {
        return ${field.nameCamelCaseLowerCase}GtEq(Integer.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Lt(int value) {
        return ${field.nameCamelCaseLowerCase}Lt(Integer.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}LtEq(int value) {
        return ${field.nameCamelCaseLowerCase}LtEq(Integer.valueOf(value));
    }

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
    <#case "LONG_PRIMITIVE">
    <#case "LONG">
    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Gt(long value) {
        return ${field.nameCamelCaseLowerCase}Gt(Long.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}GtEq(long value) {
        return ${field.nameCamelCaseLowerCase}GtEq(Long.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Lt(long value) {
        return ${field.nameCamelCaseLowerCase}Lt(Long.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}LtEq(long value) {
        return ${field.nameCamelCaseLowerCase}LtEq(Long.valueOf(value));
    }
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
    <#case "FLOAT_PRIMITIVE">
    <#case "FLOAT">
    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Gt(float value) {
        return ${field.nameCamelCaseLowerCase}Gt(Float.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}GtEq(float value) {
        return ${field.nameCamelCaseLowerCase}GtEq(Float.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Lt(float value) {
        return ${field.nameCamelCaseLowerCase}Lt(Float.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}LtEq(float value) {
        return ${field.nameCamelCaseLowerCase}LtEq(Float.valueOf(value));
    }

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

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Gt(double value) {
        return ${field.nameCamelCaseLowerCase}Gt(Double.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}GtEq(double value) {
        return ${field.nameCamelCaseLowerCase}GtEq(Double.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}Lt(double value) {
        return ${field.nameCamelCaseLowerCase}Lt(Double.valueOf(value));
    }

    public ${entity.nameCamelCase}Selection ${field.nameCamelCaseLowerCase}LtEq(double value) {
        return ${field.nameCamelCaseLowerCase}LtEq(Double.valueOf(value));
    }
    <#break>
    </#switch>
    </#list>
}
