Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86A13AB466
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735288; cv=none; b=QiknH3SeGlScIWcDsJN052yH4IClZRpqfQC23afuYcttZIgVwICrAEbMIBKU8f19CGU5VHfyVL2O5lfIqkqYvtA/mlK9UYO3Xq6fpD1k8/YvrxXn8jUIuM3MmPEyI/jMYHB1UWMX0bIXQACmiS882UlaPAus0VGci+k80i3IfcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735288; c=relaxed/simple;
	bh=jlb1DUUPSeQM22QzPKw5pTODsJAU16OF6EPDbU1TIvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O+JHIsOPciMrQSIoFBahM45wMfWk6Nx6/VS6CZa+GtQpwrT/XPJO6kormrE+JZ5NYa+gFsDknjG1XKsRITN/GQUoP60zx9Vb54q/E/3JaHOYP4rypVrRFphVZjKDom6QOKKt2+1fg9PmeBHbIXLTTycbw82RZKumto64fYhCUoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHxNBsZB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHxNBsZB"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84e0688b859so384879b3a.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 08:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784735284; x=1785340084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oYgzICp3WWBVEAdBWpXW/nz3XQWTxOaX/2nc+F1fyyo=;
        b=VHxNBsZB5ER4IEOU3iYsB1de2q4iH8AMlqdi3VhAu0Fp1arcNF/LMGuaAwFGff3xUr
         uh1MjuPR9zCf0dYU/+Y1c+tNOtUBd4mvckD+sviZNWC0xwHSpF6V56KrSauOMZS/PTix
         ylnrpkIuYWDYcQCLl94VXYWdTw5rdvFwcRbcTMILhWTpH/cenNKz07BcZBk+ohkd/hLq
         ycsqXbFVZzpQHPYAOTSk5zHw5mm9uH0rivNi7Bgy5dL0AF6NU2UXN28kHahpkzUjBOdH
         oP3IKAlSBTpjsIqzF5c8IcsB88miUzQCA4T3wc9/I468FcEbHbO0sdkJ+LCwV7sciNh/
         KiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784735284; x=1785340084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oYgzICp3WWBVEAdBWpXW/nz3XQWTxOaX/2nc+F1fyyo=;
        b=XgHgiYFVRql0QxYu5s0dNbTW8cbg+TIpJJYbpAF1FfSQG2BTEacuJG7CnAP3YNQvrH
         nYaUMxe7CzOUONXFBloEqUxTJuh/VGBNIpeU0UmVbGDWXS27GYnfnU1o/zKeAS0uS61t
         nlDrpO7mIhpQZAKTyDWfEZX8vBso+fHKlap9l2rZBLyj1ZkbitJqUclzq3sk3QR+wH9Y
         bVjpWIQzVK9Rm42JkLzC90BMRD8/Yt65XdYe/VlJV5tybi+K/zgOtZJ9vpY91edvSgQe
         0BYk3/apS3Ga/HTSFSoyxhv9TbGchEkzSDSnoQc/Al0eTXy9IEGuTAFJ206YMix4I/CA
         u7aw==
X-Forwarded-Encrypted: i=1; AHgh+RpDuFEIVi5NZkvsVb2oCWm62Q4Eh7SUT0V9V1j+OjY6sM1dNxqGIWbqstb8m09+Fx2g1noFdVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws7VXKkZhwWeJYgfj8gb8dAsAmDmPsoOermmjJO9Lmxgg1vw3p
	erav2htYKXl2MI9+qI4XCn8AKwkIS8cZeL9UdY/W3lsxmzb8FusGQSlS
X-Gm-Gg: AR+sD12AaH5Ubad9jg4Zp5PFpPiznYA7MJDtCq6jJmprYu/TQ+BqlQHiLDWoeQIY8G5
	+AznWdCCXVRRLiNiBvv/xVd7Gr2yGgY8l0F4xb8ZXqyWLmGS0aeIXmdJsmctHasZui55HjYOvJt
	Eo40z4wxPWoEKXDCXmeHT6wPPTx0q2clxQIPQ6s9sBmM6hf0WPe1bXoXaiSTn8uKN7k3FKhV44X
	BDYOlevS1jf8J71HMA/Lq9oC5twOjhsV5uzofjy1T75ClreBjRRA9jGaZU3q1Nlku+pJbV4CzsJ
	MKb/gtw9JJLSfj16eFi1WBq4Xi6QbGm9mUWqZ9qYA+GzFYyf+go+cFsibGkIYD5JeH7z4EoFXxv
	8RClx2uRDEe3FsUhKjD4K2c1hZMdQRBMXr+NNVHPCp6dkp2OF8lIcgI75bkFR0CepdvYz7eKfPt
	tDHOXKgro0Ao8HF6z7JeG4aptaUVbGQ/eNilCz6iZNFVh7so+sN3x1qGemt9M=
