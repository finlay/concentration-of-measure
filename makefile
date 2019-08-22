IMAGE := docker.dragonfly.co.nz/concentration-of-measure
RUN :=


plot.pdf: plot.r data.rds
	$(RUN) Rscript $<

data.rds: data.r
	$(RUN) Rscript $<

docker:
	docker build --tag $(IMAGE) .

local:
	docker run -it --rm -w /work -v $(PWD)/:/work \
		--net=host \
		-e DISPLAY=$$DISPLAY \
		-v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0 \
		-u $$(id -u):$$(id -g) $(IMAGE) bash

