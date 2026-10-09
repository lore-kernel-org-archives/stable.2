Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA09C35202E
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 03:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791515537; cv=none; b=bS7SUYmZIZPLQqJOq+lLDxu/6HplGMWlGH3Ls9Cji5EprcHtIaLCbgDXRQRD9rFsZsH6ZBGegVcAd7+/6rydcj05QUszU7rfL5jN/VpLBnGcZ9Iyh+Vwiv7TlxQDmOxFmUhN5c5mQlOh/TUkg8syVkW7C6lzvKdYyNNOu/fvwdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791515537; c=relaxed/simple;
	bh=FfXq19o0LIgTCw0SO+Op5Rv5TKYGoxRLlU+jTxLkmk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K7/li/gnAJaEIk5jdMFWA20hfhsKgYiYHW4r7aPqCT8nUlXf07W6vAOrNyCJoGtWuWW/Eo5ckH73Ive65N6X2Kew+vlVviKz/6hoeYS0GJFKFOpkgRqq+P5pIaY6+8VVV5n8LKHt1Mu8OmGnxDUhxSWyWlBcUtCkUPobsUNLVXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idaFz2bj; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idaFz2bj"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5e519c39196so1293661e0c.3
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 20:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791515533; x=1792120333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2lGnbxYVsuq+Lgb6XonYa97KYSsgkUoCFPmQ6flzydM=;
        b=idaFz2bjpJqJl9ER5G3rR77VHQTLOlQzUztwWxO7i+TtPiE7y80EMCNcdtxt1DHMco
         DJBu7ZSAsEsXnNla5QdQmXQhYnMD9Qlc3Ek5uWux6UBMlOw/zfTJpg0l6W87zGRZy3d6
         AmSVKr+PBC9bP8rlAl1pKwmiwDfxs3IxML/QguGYNLEoUHLk2FAko0Zj/IOW/xwD/j5x
         mo8An1LDZNbKYjvVpYd1TLazQqayoepf+AQloQlPLo92e3Iip3cddRk8wC0v+T+RwToT
         o2Z4VB6uk3dzXVyrFg8Plaje/8MSgv/cX3H7cct8RAjMXfobIvUY0gMSufTuIwiP/icL
         M0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791515533; x=1792120333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2lGnbxYVsuq+Lgb6XonYa97KYSsgkUoCFPmQ6flzydM=;
        b=pl0JLuhqrTJtqOQOtb209i8oG3Z5Rk/M5oqBe2wZObJVNNSBxR1o9LnO90bDkteA3Y
         ZEK5DeBRetLJ3mVg7bjm6jXK/YMRvfKltJ1HfzF/w5Mgl+BmHq+hcEA11ZPy9xSaAD8A
         pW1smeFT9nwV5ZGoO1WrSH1GRfSCn+p9i9oNcxcFd+/mfEi5FOC607bWY+Z+g+RYEquc
         PG3Vk7lz2KN/hjb0Iee5vjKuB0iHbSXzOTccU5WtQfP5Ku3bta8t+C+yVZ2bXX5ivcJp
         aFmjzTqpr5x99E0EfSeEN1d42FW98GP+AhnNoRc3pdUvFYm8coK0J9X3mUyRekNaIqko
         zPRw==
X-Forwarded-Encrypted: i=1; AKwUvBzAof0VhUuOxioLppxqdkIOtIjH5r4V2X5kBj7XxQc/Foei55no3UFwGngwbHGvwAOl0vDqVr0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJb2NT4UrgJ9KxwY6clXqHj5dxwscnjSZ5PMHmY3WEXNWHZJ8us
	L46pv7djGbnxS0h0Az63BrwTRdvxoCzj98MEKxatUevRbCF7bLYNCU0x
X-Gm-Gg: AYBFou0BauyR7/rxcTVt8Yh6rgky/z6s4MnJjk7w++Vgf2xiF8ycd4143E9pK9yUoKF
	b1631GwYNYq9icLoRXpsM3c9F39hWEHjxLXwkpiEn2cpXiCbGm9qvChSGVMGafspwkZVP4uV10u
	PnYzvb29ZC/qcyHEHEi3l4KK45FmQQdV7ZsGF7EidP14aUHwIgs14ZA0JslsHiDcOSt9tmgOFUo
	7bkoD9CyJJNempBIdBtg9W2hmNY94u6z1Y20//bbSOh6A9klzMbU5TemdZICe0vEs24kNrLa791
	9zQGMuBP8iFev+bVPZHrpGWOIQldxa9sLPYpwrF8zr/bikA2ioK8MozMoYBye6pzR9lENldEx+u
	mrwHNKMou9pqJ6eeyzyDkmz7kwCZZjavtN4NRmoDcI23MvWGksXz/JiM7ePyKlDcoaKslyAHDn5
	YGD7macEG9j0JlR6ojxLeVFTxJY56GRTSkEEUC9ujsXFNMh6C3/nBckheLvrzsyOY=
