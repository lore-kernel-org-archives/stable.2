Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D51F4DC551
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163643; cv=none; b=gWR1UnTWv0BTk5g0lAB4KLRaLdxSZjiW9asEJxorT9fUjSupnyEKVrsRIm60ut87Mm/Yn+H3fwS/HA8DVaOHFCcQxQ7ma8g7gZCpdySR+zytENJ0ZHAjoV3a1D1Lj8y1VnfDVQaZYBK/3cRnqjQYQwNoys7oUUmhjW2KqKIJ5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163643; c=relaxed/simple;
	bh=Tfm02lrkH9VmFMESRukHB3YhrdebKxeHbFXI7GjENkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAjFs25g1eWAs+vgGi+BNkcqZ+dbUjuqpnF30La7MxSwT5oU+uPd3j2FiLekAB+mKiPiIq0JGOJ6ydxk7Fxq06GJqNyaw7F+uKPnsZ8YIh2xFw9yNumWOEVZBMtaSxJbrD/xxqKyc8KIGDYE9w6IOF8CBv/HO1/xBGJ5ovE3Xzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qnOXZjEK; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnOXZjEK"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5363c8de563so144251cf.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 08:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792163641; x=1792768441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4cg/NeALXrxKotAI3u5uSYzw1KdGURDQwTKLcHQsWt8=;
        b=qnOXZjEKSXUpRA4t8c/bvp1B3XJ6uXyIZdu1jONR66thaTmL7XIKjQ87VYCSj8QvH8
         bwHwe0VPvPVd8dinXptF4d4E5DqRcdJ4FqL5lW2f/MwxdZibyGpMQlAksz5xm8MlEZXr
         D9goXraLQyam0bkADr9Mb8G4hUPUZmtYLNcQhIb/nmY28YztHc+lXIyEoqkIit5AJY3i
         ot7ji6YWY6dw3d5N98RjKYFNp+emmefm5SE923xIYUzDm/KebxREvDlPtP/X4F3GrqJv
         /zo1f/XwkAcHg6Pbi9UvY7w+VWH8RUf27CwF2KW1pqMFwpmBEKka+/SfWotY+WrvgaUK
         AHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792163641; x=1792768441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4cg/NeALXrxKotAI3u5uSYzw1KdGURDQwTKLcHQsWt8=;
        b=BLYXmyMchZTWkRmsZ604Bxdf/hO44tDGvJUxA2HlzGQH67uDw4LCemFSNf1OL/8MWR
         lFyU1nKd7iCgMFFtcIoIIvJIx36ht02vGTo9SgThHEolLRcW+O8NW26nnib46ypYwXAt
         98AW4Q3GOLqtBk99LDmXrf4l5zTns3Ms/WStMloBC75BFq71oOMK2VA7CnQ/OOw88DpE
         aw0xJJnx+As477Vl1TR/4mhdojK4UemL8bjlbxO+ZGJ49+MJenH5fpKeLEslQ1MxysXj
         NUqftyvkJ5yqTUdzaIeZpyj4o8XJBrtdFSvGuN9IwiZx4EHWqx93H1SVoxWKmxWeg6vd
         z3WQ==
X-Forwarded-Encrypted: i=1; AKwUvBxbIoxJAeqEuccSIP/+qifjf7OywfXjSnhvFZt9uJSQACSBrbqgG8bpOkqyCpTByJmqXAvK4H4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdGZNTB56R43Fq6Jgs5OiWtU0WoAOp0vOxt7LqCfMhdVsh/cke
	MIQB497MwKvGUia0WSU6kIHtFwD7FVsYaFw+zdDNhhwTmRKCr9hXuwrGuo1wIPJk
X-Gm-Gg: AYBFou3wOSjVQGPasvi0UJ+PXjrF0qCy+c8PkCscjdpyP/jki9EvfmevFvAJHUqAb9N
	AhUkS5NLiO7afzXvSW+u75V8Mb5T1cDJS9dnKGCZOI9OwNku+L9xPVTuSVJfOMX3DPdP5HJ6qog
	bWzTSH271FXtL5hQh1pxxZK9tBBDe+0Obr5F+nbHHFg81ErQY9Os9uifDqB9qCRA7EsfnCCb6n0
	mArUa2M3YSBStR+H2HDxgCYo6E+EPwQcAPKoFdzmXre0qqrD6gR/HagnRDUeUiHKvxh6ZQmd9XU
	ZNsgt6rF/Y1qhDl9uJmI7yq5Ywfzpicb3C1htGT+VXb2ZdgDOnE5zJmUfNye6zuRXrhoRqfmSWp
	D+a7l/XmebkTjsF7LDi8nqvtP1WeuwroZIUhUpaaXEU69bz78mjx6t9CvckZyni3HvjuGYYzniJ
	CHgmJBYRnopFgJx4QBqFwImnx8P8CJbjRFj9YXofUONKjIZDEl2VsHTZ/NK/ryQ8k=
X-Received: by 2002:ac8:5d0a:0:b0:536:2fd8:a4d8 with SMTP id d75a77b69052e-5362fd8a9a2mr33325271cf.15.1792163641162;
        Fri, 16 Oct 2026 08:14:01 -0700 (PDT)
