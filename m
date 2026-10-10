Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B33337FF76
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791673287; cv=none; b=upPDEPPdqttlVKCGhdPwEKW+L5J3XwsdFSaWlQ//4ol70Ws91mtR5CcO6AwNV4lFJI1bd/js2eSyUpF36/hRPNm80pgiguMjF6sQfzK4H92aktOa71miKHPIz/z0s+OXlcx45b+TmWo+7FDYz5z0XgTOCaRfy3uvjo23/0P3rHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791673287; c=relaxed/simple;
	bh=ilxV3VSIaM1J1kK25Vbt5TiJBHdiErBl7HzYOAyjhBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bkaE++A3dmdaDR7jYzFH3syY+ZrX/IdbL8orlSxUbPckcbbNaHqfsTSypF9IAMFYIFzhKAozM2hBUdDv5yNotV2IAOgDMKAFOBl4oAo7bhHhDaG59dm385rM8OL9Kb8hs+BwwL+ezZIwH+tjSv1HzQt38Av/uXmQObRGv8WNPUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHlqIdjn; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHlqIdjn"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso333867a91.0
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 16:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791673280; x=1792278080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lntVu/7VwjTQ6lr9AyFi6/5e+O4SOQKgyzSvNT9kFBU=;
        b=lHlqIdjn9dHgCZf1BzmbebWzPjQS+1Yf1xb041PIRNZiOMXeXKWDdKtCDdNM9NWf0b
         3CrqVTTfeITaqmCjbX4cvHyc2d5fbvIt+iOkHt17eS/l9Q6fw+06E82D6csztHe0iVhr
         GIiM3QoWTfkudPC6HxY+bOylg0czfW8Mp7iukpUaACvnW0e/ZH2rwR/87EYe8dp0ygwX
         oqbExsJP0run6AeIZzb5yQMjvlqcv2xATKWPw93jmic4Dj2suqtU1+xHmGWyWTM2bmkg
         VohdOZuVpKjd/odRTas3ilxhH/sZ5RdUkdT5GgHGR2sf6n755/M0OYwzf2oempWcXzTm
         E6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791673280; x=1792278080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lntVu/7VwjTQ6lr9AyFi6/5e+O4SOQKgyzSvNT9kFBU=;
        b=azWO08N3f8iuRIkK1qjlbhCsueuEzbRzt9Yv2ZhmQU83zRlE7Q0BzhmFwIammZO0u2
         12wLuyZspsmL8YIg8SuJvwdBUFJIZQo+hEJbQ2qhozdBPPvVdFIeOK63TPJETOunMUSs
         yEWEHf1yqVZ38JPbx5eyrtq+4xTk3OUYlN9xZQpSd4C01IBWs4gHFLVJLwZLFvb5OT07
         OUA/Me6yhZdwmjLSResvZDAg3tmT+Yw1+yrm8V4azENQrQs4Q2FLqUZrJw3hOBUi9hcR
         J+LT7PR5CPGBhKXpamc7oTwqqyVsEya09h09EyRmkoSFjyZMaHt/JYbypHzvOU+tvGD1
         kFUw==
X-Forwarded-Encrypted: i=1; AKwUvBzIjlb9igXsKrMi0GRBt5QvgpHC3lsHOxBkHaKH9h6DuT15o3Tp6e8hun9/trHke8lfKKkTaLU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9vvSdmkorgwhMBTa/+/rzjOeuxnrWC9y8iWm7wrVqbxcpKNnW
	Te080hKVXGaVmDbQ2QoU3Gynx0hS/MNZx4nmE4RJ39MAGVDkUtNiAQTA
