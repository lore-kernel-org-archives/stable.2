Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1BA4A99AC
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821126; cv=none; b=sPF0tqZdxQXLqb431Hg9lcSjndZcERcyJl1FvuGHE5hU1LL36rQcbMpVy6NIRNGQcn1dtmjSjJJwL36b0IUVpOxHDfXW4DohiqnTQSwkfqDz/bjQ+bzqZyqOgRfSN1hbzIzy6H1IsNjoRd/XeenxcTfb2mLFlduhSHiY5PHyLQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821126; c=relaxed/simple;
	bh=/BboWUqOf65bWfaAszocHv6CTiq3icV2hktIX1fMSVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhpghkbeQwIxCjLDeKbm5IoImdj1Tl1MqrFFmpoTPoih1d4cYolq/AmTwjQUH0npnvmPc5/fczjkXrPLzkMKali7UmY9WpeseebwuVxlV3oqaNrn8xENlMAk30dAURjDtdMv4gEB3DuwbOd9iU40VvtjyoI7Vy2pJ2NKh8yz+dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cinemaone.ch; spf=pass smtp.mailfrom=cinemaone.ch; dkim=pass (2048-bit key) header.d=cinemaone.ch header.i=@cinemaone.ch header.b=n8XlFbxg; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cinemaone.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cinemaone.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cinemaone.ch header.i=@cinemaone.ch header.b="n8XlFbxg"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j3MkT4pX5zQX6;
	Mon, 12 Oct 2026 18:05:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cinemaone.ch;
	s=20250113; t=1791821121;
	bh=NBV717XEdH/SF7RKcwo0CvdvOJe4MNqIR9zuPbBtMk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8XlFbxgC7VXMyn55RloubFAA2XzrG3AOsmCfF7Vug2SnDpgvMdx6Xzm2jOvlvE/X
	 m77jaKmSZyfU1NF0xNQgPOo0H7Wx0kJWZLByFI5EXUJN7OZLyMCNZqPQzeaxe9IvbS
	 PagPvQcKmvt88zqHFe/D103Ijzwzx8gvIO+9+FeTBg3EZqzqG8PzA5sOwGfqYAjUTP
	 K1iDxdR3AT/stC0MnISxh4smRFkROdcaYw6ek6b15qCeYIJPU8TKpILhmTLyZfvqyo
	 dEXN65XtsELjz34zZDf8J0p9ikcwjhC6W/IAFgfxc0uj8EY/vXV8S9iyJ+ygk2fNSJ
	 fnoq9fwbpDxHw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4j3MkT0TXmzPCT;
	Mon, 12 Oct 2026 18:05:21 +0200 (CEST)
From: Adrian Betschart <adrian.betschart@cinemaone.ch>
To: stable@vger.kernel.org
Cc: Dan Wheeler <daniel.wheeler@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.18.y] drm/amd/display: Don't replace a sink mode that shares the native totals
Date: Mon, 12 Oct 2026 18:04:20 +0200
Message-ID: <20261012160420.8194-1-adrian.betschart@cinemaone.ch>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026101214-stimulant-aspect-4cca@gregkh>
References: <2026101214-stimulant-aspect-4cca@gregkh>
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
[ Adrian: this tree keeps the function in amdgpu_dm.c; dropped the KUnit
  test, its file does not exist here. ]
Signed-off-by: Adrian Betschart <adrian.betschart@cinemaone.ch>
Assisted-by: Claude-Code:claude-opus-5-5
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 19c3f56017ce..bb1fae39cd39 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6799,10 +6799,15 @@ decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
 					const struct drm_display_mode *native_mode,
 					bool scale_enabled)
 {
+	/* Inserted modes copy the native sync; a sink mode with equal totals may not */
 	if (scale_enabled || (
 	    native_mode->clock == drm_mode->clock &&
 	    native_mode->htotal == drm_mode->htotal &&
-	    native_mode->vtotal == drm_mode->vtotal)) {
+	    native_mode->vtotal == drm_mode->vtotal &&
+	    native_mode->hsync_start == drm_mode->hsync_start &&
+	    native_mode->hsync_end == drm_mode->hsync_end &&
+	    native_mode->vsync_start == drm_mode->vsync_start &&
+	    native_mode->vsync_end == drm_mode->vsync_end)) {
 		if (native_mode->crtc_clock)
 			copy_crtc_timing_for_drm_display_mode(native_mode, drm_mode);
 	} else {
-- 
2.56.0

