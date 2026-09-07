Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FA735C6BF
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817004; cv=none; b=KqaWA3kH0YhbKIXFVnxQ9f++dkX1EItvqK2Ti8Xwz+2W9pddtZoka4RFgsIMEDfJVuow1ERsPtta0gfzAZ/Wmf8ndaA7EMFfVwGLkaVIlBs986bZNQp+Xv51xWM4Rs3CwcVQuvy6v1hWqPhIVuXjAAZZ2GzxaLTikuIK6ZMC+K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817004; c=relaxed/simple;
	bh=KCwIBH5vEmGdx+AZOB+cCqrXbiX4rEIUKsgtUtwySlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pkt1QivzZHsBTbRLthaG+qfcQLGzB/OZCPtFH5qM+ZapFz+cb4KOQJjIuKxCOQYIPuto+fsoKNwbl21OvzI6/KmOfmJ28fBaqw56Pzp4RbWcpbvhAkUYTsL7J8grEW7pYg27t18mAHt+RjCPk74XsB+LBXJcMfRTmLnFseoUm2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=np8BpKsI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="np8BpKsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AC21F00ADB;
	Mon,  7 Sep 2026 21:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788817002;
	bh=dvGcEgHx7nwCOsjKIZ2UDzm2bU5zH+i9YTDA8HfwoAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=np8BpKsIue23axuRM6k7iST9KrGDVbFctczbDpiWAoZ3MS6thL8FyXbT9arNFvYyC
	 F05YBGD7imqir818KhFbaLdInAvMwdL/1g5z8RRPr+D4dPRwlMuB11Jjz6IdcIeA6G
	 DwSifrFarS/Jid1NNZLqz2K9ZatQSVeZNfFHPW8ZwLBmrWJsCAsiPQj7oyLftXhDxI
	 P2QcgIxJXVNtDTP5lon9+1Bvsd5K+wRBwukoGgfl02mC5zs9C8651eSVMTOiOJNa+o
	 t8VsyIpc83D4cAPErqmr3gfZgs2w/RyTtI3CLZc7yD1PH6wlItn/1QEKH03mS5sH1x
	 MH4c2flWxwCnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Doruk Tan Ozturk <doruk@0sec.ai>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] HID: sony: clean up device list on probe failure
Date: Mon,  7 Sep 2026 17:36:37 -0400
Message-ID: <20260907213637.574137-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907213637.574137-1-sashal@kernel.org>
References: <2026090344-dislocate-egging-04af@gregkh>
 <20260907213637.574137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Doruk Tan Ozturk <doruk@0sec.ai>

[ Upstream commit 7c65699a3a311198a07659a614fe64d45924839e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-sony.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 7a961a2b14432..105c56de0df95 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1738,11 +1738,10 @@ static int sony_check_add_dev_list(struct sony_sc *sc)
 
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
@@ -1878,6 +1877,13 @@ static inline void sony_cancel_work_sync(struct sony_sc *sc)
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
@@ -2036,9 +2042,7 @@ static int sony_input_configured(struct hid_device *hdev,
 err_close:
 	hid_hw_close(hdev);
 err_stop:
-	sony_cancel_work_sync(sc);
-	sony_remove_dev_list(sc);
-	sony_release_device_id(sc);
+	sony_cleanup(sc);
 	return ret;
 }
 
@@ -2064,6 +2068,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	spin_lock_init(&sc->lock);
+	INIT_LIST_HEAD(&sc->list_node);
+	sc->device_id = -1;
 
 	sc->quirks = quirks;
 	hid_set_drvdata(hdev, sc);
@@ -2092,6 +2098,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	ret = hid_hw_start(hdev, connect_mask);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
+		sony_cleanup(sc);
 		return ret;
 	}
 
@@ -2143,7 +2150,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 err:
 	usb_free_urb(sc->ghl_urb);
-
+	sony_cleanup(sc);
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -2158,13 +2165,7 @@ static void sony_remove(struct hid_device *hdev)
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
 
-- 
2.53.0

