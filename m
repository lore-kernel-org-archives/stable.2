Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869556;
	b=C8DewTY2m17d2yXwrMi+SziZowCUFAxZNMK4JFb/Ccrlav6e3mWfRMA633x4aiEXPy1+
	 5OzPx2S9bLgMOgMSLNoeN/Kf8VEQaIqBfEC7KxH82mjtBlxvwj6Ea4Ycs/5ni91TiqmUV
	 3Xdh65BqQBrmEeMLuuSBJk5DJSsIm3pMYY4mu/1DEXInRLlQxMgt+9KcXsxlSjKyuD5fh
	 FN675rJiybOqabX6w0fBTtKmNVCUF2+wEUhbmCCWJvKjRwgZSMacSLTd9YO0Sj4vTzKe6
	 UaplttUvTTDKqCzOAw7woCJzUSFq8yyvYFHV2tymG6rFn7xNC/ITy1gBZ0LulkTAPlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869556;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vuFECZ4EHZrEeMpVma1G6wBxYe3WeT+cWYlUS2SwRHw=;
	b=gR2UzzUcL+G5JduiHpu2g6k5osyYdgBB8URoT74DemzP06DF6vBBQSEqIxTUz0YM7Xhu
	 sx74xsWWhiKXAenvb+ZBlSuO0x19YJnJHTy1MVGIct+rXBbxkJZjVs1MffxXc91Uyju0e
	 /Bj7w8iXu7u2C0WsYKZPk666u6cshkl9vkUDGRI9T1awMU1lfOp8p+Kyc8cRv0pWqM7U7
	 1fL0HaUoAT7N1eGkb1QIMljr7S3BDtYRafMmVxXNZgi/Pf547G95zBKgOoK2s37jztJCy
	 yEPahe2R0cY84uRGFYZRdego7AmjOQn8vjRW4yPjDoDSY0POGzewiRQM44Pr9saP29g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291F3606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 09:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 291F3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1799a95ed8f811f19a56ed5b684f684d-20261105
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:4919fad1-8fb8-4cf6-acdd-6e9e921fbd01,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:7f8c8dba8eabc189306fe75811240ca5,BulkI
	D:nil,BulkQuantity:0,SF:102|123|136|850|865|898,TC:nil,Content:0|15|50|99,
	EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1799a95ed8f811f19a56ed5b684f684d-20261105
X-User: jiangwang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1781901378; Thu, 05 Nov 2026 17:05:48 +0800
From: jiangwang@kylinos.cn
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com,
	nicholas.kazlauskas@amd.com,
	Rodrigo.Siqueira@amd.com,
	harry.wentland@amd.com,
	Wang Jiang <jiangwang@kylinos.cn>
Subject: [PATCH 5.15] drm/amd/display: skip pre-flip post_update on DCE
Date: Thu,  5 Nov 2026 17:05:43 +0800
Message-Id: <20261105090543.930342-1-jiangwang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Jiang <jiangwang@kylinos.cn>

The v5.15.119 backport of the dc_update_planes_and_stream series
(commit 3c1aa91b37f9 "drm/amd/display: Add wrapper to call planes and
stream update", upstream commit 81f743a08f3b) made
update_planes_and_stream_adapter() call
dc_post_update_surfaces_to_stream() before every UPDATE_TYPE_FAST flip.

In mainline that series was merged in the same cycle as commit
32953485c558 ("drm/amd/display: Do not update DRR while BW optimizations
pending"), which restructured dc_post_update_surfaces_to_stream() so
that disable_plane()/optimize_bandwidth() only run on DCN, retaining the
legacy behaviour for DCE.  That companion commit was never backported to
5.15.y, so on DCE every desktop flip now runs disable_plane() for each
unused pipe - an ATOM enable_disp_power_gating VBIOS call each - plus
optimize_bandwidth() immediately before the new surface address is
programmed.

On Carrizo (DCE 11) this occasionally wedges the active pipe: the
surface update stays GRPH_SURFACE_UPDATE_PENDING set forever and is
never taken, GRPH_PFLIP never fires, drm_atomic_helper_wait_for_flip_done()
times out and the desktop freezes.  When it hits the first desktop
commit after boot, the pipe scans out zero data, which shows as a green
screen on YCbCr 4:4:4 HDMI outputs (black on RGB/DP).  A VT switch
recovers because the full modeset reprograms the front end.  Wedging
boots also show "atombios stuck in loop" in the EnableDispPowerGating
table and smu8 message timeouts.  Later modesets can deadlock in
dce_mi_free_dmif().

This is the same class of regression that commit 62e5a7e2333a
("drm/amd/display: Fix surface optimization regression on Carrizo")
fixed for the previous call site in dc_commit_updates_for_stream(),
which the new adapter path bypasses.  Mainline is not affected (DCE is
guarded inside dc_post_update_surfaces_to_stream(), later cleaned up by
commit 9571dbaf98c8); 6.1.y, 6.6.y and 6.12.y all carry the guard.
Only 5.15.y is missing it.

Restrict the pre-update call to DCN, matching mainline behaviour.  The
full mainline rework does not backport cleanly; this is the minimal
equivalent for 5.15.y.

Tested on LENOVO 90K7S04400/3141 (Carrizo, Wani [1002:9874], DCE 11,
BIOS M25KT37A): without this patch the wedge reproduces within minutes
of desktop use on 5.15.120 and later; with it (and on v5.15.110 which
predates the series) it does not reproduce.

Fixes: 3c1aa91b37f9 ("drm/amd/display: Add wrapper to call planes and stream update")
Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
---
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -376,7 +376,8 @@
 	/*
 	 * Previous frame finished and HW is ready for optimization.
 	 */
-	if (update_type == UPDATE_TYPE_FAST)
+	if (update_type == UPDATE_TYPE_FAST &&
+	    dc->ctx->dce_version >= DCE_VERSION_MAX)
 		dc_post_update_surfaces_to_stream(dc);
 
 	return dc_update_planes_and_stream(dc,
-- 
2.34.1
