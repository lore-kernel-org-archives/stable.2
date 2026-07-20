Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A94443314
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566075; cv=none; b=orZ9+ClwUH0QxZNDK2PcsLCkkmiSKIOOJR5+lh0mTluNGJ4/CfWw1hf6biBxBCkRMbq8VlLy2rwDltK8uS8dX6jd9resC9v1g9jQN9a7wg4/fFz9WiG6gL79+Ug1pzOTtT5boU2UP0wPJ7ODcd0IU28WTac8VBxGag2vzodb2CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566075; c=relaxed/simple;
	bh=Oti1msIlvTX5aDbLqPUB5RsoSmps0p87NYEbSnq/5kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ut4EdPexqNQ2kD6XlqcZzrQfGtSwTR7FO3ngdu1VM6vod1KCwmx0flFTmTwHjK/MM/KFNdBIHGKe+N8BSDRfPScKUY17sdJeYpFJZ8/AOo9OJs7N5/F0T4A2894ryknso0TI4gKEjj77MtjBgJTTgbBUXCdvfCWrPucZAxuCfqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ij3rrWpk; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij3rrWpk"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8484a24ccf8so746671b3a.1
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 09:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784566068; x=1785170868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AXskwc2WtSB6mLoqDGsJMTeDVD+Exvdvy305sSbWnFk=;
        b=ij3rrWpk4htzUBJTQh/RlpU0UZnCOChLydwio8wSGspPWnCKsrxQatmiQHGGIp5b+G
         DRr3tnIshrrBQAnyS1bE/vPdm7NiSmgDwoO4DIUhX/e0tUMShzxQy8TjYIzzvvnayPBS
         VVUrSst3cqxlmSZTSjrOmNYIH3+E8TTMDfbqoLiGYN9aPvS7u74mfndAm0DhBeFw5cv4
         MtNAGUp451AW9pqXws1KTkV9Q/l+W2Vrk8b92cq5iFmOy8CtEiU87JzgOq8g6ZiZGCb9
         JAnTulzxCw+4asuIj2QvB7IVTirmR+s0U9zyfLsQRPqkYHTbA366/8tK1bKzMyXmvAt7
         V7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784566068; x=1785170868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AXskwc2WtSB6mLoqDGsJMTeDVD+Exvdvy305sSbWnFk=;
        b=FmisipiIVP9cytVmVg6q+4+SOqNtcVtA4DCh/9Bz2sdr5I5QPpnM0omYiv17IzLs9L
         3BelrKwLEtW+Qn5wzs8V4VRh61JIcP1GV6lzr8bnUMyj4jrHxF94y8YO241tw5jsnOkr
         f2JSPbIdoNKp508gUNunWMONkRO7HoCwA0jZ3m0FLHF2laJa8xKsI50WNZeo5qJN2nMe
         DC1xbolHKDgwaJ8lriZBwQ7jn+SKOxIgT/63+eBaYVBsJ9UmxBlXpXNu1k8WvFygjEa+
         qktJbPRsiSuBhWahA1vPmV7GtOPyOH68jpIGpXIkTiZnOxA2fvjYhdu1SGw5zLYWLYOX
         pkTg==
X-Forwarded-Encrypted: i=1; AHgh+RpZZYAW30EQH0e0U920MhRnazc41fm7fm/n8Hlm/w3Tn5ibRP1l/b5rUPvVWltH4r1H/wDXmPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzek964MahwZiwZE7LNFdAxu0d+DhJaBREY9FJWzS4P4SaGT14Z
	vcfKD6AMaPfNtYO7FoHklqOkbr6X5706JQuvwXXS6Lf7Ibg+mmZowhci
X-Gm-Gg: AR+sD10b8HTvsKmb0RkEdnwkoFoUcsq7ZvuAZ0vWz4n1yE/NqfKWxColHn6+RRC4ABA
	PIZ/u6Uscv0XWY3fLmQZH00NwY5CQGGACr4L9MMolSHzoC1fZLHY9z0wmJDVivFGHkThHfcP/B6
	rSzBnWg39jQ9gUhNC2gBknPo4z7HfYahfQSsd1xw0Dw+VA/wzD4BynvneKa9lV6C7JG2D6FuKmm
	QeIXRkDzDYEbWlviZyc2l70WJNpvleoGXWS0O6L3gw3StM+qN+uetgCAB7XbUrFULs7zdLoB9QN
	UOl5K/95hBm06U7ED7p+uE5oYdF+i9xEIiaaAX9ANzYIT3g9IEWtTFGSZnE6wnqVBnfSxvv8h6k
	RMd4Db/iNMgqFZ8XwSQprgoDlgVA+SaQyhHM875HE7Tn9gHBduFrDmNqTDMxokeMk/wqmzY3V0v
	KIm/ngnxySsJ/i98t5wqQ/HJh1e4EiqfhmrQpmN3Y8jTo5Jk/SG+5DsVAB/7OTizySzbl/
