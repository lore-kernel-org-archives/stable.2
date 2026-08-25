Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F53E1203
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787692740; cv=none; b=nDZOo2shLBrTncZ+z6hsE+mjjFkCIyNGDk0jJ41kcxsqjVn5qij2usNbggDSXIQh37Kz7JZmon2b7sqFXgsr9l/6xNbH/u09sbRs5Mh3jocuOWMRjULEVzCRLUQbhe91qjrwd3wtpBNnWQLNM0Wa5OBEsq9f6SHuZP4uehBmnWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787692740; c=relaxed/simple;
	bh=v3KeD7vAn/1Tr9xc0hALdyyz+zpRtUYf3698BVfPqxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/hlZ6yWLH+MHhcJf7bWuSm12kPr1uGe2ro+EB5cHbo/BDu9rEWZ+ngRU22WJwkoAm4vUBwxtRqH1ow4W2Xr59HzbahRU+a8vY+3lPkWuhgVppPH7ZgmuEPZRg8hulutW1vBEKByevCk2AHj5B6yjaiJEA18I3rzWHAulCdf7YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwP43f48; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwP43f48"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-747355a8565so122743137.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 14:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787692735; x=1788297535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+eIjrt6KeI3I2h6Zo1iGh+SOtnehC55eS3yDc43Zaig=;
        b=YwP43f48u/RQO8tGMhgKHr3s0wIs/8wLVG0V7M70bPdvbENm+3znEJQWar/Qy6oSN6
         3+vZo2HTe1HHTmv1Z1G0hlRKZN6o3c6OZK+ydJEyCxkja42N9jBwbgatb31B8xY6h59c
         S3sVjNWF7Qz0sWLwe8NjsGFmlhKi8XLsMnpikNUTFNZptZP49xfN4uozZnPhRyuQu83w
         ZJIVMO9VTuTsNajm6NZ/Sm4Ml4q8RHI2Bx/MjP3Skj2J+pbQwhEIIPDQ30XWU+v0mPeG
         zGTHCh7Sw8uGSPM6PfaVHa7a/od6o/7/SKkIotrTVKqQDG8TR9npJywmJdvbqakXVRXD
         ruiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787692735; x=1788297535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+eIjrt6KeI3I2h6Zo1iGh+SOtnehC55eS3yDc43Zaig=;
        b=rGjF5yjs0t5V28wWYjeDVYXp1asQp2eqa+6PQOROrtJqHEam+0FS8BUDUfWq9Feemo
         BtH/bfMJDnXndutExRhl790Ih0HGKnZtlPrDvfxKcERFKhxvtwRz0gaRkh4X+nmFmvgO
         stL0KOw9AWvsUn9YonVYOBWEmMewWJuqZEDFOhFAsDaj3E1/sYhLaRv+rCThga/2xJ9A
         HK2cGgUR2hegmrtFoWc1bHkz+tJKgx2lxkxpW2pORIUjvGThhANYdZCNf3uD6v3h+2Df
         WJvd6DLXEumNfCpgKJHOh3KlktCBHVBxWdZ1Y26Be177N722N11dRdm792C0HA+rXhcl
         1Xyw==
X-Forwarded-Encrypted: i=1; AHgh+RptZ/BGpin8Y15O/+28+OgHU7ZxmaleYC+GnW/CfJBrGp49QwoJjD7kfhScBIUH0SDv3/ps1P4=@vger.kernel.org
X-Gm-Message-State: AFuF++m7aT+n8JgyuXIcbud2f+3zrlVmchSJEUd9RFjDjVYf5cAmvEKg
	R9WKr2p6EdbyF72erNo3miJvxYguJ+G7NfZ4uIaacOMiYUKEs08F6KDo
X-Gm-Gg: AR+sD11xT5wLfK+9m2Dv2uC5eiC6PjGWMMLGBuEWK6oK5kPVS6Yeq3OZJ8l5P4npTzm
	TFHhlbfctxc2ddfMWP/8aNIQS1GUdcQZLAx0Lo8FtSw7ZU9gtVMruKk5jnmGJK8G7YFjPpO5HMN
	nVRVHybPIDhfb/8wy5RfhZ2jpzaxDjgcZMvSRXDSl4i4PpBtJ2R+L0IG3e9jfSuaPPeWLcRjBaW
	8rgppezdAyBlk27R/oVxD9CfAydGURIA9wvpPh2/Xuh5bVSesvR2U6na8DGypVEBmdSGOcmyWAG
	7DRjw3Jge0EpSPvx43IDNK7cxuniUw8LcCRMR7ONWsvxhLjbCO5Y54wDvfIIEAV3EnF78YoXrOw
	PT7kv1kEd95NynIQGMDCNst2RZtY3rdMaA5pSFMBQLLVXJ4zV1kfQurcMLwxmEBD26IqvPwIJSu
	kk6GHNoLSIgM3nFiXRsrnUbr7wOpMlBN8oqaCIHXvdTloe/iYNTr7RLUkLOsygZLJ+aO4=
X-Received: by 2002:a05:6102:448a:b0:778:9b4:55a4 with SMTP id ada2fe7eead31-782c1c06621mr671271137.12.1787692735490;
        Tue, 25 Aug 2026 14:18:55 -0700 (PDT)
