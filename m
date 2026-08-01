Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911EA34CFA1
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785600096; cv=none; b=WdpWynlEbELVTdCFKT/7jdJs38sjkbCMv8yca1mPnbpQApXRO0YXlCiNaGBRcFwFPLEKThP2v5gCVWVOGXGjUsjo3NJ6EnBjV1ItsQw5zLVpvK7PUFMvyjki8j6tIYDs+WfobXSLIoO7FhnNLQ9Z7xM2VKenNrOrFGqNPHBWxc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785600096; c=relaxed/simple;
	bh=3q2Opq7ZDzZGeFt+sW1JhmSemcoiXnDrnDJVtaO9bvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3fiedG47uc/snjpVFmLrMHNYYgu1SQaDnaHkUVNlWH3PksXJTuK3YU9RgqSA2Sh9c2/gSnpQb0wj1Ukse7vYQBhOEeEgLzfFmNn/6jDcTMWbJIlK+DpTEfv9WTd5qE4/vVw/HpLuavs4s9hQx3ekLGaTVkm7/EukdlUHe9S3t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nag24A42; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nag24A42"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D9A1F00AC4;
	Sat,  1 Aug 2026 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785600090;
	bh=UmWDDvYfIT4Q9Yz/QeNdxK1f6/LNoaHG5JMCjPxSF3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nag24A42AQ3sgyjBgkYYhXe+R+evR5FwBj6wKN1jtILjmSt1wohUWBbXalGx4xFiU
	 ntaCBMXqzBBv+rPBzizkT+BymyRkYMMyBWNNwDSJPOvPXnujkqa5SCy2JWCHdw7faS
	 +gVnx7OAgB8jC5PZMv2E4KMnriwWqU6dpltgWUvpJpXyVKt3W0I9Yar4rY+2aFOKlW
	 tDl/sP6o4Lj/5++r/DwtU/F3kWzl2q/mflKsfw/5sOG0sqipRAWFkM/DIfJSbz5oDO
	 ivh3qR9dLW7H+0y9GY1cdkG4mVZZY3UYlGlVBTW1Y+Ve37XmRpfuUyi2vsDiWqQNhA
	 0nkfnPQHu9V2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	James Lin <pinglei.lin@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/3] drm/amd/display: Fix type mismatches in DML and normalize loop bounds
Date: Sat,  1 Aug 2026 12:01:21 -0400
Message-ID: <20260801160127.1534503-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072943-starboard-brisket-7559@gregkh>
References: <2026072943-starboard-brisket-7559@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[ Upstream commit faaeeecef94ad312b051dbe628d6e3f016ba5263 ]

[Why]
Address signed/unsigned comparison warnings across DML paths
to keep builds warning-clean and improve type safety at comparison
boundaries. Most warnings came from signed loop/index temporaries compared
against unsigned counters (for example pipe_count, num_states, and
candidate/state counts), plus a small number of mixed signed/unsigned
clock and geometry checks.

[How]
Aligned iterator and temporary variable types with the semantic type
of the compared bounds. Used unsigned indices for loops bounded by unsigned
counters, and retained signed types where values are semantically signed
(for example plane_count math, timing/micro-schedule arithmetic, and
reverse/sentinel-style iteration). Where mixed signed/unsigned comparisons
are intentional, applied explicit boundary casts instead of broad type
changes (for example dispclk minimum clamp and selected timing/height
comparisons).

As a side effect of converting count parameters such as
NumberOfActivePlanes to unsigned, normalized equivalent loop forms from:

for (i = 0; i <= NumberOfActivePlanes - 1; i++)

into the normalized form:

for (i = 0; i < NumberOfActivePlanes; i++)

to keep bound style coherent and avoid avoidable mismatch patterns.

No functional behavior changes are intended; this is a warning-resolution
and type-alignment cleanup.

Assisted-by: Copilot
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 93c8fe6d5603 ("drm/amd/display: guard against overflow in HDCP message dump")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   9 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  34 +++--
 .../dc/dml/dcn20/display_mode_vba_20.c        |  36 ++---
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |  36 ++---
 .../dc/dml/dcn21/display_mode_vba_21.c        |  36 ++---
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |  14 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |  83 +++++------
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    |   5 +-
 .../amd/display/dc/dml/dcn302/dcn302_fpu.c    |   2 +-
 .../amd/display/dc/dml/dcn303/dcn303_fpu.c    |   2 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |  15 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        | 121 ++++++++--------
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   5 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      | 129 ++++++++++--------
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  75 +++++-----
 .../dc/dml/dcn32/display_mode_vba_32.c        |  21 +--
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   2 +-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |  46 +++----
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   5 +-
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |   5 +-
 .../drm/amd/display/dc/dml/display_mode_vba.c |   4 +-
 21 files changed, 366 insertions(+), 319 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
