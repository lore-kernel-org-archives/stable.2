Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B362E8B9B
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040892; cv=none; b=RsIXBRXjg3HB/oTJ5AsZVL5SLhFHRd/SzNjhmO3OBXva4J100Lp3z2sB5FEEAocjYfZZPIjsG+iZ8GbfMmrpK6EE9x7wYLhparU9EjjKjS54Q+LOnm8MmObCDVQi+pshdKF5R1F2UrOeeylIlLcuNUMoS0mAuexIDCUmlnpHPtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040892; c=relaxed/simple;
	bh=j6MKVM8lMZJ+9mOatS/g7uAAyGwo3EdiTYU5w8X9gps=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GVZyg7EEtcswtCBeJFESPN/fZ7GwcY4//Q0H1xJ3A7ck3hXtPoFNZXHBjY6QlWyf/VUOr8ZwoNCbGZLDWgO78+R21qK5l6OTmDiK0BBxQuJyd3ZiASHtViIgX8yVfKIcbl2Ae8B487eS4y7ouo3n7KdVB1T7kvBFl+UJgJjEiFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JhsKi8N7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JhsKi8N7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0951F000E9;
	Tue, 14 Jul 2026 14:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040890;
	bh=NVfYqEg18Qb2sNZv2g0F+nXgBPV0emq83ijdLxwYjO4=;
	h=Subject:To:Cc:From:Date;
	b=JhsKi8N7nBC9oF0NZB2fzDwtm8mS9v9fcu2JXGc5+06pvWcSEdZjjN5K5JnNCHc2Z
	 LUIllOIAaFNNCvxipTo+BOFKxe5cHnPk8672/szGLRFxYPxPXKeszQ+0YQre9lSaio
	 stxNasTbPf79nqyLkrwaFW8/LDTJr2D8wR9q+LZQ=
Subject: FAILED: patch "[PATCH] HID: appleir: fix UAF on pending key_up_timer in remove()" failed to apply to 5.15-stable tree
To: maskmemanish@gmail.com,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:54:30 +0200
Message-ID: <2026071430-excavate-prayer-7d7c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 75fe87e19d8aff81eb2c64d15d244ab8da4de945
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071430-excavate-prayer-7d7c@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 75fe87e19d8aff81eb2c64d15d244ab8da4de945 Mon Sep 17 00:00:00 2001
From: Manish Khadka <maskmemanish@gmail.com>
Date: Fri, 15 May 2026 23:17:52 +0545
Subject: [PATCH] HID: appleir: fix UAF on pending key_up_timer in remove()

appleir_remove() runs hid_hw_stop() before timer_delete_sync().
hid_hw_stop() synchronously unregisters the HID input device via
hid_disconnect() -> hidinput_disconnect() -> input_unregister_device(),
which drops the last reference and frees the underlying input_dev when
no userspace handle holds it open.

key_up_tick() reads appleir->input_dev and calls input_report_key() /
input_sync() on it.  The timer is armed from appleir_raw_event() with
a HZ/8 (~125 ms) timeout on every keydown and key-repeat report.  If a
key was pressed shortly before the device is disconnected, the timer
can fire after hid_hw_stop() has freed input_dev but before the
teardown drains it.

A simple reorder is not sufficient.  Putting the timer drain first
still leaves a window where a USB URB completion (raw_event) running
during hid_hw_stop() can call mod_timer() and re-arm the timer, which
then fires after hidinput_disconnect() has freed input_dev.  The same
URB-completion window also lets raw_event() reach key_up(), key_down()
and battery_flat() directly, all of which dereference
appleir->input_dev.

Introduce a 'removing' flag on struct appleir, gated by the existing
spinlock.  appleir_remove() sets the flag under the lock and then
shuts down the timer with timer_shutdown_sync(), which both drains any
in-flight callback and permanently disables further mod_timer() calls.
appleir_raw_event() and key_up_tick() bail out early if the flag is
set, so no path can arm or run the timer, or dereference
appleir->input_dev, after remove() has started tearing down.

The keyrepeat and flatbattery branches of appleir_raw_event()
previously called into the input layer without holding the spinlock;
take it now so the flag check is well-defined.  This incidentally
closes a pre-existing read-side race on appleir->current_key in the
keyrepeat branch.

