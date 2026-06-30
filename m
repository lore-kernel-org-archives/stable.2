Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA4822AE48
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 01:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782781770; cv=none; b=aRRajlKriDrMJxbUwcckqsyFRGA8GBQMzY6Xtoqr4xSYqaEON4GciNqsD8rkmumucE9VoH67vvBJtG06FNb4U7uV9j8FvvHJbpS1Spu2Bmj3RQDE39JweRucW5Fgu55EWySrrhOQDQvOAt/WsCfzq63vwL+GMYan/ep3twyHG8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782781770; c=relaxed/simple;
	bh=VIYVEeqg5Uru7TpS/SsXJahR9C8vMWAkOIUv367sfj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LDN9jkZhH8S0Vzu9sXcbWmb3seorOL2PGII8/hS9u1+4vQpTQh5m2NQRxo6W5iqVeVxwiucKN4S3kGyPFgLewvt5UxhZW/RKmgcjGiYtpWCCkrGD2DzERr12ezpPK2kqAaEOsXUo+LoUNOclRrjZf/lffCEW3Frs6PxXkqHGyXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qk4Ou1DF; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk4Ou1DF"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-461edb387ddso3763003f8f.3
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 18:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782781767; x=1783386567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Um9ErCcdf49zk6uB2lU45UAxhDbw8UL4WZ7Z0MeU9XQ=;
        b=Qk4Ou1DF5HVj2+H02aHBc0FqMeQTyGB/Z/RhvXWpkhj5t6VIUn885r3foUlflUWiwF
         gEh+Ae8XPQ+AK4vCePGmZuZrf+49koFGj5KIhr8FsnKVcEyyLXFbOR9L882+of5icfOm
         IIrn81sVtcTzyS6rHbSNoGCc71ao+VlqrEkE1i+pyMHADnzVmtnUb+EAPMbZnK2PhEIL
         Ovd4l8E8KwAvijZQ61ahF6cgrDYfH7sY2+UHiKdOEor167AKGkKwIPoP2FPQp4pSxbtq
         0Q22X0ZD0feYIT/Z2JPkyY5sicikanOHLTG0QhLfzssKP5hZR1KvNfFKVxZxyXQJFYN3
         tt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782781767; x=1783386567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Um9ErCcdf49zk6uB2lU45UAxhDbw8UL4WZ7Z0MeU9XQ=;
        b=hpauu/5MN6hQ3aKp5r1nZ2aTUS1cbNG38R1z4TiiaZyrcKDtb/TQi2VHygbC4wQ4af
         3wFmtPkATfHU5fWzRnf8oJeC5h4I/a3vfq4WrkWDRPLN8iFaQ6rbTTeQozCk3TWkjbYz
         nV2eMKzz9XpBHGEjGW56VhfPvd2P0ttu/khM3CGKr0KRqsFC3pxkTt1DmnoEc1VMDJJs
         ac7md8coGJCG4N7//cgglLmwRis1H2xGsZtFbNCI/mCYEKxHzxN9Qw57dIgNznsyeyeW
         s0syW7fHueJVz5ZhXsCMum6eTHP1SGkiYsuMUxi1OHha9I4perPCD946U2ROdcQSM08+
         dbdg==
X-Forwarded-Encrypted: i=1; AHgh+RpdCH59lUAGca3nxZgajcBLvnrkFqYPIluM3cx6++iE9csLv5RDww16oXznX0CNdqm1MeMZlNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp8x1qyo4/0jLhchcoZjZyEBGKzJwza3Wmw0aBHsf3qwce/e8+
	ZnCU/De6EHvf8SQKegLQI/vlRKt3qmOtoxln9VVG/K6ZNcFiDV5Xm0EI
