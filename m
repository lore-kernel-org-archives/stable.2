Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231542;
	b=HSSV/GhdPbeILWs3lZTtR2GNc1F7Y1SiLRz73tV7rbmpgvkf9fy4ApDqNFGWmCVPrtl1
	 SRbvsbIIEht7oBAAbOR4NX9fVvvQB/4TSkhHSxbbTGicKefv0Y20YAXApjh2+8mrLJ012
	 88TJMMa2biP9LkenFCbyV+4QZUbwNfrhVWStzsmns7tzjTuqAhIR1n9M+d/UVnKZ/12cz
	 D3Qoq8WRVe48I76XuT1jYJzS6OzMMFzsSUH+OmJ7JwcYmgQ2QJuGtxuDxj3/bCu8XdoHK
	 lIeg0LPAty2bPCjEO9PvN3ljTOBKMclzfLhkZr/cyAvXFP3/80NECeUZ9OP73G+d/yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231542;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ctAGp7a36ZpsTouqfR2ze9VJSRRZ8iArYNlc0XI0q7I=;
	b=AOAe7Fckp5LrhiuxBD9zcpQtKUSCpLl1BqDOeDk8uSjrBqp8iLpAVO3jD+bO7T+LgC6a
	 nIS1MLTuwnHrrFW2LPBDfDldnVe3RK/Js5r3HL9c5mr5WKowNfel+knthKT3zR+wD0S9s
	 dvQ28pLl5/5XUfQGlgiruB8JeAKJZup7oYiVLVM69s5r3vY3xq+C++IpjUWIYGerANvZc
	 a+DygtxJJ70clzrwwYQ/3RRIaw+4p+WdGcshUmx2KvbHJjqBha+PKZs/VUkZL0omwaa3v
	 FxtV6QWv5jbTVftCi/G5tpOxvaQNEXxH0Pe74+UfylDuct+GLc33GUMnJfsSUEn20LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDdTgd22;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D91606A331;
	Mon,  9 Nov 2026 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDdTgd22
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6611F0089F;
	Mon,  9 Nov 2026 13:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794231541;
	bh=ctAGp7a36ZpsTouqfR2ze9VJSRRZ8iArYNlc0XI0q7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iDdTgd22Aj2YbuzsDdRFyjY8AvOZwfrKo72zUM3fygOVdSOW6ZtJelZChaIqjkJ0D
	 QT6t5OhqkmZJ8cYVszEE4LVfG9jjoYgprF9F4CXh01/sGNJtUMD1Q5xdK9v2NwIHaV
	 OmqopvUwV1dc5fzPOsu6F4ne7SwR7tw66cB8PELdsaAX8pJTUK+r6LUgUgtLl5/lxs
	 4aNgWddV17ZrCcmEJqyy57HHmGtTbE5unVmb68Ci4Nypml1hdojXYPaxTH23Q61pyV
	 ALD2KR4aPAquygp8aRJ+Pa/0+EW+tgYvoL/I8RMhL1+jY8kW64xD1BjhGiOHxeA0gZ
	 9FCp1ER2b4g9g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Ping Cheng <ping.cheng@wacom.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Jiri Kosina <jkosina@suse.com>
Subject: [STABLE v5.15 1/2] HID: wacom: Fix Use-After-Free in wacom_intuos_pad
Date: Mon,  9 Nov 2026 13:38:50 +0000
Message-ID: <20261109133854.3026082-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109133854.3026082-1-lee@kernel.org>
References: <20261109133854.3026082-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit ef32877368a7013c060ef6bd03a30b6da2fe0c41 ]

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
Acked-by: Ping Cheng <ping.cheng@wacom.com>
Tested-by: Ping Cheng <ping.cheng@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
[Lee: Use explicit mutex_lock()/mutex_unlock() in wacom_remove_shared_data()
      for -std=gnu89 compatibility and adapt to res_wacom]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/wacom_sys.c | 18 +++++++++++++-----
 drivers/hid/wacom_wac.c | 36 ++++++++++++++++++------------------
 drivers/hid/wacom_wac.h |  2 +-
 3 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index b6393a806574..149d3546367f 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -885,10 +885,16 @@ static void wacom_remove_shared_data(void *res)
 		data = container_of(wacom_wac->shared, struct wacom_hdev_data,
 				    shared);
 
-		if (wacom_wac->shared->touch == res_wacom->hdev)
+		mutex_lock(&wacom_udev_list_lock);
+		if (wacom_wac->shared->touch == res_wacom->hdev) {
 			wacom_wac->shared->touch = NULL;
-		else if (wacom_wac->shared->pen == res_wacom->hdev)
+			rcu_assign_pointer(wacom_wac->shared->touch_input, NULL);
+		} else if (wacom_wac->shared->pen == res_wacom->hdev) {
 			wacom_wac->shared->pen = NULL;
+		}
+		mutex_unlock(&wacom_udev_list_lock);
+
+		synchronize_rcu();
 
 		if (kref_put_mutex(&data->kref, wacom_release_shared_data, &wacom_udev_list_lock))
 			mutex_unlock(&wacom_udev_list_lock);
@@ -2350,9 +2356,11 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
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
index 78d7fda68f20..6549439f3203 100644
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
@@ -2192,7 +2200,7 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 	 */
 	if ((equivalent_usage == WACOM_HID_WD_MUTE_DEVICE) ||
 	   (equivalent_usage == WACOM_HID_WD_TOUCHONOFF)) {
-		if (wacom_wac->shared->touch_input) {
+		if (wacom_wac->shared) {
 			bool *is_touch_on = &wacom_wac->shared->is_touch_on;
 
 			if (equivalent_usage == WACOM_HID_WD_MUTE_DEVICE && value)
@@ -2200,9 +2208,7 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 			else if (equivalent_usage == WACOM_HID_WD_TOUCHONOFF)
 				*is_touch_on = value;
 
-			input_report_switch(wacom_wac->shared->touch_input,
-					    SW_MUTE_DEVICE, !(*is_touch_on));
-			input_sync(wacom_wac->shared->touch_input);
+			wacom_report_touch_mute(wacom_wac, !(*is_touch_on));
 		}
 		return;
 	}
@@ -3324,11 +3330,8 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 
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
@@ -3363,11 +3366,8 @@ static int wacom_status_irq(struct wacom_wac *wacom_wac, size_t len)
 
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
index 0491b19430cd..4f9ef7b21de3 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -286,7 +286,7 @@ struct wacom_shared {
 	/* for wireless device to access USB interfaces */
 	unsigned touch_max;
 	int type;
-	struct input_dev *touch_input;
+	struct input_dev __rcu *touch_input;
 	struct hid_device *pen;
 	struct hid_device *touch;
 	bool has_mute_touch_switch;
-- 
2.56.0.506.g506a7eabc5-goog

