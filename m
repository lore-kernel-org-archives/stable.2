Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237F48F03C
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247917; cv=none; b=qvOThFM9Vp7XEEebiVnRB8qSwbXyIWXg7BW6LzvBezZw+RZHKa7ApEvYWJrSbBrlvmzgjXfBxcMmGfFmVtP/cnBeeHXKc7t17BzmbbPO6Egamvp1emiMKAGzzSukfdYEjN3epez2fVtRnmw2Jn/UR4Bsq+3n0l5KO8G0hU8KuGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247917; c=relaxed/simple;
	bh=pzHYCNoq9J/xjDTIZm1GzwKAg0a5eysa5HPlMSXc4zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThpBv+YcPJoixeymYqlcXbEEy1F3PEpGXyhVJJjd93PYkyOG7kbLNKAZ/UAhFLTe32+bmnNw+3vb7W93Qcj6iBDTHQBQQQpoqRleVn2ZnwHbmOxbC8rMGyTjzJJ1pFwXcxKWXKNe7YItLiZYWftDo0x6bjuolthp0PN7ugLFTCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvO/TU5f; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvO/TU5f"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso1945147eec.1
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792247915; x=1792852715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nt2I2LjFkGPbme+OwhKJrbwORKBaSL5qspjiblTND8U=;
        b=qvO/TU5fM5R5qvUwyT7zYJgVFkTmuuuofvZ/L8CXG+ULU+6XD7aaH4PAaDXtdu593W
         l75hTIyk3U8wYKMCd9mNhY3d/0cC0t2LIJBC5kOTKvCeuZRzUexF9tPZttN8+1cAQeaN
         NNcGEqX5tBQ+TRvOAU1KXJYmSJ/YvtwB9anNU63H8aRfL73j3i99EbMj3pqbJylhAzvm
         77nHSHHytoQy3aI7129cNMa7ITYIDVhCuOWWoDQ2fsGyuWvYgNRiTGaDd7BSflxuwSDb
         I7HI8q5rrhM4aB57vOpAQyndZJDSbHrL0EqaPB5/Yi0oHInVm3nUMQ2jeeCRSs8Rl2Jh
         0FzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792247915; x=1792852715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nt2I2LjFkGPbme+OwhKJrbwORKBaSL5qspjiblTND8U=;
        b=joUxegUw8Juq+sWWD9aZju4Q6bcAz6XMvINOSqAHRYVNr1jyUsza3m0lpbiwcadnBX
         b2Wkm7Tl3xoNyYh8P9dPnW8NvFmJM4CtSwq5Pay1J6t+ZNXS92pfUJkxjX0MPHGMCZfq
         qLpeOjY3DfCz0fXo5LNzpe6ZSp7CRazjyGeCcZCDkpVC/e/e5yLortSLchqkBHdZ6vbn
         QjoVluuxYhhdll0OQ/qSniG8EkNP6eNy/oP49/Wz4P7TkURYFZ+W7HNo7zGdHWy/EG8a
         94Ge1uzdRPA16lG2Q+gh9o8uP6q58AV6pEk07qmJvpI+gC9SXP5USnlzBEgVDDiT3x6B
         ZmrQ==
X-Forwarded-Encrypted: i=1; AKwUvBwohrA4yb8McV9d0QPg0JxWEWXQ+I0+6CuN/CcIzXXj3CW/ei/izEwhnfyKqZ5VaKqIDMnKLdw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXJz2jqlsdR3d/WWv+HEAXuWvXNKTevtKn97h29SQAHVjg4V8U
	2Qe+6vaCQfS3Ctqt+jci6t2E8ZisrwzGIA2kqtLW3AvF/o91a8MjM8Yd
X-Gm-Gg: AYBFou1PjUdKlTBODBWTOnRuhcL2dsDYotPergtHabVTz3NlQQkf9t3m4527J2nw0tx
	E4rOWcXooV9+I1qpSxrbbC4kdjCka9vl0/2md0H3TvWOF9oRFv1+P6H/qGyxi87niTTN1bD3+BU
	431/mqR3OJrS1imku8zKHlAMoKU5uPASQS3HRPRushOUQ2DBaBLkasi31lBdmX/5pex5cGiSWBy
	R7HW10J1L52qWpS5yAsShhP34TAR5SHbSyfDASHgiLtY1q9bgcUBIxiDLhXzrE4xdq+HqnEc0Ju
	NKu0WBHMZLBptER6BRQlgxPJoBEFd958ivHEoylfKMQTTXJ6AAWubid7J2OTiJNPTKY6h0OWhy4
	UB3w0xtPJij1PvFiZeQmxCOaDutlzk34EwHp7TxlhJfCpt3SjzLD71Z+zsUVRdHrMUcFtj/efk9
	FL6nhvs4tAMjPALq4KOPQcKWZKb1GPcJ5LPoQTW18OeIuCkPahYOU5gbSpsrgK
X-Received: by 2002:a05:693c:65d2:b0:35c:cd26:3066 with SMTP id 5a478bee46e88-361a36162a3mr4238189eec.41.1792247914782;
        Sat, 17 Oct 2026 07:38:34 -0700 (PDT)
Received: from beelink ([186.22.57.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081ab80f9sm26652075eec.12.2026.10.17.07.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 07:38:34 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v10 1/2] HID: haptic: make FF creation the last fallible init step
Date: Sat, 17 Oct 2026 11:38:09 -0300
Message-ID: <20261017143810.1567677-2-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017143810.1567677-1-qwe.aldo@gmail.com>
References: <20261017143810.1567677-1-qwe.aldo@gmail.com>
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

