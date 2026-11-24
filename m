Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795538814;
	b=OxFiyBZN1eFA3VbFxJRZFcTg6a33iZyiIFgDT95tDbr3Fygu55Kl7Q3sHy3ewFdslC4f
	 766g1Di8XFy5b2DttwSVm6iQeB/Gr+7i+7DY1b4eWxmDKqCXjzgSK9mE4UE6rz8FTBnGF
	 37S6FRpuH409Ky8BH94apLasya9cv96gET8kbWWh4HyXPO/svHClGvoOknTbbanW5CrxT
	 2bPULmhEDtcaT9HR5AHhAqprxUKMkkolUV5l/4ygNHNXRHKLAI1R64SNKhyvoOstTVdZn
	 OPhQyDnYJ722n0sshzSe3XdKO5L7Ztqcq6OTsuno+Jez0Lxhe84T+nKn4NBVozqpUFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538814;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=6w8Lza8VLIeRGazFkhwtljLkJp99EdnGd/ox/fIDbok=;
	b=CNmaX8GrKKTBz2rs8EiSWVIPumS2/9slln/AYd2iXElvLyS3JMJJAZ1eTjNCNFwzNpmL
	 2oySVZizmZeMF9WWv4XA0FhL7Ofcs7vGMOQCue+Sd4l/wPL3OAgMp8NE11IpKxmg581Oy
	 7iHP0v8Ty8eTaC2PAPDwCMpnd2pAlrjf3iUxVFWelMgafNcx8NNeKS8WX4FgIswqj1mWF
	 m6WKGsBdYIcXcVlA9OX8rfKLH67dlnalbY9b7UYFD1wY8F2VsTQZLEg0VnYbLqmNWHmy8
	 UnIw7mDYr5S7TYTIQaQYPPnjYcCPI3Byx6JWWfWgJItWAph7GkkZ8FtDHa0wB3NAqRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=mnNzk6qs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
