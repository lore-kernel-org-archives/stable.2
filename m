Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795803726;
	b=sl/wGgXPuqF0rqniSkdOylnLEJrxqB8h1acLfT1S6W8Ly53bOP1ScBTxwjVQl8/8/pk0
	 Foj2KcufYBmfasGa9bkMQ0vlDhdW9WwxzUP7tPRfAt4y5XyZ383NmPo9xabujBiBiNkkc
	 YGzlcfe6tTiP5sZuoRoEs6wWh5cNWFhAC5B8VDzoG2OwzXRBDzRIApRgnjLmh/DaCYnm4
	 0APgOyXUDdEtPQkFqh91eUHyZ349fNpnYD76bJK9zHFfghdgp27IthgY/4rO1030gPLfI
	 hCRq0ehKGspbMwHdELfqL/iZyd21BqiuOtgLgR/TfmZuDDsxs+Y0tttEvBc6bUcNZng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803726;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VO2MI/YunwrxUfZfJWsCAxUoYcyw7ievfDccX9DC3Mo=;
	b=IZSCIGzV8pL1VtioIJkZLym+Fx/wvr598RCzzEzRnqT14WAPmxt3IoaFtMCTC4KAWa8F
	 PHrAc4STgewcjtB0XWx08T1TdolfKN1b/xEk2Yb2jYx9NZsO8g1IBPx1Eml3rOtSDDcJS
	 NQyU0nMB0EB3k6+4D5k5TXkkkUYnQJUyDZHewTYiy7/qt+X0b31i9AXPpqofvAyt8emJx
	 v67hTX/kCnLgua65nnfCA2lsU4IMSqPbdkQSZhFPvztpqSAQGhgojdglWXMyyCIyU41TT
	 zVUJafE1exGR2d5GCLSs1HGbUuXP7OPHh+RKexOEyplAW/bQaIS0kmkYQHD8/9tltIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m0nBNQOb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D9A606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m0nBNQOb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795803725;
	b=GzfNzhyR/28gtvbaiBTK1GLk8jxzh8dmSr0+3fB/CemrIsD5gIYhzdR0KEqfdDYhWz1U
	 x9LwqAFFqJnGpUGVL+SO/4KjVBMf4oC0V47EjGwmsvkntt1INZxodHbbd+kAH4JKXV1kV
	 0CObw5Y5gkp4BC0TY1/RrTjLOpjMuhgqRNCD3iu6HycI1EMS6s2g4rDgsMB3gMRZ+Tcg/
	 BbytcAQCH7aRjnRvWngSyqUngdc6KnhZwbsFkbEJOkcWsM0UWET5gI3bAv8f1amjAF3zA
	 JbUn+9ESlUj52+lVAsLrBlhtFF1Y+uQXhml/rCLNQeRo+RPy96hKCeiVaKvDjlgz4Uw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795803725;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VO2MI/YunwrxUfZfJWsCAxUoYcyw7ievfDccX9DC3Mo=;
	b=VHRaBGW4dM/jfOjVf0whePhYd3dfLF6roLMWoGT7TiLlp7jNcJtAa4MP3i74/W6JAEwX
	 ddUPFMkvgT3muFBSMl2gs9KNoR/hhvLDwwoBwv1pkG/vJ9kCFBvLx92bAx1jHGGzHxblw
	 cKMtV76as9lfv8jjlEOP85k3RSd1djVZ68hDGQWKWIQ8EtlfVr+l2GACrpnfx4h3McbEL
	 Jgx4sZRsQ6/ovyF72nfghk6UOVfi1+vac7sPuac4NHRiHjWK1LiA4VXu1lCySo9d2qK0y
	 dJZk9bI42k9ffHL6ssDIfLTbh1sE31fJXo069zK/1FX7FuFgsLxq73MhZFOiphrg/UA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C2D821F00897;
	Fri, 27 Nov 2026 18:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795803725;
	bh=VO2MI/YunwrxUfZfJWsCAxUoYcyw7ievfDccX9DC3Mo=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=m0nBNQObplJws0Ityly9un82+TYnIh4QMtuKCtBV3dYUX+FGKkdtG/QuTY0JsKUHj
	 AAm+M0KVUNNhZYe3nzmvY5iy1fsiO4wdJa/o8kK7SyeFrCeOqhiOpcFQJeDMrSRpUd
	 9BTWcbnU33c+MVoDefAPZFHKpQ8b0Rcv+egO/EmKnNhPQqzmO/FfO6kfZ7nkde0sLl
	 FBhDXNCCH7xCIe7iLGPbSDTljH4iEMhto2ZvpewA5WtiXpaozWeFuIhhTPDitLh688
	 eGJ4ZM9yT5pWHZ+Mz/YyaxrW4ilt+6N+8yk3um+1+aZMIbm9+v85Ohhp3yEWAhbXsa
	 dS+WUpVP5bDlQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4F3CC4DD0A;
	Fri, 27 Nov 2026 18:22:01 +0000 (UTC)
