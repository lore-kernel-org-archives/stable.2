Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB654399E2
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752043; cv=none; b=SfjzBu60xTDDGuz+s1+ETJ9P5PAQ96p7WzPBwctZwg91vx6cNXCbLQ6OafLgWJt2hlrrit/FeakcQjTTJ8Lw2mtbuWX+6iZwou2omh+pWRjBzsfgPlElBrw/JK/fe+BMIxU5Y/7umEW+RGc+2KfaWwI8/1tUBl6lLxeOjGaqpYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752043; c=relaxed/simple;
	bh=JXDbTffJl+jgmYEZuwSZdLtP/18kE11NRZMFRBnizrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mkf0T4s++R3cenlwywwQ7/GH/EtrTgVvQGvDGi5SdEel/pBevtHET/iaik8JSJZARbtCMP71KjNppBUX+vmdth6o3HZL1WxQBXffT5bAj2Ps4HijG0bq62UE155023aa+2mbjR5rxf5kYZbalP5L/KN1Ol9irFCD/iPJ57lvg3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCAL9Mec; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCAL9Mec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3961F00A3D;
	Wed, 26 Aug 2026 13:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787752039;
	bh=3CMag2LJo2g5zx1amCUjPDK9K6XByVB/C5aOiLcMoeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GCAL9Mec2O05XNZhmaisSV1DvATzD1PQxG5AZNKBx/v+isAh8ZJIPK4A8N7SdHVRi
	 YDwXuauNCyN/V7Kbn2bioXj8zlyWzXiyT0X2kRCiugS34Mc9xdWjYOoqV3RQhgQHRy
	 J7olzbEGa0zBloAasRjmMY5sJkQWLFd17QWdNbz2igXJb6tg8EdvAAPW1fxpvEIdN+
	 cD5evX0ln3TGwfakUeSoChLGWy1kY/N5ruZVtieJuoTMUw4GgabDoWg8UhU/rkGV+1
	 oeFZuT0aBXf9chUsjZPfSoPmhcj+yC6DcZMIvDKfUCQvzdXDS2kZHtErmxpsp9KQ12
	 CNzBmAPwncK/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] HID: pidff: clang-format pass
Date: Wed, 26 Aug 2026 09:47:14 -0400
Message-ID: <20260826134715.3968449-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826134715.3968449-1-sashal@kernel.org>
References: <2026082517-petroleum-anaerobic-3fd3@gregkh>
 <20260826134715.3968449-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

[ Upstream commit ae42428fb4e3d2eed344f0d6fcfa778bc8b8f80a ]

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Stable-dep-of: 67bb1074e3d2 ("HID: pidff: fix OOB write when hid->inputs is empty")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/usbhid/hid-pidff.c | 55 ++++++++++++++++------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index fe5462a19df38..72ed11e054665 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -9,12 +9,11 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include "hid-pidff.h"
+#include <linux/hid.h>
 #include <linux/input.h>
+#include <linux/minmax.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
-#include <linux/hid.h>
-#include <linux/minmax.h>
-
 
 #define	PID_EFFECTS_MAX		64
 #define	PID_INFINITE		U16_MAX
@@ -285,7 +284,7 @@ static s32 pidff_clamp(s32 i, struct hid_field *field)
 static int pidff_rescale(int i, int max, struct hid_field *field)
 {
 	return i * (field->logical_maximum - field->logical_minimum) / max +
-		field->logical_minimum;
+	       field->logical_minimum;
 }
 
 /*
@@ -329,18 +328,18 @@ static void pidff_set_signed(struct pidff_usage *usage, s16 value)
 	else {
 		if (value < 0)
 			usage->value[0] =
-			    pidff_rescale(-value, -S16_MIN, usage->field);
+				pidff_rescale(-value, -S16_MIN, usage->field);
 		else
 			usage->value[0] =
-			    pidff_rescale(value, S16_MAX, usage->field);
+				pidff_rescale(value, S16_MAX, usage->field);
 	}
 	pr_debug("calculated from %d to %d\n", value, usage->value[0]);
 }
 
 static void pidff_set_time(struct pidff_usage *usage, u16 time)
 {
-	usage->value[0] = pidff_clamp(
-		pidff_rescale_time(time, usage->field), usage->field);
+	usage->value[0] = pidff_clamp(pidff_rescale_time(time, usage->field),
+				      usage->field);
 }
 
 static void pidff_set_duration(struct pidff_usage *usage, u16 duration)
@@ -463,11 +462,11 @@ static void pidff_set_effect_report(struct pidff_device *pidff,
 		pidff_get_effect_type_id(pidff, effect);
 
 	pidff_set_duration(&pidff->set_effect[PID_DURATION],
-		effect->replay.length);
+			   effect->replay.length);
 
 	pidff->set_effect[PID_TRIGGER_BUTTON].value[0] = effect->trigger.button;
 	pidff_set_time(&pidff->set_effect[PID_TRIGGER_REPEAT_INT],
-			effect->trigger.interval);
+		       effect->trigger.interval);
 	pidff->set_effect[PID_GAIN].value[0] =
 		pidff->set_effect[PID_GAIN].field->logical_maximum;
 	pidff->set_effect[PID_DIRECTION_ENABLE].value[0] = 1;
@@ -477,10 +476,10 @@ static void pidff_set_effect_report(struct pidff_device *pidff,
 	/* Omit setting delay field if it's missing */
 	if (!(pidff->quirks & HID_PIDFF_QUIRK_MISSING_DELAY))
 		pidff_set_time(&pidff->set_effect[PID_START_DELAY],
-				effect->replay.delay);
+			       effect->replay.delay);
 
 	hid_hw_request(pidff->hid, pidff->reports[PID_SET_EFFECT],
-			HID_REQ_SET_REPORT);
+		       HID_REQ_SET_REPORT);
 }
 
 /*
@@ -510,10 +509,10 @@ static void pidff_set_periodic_report(struct pidff_device *pidff,
 			 effect->u.periodic.offset);
 	pidff_set(&pidff->set_periodic[PID_PHASE], effect->u.periodic.phase);
 	pidff_set_time(&pidff->set_periodic[PID_PERIOD],
-			effect->u.periodic.period);
+		       effect->u.periodic.period);
 
 	hid_hw_request(pidff->hid, pidff->reports[PID_SET_PERIODIC],
-			HID_REQ_SET_REPORT);
+		       HID_REQ_SET_REPORT);
 }
 
 /*
@@ -560,7 +559,7 @@ static void pidff_set_condition_report(struct pidff_device *pidff,
 		pidff_set(&pidff->set_condition[PID_DEAD_BAND],
 			  effect->u.condition[i].deadband);
 		hid_hw_request(pidff->hid, pidff->reports[PID_SET_CONDITION],
-				HID_REQ_SET_REPORT);
+			       HID_REQ_SET_REPORT);
 	}
 }
 
@@ -623,7 +622,7 @@ static void pidff_set_gain_report(struct pidff_device *pidff, u16 gain)
 
 	pidff_set(&pidff->device_gain[PID_DEVICE_GAIN_FIELD], gain);
 	hid_hw_request(pidff->hid, pidff->reports[PID_DEVICE_GAIN],
-			HID_REQ_SET_REPORT);
+		       HID_REQ_SET_REPORT);
 }
 
 /*
@@ -717,21 +716,19 @@ static void pidff_fetch_pool(struct pidff_device *pidff)
  */
 static int pidff_request_effect_upload(struct pidff_device *pidff, int efnum)
 {
-	int j;
-
 	pidff->create_new_effect_type->value[0] = efnum;
 	hid_hw_request(pidff->hid, pidff->reports[PID_CREATE_NEW_EFFECT],
-			HID_REQ_SET_REPORT);
+		       HID_REQ_SET_REPORT);
 	hid_dbg(pidff->hid, "create_new_effect sent, type: %d\n", efnum);
 
 	pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0] = 0;
 	pidff->block_load_status->value[0] = 0;
 	hid_hw_wait(pidff->hid);
 
