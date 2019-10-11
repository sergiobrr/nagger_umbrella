defmodule NaggerWeb.FilterConfig do

  @moduledoc """
  This module is intended to contains
  all filters used by rest client to get data
  relatives to this app controllers
"""
  import Filtrex.Type.Config

  # configurations for filters on tags
  def tags() do
    defconfig do
      text [:value]
    end
  end



end
