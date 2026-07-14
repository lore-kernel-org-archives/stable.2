Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CC83EDE73
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059333; cv=none; b=KtmCciV7enakcs4bbbH/6tuPUrXc0TPBnb1noFH6uypd9SHwP6nxDa6gkZ+Mw5UTxyF38yUezZOvvsEsQZ4jDytKviVzYC88kq6UhWZqj9AU0zFN145QPVkbJtGY51/AjhoS/Bn2pcAiQljCD2JrLCJCQIA6blVODPOqj9oTer8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059333; c=relaxed/simple;
	bh=CJ3wqMMiKYdh1FFIfwx6WxfGWc1zVJ9HkXh3/YO2LZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxMCL7IyiP7u9tca9VzYX5nl2fkrEcaAhdCmpjjGRcpOBic0C/rcx/bJ84oHJNza3pydc1RBKib6/gacyOf12i5sN8pvQlp5Q3746gC7PVRzN+ZZ50NQUZ7l1Q7SBPQsqfuE5rEkCY8poe+iL3WkOltjAUMqUBdI3P7qaZvlIfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEIiaSUG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEIiaSUG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9851F00AC4;
	Tue, 14 Jul 2026 20:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059321;
	bh=eA5T4NHgSb4Uxx5p3nEaoH5UHOwdpoWUT8Eb6w4GSQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PEIiaSUGr88edsuEM0XNvVAO1HIacg4nu0IrqygxR4M2JdcFnJRzbNPGOx8JDiTk1
	 wBFfV/hTw5NvdQUt10zrtx3JJgS6ya0N0Yprk4v0tANPWyowCQzDOaQW2t2k1DCTlL
	 L/h5pebfB6uiv84hl/RckJsokpFteX6kl5ZLBNmWH2JKTX1TDWFd+35Rldzs/uqYAy
	 YFts/PyXApX3xlBa9M3/3IR5P1ocP9mXaFsrVdo9W43EC0HgnyVrnenjyq9g5O1yPK
	 pFa+GRmb7Pb6SdHGTcfmZkKdoFwvjK5vDgNU0bD4KF0igSn9/b6DtaFXCrF5WBDu/C
	 jf1uvUl/Wvb6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Martiros Shakhzadyan <vrzh@vrzh.net>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/6] media: staging: media: atomisp: Fix sh_css.c brace coding style issues
Date: Tue, 14 Jul 2026 16:01:54 -0400
Message-ID: <20260714200158.3152137-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714200158.3152137-1-sashal@kernel.org>
References: <2026071304-opulently-outburst-4960@gregkh>
 <20260714200158.3152137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martiros Shakhzadyan <vrzh@vrzh.net>

[ Upstream commit 6ceb557604e85c55bce0585216623c21c7a00453 ]

Fix brace coding style issues.

Signed-off-by: Martiros Shakhzadyan <vrzh@vrzh.net>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: f4d51e55dd47 ("staging: media: atomisp: reduce load_primary_binaries() stack usage")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/atomisp/pci/sh_css.c | 224 +++++++++------------
 1 file changed, 90 insertions(+), 134 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
