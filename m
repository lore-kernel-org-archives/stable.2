Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A714480DC4
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059327; cv=none; b=HuSQo9K8u3ny6OP3xxfDycOyBvsGSzA1ao/FZyiOMiOVl5EPm+o9hPh5gEALcRiC2TYqmv3K8Zfi0ctfkL3C9wBd6vkGOTq2CGP2WV5OUgBEf6NHqW7DKYPngOceFGRv4XcZB200jHLN2mW7tz5sKKZZHfv14lQh3gyo5Qrsze8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059327; c=relaxed/simple;
	bh=buFSbIzXroW79TMKAyVqg7uvpPafYDBZVv7N02NmEzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNm5qUy0u3dZz2ohfO0bKGIY7hMu74TDnX5u4fYnECEgtQSfKvMv8vdzhha6xW4J8EjPocc5774YmhaT18r+dGiK7bey1ExRkntN6zXz5Bvlhrg73WISlzPjoxFCFamWr6ShXUHGwQnp7IXQzdWDNSd6ppGWfNpfqsi0khVGQu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQpGWsix; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQpGWsix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB9D1F000E9;
	Tue, 14 Jul 2026 20:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059321;
	bh=MvHFTcB7dcrqYtvfumLr9TbEZw4yWxrQvLxBEpkAgO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HQpGWsixme6DhpokK8o+WelVhG3IkBMHs/RZQjOwwf0+TFXK/dh1z/jEqwJsUhZVQ
	 XD09+WI7wECX3t2eK47R7wsQdl7aMjooJvFAwSMoeZApNsE/XpkbWGeo0USCW/K0+7
	 q6rQOEP0mJGBjiImh17lFCVxuf1Bp3+/Abus0DLJtHDIWIS0PoHoA+SXvwVeeEDoY5
	 po7zp+7PKsNxcccgFYdooQDppcSZHaw8eDzvEa3omFcT59oUREs4PSAfXHTONoEIlj
	 oMRblBysv3FauQL1YskULoxO+T2RSsE5Sd5XfRU4uxCXy1ctn5MEjWCPFm2Gg3aKSQ
	 uvhrXEpKG5Y3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aditya Srivastava <yashsri421@gmail.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/6] media: atomisp: replace boolean comparison of values with bool variables
Date: Tue, 14 Jul 2026 16:01:53 -0400
Message-ID: <20260714200158.3152137-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071304-opulently-outburst-4960@gregkh>
References: <2026071304-opulently-outburst-4960@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aditya Srivastava <yashsri421@gmail.com>

[ Upstream commit c606970d4250dfb95869a563975c08bab148137a ]

There are certain expressions in a condition in atomisp, where a boolean
variable is compared with true/false in forms such as (foo == true)
or (false != bar), which does not comply with the coding style rule by
checkpatch.pl (CHK: BOOL_COMPARISON), according to which the boolean
variables should be themselves used in the condition, rather than
comparing with true or false.

E.g. In drivers/staging/media/atomisp/pci/atomisp_compat_css20.c:

