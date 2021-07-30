package org.apache.flink.connector.jdbc.dialect;

import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;

public final class JdbcDialects {
    private static final List<JdbcDialect> DIALECTS =
            Arrays.asList(
                    new OracleDialect(),
                    new DerbyDialect(),
                    new MySQLDialect(),
                    new PostgresDialect(),
                    new ClickhouseDialect());

    public JdbcDialects() {}
    //    /** Fetch the JdbcDialect class corresponding to a given database url. */
    //    public static Optional<JdbcDialect> get(String url) {
    //        for (JdbcDialect dialect : DIALECTS) {
    //            System.out.println(dialect+ "2313" + DIALECTS);
    //            if (dialect.canHandle(url)) {
    //                return Optional.of(dialect);
    //            }
    //        }
    //        return Optional.empty();
    //    }
    public static Optional<JdbcDialect> get(String url) {
        Iterator var1 = DIALECTS.iterator();

        JdbcDialect dialect;
        do {
            if (!var1.hasNext()) {
                return Optional.empty();
            }

            dialect = (JdbcDialect) var1.next();
        } while (!dialect.canHandle(url));

        return Optional.of(dialect);
    }
}
