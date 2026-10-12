Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E5949E5FE
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821131; cv=none; b=RWa7OJ2omIM8tSIUNCPejUCi2cf0WlHsoSfycVFZz2F3aug3Bi/kIQygIpTqiZWym4kp9dVyZymEgVMK1ZuhbU6Tz64VfMMc+8tR8Pcsh9v1zPDV4QAa7pBZBvb1eFoeSVYAiTP5egMhBp2Sc1EWO7FLgSMBI8mQzSpFlCdHiXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821131; c=relaxed/simple;
	bh=Xn9MNQ5mt844wjwSg4h7WXR4Wbz/xxQ/gXYnDrMJ2wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSOx9ZnvTeNUNYJKRM4Wc/8BmhpOoCwDgbcySeK67FPYhzu+p80TJN5zFSKKzDntbGhgVDxau0sJ4JBrakS9kcJLExfywTXVLP4dGSc/h5ThsL6ppTD+W61HSJEwvwbNjxzDN9Q6qQekf5K2hPklzsrD0uEX3PaS5+8DbnCqxSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cinemaone.ch; spf=pass smtp.mailfrom=cinemaone.ch; dkim=pass (2048-bit key) header.d=cinemaone.ch header.i=@cinemaone.ch header.b=UgfG+xoj; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cinemaone.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cinemaone.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cinemaone.ch header.i=@cinemaone.ch header.b="UgfG+xoj"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j3Mkb6PxWzblt;
	Mon, 12 Oct 2026 18:05:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cinemaone.ch;
	s=20250113; t=1791821127;
	bh=LxbxlLp+19H8CYUXRkrPVaExJlICUCo61ZZy/kz9j1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UgfG+xoj4sULopI2PUb20BqZgdiykX8jeR+kQJjD3Bq/Cvj5Gm47QmI8XOCV4FSHs
	 bWx/kitzmAmaptzCGQ17HQ4jjDThUT0+k/J2f6OFAVzpyxVFjL0aPOOR4bBTVwQw72
	 CVLh9HQwN0cm14o6a1rYQfYOAHo9TS+ss8EufIGVtrj8cSVvEEYJDClYfZIstu3vaL
	 AQfrCoBim/43v2BnLzNHDBBpWEUTbP0WFvAFUGyn440wEBNpXJSkfBJ8Rjl+HAyNrZ
	 x4HTR+fhdWo46X722iyojILdSR8MKsSTwudjROcmBxpa2arHLKqzvrxbjThs8sg89s
	 8I3BnvcTpre7w==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4j3Mkb1QqgzMlB;
	Mon, 12 Oct 2026 18:05:27 +0200 (CEST)
From: Adrian Betschart <adrian.betschart@cinemaone.ch>
To: stable@vger.kernel.org
Cc: Dan Wheeler <daniel.wheeler@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1.y] drm/amd/display: Don't replace a sink mode that shares the native totals
Date: Mon, 12 Oct 2026 18:05:25 +0200
Message-ID: <20261012160525.8456-1-adrian.betschart@cinemaone.ch>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026101219-direction-scrounger-fdc4@gregkh>
References: <2026101219-direction-scrounger-fdc4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

decide_crtc_timing_for_drm_display_mode() copies the native mode's CRTC
timing into the requested mode when clock, htotal and vtotal match.
That is meant for the modes amdgpu inserts itself:
amdgpu_dm_create_common_mode() duplicates the native mode and changes
only hdisplay and vdisplay, so those are sent with the native timing
and scaled.

A sink can also offer a real mode with the same clock and totals as
its native mode. CTA-861 VIC 102 (4096x2160@60) and VIC 97
(3840x2160@60) both use 594 MHz and 4400x2250. With 3840x2160@60 as
the preferred mode, a 4096x2160@60 request goes out with the 3840x2160
timing and the framebuffer scaled into it (dst 3840x2025 at y=67),
while the AVI InfoFrame still carries VIC 102. A JVC projector then
reports 3840x2160 and shows a corrupted right edge. 4096x2160@24,
whose totals differ, is sent and displayed correctly.

Inserted modes keep the native sync positions; a real mode with its
own active width does not. Compare those too, so only inserted modes
are patched.

Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Signed-off-by: Adrian Betschart <adrian.betschart@cinemaone.ch>
Assisted-by: Claude-Code:claude-opus-5-5
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 22f9a2da101c37f821cd00954f81dc598754f4d5)
Cc: stable@vger.kernel.org
(cherry picked from commit 54c998c55fc9cbc391b350d67b86e0c2a0748f1a)
[ Adrian: this tree keeps the function in amdgpu_dm.c, with the equal-totals
  case as its own else-if; added the sync checks there. Dropped the KUnit
  test, its file does not exist here. ]
Signed-off-by: Adrian Betschart <adrian.betschart@cinemaone.ch>
Assisted-by: Claude-Code:claude-opus-5-5
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index deaf98957cb7..813b68217df7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5602,11 +5602,16 @@ decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
 					const struct drm_display_mode *native_mode,
 					bool scale_enabled)
 {
+	/* Inserted modes copy the native sync; a sink mode with equal totals may not */
 	if (scale_enabled) {
 		copy_crtc_timing_for_drm_display_mode(native_mode, drm_mode);
 	} else if (native_mode->clock == drm_mode->clock &&
 			native_mode->htotal == drm_mode->htotal &&
-			native_mode->vtotal == drm_mode->vtotal) {
+			native_mode->vtotal == drm_mode->vtotal &&
+			native_mode->hsync_start == drm_mode->hsync_start &&
+			native_mode->hsync_end == drm_mode->hsync_end &&
+			native_mode->vsync_start == drm_mode->vsync_start &&
+			native_mode->vsync_end == drm_mode->vsync_end) {
 		copy_crtc_timing_for_drm_display_mode(native_mode, drm_mode);
 	} else {
 		/* no scaling nor amdgpu inserted, no need to patch */
-- 
2.56.0

