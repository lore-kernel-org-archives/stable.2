Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993792E62B4
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909990; cv=none; b=dJUO9IRSLvVKnpPatFa0oxz2iyi9p62hFAHHliCZkGXYWSFohFAFVWwEE1628hPYw3pnH4D5LmkVKH2MPrUkfgPGZuM1Qw3+A1UhayzG3ZLE6+0RiHiPjgEV5pp8pN+L4Ns7Q0rPFuXHd1iieAFVbCSYP775DlrYLd0hzGqMDSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909990; c=relaxed/simple;
	bh=dkCuiAK1kOD5p3u0nxD1rPOGHBlcIMgT85PKDMH0CA0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=huWFvlEy/IKPTQoVrrCee8fbRX6hLCjgXrifurDhi/rtKWlubxNt/OkhI1ukDsVNXcbeyF9cZgRUavXAp7DMAyhrwDf8S/Tdva1vzq3QE8dUGr8ehKK53upG6fG4G8hy0sHrB8GbNKgLDkkaJzhZuc89BClPhqvv/mF/bguL0+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=L88bmJO/; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="L88bmJO/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1780909980;
	bh=Zk1OdM/FO04pIv727zNRuWZ1i1r0L3Cf7ZaDQS1VgWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L88bmJO/r71yXV6q+vcPNR/8AIu6ZDR0VQJBz3OskZcszpfk9DLgpR+DL603GbEKd
	 rDypRroo5Wh2fZWEfoW38XbbtDJjWLCJxmrxDxxoTP4k8RRnNsqJGFKKuRWGJbmj+F
	 JCDaR/O+SX9tELVoIAXg3IJjFKXNv+UnzpHMryKg=
Received: from chafi-Matebook-Ubuntu.. ([117.25.98.102])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 32F830C7; Mon, 08 Jun 2026 17:12:47 +0800
X-QQ-mid: xmsmtpt1780909978t83o855lm
Message-ID: <tencent_AEC2C2C7582DD97B19BFA51196A256151F05@qq.com>
X-QQ-XMAILINFO: N1MQIlrHEcYy/L89GIYSaW/e9aFe/SJF0uC3bXmon5vt/U7LMi+32NnruVI7rS
	 KguiKs5agSU/BSXlNnpt5SKG2wmzDlD6o+xeAtnERJmcUWvCCL/OHsCCEIVIB6+QAIyN9mCVpKmg
	 ySA6IyaXMmXsalXWYryIoBMbg7vWQlK7XiYG6eEG8HBNK+oPzYCADVeCc/uJKfLrXPbNT+AuhwCp
	 eVKmXU89LvhPxAsgZdgvPoCfLZUwKbJLsApqdpq9AW4grP2XdzmmYU1Bg3TjgbOp/FyWPaZNP4Ar
	 EvuoXS1IB+t9ze07rifiT8lr5l6KRSTISC6DVFWom0wF6uB7Atapf8BmAJ7jVfLEa1U1ppz8uCzp
	 zOVIwBJLCeYafF5jNvOfG/WvDDxBab9ELsMziPbx3MwzSPWper5ONHYlDAujigFXDCrIbjLRwWGX
	 H4CfIuP5LHTaPYpKrh9MJYNWLVvDbZvqKLyems4IW6HJUPC1G/6U51TUVHqOVZ5YhHPErr2Q2y1r
	 RjpW6gqhW8mVBBvoBp1+F543cJ2Pn8xPNQRc8Xy8wwMmQse+fish1CxoU5XdWpvIp/GxBzSFSdY4
	 gHiENFpT8NBBS7rQortD24PeJyQWIeGEdL4W9FwAjK+tCzOB9tT35NsQOvl6uY8h1KLYC2b3nqn3
	 IfyDVmKKM+6geJy1ITDO1WLD/j/u8IG0o8oMAoRWtsTGHCNhP26rcqoCaaJLM7Swa7Il0QnVmm5V
	 6DNOSJE20cLQ7iyy512sPdDrsOMP3m0uwCKv1IWDx2yM2vf6kOMw/xDKR1cMaBKiK/24ZdlYPpj/
	 E22JlHuri4neDlDRNcP1OCw1RiP0dte5c7aONRyJ3vg3YCZor9vkFPyJ9UqufWtQVmZUyZlWh6AV
	 vTNS+/X1nKmaZq8c5mDlWqkF8MWu0sPzf5U7NcjFlhLZYLHhcKotuRZNox+JHKBkHISGhY1dERBw
	 0C4nwxTuJ63WTJ56g14YSYTkoTHoq4+LRUQREE4UcJ55/Yph+poWg3/iHdt1exHXApVpfbEFSi/5
	 yot/aS5Jr0BmO4gQUf34QTh4ythxgzjpmy+wNJAg==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: chafi <chafiprc@foxmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	Yu Zhang <chafiprc@foxmail.com>
Subject: [PATCH 2/3] drm/i915/dsi: Fix hsync readout for dual-link command mode
Date: Mon,  8 Jun 2026 17:12:43 +0800
X-OQ-MSGID: <20260608091245.462464-2-chafiprc@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608091245.462464-1-chafiprc@foxmail.com>
References: <20260608091245.462464-1-chafiprc@foxmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Zhang <chafiprc@foxmail.com>

gen11_dsi_get_timings() only doubles hsync_start/end for dual-link
DSI in video mode. For command mode dual-link, the hardware stores
per-link values (e.g. hsync_start=1380 instead of 2762), but the
readout does not compensate, causing:

  [drm] *ERROR* hw.pipe_mode.crtc_hsync_start (expected 2762, found 1380)

Fix this by applying the dual-link hsync doubling unconditionally,
matching the SET side where hsync is now halved for all modes.

Fixes: d1aeb5f399d9 ("drm/i915/icl: Configure DSI transcoder timings")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <chafiprc@foxmail.com>
---
 drivers/gpu/drm/i915/display/icl_dsi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index c667d5941..f579cba28 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -1527,11 +1527,9 @@ static void gen11_dsi_get_timings(struct intel_encoder *encoder,
 	adjusted_mode->crtc_hblank_start = adjusted_mode->crtc_hdisplay;
 	adjusted_mode->crtc_hblank_end = adjusted_mode->crtc_htotal;
 
-	if (intel_dsi->operation_mode == INTEL_DSI_VIDEO_MODE) {
-		if (intel_dsi->dual_link) {
-			adjusted_mode->crtc_hsync_start *= 2;
-			adjusted_mode->crtc_hsync_end *= 2;
-		}
+	if (intel_dsi->dual_link) {
+		adjusted_mode->crtc_hsync_start *= 2;
+		adjusted_mode->crtc_hsync_end *= 2;
 	}
 	adjusted_mode->crtc_vblank_start = adjusted_mode->crtc_vdisplay;
 	adjusted_mode->crtc_vblank_end = adjusted_mode->crtc_vtotal;
-- 
2.43.0

