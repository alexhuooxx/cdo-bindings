module Cdo
  using PyCall

  pyCdo = pyimport("cdo")

  # wrap around the original python constructor
  function new(self, args...; kwargs...)
    pyCdo.Cdo(self, args...; kwargs...)
  end
end