X-Gm-Gg: AYBFou1QaFK6pr2xn01/Zo2TQrZR1Y2YR5R9lJ4qk+IBTwKRBrDvQQCJF5ye7Ky6Klv
	0l2nuwoa9/f/X3i7Jokq7r56Mu7+7RetKqu55QoV3nn1KQPvzC53dnnu7bp9EoYtGNS5B4qWqmG
	+0iyHUyjRR64H669XjbBL5OP33R8aCVjLIyIXWxHv90Neuw+7ISNj/o+1mUe89Hys4lilMBsiyZ
	cZbZGyJgSAFbLvxPvKhFDaigqYJLfcrixduJDF956ZyQ3N/aOOuYMA3NlsO5jS818raOy9MrzVQ
	8G9gL2ZDwW0iem+Fs2JdnbrPKoN9sGF76NvLFcVzJYhF+3EY08ANrNSU9NaxOvUltj8ic6XCL5B
	BRq+dgTSncOxqkvflvRuUe151rUNYU2QM65ZkrNPmVr3hjkBaNTwNFlGTtP/WErmhaQxPIV48Lv
	/501mS+gm+hdRRX5Ja7aE6vQVcbKPoCUHwHMUlgYPsFql3ZNBVuLps0Pe4YqU2jRJLj6pcA2gFf
	jNbEbL07DB9pEhk5tFqHwyxvun0E8SQ6KBDu8DyE/BXAmyg
X-Received: by 2002:a17:90b:3912:b0:3a4:dbda:9934 with SMTP id 98e67ed59e1d1-3ab3aca2634mr4080661a91.63.1791673279829;
        Sat, 10 Oct 2026 16:01:19 -0700 (PDT)
