Received: from server3.evolutia.digital (server3.evolutia.digital [95.216.176.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D8E55D87B
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.176.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992746; cv=none; b=HXTBKhsmPXPl9950ijZgzVhQ8L53Hf02brtQ3ahT3QcFeiJvApxbawh9qZQCnBU1QItFjldQENrovbS9J5HiuvJLxgIi2Sei9UCIIYfz5XAsKHQ5OhGiJvqCkdnjhZxH0VwwCivGos9tzErOAVkiYfqst3shXdhhGUBGtR345JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992746; c=relaxed/simple;
	bh=EEdj1gzQB2u2tfhxtq0hQwPGQ1y8VN1/0mWGHcYmylg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FaC8uZIdfAkdNe/2JckdpRah6gCAW67hue0ZMkXNeawus+wJ8h1jlkpD8jOKXwLmx/RY6p1CGBDUISgc7z+djsbZTeIzxbal95bXxxRFz0hdLL1U9azNRcO5bj1pZ4gnh4/widHTS4vFCQulSnZ8TJbvRJnrSc8vcf97WFHIJAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=miguelmesa.com; spf=pass smtp.mailfrom=miguelmesa.com; dkim=pass (2048-bit key) header.d=miguelmesa.com header.i=@miguelmesa.com header.b=BI4euVUV; arc=none smtp.client-ip=95.216.176.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=miguelmesa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miguelmesa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=miguelmesa.com header.i=@miguelmesa.com header.b="BI4euVUV"
Received: from B5-Miguel-CachyOS (unknown [IPv6:2a0c:5a82:6802:2000:3e7b:70b2:9267:6bd9])
	by server3.evolutia.digital (Postfix) with ESMTPSA id 60FDA5DE92;
	Wed, 14 Oct 2026 17:39:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=miguelmesa.com;
	s=default; t=1791992381;
	bh=X3rCDuYZqJNTQUGvfoz+Q2iEI5RvkLkUD7Fv9EV/OBA=; h=From:To:Subject;
	b=BI4euVUVIn4nPJEcFa4QDOldALTLhlRindx/9/X+pc8YjnLBK+NtsYJVrDzOgIT3G
	 M3sj+jycAu8i6L5frgiJXJMUda1hWkeb2+FEk7pRXQEJwebM0uvmV+iJ0I/86UkNwQ
	 VQslyEeSHuNJrJFzJ+7tLrYzZtG7gH1ZVC+RKN2D/BC8zTMAAeLfDl/MYYV3YMogAz
	 f765Wkt5szd8vzxD2284k2aQlzIOQQqgRKVMj6CLQpwQyd9Wide8qWEnuI0aA9LioK
	 9Hju72EzqCm0E9ijB7dDrye9YxXkk32cPzj7UtCL50piJr3Q0IY1szFLMftGW3wr8h
	 QpGAyoEtsED8A==
Authentication-Results: server3.evolutia.digital;
	spf=pass (sender IP is 2a0c:5a82:6802:2000:3e7b:70b2:9267:6bd9) smtp.mailfrom=miguel@miguelmesa.com smtp.helo=B5-Miguel-CachyOS
Received-SPF: pass (server3.evolutia.digital: connection is authenticated)
From: Miguel Mesa <miguel@miguelmesa.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com,
	Jerry.Zuo@amd.com,
	harry.wentland@amd.com,
	mario.limonciello@amd.com,
	mgorny@gentoo.org
Subject: [PATCH 7.2.y v2] drm/amd/display: keep HDMI 4:2:0-only modes and
 automatic 4:4:4
Date: Wed, 14 Oct 2026 17:39:14 +0200
Message-ID: <20261014153914.275253-1-miguel@miguelmesa.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261003131523.1502250-1-miguel@miguelmesa.com>
References: <20261003131523.1502250-1-miguel@miguelmesa.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <179199238121.3575658.3846878747342221603@server3.evolutia.digital>
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
Assisted-by: LLM
Signed-off-by: Miguel Mesa <miguel@miguelmesa.com>
---
v2: Replace the Co-authored-by trailer with Assisted-by: LLM; a bot
cannot be an author (Greg KH). No code changes.

Tool-origin note (Documentation/process/generated-content.html): the
patch and commit message were drafted with the help of an LLM coding
assistant (Cursor) during a bisect session on this box. The bisect
harness, the boot tests (v7.1 good, v7.2 bad, first-bad 7e5760f084d0)
and the final verification on CachyOS linux-cachyos-bore 7.2.7-3 at
3840x2160@60 were run and reviewed by the human submitter, who reviewed
the diff and takes full responsibility for this change.
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