From: Ani Aggarwal via B4 Relay <devnull+antiani100.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 10:21:52 -0800
Subject: [PATCH] drm/i915/psr: Add quirk to ignore PSR setup time on Dell
 XPS 15 9520
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-xps9520-psr-setup-time-v1-1-692c17859301@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CQAxFr0K6tpGpYKJXMS6YoUCNDJN2MCSEu
 wu6fD//vRWMVdjgXqyg/BGTKe7gTgWEoYk9o7Q7A5V0dY4qXJLdaioxmaJxnhNmGRkDVe2ldhQ
 68rDLSbmT5Rd+PP9ss39xyEftePjGGL02MQzHNKn0Es+tjigx8xsjLxm27Qum12K/ogAAAA==
X-Change-ID: 20261124-xps9520-psr-setup-time-c24d3512cf2b
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 =?utf-8?q?Jouni_H=C3=B6gander?= <jouni.hogander@intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org, 
 Ani Aggarwal <antiani100@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795803721; l=4349;
 i=antiani100@gmail.com; s=20261125; h=from:subject:message-id;
 bh=318c4BOjroDNrkIKKte4IuzP8nHEwhcDbXg4u+A0OqA=;
 b=kke/ZkF1cQ+rI/ACJJ74rhj0beBUuKU0hWmQSckrVUM/VjiyuIVg2l/HwJXBAy/LKaNVtH5Xt
 bLBST0JCmlMDzOvTwEhm/PxeyXF4eMthSxW+/r6mphGGJ1Zh+C76PMI
X-Developer-Key: i=antiani100@gmail.com; a=ed25519;
 pk=lKco5sHiv9Mkqd7wU58OKQWw9dm6Hv4Pe7jGlp3eSsw=
X-Endpoint-Received: by B4 Relay for antiani100@gmail.com/20261125 with
 auth_id=1668
X-Original-From: Ani Aggarwal <antiani100@gmail.com>
Reply-To: antiani100@gmail.com
Content-Transfer-Encoding: 7bit

From: Ani Aggarwal <antiani100@gmail.com>

The Samsung OLED panel (EDID SDC 0x414d, sink OUI ba:41:59) in the
Dell XPS 15 9520 reports a PSR setup time of 330 us: DPCD 0x071 bits
3:1 are 000b, the default encoding. Its only mode, 3456x2160@60 with a
528.19 MHz pixel clock, htotal 4016 and vtotal 2192, has a 32 line
vertical blank of about 243 us. intel_psr_entry_setup_frames()
therefore rejects PSR on this display version 13 (ADL-P) platform:

  PSR condition failed: PSR setup time (330 us) too long

so the panel never gets PSR, DC5/DC6 are never entered and the package
does not go below PC3 with the panel on.

Forcing the check to pass (a 220 us setup time, which fits the vblank)
lets PSR1 enable. The sink enters self refresh on a static screen, no
PSR aux or sink errors were seen, and idle package C-state residency
moves from PC2/PC3 to PC6 and PC8.

