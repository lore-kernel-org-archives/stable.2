Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83903D3CF6
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040865; cv=none; b=rOmiEiFvU4IaFQrZYRfudJlzkxE60PNNeNvFLz/2W2ju4/Fi09AThvxj1KvkQDE502FydNit3w9lkzBhVrCmJ4uQaqsVO+dFsYNxYU55v6LBckHzB6BnqKZoNBma+7xE3F4uqjvIxS7u9uFkj/GKyKDWJRSVet8rSto5zuxhy1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040865; c=relaxed/simple;
	bh=IK7c1I5HguJ8GEyuHqaBTBSs6WkQzAzzhpk5BddI7x0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tDOv51eayTuYkEsY2L2Zg/hlOlndZU24WQ5LhghAlq3Hh5etV6cgL86bef7u2Ntfzslog7b6NyMbFyGTVEfsr9wqG4LzN7yWnSf0XApZzBXmWVxt20NF93EkbpDBMSOnMei/oCjmlEsmgDgFopmv5y5tKNtG4ilAENg6sAnE6l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tbJXVXC2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tbJXVXC2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046421F000E9;
	Tue, 14 Jul 2026 14:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040863;
	bh=Qw1uCa7bUxOv2jhODLolI1u4eoiu36vRAxDkb/NEfm8=;
	h=Subject:To:Cc:From:Date;
	b=tbJXVXC2S+95xbBR+prfprWBfvdpu7IyhNUpu9q7N3Z7RcgdzuzQUbgUyIUrS0a4E
	 0uloEGv63bLh8WiDL0D2fD8TUIDvyQkhX+ESvjEgX5YboIrOmYC+0N/cXTZuGX936J
	 J4Bt3HPJxSot8D0aZlSqFPL4Z2SaeRoooOwGKet8=
Subject: FAILED: patch "[PATCH] HID: multitouch: fix out-of-bounds bit access on mt_io_flags" failed to apply to 6.12-stable tree
To: trungnh@cystack.net,bentiss@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:54:17 +0200
Message-ID: <2026071417-rarity-paralyze-9329@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8813b0612275cc61fe9e6603d0ee019247ade6be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071417-rarity-paralyze-9329@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8813b0612275cc61fe9e6603d0ee019247ade6be Mon Sep 17 00:00:00 2001
From: Trung Nguyen <trungnh@cystack.net>
Date: Thu, 2 Jul 2026 00:13:19 +0700
Subject: [PATCH] HID: multitouch: fix out-of-bounds bit access on mt_io_flags

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

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 0495152091e3..edb37b4c867e 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -31,6 +31,7 @@
  * [1] https://gitlab.freedesktop.org/libevdev/hid-tools
  */
 
+#include <linux/bitmap.h>
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/hid.h>
@@ -97,8 +98,7 @@ enum report_mode {
 	TOUCHPAD_REPORT_ALL = TOUCHPAD_REPORT_BUTTONS | TOUCHPAD_REPORT_CONTACTS,
 };
 
-#define MT_IO_SLOTS_MASK		GENMASK(7, 0) /* reserve first 8 bits for slot tracking */
-#define MT_IO_FLAGS_RUNNING		32
+#define MT_IO_FLAGS_RUNNING		0
 
 static const bool mtrue = true;		/* default for true */
 static const bool mfalse;		/* default for false */
@@ -174,10 +174,9 @@ struct mt_device {
 	struct timer_list release_timer;	/* to release sticky fingers */
 	struct hid_haptic_device *haptic;	/* haptic related configuration */
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
@@ -1036,7 +1035,7 @@ static void mt_release_pending_palms(struct mt_device *td,
 
 	for_each_set_bit(slotnum, app->pending_palm_slots, td->maxcontacts) {
 		clear_bit(slotnum, app->pending_palm_slots);
-		clear_bit(slotnum, &td->mt_io_flags);
+		clear_bit(slotnum, td->active_slots);
 
 		input_mt_slot(input, slotnum);
 		input_mt_report_slot_inactive(input);
@@ -1247,9 +1246,9 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
 		input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
 
-		set_bit(slotnum, &td->mt_io_flags);
+		set_bit(slotnum, td->active_slots);
 	} else {
-		clear_bit(slotnum, &td->mt_io_flags);
+		clear_bit(slotnum, td->active_slots);
 	}
 
 	return 0;
@@ -1384,7 +1383,7 @@ static void mt_touch_report(struct hid_device *hid,
 	 * defect.
 	 */
 	if (app->quirks & MT_QUIRK_STICKY_FINGERS) {
-		if (td->mt_io_flags & MT_IO_SLOTS_MASK)
+		if (!bitmap_empty(td->active_slots, td->maxcontacts))
 			mod_timer(&td->release_timer,
 				  jiffies + msecs_to_jiffies(100));
 		else
@@ -1443,6 +1442,15 @@ static int mt_touch_input_configured(struct hid_device *hdev,
 	if (td->is_pressurepad)
 		__set_bit(INPUT_PROP_PRESSUREPAD, input->propbit);
 
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
@@ -2062,7 +2070,7 @@ static void mt_release_contacts(struct hid_device *hid)
 			for (i = 0; i < mt->num_slots; i++) {
 				input_mt_slot(input_dev, i);
 				input_mt_report_slot_inactive(input_dev);
-				clear_bit(i, &td->mt_io_flags);
+				clear_bit(i, td->active_slots);
 			}
 			input_mt_sync_frame(input_dev);
 			input_sync(input_dev);
@@ -2085,7 +2093,7 @@ static void mt_expired_timeout(struct timer_list *t)
 	 */
 	if (test_and_set_bit_lock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))
 		return;
-	if (td->mt_io_flags & MT_IO_SLOTS_MASK)
+	if (!bitmap_empty(td->active_slots, td->maxcontacts))
 		mt_release_contacts(hdev);
 	clear_bit_unlock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags);
 }

