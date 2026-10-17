Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49070222580
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792245833; cv=none; b=AU+Sqy5qzGHIUpMdd4GaG4E+mbYl/etP7xxi5rret2UoQb4SWkk2q0a8Ik+kPPCJbAZr35chGT18CO/R+4zyDSa2XGosdFlA6R4R6KjJKEUZRzh5gFlSUMfvW4SyeLn2nRbgI3rm33yEA55KH/xaJT0zpq8R+adgVQ5INS0Meec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792245833; c=relaxed/simple;
	bh=pzHYCNoq9J/xjDTIZm1GzwKAg0a5eysa5HPlMSXc4zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ue6LW3b8og2riUpKbzJOLkkmC1ZTkK6QH1GgakYeyoFRus4vpKrGE8FjWDEJNahCEBLQO9md7e9ILYnuUPqipFkeYzQF69lrFhidlM/SZxKbiN/9pPeYM6ERhT/zodvMD5JFZyfuH1KnY69zxO2Vj7QwikHQrafwzbT2TASs6OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3FxalY7; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3FxalY7"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35aa0cf7c40so1420005eec.1
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 07:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792245831; x=1792850631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nt2I2LjFkGPbme+OwhKJrbwORKBaSL5qspjiblTND8U=;
        b=a3FxalY7XcdxrvhpXKGhlIVz5WidAvfLf1wy1QWmcVvKmylKtLP2yGcUkbH4CzgVQu
         /p4VInHWHmgSTHJoZ8ftNkYxlOVqPTPDhPuW3ThcNKag1Y45LJG+imaEIThrkm31M60J
         zVycnZwViGh6FCsagqFe6UC0QcH29z0iXHCCDF3BIG+u5PSgTozkrc8ucuZuz3QmdZyE
         RMS++QpUrnKyH3VwoPXpwQ56VPPEfWg69ZzZnFEWMOJacDgZV3ErqKpybyCQ1koIkxkx
         OVyb+tUzxoR6R25o36eC4MHLWAgOtunyehFDhv8KGAt89lHcJkhOe3IF3Aq0a57SMJqP
         uzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792245831; x=1792850631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nt2I2LjFkGPbme+OwhKJrbwORKBaSL5qspjiblTND8U=;
        b=JNvgLf3+YS3efQXqQyltevrRhU/NAYVSs+EV9VKsja52HfoRSXysziI+peirtF0M09
         kvS8oP4ED2jUXvlthJsH9TZWgsaWXHIut2AtRbUd43zVSNPwGP7hg+amuM6ihT9fMR9G
         W49/+Gebp1RydZ9Nmb5ES9+JoIK6Y/tLCShYpEmDcOuP2eV1x++k+kYwh9B+brfxjPQP
         g4heCtK+YY4XBTMPR7xoJeVQYdpRM0iq3aw/fg64opSECVX5Z8FNe31ZgG5DJirDTUb2
         f0dxrAkJYt06bxajtUX9TEw525WuD0b0tQpMiBJmxD/I7FoX+Xk2CpSTr0IXm2FurlY+
         AHXw==
X-Forwarded-Encrypted: i=1; AKwUvBx4XHtoq+R0ZyWoVJajbfprIHjEMo2U+eYNQGSKOT9m7vE0the6e43XcIF6xeWjgVhUgW6wwgo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZfTo4zPqD5lafMtdJ/UYmDGhRe7PeGM+LsX3470iAdfZo0a94
	hXFano9cx5iVpa7E3cszoeHQvR1xokowEgK1chwV39wc+Efx1I22yFSF
