Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFAE37F00A
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298891; cv=none; b=AlpGE+6rye8XnxPgZ6k1RJb3htdUmMbP4bk6CzMN4r2BRarTKhKW17Y4HAZiUBnnB5y9vcQhwYq03303y50Sr6ciZmHf8FTDfwu5xC1/IUBBKcXIpy+42tWYWwFwbiS97Eak8Rhm+2yX8PA2My+V4qKK/MW/QXRH0xKm6mFPnwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298891; c=relaxed/simple;
	bh=J9xpyFbyx7QXxV6CxcKFx9MYbdYn3tyEPnngHH2News=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgD8IITiEVj/VaxFOdkp2XnIvUnW3z7KqSs+Gnf/Z56fqMSMYmVrjKWX9PZOq8TeWazUMGV+0kH40E7rED0vj02VxA+oBpFdK2qqLR2qKvw8Y4CQgRgtFAJXInuVdMDfkBYTnLMi8GXvL9ktGowRY9LvP5F+vgmZeLzySI+42tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP2oW4J6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP2oW4J6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4CC1F00A3A;
	Fri, 17 Jul 2026 14:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784298890;
	bh=VGNH0YXPsaf6V5uUA9AAojIQ4cRQUiLsyXZkhfl/N/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FP2oW4J6SGsrnxd7YsTsDcFyvC57iWePyriavQgGAMQ0GJUw6MahoY+gdqAAe7PcB
	 SZXASeg7g7GiumQPPhapWrosx78dQ2H4VRTdQEKsFkhGapNy7pgH8rPHRC+z0Dt4Ux
	 qTnNYR3P+GjqypVCKMEjfsS87Z4fNxZ3RT5dAqYqaKZesoGDVwB5xp2jmJXPuy5s9C
	 fcINvV+XBppI4L3d9oDsdnPw+0AgLm9gNxW7QCLwpmnFUYiPBqkOToaGeEas7atl+M
	 AyGnMz3AydKvRir0odmAc5iMNm9xCL8rgDrqyKIC0IaGJcFhqnLCImSF5gQsO9M5Ld
	 EjoGAtIR8HgVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Trung Nguyen <trungnh@cystack.net>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] HID: multitouch: fix out-of-bounds bit access on mt_io_flags
Date: Fri, 17 Jul 2026 10:34:47 -0400
Message-ID: <20260717143447.1877787-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717143447.1877787-1-sashal@kernel.org>
References: <2026071419-skinny-privatize-967b@gregkh>
 <20260717143447.1877787-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trung Nguyen <trungnh@cystack.net>

[ Upstream commit 8813b0612275cc61fe9e6603d0ee019247ade6be ]

mt_io_flags is a single unsigned long, but mt_process_slot(),
mt_release_pending_palms() and mt_release_contacts() use it as a
per-slot bitmap indexed by the slot number. That slot number is only
bounded by td->maxcontacts, which is taken from the device's
ContactCountMaximum feature report and can be up to 255, not by
BITS_PER_LONG.

As a result, a multitouch device that advertises a large contact count
makes set_bit()/clear_bit() operate past the mt_io_flags word and
corrupt the adjacent members of struct mt_device. The sticky-fingers
release timer is the easiest way to reach this. mt_release_contacts()
runs

	for (i = 0; i < mt->num_slots; i++)
		clear_bit(i, &td->mt_io_flags);

with num_slots == maxcontacts. For maxcontacts around 250 the loop
clears the bits that overlap td->applications.next, zeroing that list
head, and the list_for_each_entry() that immediately follows then
dereferences NULL. The kernel panics from timer (softirq) context. On a
KASAN build this shows up as a general protection fault in
mt_release_contacts() with a null-ptr-deref at offset 0x58, which is
offsetof(struct mt_application, num_received).

The state is reachable from an untrusted USB or Bluetooth HID
multitouch device; no local privileges are required.

Store the per-slot active state in a separately allocated bitmap sized
for maxcontacts, the same pattern already used for pending_palm_slots,
and keep only MT_IO_FLAGS_RUNNING in mt_io_flags. The two
"mt_io_flags & MT_IO_SLOTS_MASK" arming checks become
bitmap_empty(td->active_slots, td->maxcontacts).

Move MT_IO_FLAGS_RUNNING back to bit 0. It was bumped to bit 32 by the
same commit to leave the low byte for the slot bits; with the slot bits
gone it fits in bit 0 again, which also keeps it within the unsigned
long on 32-bit.

