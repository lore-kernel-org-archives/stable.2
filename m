Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C206D3AFAED
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791410620; cv=none; b=AfSp7NSZO1YrC4CEQL1RIL3TKFONTmgsP8IEPUqIIThES+hD85YNt8iDcWilbFB4mbKnkN9PykPD1JZ6EBKlkDjQon3Ne/fR8rdfHJ6Zepe7fz91VsHaPHdNiD65+Y807SEJQmx9HsYf+Zo0pqi4ghBlzkrqABwCAC3h8IlUo4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791410620; c=relaxed/simple;
	bh=pnSOfrmzHXwlWNbFIrL3h4Otp3NZjkJxlv13l4SR1uU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZU0p0MgLO6zVSHETMCjsG6mBkuAp1Pv18wO3txNcIrYkbA4tnptw78Ih2XJ3bqSf1bJWfxByOoP42VU7vNHTpkTVZWvJvdevpa2o8tWbGWHkFIJRprlk726M8xngFFdh7FRDG+7abF5PRbm9PrrhAEHMNcg9OF9sE22+newFGnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3xQNdKf; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3xQNdKf"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-884062f3296so1454581b3a.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 15:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791410619; x=1792015419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C1Wd3hcBZC1XpwvwN/vmfOrH1iAejKOYrsAXw8rqSj4=;
        b=m3xQNdKfv/ThGRSlQj/7UsLJMm6MKT6wimLfezXqRfMxf3Xlfz9S3PYd+tKw060+Cd
         N5us17gs/GjoUw1HxOForV3kGFLj4nW2CfAV6QHypp1rY88edWqDFmmGw78L1MkACOLo
         vfQmUXV3EeeWqdGApJUgiNWmf+4LkwRF1fjVyZgoBkkai4B6T4QNlvI/2tHjyqmcoHhQ
         oy3LLJ9Irzbv43ZqHx/WO4t4O4hU36B44D6WVy+X8MDkA5H7ejiCX9A7dhyKHEW8Vlnd
         mo4dYzx7rFw7r62bdNrJR7H8aCyFlYC5Pvb12gVOVoRQBp6n1zoZGw/sh7HwPYKYBYAz
         dnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791410619; x=1792015419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C1Wd3hcBZC1XpwvwN/vmfOrH1iAejKOYrsAXw8rqSj4=;
        b=kmzay1i6bpKq6STk7QzlvicvD9DvP9iMyTmk5DVAhNUTVHQlpPOgVbyOo9dceLi9A5
         HmPX5k2DlA9Wun7WPHeBzmbRzzq+eGVpt22ch7/Ucf/STLRj4xUdF4DWLih1iHl7j/wV
         yUcU6fk6WtdsxC7wV7pYz8maWJroJtVZyzgJoXOvYKuNIWo2xfEh17MCcJgHzsmoV1P2
         IhRoqM9ZuJ9orOTi00ZOpQxC5osVDerUAgCnx1Hj+nOIlDvKu97MZIRuZbtIk1eOlU1f
         g5Bi95PSxTJtjVkFDk7MBkFPEE+FZWVpZyElFi0hG0UGkXWUlDttZfpCUNmGCuk3WDoG
         WDYg==
X-Gm-Message-State: AFuF++ni/ieMwNWIRvc4W5GHZR6c2LYSgu4w7JF/R0fECeAaKOG6ihTd
	QtFGIGGLlQHNvZz9Y2X0TIZumhWPtEnxZgDq8LI/fEly67890m1UpPt5
X-Gm-Gg: AYBFou2oEGepWNdWmxQMBALZuCZoQJCQzKV2upzFrKd2U9oIsAW7qX1Z4nBoTuWTdu2
	vk4DhN4L0JUSWCG6W6kvZdiVuLOzACGsz/0DjTXMfmoy79NRZNhhcFmuRTa9b3o9mGIHn/n4MRm
	82gkr0fnuGE+o7LbqmTgjX3jKqLHthR2N2lWEqM6qRGeZdndu41xeyXFfxFFfan4DyVvxfBVR1g
	0LwaVatGOeWu3+XgqvMPL/82XIHaoeIgYt3rZq9NVB+8ft3J3KScFSJIAOi38xOBTQSYR4cQKkr
	OhJbcRbLyTbDFX7bjUFGDbpSbEPe4B0QTvCJaDEWMoXrpLyBbFO0E0fZBGschvGQlFWbCvT0Ver
	KWVECeVrT6SI2OGgwgfV2YkGr/a5ZV370vnGM+ulxTnvIoHdqjTCN8wXDQ8zSHUVVpE4PSKZZjO
	OrxGboOIeHodvBdd7d1AdCkyRc0pBOhrw2Fd7yAnZojMxmx6OP0+cYBbBk+v2v89OtNZTRsQoeV
	ubzu+U=
