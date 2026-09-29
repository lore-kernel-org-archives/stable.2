Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6953E4111
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 03:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651777; cv=none; b=hCyyWnPInY0hWZUlkW/ztLW4P2UHgCk79IsTE9bbBSvjvaPwHyi+RkZ/hNG0rC3oLwuVyQwYYXYKxsnQJhk1oHq13dhq1s4n0WpbdsQp8TW2MDoOkKCuVg07nL0rsF9ETAoygfzHq7AUUf7K+w0BZosycwCvchqPfNGJvsgcoHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651777; c=relaxed/simple;
	bh=pXcQeuuq4+KipFcyiYcoim2QdrvkaMHYe+s8t/1pgV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hWUnbuFiPN1w4LCml1/2bnZ5dcCOtiszBP0knSlTHzptzk3fm0j3I8V3sHH9in+VKJedQl7DGGVG79Yte95r5NK3K5o7vRNgG6crZLZmoi8bwv3nozuBW5SEUZWWrNiLcm7Z+BguL6n7AKBBnns9Wcb1KyB+ol3GHIC1DaXKShk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=DMp8TXe2; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="DMp8TXe2"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3428f70d7e7so2150656eec.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 20:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790651767; x=1791256567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ii7I0wGCyLeOvs236TbUzajnntIO2CSnGCaTsNpfSI=;
        b=DMp8TXe2nHWTqSPbHmLD1Sw4mGXcohd1tKij5XRJggELk4vhPVQSEVwuBsQQPQU3D2
         pRUs22zHcoqeNhwBBljpkfXSSR5SXUwqf4KFXgXgg81WYhDX1jzwaSsVBsiLjJRfa6v9
         pFE7XMXDciH2ngu8WiWZgeE5WUqtqQApPqSGRxUb968avAYiRsSXnZHtW4Wbk+z4CkUc
         8uQCDLB5vrZzTEYbRRvGC++97si4gUW60/eBKT5pLm+7M1Ys5KpxouWriyxNJQbT9WR8
         Zr8vlTH8VePPVuh7gSwcQWI1OfMp2I5XonrNeIygDS6hB1OBxeOHgPHMGllvV/nugqaG
         As1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790651767; x=1791256567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ii7I0wGCyLeOvs236TbUzajnntIO2CSnGCaTsNpfSI=;
        b=KZCT9XK2eviQSWUoktxi2WVBYG9ZS1CczTx3dJPS2kuh5+dI1TXpQl6ctN+i/3mLOv
         HLTkT/K5q/2xAMCmkPpZI6J9TSZn5hmAsuuqKexm3W0pbPcIvXCfHjNbWpuHwjeqH+iv
         epXoMhlGLWDa23gwnk5c4sfk5PiAVc9olFVRj0a9/ZX8Ys5hXVX25M/1dej4hyhUQ+k6
         t1USmxvUGNABIAb5eyZv/d5Nfi34LXjhPLHfXMZomv98MQQbFNPVBN273YJkleklxjDT
         8MjsNJiniZZd1Fg1AWEhQegiAUaiMKc9HoqVmV92scCNBFSXTGGFASyZX8mXUGoM8CL6
         1nOA==
X-Gm-Message-State: AFq9FYJAMFW+kPMOizkFEqLNT3urB9ocG6Y5GiUYlG1H/9HH0FFJAjGt
	kl91gVwjRZZbdg64dSwCbZ14AWuOIXgouXvA7rcOWSsIAsT0yd2aMfklNTwk8MF67KH8MKT0Ygr
	/DUl64Tw=
X-Gm-Gg: AYBFou3FTcADjKsj/Cq4Uy8fIUryhabJsAHNx63Pdpe8RtrurZaNyL4GY7gHIQ7U3rr
	PiqrLO9/lwLjDfNXDkDHseFRfiNdTDzkIRSeo5336VFyiWWKqpH68gxcA9/wLJUR2rwXm77iZOr
	AqlnJFPEcOLsEXAz9gY+apOIbd8lB1Q9Y7wt7gW8RntEHXJEJP166aVL9hYAjMcW8A5csTg7iXN
	R4USyqBTZYSslZ5EMEmmqxIqf+Z3Gxx6xTTrMyArnay9X7a3JPdra4/X9sD1OfNGZLum6UrZjkr
	Txqug/upzAD7FmRfglfXYV6+svF2997zwmrHUhOumt4jrPqq0i+XxxbOtz3ZXctMbWo7tC2rsWF
	lF2SrqIt/GOkEsA0mJiwIp6hy5J8z7yw4l0JavNPoernKftzafHSEVWf+pQyrwGR6RYfF8HASw+
	03MugeSiRxHyqpFPuv013NFvxyEaYjauY4Qj68lY+nL1YZ78hvDWt/Yqoo2Ya642NoDm7gftud/
	SJqOUoG0SlUkd1nX/Wl7joPwV7L0t7W4tQhb+Q8Jy6kv8JT19t3rx7umN7/bDTFlCBi3i04gf/n
	xrEeJQ==
