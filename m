Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA123AAF5E
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066085; cv=none; b=CXsGdL3vYHpF3o6fHI8WS656YOVCvLWIw2scVvs66F1Oyx8dKEweRbjIOakWkbR+LHbsf7kDhOu7aNlkY7cIrxUTuFfteWh2hVw5j6dd55E5RSNXZYtxOyh0l9UNum8L2fIHbQFh09+M7tuBujnBY6VxOgUdn6jPg+FV3jrSaOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066085; c=relaxed/simple;
	bh=axV0Xe/l0zqKu4dH1Id8zerBM+MGpmGJDJcGlyeEvtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3hB8lue3nF3ixwVUucDWHSkSCM8FpVwGQxbYheXOJmXbD2mtDsaEkyE3wkaJ9+mKsZEZAwy/ozvFec91TB+qrA/hiXZIuejzR1iJ5J0EoGq4HLVw+956volycdAHfsZxOdY5w6/J8PMCsCQngK469rSpwJQ5DnoxzsJKxl2zBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDYBV3vu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDYBV3vu"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954df200ddso34453725e9.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787066082; x=1787670882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lzohCHfuB1luQeAMOC/pqUEUdm2PKR4ZBwb8q7ZkmM4=;
        b=iDYBV3vuDHy8Ao4KsY2+F8AZX/nG+09r1Z/cCzEWN7Viidw1xvpZcgHOUQ0KJL22YU
         14zfDJRIi/2Mh8sRbxtQOYNiJ3b9NUzB6wNmxhGf0ZjFMpoD+LWthL8tQK0Imj8oKfqr
         efbabG5cSwfKviC9Irng7kwP3HTvsoJHFXQCyjQ72aEXyeciSKRzun3qPxMKmFkkFttv
         5X0DqvwWlAHAvisewiNq/3hsKjJbI+3B2woOU9aU/CwWT9KG3n9YcbJUXQB5DdpDO5BE
         lAxekUpYQDES1q/snzFhb/5ku3uoVmJuW8ImCuk2RNui2u4ABt+uPL/04vcIZQFXYsP2
         NVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787066082; x=1787670882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lzohCHfuB1luQeAMOC/pqUEUdm2PKR4ZBwb8q7ZkmM4=;
        b=SbmABjkDysF2vS69Q8liPKVxgLjBoKwMHA5ma4Jy8se21fiNmDlle3D9Po5JWsF+SM
         HIdule19uWb9Btiwmtp8IC8YYLzUu+TMRjZdUZO10udQmH2tR4NfVvN/LAO9+fEN89Jo
         2wV5hauU7Ltc/4tUAUaZdaWYqhhu4xsZGH88R4XkMMYXQZmJC59L7uM264x/UgcGsMI2
         I7/0mk2s8bWYX2FRL0dvcMVSLi2ZUWI6OIjqG95gf7thhaWDgsWAK6CxSFgW1PJkyz60
         n9LFipcWVCUj219QLdPTIwkSD1UXRYMBLKf/eIdC/+bsfTJQVcTNGk/ofmGiQfXwO2fT
         X1Aw==
X-Forwarded-Encrypted: i=1; AHgh+RqnsQQf61E4xG9R9gp/s8GIBX6cvHOjeVYdSjDDTVpfBcN3QDxEvtaDgWZnvZjpjc4oSIaXx18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAXpfa+aQKDQGlKeSOSoPF/zKk/4JCTsFFvo3ymRbjVKQLckXx
	9v183ODsJ2nl3MWkTX9XeFg/+O/fuNAdl+rKFpFfzKzJngssj6z8SI5G
X-Gm-Gg: AR+sD11MGhrok5y/8HgnyGbiNqjDg1W/H7T5PnRMoXNrHtMimrw+ScD1Oa6tQy1zTv2
	ohMxjQD/6OZM73jjSo8Ar532nm7k1EVuxa7YJgxT69P9pnWZAEY49SgcTur9a0LjH+HsHGlTiZ2
	hbZRI+M+Ujs2FJfDcBamRXJPi5nJxUGrLihYCkwpUxlM2BqyVAgd1cCn6X0wTLjghjtGce600rp
	cEoRzv89eImruwAmNjDpDYCmr3PrVCiptX3m4fwl/FSk+E7H6UMoh1jNBMyf66Y4jlFpoBrU6nn
	erH0fodYqOwkaYNsPspRqGBLw/SfvDnHoI8lVmsm6gW2pRp+D+k46Fp+bpu5FBulx0LbIundhQo
	ysdXQH8jaXxd/nAwn7x1/+EdvWxGuVlLm5BwI1jHbvZ6WVFSjn6pZvn9thp3r7JmWJh7tCxXArJ
	6KV6BSn7G90nEJygPfH2nhThYFnBGwQFtsv1JiGpv0PmQYdkqWTe+i3Sjy/HHZCS1fiR/yc0KgN
	QQZJxHotIGLxYVnWnLVPa+gojJvuw==
X-Received: by 2002:a05:600c:19ca:b0:499:7ce1:d8a2 with SMTP id 5b1f17b1804b1-499879426e9mr450375235e9.8.1787066081793;
        Tue, 18 Aug 2026 08:14:41 -0700 (PDT)
Received: from HomeOffice (046125138157.public.t-mobile.at. [46.125.138.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b7cd38sm13657469f8f.32.2026.08.18.08.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:14:41 -0700 (PDT)
From: Panz Dev <panz.development@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Denis Benato <denis.benato@linux.dev>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Panz Dev <panz.development@gmail.com>
Subject: [PATCH v2] HID: asus: do not send keyboard init reports to touchpads
Date: Tue, 18 Aug 2026 17:14:31 +0200
Message-ID: <20260818151431.939132-1-panz.development@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0919db9f3583 ("HID: asus: always fully initialize devices") added a
loop during asus_probe() to send keyboard feature report initializations
(asus_kbd_init) to all ASUS HID devices.

On ASUS laptops with I2C/HID touchpads (such as the ASUS E200HA), sending
keyboard feature reports (FEATURE_KBD_REPORT_ID) to touchpad endpoints
sends invalid feature requests to touchpad hardware, corrupting probe
state and causing the touchpad to become unresponsive.

Wrap the asus_report_id_init loop in an `if (!drvdata->tp)` check so
keyboard feature initialization only runs for actual keyboards.

Tested on ASUS E200HA (where touchpad functionality is fully restored)
and ASUS VivoBook Flip 14 TP401MA (confirming zero regressions).

Fixes: 0919db9f3583 ("HID: asus: always fully initialize devices")
Cc: stable@vger.kernel.org
Signed-off-by: Panz Dev <panz.development@gmail.com>
---
v2:
 - Keep asus_start_multitouch() inside the HID_CLAIMED_INPUT check to avoid
   any UAF risk if input registration fails (as pointed out by Denis Benato
   and automated review).
 - Focus the fix on skipping keyboard report initialization for touchpads.
---
 drivers/hid/hid-asus.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 3f5e96900b67..7f19ca1e5a1b 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1294,12 +1294,14 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}

-	for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
-		if (asus_has_report_id(hdev, asus_report_id_init[r])) {
-			ret = asus_kbd_init(hdev, asus_report_id_init[r]);
-			if (ret < 0)
-				hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
-					 asus_report_id_init[r], ret);
+	if (!drvdata->tp) {
+		for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
+			if (asus_has_report_id(hdev, asus_report_id_init[r])) {
+				ret = asus_kbd_init(hdev, asus_report_id_init[r]);
+				if (ret < 0)
+					hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
+						 asus_report_id_init[r], ret);
+			}
 		}
 	}

-- 
2.47.0