X-Gm-Gg: AfdE7cnGlv+ExTGgeByy+QHhlCDV3dcTZzCOsD7C7Sz/4vzFA4TuJ/o92QVpnnfbmub
	DuRG3JYCv5PsJid6acvPYEY+mBMjlEJw+S981NN7CsBtgka3BjhsiwAODjUePmg2dezPTiCrRGg
	SLoI0rkHvsI/WcJy3VaUz7VIgtRUC63+vxn1iJnkKgmfHOOEyoms7haj+J8R5eV0Se7gcmr9gAM
	zQZa6N7MwwY6gWBiYzRZGKcOG5Rth2M7L+2weZ24i0AfbldWmsTHOWL961Y7haQIbxQl8ttUM9v
	clV0ZbNvllAoq1ZPzMzQFmduN8Pn8JRWUoVpoEB2UdoqZMiNvIYbKIyHMFg915POPT8cEvURSGW
	PMt3Whh8KlYX7eQWSfin6XFtlt/fIJBRjnhznxqNhkZ2X2GENa12py/FliScbM67FfFoVa7fZHS
	/qOwYpmFkdX2gJA4OPE0oop3sbhD6cLrvDxQro+e8m0YLeByK8IBT5SkRyXbvaAubpYGhuweDHd
	vd/zCYtQDQxk7HEzGjbQyw=
X-Received: by 2002:adf:e011:0:10b0:46f:558:a42a with SMTP id ffacd0b85a97d-47552a6910fmr1364141f8f.34.1782781767303;
        Mon, 29 Jun 2026 18:09:27 -0700 (PDT)
Received: from snakeroot ([2a05:87c3:2001:7400:25e9:cccc:54ef:5829])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475671d02f5sm2977891f8f.28.2026.06.29.18.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 18:09:26 -0700 (PDT)
From: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To: linux-input@vger.kernel.org
Cc: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	linux-kernel@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] HID: corsair-void: Check size of status and firmware events before reading them
Date: Tue, 30 Jun 2026 02:06:56 +0100
Message-ID: <20260630010656.626157-3-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Malformed status and firmware events could cause an out-of-bounds read since
the size wasn't being checked. Check the size and warn on unexpected values to
avoid this.

Fixes: 6ea2a6fd3872 ("HID: corsair-void: Add Corsair Void headset family driver")
Cc: stable@vger.kernel.org
Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
---

v1 -> v2:
 - Ratelimit the warnings
 - Accept packets larger than the expected size

---
 drivers/hid/hid-corsair-void.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/hid/hid-corsair-void.c b/drivers/hid/hid-corsair-void.c
index 5e9a5b8f7f16..071a663a6c26 100644
--- a/drivers/hid/hid-corsair-void.c
+++ b/drivers/hid/hid-corsair-void.c
@@ -92,6 +92,9 @@
 #define CORSAIR_VOID_STATUS_REPORT_ID		0x64
 #define CORSAIR_VOID_FIRMWARE_REPORT_ID		0x66
 
+#define CORSAIR_VOID_STATUS_REPORT_SIZE		5
+#define CORSAIR_VOID_FIRMWARE_REPORT_SIZE	5
+
 #define CORSAIR_VOID_USB_SIDETONE_REQUEST	0x1
 #define CORSAIR_VOID_USB_SIDETONE_REQUEST_TYPE	0x21
 #define CORSAIR_VOID_USB_SIDETONE_VALUE		0x200
@@ -742,6 +745,13 @@ static int corsair_void_raw_event(struct hid_device *hid_dev,
 
 	/* Description of packets are documented at the top of this file */
 	if (hid_report->id == CORSAIR_VOID_STATUS_REPORT_ID) {
+		if (size < CORSAIR_VOID_STATUS_REPORT_SIZE) {
+			hid_warn_ratelimited(hid_dev,
+			                     "unexpected status report of size %d",
+			                     size);
+			return 1;
+		}
+
 		drvdata->mic_up = FIELD_GET(CORSAIR_VOID_MIC_MASK, data[2]);
 		drvdata->connected = (data[3] == CORSAIR_VOID_WIRELESS_CONNECTED) ||
 				     drvdata->is_wired;
@@ -750,6 +760,13 @@ static int corsair_void_raw_event(struct hid_device *hid_dev,
 					      FIELD_GET(CORSAIR_VOID_CAPACITY_MASK, data[2]),
 					      data[3], data[4]);
 	} else if (hid_report->id == CORSAIR_VOID_FIRMWARE_REPORT_ID) {
+		if (size < CORSAIR_VOID_FIRMWARE_REPORT_SIZE) {
+			hid_warn_ratelimited(hid_dev,
+			                     "unexpected firmware report of size %d",
+			                     size);
+			return 1;
+		}
+
 		drvdata->fw_receiver_major = data[1];
 		drvdata->fw_receiver_minor = data[2];
 		drvdata->fw_headset_major = data[3];
-- 
2.53.0

