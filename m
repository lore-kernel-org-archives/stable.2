Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D014A43E8
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821132; cv=none; b=aD4miShekGsLAQZ7PQEnZCCLmNlIcPq28PmdFR042gYAtrmi/B40Jffp9tE8vLdVYPnPXcXdLRoHA/PtQ3vKkYjE0MUII+fSF6UjtNmvliLuY+KRSpACdmygL/KLTldHDIB8kse4ToLBgIylGqD07RR5BEXlYWQbLGmKVFvgcSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821132; c=relaxed/simple;
	bh=4BT6LOYRmnIYYrPoztCbF+ZJ0CJAneEp7z8sGX3vsBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dp4YTY9JB0mMRMqBOUoJE6WZRpANNHhfRKmBKmi9VLpMzhOz5BD/79CbX5ioVOKruMzmVUXBFwFSI1LffzjzfodKSdNZQKonC+FHuu1he7lbGmcWYX5sO63s8XBtTkV3fZGNvX5+Gq9Eo93qA4SpLGcN3AaTA+/agmHTYY+F/B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cinemaone.ch; spf=pass smtp.mailfrom=cinemaone.ch; dkim=pass (2048-bit key) header.d=cinemaone.ch header.i=@cinemaone.ch header.b=uPXXbID/; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cinemaone.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cinemaone.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cinemaone.ch header.i=@cinemaone.ch header.b="uPXXbID/"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j3Mkd3cdfzbD1
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 18:05:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cinemaone.ch;
	s=20250113; t=1791821129;
	bh=esMBntYmGpPlyCLgg0PB6Ja7oCtVa0NhIrVxxK5Ou08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uPXXbID/cFKw50otF3373kUlvcs0rI+ijMJ8ZfC/VmD3CCbOB74f9yMj0s8CzBKVd
	 XIVRg1u7dINY3706WmgHHXeUtEDiGY3UBEYa7d87GGcUCcXHJr0NCu8aVb/EShebMw
	 EG3ZS/mzeMNSreZp1FQm8LV/MeTlWCwO062zmT9N3jVkdqRUhvnUto84PAUCw1mrIF
	 fjpgQX5a40pi+ZD/GDFZUzuEsqj2q5bHwpUHSGeXZEIyUJysaZcbwwn4xNvuYm9fGD
	 ztX8i4SbXfTL/Oi0JCYTaS5qXhsftbQLvPnq9rEFWIbXcsj7MTjTKE7TC/YMlqqynE
	 hVOoEAsDFRqWA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4j3Mkc6thWzHps;
	Mon, 12 Oct 2026 18:05:28 +0200 (CEST)
From: Adrian Betschart <adrian.betschart@cinemaone.ch>
To: stable@vger.kernel.org
Cc: Dan Wheeler <daniel.wheeler@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15.y] drm/amd/display: Don't replace a sink mode that shares the native totals
Date: Mon, 12 Oct 2026 18:05:27 +0200
Message-ID: <20261012160527.8479-1-adrian.betschart@cinemaone.ch>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026101219-ecologist-overripe-ff1b@gregkh>
References: <2026101219-ecologist-overripe-ff1b@gregkh>
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
index 4530d2213935..39614d5dea40 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6024,11 +6024,16 @@ decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
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

