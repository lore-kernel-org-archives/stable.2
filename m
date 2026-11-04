Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799829;
	b=DgkLQvwxLC/4Qon7uGDXi+uxg8basu9Ir+yaUjZNKOzhUIBxhXs8VWWJKMsF29yu8v21
	 xAbaEm6UwqHz8UakmC1qwpGUaWgdcyi0rNEJC6yL703iVhzMyTOPc/swE6AO6zgCpjhHL
	 1ZFOk4/sPMPrtpiOC6n1WELNMobgHx8+oRiBNFmA/hnVFYeYBjKT41Ta/rFMJHskWB3JR
	 qIx0ZhJ0QCkFglg4WpNUG4BS4Nf4X4QSDhd6HbtYyN7fc+hdHH9Qf/kC/JexCHJX/d3Xv
	 iKAirO8hqDiEcHxiKDsI84b8+wIHhwNd9Q2r9Y4zPnj0amvgrMgZUUBqytgqLDNsRdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799829;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=i8icQTFTRG/1ixiqdj915PPUIVjAmAQVRklVikeo6tI=;
	b=lKNNT/LOoV/8SkTCtADWkEqtRmTkYqcAj2fj2S+Of3/8hwgxguMW3pbn2kPdeEZrNdIO
	 me9AvoOiZSHwqfnxfAOTaKgPm73L/J1IKuRzs5LZaiaNWWdhIaGK6gSmzZGgsHNKLLtjA
	 TGJMsOcTdotk7P993FIjFPBb1C8+yfj3eglYTCYUO8QehsW84W7k76053NX2khgUv2R0o
	 LP0Ps1Uc7M8jm9YJ6FwehjE9FV+pOwQUvDI3TbIuDXaGUvf1pAJhsOxrgmdAGbljr24/o
	 tgB2D30xrLF6NRxiAXnkgMxnK8O5UAf8tj5D2wzvWhEMEfuW+rEbn4Ju5dwgBwIy3tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gbFEVL4V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA32B606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=gbFEVL4V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E71A1F00919;
	Wed,  4 Nov 2026 13:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793799828;
	bh=i8icQTFTRG/1ixiqdj915PPUIVjAmAQVRklVikeo6tI=;
	h=Subject:To:Cc:From:Date;
	b=gbFEVL4VvAtdpW514rs5J5CpHWpEGN8dfmyx+DrnnS6r7goliyCwckTQdAOqHgePM
	 abTt/y0Zh7Otaf9UYK0utBtrm5Pq6ODaFk3HHeM0YigCnq+JWrzZXIQsx7PBEOWvKU
	 kGHlvcxwgmAwWF5CgWfAAR6NSRPM4mclrZSPpjQw=
Subject: FAILED: patch "[PATCH] HID: wacom: Fix Use-After-Free in wacom_intuos_pad" failed to apply to 5.10-stable tree
To: lee@kernel.org,jkosina@suse.com,ping.cheng@wacom.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:43:39 +0100
Message-ID: <2026110439-ramble-ebook-0594@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ef32877368a7013c060ef6bd03a30b6da2fe0c41
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110439-ramble-ebook-0594@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ef32877368a7013c060ef6bd03a30b6da2fe0c41 Mon Sep 17 00:00:00 2001
From: Lee Jones <lee@kernel.org>
Date: Wed, 9 Sep 2026 11:12:25 +0000
Subject: [PATCH] HID: wacom: Fix Use-After-Free in wacom_intuos_pad

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