Fixes: 46f781e0d151 ("HID: multitouch: fix sticky fingers")
Cc: stable@vger.kernel.org
Signed-off-by: Trung Nguyen <trungnh@cystack.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-multitouch.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index df87d7ae94c462..a7871c2b2d8f70 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -31,6 +31,7 @@
  * [1] https://gitlab.freedesktop.org/libevdev/hid-tools
  */
 
+#include <linux/bitmap.h>
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
@@ -83,8 +84,7 @@ enum latency_mode {
 	HID_LATENCY_HIGH = 1,
 };
 
-#define MT_IO_SLOTS_MASK		GENMASK(7, 0) /* reserve first 8 bits for slot tracking */
-#define MT_IO_FLAGS_RUNNING		32
+#define MT_IO_FLAGS_RUNNING		0
 
 static const bool mtrue = true;		/* default for true */
 static const bool mfalse;		/* default for false */
@@ -160,10 +160,9 @@ struct mt_device {
 	struct mt_class mtclass;	/* our mt device class */
 	struct timer_list release_timer;	/* to release sticky fingers */
 	struct hid_device *hdev;	/* hid_device we're attached to */
-	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_RUNNING)
-					 * first 8 bits are reserved for keeping the slot
-					 * states, this is fine because we only support up
-					 * to 250 slots (MT_MAX_MAXCONTACT)
+	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_RUNNING) */
+	unsigned long *active_slots;	/* bitmap of slots with an active
+					 * contact, sized for maxcontacts
 					 */
 	__u8 inputmode_value;	/* InputMode HID feature value */
 	__u8 maxcontacts;
@@ -947,7 +946,7 @@ static void mt_release_pending_palms(struct mt_device *td,
 
 	for_each_set_bit(slotnum, app->pending_palm_slots, td->maxcontacts) {
 		clear_bit(slotnum, app->pending_palm_slots);
-		clear_bit(slotnum, &td->mt_io_flags);
+		clear_bit(slotnum, td->active_slots);
 
 		input_mt_slot(input, slotnum);
 		input_mt_report_slot_inactive(input);
@@ -1153,9 +1152,9 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
 
-		set_bit(slotnum, &td->mt_io_flags);
+		set_bit(slotnum, td->active_slots);
 	} else {
-		clear_bit(slotnum, &td->mt_io_flags);
+		clear_bit(slotnum, td->active_slots);
 	}
 
 	return 0;
@@ -1290,7 +1289,7 @@ static void mt_touch_report(struct hid_device *hid,
 	 * defect.
 	 */
 	if (app->quirks & MT_QUIRK_STICKY_FINGERS) {
-		if (td->mt_io_flags & MT_IO_SLOTS_MASK)
+		if (!bitmap_empty(td->active_slots, td->maxcontacts))
 			mod_timer(&td->release_timer,
 				  jiffies + msecs_to_jiffies(100));
 		else
@@ -1330,6 +1329,15 @@ static int mt_touch_input_configured(struct hid_device *hdev,
 	if (td->is_buttonpad)
 		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
 
+	if (!td->active_slots) {
+		td->active_slots = devm_kcalloc(&td->hdev->dev,
+						BITS_TO_LONGS(td->maxcontacts),
+						sizeof(long),
+						GFP_KERNEL);
+		if (!td->active_slots)
+			return -ENOMEM;
+	}
+
 	app->pending_palm_slots = devm_kcalloc(&hi->input->dev,
 					       BITS_TO_LONGS(td->maxcontacts),
 					       sizeof(long),
@@ -1740,7 +1748,7 @@ static void mt_release_contacts(struct hid_device *hid)
 			for (i = 0; i < mt->num_slots; i++) {
 				input_mt_slot(input_dev, i);
 				input_mt_report_slot_inactive(input_dev);
-				clear_bit(i, &td->mt_io_flags);
+				clear_bit(i, td->active_slots);
 			}
 			input_mt_sync_frame(input_dev);
 			input_sync(input_dev);
@@ -1763,7 +1771,7 @@ static void mt_expired_timeout(struct timer_list *t)
 	 */
 	if (test_and_set_bit_lock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))
 		return;
-	if (td->mt_io_flags & MT_IO_SLOTS_MASK)
+	if (!bitmap_empty(td->active_slots, td->maxcontacts))
 		mt_release_contacts(hdev);
 	clear_bit_unlock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags);
 }
-- 
2.53.0