Received: from beelink ([187.15.139.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362aa59b03sm24674041cf.27.2026.10.16.08.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:14:00 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v6 2/2] HID: multitouch: fix use-after-free of haptic data on delayed input release
Date: Fri, 16 Oct 2026 12:13:42 -0300
Message-ID: <20261016151343.3120300-3-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016151343.3120300-1-qwe.aldo@gmail.com>
References: <20261016135516.2957381-1-qwe.aldo@gmail.com>
 <20261016151343.3120300-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt_probe() allocates td->haptic with devm_kzalloc() and hid_haptic_init()
stores it in ff->private.  When the HID device is removed while an evdev
fd is still held, devres frees td->haptic at unbind but
hid_haptic_destroy() runs later from input_dev_release() and dereferences
the freed pointer.  input_ff_destroy() then double-frees it via
kfree(ff->private).

Move all resource cleanup into a devm_add_action() callback so it runs
at unbind before devres frees the struct.  hid_haptic_destroy() becomes
ff->private = NULL plus module_put() -- keeping the module loaded until
the FF subsystem is done with the callback.  The input device is pinned
with input_get_device() to prevent concurrent release during the devres
action; the workqueue is drained first while all buffers are still live.

Guard against double-init when multiple touchpad collections trigger
hid_haptic_init() for the same haptic struct.

Fixes: 8d0bf7908b5a ("HID: multitouch: add haptic multitouch support")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/hid/hid-haptic.c | 74 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 592b44e..6d72d9c 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -379,32 +379,61 @@ static int hid_haptic_erase(struct input_dev *dev, int effect_id)
 
 static void hid_haptic_destroy(struct ff_device *ff)
 {
-	struct hid_haptic_device *haptic = ff->private;
-	struct hid_device *hdev = haptic->hdev;
+	/*
+	 * Resource cleanup is handled by hid_haptic_devm_release() at
+	 * driver unbind.  Disconnect the FF pointer so input_ff_destroy()'s
+	 * kfree(ff->private) becomes kfree(NULL).  Drop the module
+	 * reference last -- it must outlive this callback.
+	 */
+	ff->private = NULL;
+	module_put(THIS_MODULE);
+}
+
+static void hid_haptic_devm_release(void *data)
+{
+	struct hid_haptic_device *haptic = data;
+	struct input_dev *dev = haptic->input_dev;
 	int r;
 
-	if (hdev)
-		put_device(&hdev->dev);
+	/*
+	 * Drain pending work first -- handlers dereference ff->private
+	 * through the input_dev, so the workqueue must be idle before
+	 * we NULL that pointer or free any buffers.
+	 */
+	if (haptic->wq) {
+		destroy_workqueue(haptic->wq);
+		haptic->wq = NULL;
+	}
+
+	if (dev && dev->ff && dev->ff->private == haptic)
+		dev->ff->private = NULL;
+
+	if (haptic->hdev) {
+		put_device(&haptic->hdev->dev);
+		haptic->hdev = NULL;
+	}
 
 	kfree(haptic->stop_effect.report_buf);
 	haptic->stop_effect.report_buf = NULL;
 
 	if (haptic->effect) {
-		for (r = 0; r < ff->max_effects; r++)
+		for (r = 0; r < FF_MAX_EFFECTS; r++)
 			kfree(haptic->effect[r].report_buf);
 		kfree(haptic->effect);
 	}
 	haptic->effect = NULL;
 
-	destroy_workqueue(haptic->wq);
-	haptic->wq = NULL;
-
 	kfree(haptic->duration_map);
 	haptic->duration_map = NULL;
 
 	kfree(haptic->hid_usage_map);
 	haptic->hid_usage_map = NULL;
 
+	if (dev) {
+		input_put_device(dev);
+		haptic->input_dev = NULL;
+	}
+
 	module_put(THIS_MODULE);
 }
 
@@ -414,12 +443,17 @@ int hid_haptic_init(struct hid_device *hdev,
 {
 	struct ff_device *ff;
 	int ret = 0, r;
+	int (*saved_flush)(struct input_dev *, struct file *);
+	int (*saved_event)(struct input_dev *, unsigned int, unsigned int, int);
 	struct ff_haptic_effect stop_effect = {
 		.hid_usage = HID_HP_WAVEFORMSTOP & HID_USAGE,
 	};
 	const char *prefix = "hid-haptic";
 	char *name;
 
+	if (haptic->wq)
+		return 0;
+
 	haptic->hdev = hdev;
 	haptic->max_waveform_id = max(2u, haptic->max_waveform_id);
 	haptic->max_duration_id = max(2u, haptic->max_duration_id);
@@ -511,6 +545,8 @@ int hid_haptic_init(struct hid_device *hdev,
 		goto stop_buffer_free;
 	}
 
+	saved_flush = dev->flush;
+	saved_event = dev->event;
 	ret = input_ff_create(dev, FF_MAX_EFFECTS);
 	if (ret) {
 		dev_err(&hdev->dev, "Failed to create ff device.\n");
@@ -525,6 +561,28 @@ int hid_haptic_init(struct hid_device *hdev,
 	ff->playback = hid_haptic_playback;
 	ff->erase = hid_haptic_erase;
 	ff->destroy = hid_haptic_destroy;
+
+	/*
+	 * Pin the input device so it cannot be released concurrently
+	 * with our devres cleanup, and take a second module reference
+	 * so the module stays loaded while hid_haptic_devm_release()
+	 * executes (the first ref is dropped by hid_haptic_destroy()
+	 * which may run inside input_put_device() below).
+	 */
+	input_get_device(dev);
+	__module_get(THIS_MODULE);
+
+	ret = devm_add_action(&hdev->dev, hid_haptic_devm_release, haptic);
+	if (ret) {
+		module_put(THIS_MODULE);
+		input_ff_destroy(dev);
+		dev->flush = saved_flush;
+		dev->event = saved_event;
+		input_put_device(dev);
+		put_device(&hdev->dev);
+		goto stop_buffer_free;
+	}
+
 	return 0;
 
 stop_buffer_free:
-- 
2.53.0