X-Received: by 2002:a17:90b:2fc3:b0:38d:90c1:2400 with SMTP id 98e67ed59e1d1-38e4b3d5042mr12353703a91.2.1784566068190;
        Mon, 20 Jul 2026 09:47:48 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2a18a47sm34309143c88.8.2026.07.20.09.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:47:47 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Fix scan response data UAF
Date: Tue, 21 Jul 2026 00:47:38 +0800
Message-ID: <20260720164738.2921802-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eir_create_scan_rsp() calls hci_find_adv_instance(), whose return value is
valid only while hdev->lock is held.  After advertising setup was moved to
hci_cmd_sync_work, neither scan response data builder held that lock.
hci_set_ext_scan_rsp_data_sync() also kept the returned pointer while
waiting for the controller and wrote scan_rsp_changed through it afterward.

An advertising termination event can therefore interleave as follows:

  hci_cmd_sync_work                 hci_rx_work
  hci_find_adv_instance()
  __hci_cmd_sync_status()
    wait for controller reply       hci_dev_lock()
                                    hci_remove_adv_instance()
                                      kfree(adv)
  adv->scan_rsp_changed = false

KASAN reported:

  BUG: KASAN: slab-use-after-free in hci_set_ext_scan_rsp_data_sync+0x2e1/0x300
  Write of size 1 at addr ffff88810a45d21d by task kworker/u17:0/88
  Workqueue: hci0 hci_cmd_sync_work
  Call Trace:
   hci_set_ext_scan_rsp_data_sync+0x2e1/0x300
   hci_schedule_adv_instance_sync+0x390/0x4c0
   hci_cmd_sync_work+0x173/0x300
  Allocated by task 87:
   hci_add_adv_instance+0x538/0xac0
   add_advertising+0x885/0x1160
  Freed by task 89:
   kfree+0x131/0x3c0
   hci_remove_adv_instance+0x1d8/0x3b0
   hci_le_ext_adv_term_evt+0x17b/0x730

Hold hdev->lock while looking up the instance, building the scan
response, and clearing its dirty bit.  Clear the bit before waiting for
the controller so no adv_info pointer survives the wait, and restore it
under the lock if the command fails.  This also preserves an update that
races with a successful command because that update sets the bit again.
Protect the legacy scan response builder with the same lock.

Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/hci_sync.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 532534bc601c..8c69a98c71e8 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1490,9 +1490,13 @@ static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 	int err;
 
 	if (instance) {
+		hci_dev_lock(hdev);
+
 		adv = hci_find_adv_instance(hdev, instance);
-		if (!adv || !adv->scan_rsp_changed)
+		if (!adv || !adv->scan_rsp_changed) {
+			hci_dev_unlock(hdev);
 			return 0;
+		}
 	}
 
 	len = eir_create_scan_rsp(hdev, instance, pdu->data);
@@ -1502,15 +1506,27 @@ static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
 	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
 
+	if (adv) {
+		adv->scan_rsp_changed = false;
+		hci_dev_unlock(hdev);
+	}
+
 	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_SCAN_RSP_DATA,
 				    struct_size(pdu, data, len), pdu,
 				    HCI_CMD_TIMEOUT);
-	if (err)
+	if (err) {
+		if (instance) {
+			hci_dev_lock(hdev);
+			adv = hci_find_adv_instance(hdev, instance);
+			if (adv)
+				adv->scan_rsp_changed = true;
+			hci_dev_unlock(hdev);
+		}
+
 		return err;
+	}
 
-	if (adv) {
-		adv->scan_rsp_changed = false;
-	} else {
+	if (!instance) {
 		memcpy(hdev->scan_rsp_data, pdu->data, len);
 		hdev->scan_rsp_data_len = len;
 	}
@@ -1525,8 +1541,14 @@ static int __hci_set_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 
 	memset(&cp, 0, sizeof(cp));
 
+	if (instance)
+		hci_dev_lock(hdev);
+
 	len = eir_create_scan_rsp(hdev, instance, cp.data);
 
+	if (instance)
+		hci_dev_unlock(hdev);
+
 	if (hdev->scan_rsp_data_len == len &&
 	    !memcmp(cp.data, hdev->scan_rsp_data, len))
 		return 0;
-- 
2.43.0

