Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BBF4E0B65
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790111150; cv=none; b=GK1uE8f5W10uD8rHacFesDxAr8LPn8SiK8gEqAMblaidaD+FrEUYDvSLohh1184uke3sxtKonDg6amIXyqRDpVgL49BIpTpRjcdxDcTZQdXpaWLlx+HgJN5uFEsGBl7xSCknvFqJkaQLCn8VMMCNOQkTUeM/uXbV/KHHvs/sKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790111150; c=relaxed/simple;
	bh=MznEH0TSSJNDns08TLLQFMMA/yS10ggZ0IYUvrXf7WI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xq+ZVAiy+ezbJ2oiYnuelhS7LfvOWqbDkoCSYj8s+6prEkyOEFeHrkO4+UbQx5H32M2bpLOS78TUDKZ8bunRaCj4ZHYWyn9l/IvLiCUp9GXlbXZUywXtd+tB0vPLdACWR3yp1et/ZuoN5eCCgIz67O+sPrXEGftZZv8BJPaLVcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QN04uSwo; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN04uSwo"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4aeso233000a12.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790111131; x=1790715931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5UcDSQfjol8c/MRKdgxKYWGRN9zsJz0+FFVZfxAT1YE=;
        b=QN04uSwoAnOGYX3m01Yg/WO0OGbLYwd31xvAXYcVNQZz0aEYUI0E+cyMVQocIU5yV1
         aoPJ4tbWK/Gu1g6X1kFXVbqerwUCHqhc3iB7QAF2Oovb7lrMW/P8SOnEBcmZOvgFS1+I
         ALSnTJvI55axzOf3k1vUYZTYDVlmTmSB3eYN1X6ihI7ScwtHrIY11uY1kAMKhosew2Zs
         WshkE07wNcab0IF63iH3AhB2HoMUpuD8sQDDe781Cy2ElgXi1KR/bOJS5m/WT6oJf27B
         kCgYvzZuGoxDXvfxhjOD6qcpCVGU1Z+9s6sn9kvoyP+iY1QwK7ESMFEAuUYJVEaO+uxW
         VxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790111131; x=1790715931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5UcDSQfjol8c/MRKdgxKYWGRN9zsJz0+FFVZfxAT1YE=;
        b=eb7o4uBxAO4obt+SiU/Kd1YEzJh3Dy5BfSrT7Pfom4Ii8ySAR/C5OBLzmlv5l5IW3Z
         O9UHeq3BdkVmMwtf7GveA1o8BD6ZABletWNvmLVmF58gzpEdQD5on+xsfB4ri4tXV2Kj
         jErVI/+Y2MGcVeYIdbBlQU+fmVweVLL5LeB/gDjre2FgAs3csFKOOZaB6Au/AwSNVx+K
         FOZM3jH5nT2+cy2AyWOeFgYll7LrPUjTTQILfR/sSnq/8w8wm5h8polqgcizvfdC/DIU
         CMMzedwn+1ApHvzBcbPlY7bFiiOIBuzQ6v0RnZ3OJnlFqS/rsMKV4grkTFTgt/Yip88r
         RHEA==
X-Gm-Message-State: AFuF++n7rHDlBravVDqGiEFYTBECM/IJ7fZ+mGZ8E2od74RT8M+qN9L4
	2mPmNeirMuc2q6996HGdb8SHJ6iMhkAq9sJdMCfZahBOMht/hMVyK0xFTer+SuvIgY4=
X-Gm-Gg: AYBFou2twDnBnNduvnqSJo0WuG40gD6mPDT7nwUd5XZPo8pl2mJhf/HVeCTJpV3S3X+
	XCZybnPX0qnw6Kcyx4txSlEUFaOSz/m3k0+FTflcA+m/ItPMDALqKZWW+UNoWmrvmJ6LztKi3fa
	OjZGXEkIsgLYiTyNaR0qWXRmcHUlJWNSB/DJB2fgnBHVAEq04Gn0oEsE3fhEJreonjglJvfdVFk
	NwYE/drhtiYHn/0Ui+MQYmaA7Jm65k4q1htzoHsE8gs+oF15utbz+lRoCTaohKmBKuGwip6P/mJ
	qyfd8OjPXilWU7oSlRhyRRpOwp74S6R5C5GUJOOWNRnOP2o5sN8Jg6HI2mqZNX+J2JHBD8RuuOm
	dRXTSjBtUfXcwzVBwZdAjxoGjrV1P7D1VqT8rQ13ZiHVs1SFAPTp0kxK6lG+O9wxVsvI3wiVRqm
	xycYyKH8bhs9s6rtVpY5BR3ukO//xj+HlVXyrwfNFtJs+NWfvn1TfYMsCs+LigXB7+53uvK4KCU
	/EMXEY=
X-Received: by 2002:a05:6a21:e08c:b0:3da:ec28:2cc9 with SMTP id adf61e73a8af0-3ddf7e52c5bmr651260637.23.1790111130866;
        Tue, 22 Sep 2026 14:05:30 -0700 (PDT)
Received: from fedora ([2607:fb92:3080:83e3:3c6f:fd76:69b:10ff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1d5c1646sm300083b3a.30.2026.09.22.14.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 14:05:30 -0700 (PDT)
From: Ping Cheng <pinglinux@gmail.com>
X-Google-Original-From: Ping Cheng <ping.cheng@wacom.com>
To: lee@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Cc: stable@vger.kernel.org,
	Ping Cheng <ping.cheng@wacom.com>
Subject: [PATCH 2/2] HID: wacom: Setup SW_MUTE_DEVICE according to the order of input registration
Date: Tue, 22 Sep 2026 14:05:26 -0700
Message-ID: <20260922210527.22420-1-ping.cheng@wacom.com>
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

