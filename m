Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18E43AE198
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255315; cv=none; b=AxYx61UuA35IP7ep7rPcYS/l44x35eUrgN3OsUXtmXnr65F//A+itUusLWSWXgmgS4YavBUhUQgDZlOh2ZK6bOmlRUH1MCOMkgZh/VowMxmVrE7Oi6Pk3sdk5Hrkw+UawCzNRyX/pQZIMA8xvpE+0oG1TRvXsGsdSdMdFozWLaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255315; c=relaxed/simple;
	bh=pzHYCNoq9J/xjDTIZm1GzwKAg0a5eysa5HPlMSXc4zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J37v3AzhyMPf72ADJLr8SZatJq5UqQNaRWSFY2FDCZZMIwfQA1qLsNSKRn2OApSZhCGr1I9lq/dBz1fm32nnO+ya4sC/sxv1ZDhQaDzI57FJ9C4YpQlDWLevs5JggPfPf3WT8V73AEfP7cHq/wDkfpo2aNC6o+yOa1+CeZtKYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoTfQPjG; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoTfQPjG"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-917866225aaso9241686d6.1
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255313; x=1792860113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nt2I2LjFkGPbme+OwhKJrbwORKBaSL5qspjiblTND8U=;
        b=IoTfQPjGWdp/XRKklc8rDVGxvs2itPBo5csHiyWp+xuyaeRinPeAf8B9PfhYXN2dgb
         shd8KNZJSbEe4//ngSKaldZawGzvRq3ahgjDlrHmEjfLp5SkXMdL1KQEAhjuuDfOPibV
         MwJz7X3lkrLlGkQlgpG86GRgko34JSuZ/IXnfd5sGDy2o8RFO1nCdXuAI4SnvDUCQ5xm
         Rjff+OdcQncfhHZaBFNlKOUW8sCOapLcku4uJ19OuRp2mt8cSfJc0dnHT24z8WmXbKvk
         GAkhSsgXspwbYC3W2xND2AIbadWlE+a3wllCHzYk8HbVfp1QVcrc2Oeu1Kwgpr6zfsPJ
         cSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255313; x=1792860113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nt2I2LjFkGPbme+OwhKJrbwORKBaSL5qspjiblTND8U=;
        b=BYJFcJgE3bK04NpLh44LLguQKFRMhet6V24o5cGm529r9sQEUdD/AOqGMHnMJvXDPE
         rVsDSJYirwe4lmKuBDTN+8LugRY5fSCp0uVpXUFmQE/tGJWDkjnrPilVzGqtBmb32GQF
         WevxtoTi0GGlJGSfd415WVqJ7bFjNpiKz+06CG51zQk5Dcx1Xnw3Caz51dO1Yb+/Fy18
         /rWR0lww3J1dpHEznWMt8AMEJsk4l+HPzq7IOgc9laUUz3Z3WlekDbRei0WLO0suEMYo
         fpn9dlpdPk0zC6Ymaaqy0xk9okix36MsOX1LAVr+G2kMTK7ung0ikqZk4sBxUaWQfnPv
         Y1Yw==
X-Forwarded-Encrypted: i=1; AKwUvBzzgng1HxrNdgD81WUniHaM0wlv84dnuveFkscw8Ogh4fnMI6Dd4LpH4kF/dclChjRcLE4nShk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIootEXp1hdk/1KL/bOT0sGRGtQLcY3xJVLOgFh/SYAsc/pHjTC
	YehioezDByPF1zAgXQnlf7egzCIwHYIBM9hKVAAIAOOT6ITP0kz3F9cC
X-Gm-Gg: AYBFou26kk70w8zkc+4puiExs0YdScOdsIeGNFy+IXy4JuanIS1hEPXL3xxGEt59V2X
	F/Dcx6cjZDNWDeaOiGCfBXEz3UbpLaoUyFZ6aU1pKpMcXiCB9goUTAG299NpI3pgSac7MCA8CwX
	2oSLH1mHECiU0EpUwgD2KDfYVVJwjakpyEhyZh4uEub69OvaYaRRhNQ+eOLaPrrx2ZGTnbjViEh
	GKBgDrRdJSmqtfomC/5FAVgkvXmseZ/ueBGfdGnWxcMu3Pus9WFfUELqkNLTk4o91H10rUYmouE
	DWAeeE6OhbiU3ctajMiu5IejXczovqdpiG/Y4bVOSDgEy9ZrMPWxKMAcQAIQcB1CebwAVvHWJPK
	PmJK+j+nqskIltO7GFAV4RPpkkRj59Zgiz8+xmqhZKmAEpNTJeb9KTT+hVk7nRPUBubF8kfKOlD
	mdnvHZKzIBJaqsNmE0S3hCuIY/8s6fVUB+DvtU9pwwgo7mmFt2g+aMo3m0sIU9htw=
X-Received: by 2002:a0c:f20a:0:b0:91b:98fe:d2ca with SMTP id 6a1803df08f44-91bdf10d09emr62428186d6.23.1792255312698;
        Sat, 17 Oct 2026 09:41:52 -0700 (PDT)
Received: from beelink ([187.15.140.245])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcb8c4adasm51061296d6.1.2026.10.17.09.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:41:52 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v11 1/2] HID: haptic: make FF creation the last fallible init step
Date: Sat, 17 Oct 2026 13:41:38 -0300
Message-ID: <20261017164139.1791033-2-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017164139.1791033-1-qwe.aldo@gmail.com>
References: <20261017164139.1791033-1-qwe.aldo@gmail.com>
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