if (asd->stream_prepared == false) {

Can be replaced with:
if (!asd->stream_prepared) {

Replace such expressions with boolean variables appropriately.

Link: https://lore.kernel.org/linux-media/20201214132716.28157-1-yashsri421@gmail.com
Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: f4d51e55dd47 ("staging: media: atomisp: reduce load_primary_binaries() stack usage")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../staging/media/atomisp/pci/atomisp_compat_css20.c |  2 +-
 .../atomisp/pci/runtime/isys/src/virtual_isys.c      | 12 ++++++------
 drivers/staging/media/atomisp/pci/sh_css.c           | 12 ++++++------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
index faa0935e536a57..6a80c676f6684a 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
@@ -1142,7 +1142,7 @@ int atomisp_css_start(struct atomisp_sub_device *asd,
 	 * Thus the stream created in set_fmt get destroyed and need to be
 	 * recreated in the next stream on.
 	 */
-	if (asd->stream_prepared == false) {
+	if (!asd->stream_prepared) {
 		if (__create_pipes(asd)) {
 			dev_err(isp->dev, "create pipe error.\n");
 			return -EINVAL;
diff --git a/drivers/staging/media/atomisp/pci/runtime/isys/src/virtual_isys.c b/drivers/staging/media/atomisp/pci/runtime/isys/src/virtual_isys.c
index 317ea30ede7a42..82f3c19dc4559f 100644
--- a/drivers/staging/media/atomisp/pci/runtime/isys/src/virtual_isys.c
+++ b/drivers/staging/media/atomisp/pci/runtime/isys/src/virtual_isys.c
@@ -179,12 +179,12 @@ ia_css_isys_error_t ia_css_isys_stream_create(
 	isys_stream->linked_isys_stream_id = isys_stream_descr->linked_isys_stream_id;
 	rc = create_input_system_input_port(isys_stream_descr,
 					    &isys_stream->input_port);
-	if (rc == false)
+	if (!rc)
 		return false;
 
 	rc = create_input_system_channel(isys_stream_descr, false,
 					 &isys_stream->channel);
-	if (rc == false) {
+	if (!rc) {
 		destroy_input_system_input_port(&isys_stream->input_port);
 		return false;
 	}
@@ -204,7 +204,7 @@ ia_css_isys_error_t ia_css_isys_stream_create(
 	if (isys_stream_descr->metadata.enable) {
 		rc = create_input_system_channel(isys_stream_descr, true,
 						 &isys_stream->md_channel);
-		if (rc == false) {
+		if (!rc) {
 			destroy_input_system_input_port(&isys_stream->input_port);
 			destroy_input_system_channel(&isys_stream->channel);
 			return false;
@@ -248,7 +248,7 @@ ia_css_isys_error_t ia_css_isys_stream_calculate_cfg(
 		  isys_stream_descr,
 		  &isys_stream_cfg->channel_cfg,
 		  false);
-	if (rc == false)
+	if (!rc)
 		return false;
 
 	/* configure metadata channel */
@@ -260,7 +260,7 @@ ia_css_isys_error_t ia_css_isys_stream_calculate_cfg(
 			  isys_stream_descr,
 			  &isys_stream_cfg->md_channel_cfg,
 			  true);
-		if (rc == false)
+		if (!rc)
 			return false;
 	}
 
@@ -269,7 +269,7 @@ ia_css_isys_error_t ia_css_isys_stream_calculate_cfg(
 		 &isys_stream->input_port,
 		 isys_stream_descr,
 		 &isys_stream_cfg->input_port_cfg);
-	if (rc == false)
+	if (!rc)
 		return false;
 
 	isys_stream->valid = 1;
diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
index cb03545203602a..57e5595faac4c9 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -1058,7 +1058,7 @@ sh_css_config_input_network(struct ia_css_stream *stream) {
 	ia_css_debug_dtrace(IA_CSS_DEBUG_TRACE_PRIVATE,
 			    "sh_css_config_input_network() enter 0x%p:\n", stream);
 
-	if (stream->config.continuous == true)
+	if (stream->config.continuous)
 	{
 		if (stream->last_pipe->config.mode == IA_CSS_PIPE_MODE_CAPTURE) {
 			pipe = stream->last_pipe;
@@ -5622,7 +5622,7 @@ static int load_video_binaries(struct ia_css_pipe *pipe)
 		} else {
 			/* output from main binary is not yuv line. currently this is
 			 * possible only when bci is enabled on vfpp output */
-			assert(pipe->config.enable_vfpp_bci == true);
+			assert(pipe->config.enable_vfpp_bci);
 			ia_css_pipe_get_yuvscaler_binarydesc(pipe, &vf_pp_descr,
 							     &mycs->video_binary.vf_frame_info,
 							     pipe_vf_out_info, NULL, NULL);
@@ -8068,7 +8068,7 @@ create_host_regular_capture_pipeline(struct ia_css_pipe *pipe) {
 		struct ia_css_frame *tmp_out_frame = NULL;
 
 		for (i = 0; i < num_yuv_scaler; i++) {
-			if (is_output_stage[i] == true)
+			if (is_output_stage[i])
 				tmp_out_frame = out_frame;
 			else
 				tmp_out_frame = NULL;
@@ -8460,7 +8460,7 @@ sh_css_pipeline_add_acc_stage(struct ia_css_pipeline *pipeline,
 	/* In QoS case, load_extension already called, so skipping */
 	int	err = 0;
 
-	if (fw->loaded == false)
+	if (!fw->loaded)
 		err = acc_load_extension(fw);
 
 	ia_css_debug_dtrace(IA_CSS_DEBUG_TRACE,
@@ -9697,8 +9697,8 @@ ia_css_stream_destroy(struct ia_css_stream *stream) {
 			assert(entry);
 			if (entry) {
 				/* get the SP thread id */
-				if (ia_css_pipeline_get_sp_thread_id(
-					ia_css_pipe_get_pipe_num(entry), &sp_thread_id) != true)
+				if (!ia_css_pipeline_get_sp_thread_id(
+					ia_css_pipe_get_pipe_num(entry), &sp_thread_id))
 					return -EINVAL;
 				/* get the target input terminal */
 				sp_pipeline_input_terminal =
-- 
2.53.0

