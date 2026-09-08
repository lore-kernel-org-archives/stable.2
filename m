Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2AE239E7F
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788827968; cv=none; b=kW9Sz12YuQ9QHIkXuG2ZlBAj9oEecCdqaleGnPOPTH12Uqy0lBXOaDMZyXVYSxwp3WBxxqqKE/ms+st6ezTqMMlkzoxVE3Nf34LyUyEkhbRshFsxQlZUkvLs1X8DaBNUQfDm7PcY/TzhvGshZLeVcU9/PW+idscu+kn9TzLmftI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788827968; c=relaxed/simple;
	bh=DYxdbpoaT1Lrh4VYoOAdLgucHJbZkftK73torohWjZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVpnOx1QeDfxltrR276vC3r/LeuSqO0Kdk6sPciXK4rj0DHcRzooE7kDOLNDuBh/w5Xjfof4pA5GSABHbgpgFQCb+bE0YCVMbePfEwrwhexutx8/bOUcfcIUSX8SwQPGVy8DitsxGIMTtdqxyJlbtLlyyZLJ7TGWKbGnAzrdXOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j49Ox2Uj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j49Ox2Uj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956AF1F00A3E;
	Tue,  8 Sep 2026 00:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788827967;
	bh=UB+NBhXog2lkwgkJV3ZhT/b5RbsFbfOZnfemR6K7X3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j49Ox2UjG2LhpNfegNCrxurn390yZNRsm4Y4tN0reZKfVzbLJueBiXS7BoNHjs1u7
	 CTvc7b9nYkf8KduXeQiUbeNPA0Z7Uj+SS6T+ymgi9pPl2+6ZWN/Yh9HxC/kQ8N17ZE
	 lVTiThiv4qApzmX/IkRkAoM4Tpqw5j+4nODU/rwJPAPG6+bI+hbO0mYjxQw6CYwupp
	 bE5gPnBYFNQJTYdoLwdLPeH1+gyqQpS0C3sWJr8z2YpH8CYNI2pqaztKJK8jIgK/1D
	 MbJ+keSc02ww+Rc0V9/sa5KQrQFAPbhPTyxV2+BwbyJqpCpqJM9bcKteLJ1Y3qo8Jt
	 90IgvaAAEe5sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Doruk Tan Ozturk <doruk@0sec.ai>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/5] HID: sony: clean up device list on probe failure
Date: Mon,  7 Sep 2026 20:39:21 -0400
Message-ID: <20260908003921.1609143-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908003921.1609143-1-sashal@kernel.org>
References: <2026090345-sizably-halves-2b7f@gregkh>
 <20260908003921.1609143-1-sashal@kernel.org>
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
index 251ca31d25571..afe7e334a5743 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1655,11 +1655,10 @@ static int sony_check_add_dev_list(struct sony_sc *sc)
 
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
@@ -1795,6 +1794,13 @@ static inline void sony_cancel_work_sync(struct sony_sc *sc)
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
@@ -1953,9 +1959,7 @@ static int sony_input_configured(struct hid_device *hdev,
 err_close:
 	hid_hw_close(hdev);
 err_stop:
-	sony_cancel_work_sync(sc);
-	sony_remove_dev_list(sc);
-	sony_release_device_id(sc);
+	sony_cleanup(sc);
 	return ret;
 }
 
@@ -1977,6 +1981,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return -ENOMEM;
 
 	spin_lock_init(&sc->lock);
+	INIT_LIST_HEAD(&sc->list_node);
+	sc->device_id = -1;
 
 	sc->quirks = quirks;
 	hid_set_drvdata(hdev, sc);
@@ -2005,6 +2011,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	ret = hid_hw_start(hdev, connect_mask);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
+		sony_cleanup(sc);
 		return ret;
 	}
 
@@ -2026,7 +2033,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 err:
 	usb_free_urb(sc->ghl_urb);
-
+	sony_cleanup(sc);
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -2040,13 +2047,7 @@ static void sony_remove(struct hid_device *hdev)
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