X-Gm-Gg: AYBFou2RYL9cZZqd0dBts0D4H6dFAsBECqm5OPYelFB5AfTbr/lDASt08e8CygXd0Iu
	6L+WQ110bXkYW4xr4rokOwPzLyonmIHG0a8Z0/+wtuDgpVA6nSaOK+fT6GTbxjEqSe2yO/ZKKHa
	zOngT4Z1AQ5MLWhNeFsq3jl6xYjM2tmvdGeWZumDtfEkYbBYJ+ZLpJubxrfpmK9mUEbNoN4uOC8
	MXU5qFjd3v/EzhtnVhi1BSELifvL4TN5uGbpY628SYQMjJvpoQao1huNsFjsvW//s8cnHtEp4ri
	ZwSX/gsrO0PnMjhCEXcAdCeGXOZ2UnWvoDbYY4VwVJZrZDjsFHH8Skzv8Hs4TW7cV99KTqM8QdQ
	mHzUenC0UwK+u2g1mPRGKRqNSw63If0DVCWmR8K9g0ZdxzAREExuMLu96nIYqXNLg0icIBKgn28
	6GNcRfTG0TnfEAg/1Lr/Cz8kJauuUPZEmEADr86oejVcUDatdLIe4V7MNwA3Lf
X-Received: by 2002:a05:701b:2610:b0:176:a225:e364 with SMTP id a92af1059eb24-185138b58a9mr3491136c88.35.1792245829507;
        Sat, 17 Oct 2026 07:03:49 -0700 (PDT)
Received: from beelink ([186.22.57.86])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b37ce3fsm12727648c88.14.2026.10.17.07.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 07:03:49 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v9 1/2] HID: haptic: make FF creation the last fallible init step
Date: Sat, 17 Oct 2026 11:03:31 -0300
Message-ID: <20261017140332.1480375-2-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017140332.1480375-1-qwe.aldo@gmail.com>
References: <20261017140332.1480375-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The caller holds the module while setting up the device. Use
__module_get() after input_ff_create() succeeds, leaving no fallible
step after the FF callbacks are installed.

Drain haptic work through ff->stop when the input device is
unregistered, before it drops its parent reference. The destroy
callback also drains work for devices that were never registered.
After unregistration, that callback only frees local allocations, so
remove the extra HID device reference and its error path.

Clear the FF capability bits if input_ff_create() fails. Return the
error from hid_haptic_input_configured() and save it in the multitouch
driver. Probe must fail even if hidraw lets hid_connect() succeed after
hidinput_connect() has unwound.

Fixes: 8d0bf7908b5a ("HID: multitouch: add haptic multitouch support")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/hid/hid-haptic.c     | 48 ++++++++++++++----------------------
 drivers/hid/hid-multitouch.c | 18 ++++++++++++--
 2 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 8760eeb..0a6126e 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -96,7 +96,7 @@ int hid_haptic_input_configured(struct hid_device *hdev,
 	if (error) {
 		dev_warn(&hdev->dev, "Cannot allocate haptic for %s\n",
 			 hdev->name);
-		return 0;
+		return error;
 	}
 
 	return 1;
@@ -377,14 +377,22 @@ static int hid_haptic_erase(struct input_dev *dev, int effect_id)
 	return 0;
 }
 
+static void hid_haptic_stop(struct ff_device *ff)
+{
+	struct hid_haptic_device *haptic = ff->private;
+
+	if (haptic->wq) {
+		destroy_workqueue(haptic->wq);
+		haptic->wq = NULL;
+	}
+}
+
 static void hid_haptic_destroy(struct ff_device *ff)
 {
 	struct hid_haptic_device *haptic = ff->private;
-	struct hid_device *hdev = haptic->hdev;
 	int r;
 
-	if (hdev)
-		put_device(&hdev->dev);
+	hid_haptic_stop(ff);
 
 	kfree(haptic->stop_effect.report_buf);
 	haptic->stop_effect.report_buf = NULL;
@@ -396,9 +404,6 @@ static void hid_haptic_destroy(struct ff_device *ff)
 	}
 	haptic->effect = NULL;
 
-	destroy_workqueue(haptic->wq);
-	haptic->wq = NULL;
-
 	kfree(haptic->duration_map);
 	haptic->duration_map = NULL;
 
