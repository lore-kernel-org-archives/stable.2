Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BEA47CA7D;
	Wed,  2 Sep 2026 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356679; cv=none; b=mMzl0UOYKk/KFMHjvX9HH3YxZyCZ4drHLtbyoFKvN61surpldHfk/xOLu5+qkzUQFl0YJIYA8yV2+1gJ55EbtG4srnoSjSIG6+uTqpt+EPReK9xIjumOH2S9hCazstn0ElFYCRQ/oGKHB06hVi3EDHNrw/8Lxgpj2FOF+c6FsHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356679; c=relaxed/simple;
	bh=PrzCDzPPF+9DtSskLp/6fGQSQlpf4jWjT5iL5tabpUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRsf6f9EiEHkBk3EMuBVcFAD2fZ2aYDPEDWYpTU//KWTjBvui7eTngaTCyS1DHdwCb5X+aTY8gHDZdNuRr8stBbFi1Iaglf0cJsmGroYYuYq2z6csljbPdK8Wn1RKJtuuBuPCKcNVtpjbzNH3uwi8snQs5X7mqpQAn955yEIF20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1+7ZTL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1+7ZTL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5226F1F00A3D;
	Wed,  2 Sep 2026 13:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788356676;
	bh=3RUyrGcT7xq5077TgolodEvtdsSk4Z/TJzIN/jGTyFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n1+7ZTL9uzAv6CcU81DoQFskmK1gsuktGb/FDUOypxiCIE8TAc3yApixdRMW1mFtG
	 TsLNQzLo7MSmOHc+fiif3AsSSuYwmH5+aMKgyeeC5S0UBvE3tDSqp3quBT+zbIi3ck
	 /IK0K/EryqzEuyGTk09CGyHmQxsGM+xMxckSJmYVisSFTDRBlEhg8RvPR3cZNRWkQ3
	 FVTSTBzozCdcmEh0iZ77hYbN4xJ51++yxgWNaPPLmqsl97KonO9rG4L3YHJpW61MLk
	 SPdtyCJCm5aoH7ER21HQ4vMzRAXYxjYr1yi5PS6Zur6V2PYFpq3ppYLNbU3/92iH4F
	 h6o90a6/K5OQA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Aaron Skomra <aaron.skomra@wacom.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v9 3/5] HID: wacom: Fix Use-After-Free in wacom_intuos_pad
Date: Wed,  2 Sep 2026 13:44:03 +0000
Message-ID: <20260902134417.1270552-3-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
In-Reply-To: <20260902134417.1270552-1-lee@kernel.org>
References: <20260902134417.1270552-1-lee@kernel.org>
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

v1 -> v2: Split and use RCU as per Dmitry's review
v2 -> v3: Sashiko fixes
v3 -> v4: Dmitry's review [redundant check and guard()]
v4 -> v5: Jason's review [split, remove "awkward if"]
v5 -> v6: No change
v6 -> v7: No change
v7 -> v8: No functional change - cleaned up a stray whitespace/blank line deletion hunk
v8 -> v9: No change

 drivers/hid/wacom_sys.c | 25 ++++++++++++++++++-------
 drivers/hid/wacom_wac.c | 36 ++++++++++++++++++------------------
 drivers/hid/wacom_wac.h |  2 +-
 3 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 026a6be467d3..1af0d518260d 100644
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
@@ -912,6 +918,7 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 	wacom_wac->shared = &data->shared;
 
 	retval = devm_add_action_or_reset(&hdev->dev, wacom_remove_shared_data, wacom);
+
 	return retval;
 }
 
@@ -2337,6 +2344,8 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 {
 	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
 
+	guard(mutex)(&wacom_udev_list_lock);
+
 	if (wacom_wac->has_mute_touch_switch) {
 		wacom_wac->shared->has_mute_touch_switch = true;
 		/* Hardware touch switch may be off. Wait until
@@ -2349,9 +2358,11 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
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
 	} else if (wacom_wac->features.device_type &
 		   (WACOM_DEVICETYPE_PEN | WACOM_DEVICETYPE_PAD)) {
 		wacom_wac->shared->pen = wacom->hdev;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index a7e3817aa2c4..f953851ad6bc 100644
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
@@ -2155,7 +2163,7 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 	 */
 	if ((equivalent_usage == WACOM_HID_WD_MUTE_DEVICE) ||
 	   (equivalent_usage == WACOM_HID_WD_TOUCHONOFF)) {
-		if (wacom_wac->shared->touch_input) {
+		if (wacom_wac->shared) {
 			bool *is_touch_on = &wacom_wac->shared->is_touch_on;
 
 			if (equivalent_usage == WACOM_HID_WD_MUTE_DEVICE && value)
@@ -2163,9 +2171,7 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 			else if (equivalent_usage == WACOM_HID_WD_TOUCHONOFF)
 				*is_touch_on = value;
 
-			input_report_switch(wacom_wac->shared->touch_input,
-					    SW_MUTE_DEVICE, !(*is_touch_on));
-			input_sync(wacom_wac->shared->touch_input);
+			wacom_report_touch_mute(wacom_wac, !(*is_touch_on));
 		}
 		return;
 	}
@@ -3383,11 +3389,8 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 
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
@@ -3422,11 +3425,8 @@ static int wacom_status_irq(struct wacom_wac *wacom_wac, size_t len)
 
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
2.55.0.966.g6673acef38-goog