X-Received: by 2002:a05:7301:7e04:b0:33b:c122:6bd4 with SMTP id 5a478bee46e88-342701bed7amr10369531eec.6.1790651766957;
        Mon, 28 Sep 2026 20:16:06 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm10711487eec.15.2026.09.28.20.16.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 20:16:06 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <xinhui.pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Simona Vetter <simona@ffwll.ch>,
	Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 6.6.y] drm/amd/display: Validate function returns
Date: Mon, 28 Sep 2026 23:16:01 -0400
Message-ID: <20260929031602.87583-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 673f816b9e1e92d1f70e1bf5f21b531e0ff9ad6c ]

[WHAT & HOW]
Function return values must be checked before data can be used
in subsequent functions.

This fixes 4 CHECKED_RETURN issues reported by Coverity.

[ Backport to 6.6.y: used the older dcn20 path and checked the applicable
  non-OK wait result; the surrounding D3-state case is absent. ]

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm amd maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-46775. It checks four display-helper results
before their output is used.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.6.y?

CVE: CVE-2024-46775
Upstream: 673f816b9e1e92d1f70e1bf5f21b531e0ff9ad6c

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c               | 7 +++++--
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c        | 3 ++-
 .../drm/amd/display/dc/link/protocols/link_dp_training.c   | 4 ++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 30a79dffbd37ab..b3f02f451535a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -144,7 +144,9 @@ bool dc_dmub_srv_cmd_run_list(struct dc_dmub_srv *dc_dmub_srv, unsigned int coun
 		if (status == DMUB_STATUS_QUEUE_FULL) {
 			/* Execute and wait for queue to become empty again. */
 			dmub_srv_cmd_execute(dmub);
-			dmub_srv_wait_for_idle(dmub, 100000);
+			status = dmub_srv_wait_for_idle(dmub, 100000);
+			if (status != DMUB_STATUS_OK)
+				return false;
 
 			/* Requeue the command. */
 			status = dmub_srv_cmd_queue(dmub, &cmd_list[i]);
@@ -405,7 +407,8 @@ void dc_dmub_srv_get_visual_confirm_color_cmd(struct dc *dc, struct pipe_ctx *pi
 	union dmub_rb_cmd cmd = { 0 };
 	unsigned int panel_inst = 0;
 
-	dc_get_edp_link_panel_inst(dc, pipe_ctx->stream->link, &panel_inst);
+	if (!dc_get_edp_link_panel_inst(dc, pipe_ctx->stream->link, &panel_inst))
+		return;
 
 	memset(&cmd, 0, sizeof(cmd));
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
index 6eebcb22e31739..2d87e85fdbac59 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
@@ -595,7 +595,8 @@ static bool hubbub2_program_watermarks(
 		hubbub1->base.ctx->dc->clk_mgr->clks.p_state_change_support == false)
 		safe_to_lower = true;
 
-	hubbub1_program_pstate_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower);
+	if (hubbub1_program_pstate_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
 
 	REG_SET(DCHUBBUB_ARB_SAT_LEVEL, 0,
 			DCHUBBUB_ARB_SAT_LEVEL, 60 * refclk_mhz);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 08c2f117241407..539f57858dfec2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1683,8 +1683,8 @@ bool perform_link_training_with_retries(
 		if (status == LINK_TRAINING_ABORT) {
 			enum dc_connection_type type = dc_connection_none;
 
-			link_detect_connection_type(link, &type);
-			if (type == dc_connection_none) {
+			if (link_detect_connection_type(link, &type) &&
+			    type == dc_connection_none) {
 				DC_LOG_HW_LINK_TRAINING("%s: Aborting training because sink unplugged\n", __func__);
 				break;
 			}
-- 
2.39.5
