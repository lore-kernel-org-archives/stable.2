Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7F1525A96
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811592; cv=none; b=Tnyjj/Mur8y58IGQVmCwrONeS88r51Fpt6JmPNgEKTGC6YUI+8LbQvT30JxDidon/jKU42covRapMCY15jqpryj3v+ELto/VzamtiD4IxF8MgTYUxPbP6z3qgKE8CJ4Hpx7TlbqggL9qL2GYZynoCRSfFS6dFZ7Jz2L/tMcONo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811592; c=relaxed/simple;
	bh=pnY3Ijp66fv/KxM5aHpF12qnAuR5fMRN2lOM1uxMfB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBkK+KYJttsdGRAy94R/LgCoYCHl9hIw/BJvxzw9vADZo9a5o6ZGbi9yudBMojnJ5bfGvnXKp1dtcu4dKIi9UL4AWQKbkp9tjgEMFerrcvVGU0iWSqf1rd1UTBrBNMEu+5Z2UlG9zErroHNbVWW/MBkTYd53mbmwkw7jwJ0d0Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEU9GkFY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEU9GkFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3491F00A3D;
	Mon,  7 Sep 2026 20:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788811588;
	bh=19eDIjfrU5W7ArUmyINsToBWTVWsMfNW5gaeUR2TAIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eEU9GkFYB1s5gF4Xb/3Q0rhc7bS0khRkIvltmU4yOITq4Jl/jItO+ISZpKsIOKXvQ
	 GoB34TjvYFcMesOHADufqodbAtGg9DeECRA8DSB/CRxct0R+IoxB3MDfRKVjKRafP4
	 zPPr4Kw7thZgfkIag18sG1PN4zCsWBHGEEXDCWuCTjeM9ofnlXXWtxAbW9L/ti7f3/
	 QRl3t9qJTP1W87CEQd1SOq4XMesVQpDQBqtcZA7Yg2oxeyTu0V3g2/B5N+tnOJIrEx
	 u6muHO7FWGCkFlxs3jq6U/rVbDJR5lHGx/MVtCNCQFleegR84Gb8tUPKZcFChb4m9r
	 38sBTV6U7idkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Doruk Tan Ozturk <doruk@0sec.ai>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] HID: sony: clean up device list on probe failure
Date: Mon,  7 Sep 2026 16:06:25 -0400
Message-ID: <20260907200625.359194-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907200625.359194-1-sashal@kernel.org>
References: <2026090343-discharge-dallying-3c2b@gregkh>
 <20260907200625.359194-1-sashal@kernel.org>
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
index 342e54fd03d4c..857b1efca4f38 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1740,11 +1740,10 @@ static int sony_check_add_dev_list(struct sony_sc *sc)
 
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
@@ -1879,6 +1878,13 @@ static inline void sony_cancel_work_sync(struct sony_sc *sc)
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
@@ -2037,9 +2043,7 @@ static int sony_input_configured(struct hid_device *hdev,
 err_close:
 	hid_hw_close(hdev);
 err_stop:
-	sony_cancel_work_sync(sc);
-	sony_remove_dev_list(sc);
-	sony_release_device_id(sc);
+	sony_cleanup(sc);
 	return ret;
 }
 
@@ -2065,6 +2069,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	spin_lock_init(&sc->lock);
+	INIT_LIST_HEAD(&sc->list_node);
+	sc->device_id = -1;
 
 	sc->quirks = quirks;
 	hid_set_drvdata(hdev, sc);
@@ -2093,6 +2099,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	ret = hid_hw_start(hdev, connect_mask);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
+		sony_cleanup(sc);
 		return ret;
 	}
 
@@ -2144,7 +2151,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 err:
 	usb_free_urb(sc->ghl_urb);
-
+	sony_cleanup(sc);
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -2159,13 +2166,7 @@ static void sony_remove(struct hid_device *hdev)
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

