Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8F649F114;
	Wed,  2 Sep 2026 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356681; cv=none; b=nS4MLt8PBqWGUtqcqlhPi+f0dmqzXrGs6tqfxwW+z9/ccdyao/C/IXFrnB1wWpY26nFkTM6w5DkaeGSiJniJ6kmPGXBf8zzdolYAEDaeGmJmf7HUv4Nk2ah5D83rhI354j+xGAj8ehIBAE80Yc93YFKL65cMPx3e3K3YN1Rgw/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356681; c=relaxed/simple;
	bh=SHjUiu6FJAKc0xleNeIViAyGIzQwhV/HLt03m92YXnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vERGtwIMUvI4s9Y37gW7xub9e2XMHF3QDMTEvdaiki+gedxegCu9sMzNoy2H7aH3wsD+XmI8kYF+wshq6C3jdAzkZWXKTvTaVjEcOWN1Pkw9hBWzi0qfgyR2gB+VwCdiYE7RkjrvnYM1ZPVjs3OYngG/7UaAwmHMrrzmiQlv2bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTFrv/Ve; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTFrv/Ve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE9C1F000E9;
	Wed,  2 Sep 2026 13:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788356679;
	bh=jRDSS1Y7C25Vk6KshUxqdorACwXQV7gAyHkuiDux/wU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jTFrv/VeainC5EyNRycG0EFUKsGieVOTJujPShQIJvkaY/fpeUeUAafIDe8iuGkIl
	 944VGZYfgTEKY+TOF4jIkGQ31so5sOT4Dg+iyWtPORJeNEriaMCoS+ZwxJppcxlW3J
	 iFfDnHLnY3AWVev4PRjxSPBrDnnheNaUK5u/b6wGSNZOpCLxSeiQPvykocN2iHnIz8
	 zZetRRnoc/izczkPOZCU2uj0IMd82JzqPNo/GXdCKsjIIYDrwu0O+XZnCRDRALFyLR
	 8xiY+ylLF2+bQTZ9z740x4iwusw7tB3H69NZLQOF+jXEikPfJEUxhlRQCC4W/lI2/A
	 14L1XWCKWxPpQ==
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
Subject: [PATCH v9 4/5] HID: wacom: Fix Use-After-Free in wacom_bamboo_pad
Date: Wed,  2 Sep 2026 13:44:04 +0000
Message-ID: <20260902134417.1270552-4-lee@kernel.org>
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

wacom_bamboo_pad_pen_event() accesses wacom->shared->pen locklessly
relative to wacom_remove_shared_data() which nullifies it.  This
can lead to a Use-After-Free if the sibling device is removed while
events are being processed.

Resolve this by introducing RCU protection for pen and touch
pointers:

 - Annotate 'pen' and 'touch' in wacom_shared struct with __rcu.
 - Wrap lockless readers in wacom_bamboo_pad_pen_event() with
   rcu_read_lock() and rcu_dereference().
 - Update writers in wacom_sys.c using rcu_assign_pointer().
 - Use rcu_dereference_protected for comparisons under
   wacom_udev_list_lock.
 - Also use rcu_access_pointer in wacom_mode_change_work() to avoid
   warnings (while lockless access there remains a pre-existing issue).

Cc: stable@vger.kernel.org
Fixes: 8c97a765467c ("HID: wacom: add full support of the Wacom Bamboo PAD")
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 -> v2: Split and use RCU as per Dmitry's review
v2 -> v3: Sashiko fixes
v3 -> v4: Dmitry's review [guard()]
v4 -> v5: No change
v5 -> v6: No change
v6 -> v7: No change
v7 -> v8: No change
v8 -> v9: No change

 drivers/hid/wacom_sys.c | 36 +++++++++++++++++++++++++-----------
 drivers/hid/wacom_wac.c | 13 ++++++-------
 drivers/hid/wacom_wac.h |  4 ++--
 3 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 1af0d518260d..12f6a32cbc5f 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -876,11 +876,18 @@ static void wacom_remove_shared_data(void *res)
 				    shared);
 
 		scoped_guard(mutex, &wacom_udev_list_lock) {
-			if (wacom_wac->shared->touch == wacom->hdev) {
-				wacom_wac->shared->touch = NULL;
+			struct hid_device *touch =
+				rcu_dereference_protected(wacom_wac->shared->touch,
+							  lockdep_is_held(&wacom_udev_list_lock));
+			struct hid_device *pen =
+				rcu_dereference_protected(wacom_wac->shared->pen,
+							  lockdep_is_held(&wacom_udev_list_lock));
+
+			if (touch == wacom->hdev) {
+				rcu_assign_pointer(wacom_wac->shared->touch, NULL);
 				rcu_assign_pointer(wacom_wac->shared->touch_input, NULL);
-			} else if (wacom_wac->shared->pen == wacom->hdev) {
-				wacom_wac->shared->pen = NULL;
+			} else if (pen == wacom->hdev) {
+				rcu_assign_pointer(wacom_wac->shared->pen, NULL);
 			}
 		}
 
@@ -2358,14 +2365,18 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 	}
 
 	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
