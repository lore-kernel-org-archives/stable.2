Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07913A5440
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 02:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789524371; cv=none; b=fNcG91AMcTk3STcavnxeIbD0Op0H/7Hn+0Aivz5WMuWbCsyVQvXM/t9khyscdkUN/KeEia+VQ5uRsAF3BtZFQJJr65IjLH8F3Bnw4uTAMlQm8HJGZmvGgpa+Y93kxztiQMCRQB4NmmXTCxyG2m50XYAJby5M7oeGy8Q5gzFzBYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789524371; c=relaxed/simple;
	bh=VzBQstYI9n5foWER42pPugcCV7m9/kLwe0mcjHJaVsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P55DMewukPM7GqchkhIUBSKsCOgfjhT9djAMMnofBav3+SystnaIEuVdJT7JPs/ibKRuHYiIjadMwfx9jQwewN1AkV0ENI5vCG/3uk/9mxXe9WhHpGjNLYJNN4GVWIinR+CnqRMPrMPIvySVeJSoZKBIw/tQEJCyV4QRbl1qaB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=reRlfq+g; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="reRlfq+g"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed6d6eso3477835ad.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 19:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789524363; x=1790129163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V1xqHMghnX/wz4hUAHEyQvIQaxwHg9qWI/SSHwusRwE=;
        b=reRlfq+giMYhMSli8ydtNL6mCWi41jbsa1Ruyp63VSED7Pi4nUBSXVI2zQBd/vj66w
         wKi73eo76YEPQGhVFw39XA3FbY1c8fbi0uuDUW4XmG2vjeJA4TPAh9bsNhoM93K6Riea
         Gst3LNgmUR3JMXT3XzB5GVPpKUMucAUcbPCEWv2F2GfwCTfcOcbhZeA/RwSlQZ8V8r9H
         r3c75uAeFMdFi5y3uJB302H4E5DP3ZM25uQ8/bsDtK2uoOh+7pRi3MwJSJyRdPyXh85i
         dTVE/SzwN71PbJxOtcYbKkW3aApSHK9+7gPFTOSGWf1TLw5qnnnwfrqyR3z1OAllTa8p
         GUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789524363; x=1790129163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V1xqHMghnX/wz4hUAHEyQvIQaxwHg9qWI/SSHwusRwE=;
        b=G/EkgFjnTzyHSZ4wPDVM5+3Whv9+kCcSMLJkNiH1tpXQ0agfYnHd71ZjVUdmw4d5eH
         pelX1iqpkRECKfH49PtAjJCrrkbZF+h1MrUShi3HPhkoNHlGM/m5ylcrpxrFJhmZItXd
         dgT5vnbISWsZKCuV7/DiukMix/qTn6zOHvnXHVx+edoAsV4fLA6S09OOj9yJCLv1Xlie
         ijBp/WoPTkMxAZcvYTUKMeiPR1RK2KeCw6pyregryhiVqjHU3jgoigUr6R0/gyHM35cb
         3fpF+9a4h6Pebd+lIgt8hbY7ttp+A/vg9x+NpmhZsLgmPi4ZdSyn6kp0Tq39dStejdg0
         pQPA==
X-Gm-Message-State: AFuF++nlM4kvrWGL/Z4jXdLD3h7OmXEfeRFF9WQssSqtMxZgeLiB1OZJ
	N2kdaDzi9nrZwEJVioLlfqi1IkHYUl6p9OtqTMMK6jzOgKaLKYu8ZiNT
X-Gm-Gg: AYBFou3qKmlUwEI95ukIgHd7x+r39gnGmazLMTpO+a/XZGTOT6EigaYerQeNc2qzX6W
	+TeqvNuDQ7e98O2orsiMwBRL2ZBOHRhI+n4UMwkdvyVeKwVOpRETz0QK8qagks4j6KENPnhfbYj
	vgEnS8dJqhzFGoG4JQVa7zc/2kqMU3hG//QrWJxRcB2q9sIMUGjadGpwbLgI4AGMcPqjTyVrDSC
	NeMczfP3IOGlYZRz7k5OrKcZgu17bQpg9W9gO/hzb+/XM8vPUOIDoSy36m9JbLhKXFKDRA/+5X0
	ecSoyDUvZtXgikD5R6FvGYuzN8J/SeC5CAQhs28CKuG/UFIWCltHpnc1I9HJBQzwQAW4//h8YKA
	I28ScXYC0Y2NiqYfW51vu+kq85AC0xSKt2WrzdmLE+Ek3f5R0cOBb3TV8bZPKGs9xw3Eox9D5uC
	mteJqvfFkeUZr6wJ8MSsKKHl0Rz8xI62QI2NlRtoLsuxpErmNuowprpRR2wn/Ux8G5M/p5
X-Received: by 2002:a17:902:db09:b0:2d6:3c2f:6a4 with SMTP id d9443c01a7336-2dd8e40c22fmr14836915ad.13.1789524362973;
        Tue, 15 Sep 2026 19:06:02 -0700 (PDT)
Received: from fedora ([2607:fb92:3080:83e3:3c6f:fd76:69b:10ff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f244c9sm3246075ad.76.2026.09.15.19.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 19:06:01 -0700 (PDT)
From: Ping Cheng <pinglinux@gmail.com>
X-Google-Original-From: Ping Cheng <ping.cheng@wacom.com>
To: lee@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Cc: stable@vger.kernel.org,
	Ping Cheng <ping.cheng@wacom.com>
Subject: [PATCH 2/2] Setup SW_MUTE_DEVICE according to the order of input registration
Date: Tue, 15 Sep 2026 19:05:58 -0700
Message-ID: <20260916020558.24308-1-ping.cheng@wacom.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping Cheng <ping.cheng@wacom.com>

The refactored SW_MUTE_DEVICE code assumed that stylus will be the
first regiestered input. In reality, touch can be registered
before stylus, such as the Wacom Cintiq Pro 13 and 16.

This patch covers both touch-first and stylus-first cases.

Cc: stable@vger.kernel.org
Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
 drivers/hid/wacom_wac.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c4cd87b781c4..9520296cb349 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3977,10 +3977,12 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 
 	if (features->type == HID_GENERIC) {
 		hid_dbg(hdev, "generic touch setup\n");
-		if (wacom_wac->has_mute_touch_switch ||
-		    (wacom_wac->shared && READ_ONCE(wacom_wac->shared->has_mute_touch_switch))) {
+
+		/* setup touch switch for those devices that report pen interface first
+		 * can only be done here since we only call this routine once
+		 */
+		if (wacom_wac->shared && READ_ONCE(wacom_wac->shared->has_mute_touch_switch)) {
 			input_set_capability(input_dev, EV_SW, SW_MUTE_DEVICE);
-			wacom_wac->has_mute_touch_switch = true;
 		}
 		/* setup has already been done */
 		return 0;
@@ -4403,7 +4405,21 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 		break;
 
 	case INTUOSHT3_BT:
+		break;
+
 	case HID_GENERIC:
+		if (wacom_wac->shared) {
+			/*
+			 * setup touch switch capability can only be done here
+			 * for those devices that have touch input registered
+			 * before stylus and pad inputs.
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