X-Received: by 2002:a05:6122:1da0:b0:5c9:a60d:3279 with SMTP id 71dfb90a1353d-5e91f4d6f14mr145097e0c.13.1791515533458;
        Thu, 08 Oct 2026 20:12:13 -0700 (PDT)
Received: from beelink.. ([187.13.210.57])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e91cbf5d1fsm766684e0c.14.2026.10.08.20.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 20:12:12 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] HID: haptic: fix use-after-free of devm haptic data in hid_haptic_destroy()
Date: Fri,  9 Oct 2026 00:12:03 -0300
Message-ID: <20261009031203.3127352-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt_probe() allocates td->haptic with devm_kzalloc(), tying its
lifetime to the HID device's driver unbind.  hid_haptic_init() then
installs hid_haptic_destroy() as the force-feedback destroy callback,
which dereferences haptic->hdev on its very first line.

When the HID device is removed while a process still holds an evdev
fd, devres frees td->haptic at unbind time, but hid_haptic_destroy()
runs later from input_dev_release() when the last fd closes.  The
callback operates on freed memory.

The existing get_device()/put_device() pair in init/destroy pins the
struct hid_device but does not keep its devres allocations alive,
since devres runs at driver unbind, not at the final device kref put.

Replace devm_kzalloc() with plain kzalloc() for the haptic struct so
it outlives the driver.  Free it at the end of hid_haptic_destroy(),
which already tears down every sub-allocation manually and holds a
device reference that keeps hdev alive until the kfree.  On the
non-haptic path and the error paths in mt_probe(), use kfree()
instead of devm_kfree().

Fixes: 8d0bf7908b5a ("HID: multitouch: add haptic multitouch support")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/hid/hid-haptic.c     |  2 ++
 drivers/hid/hid-multitouch.c | 18 ++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 8760eeb08..6c365dbf0 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -406,6 +406,8 @@ static void hid_haptic_destroy(struct ff_device *ff)
 	haptic->hid_usage_map = NULL;
 
 	module_put(THIS_MODULE);
+
+	kfree(haptic);
 }
 
 int hid_haptic_init(struct hid_device *hdev,
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 4e19a0c4d..4f7b97cd4 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2132,7 +2132,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		dev_err(&hdev->dev, "cannot allocate multitouch data\n");
 		return -ENOMEM;
 	}
-	td->haptic = devm_kzalloc(&hdev->dev, sizeof(*(td->haptic)), GFP_KERNEL);
+	td->haptic = kzalloc(sizeof(*(td->haptic)), GFP_KERNEL);
 	if (!td->haptic)
 		return -ENOMEM;
 
@@ -2181,12 +2181,14 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ret = hid_parse(hdev);
 	if (ret != 0)
-		return ret;
+		goto err_free_haptic;
 
 	if (mtclass->name == MT_CLS_APPLE_TOUCHBAR &&
 	    !hid_find_field(hdev, HID_INPUT_REPORT,
-			    HID_DG_TOUCHPAD, HID_DG_TRANSDUCER_INDEX))
-		return -ENODEV;
+			    HID_DG_TOUCHPAD, HID_DG_TRANSDUCER_INDEX)) {
+		ret = -ENODEV;
+		goto err_free_haptic;
+	}
 
 	if (mtclass->quirks & MT_QUIRK_FIX_CONST_CONTACT_ID)
 		mt_fix_const_fields(hdev, HID_DG_CONTACTID);
@@ -2196,7 +2198,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret)
-		return ret;
+		goto err_free_haptic;
 
 	ret = sysfs_create_group(&hdev->dev.kobj, &mt_attribute_group);
 	if (ret)
@@ -2206,9 +2208,13 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	mt_set_modes(hdev, HID_LATENCY_NORMAL, TOUCHPAD_REPORT_ALL);
 
 	if (!td->is_haptic_touchpad)
-		devm_kfree(&hdev->dev, td->haptic);
+		kfree(td->haptic);
 
 	return 0;
+
+err_free_haptic:
+	kfree(td->haptic);
+	return ret;
 }
 
 static int mt_suspend(struct hid_device *hdev, pm_message_t state)
-- 
2.43.0