X-Received: by 2002:a05:6a00:1382:b0:846:7507:4e07 with SMTP id d2e1a72fcca58-84c29505e28mr24354626b3a.39.1784735283477;
        Wed, 22 Jul 2026 08:48:03 -0700 (PDT)
Received: from cm5pi.lan (174-21-80-34.tukw.qwest.net. [174.21.80.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175cdc21sm1567763b3a.47.2026.07.22.08.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 08:48:02 -0700 (PDT)
From: John Foushee <johnfoushee@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	John Foushee <johnfoushee@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/backlight: allow hybrid pin-enable + AUX brightness panels
Date: Wed, 22 Jul 2026 08:48:02 -0700
Message-ID: <20260722154802.3760046-1-johnfoushee@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 102d44b3a8fa ("drm/i915/backlight: Fix VESA backlight possible
check condition") restricted the VESA backlight path to fully AUX-based
panels (enable and adjustment both via AUX), on the grounds that the
hybrid configurations are not currently supported.

The hybrid pin-enable + AUX-adjustment configuration is however already
handled: intel_dp_aux_vesa_enable_backlight() falls back to the PWM
funcs for enable when info.aux_enable is unset, and
drm_edp_backlight_init() supports aux_set without aux_enable.

At least one panel requires this configuration to work at all: the
Tianma Y156ZAN02.0 in the Google Pixel Slate (nocturne) advertises
DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP but not
DP_EDP_BACKLIGHT_AUX_ENABLE_CAP (DP_EDP_GENERAL_CAP_1 = 0xfb,
DP_EDP_BACKLIGHT_ADJUSTMENT_CAP = 0xff). The panel ignores the PWM pin
for brightness adjustment, and resets its AUX brightness register
(DP_EDP_BACKLIGHT_BRIGHTNESS_MSB/LSB) to 0 whenever panel power is
cycled. With the PWM backlight funcs selected, the panel comes back
black after every suspend/resume or DPMS off/on cycle while all
driver-visible state (link training, PPS, PWM duty) looks healthy.
Firmware rewrites the register at boot, which masks the problem until
the first runtime panel power cycle.

Allow the hybrid configuration by requiring only AUX brightness
adjustment capability; backlight enable keeps using the pin/PWM path
via the existing fallback.

Tested on the Google Pixel Slate (KBL-Y) on 7.1.4: i915 now selects the
VESA AUX backlight interface, the panel's AUX brightness register is
restored across suspend/resume, and brightness control works over the
full range where it previously had no effect.

Fixes: 102d44b3a8fa ("drm/i915/backlight: Fix VESA backlight possible check condition")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/16679
Cc: stable@vger.kernel.org
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: John Foushee <johnfoushee@gmail.com>
---
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c    | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 7a6c07f..a5c03c3 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -616,11 +616,15 @@ check_if_vesa_backlight_possible(struct intel_dp *intel_dp)
 	u8 bit_min, bit_max;
 
 	/*
-	 * Since we only support Fully AUX Based VESA Backlight interface make sure
-	 * backlight enable is possible via AUX along with backlight adjustment
+	 * Brightness adjustment must be possible via AUX. Backlight *enable*
+	 * may come either via AUX (DP_EDP_BACKLIGHT_AUX_ENABLE_CAP) or via the
+	 * BL_ENABLE pin, which the VESA backlight code already supports by
+	 * falling back to the PWM funcs for enable when aux_enable is not set.
+	 * Some panels (e.g. Tianma Y156ZAN02.0 in the Google Pixel Slate)
+	 * support only that hybrid configuration and ignore the PWM pin for
+	 * brightness adjustment.
 	 */
-	if (!(intel_dp->edp_dpcd[1] & DP_EDP_BACKLIGHT_AUX_ENABLE_CAP &&
-	      intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP))
+	if (!(intel_dp->edp_dpcd[2] & DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP))
 		return false;
 
 	ret = drm_dp_dpcd_read_byte(&intel_dp->aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &bit_min);
-- 
2.47.3

