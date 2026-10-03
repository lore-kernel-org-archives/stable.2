Received: from server3.evolutia.digital (server3.evolutia.digital [95.216.176.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303BF282F10
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.176.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033705; cv=none; b=C8W+D8abcXpGAP6eJ/ldnNuaYLNBP96D7sgtpxVm8cBU7xgLYexnCZpOBk645YFzs6bWSNnp2UQGcXx99VihTyr6FQAvkr1vJmENbLCkuDBp7i0XJJkoDEjO8gw7KaSdNCJLPxbboxab/sBwup1lkXHYjlZQ28F+LaJxDfR9BSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033705; c=relaxed/simple;
	bh=qH2AQmQjX+DJlFX+o9BUmNXHsYxdOrnLpzoDX17+cuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rrvUojF762NRg8cwkTLe4BDuOXRmKYOFoUki53AG04lo35QURG4vSgFpnOJokXF4UMuE47VdgUBg0ePdVlenimgURc++gje8R+3SBPImIfWhH9+lJ049DzWBfQMdO34zi8D8u47T4Y4th8WvTElpkI/Hrt4KIl94+cLmpZYzJ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=miguelmesa.com; spf=pass smtp.mailfrom=miguelmesa.com; dkim=pass (2048-bit key) header.d=miguelmesa.com header.i=@miguelmesa.com header.b=EhT2JyLl; arc=none smtp.client-ip=95.216.176.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=miguelmesa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miguelmesa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=miguelmesa.com header.i=@miguelmesa.com header.b="EhT2JyLl"
Received: from B5-Miguel-CachyOS (unknown [IPv6:2a0c:5a82:6807:b100:7760:f7b:d596:dc10])
	by server3.evolutia.digital (Postfix) with ESMTPSA id 39FDE5F6E5;
	Sat,  3 Oct 2026 15:15:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=miguelmesa.com;
	s=default; t=1791033343;
	bh=yn98FbPzE/tOS7dn54Zd2oHA8L4Zsp3fkAu0+jWzZ/s=; h=From:To:Subject;
	b=EhT2JyLl9qWgmKPNSfyJobl8j/CP7sJYDfMvsqPJA5ahOnkEFZztYKSEB8TrQxPUi
	 TckyJl7d3GJ+Jq2DAcqopWhMJ0FOzaXbvzAM8irFR4x04lAjTvY4qqc1c24H6fekk8
	 emrUUwaSyLa1aKAoYJbndeLHTeAgBeQQnhLkXcx6nNdRzbBtn0f3MDBPff0bDK/Pme
	 XYVWqjzQiNVHMWXRjvHC7qdfk1bFNs//uQobti35aA7rSB70uMTa7YuKMHOp6biBR+
	 uhRg+KhLoIuSxID9qnaGCNQmMarK8zY/PYdT4+jkcV5z/zq0Z+dNBirJHUEmmFR1G2
	 nT46Kb8H1FL5Q==
Authentication-Results: server3.evolutia.digital;
	spf=pass (sender IP is 2a0c:5a82:6807:b100:7760:f7b:d596:dc10) smtp.mailfrom=miguel@miguelmesa.com smtp.helo=B5-Miguel-CachyOS
Received-SPF: pass (server3.evolutia.digital: connection is authenticated)
From: Miguel Mesa <miguel@miguelmesa.com>
To: stable@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com,
	Jerry.Zuo@amd.com,
	harry.wentland@amd.com,
	mario.limonciello@amd.com,
	mgorny@gentoo.org
Subject: [PATCH 7.2.y] drm/amd/display: keep HDMI 4:2:0-only modes and
 automatic 4:4:4
Date: Sat,  3 Oct 2026 15:15:23 +0200
Message-ID: <20261003131523.1502250-1-miguel@miguelmesa.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <179103334296.2856106.18265595604110516429@server3.evolutia.digital>
X-PPP-Vhost: miguelmesa.com

commit 7e5760f084d0 ("drm/amd/display: add HDMI 2.1 Compliance Support")
selects YCbCr 4:2:0 for a 4:2:0-only mode only when the IGT override asks
for it, and YCbCr 4:4:4 only when that override is YCbCr 4:4:4. On a
normal boot the override is unset.

A 3840x2160@60 mode that the sink lists only in the YCbCr 4:2:0 block
then falls through to 4:4:4 or RGB, and the Wayland session cannot build
the output layer: kwin_wayland_drm: Failed to create framebuffer (EINVAL)
right after login. v7.3-rc5 selects 4:2:0 again for those modes when the
color format is automatic. Do the same here, including HDMI FRL.

Keep automatic YCbCr 4:4:4 for the other HDMI modes, as 7.1 did. The TMDS
depth fallback also runs for HDMI FRL, so a mode that does not fit at
4:4:4 can still drop to 4:2:0.

This is not a backport of a mainline commit. The 7.3 fix is the rewrite
in 0b0ff65d3c ("drm/amd/display: Refactor stream validation"), which
cannot be cherry-picked to 7.2; Jerry Zuo confirmed the pre-7.3 logic is
gone there. This patch restores the pre-regression selection on the 7.2
code, following the v7.3-rc5 rule. Mario Limonciello asked for it to be
sent to stable in drm/amd#5760.

Regression: black screen after login on HDMI sinks whose modes fall
through to RGB, e.g. Strix Halo (gfx1151) + TCL 4K TV whose 3840x2160@60
is YCbCr 4:2:0-only (VIC 97). 7e5760f084d0 shipped in 7.2; still unfixed
in 7.2.9.

Tested on CachyOS linux-cachyos-bore 7.2.7-3 (znver4) on that Strix Halo
box: Plasma runs at 3840x2160@60 with the same userspace and firmware
that stayed black on every stock 7.2.x kernel.

Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5760
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5893
Reported-by: Michał Górny <mgorny@gentoo.org>
Reported-by: Miguel Mesa <miguel@miguelmesa.com>
Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Miguel Mesa <miguel@miguelmesa.com>
Signed-off-by: Miguel Mesa <miguel@miguelmesa.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e594548..8f60df9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7017,9 +7017,7 @@ static void fill_stream_properties_from_drm_display_mode(
 	/* TODO: un-hardcode */
 	if (drm_mode_is_420_only(info, mode_in)
 			&& (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
-			    stream->signal == SIGNAL_TYPE_HDMI_FRL)
-			&& aconnector
-			&& aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR420)
+			    stream->signal == SIGNAL_TYPE_HDMI_FRL))
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
 	else if (drm_mode_is_420_also(info, mode_in)
 			&& aconnector
@@ -7034,8 +7032,9 @@ static void fill_stream_properties_from_drm_display_mode(
 	else if ((connector->display_info.color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444))
 			&& (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
 			    stream->signal == SIGNAL_TYPE_HDMI_FRL)
-			&& aconnector
-			&& aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR444)
+			&& (!aconnector
+			    || aconnector->force_yuv_pixel_format == PIXEL_ENCODING_UNDEFINED
+			    || aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR444))
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
 	else
 		timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
@@ -7104,7 +7103,8 @@ static void fill_stream_properties_from_drm_display_mode(
 
 	stream->out_transfer_func.type = TF_TYPE_PREDEFINED;
 	stream->out_transfer_func.tf = TRANSFER_FUNCTION_SRGB;
-	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
+	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
+	    stream->signal == SIGNAL_TYPE_HDMI_FRL) {
 		if (!adjust_colour_depth_from_display_info(timing_out, info) &&
 		    drm_mode_is_420_also(info, mode_in) &&
 		    timing_out->pixel_encoding != PIXEL_ENCODING_YCBCR420) {
-- 
2.56.0

