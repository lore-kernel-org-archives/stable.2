Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264985;
	b=cyM9bH8ci4ChYLshNmb1DfOel0wIvt3lWN11UoqG4z3l1H6UCJHMboQxOTDl+SimBchm
	 Nq473Y1LrQFewcKfJHTk/3yeH2GQYI6zDcXofUAMONwF5u0UjFht7j+UEdbGFNA/TKcw8
	 Z+dAHaesGljgSQANIFtyl+mQ5viUyR1apW8IkLbNRFbfSQeS7BOc3+Zv4HpxL2y7mhohG
	 L9tUfhcL7ft0ge17kwfTDy9WXVUEbaxR3nhOsQn3laGgEUhaCqb3idTcyhVDdVZQgiEPS
	 KeLF+RyKYDCmUbNE/nnjivL0cz/ih2MzGZG4iuPAYuSD/UCMYZJu4hZqt2O+c2CHxww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xUj6TVOjgwc5QvLbDmyVtO9DIkzDrZhSpW5tg4WgAh8=;
	b=yQL2edks404tn4uhTzZ2HeoIinl7sl55KzYHPyeMLWs0Mnl+vMYjM1NDkRQOyit4+meT
	 YYJvx11nVEN2uADTa0DpNl6yY3PR7qRdyEP/YpKFPUg/e4pSdCRJTFZ5ZgQRhGXWbT4bf
	 x+5MbnkXp7Aaj3Dj4SD5XPOM3ul/sSnsrnTd4ECNhovyz21tPr0h65PVNGQ65dsuwssv/
	 0jOu6SF73GET3AAGJRxjsz9A9sZWd3PJtB+owJBerP/dWwlANgkWkjx19OlE3ahsTeQD4
	 rq6qj3imOMwCDnvvcGV2fG3VYxXgQHP+UnsyTltYWkgOfPqDr3UmgOJ8K260zmq3sKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P+f+rKpN;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C35B606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 09:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C35B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P+f+rKpN
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ccca948203aso825022a12.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 02:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264984; x=1793869784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xUj6TVOjgwc5QvLbDmyVtO9DIkzDrZhSpW5tg4WgAh8=;
        b=P+f+rKpNDMbazkmk7ybuUqmWIDJQs6ay1YMFeKcc3xmDXGZjjOgNURsFGOrjqT6yp5
         AolARoADvF9/3WojZePHvDV/qbVTFlLUHVFtvg4re2Wce2wfOeoV46DpTW3Kv9ITXpPa
         9+GfFYEH5wsko7zK5k9oYKvEOw/vGlbHpZQK2NLHPanYkqvFVZUadvVR7mndKRN+Jggc
         j/xU81ReZX9g3ZoXfxidoE2+6XaupNl4ycdmKFJ/VhohVEX4nU3rJ56rj5yO97Y+aQPw
         0qbsdMYHPRqf9EYeGmFt9NEN4eEpjpePXLxOvm0TMy7GXG6uvIBIreKO1zMbdazjVcf9
         gD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264984; x=1793869784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xUj6TVOjgwc5QvLbDmyVtO9DIkzDrZhSpW5tg4WgAh8=;
        b=SwlQ1aAYpbZp5nfz7exsg59rwopyGPMHdrZyGhxmUr2Kk9iZOjU7qUSBuCXzpP+vbs
         b+2tboq6vBGXCT3xRrptOEmO26LG1QE9nQLjJTNffFnECXzkdH2yzYCS0tj4/wxnxd9S
         BrmQqHi9De74MDkVuiAprFjjjPBtdbWhvU0mowsMgK77Osq6IsmG7/VM0Fp9S4KJtbIG
         GwegYuV16WqfKdPKMSS6OrXXVjM/hccBdMrX3ytOKtvRbiwAsoNfOAs15VHL4bucK0YI
         tc028o0QQt0fxwfgxiNUazcVX0n4+QVSM9sf45QQ3G5dhs+pva65GZFE6xGGF1HdiGe3
         kjMA==
X-Forwarded-Encrypted: i=1; AKwUvBzxjKJPjgBChNBExw7gCRcXj2kkcuATMoYbiQ+SU3leShVitIY84NGWj8Ek/O+W568uciFIKdI=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3FY+j9pCQKHPetRKBQlQ2MZ7zAMTE/hwAC+cPXNJGPueeZNHE
	cq78IEWz9QGKpAdUrFnJZ0zMLJuw63YqWwVaznz4ZC3qU3El/2psTsI=