Received: from localhost.localdomain ([49.175.192.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab32c0f59bsm6117974a91.0.2026.10.10.16.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 16:01:18 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alhouseenyousef@gmail.com,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: hidraw: fix use-after-free and double free on disconnect
Date: Sun, 11 Oct 2026 08:01:08 +0900
Message-ID: <20261010230108.107272-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0xf8/0x1c8
Write of size 4 at addr ffff0000ce4ffb38 by task wacom_uaf/261

Call trace:
 _raw_spin_lock_irqsave+0xf8/0x1c8
 hidraw_report_event+0x64/0x2a8
 hid_report_raw_event+0x488/0x1228
 __hid_input_report+0x418/0x5b8
 hid_safe_input_report+0x68/0x90
 uhid_char_write+0xb04/0xfb8
 vfs_write+0x2e4/0xac0

Allocated by task 131:
 hidraw_connect+0x54/0x390
 hid_connect+0xb80/0x13d8
 hid_hw_start+0xc4/0x150
 wacom_parse_and_register+0x2ae4/0x4d40
 wacom_probe+0x724/0xb18

Freed by task 68:
 kfree+0x264/0x4c8
 drop_ref+0x268/0x340
 hidraw_disconnect+0x60/0x88
 hid_disconnect+0x17c/0x1c8
 hid_hw_stop+0x70/0x100
 wacom_mode_change_work+0x11c/0x6b0

The buggy address belongs to the object at ffff0000ce4ffb00
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 56 bytes inside of
 freed 96-byte region [ffff0000ce4ffb00, ffff0000ce4ffb60)

Reproduced on mainline 7.2.0-g66498c75b4f8 (arm64, KASAN) through
/dev/uhid writes alone.  Offset 56 is struct hidraw::list_lock.

hidraw_report_event() dereferences hid->hidraw with nothing keeping the
object alive, and hidraw_disconnect() frees it without clearing the
pointer:

	void hidraw_disconnect(struct hid_device *hid)
	{
		struct hidraw *hidraw = hid->hidraw;

		down_write(&minors_rwsem);
		drop_ref(hidraw, 1);		/* kfree() when !open */
		up_write(&minors_rwsem);
	}			/* hid->hidraw left dangling */

hid_disconnect() also clears the HID_CLAIMED_HIDRAW bit that guards the
call only after the free, so a report that passed the guard walks into
freed memory and the first thing it does there is take a spinlock.

driver_input_lock normally keeps the two apart -- hid_device_remove()
holds it across the callback and __hid_input_report() takes it -- but
hid_hw_stop() carries no such requirement and drivers call it from
workqueue context holding nothing, as wacom_mode_change_work() does.
minors_rwsem cannot be used on the reader side: hidraw_report_event()
also runs from softirq on real transports.

The same function also takes the pointer outside the lock that frees
it.  hid_disconnect() tests hdev->claimed & HID_CLAIMED_HIDRAW with
nothing excluding a second caller and clears claimed only at the end,
so two overlapping teardowns can both reach drop_ref() with the same
pointer.  I have one captured double free of this object with that
shape:

  BUG kmalloc-96: Object already free
   drop_ref+0x70/0x108
   hidraw_disconnect+0x3c/0x60
   hid_disconnect+0x88/0xb0
   hid_hw_stop+0x30/0x70
   wacom_remove+0x30/0x100

I could not isolate that branch to reproduce it on demand -- three
other faults on the same wacom teardown path fire first -- so I am not
claiming this trace proves that window.  Taking the pointer under
minors_rwsem is correct regardless of how often it is hit.

Publish the object through RCU and claim it under the lock.
hidraw_connect() stores the pointer with a release, so the
initialisation is visible to a reader that picks it up without holding
anything; readers take the RCU read side and load the pointer once;
hidraw_disconnect() now reads it under minors_rwsem, returns if another
teardown already took it, and detaches it before dropping the last
reference; drop_ref() hands the object to kfree_rcu(), so a reader that
already loaded the pointer is covered by the grace period.

Same victim object and same faulting function as the bot-reported window
addressed by

  https://lore.kernel.org/linux-input/20260628005846.31248-1-alhouseenyousef@gmail.com/
  ("HID: synchronize input before cleaning up a failed probe")

but a different window: that patch re-acquires driver_input_lock in
__hid_device_probe()'s failure path and leaves hid_disconnect() alone.

Fixes: 86166b7bcda0 ("HID: add hidraw interface")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
Validated at runtime with a test-only patch that widens the window
between the pointer load and the spin_lock (mdelay(200) in
hidraw_report_event), so the report race becomes deterministic instead
of a few instructions wide.  arm64 QEMU/KVM guests, same reproducer,
4 vCPU each:

  kernel                            exposure        KASAN   signature
  ----------------------------------------------------------------------
  baseline + widening               4700 binds/180s   1     yes, t+9.07s
  WRITE_ONCE + NULL guard only      4656 binds/180s   1     yes
  RCU + widening                    5718 binds/600s   0     no
  RCU, no widening                  7070 binds/180s   0     no

The second row is worth stating: clearing the pointer and adding a NULL
check, without RCU, does not close this.  A reader that has already
loaded the pointer still walks the object after kfree().  That is why
this patch uses a grace period rather than just a NULL guard.

Those rounds cover the report race only.  I also tried to reproduce the
disconnect-vs-disconnect window on its own, on the KASAN=n,
CONFIG_SLUB_DEBUG=y tree the captured double free came from, with a
reproducer that attaches wacom pen and touch as siblings and races
their teardown: 24 boots, drop_ref() never reached.  In the four of
those boots that also tracked the in-flight hid_device pointers, no two
teardowns of the same device were ever inside hidraw_disconnect()
together -- teardowns of the two sibling devices did overlap there, so
the instrumentation was live.  The teardown race itself reproduces
every boot, but three other faults on that path -- a wacom timer on a
freed object, a NULL deref in hid_hw_stop() and a usercopy fault in
uhid_char_read() -- end the guest before the hidraw branch is reached,
and serialising the two hid_hw_stop() calls closes the path altogether.
So that hunk rests on the captured trace plus the lock discipline, not
on a round of its own, and I would rather say so than overstate it.

On the accessors: hid_device::hidraw is a void * with no __rcu
annotation, and four drivers outside hidraw.c dereference it directly
(hid-cp2112.c, hid-u2fzero.c, hid-led.c and hid-core.c), all from
probe/connect paths where the pointer is stable.  Annotating the field
would let this use rcu_dereference()/rcu_assign_pointer() but would
cascade into those four, so the plain accessors are used with the same
ordering rcu_assign_pointer() would give: smp_store_release() is what it
expands to for a non-NULL store, and WRITE_ONCE() is what it expands to
for a constant NULL.  I am happy to do the __rcu conversion as a
separate patch if you would rather have the annotated form.

Not attempted here: clearing hdev->claimed before the *_disconnect()
calls in hid_disconnect().  hid_report_raw_event() has

	if (hid->claimed != HID_CLAIMED_HIDRAW && report->maxfield)
		hid_process_report(hid, report, cdata, interrupt);

so zeroing claimed makes that condition true and opens hid_process_report()
during teardown instead.
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 9129fabed181..40c4709d5e98 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -354,7 +354,7 @@ static void drop_ref(struct hidraw *hidraw, int exists_bit)
 	if (!hidraw->open) {
 		if (!hidraw->exist) {
 			hidraw_table[hidraw->minor] = NULL;
-			kfree(hidraw);
+			kfree_rcu(hidraw, rcu);
 		} else {
 			/* close device for last reader */
 			hid_hw_close(hidraw->hid);
@@ -569,11 +569,24 @@ static const struct file_operations hidraw_ops = {
 
 int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
 {
-	struct hidraw *dev = hid->hidraw;
 	struct hidraw_list *list;
+	struct hidraw *dev;
 	int ret = 0;
 	unsigned long flags;
 
+	/*
+	 * The object is freed by hidraw_disconnect() with nothing excluding
+	 * this path: hid_hw_stop() carries no quiesce requirement and drivers
+	 * call it from workqueue context.  Hold the RCU read side so the
+	 * object cannot go away between the load and the unlock.
+	 */
+	rcu_read_lock();
+	dev = READ_ONCE(hid->hidraw);
+	if (!dev) {
+		rcu_read_unlock();
+		return 0;
+	}
+
 	spin_lock_irqsave(&dev->list_lock, flags);
 	list_for_each_entry(list, &dev->list, node) {
 		int new_head = (list->head + 1) & (HIDRAW_BUFFER_SIZE - 1);
@@ -592,6 +605,7 @@ int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
 	spin_unlock_irqrestore(&dev->list_lock, flags);
 
 	wake_up_interruptible(&dev->wait);
+	rcu_read_unlock();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hidraw_report_event);
@@ -644,7 +658,11 @@ int hidraw_connect(struct hid_device *hid)
 	dev->minor = minor;
 
 	dev->exist = 1;
-	hid->hidraw = dev;
+	/*
+	 * Publish with a release so the initialisation above is visible to
+	 * an RCU reader that picks the pointer up without taking any lock.
+	 */
+	smp_store_release(&hid->hidraw, dev);
 
 	up_write(&minors_rwsem);
 out:
@@ -655,10 +673,25 @@ EXPORT_SYMBOL_GPL(hidraw_connect);
 
 void hidraw_disconnect(struct hid_device *hid)
 {
-	struct hidraw *hidraw = hid->hidraw;
+	struct hidraw *hidraw;
 
 	down_write(&minors_rwsem);
 
+	/*
+	 * Claim the object under the lock and detach it before dropping the
+	 * last reference.  Taking it outside lets two concurrent teardowns
+	 * capture the same pointer and both call drop_ref() on it.  Readers
+	 * that have not loaded the pointer yet now see NULL; readers that
+	 * already did are kept safe by the RCU grace period taken by
+	 * kfree_rcu() in drop_ref().
+	 */
+	hidraw = hid->hidraw;
+	if (!hidraw) {
+		up_write(&minors_rwsem);
+		return;
+	}
+
+	WRITE_ONCE(hid->hidraw, NULL);
 	drop_ref(hidraw, 1);
 
 	up_write(&minors_rwsem);
diff --git a/include/linux/hidraw.h b/include/linux/hidraw.h
index 18fd30a288de..87c3beff7a36 100644
--- a/include/linux/hidraw.h
+++ b/include/linux/hidraw.h
@@ -17,6 +17,7 @@ struct hidraw {
 	struct device *dev;
 	spinlock_t list_lock;
 	struct list_head list;
+	struct rcu_head rcu;
 };
 
 struct hidraw_report {
