Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351D1281503
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 04:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783312989; cv=none; b=rd69tURcC8wzQsEVVwKu0BPSpXVrh7oCY8HhGnGhGG/EXXOE40jOJGeE0JuDk8gqQvlYNF5SKUXWO3li6AzhyLxF/rC/PuBHKGyXGrXcNCDLHEFzA7ClwGs9cwxwc3qjzUUCnjBquVaZ5Lx7IDyf/5A0peMWCWSOg4kzDJxB2eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783312989; c=relaxed/simple;
	bh=Uga8SwtBnse8nOl8WHRLRDg7luh4sHUuNAViSua3o14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YxHISRQbru9PySyw34UIYm4MN4tzD2ovdgV0ANCkVpWNQm57hOfW45nOAz+Pz52o0FtoM5pFsKCiJvTNqDb8uxje/SOIkDrwEnl83pNLj+dYxG9nBwVt6RMxfAbAvXijMTCKn+S+eJVTOv/Tgcyzaxo+t9/e+PJLLhSIwWOpzTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=YyculaLs; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="YyculaLs"
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id gQCJwA546PpWVgb99wrISv; Mon, 06 Jul 2026 04:41:32 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id gb99w5H6WtyQ7gb99w55OD; Mon, 06 Jul 2026 04:41:31 +0000
X-Authority-Analysis: v=2.4 cv=E5LNpbdl c=1 sm=1 tr=0 ts=6a4b31fb
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
	bh=PSXXCqInCKpp3mJVauWjL5wzlZte4AJdLDz/QnIw2LM=; b=YyculaLsIcqw4uRkbkhXP8j0wk
	mbjLbFteugjeNilg1MKDGdeCSQ2z3G6RUhDW8GUZoSmeGaVsXX514VavgBVeLHewRH1+/GgY1WDsk
	FHTtwn+4QFdkGMP0FYYJErYPr32PEZH271u8lXAhKw3dycPjJ4YoAw2ofYpweUARUh9krAO+e6cdg
	YZRpCzgpUl6d7UM7QJeg6bSP+ooCcY408sIq5OHQR1qeNhHZLkjyejSO+A1qoiDbJInLlPjsmbshz
	/6ttg3FkGPXbJIkjYt3rLNJYXr3IRft8t1mkek0tvdbEu60QAJD2IYBFPzpbz1jtRZyTZt5tDaEsf
	GjREp2EA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:53178 helo=beavis.silicon)
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wgb98-00000003rUl-3fux;
	Sun, 05 Jul 2026 22:41:30 -0600
From: Ron Economos <re@w6rz.net>
To: stable@vger.kernel.org
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Ron Economos <re@w6rz.net>
Subject: [PATCH 6.12.y] drm/amd: Fix set but not used warnings
Date: Sun,  5 Jul 2026 21:40:03 -0700
Message-ID: <20260706044046.1099672-1-re@w6rz.net>
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
X-Exim-ID: 1wgb98-00000003rUl-3fux
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net (beavis.silicon) [73.162.206.103]:53178
X-Source-Auth: re@w6rz.net
X-Email-Count: 3
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGPupJpKAZCqPE8XOTwd4D0uEBhGrOz8CReNPHOVzU5TM88z0m+hNnC9SCml3+u5uwWb1vMLb3DFvuKzKtHw82WxuSSSqmxEE+eCVt+xPBjc/D+20hSO
 eZlEZ6s2EnSOzqd17h6/GiD3typvcJHeun74/2x3RqzRqVH5WsQ03tRbsxWTqKw8Xyho7pQ5NP3UeA==

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c     | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h      | 6 ++++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 9 +++------
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 30b4e2c406f3..2e62dfd03c92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -307,7 +307,6 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 			int pages)
 {
 	unsigned t;
-	unsigned p;
 	int i, j;
 	u64 page_base;
 	/* Starting from VEGA10, system bit must be 0 to mean invalid. */
@@ -321,8 +320,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 		return;
 
 	t = offset / AMDGPU_GPU_PAGE_SIZE;
-	p = t / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
-	for (i = 0; i < pages; i++, p++) {
+	for (i = 0; i < pages; i++) {
 		page_base = adev->dummy_page_addr;
 		if (!adev->gart.ptr)
 			continue;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 3b6254de2c0e..d20236826e6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -100,7 +100,8 @@
 
 #define SOC15_DPG_MODE_OFFSET(ip, inst_idx, reg) 						\
 	({											\
-		uint32_t internal_reg_offset, addr;						\
+		/* To avoid a -Wunused-but-set-variable warning. */				\
+		uint32_t internal_reg_offset __maybe_unused, addr;				\
 		bool video_range, video1_range, aon_range, aon1_range;				\
 												\
 		addr = (adev->reg_offset[ip##_HWIP][inst_idx][reg##_BASE_IDX] + reg);		\
@@ -161,7 +162,8 @@
 
 #define SOC24_DPG_MODE_OFFSET(ip, inst_idx, reg)						\
 	({											\
-		uint32_t internal_reg_offset, addr;						\
+		/* To avoid a -Wunused-but-set-variable warning. */				\
+		uint32_t internal_reg_offset __maybe_unused, addr;				\
 		bool video_range, aon_range;				\
 												\
 		addr = (adev->reg_offset[ip##_HWIP][inst_idx][reg##_BASE_IDX] + reg);		\
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index ec5009f411eb..19b8d46ce848 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -428,7 +428,6 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 	int i = 0, k = 0;
 	int ramp_up_num_steps = 1; // TODO: Ramp is currently disabled. Reenable it.
 	uint8_t visual_confirm_enabled;
-	int pipe_idx = 0;
 	struct dc_stream_status *stream_status = NULL;
 
 	if (dc == NULL)
@@ -443,7 +442,7 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 	cmd.fw_assisted_mclk_switch.config_data.visual_confirm_enabled = visual_confirm_enabled;
 
 	if (should_manage_pstate) {
-		for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 			if (!pipe->stream)
@@ -458,7 +457,6 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 				cmd.fw_assisted_mclk_switch.config_data.vactive_stretch_margin_us = dc->debug.fpo_vactive_margin_us;
 				break;
 			}
-			pipe_idx++;
 		}
 	}
 
@@ -857,7 +855,7 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 		bool enable)
 {
 	uint8_t cmd_pipe_index = 0;
-	uint32_t i, pipe_idx;
+	uint32_t i;
 	uint8_t subvp_count = 0;
 	union dmub_rb_cmd cmd;
 	struct pipe_ctx *subvp_pipes[2];
@@ -884,7 +882,7 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 
 	if (enable) {
 		// For each pipe that is a "main" SUBVP pipe, fill in pipe data for DMUB SUBVP cmd
-		for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 			pipe_mall_type = dc_state_get_pipe_subvp_type(context, pipe);
 
@@ -907,7 +905,6 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 				populate_subvp_cmd_vblank_pipe_info(dc, context, &cmd, pipe, cmd_pipe_index++);
 
 			}
-			pipe_idx++;
 		}
 		if (subvp_count == 2) {
 			update_subvp_prefetch_end_to_mall_start(dc, context, &cmd, subvp_pipes);
-- 
2.43.0