This bug is structurally a sibling of commit 4db2af929279 ("HID:
appletb-kbd: fix UAF in inactivity-timer cleanup path") and has been
present since the driver was introduced.

Fixes: 9a4a5574ce42 ("HID: appleir: add support for Apple ir devices")
Cc: stable@vger.kernel.org
Signed-off-by: Manish Khadka <maskmemanish@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/hid-appleir.c b/drivers/hid/hid-appleir.c
index 5e8ced7bc05a..adaa44a858ed 100644
--- a/drivers/hid/hid-appleir.c
+++ b/drivers/hid/hid-appleir.c
@@ -109,9 +109,10 @@ struct appleir {
 	struct hid_device *hid;
 	unsigned short keymap[ARRAY_SIZE(appleir_key_table)];
 	struct timer_list key_up_timer;	/* timer for key up */
-	spinlock_t lock;		/* protects .current_key */
+	spinlock_t lock;		/* protects .current_key, .removing */
 	int current_key;		/* the currently pressed key */
 	int prev_key_idx;		/* key index in a 2 packets message */
+	bool removing;			/* set during teardown; gates input_dev access */
 };
 
 static int get_key(int data)
@@ -172,7 +173,7 @@ static void key_up_tick(struct timer_list *t)
 	unsigned long flags;
 
 	spin_lock_irqsave(&appleir->lock, flags);
-	if (appleir->current_key) {
+	if (!appleir->removing && appleir->current_key) {
 		key_up(hid, appleir, appleir->current_key);
 		appleir->current_key = 0;
 	}
@@ -195,6 +196,10 @@ static int appleir_raw_event(struct hid_device *hid, struct hid_report *report,
 		int index;
 
 		spin_lock_irqsave(&appleir->lock, flags);
+		if (appleir->removing) {
+			spin_unlock_irqrestore(&appleir->lock, flags);
+			goto out;
+		}
 		/*
 		 * If we already have a key down, take it up before marking
 		 * this one down
@@ -229,17 +234,25 @@ static int appleir_raw_event(struct hid_device *hid, struct hid_report *report,
 	appleir->prev_key_idx = 0;
 
 	if (!memcmp(data, keyrepeat, sizeof(keyrepeat))) {
-		key_down(hid, appleir, appleir->current_key);
-		/*
-		 * Remote doesn't do key up, either pull them up, in the test
-		 * above, or here set a timer which pulls them up after 1/8 s
-		 */
-		mod_timer(&appleir->key_up_timer, jiffies + HZ / 8);
+		spin_lock_irqsave(&appleir->lock, flags);
+		if (!appleir->removing) {
+			key_down(hid, appleir, appleir->current_key);
+			/*
+			 * Remote doesn't do key up, either pull them up, in
+			 * the test above, or here set a timer which pulls them
+			 * up after 1/8 s
+			 */
+			mod_timer(&appleir->key_up_timer, jiffies + HZ / 8);
+		}
+		spin_unlock_irqrestore(&appleir->lock, flags);
 		goto out;
 	}
 
 	if (!memcmp(data, flatbattery, sizeof(flatbattery))) {
-		battery_flat(appleir);
+		spin_lock_irqsave(&appleir->lock, flags);
+		if (!appleir->removing)
+			battery_flat(appleir);
+		spin_unlock_irqrestore(&appleir->lock, flags);
 		/* Fall through */
 	}
 
@@ -318,8 +331,20 @@ static int appleir_probe(struct hid_device *hid, const struct hid_device_id *id)
 static void appleir_remove(struct hid_device *hid)
 {
 	struct appleir *appleir = hid_get_drvdata(hid);
+	unsigned long flags;
+
+	/*
+	 * Mark the driver as tearing down so that any concurrent raw_event
+	 * (e.g. from a USB URB completion that hid_hw_stop() has not yet
+	 * killed) and the key_up_timer softirq stop touching input_dev
+	 * before hid_hw_stop() frees it via hidinput_disconnect().
+	 */
+	spin_lock_irqsave(&appleir->lock, flags);
+	appleir->removing = true;
+	spin_unlock_irqrestore(&appleir->lock, flags);
+
+	timer_shutdown_sync(&appleir->key_up_timer);
 	hid_hw_stop(hid);
-	timer_delete_sync(&appleir->key_up_timer);
 }
 
 static const struct hid_device_id appleir_devices[] = {

