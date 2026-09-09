Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A70538D83;
	Wed,  9 Sep 2026 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952399; cv=none; b=dbDILgLiqF3Z0O7gNM0u3bZS9EqlHc1k0PcAI90dXu/akv2U9pqW2pTScwlMsUOtOnX2i6fRAvt2yQ9E8LuCQfGeQ/XOpTBsKYLj0lLVcBYEQNNxqaJrZEMQpFwlt2LmGMIpaibiLFbzePfttjCfRbFX7rb7iB4WQ7WCYyjcFP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952399; c=relaxed/simple;
	bh=d0CT5LGqZR35B5OgYQAKyxH4fep5wcjcjjQa7huTUzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mB/CI4mXhjBD7F8hgxzD+SsgJZ4SFjVnVRdVtA2JiCU7Xei++utnwIf6f5gLva2scIBZ8UefUxwCOBhsaAnFEAtEqPQ4iMO/x5rVQOXwkOAMzex7cYj9w6GMy5a/OcwYUwf0hjbSNIx/DKqFew/Cxn04/OnVzBZ1KVmKYGONN2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA0OUDUI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA0OUDUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28F11F00ACA;
	Wed,  9 Sep 2026 11:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952394;
	bh=XKCnvJpSb1QJ7+qbULM8SiCBq7ZJ82f58JoZ6/MR7NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KA0OUDUIHAhRnI5QhUP2EpJLjFC4jkI4kKEQTVlvYX6nsYLN1UnQqkG02XU0LdW28
	 Khw3zN5MbRWsnIZ0Uo6HBiMunHs+p86GqOO+qVyMgyBOri90oVo4lXmvhOgB6NJIfP
	 EIrI8Mk+ceNJWGro+C8k3AMhEJ7s2s8+G7LZGeWsLGLFFRYjMdUuJP1y0FG1YAlFb3
	 KVI/M3YwFBcFWW9EsH/ghdK29nHO0mVXVNpcmxsQ71vn5awvk9mg3Uny+K52JSpp4T
	 1EyHfcu29MlYocMGQ7AG6jvxKPHlgUT7dzWVi1Nr73T6F3MBK1jsynqE2/9fXldIi7
	 jPtUmMiEqrljQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Aaron Skomra <aaron.skomra@wacom.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v10 3/5] HID: wacom: Fix Use-After-Free in wacom_intuos_pad
Date: Wed,  9 Sep 2026 11:12:25 +0000
Message-ID: <c861d21f863c023ac89878c170a00fe8c80405d9.1788868602.git.lee@kernel.org>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
In-Reply-To: <fa3cb42f7b58c1b3022d8208969a81882783a5ec.1788868602.git.lee@kernel.org>
References: <fa3cb42f7b58c1b3022d8208969a81882783a5ec.1788868602.git.lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_intuos_pad() accesses wacom->shared->touch_input locklessly
inside the interrupt handler context.  If the Touch sibling device
is disconnected, wacom_remove_shared_data() clears 'touch_input'
outside any lock, creating a Time-of-Check to Time-of-Use (TOCTOU)
race condition where a preempted reader in interrupt context
dereferences the freed pointer, leading to a Use-After-Free.

Resolve this by introducing RCU protection for the touch_input
pointer:

 - Annotate 'touch_input' in wacom_shared struct with __rcu
 - Wrap all lockless readers in wacom_wac.c with guard(rcu)() and
   rcu_dereference() using a unified wacom_report_touch_mute()
   helper
 - Update writers in wacom_sys.c using rcu_assign_pointer()
 - Call synchronize_rcu() in wacom_remove_shared_data() to ensure
   all active RCU readers have finished before the input device is
   freed

Also wrap wacom_set_shared_values() and touch/pen assignments in
wacom_add_shared_data() inside the wacom_udev_list_lock to serialize
concurrent probe assignments, and verify that 'shared->touch == hdev'
before setting touch_input to prevent concurrent sibling probe state
desynchronization.

Cc: stable@vger.kernel.org
Fixes: 961794a00eab ("Input: wacom - add reporting of SW_MUTE_DEVICE events")
Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 -> v2:  Split and use RCU as per Dmitry's review
v2 -> v3:  Sashiko fixes
v3 -> v4:  Dmitry's review [redundant check and guard()]
v4 -> v5:  Jason's review [split, remove "awkward if"]
v5 -> v6:  No change
v6 -> v7:  No change
v7 -> v8:  No functional change - cleaned up a stray whitespace/blank line deletion hunk
v8 -> v9:  No change
v9 -> v10: No change

 drivers/hid/wacom_sys.c | 23 ++++++++++++++++-------
 drivers/hid/wacom_wac.c | 36 ++++++++++++++++++------------------
 drivers/hid/wacom_wac.h |  2 +-
 3 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 4eed2c189017..10f7de515ea2 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -875,10 +875,16 @@ static void wacom_remove_shared_data(void *res)
 		data = container_of(wacom_wac->shared, struct wacom_hdev_data,
 				    shared);
 
-		if (wacom_wac->shared->touch == wacom->hdev)
-			wacom_wac->shared->touch = NULL;
-		else if (wacom_wac->shared->pen == wacom->hdev)
-			wacom_wac->shared->pen = NULL;
+		scoped_guard(mutex, &wacom_udev_list_lock) {
+			if (wacom_wac->shared->touch == wacom->hdev) {
+				wacom_wac->shared->touch = NULL;
+				rcu_assign_pointer(wacom_wac->shared->touch_input, NULL);
+			} else if (wacom_wac->shared->pen == wacom->hdev) {
+				wacom_wac->shared->pen = NULL;
+			}
+		}
+
+		synchronize_rcu();
 
 		kref_put(&data->kref, wacom_release_shared_data);
 		wacom_wac->shared = NULL;
