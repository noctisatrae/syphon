defmodule Arguments do
  @tcp_syn_scan "-sS"
  @os_detection "-O"

  @is_privileged "--privileged"
  @is_unprivileged "--unprivileged"
  @verbose_output "-v"


  def tcp_syn_scan do @tcp_syn_scan end
  def os_detection do @os_detection end
  def is_privileged do @is_privileged end
  def is_unprivileged do @is_unprivileged end
  def verbose_output do @verbose_output end
end