@@ -419,8 +424,6 @@ int hid_haptic_init(struct hid_device *hdev,
 	};
 	const char *prefix = "hid-haptic";
 	char *name;
-	int (*flush)(struct input_dev *dev, struct file *file);
-	int (*event)(struct input_dev *dev, unsigned int type, unsigned int code, int value);
 
 	haptic->hdev = hdev;
 	haptic->max_waveform_id = max(2u, haptic->max_waveform_id);
@@ -501,38 +504,25 @@ int hid_haptic_init(struct hid_device *hdev,
 
 	input_set_capability(dev, EV_FF, FF_HAPTIC);
 
-	flush = dev->flush;
-	event = dev->event;
 	ret = input_ff_create(dev, FF_MAX_EFFECTS);
 	if (ret) {
 		dev_err(&hdev->dev, "Failed to create ff device.\n");
-		goto stop_buffer_free;
+		goto ff_cap_clear;
 	}
 
 	ff = dev->ff;
-	ff->private = haptic;
 	ff->upload = hid_haptic_upload_effect;
 	ff->playback = hid_haptic_playback;
 	ff->erase = hid_haptic_erase;
+	ff->stop = hid_haptic_stop;
 	ff->destroy = hid_haptic_destroy;
-	if (!try_module_get(THIS_MODULE)) {
-		dev_err(&hdev->dev, "Failed to increase module count.\n");
-		goto input_free;
-	}
-	if (!get_device(&hdev->dev)) {
-		dev_err(&hdev->dev, "Failed to get hdev device.\n");
-		module_put(THIS_MODULE);
-		goto input_free;
-	}
+	__module_get(THIS_MODULE);
+	ff->private = haptic;
 	return 0;
 
-input_free:
-	input_ff_destroy(dev);
-	/* Restore dev flush and event */
-	dev->flush = flush;
-	dev->event = event;
-	return ret;
-stop_buffer_free:
+ff_cap_clear:
+	__clear_bit(FF_HAPTIC, dev->ffbit);
+	__clear_bit(EV_FF, dev->evbit);
 	kfree(haptic->stop_effect.report_buf);
 	haptic->stop_effect.report_buf = NULL;
 buffer_free:
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 4e19a0c..154dc94 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -174,6 +174,7 @@ struct mt_device {
 	struct mt_class mtclass;	/* our mt device class */
 	struct timer_list release_timer;	/* to release sticky fingers */
 	struct hid_haptic_device *haptic;	/* haptic related configuration */
+	int haptic_init_error;
 	struct hid_device *hdev;	/* hid_device we're attached to */
 	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_RUNNING) */
 	unsigned long *active_slots;	/* bitmap of slots with an active
@@ -1958,8 +1959,16 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	if (td->is_haptic_touchpad && (td->mtclass.name == MT_CLS_WIN_8 ||
 	    td->mtclass.name == MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
 	    td->mtclass.name == MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE)) {
-		if (hid_haptic_input_configured(hdev, td->haptic, hi) == 0)
-			td->is_haptic_touchpad = false;
+		if (hi->application == HID_DG_TOUCHPAD) {
+			ret = hid_haptic_input_configured(hdev, td->haptic, hi);
+			if (ret < 0) {
+				td->haptic_init_error = ret;
+				td->is_haptic_touchpad = false;
+				return ret;
+			}
+			if (ret == 0)
+				td->is_haptic_touchpad = false;
+		}
 	} else {
 		td->is_haptic_touchpad = false;
 	}
@@ -2197,6 +2206,11 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret)
 		return ret;
+	if (td->haptic_init_error) {
+		ret = td->haptic_init_error;
+		hid_hw_stop(hdev);
+		return ret;
+	}
 
 	ret = sysfs_create_group(&hdev->dev.kobj, &mt_attribute_group);
 	if (ret)
-- 
2.53.0

