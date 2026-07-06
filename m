Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8984281503
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 04:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783313039; cv=none; b=nOr6SJozVlhmFPvYF0TgxTPqHMLumbUTEmCl/eG97dCEfXfFW2pk9atCDYdpRRzKF3BXU0LYB6OHdxGav8zFGtiy3e2ViQOMlbA2qYLYpUFVE/1F0r7i1xVce2HJ8kNTNWfIYx7E60dbZvLpLXEhTYUVc0yRGFDOjiMqtgHX/w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783313039; c=relaxed/simple;
	bh=vQhHfsHKOLxnYTIE/T8DRNMiXl0A8Jz5me6T1CRgnU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kDNTy0hgmyVZkU86mwgJbzYtsoENUuCaLBVDAW0orWuP8R25gqVBingaymoR19du+7bq5iK4i2BbeQTOZwAet0oeqKTeuMrsS2KMfR/UIUFFoyv6pshUhw5lv773VG6xo7t642v0HuRLXjiPSULVA85j0PmU/d5yN8ZUVtzu50Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=rsjwdHq2; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="rsjwdHq2"
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id gVogwAk4xPpWVgbBVwrJ2b; Mon, 06 Jul 2026 04:43:57 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id gbBUwZKZTLQlXgbBVw23Ku; Mon, 06 Jul 2026 04:43:57 +0000
X-Authority-Analysis: v=2.4 cv=AeWxH2XG c=1 sm=1 tr=0 ts=6a4b328d
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=7vwVE5O1G3EA:10 a=zd2uoN0lAAAA:8
 a=HaFmDPmJAAAA:8 a=5g331mcoVzyfAfNjrRgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LPl0RSE1LXpSGvQ8cLYYRFZ6+5PiIperp40zPuaUvBU=; b=rsjwdHq2LtdC7d2aQkxcqyLFUB
	/HKRx4p0U+BoAdvQAJsOCb86Ow42gDLilC8usyW/tYLc9iRs1j8dPRcCMe6nUZEVgHKTFsqHELKGt
	C8qCLDLr1wI0jBECHgEipr6rDJEFaW9NnfwpV5NjumZSekjCT2WZLaFPGp3IbanJndLcX5FVHdagY
	+/ID4W0iFK8CWNbrRaeSX2KavVpFTawAaPhYkMLaQN+IwMznKuS/jgQZmqRCEuvIp/iTJJHijFB2w
	ooA95hsdS4wHh+Q+ZvLlHxSlXjubguRkEBfz4AskC4wN4/3LXTg1njgBcTmzGesSOYfBKUWY1gcFm
	RNNQWsHw==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:54282 helo=beavis.silicon)
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wgbBU-00000003wEK-2Gd4;
	Sun, 05 Jul 2026 22:43:56 -0600
From: Ron Economos <re@w6rz.net>
To: stable@vger.kernel.org
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Ron Economos <re@w6rz.net>
Subject: [PATCH 6.6.y] drm/amd: Fix set but not used warnings
Date: Sun,  5 Jul 2026 21:42:00 -0700
Message-ID: <20260706044341.1099693-1-re@w6rz.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.206.103
X-Source-L: No
X-Exim-ID: 1wgbBU-00000003wEK-2Gd4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net (beavis.silicon) [73.162.206.103]:54282
X-Source-Auth: re@w6rz.net
X-Email-Count: 6
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPYvlRgvmsgEQtl0VwIN45VlZPTAotZDcbvIFVAqQxHBnS2USEArA91tsts+IlNL9Qyw7O8JVUP6Fxq3UDBRbymygV4dlMIEZTAe65BXzIeCWgYKGLCy
 NY2rE/RwvSNkTatpTkC0kNQDAf0Ryc473xSkx1UgI1QAVhCooSzG4i4UblNJnYgHZIE0WOcBsXgt5A==

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 46791d147d3ab3262298478106ef2a52fc7192e2 ]