Before display version 20 the setup time is only compared with the
vblank length and is not programmed into the hardware, so add a DPCD
quirk for this machine and panel that skips the check.

Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/17943
Cc: stable@vger.kernel.org
Signed-off-by: Ani Aggarwal <antiani100@gmail.com>
---
Tested on 6.18.64 with this backported; build-tested with W=1 on
drm-intel-next.

This is my first patch, please let me know if I need to change anything!
---
 drivers/gpu/drm/i915/display/intel_psr.c    |  9 +++++++++
 drivers/gpu/drm/i915/display/intel_quirks.c | 16 ++++++++++++++++
 drivers/gpu/drm/i915/display/intel_quirks.h |  1 +
 3 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 438cb1502..5a7a35bfb 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1347,6 +1347,15 @@ static int intel_psr_entry_setup_frames(struct intel_dp *intel_dp,
 		return -ETIME;
 	}
 
+	/*
+	 * Before display version 20 the setup time is only checked against
+	 * the vblank length, never programmed, so a quirk can skip the check
+	 * for panels that report a setup time they don't need.
+	 */
+	if (DISPLAY_VER(display) < 20 &&
+	    intel_has_dpcd_quirk(intel_dp, QUIRK_IGNORE_PSR_SETUP_TIME))
+		return 0;
+
 	if (intel_usecs_to_scanlines(adjusted_mode, psr_setup_time) >
 	    adjusted_mode->crtc_vtotal - adjusted_mode->crtc_vdisplay - 1) {
 		if (DISPLAY_VER(display) >= 20) {
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index ec3a79c87..cce29a9b6 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -94,6 +94,14 @@ static void quirk_disable_edp_panel_replay(struct intel_dp *intel_dp)
 	drm_info(display->drm, "Applying disable Panel Replay quirk\n");
 }
 
+static void quirk_ignore_psr_setup_time(struct intel_dp *intel_dp)
+{
+	struct intel_display *display = to_intel_display(intel_dp);
+
+	intel_set_dpcd_quirk(intel_dp, QUIRK_IGNORE_PSR_SETUP_TIME);
+	drm_info(display->drm, "Applying ignore PSR setup time quirk\n");
+}
+
 static void quirk_disable_psr2(struct intel_display *display)
 {
 	intel_set_quirk(display, QUIRK_DISABLE_PSR2);
@@ -303,6 +311,14 @@ static const struct intel_dpcd_quirk intel_dpcd_quirks[] = {
 		.sink_oui = SINK_OUI(0x00, 0x22, 0xb9),
 		.hook = quirk_disable_edp_panel_replay,
 	},
+	/* Dell XPS 15 9520 with the 3.5K OLED panel */
+	{
+		.device = 0x46a6,
+		.subsystem_vendor = 0x1028,
+		.subsystem_device = 0x0b19,
+		.sink_oui = SINK_OUI(0xba, 0x41, 0x59),
+		.hook = quirk_ignore_psr_setup_time,
+	},
 	/* Dell XPS 16 DA16260 */
 	{
 		.device = DEVICE_ID_ANY,
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
index c64d0fc39..1d05fd439 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.h
+++ b/drivers/gpu/drm/i915/display/intel_quirks.h
@@ -25,6 +25,7 @@ enum intel_quirk_id {
 	QUIRK_DISABLE_PSR2,
 	QUIRK_ENABLE_DPCD_BACKLIGHT,
 	QUIRK_ALLOW_EDP_JOINER,
+	QUIRK_IGNORE_PSR_SETUP_TIME,
 };
 
 void intel_init_quirks(struct intel_display *display);

---
base-commit: accacc0e5e1f1446af365770e88d344b7786ac82
change-id: 20261124-xps9520-psr-setup-time-c24d3512cf2b

Best regards,
--  
Ani Aggarwal <antiani100@gmail.com>


