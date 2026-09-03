Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0AD4B1485
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443411; cv=none; b=Jnu1BT52qteDTMXK652t3ck1Oz2tlu9Ps8EPLrvrCW4Nc25cEUZacWt2WVxAn73zcTAo9CGRdoapmuwRgejaD8gbYI4WTJnBQXdWXycpWVL/oO98czEpuxKFpbrflq4jwAPRfTcLwDpwevVHLsoS72QwIqXH/7NbL5wtdMUhypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443411; c=relaxed/simple;
	bh=TIanIA+IBtugIGnb7D2FqDnVKX/jr+dGG261+CprEVI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B43YkhVamf0bVvGWrx8pW0oMO8J/TfDw/2JrGEtjSqhuI6fPLfrrskOewMSj7zxFHNh5fBEoPYWxDy82oNfW0RIJoq6QkFB1wEWLaS8xsOLuKMfjOzSGI/Vs+N9Ilk3frNMXIsFMi9OwbL71zO2Y8YOl8ULHnMPCF7jyIlGTIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oNm09ybU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oNm09ybU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760D91F00A3F;
	Thu,  3 Sep 2026 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443396;
	bh=MYcSjSzyR18gXysPdJ5Guukwkgqum1j1Njo0O9w26as=;
	h=Subject:To:Cc:From:Date;
	b=oNm09ybU0IoLq9MfbCvXE1TmvSsZhJA6sLbH3yw6hbimnaJcL15QgDmL/vdyKRHor
	 33th/jXtajHACfHcuNwVx2rzXXjz6aNDu7xDG44PnkFwvAcnfPGBcntmvl3v/0cTnX
	 UZJmgLZclpH/WH2nWcXBbxHmDWkj7J+vL7VVwggc=
Subject: FAILED: patch "[PATCH] HID: sony: clean up device list on probe failure" failed to apply to 6.1-stable tree
To: doruk@0sec.ai,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:28:44 +0200
Message-ID: <2026090344-dislocate-egging-04af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7c65699a3a311198a07659a614fe64d45924839e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090344-dislocate-egging-04af@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7c65699a3a311198a07659a614fe64d45924839e Mon Sep 17 00:00:00 2001
From: Doruk Tan Ozturk <doruk@0sec.ai>
Date: Sun, 26 Jul 2026 14:45:51 +0200
Subject: [PATCH] HID: sony: clean up device list on probe failure

sony_input_configured() adds some controllers to sony_device_list before
HID core registers their input devices. input_register_device() can fail
after the callback returns successfully. sony_probe() then observes that
HID_CLAIMED_INPUT is clear and unwinds, but only stops the HID hardware.
The devres-managed sony_sc is freed while its list node remains linked, so
the next matching controller traverses freed memory.

Initialize the list node and device ID to inactive states. Make list
removal idempotent and run the driver-private cleanup on every probe
failure path. This also makes a second cleanup safe when
sony_input_configured() already unwound a partial initialization before
sony_probe() handles the missing input claim.

Found by 0sec (https://0sec.ai) using automated source analysis;
verified against the HID input registration and probe unwind paths.

Fixes: 4f967f6d7374 ("HID: sony: Fix memory issue when connecting device using both Bluetooth and USB")
Cc: stable@vger.kernel.org
Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
Link: https://lore.kernel.org/linux-input/20260724143925.007D61F00A3A@smtp.kernel.org/
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 253fff4066eb..56471b7b052d 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1982,11 +1982,10 @@ static int sony_check_add_dev_list(struct sony_sc *sc)
 
 static void sony_remove_dev_list(struct sony_sc *sc)
 {
-	if (sc->list_node.next) {
-		scoped_guard(spinlock_irqsave, &sony_dev_list_lock) {
-			list_del(&(sc->list_node));
-		}
-	}
+	guard(spinlock_irqsave)(&sony_dev_list_lock);
+
+	if (!list_empty(&sc->list_node))
+		list_del_init(&sc->list_node);
 }
 
 static int sony_get_bt_devaddr(struct sony_sc *sc)
@@ -2127,6 +2126,13 @@ static inline void sony_cancel_work_sync(struct sony_sc *sc)
 	}
 }
 
+static void sony_cleanup(struct sony_sc *sc)
+{
+	sony_cancel_work_sync(sc);
+	sony_remove_dev_list(sc);
+	sony_release_device_id(sc);
+}
+
 static int sony_input_configured(struct hid_device *hdev,
 					struct hid_input *hidinput)
 {
@@ -2313,9 +2319,7 @@ static int sony_input_configured(struct hid_device *hdev,
 err_close:
 	hid_hw_close(hdev);
 err_stop:
-	sony_cancel_work_sync(sc);
-	sony_remove_dev_list(sc);
-	sony_release_device_id(sc);
+	sony_cleanup(sc);
 	return ret;
 }
 
@@ -2339,6 +2343,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return -ENOMEM;
 
 	spin_lock_init(&sc->lock);
+	INIT_LIST_HEAD(&sc->list_node);
+	sc->device_id = -1;
 
 	sc->quirks = quirks;
 	hid_set_drvdata(hdev, sc);
@@ -2367,6 +2373,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	ret = hid_hw_start(hdev, connect_mask);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
+		sony_cleanup(sc);
 		return ret;
 	}
 
@@ -2421,7 +2428,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 err:
 	usb_free_urb(sc->ghl_urb);
-
+	sony_cleanup(sc);
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -2436,13 +2443,7 @@ static void sony_remove(struct hid_device *hdev)
 	}
 
 	hid_hw_close(hdev);
-
-	sony_cancel_work_sync(sc);
-
-	sony_remove_dev_list(sc);
-
-	sony_release_device_id(sc);
-
+	sony_cleanup(sc);
 	hid_hw_stop(hdev);
 }
 

