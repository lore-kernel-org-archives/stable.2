Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E97E4AA1D2
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821129; cv=none; b=qorjDlri1KnigMVk5NX6wEu/UNSwJmh+HrdH3eygdZ4WkP44OishrB04jVAqwbyCYcpMCgtUMaXifI7VTxfDaeHG59XDvKhCA/IwqpqYym1TzEIpxRs2QVbc9DjJ5vS4ewJVpaMaTfcP+lwAQB6FOGcCAL1o7qaLJHBnWomtsLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821129; c=relaxed/simple;
	bh=WFAq8mEc7HB3T1AQknLs9hM4Ox/caKeT6GhAawR+7GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=da1MsFacDKfnpSrL8PRbzyQ4+KF0h/Alv3KdVSNMoLTIobzds2PejiFHWNCyDfMr9KDJEgeowbd1+0ao9fTDVkPU8nznSbHOK8kKmWVAJPJeU/760E1lbrcO4sicN1l4RR6Q4mjoESHC4dRdeQIKx9DQtHUPDQPR90JkJnMqAAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cinemaone.ch; spf=pass smtp.mailfrom=cinemaone.ch; dkim=pass (2048-bit key) header.d=cinemaone.ch header.i=@cinemaone.ch header.b=euInbC+M; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cinemaone.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cinemaone.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cinemaone.ch header.i=@cinemaone.ch header.b="euInbC+M"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j3MkX00ywzQ2y;
	Mon, 12 Oct 2026 18:05:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cinemaone.ch;
	s=20250113; t=1791821123;
	bh=Cf6l8RepzK+sxET5kIgarBzLV/aw/OgLCYxg27RgsSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=euInbC+MvxneaK4KrtjOEy496chLckMA9pkNCjyVOocLRyikyGN+IS1jYuN9jGB9e
	 WPJpupPJQ58e+abCUsYegL+2kCjSgsH4u5a1eD0X8zzeviNAx8ZUR/TPJg2Rog/ods
	 iYy9s5+4ep+WWQSkP5Fs5KE5AnNnU2taULvublpOzCR/sin+rrCl8PstQ0TRJEt6Mw
	 d0mLDsAdAXG5KDhxNusZpAaBek7hhVfCCFLw/jXRvMSxRzdTqub7vicx0soSBR5w9S
	 6IZhcBfYmI8xoekuJRFZnssphUnVXGNXiHECfi56FKpjSE3soFzlNXj9NY9610kkd2
	 Pe6693qhqjPLQ==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4j3MkW2zdXzJMm;
	Mon, 12 Oct 2026 18:05:23 +0200 (CEST)
From: Adrian Betschart <adrian.betschart@cinemaone.ch>
To: stable@vger.kernel.org
Cc: Dan Wheeler <daniel.wheeler@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12.y] drm/amd/display: Don't replace a sink mode that shares the native totals
Date: Mon, 12 Oct 2026 18:05:21 +0200
Message-ID: <20261012160521.8405-1-adrian.betschart@cinemaone.ch>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026101215-liquefy-flanked-b3af@gregkh>
References: <2026101215-liquefy-flanked-b3af@gregkh>
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
index 181606b4fd38..d21e9028b141 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6343,11 +6343,16 @@ decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
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