There are many set but not used warnings under drivers/gpu/drm/amd when
compiling with the latest upstream mainline GCC:

  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:305:18: warning: variable ‘p’ set but not used [-Wunused-but-set-variable=]
  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h:103:26: warning: variable ‘internal_reg_offset’ set but not used [-Wunused-but-set-variable=]
  ...
  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h:164:26: warning: variable ‘internal_reg_offset’ set but not used [-Wunused-but-set-variable=]
  ...
  drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:445:13: warning: variable ‘pipe_idx’ set but not used [-Wunused-but-set-variable=]
  drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:875:21: warning: variable ‘pipe_idx’ set but not used [-Wunused-but-set-variable=]

Remove the variables actually not used or add __maybe_unused attribute for
the variables actually used to fix them, compile tested only.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Ron Economos <re@w6rz.net>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c     |  4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h      |  3 ++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 11 ++++-------
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index ea75c2b2bbb1..055aa0418a73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -299,7 +299,6 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 			int pages)
 {
 	unsigned t;
-	unsigned p;
 	int i, j;
 	u64 page_base;
 	/* Starting from VEGA10, system bit must be 0 to mean invalid. */
@@ -313,8 +312,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 		return;
 
 	t = offset / AMDGPU_GPU_PAGE_SIZE;
-	p = t / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
-	for (i = 0; i < pages; i++, p++) {
+	for (i = 0; i < pages; i++) {
 		page_base = adev->dummy_page_addr;
 		if (!adev->gart.ptr)
 			continue;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 3dc2cffdae4f..ba45e85b23f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -101,7 +101,8 @@
 
 #define SOC15_DPG_MODE_OFFSET(ip, inst_idx, reg) 						\
 	({											\
-		uint32_t internal_reg_offset, addr;						\
+		/* To avoid a -Wunused-but-set-variable warning. */				\
+		uint32_t internal_reg_offset __maybe_unused, addr;				\
 		bool video_range, video1_range, aon_range, aon1_range;				\
 												\
 		addr = (adev->reg_offset[ip##_HWIP][inst_idx][reg##_BASE_IDX] + reg);		\
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 4c5ef3ef8dbd..30a79dffbd37 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -322,7 +322,6 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 	int i = 0, k = 0;
 	int ramp_up_num_steps = 1; // TODO: Ramp is currently disabled. Reenable it.
 	uint8_t visual_confirm_enabled;
-	int pipe_idx = 0;
 
 	if (dc == NULL)
 		return false;
@@ -336,7 +335,7 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 	cmd.fw_assisted_mclk_switch.config_data.visual_confirm_enabled = visual_confirm_enabled;
 
 	if (should_manage_pstate) {
-		for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 			if (!pipe->stream)
@@ -350,7 +349,6 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 				cmd.fw_assisted_mclk_switch.config_data.vactive_stretch_margin_us = dc->debug.fpo_vactive_margin_us;
 				break;
 			}
-			pipe_idx++;
 		}
 	}
 
@@ -714,7 +712,7 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 		bool enable)
 {
 	uint8_t cmd_pipe_index = 0;
-	uint32_t i, pipe_idx;
+	uint32_t i;
 	uint8_t subvp_count = 0;
 	union dmub_rb_cmd cmd;
 	struct pipe_ctx *subvp_pipes[2];
@@ -740,7 +738,7 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 
 	if (enable) {
 		// For each pipe that is a "main" SUBVP pipe, fill in pipe data for DMUB SUBVP cmd
-		for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 			if (!pipe->stream)
@@ -763,7 +761,6 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 				populate_subvp_cmd_vblank_pipe_info(dc, context, &cmd, pipe, cmd_pipe_index++);
 
 			}
-			pipe_idx++;
 		}
 		if (subvp_count == 2) {
 			update_subvp_prefetch_end_to_mall_start(dc, context, &cmd, subvp_pipes);
@@ -1054,4 +1051,4 @@ void dc_dmub_srv_enable_dpia_trace(const struct dc *dc)
 	}
 
 	DC_LOG_DEBUG("Enabled DPIA trace\n");
-}
\ No newline at end of file
+}
-- 
2.43.0

