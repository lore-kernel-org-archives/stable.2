Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997623CDBAA
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501211; cv=none; b=DqiG5vnu4YmO6MmHNNsvXckr1PI1alaLASDRTrvTjTThDdvAgGkZ+PWxFY5skpXSnJo11aC79QlIeH4VVgd2N62IZJj4Wtz2y3NCpTIG4eN4b2oWlB8Z2dxlZTESdK0Uqsb2Ech27AKSnWOwend6f+ZdfzbHdSQ38sN3NtQylWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501211; c=relaxed/simple;
	bh=vAMmBnN+L9ZqhoN92DE6aIJtWVqWqsFL8kdBOPwfiT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tw1K2GDnpT/EOoU1y5YXGIGfQ+XRHjSIj5tgMxKdGXXxuKqXqBwsyuLsGvB/1VbKdbG4taDev4CNlF0ITNZjkD6FotGFj9Jx/cnAKVY9NZKSOld8EIVXPxosAXwWFFuD36YKY2D9Irfka2Bqn//+R6YoZFR+Ejp6legGBgM+gqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=WkTY6+DV; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="WkTY6+DV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1780501209;
	bh=Ri1tO8GMn6WbyO3R2aVVNaEbwovcSe6KpbCI36dIv1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WkTY6+DVqsP4ICURshJLjejq3XAX05Zazy4U7dO4nSqytaG26IHAeEAjRAmRDx386
	 u78luyXdOZOBP1yD9AVx6IQW+ylViOHsYu7HReL/V704BIlmzldhvv6+sjWgbt0Iqd
	 xr1SGcQfKn/e83NlPLudQnJxnVmW0b0Kj0iNSihY=
Received: from stargazer (unknown [IPv6:2408:824e:307:6541:546a:40ae:5851:c0ef])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 5DABD65B57;
	Wed,  3 Jun 2026 11:40:04 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	Ovidiu Bunea <ovidiu.bunea@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v7.0.y v2 1/8] drm/amd/display: Add min clock init for DML21 mode programming
Date: Wed,  3 Jun 2026 23:39:13 +0800
Message-ID: <20260603153920.249671-2-xry111@xry111.site>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603153920.249671-1-xry111@xry111.site>
References: <20260603153920.249671-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[ Upstream commit 23dee18f6503d67b195f1513e404c78653ed0d40 ]

[WHY & HOW]
0 stream cases do not go through any DML validation which leaves DCN
clocks in unoptimized states.

If requesting DML validation or programming with 0 streams, program
DCN clocks to lowest DPM state.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 .../dml2_0/dml21/dml21_translation_helper.c   | 25 +++++++++++++++++++
 .../dml2_0/dml21/dml21_translation_helper.h   |  1 +
 .../display/dc/dml2_0/dml21/dml21_wrapper.c   |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index bf5e7f4e0416..5bf3008a71c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -927,3 +927,28 @@ void dml21_set_dc_p_state_type(
 	}
 }
 
+void dml21_init_min_clocks_for_dc_state(struct dml2_context *in_ctx, struct dc_state *context)
+{
+	unsigned int lowest_dpm_state_index = 0;
+	struct dc_clocks *min_clocks = &context->bw_ctx.bw.dcn.clk;
+
+	min_clocks->dispclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.dispclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->dppclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.dppclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->dcfclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.dcfclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->dramclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.uclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->fclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.fclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->idle_dramclk_khz = 0;
+	min_clocks->idle_fclk_khz = 0;
+	min_clocks->dcfclk_deep_sleep_khz = 0;
+	min_clocks->fclk_p_state_change_support = true;
+	min_clocks->p_state_change_support = true;
+	min_clocks->dtbclk_en = false;
+	min_clocks->ref_dtbclk_khz = 0;
+	min_clocks->socclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.socclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->subvp_prefetch_dramclk_khz = 0;
+	min_clocks->subvp_prefetch_fclk_khz = 0;
+	min_clocks->phyclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.phyclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->stutter_efficiency.base_efficiency = 1;
+	min_clocks->stutter_efficiency.low_power_efficiency = 1;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.h
index 9880d3e0398e..f51d3d8a52c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.h
@@ -25,4 +25,5 @@ void dml21_map_hw_resources(struct dml2_context *dml_ctx);
 void dml21_get_pipe_mcache_config(struct dc_state *context, struct pipe_ctx *pipe_ctx, struct dml2_per_plane_programming *pln_prog, struct dml2_pipe_configuration_descriptor *mcache_pipe_config);
 void dml21_set_dc_p_state_type(struct pipe_ctx *pipe_ctx, struct dml2_per_stream_programming *stream_programming, bool sub_vp_enabled);
 unsigned int map_plane_to_dml21_display_cfg(const struct dml2_context *dml_ctx, unsigned int stream_id, const struct dc_plane_state *plane, const struct dc_state *context);
+void dml21_init_min_clocks_for_dc_state(struct dml2_context *in_ctx, struct dc_state *context);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
index 798abb2b2e67..96c62bd6a37b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
@@ -215,6 +215,7 @@ static bool dml21_mode_check_and_programming(const struct dc *in_dc, struct dc_s
 		return true;
 
 	if (context->stream_count == 0) {
+		dml21_init_min_clocks_for_dc_state(dml_ctx, context);
 		dml21_build_fams2_programming(in_dc, context, dml_ctx);
 		return true;
 	}
-- 
2.54.0