index 57e5595faac4c9..2988f686e26b65 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -456,15 +456,15 @@ static enum ia_css_frame_format yuv422_copy_formats[] = {
  * by the copy binary given the stream format.
  * */
 static int
-verify_copy_out_frame_format(struct ia_css_pipe *pipe) {
+verify_copy_out_frame_format(struct ia_css_pipe *pipe)
+{
 	enum ia_css_frame_format out_fmt = pipe->output_info[0].format;
 	unsigned int i, found = 0;
 
 	assert(pipe);
 	assert(pipe->stream);
 
-	switch (pipe->stream->config.input_config.format)
-	{
+	switch (pipe->stream->config.input_config.format) {
 	case ATOMISP_INPUT_FORMAT_YUV420_8_LEGACY:
 	case ATOMISP_INPUT_FORMAT_YUV420_8:
 		for (i = 0; i < ARRAY_SIZE(yuv420_copy_formats) && !found; i++)
@@ -532,7 +532,8 @@ ia_css_stream_input_format_bits_per_pixel(struct ia_css_stream *stream)
 
 #if !defined(ISP2401)
 static int
-sh_css_config_input_network(struct ia_css_stream *stream) {
+sh_css_config_input_network(struct ia_css_stream *stream)
+{
 	unsigned int fmt_type;
 	struct ia_css_pipe *pipe = stream->last_pipe;
 	struct ia_css_binary *binary = NULL;
@@ -558,8 +559,7 @@ sh_css_config_input_network(struct ia_css_stream *stream) {
 					stream->config.mode);
 
 	if ((binary && (binary->online || stream->config.continuous)) ||
-	    pipe->config.mode == IA_CSS_PIPE_MODE_COPY)
-	{
+	    pipe->config.mode == IA_CSS_PIPE_MODE_COPY) {
 		err = ia_css_ifmtr_configure(&stream->config,
 					     binary);
 		if (err)
@@ -567,8 +567,7 @@ sh_css_config_input_network(struct ia_css_stream *stream) {
 	}
 
 	if (stream->config.mode == IA_CSS_INPUT_MODE_TPG ||
-	    stream->config.mode == IA_CSS_INPUT_MODE_PRBS)
-	{
+	    stream->config.mode == IA_CSS_INPUT_MODE_PRBS) {
 		unsigned int hblank_cycles = 100,
 		vblank_lines = 6,
 		width,
@@ -723,35 +722,32 @@ static bool sh_css_translate_stream_cfg_to_input_system_input_port_id(
 	switch (stream_cfg->mode) {
 	case IA_CSS_INPUT_MODE_TPG:
 
-		if (stream_cfg->source.tpg.id == IA_CSS_TPG_ID0) {
+		if (stream_cfg->source.tpg.id == IA_CSS_TPG_ID0)
 			isys_stream_descr->input_port_id = INPUT_SYSTEM_PIXELGEN_PORT0_ID;
-		} else if (stream_cfg->source.tpg.id == IA_CSS_TPG_ID1) {
+		else if (stream_cfg->source.tpg.id == IA_CSS_TPG_ID1)
 			isys_stream_descr->input_port_id = INPUT_SYSTEM_PIXELGEN_PORT1_ID;
-		} else if (stream_cfg->source.tpg.id == IA_CSS_TPG_ID2) {
+		else if (stream_cfg->source.tpg.id == IA_CSS_TPG_ID2)
 			isys_stream_descr->input_port_id = INPUT_SYSTEM_PIXELGEN_PORT2_ID;
-		}
 
 		break;
 	case IA_CSS_INPUT_MODE_PRBS:
 
-		if (stream_cfg->source.prbs.id == IA_CSS_PRBS_ID0) {
+		if (stream_cfg->source.prbs.id == IA_CSS_PRBS_ID0)
 			isys_stream_descr->input_port_id = INPUT_SYSTEM_PIXELGEN_PORT0_ID;
-		} else if (stream_cfg->source.prbs.id == IA_CSS_PRBS_ID1) {
+		else if (stream_cfg->source.prbs.id == IA_CSS_PRBS_ID1)
 			isys_stream_descr->input_port_id = INPUT_SYSTEM_PIXELGEN_PORT1_ID;
-		} else if (stream_cfg->source.prbs.id == IA_CSS_PRBS_ID2) {
+		else if (stream_cfg->source.prbs.id == IA_CSS_PRBS_ID2)
 			isys_stream_descr->input_port_id = INPUT_SYSTEM_PIXELGEN_PORT2_ID;
-		}
 
 		break;
 	case IA_CSS_INPUT_MODE_BUFFERED_SENSOR:
 
-		if (stream_cfg->source.port.port == MIPI_PORT0_ID) {
+		if (stream_cfg->source.port.port == MIPI_PORT0_ID)
 			isys_stream_descr->input_port_id = INPUT_SYSTEM_CSI_PORT0_ID;
-		} else if (stream_cfg->source.port.port == MIPI_PORT1_ID) {
+		else if (stream_cfg->source.port.port == MIPI_PORT1_ID)
 			isys_stream_descr->input_port_id = INPUT_SYSTEM_CSI_PORT1_ID;
-		} else if (stream_cfg->source.port.port == MIPI_PORT2_ID) {
+		else if (stream_cfg->source.port.port == MIPI_PORT2_ID)
 			isys_stream_descr->input_port_id = INPUT_SYSTEM_CSI_PORT2_ID;
-		}
 
 		break;
 	default:
@@ -804,15 +800,14 @@ static bool sh_css_translate_stream_cfg_to_input_system_input_port_attr(
 	rc = true;
 	switch (stream_cfg->mode) {
 	case IA_CSS_INPUT_MODE_TPG:
-		if (stream_cfg->source.tpg.mode == IA_CSS_TPG_MODE_RAMP) {
+		if (stream_cfg->source.tpg.mode == IA_CSS_TPG_MODE_RAMP)
 			isys_stream_descr->tpg_port_attr.mode = PIXELGEN_TPG_MODE_RAMP;
-		} else if (stream_cfg->source.tpg.mode == IA_CSS_TPG_MODE_CHECKERBOARD) {
+		else if (stream_cfg->source.tpg.mode == IA_CSS_TPG_MODE_CHECKERBOARD)
 			isys_stream_descr->tpg_port_attr.mode = PIXELGEN_TPG_MODE_CHBO;
-		} else if (stream_cfg->source.tpg.mode == IA_CSS_TPG_MODE_MONO) {
+		else if (stream_cfg->source.tpg.mode == IA_CSS_TPG_MODE_MONO)
 			isys_stream_descr->tpg_port_attr.mode = PIXELGEN_TPG_MODE_MONO;
-		} else {
+		else
 			rc = false;
-		}
 
 		/*
 		 * TODO
@@ -951,12 +946,12 @@ static bool sh_css_translate_stream_cfg_to_input_system_input_port_resolution(
 	     stream_cfg->mode == IA_CSS_INPUT_MODE_BUFFERED_SENSOR) &&
 	    stream_cfg->source.port.compression.type != IA_CSS_CSI2_COMPRESSION_TYPE_NONE) {
 		if (stream_cfg->source.port.compression.uncompressed_bits_per_pixel ==
-		    UNCOMPRESSED_BITS_PER_PIXEL_10) {
+		    UNCOMPRESSED_BITS_PER_PIXEL_10)
 			fmt_type = ATOMISP_INPUT_FORMAT_RAW_10;
-		} else if (stream_cfg->source.port.compression.uncompressed_bits_per_pixel ==
-			   UNCOMPRESSED_BITS_PER_PIXEL_12) {
+		else if (stream_cfg->source.port.compression.uncompressed_bits_per_pixel ==
+			   UNCOMPRESSED_BITS_PER_PIXEL_12)
 			fmt_type = ATOMISP_INPUT_FORMAT_RAW_12;
-		} else
+		else
 			return false;
 	}
 
@@ -1043,7 +1038,8 @@ static bool sh_css_translate_binary_info_to_input_system_output_port_attr(
 }
 
 static int
-sh_css_config_input_network(struct ia_css_stream *stream) {
+sh_css_config_input_network(struct ia_css_stream *stream)
+{
 	bool					rc;
 	ia_css_isys_descr_t			isys_stream_descr;
 	unsigned int				sp_thread_id;
@@ -1058,19 +1054,16 @@ sh_css_config_input_network(struct ia_css_stream *stream) {
 	ia_css_debug_dtrace(IA_CSS_DEBUG_TRACE_PRIVATE,
 			    "sh_css_config_input_network() enter 0x%p:\n", stream);
 
-	if (stream->config.continuous)
-	{
-		if (stream->last_pipe->config.mode == IA_CSS_PIPE_MODE_CAPTURE) {
+	if (stream->config.continuous) {
+		if (stream->last_pipe->config.mode == IA_CSS_PIPE_MODE_CAPTURE)
 			pipe = stream->last_pipe;
-		} else if (stream->last_pipe->config.mode == IA_CSS_PIPE_MODE_YUVPP) {
+		else if (stream->last_pipe->config.mode == IA_CSS_PIPE_MODE_YUVPP)
 			pipe = stream->last_pipe;
-		} else if (stream->last_pipe->config.mode == IA_CSS_PIPE_MODE_PREVIEW) {
+		else if (stream->last_pipe->config.mode == IA_CSS_PIPE_MODE_PREVIEW)
 			pipe = stream->last_pipe->pipe_settings.preview.copy_pipe;
-		} else if (stream->last_pipe->config.mode == IA_CSS_PIPE_MODE_VIDEO) {
+		else if (stream->last_pipe->config.mode == IA_CSS_PIPE_MODE_VIDEO)
 			pipe = stream->last_pipe->pipe_settings.video.copy_pipe;
-		}
-	} else
-	{
+	} else {
 		pipe = stream->last_pipe;
 		if (stream->last_pipe->config.mode == IA_CSS_PIPE_MODE_CAPTURE) {
 			/*
@@ -1093,8 +1086,7 @@ sh_css_config_input_network(struct ia_css_stream *stream) {
 		if (pipe->pipeline.stages->binary)
 			binary = pipe->pipeline.stages->binary;
 
-	if (binary)
-	{
+	if (binary) {
 		/* this was being done in ifmtr in 2400.
 		 * online and cont bypass the init_in_frameinfo_memory_defaults
 		 * so need to do it here
@@ -1208,11 +1200,10 @@ static inline struct ia_css_pipe *stream_get_target_pipe(
 	struct ia_css_pipe *target_pipe;
 
 	/* get the pipe that consumes the stream */
-	if (stream->config.continuous) {
+	if (stream->config.continuous)
 		target_pipe = stream_get_copy_pipe(stream);
-	} else {
+	else
 		target_pipe = stream_get_last_pipe(stream);
-	}
 
 	return target_pipe;
 }
@@ -1386,7 +1377,8 @@ start_binary(struct ia_css_pipe *pipe,
 /* start the copy function on the SP */
 static int
 start_copy_on_sp(struct ia_css_pipe *pipe,
-		 struct ia_css_frame *out_frame) {
+		 struct ia_css_frame *out_frame)
+{
 	(void)out_frame;
 	assert(pipe);
 	assert(pipe->stream);
@@ -1404,8 +1396,7 @@ start_copy_on_sp(struct ia_css_pipe *pipe,
 	sh_css_sp_start_binary_copy(ia_css_pipe_get_pipe_num(pipe), out_frame, pipe->stream->config.pixels_per_clock == 2);
 
 #if !defined(ISP2401)
-	if (pipe->stream->reconfigure_css_rx)
-	{
+	if (pipe->stream->reconfigure_css_rx) {
 		ia_css_isys_rx_configure(&pipe->stream->csi_rx_config,
 					 pipe->stream->config.mode);
 		pipe->stream->reconfigure_css_rx = false;
@@ -1594,7 +1585,8 @@ ia_css_reset_defaults(struct sh_css *css)
 
 int
 ia_css_load_firmware(struct device *dev, const struct ia_css_env *env,
-		     const struct ia_css_fw  *fw) {
+		     const struct ia_css_fw  *fw)
+{
 	int err;
 
 	if (!env)
@@ -1605,16 +1597,14 @@ ia_css_load_firmware(struct device *dev, const struct ia_css_env *env,
 	ia_css_debug_dtrace(IA_CSS_DEBUG_TRACE, "ia_css_load_firmware() enter\n");
 
 	/* make sure we initialize my_css */
-	if (my_css.flush != env->cpu_mem_env.flush)
-	{
+	if (my_css.flush != env->cpu_mem_env.flush) {
 		ia_css_reset_defaults(&my_css);
 		my_css.flush = env->cpu_mem_env.flush;
 	}
 
 	ia_css_unload_firmware(); /* in case we are called twice */
 	err = sh_css_load_firmware(dev, fw->data, fw->bytes);
-	if (!err)
-	{
+	if (!err) {
 		err = ia_css_binary_init_infos();
 		if (!err)
 			fw_explicitly_loaded = true;
@@ -1628,7 +1618,8 @@ int
 ia_css_init(struct device *dev, const struct ia_css_env *env,
 	    const struct ia_css_fw  *fw,
 	    u32                 mmu_l1_base,
-	    enum ia_css_irq_type     irq_type) {
+	    enum ia_css_irq_type     irq_type)
+{
 	int err;
 	ia_css_spctrl_cfg spctrl_cfg;
 
@@ -1702,16 +1693,14 @@ ia_css_init(struct device *dev, const struct ia_css_env *env,
 	my_css.flush     = flush_func;
 
 	err = ia_css_rmgr_init();
-	if (err)
-	{
+	if (err) {
 		IA_CSS_LEAVE_ERR(err);
 		return err;
 	}
 
 	IA_CSS_LOG("init: %d", my_css_save_initialized);
 
-	if (!my_css_save_initialized)
-	{
+	if (!my_css_save_initialized) {
 		my_css_save_initialized = true;
 		my_css_save.mode = sh_css_mode_working;
 		memset(my_css_save.stream_seeds, 0,
@@ -1739,19 +1728,16 @@ ia_css_init(struct device *dev, const struct ia_css_env *env,
 	gpio_reg_store(GPIO0_ID, _gpio_block_reg_do_0, 0);
 
 	err = ia_css_refcount_init(REFCOUNT_SIZE);
-	if (err)
-	{
+	if (err) {
 		IA_CSS_LEAVE_ERR(err);
 		return err;
 	}
 	err = sh_css_params_init();
-	if (err)
-	{
+	if (err) {
 		IA_CSS_LEAVE_ERR(err);
 		return err;
 	}
-	if (fw)
-	{
+	if (fw) {
 		ia_css_unload_firmware(); /* in case we already had firmware loaded */
 		err = sh_css_load_firmware(dev, fw->data, fw->bytes);
 		if (err) {
@@ -1772,23 +1758,20 @@ ia_css_init(struct device *dev, const struct ia_css_env *env,
 		return -EINVAL;
 
 	err = ia_css_spctrl_load_fw(SP0_ID, &spctrl_cfg);
-	if (err)
-	{
+	if (err) {
 		IA_CSS_LEAVE_ERR(err);
 		return err;
 	}
 
 #if WITH_PC_MONITORING
-	if (!thread_alive)
-	{
+	if (!thread_alive) {
 		thread_alive++;
 		sh_css_print("PC_MONITORING: %s() -- create thread DISABLED\n",
 			     __func__);
 		spying_thread_create();
 	}
 #endif
-	if (!sh_css_hrt_system_is_idle())
-	{
+	if (!sh_css_hrt_system_is_idle()) {
 		IA_CSS_LEAVE_ERR(-EBUSY);
 		return -EBUSY;
 	}
@@ -1821,7 +1804,8 @@ ia_css_init(struct device *dev, const struct ia_css_env *env,
 }
 
 int
-ia_css_enable_isys_event_queue(bool enable) {
+ia_css_enable_isys_event_queue(bool enable)
+{
 	if (sh_css_sp_is_running())
 		return -EBUSY;
 	sh_css_sp_enable_isys_event_queue(enable);
@@ -1842,7 +1826,8 @@ sh_css_flush(struct ia_css_acc_fw *fw)
  * doing it from stream_create since we could run out of sp threads due to
  * allocation on inactive pipelines. */
 static int
-map_sp_threads(struct ia_css_stream *stream, bool map) {
+map_sp_threads(struct ia_css_stream *stream, bool map)
+{
 	struct ia_css_pipe *main_pipe = NULL;
 	struct ia_css_pipe *copy_pipe = NULL;
 	struct ia_css_pipe *capture_pipe = NULL;
@@ -1854,8 +1839,7 @@ map_sp_threads(struct ia_css_stream *stream, bool map) {
 	IA_CSS_ENTER_PRIVATE("stream = %p, map = %s",
 			     stream, map ? "true" : "false");
 
-	if (!stream)
-	{
+	if (!stream) {
 		IA_CSS_LEAVE_ERR_PRIVATE(-EINVAL);
 		return -EINVAL;
 	}
@@ -1865,8 +1849,7 @@ map_sp_threads(struct ia_css_stream *stream, bool map) {
 
 	ia_css_pipeline_map(main_pipe->pipe_num, map);
 
-	switch (pipe_id)
-	{
+	switch (pipe_id) {
 	case IA_CSS_PIPE_ID_PREVIEW:
 		copy_pipe    = main_pipe->pipe_settings.preview.copy_pipe;
 		capture_pipe = main_pipe->pipe_settings.preview.capture_pipe;
@@ -1885,23 +1868,17 @@ map_sp_threads(struct ia_css_stream *stream, bool map) {
 	}
 
 	if (acc_pipe)
-	{
 		ia_css_pipeline_map(acc_pipe->pipe_num, map);
-	}
 
 	if (capture_pipe)
-	{
 		ia_css_pipeline_map(capture_pipe->pipe_num, map);
-	}
 
 	/* Firmware expects copy pipe to be the last pipe mapped. (if needed) */
 	if (copy_pipe)
-	{
 		ia_css_pipeline_map(copy_pipe->pipe_num, map);
-	}
+
 	/* DH regular multi pipe - not continuous mode: map the next pipes too */
-	if (!stream->config.continuous)
-	{
+	if (!stream->config.continuous) {
 		int i;
 
 		for (i = 1; i < stream->num_pipes; i++)
@@ -1915,7 +1892,8 @@ map_sp_threads(struct ia_css_stream *stream, bool map) {
 /* creates a host pipeline skeleton for all pipes in a stream. Called during
  * stream_create. */
 static int
-create_host_pipeline_structure(struct ia_css_stream *stream) {
+create_host_pipeline_structure(struct ia_css_stream *stream)
+{
 	struct ia_css_pipe *copy_pipe = NULL, *capture_pipe = NULL;
 	struct ia_css_pipe *acc_pipe = NULL;
 	enum ia_css_pipe_id pipe_id;
@@ -1927,24 +1905,21 @@ create_host_pipeline_structure(struct ia_css_stream *stream) {
 	assert(stream);
 	IA_CSS_ENTER_PRIVATE("stream = %p", stream);
 
-	if (!stream)
-	{
+	if (!stream) {
 		IA_CSS_LEAVE_ERR_PRIVATE(-EINVAL);
 		return -EINVAL;
 	}
 
 	main_pipe	= stream->last_pipe;
 	assert(main_pipe);
-	if (!main_pipe)
-	{
+	if (!main_pipe) {
 		IA_CSS_LEAVE_ERR_PRIVATE(-EINVAL);
 		return -EINVAL;
 	}
 
 	pipe_id	= main_pipe->mode;
 
-	switch (pipe_id)
-	{
+	switch (pipe_id) {
 	case IA_CSS_PIPE_ID_PREVIEW:
 		copy_pipe    = main_pipe->pipe_settings.preview.copy_pipe;
 		copy_pipe_delay = main_pipe->dvs_frame_delay;
@@ -1984,30 +1959,23 @@ create_host_pipeline_structure(struct ia_css_stream *stream) {
 	}
 
 	if (!(err) && copy_pipe)
-	{
 		err = ia_css_pipeline_create(&copy_pipe->pipeline,
 					     copy_pipe->mode,
 					     copy_pipe->pipe_num,
 					     copy_pipe_delay);
-	}
 
 	if (!(err) && capture_pipe)
-	{
 		err = ia_css_pipeline_create(&capture_pipe->pipeline,
 					     capture_pipe->mode,
 					     capture_pipe->pipe_num,
 					     capture_pipe_delay);
-	}
 
 	if (!(err) && acc_pipe)
-	{
 		err = ia_css_pipeline_create(&acc_pipe->pipeline, acc_pipe->mode,
 					     acc_pipe->pipe_num, main_pipe->dvs_frame_delay);
-	}
 
 	/* DH regular multi pipe - not continuous mode: create the next pipelines too */
-	if (!stream->config.continuous)
-	{
+	if (!stream->config.continuous) {
 		int i;
 
 		for (i = 1; i < stream->num_pipes && 0 == err; i++) {
@@ -2026,7 +1994,8 @@ create_host_pipeline_structure(struct ia_css_stream *stream) {
 /* creates a host pipeline for all pipes in a stream. Called during
  * stream_start. */
 static int
-create_host_pipeline(struct ia_css_stream *stream) {
+create_host_pipeline(struct ia_css_stream *stream)
+{
 	struct ia_css_pipe *copy_pipe = NULL, *capture_pipe = NULL;
 	struct ia_css_pipe *acc_pipe = NULL;
 	enum ia_css_pipe_id pipe_id;
@@ -2035,8 +2004,7 @@ create_host_pipeline(struct ia_css_stream *stream) {
 	unsigned int max_input_width = 0;
 
 	IA_CSS_ENTER_PRIVATE("stream = %p", stream);
-	if (!stream)
-	{
+	if (!stream) {
 		IA_CSS_LEAVE_ERR_PRIVATE(-EINVAL);
 		return -EINVAL;
 	}
@@ -2047,8 +2015,7 @@ create_host_pipeline(struct ia_css_stream *stream) {
 	/* No continuous frame allocation for capture pipe. It uses the
 	 * "main" pipe's frames. */
 	if ((pipe_id == IA_CSS_PIPE_ID_PREVIEW) ||
-	    (pipe_id == IA_CSS_PIPE_ID_VIDEO))
-	{
+	    (pipe_id == IA_CSS_PIPE_ID_VIDEO)) {
 		/* About pipe_id == IA_CSS_PIPE_ID_PREVIEW && stream->config.mode != IA_CSS_INPUT_MODE_MEMORY:
 		 * The original condition pipe_id == IA_CSS_PIPE_ID_PREVIEW is too strong. E.g. in SkyCam (with memory
 		 * based input frames) there is no continuous mode and thus no need for allocated continuous frames
@@ -2066,24 +2033,21 @@ create_host_pipeline(struct ia_css_stream *stream) {
 
 #if !defined(ISP2401)
 	/* old isys: need to allocate_mipi_frames() even in IA_CSS_PIPE_MODE_COPY */
-	if (pipe_id != IA_CSS_PIPE_ID_ACC)
-	{
+	if (pipe_id != IA_CSS_PIPE_ID_ACC) {
 		err = allocate_mipi_frames(main_pipe, &stream->info);
 		if (err)
 			goto ERR;
 	}
 #elif defined(ISP2401)
 	if ((pipe_id != IA_CSS_PIPE_ID_ACC) &&
-	    (main_pipe->config.mode != IA_CSS_PIPE_MODE_COPY))
-	{
+	    (main_pipe->config.mode != IA_CSS_PIPE_MODE_COPY)) {
 		err = allocate_mipi_frames(main_pipe, &stream->info);
 		if (err)
 			goto ERR;
 	}
 #endif
 
-	switch (pipe_id)
-	{
+	switch (pipe_id) {
 	case IA_CSS_PIPE_ID_PREVIEW:
 		copy_pipe    = main_pipe->pipe_settings.preview.copy_pipe;
 		capture_pipe = main_pipe->pipe_settings.preview.capture_pipe;
@@ -2133,31 +2097,27 @@ create_host_pipeline(struct ia_css_stream *stream) {
 	if (err)
 		goto ERR;
 
-	if (copy_pipe)
-	{
+	if (copy_pipe) {
 		err = create_host_copy_pipeline(copy_pipe, max_input_width,
 						main_pipe->continuous_frames[0]);
 		if (err)
 			goto ERR;
 	}
 
-	if (capture_pipe)
-	{
+	if (capture_pipe) {
 		err = create_host_capture_pipeline(capture_pipe);
 		if (err)
 			goto ERR;
 	}
 
-	if (acc_pipe)
-	{
+	if (acc_pipe) {
 		err = create_host_acc_pipeline(acc_pipe);
 		if (err)
 			goto ERR;
 	}
 
 	/* DH regular multi pipe - not continuous mode: create the next pipelines too */
-	if (!stream->config.continuous)
-	{
+	if (!stream->config.continuous) {
 		int i;
 
 		for (i = 1; i < stream->num_pipes && 0 == err; i++) {
@@ -2199,10 +2159,10 @@ static const struct ia_css_yuvpp_settings yuvpp = IA_CSS_DEFAULT_YUVPP_SETTINGS;
 static int
 init_pipe_defaults(enum ia_css_pipe_mode mode,
 		   struct ia_css_pipe *pipe,
-		   bool copy_pipe) {
+		   bool copy_pipe)
+{
 
-	if (!pipe)
-	{
+	if (!pipe) {
 		IA_CSS_ERROR("NULL pipe parameter");
 		return -EINVAL;
 	}
@@ -2211,18 +2171,17 @@ init_pipe_defaults(enum ia_css_pipe_mode mode,
 	memcpy(pipe, &default_pipe, sizeof(default_pipe));
 
 	/* TODO: JB should not be needed, but temporary backward reference */
-	switch (mode)
-	{
+	switch (mode) {
 	case IA_CSS_PIPE_MODE_PREVIEW:
 		pipe->mode = IA_CSS_PIPE_ID_PREVIEW;
 		memcpy(&pipe->pipe_settings.preview, &preview, sizeof(preview));
 		break;
 	case IA_CSS_PIPE_MODE_CAPTURE:
-		if (copy_pipe) {
+		if (copy_pipe)
 			pipe->mode = IA_CSS_PIPE_ID_COPY;
-		} else {
+		else
 			pipe->mode = IA_CSS_PIPE_ID_CAPTURE;
-		}
+
 		memcpy(&pipe->pipe_settings.capture, &capture, sizeof(capture));
 		break;
 	case IA_CSS_PIPE_MODE_VIDEO:
@@ -2252,27 +2211,25 @@ pipe_global_init(void)
 	u8 i;
 
 	my_css.pipe_counter = 0;
-	for (i = 0; i < IA_CSS_PIPELINE_NUM_MAX; i++) {
+	for (i = 0; i < IA_CSS_PIPELINE_NUM_MAX; i++)
 		my_css.all_pipes[i] = NULL;
-	}
 }
 
 static int
 pipe_generate_pipe_num(const struct ia_css_pipe *pipe,
-		       unsigned int *pipe_number) {
+		       unsigned int *pipe_number)
+{
 	const u8 INVALID_PIPE_NUM = (uint8_t)~(0);
 	u8 pipe_num = INVALID_PIPE_NUM;
 	u8 i;
 
-	if (!pipe)
-	{
+	if (!pipe) {
 		IA_CSS_ERROR("NULL pipe parameter");
 		return -EINVAL;
 	}
 
 	/* Assign a new pipe_num .... search for empty place */
-	for (i = 0; i < IA_CSS_PIPELINE_NUM_MAX; i++)
-	{
+	for (i = 0; i < IA_CSS_PIPELINE_NUM_MAX; i++) {
 		if (!my_css.all_pipes[i]) {
 			/*position is reserved */
 			my_css.all_pipes[i] = (struct ia_css_pipe *)pipe;
@@ -2280,8 +2237,7 @@ pipe_generate_pipe_num(const struct ia_css_pipe *pipe,
 			break;
 		}
 	}
-	if (pipe_num == INVALID_PIPE_NUM)
-	{
+	if (pipe_num == INVALID_PIPE_NUM) {
 		/* Max number of pipes already allocated */
 		IA_CSS_ERROR("Max number of pipes already created");
 		return -ENOSPC;
-- 
2.53.0