-	for (j = 0; j < 60; j++) {
+	for (int i = 0; i < 60; i++) {
 		hid_dbg(pidff->hid, "pid_block_load requested\n");
 		hid_hw_request(pidff->hid, pidff->reports[PID_BLOCK_LOAD],
-				HID_REQ_GET_REPORT);
+			       HID_REQ_GET_REPORT);
 		hid_hw_wait(pidff->hid);
 		if (pidff->block_load_status->value[0] ==
 		    pidff->status_id[PID_BLOCK_LOAD_SUCCESS]) {
@@ -808,8 +805,8 @@ static int pidff_erase_effect(struct input_dev *dev, int effect_id)
 	struct pidff_device *pidff = dev->ff->private;
 	int pid_id = pidff->pid_id[effect_id];
 
-	hid_dbg(pidff->hid, "starting to erase %d/%d\n",
-		effect_id, pidff->pid_id[effect_id]);
+	hid_dbg(pidff->hid, "starting to erase %d/%d\n", effect_id,
+		pidff->pid_id[effect_id]);
 
 	/*
 	 * Wait for the queue to clear. We do not want
@@ -929,7 +926,7 @@ static void pidff_autocenter(struct pidff_device *pidff, u16 magnitude)
 		pidff->set_effect[PID_START_DELAY].value[0] = 0;
 
 	hid_hw_request(pidff->hid, pidff->reports[PID_SET_EFFECT],
-			HID_REQ_SET_REPORT);
+		       HID_REQ_SET_REPORT);
 }
 
 /*
@@ -1196,7 +1193,7 @@ static int pidff_find_special_fields(struct pidff_device *pidff)
 
 	if (PIDFF_FIND_SPECIAL_KEYS(status_id, block_load_status,
 				    block_load_status) !=
-			ARRAY_SIZE(pidff_block_load_status)) {
+	    ARRAY_SIZE(pidff_block_load_status)) {
 		hid_err(pidff->hid,
 			"block load status identifiers not found\n");
 		return -1;
@@ -1204,7 +1201,7 @@ static int pidff_find_special_fields(struct pidff_device *pidff)
 
 	if (PIDFF_FIND_SPECIAL_KEYS(operation_id, effect_operation_status,
 				    effect_operation_status) !=
-			ARRAY_SIZE(pidff_effect_operation_status)) {
+	    ARRAY_SIZE(pidff_effect_operation_status)) {
 		hid_err(pidff->hid, "effect operation identifiers not found\n");
 		return -1;
 	}
@@ -1408,8 +1405,8 @@ static int pidff_check_autocenter(struct pidff_device *pidff,
 int hid_pidff_init_with_quirks(struct hid_device *hid, u32 initial_quirks)
 {
 	struct pidff_device *pidff;
-	struct hid_input *hidinput = list_entry(hid->inputs.next,
-						struct hid_input, list);
+	struct hid_input *hidinput =
+		list_entry(hid->inputs.next, struct hid_input, list);
 	struct input_dev *dev = hidinput->input;
 	struct ff_device *ff;
 	int max_effects;
@@ -1496,7 +1493,7 @@ int hid_pidff_init_with_quirks(struct hid_device *hid, u32 initial_quirks)
 
 	return 0;
 
- fail:
+fail:
 	hid_device_io_stop(hid);
 
 	kfree(pidff);
-- 
2.53.0

