Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40D3A545F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 06:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785306892; cv=none; b=af7Lu6jvI+mpNxNRywRCAs3STbE9sbjP31kq5LnHaSgGIxtIV8c5PAP2rIXxgbTnV5DlsRfmtXfutCln/SUjFP1B8UhiIK5g8jhaiu/dNE9c9mB7iQhVRpE87fdQINCjqnuh9wSN3fdw8UzEm8hCA52XId2C8xS3wrgFBO+zPzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785306892; c=relaxed/simple;
	bh=PY5w/b54wziizuQOWpl4P8LjuL7PQcXgVXCYLjlt26c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=coKXot2XC2ofOMvSLuJ/Vi89dSxSZh2Zijbme4mLe0fHWP8Lz2w0TQnSvFTtK9Vd2NuYYTRR8A10RfkQ+DErYwAWUWfbuho5Qw7zyTZHQwW0QeWG07mjrMb7L1uOH+GExugKWvgiYlnvHzYcpkFpZS1LxlSJRvN7usYdv5fFEew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r6+5siZr; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r6+5siZr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785306886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=71o7pgYmf0sE5JSVHPewVuh8Wj9lSn+Qrfh4RCsQpnU=;
	b=r6+5siZrco9mh5LYKP6lyHhjH1mEOZbW+B2Eom2MWU59Bz4HgSxwmf4SqZBSJPliZZZNvT
	aRpAobb5XsvhsBvNvmRVQ3pJuTYinEJw5/s19ydnfgTOfr2tvwVc05sH5NQyydwhtAO/WN
	c9WE+ivsr9LvpY4KQTWArxR1L4FqhH4=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: stable@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org,
	sunpeng.li@amd.com,
	mario.limonciello@amd.com,
	Harry Wentland <harry.wentland@amd.com>,
	Fangzhi Zuo <Jerry.Zuo@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH 6.12.y/6.18.y/7.1.y] drm/amd/display: Fix DTB DTO updates breaking live pixel rate sources
Date: Tue, 28 Jul 2026 23:33:40 -0700
Message-ID: <20260729063340.9287-1-matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Harry Wentland <harry.wentland@amd.com>

commit 76a2db58e95e328007043f54ac3c7336ccbee440 upstream.

dcn32_update_clocks_update_dtb_dto() and its dcn35 counterpart reprogram
the DTB DTO of every timing generator in the context whenever the DTBCLK
reference changes, passing a zeroed pixel rate and never setting
is_hdmi. Both dccg set_dtbclk_dto() implementations treat a zero pixel
rate as a disable request. On dcn32 that branch drives PIPE_DTO_SRC_SEL
to the DP DTO source, so a timing generator actively scanning out an
HDMI stream has its pixel rate source re-muxed out from under the live
raster and the OTG stops on the spot. On dcn35 it clears
DTBCLK_DTO_ENABLE and restores DTBCLK_Pn clock gating, which does the
same to a live 128b/132b stream.

Two displays where only one runs a 128b/132b link hit this reliably.
is_dtbclk_required() holds the DTBCLK reference high while both are
active, and the moment the 128b/132b stream is torn down (compositor
switch, display disable, hot-unplug) the next safe_to_lower pass drops
the reference to the lowest DPM level and the DTO walk freezes the
surviving screen. On Navi31 the DAL mailbox then goes deaf on the
DISPCLK hard-min that follows the walk in dcn32_update_clocks(),
stranding both SMU mailboxes until reboot.

Set is_hdmi for HDMI and DVI signals so the disable path leaves the
pixel rate source selection on the HDMI path, and pass the real pixel
rate for 128b/132b streams so a reference change rescales their DTO
instead of disabling it.

Fixes: 128c1ca0303f ("drm/amd/display: Update DTBCLK for DCN32")
Fixes: 8774029f76b9 ("drm/amd/display: Add DCN35 CLK_MGR")
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ mschwartz: dcn32 and dcn35 clk_mgr hunks only. The rest is HDMI FRL
  enablement, absent before 7.2, so the FRL conditions and the
  req_audio_dtbclk_khz assignment they guard are dropped and the
  FRL-centric changelog is rewritten. Added the pipe_ctx->stream check
  the new dereferences need. ]
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
6.6.y needs the dcn32 hunk alone and is sent alongside this one. Tested
on Navi31 with a DisplayPort UHBR monitor and an HDMI TV.

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 084994c650c4..285689d7ecc4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -276,13 +276,20 @@ static void dcn32_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
 		struct dtbclk_dto_params dto_params = {0};
 
 		/* use mask to program DTO once per tg */
-		if (pipe_ctx->stream_res.tg &&
+		if (pipe_ctx->stream && pipe_ctx->stream_res.tg &&
 				!(tg_mask & (1 << pipe_ctx->stream_res.tg->inst))) {
 			tg_mask |= (1 << pipe_ctx->stream_res.tg->inst);
 
 			dto_params.otg_inst = pipe_ctx->stream_res.tg->inst;
 			dto_params.ref_dtbclk_khz = ref_dtbclk_khz;
 
+			if (dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe_ctx))
+				dto_params.pixclk_khz = pipe_ctx->stream->timing.pix_clk_100hz / 10;
+
+			if (dc_is_hdmi_signal(pipe_ctx->stream->signal) ||
+					dc_is_dvi_signal(pipe_ctx->stream->signal))
+				dto_params.is_hdmi = true;
+
 			dccg->funcs->set_dtbclk_dto(clk_mgr->dccg, &dto_params);
 			//dccg->funcs->set_audio_dtbclk_dto(clk_mgr->dccg, &dto_params);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index bb1ac12a2b09..d154383a3961 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -264,13 +264,20 @@ static void dcn35_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
 		struct dtbclk_dto_params dto_params = {0};
 
 		/* use mask to program DTO once per tg */
-		if (pipe_ctx->stream_res.tg &&
+		if (pipe_ctx->stream && pipe_ctx->stream_res.tg &&
 				!(tg_mask & (1 << pipe_ctx->stream_res.tg->inst))) {
 			tg_mask |= (1 << pipe_ctx->stream_res.tg->inst);
 
 			dto_params.otg_inst = pipe_ctx->stream_res.tg->inst;
 			dto_params.ref_dtbclk_khz = ref_dtbclk_khz;
 
+			if (dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe_ctx))
+				dto_params.pixclk_khz = pipe_ctx->stream->timing.pix_clk_100hz / 10;
+
+			if (dc_is_hdmi_signal(pipe_ctx->stream->signal) ||
+					dc_is_dvi_signal(pipe_ctx->stream->signal))
+				dto_params.is_hdmi = true;
+
 			dccg->funcs->set_dtbclk_dto(clk_mgr->dccg, &dto_params);
 			//dccg->funcs->set_audio_dtbclk_dto(clk_mgr->dccg, &dto_params);
 		}
-- 
2.50.1

