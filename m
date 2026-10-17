Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD61747F784
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247921; cv=none; b=R5S3UW4Ll0gtti8QfoPhs9U2CYkI4h1GgtH5X12/e1iHmoIMF7ogwADQv4SRHDi26IosazZnO/nbxRFEebH2RzNIjBw6EOyWCs9tyy7uDRZYozpDnFHFTVpRYygVizvuZxc+m/J8HHeoaqjteqCBj67lP1/w6VZJQ6fgYXIURcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247921; c=relaxed/simple;
	bh=9BCu4demUzTnXPk45hSWaOqkBCGnzNG0yYDUdRCCMp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daC7Jn6oXaI+RuZ83Z1at9Uus2YQou2yiLvN4QT75Rn9ZC008CDorDm00X9XJCVU6wEVjBM4JuJw6LN2fzKDP6mjkKaOG9mcPMT57CrJGzRgSSFM6ef1XY6dj9tDm9mPNWoFi9nGaY4Sjo3erLv0plX/mAtaLwKpGVj7idQwm+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1M6+STm; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1M6+STm"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3550c917fd3so926693eec.0
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792247918; x=1792852718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TnxjOcsDfjNAvZU8dj+rOzYZGfEa0Jvxh69bQaxfS9o=;
        b=Y1M6+STmGLLETRIsIJHW5hle0h/BbWHKH/zevK6qvs61+p6mXzqoPNL/++x3sFl9le
         DOlIibbcFH7nj7HM3xfsaJyO/suPOCL+M24/nFS8pthyNNtYD14vxxJDRxcdxzg2nIUm
         nFLjxoflh3qKAdOsHiGl/BUTrOyWnhANLqiBIPP1f1SFkVfPGPbb0H+k/uDw43O0U7iM
         noj9J2/wryUrTLbCMtapK57e89KkNRt2iCsG7QGQUnnoarS1YWG0GvT9CyW3JNhkNmo5
         XFMi0laC26tKHzXXhG75UCUcRBb5J1woF077xMpZpuYezHdbCsit4baOmFnaiNOeGh0k
         PRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792247918; x=1792852718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TnxjOcsDfjNAvZU8dj+rOzYZGfEa0Jvxh69bQaxfS9o=;
        b=CSZ/KiGmQ6igLreGvSWfkq7sqb7xmPqOkrgkUnsU1NlduMgDXnPTcO8vMPhJmqbSOg
         8LZ9/rkLZfQNkBhyZfFOI0yBtUAeUriytD6nqiO/bGsPZhA2MjA8gHBX++0uNufi9Skq
         JzgF4hRN4vC7uO+Ua7gw84ouvSN3zifqf2sAsAQFAvDLDXsHaYc2glCdFz2T08XH4vVw
         bgVyqX+LC4h4DOxavZNbsINKVhXpuGWkbQvCcZaSxEtPXjE71gBqlraeovARS1w9PYnm
         PTgIsNHyul2qcX5xbW5WINZ4dPxB1URi0w6Nf92YHgU10eVdx7ofEKho9VVkyqo/s39Z
         B5kA==
X-Forwarded-Encrypted: i=1; AKwUvBx3LD82jnBirATBW1JcNrABHs+IDAJgJMJ/Adceofop0f2OjKvy9JLhi7N5BR4eEQKpJi9CoH0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/WRXdnCY9XIJGy1PN2xf0sGgoRlWWMiRB13KvYuSdkw4Mi6IY
	klYJo41bsCXA0nEuISf+awuoeS65+YFwN3TwEuoZtGwZv66h2Ik5cQn5FvuBtWa43wVpPA==
X-Gm-Gg: AYBFou0gnOXv3pIbeZG+j0wjaCMd0oKlrZP6FJ9XdVcRKu2YOD2I2IUVNwWY+ZU+/en
	VzkqPaRqXdVnScGoFxVRjAtrm0TzISt/GCWIhJsn2zrL6cbHNVmmxqjTYGjvCA+qJ8OfPPeuWTf
	wWJa7fHFc/FemKL6Ma2owxDiFKQhAY+DG4toIzAH8JYgRziWlPmX4gx6bN+HB2Slpi1A1zAAEov
	V00vBVgXXJNjUo3oejhh8XWFnjZwt5mdzAdSdzpmWaA5/ulS1sek5h+5n8G5KCX1JYfcJ/boUM5
	In/U3llzjoU3ED9vKNSMpw+I8w1E4HpEcQOU+F3zRnlmEynoGKzAEGxYjY2hIWUyfcILzXQapfi
	/MuEcruneX005u4GR/pWwrtEPEJRIgwT1eNt7AiIIrwHmgHwHqeq3zrYKuXvEa1CZe0rh3pfYLf
	hRoV3mHWNtRtt1/dmLu1MWIUHdGyGwtaAsK/K29u0R2RmJewyCZmmQQ6J4bi5T