X-Received: by 2002:a05:6a00:32c9:b0:891:3e34:e06f with SMTP id d2e1a72fcca58-891b54d1bf1mr2794094b3a.44.1791410618939;
        Wed, 07 Oct 2026 15:03:38 -0700 (PDT)
Received: from fedora ([2607:fb92:3080:b51c:3c6f:fd76:69b:10ff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-892bbf7fb6esm832980b3a.55.2026.10.07.15.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 15:03:38 -0700 (PDT)
From: Ping Cheng <pinglinux@gmail.com>
X-Google-Original-From: Ping Cheng <ping.cheng@wacom.com>
To: lee@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Cc: stable@vger.kernel.org,
	Ping Cheng <ping.cheng@wacom.com>
Subject: [PATCH 2/2 RESEND] HID: wacom: Setup SW_MUTE_DEVICE according to the order of input registration
Date: Wed,  7 Oct 2026 15:03:35 -0700
Message-ID: <20261007220335.6661-1-ping.cheng@wacom.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping Cheng <ping.cheng@wacom.com>

The refactored SW_MUTE_DEVICE code assumed that stylus will be
the first regiestered input. In reality, touch can be registered
before stylus, such as the Wacom Cintiq Pro 13 and 16.

This patch covers both touch-first and stylus-first cases.

Cc: stable@vger.kernel.org
Fixes: ba16e5ffbaa1 ("HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration")
Reviewed-by: Lee Jones <lee@kernel.org>
Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
Note: no code change. Just commit comments and code comments change to the existing patchset
---
 drivers/hid/wacom_wac.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c4cd87b781c4..f109dc74e55a 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3977,10 +3977,18 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 
 	if (features->type == HID_GENERIC) {
 		hid_dbg(hdev, "generic touch setup\n");
-		if (wacom_wac->has_mute_touch_switch ||
-		    (wacom_wac->shared && READ_ONCE(wacom_wac->shared->has_mute_touch_switch))) {
+
+		/*
+		 * This is to setup the touch switch for those devices that report
+		 * pen interface first. The setup can only be done here since this
+		 * routine is only called once. When we are here, the shared
+		 * has_mute_touch_switch has been set by the pad.
+
+		 * There are two ways of reporting inputs from firmware: stylus first
+		 * or touch first. This path covers the stylus input first case.
+		 */
+		if (wacom_wac->shared && READ_ONCE(wacom_wac->shared->has_mute_touch_switch)) {
 			input_set_capability(input_dev, EV_SW, SW_MUTE_DEVICE);
-			wacom_wac->has_mute_touch_switch = true;
 		}
 		/* setup has already been done */
 		return 0;
@@ -4403,7 +4411,26 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 		break;
 
 	case INTUOSHT3_BT:
+		break;
+
 	case HID_GENERIC:
+		if (wacom_wac->shared) {
+			/*
+			 * The setup of touch switch capability can only be done
+			 * here for those devices, such as Cintiq Pro 13 and 16,
+			 * that have touch input registered before stylus and pad
+			 * inputs.
+			 *
+			 * There are two ways of reporting inputs from firmware:
+			 * stylus first or touch first. This path covers the touch
+			 * input first case.
+			 */
+			if (wacom_wac->has_mute_touch_switch &&
+			    wacom_wac->shared->touch_input) {
+				input_set_capability(wacom_wac->shared->touch_input,
+				    EV_SW, SW_MUTE_DEVICE);
+			}
+		}
 		break;
 
 	default:
-- 
2.55.0