Received: from t14 ([189.39.221.242])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78307cb51b9sm47611137.7.2026.08.25.14.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:18:54 -0700 (PDT)
From: Mauricio Bellon <mauriciobellon@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Wayne Lin <Wayne.Lin@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mauricio Bellon <mbellon@lenovo.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	christian.koenig@amd.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/amd/display: stabilize DCN35 ODM update sequencing
Date: Tue, 25 Aug 2026 18:18:18 -0300
Message-ID: <20260825211819.100210-2-mauriciobellon@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825211819.100210-1-mauriciobellon@gmail.com>
References: <20260825211819.100210-1-mauriciobellon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mauricio Bellon <mbellon@lenovo.com>

Two related direct DisplayPort failures occur with a high-refresh DSC
stream using two-way ODM on DCN35. A normal transition from 4K120 to
4K144 can commit successfully but produce no visible output. After 4K144
is working, a long-pulse hotplug can reconstruct the same DSC/ODM stream
but leave the monitor black.

The horizontal timing divider changes together with the ODM topology.
DCN35 does not expose wait_odm_doublebuffer_pending_clear(), so the
common completion path can continue before the divider update has
latched. Hook up the compatible DCN32 wait implementation and wait
immediately after dcn35_update_odm() programs combine or bypass.

Keep the divider under manual control while changing the ODM topology.
After the pending update completes, restore manual mode explicitly from
the target stream using the same FRL, horizontal-timing divisibility, and
virtual-signal policy as stream timing setup. Keep that restoration
separate from hwss_wait_for_odm_update_pending_complete() so the wait
helper remains limited to waiting for hardware updates.

The affected 4K144 timing has odd horizontal blank boundaries and
requires manual divider mode, while the 4K120 timing is divisible by two
and uses automatic mode. The ODM combine and bypass functions explicitly
program OTG_H_TIMING_DIV_MODE before completion.

Cc: stable@vger.kernel.org
Signed-off-by: Mauricio Bellon <mbellon@lenovo.com>
---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 20 +++++++++++++++++--
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |  2 ++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 6e1079377..a5b914b81 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -433,18 +433,30 @@ void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 {
 	(void)context;
 	struct pipe_ctx *odm_pipe;
+	struct pipe_ctx *current_pipe_ctx =
+		&dc->current_state->res_ctx.pipe_ctx[pipe_ctx->pipe_idx];
+	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 	int opp_cnt = 0;
 	int opp_inst[MAX_PIPES] = {0};
 	int odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, false);
 	int last_odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, true);
 	struct mpc *mpc = dc->res_pool->mpc;
+	bool target_manual_mode;
+	bool update_odm;
 	int i;
 
 	opp_cnt = get_odm_config(pipe_ctx, opp_inst);
+	update_odm = opp_cnt > 1 || current_pipe_ctx->next_odm_pipe;
+	target_manual_mode = dc_is_hdmi_frl_signal(pipe_ctx->stream->signal) ||
+		!is_h_timing_divisible_by_2(pipe_ctx->stream) ||
+		dc_is_virtual_signal(pipe_ctx->stream->signal);
 
 	if (!(pipe_ctx->stream_res.hpo_frl_stream_enc &&
 			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_fifo_odm_enabled &&
 			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_fifo_odm_enabled(pipe_ctx->stream_res.hpo_frl_stream_enc))) {
+		if (update_odm && tg->funcs->set_h_timing_div_manual_mode)
+			tg->funcs->set_h_timing_div_manual_mode(tg, true);
+
 	if (opp_cnt > 1)
 		pipe_ctx->stream_res.tg->funcs->set_odm_combine(
 				pipe_ctx->stream_res.tg,
@@ -454,6 +466,12 @@ void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
 
+		if (update_odm && tg->funcs->wait_odm_doublebuffer_pending_clear)
+			tg->funcs->wait_odm_doublebuffer_pending_clear(tg);
+
+		if (update_odm && tg->funcs->set_h_timing_div_manual_mode)
+			tg->funcs->set_h_timing_div_manual_mode(tg, target_manual_mode);
+
 	if (mpc->funcs->set_out_rate_control) {
 		for (i = 0; i < opp_cnt; ++i) {
 			mpc->funcs->set_out_rate_control(
@@ -472,8 +490,6 @@ void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 	}
 
 	if (pipe_ctx->stream_res.dsc) {
-		struct pipe_ctx *current_pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[pipe_ctx->pipe_idx];
-
 		update_dsc_on_stream(pipe_ctx, pipe_ctx->stream->timing.flags.DSC != 0);
 
 		/* Check if no longer using pipe for ODM, then need to disconnect DSC for that pipe */
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index 897f857db..c26a2fd70 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -603,6 +603,8 @@ static const struct timing_generator_funcs dcn35_tg_funcs = {
 		.set_odm_combine = optc35_set_odm_combine,
 		.get_optc_source = optc2_get_optc_source,
 		.wait_otg_disable = optc35_wait_otg_disable,
+		.wait_odm_doublebuffer_pending_clear =
+			optc32_wait_odm_doublebuffer_pending_clear,
 		.set_h_timing_div_manual_mode = optc32_set_h_timing_div_manual_mode,
 		.set_out_mux = optc3_set_out_mux,
 		.set_drr_trigger_window = optc3_set_drr_trigger_window,
-- 
2.53.0

