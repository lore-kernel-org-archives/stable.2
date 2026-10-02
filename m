Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306784BC01A
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969891; cv=none; b=OhV34H+E7NXEJlAOnpAIuyLFnfFDGq5Y6TRZ6B3SexxwwxWAoeHcT1jOiYDpqsksmB3VlCUtQhKUh9SHI4PuepJ67vJZTRJMufpK7BtA8KLkPhNRPqRDrfejJtrEvlb+dK00nIoH09Ed7HCunDy4PjzPkOq/cKMVeWMjQan8PBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969891; c=relaxed/simple;
	bh=QEO0aILy9z4JGdIIPQYRUNlkoPgqNfk0ePWg3gHPOAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LLCYxP8F2/hfrK4RdVbe6s2B0aDYDp5FFZPfSQi3SDmDxtT1UDPKwjtR9Yibbbb+vQCA6XHD/Eil84sLAIfzSkZ3SYR4fqw2IVeW6RDBdUN/1GFRZLZtobGCEJP+ghgXLbJfKKX8sua3SW4/NW2H0lPKJhaekMuJwn5tAid74MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=HAgzcRXa; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="HAgzcRXa"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-149241d04f5so301316c88.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790969878; x=1791574678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EGgEtdhM8SzSotKxZXA7cTlPWzHiA22Nw8COOnRZiR4=;
        b=HAgzcRXaHs3tN0+Mvxi6cKTmEP2gYUEJ0oryLP/pXYzGWG0hfoEx3vtDcLTPknZGaj
         iuNewsHsJ7wrx+925FD2b5IqFkmWyFFhkHK/fGm/kfeSUbNw0gOt6VexeOZyqSwM3h6r
         azNcOm9Qy+ffaxi2xgL47rInf5njuwbikUkLS6vqfU5JIgkUszNhQhUKrf+VhtfB2kG9
         vbeRIJO44bOJsB8fW8opL4pQsKrh1F3TiKOeQy7nr8GBGN3ic/ypFeWXz64F9E8eH9qC
         YwgP8eVjZfDIK3aPZaKP4nYHN23xlsI3NuO4n4IjL47VVddyU8qfal75x9VbyDN81pCe
         9LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790969878; x=1791574678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EGgEtdhM8SzSotKxZXA7cTlPWzHiA22Nw8COOnRZiR4=;
        b=Uq/gh4RP8pWzKJolwNU3K+U/6S5rzo9u3qCH609BocjqeaWvlEv31h4O6ncpkfQH3f
         uaj0wOkQdKFyGup3azZSJ5vUiv8dMiTS8LYFpo+1xG8aSz5kh57cqdRerUC7UNvlhHk7
         tHsja4UdWzIa8zA5q0aDuBeqLY2Xj7Z2ThsuFc9L+nJdSw/iDyjAqQXKvqw84AOey1tI
         +KKVyYOGe/MrWQr3JS7p6pCGPCa/72deg9aTW8piNlBgf0i0V5+6ZYuXfqBqB6CerKQu
         HuguAL4D/vXOREKsinJC5bYdJHfY7nUafmjymjV3LQthEhshoQzYbaaIcIFTnX1Rndb6
         U3kA==
X-Gm-Message-State: AFuF++nSFIG5BKaOH+Th5AfslKRRM9YbilmkB40YqKCB7DUl1jMjkF6t
	OOYEw6kf3wySXywFgWvcdmcOk8XEohR7JgOFPZhgQz2ycMcM1oZ3R2dsoH94soGAJTH9IOQAkXJ
	8n+qpH/NnzQ==