index 61553e24d53e..ad42b2e12fef 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
@@ -759,7 +759,8 @@ bool dcn_validate_bandwidth(
 
 	const struct resource_pool *pool = dc->res_pool;
 	struct dcn_bw_internal_vars *v = &context->dcn_bw_vars;
-	int i, input_idx, k;
+	unsigned int i;
+	int input_idx, k;
 	int vesa_sync_start, asic_blank_end, asic_blank_start;
 	bool bw_limit_pass;
 	float bw_limit;
@@ -1168,9 +1169,9 @@ bool dcn_validate_bandwidth(
 			context->bw_ctx.bw.dcn.clk.dispclk_khz = (int)(dc->dcn_soc->max_dispclk_vmax0p9 * 1000);
 
 		if (context->bw_ctx.bw.dcn.clk.dispclk_khz <
-				dc->debug.min_disp_clk_khz) {
+				(int)dc->debug.min_disp_clk_khz) {
 			context->bw_ctx.bw.dcn.clk.dispclk_khz =
-					dc->debug.min_disp_clk_khz;
+					(int)dc->debug.min_disp_clk_khz;
 		}
 
 		context->bw_ctx.bw.dcn.clk.dppclk_khz = context->bw_ctx.bw.dcn.clk.dispclk_khz /
@@ -1307,7 +1308,7 @@ bool dcn_validate_bandwidth(
 	PERFORMANCE_TRACE_END();
 	BW_VAL_TRACE_FINISH();
 
-	if (bw_limit_pass && v->voltage_level <= get_highest_allowed_voltage_level(dc->config.is_vmin_only_asic))
+	if (bw_limit_pass && v->voltage_level <= (int)get_highest_allowed_voltage_level(dc->config.is_vmin_only_asic))
 		return true;
 	else
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index e82f2d531211..a3e644b7a4fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -990,7 +990,8 @@ void dcn20_populate_dml_writeback_from_context(struct dc *dc,
 					       struct resource_context *res_ctx,
 					       display_e2e_pipe_params_st *pipes)
 {
-	int pipe_cnt, i;
+	unsigned int i;
+	int pipe_cnt;
 
 	dc_assert_fp_enabled();
 
@@ -1044,7 +1045,7 @@ void dcn20_fpu_set_wb_arb_params(struct mcif_arb_params *wb_arb_params,
 
 static bool is_dtbclk_required(struct dc *dc, struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
@@ -1134,7 +1135,7 @@ static void dcn20_adjust_freesync_v_startup(
 	/* The newVStartUp is 1 line before vsync point */
 	newVstartup = asic_blank_end + 1;
 
-	*vstartup_start = ((newVstartup > *vstartup_start) ? newVstartup : *vstartup_start);
+	*vstartup_start = (((int)newVstartup > *vstartup_start) ? (int)newVstartup : *vstartup_start);
 }
 
 void dcn20_calculate_dlg_params(struct dc *dc,
@@ -1143,7 +1144,8 @@ void dcn20_calculate_dlg_params(struct dc *dc,
 				int pipe_cnt,
 				int vlevel)
 {
-	int i, pipe_idx, active_hubp_count = 0;
+	int pipe_idx, active_hubp_count = 0;
+	unsigned int i;
 
 	dc_assert_fp_enabled();
 
@@ -1155,7 +1157,7 @@ void dcn20_calculate_dlg_params(struct dc *dc,
 	context->bw_ctx.bw.dcn.clk.socclk_khz = context->bw_ctx.dml.vba.SOCCLK * 1000;
 	context->bw_ctx.bw.dcn.clk.dramclk_khz = context->bw_ctx.dml.vba.DRAMSpeed * 1000 / 16;
 
-	if (dc->debug.min_dram_clk_khz > context->bw_ctx.bw.dcn.clk.dramclk_khz)
+	if ((int)dc->debug.min_dram_clk_khz > context->bw_ctx.bw.dcn.clk.dramclk_khz)
 		context->bw_ctx.bw.dcn.clk.dramclk_khz = dc->debug.min_dram_clk_khz;
 
 	context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz = context->bw_ctx.dml.vba.DCFCLKDeepSleep * 1000;
@@ -1173,8 +1175,8 @@ void dcn20_calculate_dlg_params(struct dc *dc,
 
 	context->bw_ctx.bw.dcn.clk.dtbclk_en = is_dtbclk_required(dc, context);
 
-	if (context->bw_ctx.bw.dcn.clk.dispclk_khz < dc->debug.min_disp_clk_khz)
-		context->bw_ctx.bw.dcn.clk.dispclk_khz = dc->debug.min_disp_clk_khz;
+	if ((unsigned int)context->bw_ctx.bw.dcn.clk.dispclk_khz < dc->debug.min_disp_clk_khz)
+		context->bw_ctx.bw.dcn.clk.dispclk_khz = (int)dc->debug.min_disp_clk_khz;
 
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
@@ -1317,7 +1319,8 @@ int dcn20_populate_dml_pipes_from_context(struct dc *dc,
 					  enum dc_validate_mode validate_mode)
 {
 	(void)validate_mode;
-	int pipe_cnt, i;
+	int pipe_cnt;
+	unsigned int i;
 	bool synchronized_vblank = true;
 	struct resource_context *res_ctx = &context->res_ctx;
 
@@ -1735,7 +1738,8 @@ void dcn20_calculate_wm(struct dc *dc, struct dc_state *context,
 			int vlevel,
 			enum dc_validate_mode validate_mode)
 {
-	int pipe_cnt, i, pipe_idx;
+	int pipe_cnt, pipe_idx;
+	unsigned int i;
 
 	dc_assert_fp_enabled();
 
@@ -1853,7 +1857,7 @@ void dcn20_update_bounding_box(struct dc *dc,
 {
 	int num_calculated_states = 0;
 	int min_dcfclk = 0;
-	int i;
+	unsigned int i;
 
 	dc_assert_fp_enabled();
 
@@ -1914,7 +1918,7 @@ void dcn20_update_bounding_box(struct dc *dc,
 void dcn20_cap_soc_clocks(struct _vcs_dpi_soc_bounding_box_st *bb,
 			  struct pp_smu_nv_clock_table max_clocks)
 {
-	int i;
+	unsigned int i;
 
 	dc_assert_fp_enabled();
 
@@ -2158,7 +2162,7 @@ int dcn21_populate_dml_pipes_from_context(struct dc *dc,
 					  enum dc_validate_mode validate_mode)
 {
 	uint32_t pipe_cnt;
-	int i;
+	unsigned int i;
 
 	dc_assert_fp_enabled();
 
@@ -2240,7 +2244,8 @@ static void dcn21_calculate_wm(struct dc *dc, struct dc_state *context,
 			int vlevel_req,
 			enum dc_validate_mode validate_mode)
 {
-	int pipe_cnt, i, pipe_idx;
+	int pipe_cnt, pipe_idx;
+	unsigned int i;
 	int vlevel, vlevel_max;
 	struct wm_range_table_entry *table_entry;
 	struct clk_bw_params *bw_params = dc->clk_mgr->bw_params;
@@ -2476,7 +2481,8 @@ void dcn201_populate_dml_writeback_from_context_fpu(struct dc *dc,
 						    struct resource_context *res_ctx,
 						    display_e2e_pipe_params_st *pipes)
 {
-	int pipe_cnt, i, j;
+	int pipe_cnt;
+	unsigned int i, j;
 	double max_calc_writeback_dispclk;
 	double writeback_dispclk;
 	struct writeback_st dout_wb = {0};
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index f5f636afe33c..dae762f51407 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -3288,8 +3288,8 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 {
 	struct vba_vars_st *locals = &mode_lib->vba;
 
-	int i;
-	unsigned int j, k, m;
+	int idx;
+	unsigned int i, j, k, m;
 
 	/*MODE SUPPORT, VOLTAGE STATE AND SOC CONFIGURATION*/
 
@@ -5018,7 +5018,7 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 	/*Mode Support, Voltage State and SOC Configuration*/
 
-	for (i = mode_lib->vba.soc.num_states; i >= 0; i--) {
+	for (idx = mode_lib->vba.soc.num_states; idx >= 0; idx--) {
 		for (j = 0; j < 2; j++) {
 			enum dm_validation_status status = DML_VALIDATION_OK;
 
@@ -5026,21 +5026,21 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				status = DML_FAIL_SCALE_RATIO_TAP;
 			} else if (mode_lib->vba.SourceFormatPixelAndScanSupport != true) {
 				status = DML_FAIL_SOURCE_PIXEL_FORMAT;
-			} else if (locals->ViewportSizeSupport[i][0] != true) {
+			} else if (locals->ViewportSizeSupport[idx][0] != true) {
 				status = DML_FAIL_VIEWPORT_SIZE;
-			} else if (locals->DIOSupport[i] != true) {
+			} else if (locals->DIOSupport[idx] != true) {
 				status = DML_FAIL_DIO_SUPPORT;
-			} else if (locals->NotEnoughDSCUnits[i] != false) {
+			} else if (locals->NotEnoughDSCUnits[idx] != false) {
 				status = DML_FAIL_NOT_ENOUGH_DSC;
-			} else if (locals->DSCCLKRequiredMoreThanSupported[i] != false) {
+			} else if (locals->DSCCLKRequiredMoreThanSupported[idx] != false) {
 				status = DML_FAIL_DSC_CLK_REQUIRED;
-			} else if (locals->UrgentLatencySupport[i][j] != true) {
+			} else if (locals->UrgentLatencySupport[idx][j] != true) {
 				status = DML_FAIL_URGENT_LATENCY;
-			} else if (locals->ROBSupport[i][0] != true) {
+			} else if (locals->ROBSupport[idx][0] != true) {
 				status = DML_FAIL_REORDERING_BUFFER;
-			} else if (locals->DISPCLK_DPPCLK_Support[i][j] != true) {
+			} else if (locals->DISPCLK_DPPCLK_Support[idx][j] != true) {
 				status = DML_FAIL_DISPCLK_DPPCLK;
-			} else if (locals->TotalAvailablePipesSupport[i][j] != true) {
+			} else if (locals->TotalAvailablePipesSupport[idx][j] != true) {
 				status = DML_FAIL_TOTAL_AVAILABLE_PIPES;
 			} else if (mode_lib->vba.NumberOfOTGSupport != true) {
 				status = DML_FAIL_NUM_OTG;
@@ -5054,24 +5054,24 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				status = DML_FAIL_CURSOR_SUPPORT;
 			} else if (mode_lib->vba.PitchSupport != true) {
 				status = DML_FAIL_PITCH_SUPPORT;
-			} else if (locals->PrefetchSupported[i][j] != true) {
+			} else if (locals->PrefetchSupported[idx][j] != true) {
 				status = DML_FAIL_PREFETCH_SUPPORT;
-			} else if (locals->TotalVerticalActiveBandwidthSupport[i][0] != true) {
+			} else if (locals->TotalVerticalActiveBandwidthSupport[idx][0] != true) {
 				status = DML_FAIL_TOTAL_V_ACTIVE_BW;
-			} else if (locals->VRatioInPrefetchSupported[i][j] != true) {
+			} else if (locals->VRatioInPrefetchSupported[idx][j] != true) {
 				status = DML_FAIL_V_RATIO_PREFETCH;
-			} else if (locals->PTEBufferSizeNotExceeded[i][j] != true) {
+			} else if (locals->PTEBufferSizeNotExceeded[idx][j] != true) {
 				status = DML_FAIL_PTE_BUFFER_SIZE;
 			} else if (mode_lib->vba.NonsupportedDSCInputBPC != false) {
 				status = DML_FAIL_DSC_INPUT_BPC;
 			}
 
 			if (status == DML_VALIDATION_OK) {
-				locals->ModeSupport[i][j] = true;
+				locals->ModeSupport[idx][j] = true;
 			} else {
-				locals->ModeSupport[i][j] = false;
+				locals->ModeSupport[idx][j] = false;
 			}
-			locals->ValidationStatus[i] = status;
+			locals->ValidationStatus[idx] = status;
 		}
 	}
 	{
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 95b0a3501880..f7dc33f056d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -3396,8 +3396,8 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 {
 	struct vba_vars_st *locals = &mode_lib->vba;
 
-	int i;
-	unsigned int j, k, m;
+	int idx;
+	unsigned int i, j, k, m;
 
 	/*MODE SUPPORT, VOLTAGE STATE AND SOC CONFIGURATION*/
 
@@ -5135,7 +5135,7 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 	}
 	/*Mode Support, Voltage State and SOC Configuration*/
 
-	for (i = mode_lib->vba.soc.num_states; i >= 0; i--) {
+	for (idx = mode_lib->vba.soc.num_states; idx >= 0; idx--) {
 		for (j = 0; j < 2; j++) {
 			enum dm_validation_status status = DML_VALIDATION_OK;
 
@@ -5143,21 +5143,21 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 				status = DML_FAIL_SCALE_RATIO_TAP;
 			} else if (mode_lib->vba.SourceFormatPixelAndScanSupport != true) {
 				status = DML_FAIL_SOURCE_PIXEL_FORMAT;
-			} else if (locals->ViewportSizeSupport[i][0] != true) {
+			} else if (locals->ViewportSizeSupport[idx][0] != true) {
 				status = DML_FAIL_VIEWPORT_SIZE;
-			} else if (locals->DIOSupport[i] != true) {
+			} else if (locals->DIOSupport[idx] != true) {
 				status = DML_FAIL_DIO_SUPPORT;
-			} else if (locals->NotEnoughDSCUnits[i] != false) {
+			} else if (locals->NotEnoughDSCUnits[idx] != false) {
 				status = DML_FAIL_NOT_ENOUGH_DSC;
-			} else if (locals->DSCCLKRequiredMoreThanSupported[i] != false) {
+			} else if (locals->DSCCLKRequiredMoreThanSupported[idx] != false) {
 				status = DML_FAIL_DSC_CLK_REQUIRED;
-			} else if (locals->UrgentLatencySupport[i][j] != true) {
+			} else if (locals->UrgentLatencySupport[idx][j] != true) {
 				status = DML_FAIL_URGENT_LATENCY;
-			} else if (locals->ROBSupport[i][0] != true) {
+			} else if (locals->ROBSupport[idx][0] != true) {
 				status = DML_FAIL_REORDERING_BUFFER;
-			} else if (locals->DISPCLK_DPPCLK_Support[i][j] != true) {
+			} else if (locals->DISPCLK_DPPCLK_Support[idx][j] != true) {
 				status = DML_FAIL_DISPCLK_DPPCLK;
-			} else if (locals->TotalAvailablePipesSupport[i][j] != true) {
+			} else if (locals->TotalAvailablePipesSupport[idx][j] != true) {
 				status = DML_FAIL_TOTAL_AVAILABLE_PIPES;
 			} else if (mode_lib->vba.NumberOfOTGSupport != true) {
 				status = DML_FAIL_NUM_OTG;
@@ -5171,24 +5171,24 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 				status = DML_FAIL_CURSOR_SUPPORT;
 			} else if (mode_lib->vba.PitchSupport != true) {
 				status = DML_FAIL_PITCH_SUPPORT;
-			} else if (locals->PrefetchSupported[i][j] != true) {
+			} else if (locals->PrefetchSupported[idx][j] != true) {
 				status = DML_FAIL_PREFETCH_SUPPORT;
-			} else if (locals->TotalVerticalActiveBandwidthSupport[i][0] != true) {
+			} else if (locals->TotalVerticalActiveBandwidthSupport[idx][0] != true) {
 				status = DML_FAIL_TOTAL_V_ACTIVE_BW;
-			} else if (locals->VRatioInPrefetchSupported[i][j] != true) {
+			} else if (locals->VRatioInPrefetchSupported[idx][j] != true) {
 				status = DML_FAIL_V_RATIO_PREFETCH;
-			} else if (locals->PTEBufferSizeNotExceeded[i][j] != true) {
+			} else if (locals->PTEBufferSizeNotExceeded[idx][j] != true) {
 				status = DML_FAIL_PTE_BUFFER_SIZE;
 			} else if (mode_lib->vba.NonsupportedDSCInputBPC != false) {
 				status = DML_FAIL_DSC_INPUT_BPC;
 			}
 
 			if (status == DML_VALIDATION_OK) {
-				locals->ModeSupport[i][j] = true;
+				locals->ModeSupport[idx][j] = true;
 			} else {
-				locals->ModeSupport[i][j] = false;
+				locals->ModeSupport[idx][j] = false;
 			}
-			locals->ValidationStatus[i] = status;
+			locals->ValidationStatus[idx] = status;
 		}
 	}
 	{
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index 11570a0c9427..31679c2332ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -3525,8 +3525,8 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 {
 	struct vba_vars_st *locals = &mode_lib->vba;
 
-	int i;
-	unsigned int j, k, m;
+	int idx;
+	unsigned int i, j, k, m;
 
 	/*MODE SUPPORT, VOLTAGE STATE AND SOC CONFIGURATION*/
 
@@ -5138,7 +5138,7 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 	/*Mode Support, Voltage State and SOC Configuration*/
 
-	for (i = mode_lib->vba.soc.num_states; i >= 0; i--) {
+	for (idx = mode_lib->vba.soc.num_states; idx >= 0; idx--) {
 		for (j = 0; j < 2; j++) {
 			enum dm_validation_status status = DML_VALIDATION_OK;
 
@@ -5146,19 +5146,19 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				status = DML_FAIL_SCALE_RATIO_TAP;
 			} else if (!mode_lib->vba.SourceFormatPixelAndScanSupport) {
 				status = DML_FAIL_SOURCE_PIXEL_FORMAT;
-			} else if (!locals->ViewportSizeSupport[i][0]) {
+			} else if (!locals->ViewportSizeSupport[idx][0]) {
 				status = DML_FAIL_VIEWPORT_SIZE;
-			} else if (!locals->DIOSupport[i]) {
+			} else if (!locals->DIOSupport[idx]) {
 				status = DML_FAIL_DIO_SUPPORT;
-			} else if (locals->NotEnoughDSCUnits[i]) {
+			} else if (locals->NotEnoughDSCUnits[idx]) {
 				status = DML_FAIL_NOT_ENOUGH_DSC;
-			} else if (locals->DSCCLKRequiredMoreThanSupported[i]) {
+			} else if (locals->DSCCLKRequiredMoreThanSupported[idx]) {
 				status = DML_FAIL_DSC_CLK_REQUIRED;
-			} else if (!locals->ROBSupport[i][0]) {
+			} else if (!locals->ROBSupport[idx][0]) {
 				status = DML_FAIL_REORDERING_BUFFER;
-			} else if (!locals->DISPCLK_DPPCLK_Support[i][j]) {
+			} else if (!locals->DISPCLK_DPPCLK_Support[idx][j]) {
 				status = DML_FAIL_DISPCLK_DPPCLK;
-			} else if (!locals->TotalAvailablePipesSupport[i][j]) {
+			} else if (!locals->TotalAvailablePipesSupport[idx][j]) {
 				status = DML_FAIL_TOTAL_AVAILABLE_PIPES;
 			} else if (!mode_lib->vba.NumberOfOTGSupport) {
 				status = DML_FAIL_NUM_OTG;
@@ -5172,27 +5172,27 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				status = DML_FAIL_CURSOR_SUPPORT;
 			} else if (!mode_lib->vba.PitchSupport) {
 				status = DML_FAIL_PITCH_SUPPORT;
-			} else if (!locals->TotalVerticalActiveBandwidthSupport[i][0]) {
+			} else if (!locals->TotalVerticalActiveBandwidthSupport[idx][0]) {
 				status = DML_FAIL_TOTAL_V_ACTIVE_BW;
-			} else if (!locals->PTEBufferSizeNotExceeded[i][j]) {
+			} else if (!locals->PTEBufferSizeNotExceeded[idx][j]) {
 				status = DML_FAIL_PTE_BUFFER_SIZE;
 			} else if (mode_lib->vba.NonsupportedDSCInputBPC) {
 				status = DML_FAIL_DSC_INPUT_BPC;
 			} else if ((mode_lib->vba.HostVMEnable
-					&& !locals->ImmediateFlipSupportedForState[i][j])) {
+					&& !locals->ImmediateFlipSupportedForState[idx][j])) {
 				status = DML_FAIL_HOST_VM_IMMEDIATE_FLIP;
-			} else if (!locals->PrefetchSupported[i][j]) {
+			} else if (!locals->PrefetchSupported[idx][j]) {
 				status = DML_FAIL_PREFETCH_SUPPORT;
-			} else if (!locals->VRatioInPrefetchSupported[i][j]) {
+			} else if (!locals->VRatioInPrefetchSupported[idx][j]) {
 				status = DML_FAIL_V_RATIO_PREFETCH;
 			}
 
 			if (status == DML_VALIDATION_OK) {
-				locals->ModeSupport[i][j] = true;
+				locals->ModeSupport[idx][j] = true;
 			} else {
-				locals->ModeSupport[i][j] = false;
+				locals->ModeSupport[idx][j] = false;
 			}
-			locals->ValidationStatus[i] = status;
+			locals->ValidationStatus[idx] = status;
 		}
 	}
 	{
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index 0cdd60869ce1..dcb71e7c90e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -181,7 +181,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_0_soc = {
 void dcn30_fpu_populate_dml_writeback_from_context(
 		struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
 {
-	int pipe_cnt, i, j;
+	int pipe_cnt;
+	unsigned int i, j;
 	double max_calc_writeback_dispclk;
 	double writeback_dispclk;
 	struct writeback_st dout_wb = {0};
@@ -308,6 +309,7 @@ void dcn30_fpu_calculate_wm_and_dlg(
 {
 	int maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
 	int i, pipe_idx;
+	unsigned int pipe_i, state_i;
 	double dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][maxMpcComb];
 	bool pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] != dm_dram_clock_change_unsupported;
 	unsigned int dummy_latency_index = 0;
@@ -475,8 +477,8 @@ void dcn30_fpu_calculate_wm_and_dlg(
 	/* Make set D = set A until set D is enabled */
 	context->bw_ctx.bw.dcn.watermarks.d = context->bw_ctx.bw.dcn.watermarks.a;
 
-	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
-		if (!context->res_ctx.pipe_ctx[i].stream)
+	for (pipe_i = 0, pipe_idx = 0; pipe_i < dc->res_pool->pipe_count; pipe_i++) {
+		if (!context->res_ctx.pipe_ctx[pipe_i].stream)
 			continue;
 
 		pipes[pipe_idx].clks_cfg.dispclk_mhz = get_dispclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt);
@@ -500,9 +502,9 @@ void dcn30_fpu_calculate_wm_and_dlg(
 			context->bw_ctx.dml.vba.DRAMSpeed <= 1700 &&
 			context->bw_ctx.dml.vba.DRAMSpeed >= 1500) {
 
-		for (i = 0; i < dc->dml.soc.num_states; i++) {
-			if (dc->dml.soc.clock_limits[i].dram_speed_mts > 1700) {
-				context->bw_ctx.dml.vba.DRAMSpeed = dc->dml.soc.clock_limits[i].dram_speed_mts;
+		for (state_i = 0; state_i < dc->dml.soc.num_states; state_i++) {
+			if (dc->dml.soc.clock_limits[state_i].dram_speed_mts > 1700) {
+				context->bw_ctx.dml.vba.DRAMSpeed = dc->dml.soc.clock_limits[state_i].dram_speed_mts;
 				break;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 634982173190..e201ff5dd7e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -366,7 +366,7 @@ static void CalculatePixelDeliveryTimes(
 		double CursorRequestDeliveryTimePrefetch[]);
 
 static void CalculateMetaAndPTETimes(
-		int NumberOfActivePlanes,
+		unsigned int NumberOfActivePlanes,
 		bool GPUVMEnable,
 		int MetaChunkSize,
 		int MinMetaChunkSizeBytes,
@@ -439,7 +439,7 @@ static void CalculateVMGroupAndRequestTimes(
 		double TimePerVMRequestFlip[]);
 
 static void CalculateStutterEfficiency(
-		int NumberOfActivePlanes,
+		unsigned int NumberOfActivePlanes,
 		long ROBBufferSizeInKByte,
 		double TotalDataReadBandwidth,
 		double DCFCLK,
@@ -479,7 +479,7 @@ static void CalculateStutterEfficiency(
 
 static void CalculateSwathAndDETConfiguration(
 		bool ForceSingleDPP,
-		int NumberOfActivePlanes,
+		unsigned int NumberOfActivePlanes,
 		unsigned int DETBufferSizeInKByte,
 		double MaximumSwathWidthLuma[],
 		double MaximumSwathWidthChroma[],
@@ -518,7 +518,7 @@ static void CalculateSwathAndDETConfiguration(
 		bool *ViewportSizeSupport);
 static void CalculateSwathWidth(
 		bool ForceSingleDPP,
-		int NumberOfActivePlanes,
+		unsigned int NumberOfActivePlanes,
 		enum source_format_class SourcePixelFormat[],
 		enum scan_direction_class SourceScan[],
 		unsigned int ViewportWidth[],
@@ -572,7 +572,7 @@ static double CalculateExtraLatencyBytes(
 		int MetaChunkSize,
 		bool GPUVMEnable,
 		bool HostVMEnable,
-		int NumberOfActivePlanes,
+		unsigned int NumberOfActivePlanes,
 		int NumberOfDPP[],
 		int dpte_group_bytes[],
 		double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData,
@@ -1335,11 +1335,12 @@ static void CalculateDCCConfiguration(
 	max_vp_horz_width = dml_min((double) MAS_vp_horz_limit, detile_buf_vp_horz_limit);
 	max_vp_vert_height = dml_min((double) MAS_vp_vert_limit, detile_buf_vp_vert_limit);
 	eff_surf_width_l =
-			(SurfaceWidthLuma > max_vp_horz_width ? max_vp_horz_width : SurfaceWidthLuma);
+			(SurfaceWidthLuma > (unsigned long)max_vp_horz_width ?
+			(unsigned long)max_vp_horz_width : SurfaceWidthLuma);
 	eff_surf_width_c = eff_surf_width_l / (1 + yuv420);
 	eff_surf_height_l = (
-			SurfaceHeightLuma > max_vp_vert_height ?
-					max_vp_vert_height : SurfaceHeightLuma);
+			SurfaceHeightLuma > (unsigned long)max_vp_vert_height ?
+					(unsigned long)max_vp_vert_height : SurfaceHeightLuma);
 	eff_surf_height_c = eff_surf_height_l / (1 + yuv420);
 
 	full_swath_bytes_horz_wc_l = eff_surf_width_l * RequestHeight256ByteLuma * BytePerPixelY;
@@ -3381,8 +3382,8 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 {
 	struct vba_vars_st *v = &mode_lib->vba;
 	int MinPrefetchMode, MaxPrefetchMode;
-	int i, start_state;
-	unsigned int j, k, m;
+	int idx, start_state;
+	unsigned int i, j, k, m;
 	bool   EnoughWritebackUnits = true;
 	bool   WritebackModeSupport = true;
 	bool   ViewportExceedsSurface = false;
@@ -4913,33 +4914,39 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 	/*Mode Support, Voltage State and SOC Configuration*/
 
-	for (i = v->soc.num_states - 1; i >= start_state; i--) {
+	for (idx = v->soc.num_states - 1; idx >= start_state; idx--) {
 		for (j = 0; j < 2; j++) {
-			if (v->ScaleRatioAndTapsSupport == 1 && v->SourceFormatPixelAndScanSupport == 1 && v->ViewportSizeSupport[i][j] == 1
-					&& v->DIOSupport[i] == 1 && v->ODMCombine4To1SupportCheckOK[i] == 1
-					&& v->NotEnoughDSCUnits[i] == 0
-					&& v->DTBCLKRequiredMoreThanSupported[i] == 0
-					&& v->ROBSupport[i][j] == 1 && v->DISPCLK_DPPCLK_Support[i][j] == 1 && v->TotalAvailablePipesSupport[i][j] == 1
+			if (v->ScaleRatioAndTapsSupport == 1 && v->SourceFormatPixelAndScanSupport == 1
+					&& v->ViewportSizeSupport[idx][j] == 1
+					&& v->DIOSupport[idx] == 1 && v->ODMCombine4To1SupportCheckOK[idx] == 1
+					&& v->NotEnoughDSCUnits[idx] == 0
+					&& v->DTBCLKRequiredMoreThanSupported[idx] == 0
+					&& v->ROBSupport[idx][j] == 1 && v->DISPCLK_DPPCLK_Support[idx][j] == 1
+					&& v->TotalAvailablePipesSupport[idx][j] == 1
 					&& EnoughWritebackUnits == 1 && WritebackModeSupport == 1
-					&& v->WritebackLatencySupport == 1 && v->WritebackScaleRatioAndTapsSupport == 1 && v->CursorSupport == 1 && v->PitchSupport == 1
-					&& ViewportExceedsSurface == 0 && v->PrefetchSupported[i][j] == 1 && v->DynamicMetadataSupported[i][j] == 1
-					&& v->TotalVerticalActiveBandwidthSupport[i][j] == 1 && v->VRatioInPrefetchSupported[i][j] == 1
-					&& v->PTEBufferSizeNotExceeded[i][j] == 1 && v->NonsupportedDSCInputBPC == 0
+					&& v->WritebackLatencySupport == 1 && v->WritebackScaleRatioAndTapsSupport == 1
+					&& v->CursorSupport == 1 && v->PitchSupport == 1
+					&& ViewportExceedsSurface == 0 && v->PrefetchSupported[idx][j] == 1
+					&& v->DynamicMetadataSupported[idx][j] == 1
+					&& v->TotalVerticalActiveBandwidthSupport[idx][j] == 1
+					&& v->VRatioInPrefetchSupported[idx][j] == 1
+					&& v->PTEBufferSizeNotExceeded[idx][j] == 1 && v->NonsupportedDSCInputBPC == 0
 					&& ((v->HostVMEnable == 0 && v->ImmediateFlipRequirement[0] != dm_immediate_flip_required)
-							|| v->ImmediateFlipSupportedForState[i][j] == true)) {
-				v->ModeSupport[i][j] = true;
+							|| v->ImmediateFlipSupportedForState[idx][j] == true)) {
+				v->ModeSupport[idx][j] = true;
 			} else {
-				v->ModeSupport[i][j] = false;
+				v->ModeSupport[idx][j] = false;
 			}
 		}
 	}
 	{
 		unsigned int MaximumMPCCombine = 0;
-		for (i = v->soc.num_states; i >= start_state; i--) {
-			if (i == v->soc.num_states || v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true) {
-				v->VoltageLevel = i;
-				v->ModeIsSupported = v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true;
-				if (v->ModeSupport[i][1] == true) {
+		for (idx = v->soc.num_states; idx >= start_state; idx--) {
+			if (idx == (int)v->soc.num_states || v->ModeSupport[idx][0] == true
+					|| v->ModeSupport[idx][1] == true) {
+				v->VoltageLevel = idx;
+				v->ModeIsSupported = v->ModeSupport[idx][0] == true || v->ModeSupport[idx][1] == true;
+				if (v->ModeSupport[idx][1] == true) {
 					MaximumMPCCombine = 1;
 				} else {
 					MaximumMPCCombine = 0;
@@ -5400,7 +5407,7 @@ static void CalculatePixelDeliveryTimes(
 }
 
 static void CalculateMetaAndPTETimes(
-		int NumberOfActivePlanes,
+		unsigned int NumberOfActivePlanes,
 		bool GPUVMEnable,
 		int MetaChunkSize,
 		int MinMetaChunkSizeBytes,
@@ -5686,7 +5693,7 @@ static void CalculateVMGroupAndRequestTimes(
 }
 
 static void CalculateStutterEfficiency(
-		int NumberOfActivePlanes,
+		unsigned int NumberOfActivePlanes,
 		long ROBBufferSizeInKByte,
 		double TotalDataReadBandwidth,
 		double DCFCLK,
@@ -5840,7 +5847,7 @@ static void CalculateStutterEfficiency(
 
 static void CalculateSwathAndDETConfiguration(
 		bool ForceSingleDPP,
-		int NumberOfActivePlanes,
+		unsigned int NumberOfActivePlanes,
 		unsigned int DETBufferSizeInKByte,
 		double MaximumSwathWidthLuma[],
 		double MaximumSwathWidthChroma[],
@@ -5891,7 +5898,7 @@ static void CalculateSwathAndDETConfiguration(
 	long RoundedUpSwathSizeBytesC = 0;
 	double SwathWidthSingleDPP[DC__NUM_DPP__MAX] = { 0 };
 	double SwathWidthSingleDPPChroma[DC__NUM_DPP__MAX] = { 0 };
-	int k;
+	unsigned int k;
 
 	CalculateSwathWidth(
 			ForceSingleDPP,
@@ -5980,21 +5987,21 @@ static void CalculateSwathAndDETConfiguration(
 		}
 
 		if (RoundedUpMaxSwathSizeBytesY + RoundedUpMaxSwathSizeBytesC
-				<= DETBufferSizeInKByte * 1024 / 2) {
+				<= (long)DETBufferSizeInKByte * 1024 / 2) {
 			SwathHeightY[k] = MaximumSwathHeightY[k];
 			SwathHeightC[k] = MaximumSwathHeightC[k];
 			RoundedUpSwathSizeBytesY = RoundedUpMaxSwathSizeBytesY;
 			RoundedUpSwathSizeBytesC = RoundedUpMaxSwathSizeBytesC;
 		} else if (RoundedUpMaxSwathSizeBytesY >= 1.5 * RoundedUpMaxSwathSizeBytesC
 				&& RoundedUpMinSwathSizeBytesY + RoundedUpMaxSwathSizeBytesC
-						<= DETBufferSizeInKByte * 1024 / 2) {
+						<= (long)DETBufferSizeInKByte * 1024 / 2) {
 			SwathHeightY[k] = MinimumSwathHeightY;
 			SwathHeightC[k] = MaximumSwathHeightC[k];
 			RoundedUpSwathSizeBytesY = RoundedUpMinSwathSizeBytesY;
 			RoundedUpSwathSizeBytesC = RoundedUpMaxSwathSizeBytesC;
 		} else if (RoundedUpMaxSwathSizeBytesY < 1.5 * RoundedUpMaxSwathSizeBytesC
 				&& RoundedUpMaxSwathSizeBytesY + RoundedUpMinSwathSizeBytesC
-						<= DETBufferSizeInKByte * 1024 / 2) {
+						<= (long)DETBufferSizeInKByte * 1024 / 2) {
 			SwathHeightY[k] = MaximumSwathHeightY[k];
 			SwathHeightC[k] = MinimumSwathHeightC;
 			RoundedUpSwathSizeBytesY = RoundedUpMaxSwathSizeBytesY;
@@ -6018,7 +6025,7 @@ static void CalculateSwathAndDETConfiguration(
 		}
 
 		if (RoundedUpMinSwathSizeBytesY + RoundedUpMinSwathSizeBytesC
-				> DETBufferSizeInKByte * 1024 / 2
+				> (long)DETBufferSizeInKByte * 1024 / 2
 				|| SwathWidth[k] > MaximumSwathWidthLuma[k]
 				|| (SwathHeightC[k] > 0
 						&& SwathWidthChroma[k] > MaximumSwathWidthChroma[k])) {
@@ -6032,7 +6039,7 @@ static void CalculateSwathAndDETConfiguration(
 
 static void CalculateSwathWidth(
 		bool ForceSingleDPP,
-		int NumberOfActivePlanes,
+		unsigned int NumberOfActivePlanes,
 		enum source_format_class SourcePixelFormat[],
 		enum scan_direction_class SourceScan[],
 		unsigned int ViewportWidth[],
@@ -6185,7 +6192,7 @@ static double CalculateExtraLatencyBytes(
 		int MetaChunkSize,
 		bool GPUVMEnable,
 		bool HostVMEnable,
-		int NumberOfActivePlanes,
+		unsigned int NumberOfActivePlanes,
 		int NumberOfDPP[],
 		int dpte_group_bytes[],
 		double PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
index 1aaa77265eed..57898dc17fa3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
@@ -326,7 +326,8 @@ void dcn301_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_p
 	struct dcn301_resource_pool *pool = TO_DCN301_RES_POOL(dc->res_pool);
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
 	unsigned int i, closest_clk_lvl;
-	int j = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0;
+	int j = 0;
+	unsigned int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
 
 	dc_assert_fp_enabled();
 
@@ -429,7 +430,7 @@ void dcn301_fpu_calculate_wm_and_dlg(struct dc *dc,
 		int pipe_cnt,
 		int vlevel_req)
 {
-	int i, pipe_idx;
+	unsigned int i, pipe_idx;
 	int vlevel, vlevel_max;
 	struct wm_range_table_entry *table_entry;
 	struct clk_bw_params *bw_params = dc->clk_mgr->bw_params;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c
index 8d7c59ec701d..a00d1b466790 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c
@@ -218,7 +218,7 @@ void dcn302_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_p
 	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 
 	if (bw_params->clk_table.entries[0].memclk_mhz) {
-		int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0, max_phyclk_mhz = 0;
+		unsigned int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0, max_phyclk_mhz = 0;
 
 		for (i = 0; i < MAX_NUM_DPM_LVL; i++) {
 			if (bw_params->clk_table.entries[i].dcfclk_mhz > max_dcfclk_mhz)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
index b5d3fd4c3694..6318b4e4a6f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
@@ -214,7 +214,7 @@ void dcn303_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_p
 	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 
 	if (bw_params->clk_table.entries[0].memclk_mhz) {
-		int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0, max_phyclk_mhz = 0;
+		unsigned int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0, max_phyclk_mhz = 0;
 
 		for (i = 0; i < MAX_NUM_DPM_LVL; i++) {
 			if (bw_params->clk_table.entries[i].dcfclk_mhz > max_dcfclk_mhz)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index ad23215da9f8..f702ba90962d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -485,9 +485,12 @@ void dcn31_calculate_wm_and_dlg_fp(
 		int pipe_cnt,
 		int vlevel)
 {
-	int i, pipe_idx, total_det = 0, active_hubp_count = 0;
+	int total_det = 0, active_hubp_count = 0;
+	unsigned int i, pipe_idx;
 	double dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
 	uint32_t cstate_enter_plus_exit_z8_ns;
+	uint32_t minimum_z8_residency_time_ns =
+			(uint32_t)dc->debug.minimum_z8_residency_time * 1000U;
 
 	dc_assert_fp_enabled();
 
@@ -511,8 +514,8 @@ void dcn31_calculate_wm_and_dlg_fp(
 		get_wm_z8_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 
 	if (get_stutter_period(&context->bw_ctx.dml, pipes, pipe_cnt) < dc->debug.minimum_z8_residency_time &&
-			cstate_enter_plus_exit_z8_ns < dc->debug.minimum_z8_residency_time * 1000)
-		cstate_enter_plus_exit_z8_ns = dc->debug.minimum_z8_residency_time * 1000;
+				cstate_enter_plus_exit_z8_ns < minimum_z8_residency_time_ns)
+		cstate_enter_plus_exit_z8_ns = minimum_z8_residency_time_ns;
 
 	/* Set A:
 	 * All clocks min required
@@ -592,7 +595,7 @@ void dcn31_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
 	struct _vcs_dpi_voltage_scaling_st *s = dc->scratch.update_bw_bounding_box.clock_limits;
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
 	unsigned int i, closest_clk_lvl;
-	int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
+	unsigned int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
 	int j;
 
 	dc_assert_fp_enabled();
@@ -668,7 +671,7 @@ void dcn31_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
 void dcn315_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params)
 {
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
-	int i, max_dispclk_mhz = 0, max_dppclk_mhz = 0;
+	unsigned int i, max_dispclk_mhz = 0, max_dppclk_mhz = 0;
 
 	dc_assert_fp_enabled();
 
@@ -731,7 +734,7 @@ void dcn316_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 	struct _vcs_dpi_voltage_scaling_st *s = dc->scratch.update_bw_bounding_box.clock_limits;
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
 	unsigned int i, closest_clk_lvl;
-	int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
+	unsigned int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
 	int j;
 
 	dc_assert_fp_enabled();
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 9833467722b9..fe0f89288336 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -1510,10 +1510,10 @@ static void CalculateDCCConfiguration(
 	double detile_buf_vp_horz_limit;
 	double detile_buf_vp_vert_limit;
 
-	int MAS_vp_horz_limit;
-	int MAS_vp_vert_limit;
-	int max_vp_horz_width;
-	int max_vp_vert_height;
+	unsigned int MAS_vp_horz_limit;
+	unsigned int MAS_vp_vert_limit;
+	unsigned int max_vp_horz_width;
+	unsigned int max_vp_vert_height;
 	int eff_surf_width_l;
 	int eff_surf_width_c;
 	int eff_surf_height_l;
@@ -3785,7 +3785,8 @@ static noinline void CalculatePrefetchSchedulePerPlane(
 
 static void PatchDETBufferSizeInKByte(unsigned int NumberOfActivePlanes, int NoOfDPPThisState[], unsigned int config_return_buffer_size_in_kbytes, unsigned int DETBufferSizeInKByte[])
 {
-	int i, total_pipes = 0;
+	int total_pipes = 0;
+	unsigned int i;
 	for (i = 0; i < NumberOfActivePlanes; i++)
 		total_pipes += NoOfDPPThisState[i];
 	DETBufferSizeInKByte[0] = ((config_return_buffer_size_in_kbytes - DCN3_15_MIN_COMPBUF_SIZE_KB) / 64 / total_pipes) * 64;
@@ -3800,8 +3801,8 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 {
 	struct vba_vars_st *v = &mode_lib->vba;
 
-	int i, j;
-	unsigned int k, m;
+	int idx;
+	unsigned int i, j, k, m;
 	int ReorderingBytes;
 	int MinPrefetchMode = 0, MaxPrefetchMode = 2;
 	bool NoChroma = true;
@@ -5451,46 +5452,53 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 
 	/*Mode Support, Voltage State and SOC Configuration*/
-	for (i = v->soc.num_states - 1; i >= 0; i--) {
+	for (idx = (int)v->soc.num_states - 1; idx >= 0; idx--) {
 		for (j = 0; j < 2; j++) {
-			if (v->ScaleRatioAndTapsSupport == true && v->SourceFormatPixelAndScanSupport == true && v->ViewportSizeSupport[i][j] == true
-					&& v->LinkCapacitySupport[i] == true && !P2IWith420 && !DSCOnlyIfNecessaryWithBPP
-					&& !DSC422NativeNotSupported && v->ODMCombine4To1SupportCheckOK[i] == true && v->NotEnoughDSCUnits[i] == false
-					&& v->DTBCLKRequiredMoreThanSupported[i] == false
-					&& v->ROBSupport[i][j] == true && v->DISPCLK_DPPCLK_Support[i][j] == true
-					&& v->TotalAvailablePipesSupport[i][j] == true && EnoughWritebackUnits == true
+			if (v->ScaleRatioAndTapsSupport == true && v->SourceFormatPixelAndScanSupport == true
+					&& v->ViewportSizeSupport[idx][j] == true
+					&& v->LinkCapacitySupport[idx] == true && !P2IWith420
+					&& !DSCOnlyIfNecessaryWithBPP
+					&& !DSC422NativeNotSupported && v->ODMCombine4To1SupportCheckOK[idx] == true
+					&& v->NotEnoughDSCUnits[idx] == false
+					&& v->DTBCLKRequiredMoreThanSupported[idx] == false
+					&& v->ROBSupport[idx][j] == true && v->DISPCLK_DPPCLK_Support[idx][j] == true
+					&& v->TotalAvailablePipesSupport[idx][j] == true && EnoughWritebackUnits == true
 					&& v->WritebackLatencySupport == true && v->WritebackScaleRatioAndTapsSupport == true
-					&& v->CursorSupport == true && v->PitchSupport == true && ViewportExceedsSurface == false
-					&& v->PrefetchSupported[i][j] == true && v->DynamicMetadataSupported[i][j] == true
-					&& v->TotalVerticalActiveBandwidthSupport[i][j] == true && v->VRatioInPrefetchSupported[i][j] == true
-					&& v->PTEBufferSizeNotExceeded[i][j] == true && v->NonsupportedDSCInputBPC == false
+					&& v->CursorSupport == true && v->PitchSupport == true
+					&& ViewportExceedsSurface == false
+					&& v->PrefetchSupported[idx][j] == true
+					&& v->DynamicMetadataSupported[idx][j] == true
+					&& v->TotalVerticalActiveBandwidthSupport[idx][j] == true
+					&& v->VRatioInPrefetchSupported[idx][j] == true
+					&& v->PTEBufferSizeNotExceeded[idx][j] == true
+					&& v->NonsupportedDSCInputBPC == false
 					&& ((v->HostVMEnable == false
 					&& v->ImmediateFlipRequirement[0] != dm_immediate_flip_required)
-							|| v->ImmediateFlipSupportedForState[i][j] == true)
+							|| v->ImmediateFlipSupportedForState[idx][j] == true)
 					&& FMTBufferExceeded == false) {
-				v->ModeSupport[i][j] = true;
+				v->ModeSupport[idx][j] = true;
 			} else {
-				v->ModeSupport[i][j] = false;
+				v->ModeSupport[idx][j] = false;
 #ifdef __DML_VBA_DEBUG__
 				if (v->ScaleRatioAndTapsSupport == false)
 					dml_print("DML SUPPORT:     ScaleRatioAndTapsSupport failed");
 				if (v->SourceFormatPixelAndScanSupport == false)
 					dml_print("DML SUPPORT:     SourceFormatPixelAndScanSupport failed");
-				if (v->ViewportSizeSupport[i][j] == false)
+				if (v->ViewportSizeSupport[idx][j] == false)
 					dml_print("DML SUPPORT:     ViewportSizeSupport failed");
-				if (v->LinkCapacitySupport[i] == false)
+				if (v->LinkCapacitySupport[idx] == false)
 					dml_print("DML SUPPORT:     LinkCapacitySupport failed");
-				if (v->ODMCombine4To1SupportCheckOK[i] == false)
+				if (v->ODMCombine4To1SupportCheckOK[idx] == false)
 					dml_print("DML SUPPORT:     DSC422NativeNotSupported failed");
-				if (v->NotEnoughDSCUnits[i] == true)
+				if (v->NotEnoughDSCUnits[idx] == true)
 					dml_print("DML SUPPORT:     NotEnoughDSCUnits");
-				if (v->DTBCLKRequiredMoreThanSupported[i] == true)
+				if (v->DTBCLKRequiredMoreThanSupported[idx] == true)
 					dml_print("DML SUPPORT:     DTBCLKRequiredMoreThanSupported");
-				if (v->ROBSupport[i][j] == false)
+				if (v->ROBSupport[idx][j] == false)
 					dml_print("DML SUPPORT:     ROBSupport failed");
-				if (v->DISPCLK_DPPCLK_Support[i][j] == false)
+				if (v->DISPCLK_DPPCLK_Support[idx][j] == false)
 					dml_print("DML SUPPORT:     DISPCLK_DPPCLK_Support failed");
-				if (v->TotalAvailablePipesSupport[i][j] == false)
+				if (v->TotalAvailablePipesSupport[idx][j] == false)
 					dml_print("DML SUPPORT:     DSC422NativeNotSupported failed");
 				if (EnoughWritebackUnits == false)
 					dml_print("DML SUPPORT:     DSC422NativeNotSupported failed");
@@ -5504,21 +5512,21 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					dml_print("DML SUPPORT:     PitchSupport failed");
 				if (ViewportExceedsSurface == true)
 					dml_print("DML SUPPORT:     ViewportExceedsSurface failed");
-				if (v->PrefetchSupported[i][j] == false)
+				if (v->PrefetchSupported[idx][j] == false)
 					dml_print("DML SUPPORT:     PrefetchSupported failed");
-				if (v->DynamicMetadataSupported[i][j] == false)
+				if (v->DynamicMetadataSupported[idx][j] == false)
 					dml_print("DML SUPPORT:     DSC422NativeNotSupported failed");
-				if (v->TotalVerticalActiveBandwidthSupport[i][j] == false)
+				if (v->TotalVerticalActiveBandwidthSupport[idx][j] == false)
 					dml_print("DML SUPPORT:     TotalVerticalActiveBandwidthSupport failed");
-				if (v->VRatioInPrefetchSupported[i][j] == false)
+				if (v->VRatioInPrefetchSupported[idx][j] == false)
 					dml_print("DML SUPPORT:     VRatioInPrefetchSupported failed");
-				if (v->PTEBufferSizeNotExceeded[i][j] == false)
+				if (v->PTEBufferSizeNotExceeded[idx][j] == false)
 					dml_print("DML SUPPORT:     PTEBufferSizeNotExceeded failed");
 				if (v->NonsupportedDSCInputBPC == true)
 					dml_print("DML SUPPORT:     NonsupportedDSCInputBPC failed");
 				if (!((v->HostVMEnable == false
 					&& v->ImmediateFlipRequirement[0] != dm_immediate_flip_required)
-							|| v->ImmediateFlipSupportedForState[i][j] == true))
+							|| v->ImmediateFlipSupportedForState[idx][j] == true))
 					dml_print("DML SUPPORT:     ImmediateFlipRequirement failed");
 				if (FMTBufferExceeded == true)
 					dml_print("DML SUPPORT:     FMTBufferExceeded failed");
@@ -5529,11 +5537,12 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	{
 		unsigned int MaximumMPCCombine = 0;
-		for (i = v->soc.num_states; i >= 0; i--) {
-			if (i == v->soc.num_states || v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true) {
-				v->VoltageLevel = i;
-				v->ModeIsSupported = v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true;
-				if (v->ModeSupport[i][0] == true) {
+		for (idx = (int)v->soc.num_states; idx >= 0; idx--) {
+			if (idx == (int)v->soc.num_states || v->ModeSupport[idx][0] == true
+					|| v->ModeSupport[idx][1] == true) {
+				v->VoltageLevel = idx;
+				v->ModeIsSupported = v->ModeSupport[idx][0] == true || v->ModeSupport[idx][1] == true;
+				if (v->ModeSupport[idx][0] == true) {
 					MaximumMPCCombine = 0;
 				} else {
 					MaximumMPCCombine = 1;
@@ -5541,7 +5550,7 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			}
 		}
 		v->ImmediateFlipSupport = v->ImmediateFlipSupportedForState[v->VoltageLevel][MaximumMPCCombine];
-		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
+		for (k = 0; k < v->NumberOfActivePlanes; k++) {
 			v->MPCCombineEnable[k] = v->MPCCombine[v->VoltageLevel][MaximumMPCCombine][k];
 			v->DPPPerPlane[k] = v->NoOfDPP[v->VoltageLevel][MaximumMPCCombine][k];
 		}
@@ -5599,7 +5608,7 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 	double SecondMinActiveDRAMClockChangeMarginOneDisplayInVBLank;
 	double WritebackDRAMClockChangeLatencyHiding;
 	double TotalPixelBW = 0.0;
-	int k, j;
+	unsigned int k, j;
 
 	v->UrgentWatermark = UrgentLatency + ExtraLatency;
 
@@ -5787,7 +5796,7 @@ static void CalculateDCFCLKDeepSleep(
 	double DisplayPipeLineDeliveryTimeLuma;
 	double DisplayPipeLineDeliveryTimeChroma;
 	double ReadBandwidth = 0.0;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < NumberOfActivePlanes; ++k) {
 
@@ -5938,7 +5947,7 @@ static void CalculatePixelDeliveryTimes(
 		double CursorRequestDeliveryTimePrefetch[])
 {
 	double req_per_swath_ub;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < NumberOfActivePlanes; ++k) {
 		if (VRatio[k] <= 1) {
@@ -6235,7 +6244,7 @@ static void CalculateVMGroupAndRequestTimes(
 	(void)dpte_row_width_chroma_ub;
 	int num_group_per_lower_vm_stage;
 	int num_req_per_lower_vm_stage;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < NumberOfActivePlanes; ++k) {
 		if (GPUVMEnable == true && (DCCEnable[k] == true || GPUVMMaxPageTableLevels > 1)) {
@@ -6676,12 +6685,12 @@ static void CalculateSwathAndDETConfiguration(
 	int MaximumSwathHeightC[DC__NUM_DPP__MAX];
 	int MinimumSwathHeightY;
 	int MinimumSwathHeightC;
-	int RoundedUpMaxSwathSizeBytesY;
-	int RoundedUpMaxSwathSizeBytesC;
-	int RoundedUpMinSwathSizeBytesY;
-	int RoundedUpMinSwathSizeBytesC;
-	int RoundedUpSwathSizeBytesY;
-	int RoundedUpSwathSizeBytesC;
+	unsigned int RoundedUpMaxSwathSizeBytesY;
+	unsigned int RoundedUpMaxSwathSizeBytesC;
+	unsigned int RoundedUpMinSwathSizeBytesY;
+	unsigned int RoundedUpMinSwathSizeBytesC;
+	unsigned int RoundedUpSwathSizeBytesY;
+	unsigned int RoundedUpSwathSizeBytesC;
 	double SwathWidthSingleDPP[DC__NUM_DPP__MAX];
 	double SwathWidthSingleDPPChroma[DC__NUM_DPP__MAX];
 	int k;
@@ -7052,7 +7061,9 @@ static noinline_for_stack void UseMinimumDCFCLK(
 		int ReorderingBytes)
 {
 	struct vba_vars_st *v = &mode_lib->vba;
-	int dummy1, i, j, k;
+	int dummy1;
+	unsigned int j, k;
+	unsigned int i;
 	double NormalEfficiency,  dummy2, dummy3;
 	double TotalMaxPrefetchFlipDPTERowBandwidth[DC__VOLTAGE_STATES][2];
 
@@ -7079,9 +7090,8 @@ static noinline_for_stack void UseMinimumDCFCLK(
 						+ v->NoOfDPP[i][j][k] * v->DPTEBytesPerRow[i][j][k] / (15.75 * v->HTotal[k] / v->PixelClock[k]);
 			}
 
-			for (k = 0; k <= v->NumberOfActivePlanes - 1; ++k) {
+			for (k = 0; k < v->NumberOfActivePlanes; ++k)
 				NoOfDPPState[k] = v->NoOfDPP[i][j][k];
-			}
 
 			MinimumTWait = CalculateTWait(MaxPrefetchMode, v->FinalDRAMClockChangeLatency, v->UrgLatency[i], v->SREnterPlusExitTime);
 			NonDPTEBandwidth = v->TotalVActivePixelBandwidth[i][j] + v->TotalVActiveCursorBandwidth[i][j] + v->TotalMetaRowBandwidth[i][j];
@@ -7182,9 +7192,8 @@ static noinline_for_stack void UseMinimumDCFCLK(
 				}
 			}
 			DCFCLKRequiredForPeakBandwidth = 0;
-			for (k = 0; k <= v->NumberOfActivePlanes - 1; ++k) {
+			for (k = 0; k < v->NumberOfActivePlanes; ++k)
 				DCFCLKRequiredForPeakBandwidth = DCFCLKRequiredForPeakBandwidth + DCFCLKRequiredForPeakBandwidthPerPlane[k];
-			}
 			MinimumTvmPlus2Tr0 = v->UrgLatency[i]
 					* (v->GPUVMEnable == true ?
 							(v->HostVMEnable == true ?
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index ab016c294ba7..ada055024229 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -185,7 +185,7 @@ void dcn314_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 	struct _vcs_dpi_voltage_scaling_st *clock_limits =
 		dcn3_14_soc.clock_limits;
 	unsigned int i, closest_clk_lvl;
-	int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
+	unsigned int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
 	int j;
 
 	dc_assert_fp_enabled();
@@ -308,7 +308,8 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 					       display_e2e_pipe_params_st *pipes,
 					       enum dc_validate_mode validate_mode)
 {
-	int i, pipe_cnt;
+	int pipe_cnt;
+	unsigned int i;
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe = 0;
 	bool upscaled = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 033fde774337..0fd149d000f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -407,7 +407,7 @@ static void CalculatePixelDeliveryTimes(
 		double CursorRequestDeliveryTimePrefetch[]);
 
 static void CalculateMetaAndPTETimes(
-		int NumberOfActivePlanes,
+		unsigned int NumberOfActivePlanes,
 		bool GPUVMEnable,
 		int MetaChunkSize,
 		int MinMetaChunkSizeBytes,
@@ -1527,14 +1527,14 @@ static void CalculateDCCConfiguration(
 	double detile_buf_vp_horz_limit;
 	double detile_buf_vp_vert_limit;
 
-	int MAS_vp_horz_limit;
-	int MAS_vp_vert_limit;
-	int max_vp_horz_width;
-	int max_vp_vert_height;
-	int eff_surf_width_l;
-	int eff_surf_width_c;
-	int eff_surf_height_l;
-	int eff_surf_height_c;
+	unsigned int MAS_vp_horz_limit;
+	unsigned int MAS_vp_vert_limit;
+	unsigned int max_vp_horz_width;
+	unsigned int max_vp_vert_height;
+	unsigned int eff_surf_width_l;
+	unsigned int eff_surf_width_c;
+	unsigned int eff_surf_height_l;
+	unsigned int eff_surf_height_c;
 
 	int full_swath_bytes_horz_wc_l;
 	int full_swath_bytes_horz_wc_c;
@@ -3893,7 +3893,8 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 {
 	struct vba_vars_st *v = &mode_lib->vba;
 
-	int i, j;
+	int j;
+	unsigned int i;
 	unsigned int k, m;
 	int ReorderingBytes;
 	int MinPrefetchMode = 0, MaxPrefetchMode = 2;
@@ -5537,30 +5538,37 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 	}
 
 	/*Mode Support, Voltage State and SOC Configuration*/
-	for (i = v->soc.num_states - 1; i >= 0; i--) {
+	for (int idx = (int)v->soc.num_states - 1; idx >= 0; idx--) {
 		for (j = 0; j < 2; j++) {
-			if (v->ScaleRatioAndTapsSupport == true && v->SourceFormatPixelAndScanSupport == true && v->ViewportSizeSupport[i][j] == true
-					&& v->LinkCapacitySupport[i] == true && !P2IWith420 && !DSCOnlyIfNecessaryWithBPP
-					&& !DSC422NativeNotSupported && v->ODMCombine4To1SupportCheckOK[i] == true && v->NotEnoughDSCUnits[i] == false
-					&& v->DTBCLKRequiredMoreThanSupported[i] == false
-					&& v->ROBSupport[i][j] == true && v->DISPCLK_DPPCLK_Support[i][j] == true
-					&& v->TotalAvailablePipesSupport[i][j] == true && EnoughWritebackUnits == true
+			if (v->ScaleRatioAndTapsSupport == true && v->SourceFormatPixelAndScanSupport == true
+					&& v->ViewportSizeSupport[idx][j] == true
+					&& v->LinkCapacitySupport[idx] == true && !P2IWith420
+					&& !DSCOnlyIfNecessaryWithBPP
+					&& !DSC422NativeNotSupported && v->ODMCombine4To1SupportCheckOK[idx] == true
+					&& v->NotEnoughDSCUnits[idx] == false
+					&& v->DTBCLKRequiredMoreThanSupported[idx] == false
+					&& v->ROBSupport[idx][j] == true && v->DISPCLK_DPPCLK_Support[idx][j] == true
+					&& v->TotalAvailablePipesSupport[idx][j] == true && EnoughWritebackUnits == true
 					&& v->WritebackLatencySupport == true && v->WritebackScaleRatioAndTapsSupport == true
-					&& v->CursorSupport == true && v->PitchSupport == true && ViewportExceedsSurface == false
-					&& v->PrefetchSupported[i][j] == true && v->DynamicMetadataSupported[i][j] == true
-					&& v->TotalVerticalActiveBandwidthSupport[i][j] == true && v->VRatioInPrefetchSupported[i][j] == true
-					&& v->PTEBufferSizeNotExceeded[i][j] == true && v->NonsupportedDSCInputBPC == false
+					&& v->CursorSupport == true && v->PitchSupport == true
+					&& ViewportExceedsSurface == false
+					&& v->PrefetchSupported[idx][j] == true
+					&& v->DynamicMetadataSupported[idx][j] == true
+					&& v->TotalVerticalActiveBandwidthSupport[idx][j] == true
+					&& v->VRatioInPrefetchSupported[idx][j] == true
+					&& v->PTEBufferSizeNotExceeded[idx][j] == true
+					&& v->NonsupportedDSCInputBPC == false
 					&& ((v->HostVMEnable == false
 					&& v->ImmediateFlipRequirement[0] != dm_immediate_flip_required)
-							|| v->ImmediateFlipSupportedForState[i][j] == true)
+							|| v->ImmediateFlipSupportedForState[idx][j] == true)
 					&& FMTBufferExceeded == false) {
-				v->ModeSupport[i][j] = true;
+				v->ModeSupport[idx][j] = true;
 			} else {
-				v->ModeSupport[i][j] = false;
+				v->ModeSupport[idx][j] = false;
 			}
 		}
 	}
-	for (i = v->soc.num_states; i >= 0; i--) {
+	for (int idx = (int)v->soc.num_states; idx >= 0; idx--) {
 		for (j = 0; j < 2; j++) {
 			enum dm_validation_status status = DML_VALIDATION_OK;
 
@@ -5568,7 +5576,7 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 				status = DML_FAIL_SCALE_RATIO_TAP;
 			} else if (!v->SourceFormatPixelAndScanSupport) {
 				status = DML_FAIL_SOURCE_PIXEL_FORMAT;
-			} else if (!v->ViewportSizeSupport[i][j]) {
+			} else if (!v->ViewportSizeSupport[idx][j]) {
 				status = DML_FAIL_VIEWPORT_SIZE;
 			} else if (P2IWith420) {
 				status = DML_FAIL_P2I_WITH_420;
@@ -5576,15 +5584,15 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 				status = DML_FAIL_DSC_ONLY_IF_NECESSARY_WITH_BPP;
 			} else if (DSC422NativeNotSupported) {
 				status = DML_FAIL_NOT_DSC422_NATIVE;
-			} else if (!v->ODMCombine4To1SupportCheckOK[i]) {
+			} else if (!v->ODMCombine4To1SupportCheckOK[idx]) {
 				status = DML_FAIL_ODM_COMBINE4TO1;
-			} else if (v->NotEnoughDSCUnits[i]) {
+			} else if (v->NotEnoughDSCUnits[idx]) {
 				status = DML_FAIL_NOT_ENOUGH_DSC;
-			} else if (!v->ROBSupport[i][j]) {
+			} else if (!v->ROBSupport[idx][j]) {
 				status = DML_FAIL_REORDERING_BUFFER;
-			} else if (!v->DISPCLK_DPPCLK_Support[i][j]) {
+			} else if (!v->DISPCLK_DPPCLK_Support[idx][j]) {
 				status = DML_FAIL_DISPCLK_DPPCLK;
-			} else if (!v->TotalAvailablePipesSupport[i][j]) {
+			} else if (!v->TotalAvailablePipesSupport[idx][j]) {
 				status = DML_FAIL_TOTAL_AVAILABLE_PIPES;
 			} else if (!EnoughWritebackUnits) {
 				status = DML_FAIL_ENOUGH_WRITEBACK_UNITS;
@@ -5598,36 +5606,36 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 				status = DML_FAIL_PITCH_SUPPORT;
 			} else if (ViewportExceedsSurface) {
 				status = DML_FAIL_VIEWPORT_EXCEEDS_SURFACE;
-			} else if (!v->PrefetchSupported[i][j]) {
+			} else if (!v->PrefetchSupported[idx][j]) {
 				status = DML_FAIL_PREFETCH_SUPPORT;
-			} else if (!v->DynamicMetadataSupported[i][j]) {
+			} else if (!v->DynamicMetadataSupported[idx][j]) {
 				status = DML_FAIL_DYNAMIC_METADATA;
-			} else if (!v->TotalVerticalActiveBandwidthSupport[i][j]) {
+			} else if (!v->TotalVerticalActiveBandwidthSupport[idx][j]) {
 				status = DML_FAIL_TOTAL_V_ACTIVE_BW;
-			} else if (!v->VRatioInPrefetchSupported[i][j]) {
+			} else if (!v->VRatioInPrefetchSupported[idx][j]) {
 				status = DML_FAIL_V_RATIO_PREFETCH;
-			} else if (!v->PTEBufferSizeNotExceeded[i][j]) {
+			} else if (!v->PTEBufferSizeNotExceeded[idx][j]) {
 				status = DML_FAIL_PTE_BUFFER_SIZE;
 			} else if (v->NonsupportedDSCInputBPC) {
 				status = DML_FAIL_DSC_INPUT_BPC;
 			} else if ((v->HostVMEnable
-					&& !v->ImmediateFlipSupportedForState[i][j])) {
+					&& !v->ImmediateFlipSupportedForState[idx][j])) {
 				status = DML_FAIL_HOST_VM_IMMEDIATE_FLIP;
 			} else if (FMTBufferExceeded) {
 				status = DML_FAIL_FMT_BUFFER_EXCEEDED;
 			}
-			mode_lib->vba.ValidationStatus[i] = status;
+			mode_lib->vba.ValidationStatus[idx] = status;
 		}
 	}
 
 	{
 		unsigned int MaximumMPCCombine = 0;
-
-		for (i = v->soc.num_states; i >= 0; i--) {
-			if (i == v->soc.num_states || v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true) {
-				v->VoltageLevel = i;
-				v->ModeIsSupported = v->ModeSupport[i][0] == true || v->ModeSupport[i][1] == true;
-				if (v->ModeSupport[i][0] == true) {
+		for (int idx = (int)v->soc.num_states; idx >= 0; idx--) {
+			if (idx == (int)v->soc.num_states || v->ModeSupport[idx][0] == true
+					|| v->ModeSupport[idx][1] == true) {
+				v->VoltageLevel = idx;
+				v->ModeIsSupported = v->ModeSupport[idx][0] == true || v->ModeSupport[idx][1] == true;
+				if (v->ModeSupport[idx][0] == true) {
 					MaximumMPCCombine = 0;
 				} else {
 					MaximumMPCCombine = 1;
@@ -5635,7 +5643,7 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 			}
 		}
 		v->ImmediateFlipSupport = v->ImmediateFlipSupportedForState[v->VoltageLevel][MaximumMPCCombine];
-		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
+		for (k = 0; k < v->NumberOfActivePlanes; k++) {
 			v->MPCCombineEnable[k] = v->MPCCombine[v->VoltageLevel][MaximumMPCCombine][k];
 			v->DPPPerPlane[k] = v->NoOfDPP[v->VoltageLevel][MaximumMPCCombine][k];
 		}
@@ -5693,7 +5701,7 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 	double SecondMinActiveDRAMClockChangeMarginOneDisplayInVBLank;
 	double WritebackDRAMClockChangeLatencyHiding;
 	double TotalPixelBW = 0.0;
-	int k, j;
+	unsigned int k, j;
 
 	v->UrgentWatermark = UrgentLatency + ExtraLatency;
 
@@ -5881,7 +5889,7 @@ static void CalculateDCFCLKDeepSleep(
 	double DisplayPipeLineDeliveryTimeLuma;
 	double DisplayPipeLineDeliveryTimeChroma;
 	double ReadBandwidth = 0.0;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < NumberOfActivePlanes; ++k) {
 
@@ -6032,7 +6040,7 @@ static void CalculatePixelDeliveryTimes(
 		double CursorRequestDeliveryTimePrefetch[])
 {
 	double req_per_swath_ub;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < NumberOfActivePlanes; ++k) {
 		if (VRatio[k] <= 1) {
@@ -6132,7 +6140,7 @@ static void CalculatePixelDeliveryTimes(
 }
 
 static void CalculateMetaAndPTETimes(
-		int NumberOfActivePlanes,
+		unsigned int NumberOfActivePlanes,
 		bool GPUVMEnable,
 		int MetaChunkSize,
 		int MinMetaChunkSizeBytes,
@@ -6198,7 +6206,7 @@ static void CalculateMetaAndPTETimes(
 	unsigned int dpte_groups_per_row_luma_ub;
 	unsigned int dpte_group_width_chroma;
 	unsigned int dpte_groups_per_row_chroma_ub;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < NumberOfActivePlanes; ++k) {
 		DST_Y_PER_PTE_ROW_NOM_L[k] = dpte_row_height[k] / VRatio[k];
@@ -6330,7 +6338,7 @@ static void CalculateVMGroupAndRequestTimes(
 	(void)dpte_row_width_chroma_ub;
 	int num_group_per_lower_vm_stage;
 	int num_req_per_lower_vm_stage;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < NumberOfActivePlanes; ++k) {
 		if (GPUVMEnable == true && (DCCEnable[k] == true || GPUVMMaxPageTableLevels > 1)) {
@@ -6770,12 +6778,12 @@ static void CalculateSwathAndDETConfiguration(
 	int MaximumSwathHeightC[DC__NUM_DPP__MAX];
 	int MinimumSwathHeightY;
 	int MinimumSwathHeightC;
-	int RoundedUpMaxSwathSizeBytesY;
-	int RoundedUpMaxSwathSizeBytesC;
-	int RoundedUpMinSwathSizeBytesY;
-	int RoundedUpMinSwathSizeBytesC;
-	int RoundedUpSwathSizeBytesY;
-	int RoundedUpSwathSizeBytesC;
+	unsigned int RoundedUpMaxSwathSizeBytesY;
+	unsigned int RoundedUpMaxSwathSizeBytesC;
+	unsigned int RoundedUpMinSwathSizeBytesY;
+	unsigned int RoundedUpMinSwathSizeBytesC;
+	unsigned int RoundedUpSwathSizeBytesY;
+	unsigned int RoundedUpSwathSizeBytesC;
 	double SwathWidthSingleDPP[DC__NUM_DPP__MAX];
 	double SwathWidthSingleDPPChroma[DC__NUM_DPP__MAX];
 	int k;
@@ -7139,7 +7147,8 @@ static noinline_for_stack void UseMinimumDCFCLK(
 		int ReorderingBytes)
 {
 	struct vba_vars_st *v = &mode_lib->vba;
-	int dummy1, i, j, k;
+	int dummy1, j;
+	unsigned int i, k;
 	double NormalEfficiency,  dummy2, dummy3;
 	double TotalMaxPrefetchFlipDPTERowBandwidth[DC__VOLTAGE_STATES][2];
 
@@ -7166,7 +7175,7 @@ static noinline_for_stack void UseMinimumDCFCLK(
 						+ v->NoOfDPP[i][j][k] * v->DPTEBytesPerRow[i][j][k] / (15.75 * v->HTotal[k] / v->PixelClock[k]);
 			}
 
-			for (k = 0; k <= v->NumberOfActivePlanes - 1; ++k)
+			for (k = 0; k < v->NumberOfActivePlanes; ++k)
 				NoOfDPPState[k] = v->NoOfDPP[i][j][k];
 
 			MinimumTWait = CalculateTWait(MaxPrefetchMode, v->FinalDRAMClockChangeLatency, v->UrgLatency[i], v->SREnterPlusExitTime);
@@ -7269,7 +7278,7 @@ static noinline_for_stack void UseMinimumDCFCLK(
 				}
 			}
 			DCFCLKRequiredForPeakBandwidth = 0;
-			for (k = 0; k <= v->NumberOfActivePlanes - 1; ++k)
+			for (k = 0; k < v->NumberOfActivePlanes; ++k)
 				DCFCLKRequiredForPeakBandwidth = DCFCLKRequiredForPeakBandwidth + DCFCLKRequiredForPeakBandwidthPerPlane[k];
 
 			MinimumTvmPlus2Tr0 = v->UrgLatency[i]
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index eb199215d298..b3b59401e98d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -297,7 +297,7 @@ int dcn32_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
 				dcn32_subvp_in_use(dc, context))
 			vba->DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] = temp_clock_change_support;
 
-		if (vlevel < context->bw_ctx.dml.vba.soc.num_states &&
+		if (vlevel < (int)context->bw_ctx.dml.vba.soc.num_states &&
 				vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] != dm_dram_clock_change_unsupported)
 			break;
 
@@ -418,8 +418,8 @@ static void insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scaling_st *t
 				    unsigned int *num_entries,
 				    struct _vcs_dpi_voltage_scaling_st *entry)
 {
-	int i = 0;
-	int index = 0;
+	unsigned int i = 0;
+	unsigned int index = 0;
 
 	dc_assert_fp_enabled();
 
@@ -773,8 +773,8 @@ static bool subvp_subvp_schedulable(struct dc *dc, struct dc_state *context)
 			subvp_pipes[1]->stream->timing.h_total) /
 			(double)(subvp_pipes[1]->stream->timing.pix_clk_100hz * 100)) * 1000000;
 
-	if ((vactive1_us - vblank2_us) / 2 > max_microschedule_us &&
-	    (vactive2_us - vblank1_us) / 2 > max_microschedule_us)
+	if ((vactive1_us - vblank2_us) / 2 > (int32_t)max_microschedule_us &&
+	    (vactive2_us - vblank1_us) / 2 > (int32_t)max_microschedule_us)
 		return true;
 
 	return false;
@@ -1013,8 +1013,8 @@ static bool subvp_subvp_admissable(struct dc *dc,
 	}
 
 	if (subvp_count == 2 && ((min_refresh < 120 && max_refresh < 120) ||
-		(min_refresh >= subvp_high_refresh_list.min_refresh &&
-				max_refresh <= subvp_high_refresh_list.max_refresh)))
+		(min_refresh >= (uint32_t)subvp_high_refresh_list.min_refresh &&
+				max_refresh <= (uint32_t)subvp_high_refresh_list.max_refresh)))
 		result = true;
 
 	return result;
@@ -1092,7 +1092,7 @@ static bool subvp_validate_static_schedulability(struct dc *dc,
 
 static void assign_subvp_index(struct dc *dc, struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 	int index = 0;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -1224,7 +1224,8 @@ static bool update_pipe_slice_table_with_split_flags(
 	 */
 	struct pipe_ctx *pipe;
 	bool odm;
-	int dc_pipe_idx, dml_pipe_idx = 0;
+	unsigned int dc_pipe_idx;
+	int dml_pipe_idx = 0;
 	bool updated = false;
 
 	for (dc_pipe_idx = 0;
@@ -1466,7 +1467,7 @@ static bool dcn32_full_validate_bw_helper(struct dc *dc,
 
 	*vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, *pipe_cnt);
 	/* This may adjust vlevel and maxMpcComb */
-	if (*vlevel < context->bw_ctx.dml.soc.num_states) {
+	if (*vlevel < (int)context->bw_ctx.dml.soc.num_states) {
 		*vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, *vlevel, split, merge);
 		vba->VoltageLevel = *vlevel;
 	}
@@ -1527,14 +1528,14 @@ static bool dcn32_full_validate_bw_helper(struct dc *dc,
 			/* Check that vlevel requested supports pstate or not
 			 * if not, select the lowest vlevel that supports it
 			 */
-			for (i = *vlevel; i < context->bw_ctx.dml.soc.num_states; i++) {
+			for (i = *vlevel; i < (int)context->bw_ctx.dml.soc.num_states; i++) {
 				if (vba->DRAMClockChangeSupport[i][vba->maxMpcComb] != dm_dram_clock_change_unsupported) {
 					*vlevel = i;
 					break;
 				}
 			}
 
-			if (*vlevel < context->bw_ctx.dml.soc.num_states
+			if (*vlevel < (int)context->bw_ctx.dml.soc.num_states
 			    && subvp_validate_static_schedulability(dc, context, *vlevel))
 				found_supported_config = true;
 			if (found_supported_config) {
@@ -1566,7 +1567,7 @@ static bool dcn32_full_validate_bw_helper(struct dc *dc,
 
 			*vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, *pipe_cnt);
 			/* This may adjust vlevel and maxMpcComb */
-			if (*vlevel < context->bw_ctx.dml.soc.num_states) {
+			if (*vlevel < (int)context->bw_ctx.dml.soc.num_states) {
 				*vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, *vlevel, split, merge);
 				vba->VoltageLevel = *vlevel;
 			}
@@ -1599,7 +1600,7 @@ static bool dcn32_full_validate_bw_helper(struct dc *dc,
 
 static bool is_dtbclk_required(struct dc *dc, struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
@@ -1614,7 +1615,8 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 				       display_e2e_pipe_params_st *pipes,
 				       int pipe_cnt, int vlevel)
 {
-	int i, pipe_idx, active_hubp_count = 0;
+	int pipe_idx, active_hubp_count = 0;
+	unsigned int i;
 	bool usr_retraining_support = false;
 	bool unbounded_req_enabled = false;
 	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
@@ -1650,8 +1652,8 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 	usr_retraining_support = context->bw_ctx.dml.vba.USRRetrainingSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
 	ASSERT(usr_retraining_support);
 
-	if (context->bw_ctx.bw.dcn.clk.dispclk_khz < dc->debug.min_disp_clk_khz)
-		context->bw_ctx.bw.dcn.clk.dispclk_khz = dc->debug.min_disp_clk_khz;
+	if ((unsigned int)context->bw_ctx.bw.dcn.clk.dispclk_khz < dc->debug.min_disp_clk_khz)
+		context->bw_ctx.bw.dcn.clk.dispclk_khz = (int)dc->debug.min_disp_clk_khz;
 
 	unbounded_req_enabled = get_unbounded_request_enabled(&context->bw_ctx.dml, pipes, pipe_cnt);
 
@@ -1904,7 +1906,8 @@ static bool dcn32_apply_merge_split_flags_helper(
 		int *split,
 		bool *merge)
 {
-	int i, pipe_idx;
+	int pipe_idx;
+	unsigned int i;
 	bool newly_split[MAX_PIPES] = { false };
 	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
 
@@ -2165,7 +2168,7 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 
 		context->bw_ctx.dml.validate_max_state = false;
 
-		if (vlevel < context->bw_ctx.dml.soc.num_states) {
+		if (vlevel < (int)context->bw_ctx.dml.soc.num_states) {
 			memset(split, 0, sizeof(split));
 			memset(merge, 0, sizeof(merge));
 			vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
@@ -2179,7 +2182,7 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 	if (vlevel == context->bw_ctx.dml.soc.num_states)
 		goto validate_fail;
 
-	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+	for (i = 0, pipe_idx = 0; i < (int)dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 		struct pipe_ctx *mpo_pipe = pipe->bottom_pipe;
 
@@ -2233,7 +2236,7 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 				flag_max_mpc_comb != context->bw_ctx.dml.vba.maxMpcComb) {
 			/* check the context constructed with pipe split flags is still valid*/
 			bool flags_valid = false;
-			for (i = flag_vlevel; i < context->bw_ctx.dml.soc.num_states; i++) {
+			for (i = flag_vlevel; i < (int)context->bw_ctx.dml.soc.num_states; i++) {
 				if (vba->ModeSupport[i][flag_max_mpc_comb]) {
 					vba->maxMpcComb = flag_max_mpc_comb;
 					vba->VoltageLevel = i;
@@ -2267,7 +2270,8 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 				int pipe_cnt,
 				int vlevel)
 {
-	int i, pipe_idx, vlevel_temp = 0;
+	int pipe_idx, vlevel_temp = 0;
+	unsigned int i;
 	double dcfclk = dcn3_2_soc.clock_limits[0].dcfclk_mhz;
 	double dcfclk_from_validation = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
 	double dram_speed_from_validation = context->bw_ctx.dml.vba.DRAMSpeed;
@@ -2619,7 +2623,7 @@ static void dcn32_get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
 static void remove_entry_from_table_at_index(struct _vcs_dpi_voltage_scaling_st *table, unsigned int *num_entries,
 		unsigned int index)
 {
-	int i;
+	unsigned int i;
 
 	if (*num_entries == 0)
 		return;
@@ -2686,7 +2690,7 @@ static void sort_entries_with_same_bw(struct _vcs_dpi_voltage_scaling_st *table,
 	unsigned int end_index = 0;
 	unsigned int current_bw = 0;
 
-	for (int i = 0; i < (*num_entries - 1); i++) {
+	for (unsigned int i = 0; i < (*num_entries - 1); i++) {
 		if (table[i].net_bw_in_kbytes_sec == table[i+1].net_bw_in_kbytes_sec) {
 			current_bw = table[i].net_bw_in_kbytes_sec;
 			start_index = i;
@@ -2697,8 +2701,8 @@ static void sort_entries_with_same_bw(struct _vcs_dpi_voltage_scaling_st *table,
 		}
 
 		if (start_index != end_index) {
-			for (int j = start_index; j < end_index; j++) {
-				for (int k = start_index; k < end_index; k++) {
+			for (unsigned int j = start_index; j < end_index; j++) {
+				for (unsigned int k = start_index; k < end_index; k++) {
 					if (table[k].dcfclk_mhz > table[k+1].dcfclk_mhz)
 						swap_table_entries(&table[k], &table[k+1]);
 				}
@@ -2717,7 +2721,7 @@ static void sort_entries_with_same_bw(struct _vcs_dpi_voltage_scaling_st *table,
  */
 static void remove_inconsistent_entries(struct _vcs_dpi_voltage_scaling_st *table, unsigned int *num_entries)
 {
-	for (int i = 0; i < (*num_entries - 1); i++) {
+	for (unsigned int i = 0; i < (*num_entries - 1); i++) {
 		if (table[i].net_bw_in_kbytes_sec == table[i+1].net_bw_in_kbytes_sec) {
 			if ((table[i].dram_speed_mts > table[i+1].dram_speed_mts) ||
 				(table[i].fabricclk_mhz > table[i+1].fabricclk_mhz))
@@ -2765,7 +2769,8 @@ static int override_max_clk_values(struct clk_limit_table_entry *max_clk_limit,
 static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk_bw_params *bw_params,
 		struct _vcs_dpi_voltage_scaling_st *table, unsigned int *num_entries)
 {
-	int i, j;
+	int i;
+	unsigned int j;
 	struct _vcs_dpi_voltage_scaling_st entry = {0};
 	struct clk_limit_table_entry max_clk_data = {0};
 
@@ -2852,8 +2857,8 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 	entry.phyclk_d32_mhz = dcn3_2_soc.clock_limits[0].phyclk_d32_mhz;
 
 	// Insert all the DCFCLK STAs
-	for (i = 0; i < num_dcfclk_stas; i++) {
-		entry.dcfclk_mhz = dcfclk_sta_targets[i];
+	for (j = 0; j < num_dcfclk_stas; j++) {
+		entry.dcfclk_mhz = dcfclk_sta_targets[j];
 		entry.fabricclk_mhz = 0;
 		entry.dram_speed_mts = 0;
 
@@ -2872,10 +2877,10 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 	insert_entry_into_table_sorted(table, num_entries, &entry);
 
 	// Insert the UCLK DPMS
-	for (i = 0; i < num_uclk_dpms; i++) {
+	for (j = 0; j < num_uclk_dpms; j++) {
 		entry.dcfclk_mhz = 0;
 		entry.fabricclk_mhz = 0;
-		entry.dram_speed_mts = bw_params->clk_table.entries[i].memclk_mhz * 16;
+		entry.dram_speed_mts = bw_params->clk_table.entries[j].memclk_mhz * 16;
 
 		get_optimal_ntuple(&entry);
 		entry.net_bw_in_kbytes_sec = calculate_net_bw_in_kbytes_sec(&entry);
@@ -2884,9 +2889,9 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 
 	// If FCLK is coarse grained, insert individual DPMs.
 	if (num_fclk_dpms > 2) {
-		for (i = 0; i < num_fclk_dpms; i++) {
+		for (j = 0; j < num_fclk_dpms; j++) {
 			entry.dcfclk_mhz = 0;
-			entry.fabricclk_mhz = bw_params->clk_table.entries[i].fclk_mhz;
+			entry.fabricclk_mhz = bw_params->clk_table.entries[j].fclk_mhz;
 			entry.dram_speed_mts = 0;
 
 			get_optimal_ntuple(&entry);
@@ -2976,7 +2981,7 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 
 	// Remove duplicate states, note duplicate states are always neighbouring since table is sorted.
 	i = 0;
-	while (i < *num_entries - 1) {
+	while (i < ((int)*num_entries - 1)) {
 		if (table[i].dcfclk_mhz == table[i + 1].dcfclk_mhz &&
 				table[i].fabricclk_mhz == table[i + 1].fabricclk_mhz &&
 				table[i].dram_speed_mts == table[i + 1].dram_speed_mts)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 0782a34689a0..fd698335d713 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1724,7 +1724,8 @@ static void mode_support_configuration(struct vba_vars_st *v,
 void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
 {
 	struct vba_vars_st *v = &mode_lib->vba;
-	int i, j, start_state;
+	int i, start_state;
+	unsigned int j;
 	unsigned int k, m;
 	unsigned int MaximumMPCCombine;
 	unsigned int NumberOfNonCombinedSurfaceOfMaximumBandwidth;
@@ -2030,7 +2031,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	mode_lib->vba.MPCCombineMethodIncompatible = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsNeededForPStateChangeAndVoltage
 			&& v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MPCCombineMethodAsPossible;
 
-	for (i = start_state; i < v->soc.num_states; i++) {
+	for (i = start_state; i < (int)v->soc.num_states; i++) {
 		for (j = 0; j < 2; j++) {
 			mode_lib->vba.TotalNumberOfActiveDPP[i][j] = 0;
 			mode_lib->vba.TotalAvailablePipesSupport[i][j] = true;
@@ -2307,7 +2308,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
-	for (i = start_state; i < v->soc.num_states; ++i) {
+	for (i = start_state; i < (int)v->soc.num_states; ++i) {
 		mode_lib->vba.ExceededMultistreamSlots[i] = false;
 		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 			if (mode_lib->vba.OutputMultistreamEn[k] == true && mode_lib->vba.OutputMultistreamId[k] == k) {
@@ -2410,7 +2411,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
-	for (i = start_state; i < v->soc.num_states; ++i) {
+	for (i = start_state; i < (int)v->soc.num_states; ++i) {
 		mode_lib->vba.DTBCLKRequiredMoreThanSupported[i] = false;
 		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 			if (mode_lib->vba.BlendingAndTiming[k] == k
@@ -2427,7 +2428,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
-	for (i = start_state; i < v->soc.num_states; ++i) {
+	for (i = start_state; i < (int)v->soc.num_states; ++i) {
 		mode_lib->vba.ODMCombine2To1SupportCheckOK[i] = true;
 		mode_lib->vba.ODMCombine4To1SupportCheckOK[i] = true;
 		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
@@ -2445,7 +2446,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
-	for (i = start_state; i < v->soc.num_states; i++) {
+	for (i = start_state; i < (int)v->soc.num_states; i++) {
 		mode_lib->vba.DSCCLKRequiredMoreThanSupported[i] = false;
 		for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
 			if (mode_lib->vba.BlendingAndTiming[k] == k) {
@@ -2482,7 +2483,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	/* Check DSC Unit and Slices Support */
 	v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = 0;
 
-	for (i = start_state; i < v->soc.num_states; ++i) {
+	for (i = start_state; i < (int)v->soc.num_states; ++i) {
 		mode_lib->vba.NotEnoughDSCUnits[i] = false;
 		mode_lib->vba.NotEnoughDSCSlices[i] = false;
 		v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalDSCUnitsRequired = 0;
@@ -2517,7 +2518,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 
 	/*DSC Delay per state*/
-	for (i = start_state; i < v->soc.num_states; ++i) {
+	for (i = start_state; i < (int)v->soc.num_states; ++i) {
 		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 			mode_lib->vba.DSCDelayPerState[i][k] = dml32_DSCDelayRequirement(
 					mode_lib->vba.RequiresDSC[i][k], mode_lib->vba.ODMCombineEnablePerState[i][k],
@@ -2531,7 +2532,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 		for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
 			for (m = 0; m <= mode_lib->vba.NumberOfActiveSurfaces - 1; m++) {
-				for (j = 0; j <= mode_lib->vba.NumberOfActiveSurfaces - 1; j++) {
+				for (j = 0; j < mode_lib->vba.NumberOfActiveSurfaces; j++) {
 					if (mode_lib->vba.BlendingAndTiming[k] == m &&
 							mode_lib->vba.RequiresDSC[i][m] == true) {
 						mode_lib->vba.DSCDelayPerState[i][k] =
@@ -2682,7 +2683,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			mode_lib->vba.SurfaceSizeInMALL,
 			&mode_lib->vba.ExceededMALLSize);
 
-	for (i = start_state; i < v->soc.num_states; i++) {
+	for (i = start_state; i < (int)v->soc.num_states; i++) {
 		for (j = 0; j < 2; j++) {
 			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
 				mode_lib->vba.swath_width_luma_ub_this_state[k] =
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 5e72966a8daf..af49db78a68b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -6318,7 +6318,7 @@ bool dml32_CalculateDETSwathFillLatencyHiding(unsigned int NumberOfActiveSurface
 		enum dm_use_mall_for_pstate_change_mode UsesMALLForPStateChange[],
 		enum unbounded_requesting_policy UseUnboundedRequesting)
 {
-	int k;
+	unsigned int k;
 	double SwathSizeAllSurfaces = 0;
 	double SwathSizeAllSurfacesInFetchTimeUs;
 	double DETSwathLatencyHidingUs;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index e0a1dc89ce43..4f7188b1183c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -211,8 +211,8 @@ static void dcn321_insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scalin
 					   unsigned int *num_entries,
 					   struct _vcs_dpi_voltage_scaling_st *entry)
 {
-	int i = 0;
-	int index = 0;
+	unsigned int i = 0;
+	unsigned int index = 0;
 
 	dc_assert_fp_enabled();
 
@@ -237,7 +237,7 @@ static void dcn321_insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scalin
 static void remove_entry_from_table_at_index(struct _vcs_dpi_voltage_scaling_st *table, unsigned int *num_entries,
 		unsigned int index)
 {
-	int i;
+	unsigned int i;
 
 	if (*num_entries == 0)
 		return;
@@ -265,19 +265,19 @@ static void sort_entries_with_same_bw(struct _vcs_dpi_voltage_scaling_st *table,
 	unsigned int end_index = 0;
 	unsigned int current_bw = 0;
 
-	for (int i = 0; i < (*num_entries - 1); i++) {
+	for (unsigned int i = 0; i + 1 < *num_entries; i++) {
 		if (table[i].net_bw_in_kbytes_sec == table[i+1].net_bw_in_kbytes_sec) {
 			current_bw = table[i].net_bw_in_kbytes_sec;
 			start_index = i;
 			end_index = ++i;
 
-			while ((i < (*num_entries - 1)) && (table[i+1].net_bw_in_kbytes_sec == current_bw))
+			while ((i + 1 < *num_entries) && (table[i+1].net_bw_in_kbytes_sec == current_bw))
 				end_index = ++i;
 		}
 
 		if (start_index != end_index) {
-			for (int j = start_index; j < end_index; j++) {
-				for (int k = start_index; k < end_index; k++) {
+			for (unsigned int j = start_index; j < end_index; j++) {
+				for (unsigned int k = start_index; k < end_index; k++) {
 					if (table[k].dcfclk_mhz > table[k+1].dcfclk_mhz)
 						swap_table_entries(&table[k], &table[k+1]);
 				}
@@ -296,7 +296,7 @@ static void sort_entries_with_same_bw(struct _vcs_dpi_voltage_scaling_st *table,
  */
 static void remove_inconsistent_entries(struct _vcs_dpi_voltage_scaling_st *table, unsigned int *num_entries)
 {
-	for (int i = 0; i < (*num_entries - 1); i++) {
+	for (unsigned int i = 0; i + 1 < *num_entries; i++) {
 		if (table[i].net_bw_in_kbytes_sec == table[i+1].net_bw_in_kbytes_sec) {
 			if ((table[i].dram_speed_mts > table[i+1].dram_speed_mts) ||
 				(table[i].fabricclk_mhz > table[i+1].fabricclk_mhz))
@@ -344,7 +344,8 @@ static int override_max_clk_values(struct clk_limit_table_entry *max_clk_limit,
 static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk_bw_params *bw_params,
 		struct _vcs_dpi_voltage_scaling_st *table, unsigned int *num_entries)
 {
-	int i, j;
+	int i;
+	unsigned int j, k;
 	struct _vcs_dpi_voltage_scaling_st entry = {0};
 	struct clk_limit_table_entry max_clk_data = {0};
 
@@ -431,8 +432,8 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 	entry.phyclk_d32_mhz = dcn3_21_soc.clock_limits[0].phyclk_d32_mhz;
 
 	// Insert all the DCFCLK STAs
-	for (i = 0; i < num_dcfclk_stas; i++) {
-		entry.dcfclk_mhz = dcfclk_sta_targets[i];
+	for (k = 0; k < num_dcfclk_stas; k++) {
+		entry.dcfclk_mhz = dcfclk_sta_targets[k];
 		entry.fabricclk_mhz = 0;
 		entry.dram_speed_mts = 0;
 
@@ -451,10 +452,10 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 	dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
 
 	// Insert the UCLK DPMS
-	for (i = 0; i < num_uclk_dpms; i++) {
+	for (k = 0; k < num_uclk_dpms; k++) {
 		entry.dcfclk_mhz = 0;
 		entry.fabricclk_mhz = 0;
-		entry.dram_speed_mts = bw_params->clk_table.entries[i].memclk_mhz * 16;
+		entry.dram_speed_mts = bw_params->clk_table.entries[k].memclk_mhz * 16;
 
 		get_optimal_ntuple(&entry);
 		entry.net_bw_in_kbytes_sec = calculate_net_bw_in_kbytes_sec(&entry);
@@ -463,9 +464,9 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 
 	// If FCLK is coarse grained, insert individual DPMs.
 	if (num_fclk_dpms > 2) {
-		for (i = 0; i < num_fclk_dpms; i++) {
+		for (k = 0; k < num_fclk_dpms; k++) {
 			entry.dcfclk_mhz = 0;
-			entry.fabricclk_mhz = bw_params->clk_table.entries[i].fclk_mhz;
+			entry.fabricclk_mhz = bw_params->clk_table.entries[k].fclk_mhz;
 			entry.dram_speed_mts = 0;
 
 			get_optimal_ntuple(&entry);
@@ -489,7 +490,7 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 	// ratios (by derate, are exact).
 
 	// Remove states that require higher clocks than are supported
-	for (i = *num_entries - 1; i >= 0 ; i--) {
+	for (i = (int)*num_entries - 1; i >= 0 ; i--) {
 		if (table[i].dcfclk_mhz > max_clk_data.dcfclk_mhz ||
 				table[i].fabricclk_mhz > max_clk_data.fclk_mhz ||
 				table[i].dram_speed_mts > max_clk_data.memclk_mhz * 16)
@@ -519,7 +520,7 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 	// coarse grained DPMs and remove duplicates.
 
 	// Round up UCLKs
-	for (i = *num_entries - 1; i >= 0 ; i--) {
+	for (i = (int)*num_entries - 1; i >= 0 ; i--) {
 		for (j = 0; j < num_uclk_dpms; j++) {
 			if (bw_params->clk_table.entries[j].memclk_mhz * 16 >= table[i].dram_speed_mts) {
 				table[i].dram_speed_mts = bw_params->clk_table.entries[j].memclk_mhz * 16;
@@ -530,7 +531,7 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 
 	// If FCLK is coarse grained, round up to next DPMs
 	if (num_fclk_dpms > 2) {
-		for (i = *num_entries - 1; i >= 0 ; i--) {
+		for (i = (int)*num_entries - 1; i >= 0 ; i--) {
 			for (j = 0; j < num_fclk_dpms; j++) {
 				if (bw_params->clk_table.entries[j].fclk_mhz >= table[i].fabricclk_mhz) {
 					table[i].fabricclk_mhz = bw_params->clk_table.entries[j].fclk_mhz;
@@ -541,7 +542,7 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 	}
 	// Otherwise, round up to minimum.
 	else {
-		for (i = *num_entries - 1; i >= 0 ; i--) {
+		for (i = (int)*num_entries - 1; i >= 0 ; i--) {
 			if (table[i].fabricclk_mhz < min_fclk_mhz) {
 				table[i].fabricclk_mhz = min_fclk_mhz;
 			}
@@ -549,7 +550,7 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 	}
 
 	// Round DCFCLKs up to minimum
-	for (i = *num_entries - 1; i >= 0 ; i--) {
+	for (i = (int)*num_entries - 1; i >= 0 ; i--) {
 		if (table[i].dcfclk_mhz < min_dcfclk_mhz) {
 			table[i].dcfclk_mhz = min_dcfclk_mhz;
 		}
@@ -557,7 +558,7 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 
 	// Remove duplicate states, note duplicate states are always neighbouring since table is sorted.
 	i = 0;
-	while (i < *num_entries - 1) {
+	while (i < (int)*num_entries - 1) {
 		if (table[i].dcfclk_mhz == table[i + 1].dcfclk_mhz &&
 				table[i].fabricclk_mhz == table[i + 1].fabricclk_mhz &&
 				table[i].dram_speed_mts == table[i + 1].dram_speed_mts)
@@ -567,9 +568,8 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 	}
 
 	// Fix up the state indicies
-	for (i = *num_entries - 1; i >= 0 ; i--) {
+	for (i = (int)*num_entries - 1; i >= 0 ; i--)
 		table[i].state = i;
-	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 7f40048dd67d..558f8b96cbb8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -233,7 +233,7 @@ void dcn35_update_bw_bounding_box_fpu(struct dc *dc,
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
 	struct _vcs_dpi_voltage_scaling_st *clock_limits =
 		dc->scratch.update_bw_bounding_box.clock_limits;
-	int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
+	unsigned int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
 
 	dc_assert_fp_enabled();
 
@@ -440,7 +440,8 @@ int dcn35_populate_dml_pipes_from_context_fpu(struct dc *dc,
 					      display_e2e_pipe_params_st *pipes,
 					      enum dc_validate_mode validate_mode)
 {
-	int i, pipe_cnt;
+	unsigned int i;
+	int pipe_cnt;
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe = 0;
 	bool upscaled = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
index 73c2aee57f28..3ec2671af890 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
@@ -266,7 +266,7 @@ void dcn351_update_bw_bounding_box_fpu(struct dc *dc,
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
 	struct _vcs_dpi_voltage_scaling_st *clock_limits =
 		dc->scratch.update_bw_bounding_box.clock_limits;
-	int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
+	unsigned int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
 
 	dc_assert_fp_enabled();
 
@@ -472,7 +472,8 @@ int dcn351_populate_dml_pipes_from_context_fpu(struct dc *dc,
 					      display_e2e_pipe_params_st *pipes,
 					      enum dc_validate_mode validate_mode)
 {
-	int i, pipe_cnt;
+	int pipe_cnt;
+	unsigned int i;
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe = 0;
 	bool upscaled = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 85453bbb4f9b..146a32f94d6a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -304,7 +304,7 @@ bool get_is_phantom_pipe(struct display_mode_lib *mode_lib, const display_e2e_pi
 static void fetch_socbb_params(struct display_mode_lib *mode_lib)
 {
 	soc_bounding_box_st *soc = &mode_lib->vba.soc;
-	int i;
+	unsigned int i;
 
 	// SOC Bounding Box Parameters
 	mode_lib->vba.ReturnBusWidth = soc->return_bus_width_bytes;
@@ -946,7 +946,7 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
  */
 static void cache_debug_params(struct display_mode_lib *mode_lib)
 {
-	int k = 0;
+	unsigned int k = 0;
 
 	for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; k++)
 		mode_lib->vba.CachedActiveDRAMClockChangeLatencyMargin[k] = mode_lib->vba.ActiveDRAMClockChangeLatencyMargin[k];
-- 
2.53.0