Received: from sender5-pp-f112.zoho.com (sender5-pp-f112.zoho.com [165.173.182.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E05606A31E;
	Tue, 24 Nov 2026 16:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74E05606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=mnNzk6qs
ARC-Seal: i=1; a=rsa-sha256; t=1795538722; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PL/anYW4ogmH9NyNZqS/bRUAua0zoNl/23IOs4YKf//90tTZH7C/HR1IF2Vlnr8fu+0LAl0JHPr/tukce2yKHfwneXhvOEhMfDn4kczkpbqhJ51isXgy1JpkeNUPzw1xU0O7KNkemz7sx+/izEi1CZipbTQbD2nF5HBXt7+7Sjg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795538722; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6w8Lza8VLIeRGazFkhwtljLkJp99EdnGd/ox/fIDbok=; 
	b=cXl1CTF9DEXM/b3dkQmCKHGM7Ub2LNdni7WWtDIS/TJ3kjkKxDFaPV3gvhCDZdZpf5zWrFyzGZ0qZXrMfM+yhZd28ArT+ypFtO08JNb6rzqr3lDKNmA99h7eC3DVZzTKynuvDwsN02tgR54aN4TNp9/M3Drsqu/R3QwGMhnTGjU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=mnNzk6qstzOpzR0nReSSEZ4shVz3KpxolHGnMj027t6VQ/QKN+410uHs81MmEqhXG8Qg3QqS/xCZUNDqSIAMMPVD4zb+VJC2CuKgW+mTTZQuSqtsPcinchY5nWORUoGFoULybTlOHjGIlBx2/ZWB8frLhpv/lp0DM7qmCbiKNro9xxZZtD/WOlHq2+KRtuKNIT1HmD6D7SbGPjiKvfIbeeaYZ7PA6YeJU8TJZDkANO2dmOus4c0Ao7fS8mfY0iBzKn7rlLqaqwVtPyRdo5pVXR6p4lTpmIksw0c52DT/A9z1xqJepG2NPL2bKYUvnjaJJF5gR6FimiTSp7Dg+gFQfQ==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=6w8Lza8VLIeRGazFkhwtljLkJp99EdnGd/ox/fIDbok=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795538719885405.58866706960873;
	Tue, 24 Nov 2026 08:45:19 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Wed, 25 Nov 2026 00:44:32 +0800
Subject: [PATCH v4 4/9] HID: haptic, multitouch: Fix haptic device
 double-free and unnecessary allocation
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-hid-haptic-kmod-v4-4-03713a89f656@rong.moe>
References: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
In-Reply-To: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Angela Czubak <aczubak@google.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

The haptic device is allocated by devm_kzalloc(), which will be freed by
devres on HID device release. At that time, the ff core has already
freed it on input device release previously, causing double-free.

Allocate the haptic device using kzalloc_obj() to ensure its release can
be safely delegates to the ff core.

The allocation code is also moved to hid-haptic.h, so that it can be
replaced by a stub in !CONFIG_HID_HAPTIC builds, eliminating the
meaningless alloc-and-free sequence.

Fixes: 8d0bf7908b5a ("HID: multitouch: add haptic multitouch support")
Cc: stable@vger.kernel.org
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v3:
- Correct the Fixes: tag (thanks Sashiko)
---
 drivers/hid/hid-haptic.h     | 17 +++++++++++++++++
 drivers/hid/hid-multitouch.c | 39 +++++++++++++++++++++++++++++----------
 2 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-haptic.h b/drivers/hid/hid-haptic.h
index cd4d9c74d2dc..7878cd73ccdb 100644
--- a/drivers/hid/hid-haptic.h
+++ b/drivers/hid/hid-haptic.h
@@ -5,6 +5,7 @@
  *  Copyright (c) 2021 Angela Czubak <acz@semihalf.com>
  */
 
+#include <linux/err.h>
 #include <linux/hid.h>
 
 #define HID_HAPTIC_ORDINAL_WAVEFORMNONE 1
@@ -54,6 +55,17 @@ struct hid_haptic_device {
 };
 
 #if IS_ENABLED(CONFIG_HID_HAPTIC)
+static inline struct hid_haptic_device *hid_haptic_alloc(struct hid_device *hdev)
+{
+	struct hid_haptic_device *haptic;
+
+	haptic = kzalloc_obj(struct hid_haptic_device);
+	if (haptic)
+		haptic->hdev = hdev;
+
+	return haptic;
+}
+
 static inline bool hid_haptic_connected_to_input(struct hid_haptic_device *haptic,
 						 struct input_dev *input)
 {
@@ -80,6 +92,11 @@ void hid_haptic_pressure_reset(struct hid_haptic_device *haptic);
 void hid_haptic_pressure_increase(struct hid_haptic_device *haptic,
 				  __s32 pressure);
 #else
+static inline struct hid_haptic_device *hid_haptic_alloc(struct hid_device *hdev)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline bool hid_haptic_connected_to_input(struct hid_haptic_device *haptic,
 						 struct input_dev *input)
 {
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 5eea774dee44..a9c8396c804e 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -34,6 +34,7 @@
 #include <linux/bitmap.h>
 #include <linux/bits.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/hid.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -2129,11 +2130,18 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		dev_err(&hdev->dev, "cannot allocate multitouch data\n");
 		return -ENOMEM;
 	}
-	td->haptic = devm_kzalloc_obj(&hdev->dev, *(td->haptic));
-	if (!td->haptic)
+
+	td->haptic = hid_haptic_alloc(hdev);
+	if (IS_ERR(td->haptic)) {
+		ret = PTR_ERR(td->haptic);
+		if (ret == -EOPNOTSUPP)
+			td->haptic = NULL;
+		else
+			return ret;
+	} else if (!td->haptic) {
 		return -ENOMEM;
+	}
 
-	td->haptic->hdev = hdev;
 	td->hdev = hdev;
 	td->mtclass = *mtclass;
 	td->inputmode_value = MT_INPUTMODE_TOUCHSCREEN;
@@ -2178,12 +2186,14 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ret = hid_parse(hdev);
 	if (ret != 0)
-		return ret;
+		goto out;
 
 	if (mtclass->name == MT_CLS_APPLE_TOUCHBAR &&
 	    !hid_find_field(hdev, HID_INPUT_REPORT,
-			    HID_DG_TOUCHPAD, HID_DG_TRANSDUCER_INDEX))
-		return -ENODEV;
+			    HID_DG_TOUCHPAD, HID_DG_TRANSDUCER_INDEX)) {
+		ret = -ENODEV;
+		goto out;
+	}
 
 	if (mtclass->quirks & MT_QUIRK_FIX_CONST_CONTACT_ID)
 		mt_fix_const_fields(hdev, HID_DG_CONTACTID);
@@ -2193,7 +2203,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = sysfs_create_group(&hdev->dev.kobj, &mt_attribute_group);
 	if (ret)
@@ -2202,10 +2212,19 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	mt_set_modes(hdev, HID_LATENCY_NORMAL, TOUCHPAD_REPORT_ALL);
 
-	if (!td->is_haptic_touchpad)
-		devm_kfree(&hdev->dev, td->haptic);
+	ret = 0;
 
-	return 0;
+out:
+	/*
+	 * Don't double free when the haptic device has been delegated to the ff
+	 * core.
+	 */
+	if (td->haptic && !td->is_haptic_touchpad) {
+		kfree(td->haptic);
+		td->haptic = NULL;
+	}
+
+	return ret;
 }
 
 static int mt_suspend(struct hid_device *hdev, pm_message_t state)

-- 
2.55.0

