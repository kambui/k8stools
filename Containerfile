FROM  registry.redhat.io/rhel8/support-tools:8.10-9.1731462873 
COPY scripts/ /tools/
RUN chmod -R 755 /tools
ENV PATH="/tools:${PATH}"
CMD ["/bin/bash"]