@@ -915,6 +921,7 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 	mutex_unlock(&wacom_udev_list_lock);
 
 	retval = devm_add_action_or_reset(&hdev->dev, wacom_remove_shared_data, wacom);
+
 	return retval;
 }
 
@@ -2354,9 +2361,11 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 	}
 
 	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
-		wacom_wac->shared->type = wacom_wac->features.type;
-		wacom_wac->shared->touch_input = wacom_wac->touch_input;
-		wacom_wac->shared->touch = wacom->hdev;
+		if (wacom_wac->shared->touch == wacom->hdev || !wacom_wac->shared->touch) {
+			wacom_wac->shared->type = wacom_wac->features.type;
+			wacom_wac->shared->touch = wacom->hdev;
+			rcu_assign_pointer(wacom_wac->shared->touch_input, wacom_wac->touch_input);
+		}
 	} else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN) {
 		/* Pairs with smp_load_acquire() in wacom_sibling_pending() */
 		smp_store_release(&wacom_wac->shared->pen, wacom->hdev);
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 30df866feac8..c5227530f291 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -510,6 +510,18 @@ static void wacom_intuos_schedule_prox_event(struct wacom_wac *wacom_wac)
 	}
 }
 
+static void wacom_report_touch_mute(struct wacom_wac *wacom_wac, bool mute)
+{
+	struct input_dev *touch_input;
+
+	guard(rcu)();
+	touch_input = rcu_dereference(wacom_wac->shared->touch_input);
+	if (touch_input) {
+		input_report_switch(touch_input, SW_MUTE_DEVICE, mute);
+		input_sync(touch_input);
+	}
+}
+
 static int wacom_intuos_pad(struct wacom_wac *wacom)
 {
 	struct wacom_features *features = &wacom->features;
@@ -650,12 +662,8 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 	input_report_key(input, KEY_CONTROLPANEL, menu);
 	input_report_key(input, KEY_INFO, info);
 
-	if (wacom->shared && wacom->shared->touch_input) {
-		input_report_switch(wacom->shared->touch_input,
-				    SW_MUTE_DEVICE,
-				    !wacom->shared->is_touch_on);
-		input_sync(wacom->shared->touch_input);
-	}
+	if (wacom->shared)
+		wacom_report_touch_mute(wacom, !wacom->shared->is_touch_on);
 
 	input_report_abs(input, ABS_RX, strip1);
 	input_report_abs(input, ABS_RY, strip2);
@@ -2168,7 +2176,7 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 	 */
 	if ((equivalent_usage == WACOM_HID_WD_MUTE_DEVICE) ||
 	   (equivalent_usage == WACOM_HID_WD_TOUCHONOFF)) {
-		if (wacom_wac->shared->touch_input) {
+		if (wacom_wac->shared) {
 			bool *is_touch_on = &wacom_wac->shared->is_touch_on;
 
 			if (equivalent_usage == WACOM_HID_WD_MUTE_DEVICE && value)
@@ -2176,9 +2184,7 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 			else if (equivalent_usage == WACOM_HID_WD_TOUCHONOFF)
 				*is_touch_on = value;
 
-			input_report_switch(wacom_wac->shared->touch_input,
-					    SW_MUTE_DEVICE, !(*is_touch_on));
-			input_sync(wacom_wac->shared->touch_input);
+			wacom_report_touch_mute(wacom_wac, !(*is_touch_on));
 		}
 		return;
 	}
@@ -3396,11 +3402,8 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 
 		if ((wacom->shared->type == INTUOSHT ||
 		    wacom->shared->type == INTUOSHT2) &&
-		    wacom->shared->touch_input &&
 		    wacom->shared->touch_max) {
-			input_report_switch(wacom->shared->touch_input,
-					SW_MUTE_DEVICE, data[5] & 0x40);
-			input_sync(wacom->shared->touch_input);
+			wacom_report_touch_mute(wacom, data[5] & 0x40);
 		}
 
 		pid = get_unaligned_be16(&data[6]);
@@ -3435,11 +3438,8 @@ static int wacom_status_irq(struct wacom_wac *wacom_wac, size_t len)
 
 	if ((features->type == INTUOSHT ||
 	    features->type == INTUOSHT2) &&
-	    wacom_wac->shared->touch_input &&
 	    features->touch_max) {
-		input_report_switch(wacom_wac->shared->touch_input,
-				    SW_MUTE_DEVICE, data[8] & 0x40);
-		input_sync(wacom_wac->shared->touch_input);
+		wacom_report_touch_mute(wacom_wac, data[8] & 0x40);
 	}
 
 	if (data[9] & 0x02) { /* wireless module is attached */
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 126bec6e5c0c..a8bbba4a6f37 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -285,7 +285,7 @@ struct wacom_shared {
 	/* for wireless device to access USB interfaces */
 	unsigned touch_max;
 	int type;
-	struct input_dev *touch_input;
+	struct input_dev __rcu *touch_input;
 	struct hid_device *pen;
 	struct hid_device *touch;
 	bool has_mute_touch_switch;
-- 
2.55.0.979.g7e5102b832-goog

