class HealthsController < ApplicationController
  def show
    sys = System.first

    render json:
  end

  private

  def health_checks
    path = Graph.new(sys).path

    build_path = lambda do |node|
      downstream_apps = node["downstream_apps"].map |dsa|
        build_path.call(dsa)
      end

      {
        uri: node["metadata"]["uri"],
        downstream_apps:
      }
    end

    build_path.call(path.first)
  end
end
