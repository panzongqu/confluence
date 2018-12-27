FROM cptactionhank/atlassian-confluence
ENV CONF_HOME /var/atlassian/confluence
ENV CONF_INSTALL /opt/atlassian/confluence

RUN set -x \
    && chmod -R 700        "${CONF_HOME}" \
    && chown daemon:daemon "${CONF_HOME}" \
    && chmod -R 700            "${CONF_INSTALL}/conf" \
    && chmod -R 700            "${CONF_INSTALL}/temp" \
    && chmod -R 700            "${CONF_INSTALL}/logs" \
    && chmod -R 700            "${CONF_INSTALL}/work" \
    && chown -R daemon:daemon  "${CONF_INSTALL}/conf" \
    && chown -R daemon:daemon  "${CONF_INSTALL}/temp" \
    && chown -R daemon:daemon  "${CONF_INSTALL}/logs" \
    && chown -R daemon:daemon  "${CONF_INSTALL}/work" \
    && chown daemon:daemon "${JAVA_CACERTS}"

USER daemon:daemon
EXPOSE 8090 8091
VOLUME ["/var/atlassian/confluence", "/opt/atlassian/confluence/logs"]
WORKDIR /var/atlassian/confluence
COPY "atlassian-extras-decoder-v2-3.4.1.jar" "${CONF_INSTALL}/confluence/WEB-INF/lib"
COPY --chown=daemon:daemon "workdir_data.tar.gz" "${CONF_INSTALL}/temp"
COPY --chown=daemon:daemon "docker-entrypoint.sh" "/"
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/opt/atlassian/confluence/bin/start-confluence.sh", "-fg"]