X-Gm-Gg: AYBFou3ebKNXpew3cKxCJMvcVW07LeDFPmep/dR2X+8wMqFrlP37DFLzUbZtNP0/Ad9
	hb8ncb86lXY5nMsJMLp0LmyN99VVK+Me/EdrNOBpsojH5y7rRq9qGSfAsYGVZmey24IDtEq5TY0
	gx0Y89gsRqJ6mwBt/AkX3oBnAL5y4NNGcnRHz+SjxYT311Uk275vlu/NDAkwjY97sRB7O/aBzg1
	/VYbcTu8Eco3w25F+riVMUfWLcTk7LS2ricL0EPipLFmcKVEsy4VN0Y4a/Vf8xzg8TOLaq+Ue5f
	2a6/GIE8cIVOFSJn6w6TVrw7Fb88a2H/xxuYTawV78LZIWL+JH7xKgvKxVizKUWoi33wPDsBlW5
	rvtD+YmKCGUvD1CbeGrf4krUvjjLwpelM8HoXIITl3rMur195PzNhIXIGXvcbu7Ip8VxUiWQjWp
	MUMJApzcX5CMERFbjjjZk/J1EujTXv6ce6qNGPKmRm8wy4nJpLwUMNh6dapZ08yVpFP3MByMf8u
	3HP39nvFd54Gm7XzquI/ljUSb0W9hXDDQKK6NwSG+Q+w9oko39KLUOmFs2qc6X0Sayh98LAD5J6
	Sry/SQ==
X-Received: by 2002:a05:701b:4518:20b0:149:49c:233 with SMTP id a92af1059eb24-151c38af23amr469208c88.27.1790969878266;
        Fri, 02 Oct 2026 12:37:58 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bcf9:6140:24a9:d1e7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14fae9b3dfesm6642483c88.11.2026.10.02.12.37.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 12:37:57 -0700 (PDT)
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
Subject: [PATCH 6.1.y] drm/amd/display: Validate function returns
Date: Fri,  2 Oct 2026 15:37:52 -0400
Message-ID: <20261002193753.20239-1-artem@trailofbits.com>
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

[ Backport to 6.1.y: adapted the visual-panel, watermark, and
  link-detection checks to their older locations. The upstream DMUB
  run-list/D3 path is absent; the older dc_dmub_srv_cmd_queue() already
  checks and logs idle-wait failures but, unlike upstream, still retries
  the queue once afterwards. No DMUB queue change is included. ]

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm amd maintainers,

I am working through the small CVE backports still missing from 6.1.y.
This one addresses CVE-2024-46775. It carries the three return-value
checks that map to 6.1.y: visual-panel validation, p-state watermark
propagation, and sink-detection validation during link-training retries.

The upstream DMUB run-list/D3 path does not exist here. I left 6.1.y's
older dc_dmub_srv_cmd_queue() unchanged. It already checks and logs the
idle-wait result, but unlike upstream it still re-queues once after a
failed wait, and checks that re-queue's status.

The corresponding 6.6.y backport is already in the 6.6.y stable queue.
The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not
in 6.1.y.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.1.y?

CVE: CVE-2024-46775
Upstream: 673f816b9e1e92d1f70e1bf5f21b531e0ff9ad6c

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c    | 3 +--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c        | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 82b747c0ed693b..1d3d9a82c4637d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2808,8 +2808,7 @@ bool perform_link_training_with_retries(
 		if (status == LINK_TRAINING_ABORT) {
 			enum dc_connection_type type = dc_connection_none;
 
-			dc_link_detect_sink(link, &type);
-			if (type == dc_connection_none) {
+			if (dc_link_detect_sink(link, &type) && type == dc_connection_none) {
 				DC_LOG_HW_LINK_TRAINING("%s: Aborting training because sink unplugged\n", __func__);
 				break;
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 31bb7e782c6b1d..35e8f22d30204b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -396,7 +396,8 @@ void dc_dmub_srv_get_visual_confirm_color_cmd(struct dc *dc, struct pipe_ctx *pi
 	enum dmub_status status;
 	unsigned int panel_inst = 0;
 
-	dc_get_edp_link_panel_inst(dc, pipe_ctx->stream->link, &panel_inst);
+	if (!dc_get_edp_link_panel_inst(dc, pipe_ctx->stream->link, &panel_inst))
+		return;
 
 	memset(&cmd, 0, sizeof(cmd));
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
index aacb1fb5c73eb5..d2eebe39a55e33 100644
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
-- 
2.39.5