X-Gm-Gg: AYBFou13m2kUObcS3CO/nOOLDkWJLGadkpbeS6XkDDvW1TwMzU8BJ8P4R559aCHWSW2
	S/trDO6rwH+bsxoNhRMFXNjYqSjoLOlLOd09szUi3+nnHP32NCpQA/cXgumGY+VvY7nmc1XOwqS
	EbNIZEGGIw7xrCXRxMlZIBthXjB0e5AAPY4b7GpxG8WDF+3y9xVHqdwaqNRg0AqZcUtSHpAoVGK
	1YOH+kUKceTkY1yNjApY7QXpBDa2abSbmoqC6T9jV9Lh5BMNbunFjMQFPizlIhnS3CFgLRq4f+V
	uAnD8T3BPn/OddzEEBTTksXDO1aEgfO2LDdnkC/aVAwO5hlbgrgLjtQYyVP2+3gYaPn5IXlNRNB
	L49ALefmrenIcVfRm+njy01ybpB60buxYx605ExdVlE7+HrwxSEvXmV70Jd4SA51VKaIgSRvrA2
	F87nBkyHexDtK5i9RdqjqdldpW/eYKWHHr8LAZ9qlz0hzUYKOfEWjZgRgA+TluEWqkZC95HC/We
	AOgnbz7JXF3ECgZhvTq6rl+omwbtUoIM2nRcfgFzrG6jg8oGvtdG7xBl0t8n1uyostHrOFjV/+H
	xTAKvqlt/j66qdBF2dkbfUt62tKIZy8eYOtaj4lTzdvxSLg368zAuQFkSvhAHQ==
X-Received: by 2002:a17:90b:5908:b0:3a6:fc30:ce16 with SMTP id 98e67ed59e1d1-3ae581e1948mr3437116a91.51.1793264984432;
        Thu, 29 Oct 2026 02:09:44 -0700 (PDT)
Received: from deepin-PC ([2409:8a4d:d28:eeb4:5bcd:9360:26aa:4f88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9db612sm3484362a91.17.2026.10.29.02.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:09:43 -0700 (PDT)
From: liuwenhuan <liuwenhuan@gmail.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com,
	Wenhuan Liu <liuwenhuan@gmail.com>,
	stable@vger.kernel.org,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Werner Sembach <wse@tuxedocomputers.com>
Subject: [PATCH] drm/i915/display: Add DPCD backlight quirk for ASUS GU605CW
Date: Thu, 29 Oct 2026 17:09:27 +0800
Message-ID: <20261029090927.2318434-1-liuwenhuan@gmail.com>
X-Mailer: git-send-email 2.51.0
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

From: Wenhuan Liu <liuwenhuan@gmail.com>

The Samsung ATNA60DL01 OLED panel of the ASUS ROG Zephyrus G16 GU605CW
(Arrow Lake, 8086:7d51, subsystem 1043:3778) has no PWM brightness
input: its DP_EDP_BACKLIGHT_ADJUSTMENT_CAP (DPCD 0x702) is 0x86, i.e. no
PWM pin brightness, no AUX x PWM product mode and no PWM frequency
pass-through, but brightness over AUX. The VBT still says
INTEL_BACKLIGHT_DISPLAY_DDI, so with the default enable_dpcd_backlight
only the Intel interface is probed. It is not used because the panel has
no HDR static metadata, and i915 falls back to the PWM, which the panel
ignores: writes to intel_backlight change nothing on screen.

With enable_dpcd_backlight=2 the VESA interface is used and the
backlight works. Apply the VESA fallback by default with the quirk added
for the TUXEDO devices. The entry matches the sink OUI and device ID of
the panel ("60DL01"), so other panels in this model are not affected.

Tested on the GU605CW with 7.2.11 and a change that sets the same
try_intel_interface/try_vesa_interface flags for this panel: without any
i915 option the VESA interface is selected, the brightness registers
(0x721..0x723) match the enable_dpcd_backlight=2 case, the whole range
works, the lowest step is not black, and brightness survives S4 resume
and an NVIDIA MUX round trip.

Fixes: f30fddb44023 ("Revert "drm/i915/backlight: Remove try_vesa_interface"")
Cc: stable@vger.kernel.org
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: Werner Sembach <wse@tuxedocomputers.com>
Signed-off-by: Wenhuan Liu <liuwenhuan@gmail.com>
---
Based on drm-tip 9daba28e785e. Depends on 9499c3fca1c7 ("drm/i915/display:
Add quirk to force backlight type on some TUXEDO devices"), which adds
QUIRK_ENABLE_DPCD_BACKLIGHT.

 drivers/gpu/drm/i915/display/intel_quirks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index 96eb9a4..0d44d31 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -313,6 +313,15 @@ static const struct intel_dpcd_quirk intel_dpcd_quirks[] = {
 		.sink_oui = SINK_OUI(0x38, 0xec, 0x11),
 		.hook = quirk_enable_dpcd_backlight,
 	},
+	/* ASUS ROG Zephyrus G16 GU605CW, Samsung ATNA60DL01 OLED */
+	{
+		.device = 0x7d51,
+		.subsystem_vendor = 0x1043,
+		.subsystem_device = 0x3778,
+		.sink_oui = SINK_OUI(0xba, 0x41, 0x59),
+		.sink_device_id = SINK_DEVICE_ID('6', '0', 'D', 'L', '0', '1'),
+		.hook = quirk_enable_dpcd_backlight,
+	},
 };
 
 void intel_init_quirks(struct intel_display *display)
-- 
2.47.3