-		if (wacom_wac->shared->touch == wacom->hdev || !wacom_wac->shared->touch) {
+		struct hid_device *touch =
+			rcu_dereference_protected(wacom_wac->shared->touch,
+						  lockdep_is_held(&wacom_udev_list_lock));
+
+		if (touch == wacom->hdev || !touch) {
 			wacom_wac->shared->type = wacom_wac->features.type;
-			wacom_wac->shared->touch = wacom->hdev;
+			rcu_assign_pointer(wacom_wac->shared->touch, wacom->hdev);
 			rcu_assign_pointer(wacom_wac->shared->touch_input, wacom_wac->touch_input);
 		}
 	} else if (wacom_wac->features.device_type &
 		   (WACOM_DEVICETYPE_PEN | WACOM_DEVICETYPE_PAD)) {
-		wacom_wac->shared->pen = wacom->hdev;
+		rcu_assign_pointer(wacom_wac->shared->pen, wacom->hdev);
 	}
 }
 
@@ -2833,16 +2844,19 @@ static void wacom_mode_change_work(struct work_struct *work)
 	bool is_direct = wacom->wacom_wac.is_direct_mode;
 	int error = 0;
 
-	if (shared->pen) {
-		wacom1 = hid_get_drvdata(shared->pen);
+	struct hid_device *pen = rcu_access_pointer(shared->pen);
+	struct hid_device *touch = rcu_access_pointer(shared->touch);
+
+	if (pen) {
+		wacom1 = hid_get_drvdata(pen);
 		wacom_release_resources(wacom1);
 		hid_hw_stop(wacom1->hdev);
 		wacom1->wacom_wac.has_mode_change = true;
 		wacom1->wacom_wac.is_direct_mode = is_direct;
 	}
 
-	if (shared->touch) {
-		wacom2 = hid_get_drvdata(shared->touch);
+	if (touch) {
+		wacom2 = hid_get_drvdata(touch);
 		wacom_release_resources(wacom2);
 		hid_hw_stop(wacom2->hdev);
 		wacom2->wacom_wac.has_mode_change = true;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index f953851ad6bc..884d1cf7401c 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3294,6 +3294,7 @@ static int wacom_bpt_irq(struct wacom_wac *wacom, size_t len)
 static void wacom_bamboo_pad_pen_event(struct wacom_wac *wacom,
 		unsigned char *data)
 {
+	struct hid_device *pen;
 	unsigned char prefix;
 
 	/*
@@ -3306,13 +3307,11 @@ static void wacom_bamboo_pad_pen_event(struct wacom_wac *wacom,
 	prefix = data[0];
 	data[0] = WACOM_REPORT_BPAD_PEN;
 
-	/*
-	 * actually reroute the event.
-	 * No need to check if wacom->shared->pen is valid, hid_input_report()
-	 * will check for us.
-	 */
-	hid_input_report(wacom->shared->pen, HID_INPUT_REPORT, data,
-			 WACOM_PKGLEN_PENABLED, 1);
+	guard(rcu)();
+	pen = rcu_dereference(wacom->shared->pen);
+	if (pen)
+		hid_input_report(pen, HID_INPUT_REPORT, data,
+				 WACOM_PKGLEN_PENABLED, 1);
 
 	data[0] = prefix;
 }
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index a8bbba4a6f37..170d6adbe02a 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -286,8 +286,8 @@ struct wacom_shared {
 	unsigned touch_max;
 	int type;
 	struct input_dev __rcu *touch_input;
-	struct hid_device *pen;
-	struct hid_device *touch;
+	struct hid_device __rcu *pen;
+	struct hid_device __rcu *touch;
 	bool has_mute_touch_switch;
 	bool is_touch_on;
 };
-- 
2.55.0.966.g6673acef38-goog

