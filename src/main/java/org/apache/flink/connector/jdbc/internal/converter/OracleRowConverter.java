package org.apache.flink.connector.jdbc.internal.converter;

import org.apache.flink.table.types.logical.RowType;

public class OracleRowConverter extends AbstractJdbcRowConverter {
    private static final long serialVersionUID = 1L;

    @Override
    public String converterName() {
        return "Oracle";
    }

    public OracleRowConverter(RowType rowType) {
        super(rowType);
    }
}