X-Received: by 2002:a05:693c:66d5:10b0:359:a6ed:41ab with SMTP id 5a478bee46e88-361a2a3cd8fmr4375850eec.36.1792247917659;
        Sat, 17 Oct 2026 07:38:37 -0700 (PDT)
Received: from beelink ([186.22.57.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081ab80f9sm26652075eec.12.2026.10.17.07.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 07:38:37 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v10 2/2] HID: multitouch: give FF core ownership of haptic state
Date: Sat, 17 Oct 2026 11:38:10 -0300
Message-ID: <20261017143810.1567677-3-qwe.aldo@gmail.com>
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

An open evdev fd can delay input_ff_destroy() until after HID unbind.
The descriptor mapping state is devres managed and cannot serve as
ff->private for that lifetime.

Clone the mapped state in hid_haptic_init(). Transfer the allocation
to ff->private only after input_ff_create() succeeds; the input core
then frees it at final input device release. Scope cleanup releases
the clone and its subresources on initialization failure.

On devices with multiple inputs, attach FF to the first input with a
multitouch touchpad report. An earlier touchpad report without a
multitouch collection must not consume the single FF instance. Other
inputs skip FF initialization and do not acquire INPUT_PROP_PRESSUREPAD
from the haptic setup. The HID reports are shared, so multiple FF
instances would write the same fields under different mutexes.

Fixes: 8d0bf7908b5a ("HID: multitouch: add haptic multitouch support")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/hid/hid-haptic.c     | 131 ++++++++++++++++++-----------------
 drivers/hid/hid-haptic.h     |   6 +-
 drivers/hid/hid-multitouch.c |  38 +++++-----
 3 files changed, 91 insertions(+), 84 deletions(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index 0a6126e..ec2a891 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -5,6 +5,7 @@
  *  Copyright (c) 2021 Angela Czubak <acz@semihalf.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/input/mt.h>
 #include <linux/module.h>
 
@@ -90,7 +91,9 @@ int hid_haptic_input_configured(struct hid_device *hdev,
 	if (!haptic->auto_trigger_report || !haptic->manual_trigger_report)
 		return 0;
 
-	__set_bit(INPUT_PROP_PRESSUREPAD, hi->input->propbit);
+	/* The HID reports are shared; create only one FF instance. */
+	if (haptic->input_dev)
+		return 1;
 
 	error = hid_haptic_init(hdev, haptic, hi->input);
 	if (error) {
@@ -99,6 +102,9 @@ int hid_haptic_input_configured(struct hid_device *hdev,
 		return error;
 	}
 
+	__set_bit(INPUT_PROP_PRESSUREPAD, hi->input->propbit);
+	haptic->input_dev = hi->input;
+
 	return 1;
 }
 EXPORT_SYMBOL_GPL(hid_haptic_input_configured);
@@ -377,53 +383,76 @@ static int hid_haptic_erase(struct input_dev *dev, int effect_id)
 	return 0;
 }
 
-static void hid_haptic_stop(struct ff_device *ff)
+static void hid_haptic_stop_work(struct hid_haptic_device *haptic)
 {
-	struct hid_haptic_device *haptic = ff->private;
-
 	if (haptic->wq) {
 		destroy_workqueue(haptic->wq);
 		haptic->wq = NULL;
 	}
 }
 
-static void hid_haptic_destroy(struct ff_device *ff)
+static void hid_haptic_stop(struct ff_device *ff)
+{
+	hid_haptic_stop_work(ff->private);
+}
+
+static void hid_haptic_free_resources(struct hid_haptic_device *haptic)
 {
-	struct hid_haptic_device *haptic = ff->private;
 	int r;
 
-	hid_haptic_stop(ff);
+	hid_haptic_stop_work(haptic);
 
 	kfree(haptic->stop_effect.report_buf);
-	haptic->stop_effect.report_buf = NULL;
 
 	if (haptic->effect) {
-		for (r = 0; r < ff->max_effects; r++)
+		for (r = 0; r < FF_MAX_EFFECTS; r++)
 			kfree(haptic->effect[r].report_buf);
 		kfree(haptic->effect);
 	}
-	haptic->effect = NULL;
 
 	kfree(haptic->duration_map);
-	haptic->duration_map = NULL;
-
 	kfree(haptic->hid_usage_map);
-	haptic->hid_usage_map = NULL;
+}
+
+static void hid_haptic_free_state(struct hid_haptic_device *haptic)
+{
+	if (haptic) {
+		hid_haptic_free_resources(haptic);
+		kfree(haptic);
+	}
+}
+
+DEFINE_FREE(hid_haptic_state, struct hid_haptic_device *, hid_haptic_free_state(_T));
+
+static void hid_haptic_destroy(struct ff_device *ff)
+{
+	struct hid_haptic_device *haptic = ff->private;
+
+	hid_haptic_free_resources(haptic);
 
 	module_put(THIS_MODULE);
 }
 
 int hid_haptic_init(struct hid_device *hdev,
-		    struct hid_haptic_device *haptic,
+		    const struct hid_haptic_device *config,
 		    struct input_dev *dev)
 {
+	struct hid_haptic_device *haptic __free(hid_haptic_state) =
+		kmemdup(config, sizeof(*config), GFP_KERNEL);
 	struct ff_device *ff;
-	int ret = 0, r;
+	int ret, r;
 	struct ff_haptic_effect stop_effect = {
 		.hid_usage = HID_HP_WAVEFORMSTOP & HID_USAGE,
 	};
-	const char *prefix = "hid-haptic";
-	char *name;
+	if (!haptic)
+		return -ENOMEM;
+
+	/* The mapping state does not own these allocations. */
+	haptic->hid_usage_map = NULL;
+	haptic->duration_map = NULL;
+	haptic->effect = NULL;
+	haptic->stop_effect.report_buf = NULL;
+	haptic->wq = NULL;
 
 	haptic->hdev = hdev;
 	haptic->max_waveform_id = max(2u, haptic->max_waveform_id);
@@ -431,16 +460,12 @@ int hid_haptic_init(struct hid_device *hdev,
 
 	haptic->hid_usage_map = kcalloc(haptic->max_waveform_id + 1,
 					sizeof(u16), GFP_KERNEL);
-	if (!haptic->hid_usage_map) {
-		ret = -ENOMEM;
-		goto exit;
-	}
+	if (!haptic->hid_usage_map)
+		return -ENOMEM;
 	haptic->duration_map = kcalloc(haptic->max_duration_id + 1,
 				       sizeof(u32), GFP_KERNEL);
-	if (!haptic->duration_map) {
-		ret = -ENOMEM;
-		goto usage_map;
-	}
+	if (!haptic->duration_map)
+		return -ENOMEM;
 
 	if (haptic->max_waveform_id != haptic->max_duration_id)
 		dev_warn(&hdev->dev,
@@ -460,21 +485,19 @@ int hid_haptic_init(struct hid_device *hdev,
 	haptic->manual_trigger_report_len =
 		hid_report_len(haptic->manual_trigger_report);
 	mutex_init(&haptic->manual_trigger_mutex);
-	name = kmalloc(strlen(prefix) + strlen(hdev->name) + 2, GFP_KERNEL);
-	if (name) {
-		sprintf(name, "%s %s", prefix, hdev->name);
+	{
+		char *name __free(kfree) = kasprintf(GFP_KERNEL,
+						     "hid-haptic %s", hdev->name);
+
+		if (!name)
+			return -ENOMEM;
 		haptic->wq = create_singlethread_workqueue(name);
-		kfree(name);
-	}
-	if (!haptic->wq) {
-		ret = -ENOMEM;
-		goto duration_map;
 	}
+	if (!haptic->wq)
+		return -ENOMEM;
 	haptic->effect = kzalloc_objs(struct hid_haptic_effect, FF_MAX_EFFECTS);
-	if (!haptic->effect) {
-		ret = -ENOMEM;
-		goto output_queue;
-	}
+	if (!haptic->effect)
+		return -ENOMEM;
 	for (r = 0; r < FF_MAX_EFFECTS; r++) {
 		haptic->effect[r].report_buf =
 			hid_alloc_report_buf(haptic->manual_trigger_report,
@@ -482,8 +505,7 @@ int hid_haptic_init(struct hid_device *hdev,
 		if (!haptic->effect[r].report_buf) {
 			dev_err(&hdev->dev,
 				"Failed to allocate a buffer for an effect.\n");
-			ret = -ENOMEM;
-			goto buffer_free;
+			return -ENOMEM;
 		}
 		haptic->effect[r].input_dev = dev;
 		INIT_WORK(&haptic->effect[r].work, haptic_work_handler);
@@ -494,8 +516,7 @@ int hid_haptic_init(struct hid_device *hdev,
 	if (!haptic->stop_effect.report_buf) {
 		dev_err(&hdev->dev,
 			"Failed to allocate a buffer for stop effect.\n");
-		ret = -ENOMEM;
-		goto buffer_free;
+		return -ENOMEM;
 	}
 	haptic->stop_effect.input_dev = dev;
 	INIT_WORK(&haptic->stop_effect.work, haptic_work_handler);
@@ -507,7 +528,9 @@ int hid_haptic_init(struct hid_device *hdev,
 	ret = input_ff_create(dev, FF_MAX_EFFECTS);
 	if (ret) {
 		dev_err(&hdev->dev, "Failed to create ff device.\n");
-		goto ff_cap_clear;
+		__clear_bit(FF_HAPTIC, dev->ffbit);
+		__clear_bit(EV_FF, dev->evbit);
+		return ret;
 	}
 
 	ff = dev->ff;
@@ -517,30 +540,8 @@ int hid_haptic_init(struct hid_device *hdev,
 	ff->stop = hid_haptic_stop;
 	ff->destroy = hid_haptic_destroy;
 	__module_get(THIS_MODULE);
-	ff->private = haptic;
+	ff->private = no_free_ptr(haptic);
 	return 0;
-
-ff_cap_clear:
-	__clear_bit(FF_HAPTIC, dev->ffbit);
-	__clear_bit(EV_FF, dev->evbit);
-	kfree(haptic->stop_effect.report_buf);
-	haptic->stop_effect.report_buf = NULL;
-buffer_free:
-	while (--r >= 0)
-		kfree(haptic->effect[r].report_buf);
-	kfree(haptic->effect);
-	haptic->effect = NULL;
-output_queue:
-	destroy_workqueue(haptic->wq);
-	haptic->wq = NULL;
-duration_map:
-	kfree(haptic->duration_map);
-	haptic->duration_map = NULL;
-usage_map:
-	kfree(haptic->hid_usage_map);
-	haptic->hid_usage_map = NULL;
-exit:
-	return ret;
 }
 EXPORT_SYMBOL_GPL(hid_haptic_init);
 
diff --git a/drivers/hid/hid-haptic.h b/drivers/hid/hid-haptic.h
index 6332991..661b605 100644
--- a/drivers/hid/hid-haptic.h
+++ b/drivers/hid/hid-haptic.h
@@ -69,7 +69,8 @@ int hid_haptic_input_mapping(struct hid_device *hdev,
 int hid_haptic_input_configured(struct hid_device *hdev,
 				struct hid_haptic_device *haptic,
 				struct hid_input *hi);
-int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device *haptic,
+int hid_haptic_init(struct hid_device *hdev,
+		    const struct hid_haptic_device *config,
 		    struct input_dev *dev);
 void hid_haptic_handle_press_release(struct hid_haptic_device *haptic);
 void hid_haptic_pressure_reset(struct hid_haptic_device *haptic);
@@ -108,7 +109,8 @@ static inline
 void hid_haptic_reset(struct hid_device *hdev, struct hid_haptic_device *haptic)
 {}
 static inline
-int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device *haptic,
+int hid_haptic_init(struct hid_device *hdev,
+		    const struct hid_haptic_device *config,
 		    struct input_dev *dev)
 {
 	return 0;
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 154dc94..e53389e 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1954,25 +1954,9 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	struct mt_report_data *rdata;
 	struct mt_application *mt_application = NULL;
 	struct hid_report *report;
+	bool has_mt_touchpad = false;
 	int ret;
 
-	if (td->is_haptic_touchpad && (td->mtclass.name == MT_CLS_WIN_8 ||
-	    td->mtclass.name == MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
-	    td->mtclass.name == MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE)) {
-		if (hi->application == HID_DG_TOUCHPAD) {
-			ret = hid_haptic_input_configured(hdev, td->haptic, hi);
-			if (ret < 0) {
-				td->haptic_init_error = ret;
-				td->is_haptic_touchpad = false;
-				return ret;
-			}
-			if (ret == 0)
-				td->is_haptic_touchpad = false;
-		}
-	} else {
-		td->is_haptic_touchpad = false;
-	}
-
 	list_for_each_entry(report, &hi->reports, hidinput_list) {
 		rdata = mt_find_report_data(td, report);
 		if (!rdata) {
@@ -1987,9 +1971,29 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 							mt_application);
 			if (ret)
 				return ret;
+			if (hi->application == HID_DG_TOUCHPAD)
+				has_mt_touchpad = true;
 		}
 	}
 
+	if (td->is_haptic_touchpad &&
+	    (td->mtclass.name == MT_CLS_WIN_8 ||
+	     td->mtclass.name == MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
+	     td->mtclass.name == MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE)) {
+		if (has_mt_touchpad) {
+			ret = hid_haptic_input_configured(hdev, td->haptic, hi);
+			if (ret < 0) {
+				td->haptic_init_error = ret;
+				td->is_haptic_touchpad = false;
+				return ret;
+			}
+			if (ret == 0)
+				td->is_haptic_touchpad = false;
+		}
+	} else {
+		td->is_haptic_touchpad = false;
+	}
+
 	switch (hi->application) {
 	case HID_GD_KEYBOARD:
 	case HID_GD_KEYPAD:
-- 
2.53.0

