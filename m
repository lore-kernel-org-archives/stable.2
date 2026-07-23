Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA824C8FEA
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820900; cv=none; b=l1HIpUaHZdch0/PHCTjxqiDS3tInkJcFw/xwMuGtHJ7p8rUU/0R2xmsI6pyJYQsexXSHE+ykVIK5DqfajcAry/UnIyRUbDV1mj9AM9VXKHzyOZWvQDaM7t5t9DsBeGq2m1CWVPYAbd1YizsKBA7d69G/IRPXcvKqSKq/9yvaPHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820900; c=relaxed/simple;
	bh=GDKEmuXFhac2VKPf9kmHj7KLT8U10QqT1ib08+5c6BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNmRGBAMYmtgXMAaVOe98FnlVejbvhSs1VJRgBYIDP4IkSyriT8n9nWbHpeTFbY9XBftyk638V9rMiOtRmCzs5up2LIrU8/BcGk5KZf+kcuALSSyIFMySjigqx1ML9YVbA7Zr0yfGJq/8JI8XTrk9FQJVPKMRxm3u1qPjOWGOWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+z3Jz3k; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+z3Jz3k"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca6d9c91206so81265a12.2
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784820888; x=1785425688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jMXs52eS7eZ/u/yFLXPygHed7LhVkq5pYs2Qe/C7Pfw=;
        b=I+z3Jz3kRSjxf5uclJIjrlIGCJ1M5y4B9WVIinN2JYp47BD2JEQUvznqY+VxrcvtII
         n9efzzJWve7bS0RwBl+EgAnOOgX7xZXJOaBiVqPnzHKhitemSvX5ZmyiffPAjNclqCo8
         jgEdUVGtBCPrjGK4ephAY8fTagQ1beggwUWPhIdtpQyZQddVnh/P9PSMvY0itaY9Z/IO
         71nY+h6hV2OsVDF59OG+4SL4tNingfxfxDt7yFpf9ep/qmSS/Vzd9N+3Km7wKu4N3bjA
         732E29xmpe2M6CQzIa7gLFbq6MQFt2v8l4pBwIV8GT9AXTEk5AZKbFylgXzI3mBo7y9Y
         ZP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784820888; x=1785425688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jMXs52eS7eZ/u/yFLXPygHed7LhVkq5pYs2Qe/C7Pfw=;
        b=Yu2C7b31ZlHJiwrQ8cdLXlwLIB++nWTDcHMiMXlkDGEhmEshKALNKfH2rbjgs8eLAY
         5unsofCH0E0letxGcvYs+9O9OZsucPsuVDVybTFPyiLpYCJRedFklA4mvG7UedVLHucQ
         p+DUGUT8xhnVPDmj9ZTdXQpJGrHf9Qnefse8SBEm/1tgOeVlMHIkXYUPS4BCrfSbQWuJ
         l0fuZEOmc2ds1K1Ooo3VhVSVcbt0bXFlUCgx02N/ROxkwm3i31eJbybZkB3tysyk1A2/
         +sE6Tr4XvPnwTSJEI7GKPicpNsyKr85Qo+mGiycp/0XEB+kcr/uHcRyA3p35Lz/sBV4U
         r6rQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq7v6WVFiLLHd/Tl1rmvjX3gTdi1HGVL9omMO1RG/KSFBC0D9r+ff0z5RMuZx1/5PFnwJ3qV3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgH9HCOfpaIPuAvwgosCpeqz7iTD2FRyNcJSSxscfSR6bUMOBl
	01Ldl7gNcWA12u1jVOVyS2ZZYBguQtzsz2DTTuig/C76ZsYlxGZcbSut
X-Gm-Gg: AR+sD102w/f06F5ZZrPqwsfgezC/+RpyCPv1obxkby2jE6L08APu7oEixBPrClQFlxl
	GD5qrYyOkCSwKUIzDKbz4z7TuWqcQlYxqiZTqlDz1GI1Fd02QT7riHURud96UETxjQbPZBsqXnY
	RyLiOc/esbbMiZDXgT8pnJ5Rq/DWrw19WPHektiNG8bJkmNUMSTTrW7HGJcAjP3DanzmCQdvp9F
	9w+mb62qMfJhS8yydsKbZHUTe5vyRxCderJG2QUa2Q3sc1WL9yeQ6DA3zDp7IBqW6giH7D7Zb3r
	EcCHljvuNbpMF7mzY3sUSqavvDd4bHp9b21uae82rWSXAQDQ62oy7zcTvxoBVKWMgZco8Cx7WIz
	WjiHJeyc+QRdGdBmCPRlGIMgMpU03EPaegBeel5GBt7s8PPLmlg/WNIwEtW9c5UYVQI7URnfwBB
	No3Xy71l9w/SPw0zGXvA9/E4GEPTR5NOmCj/h+SP5q3fveNvr5GgEvq7DBW2a/MzF+WgDZ
X-Received: by 2002:a17:903:1a84:b0:2cc:d6de:d58e with SMTP id d9443c01a7336-2cfbd0a553amr1160235ad.4.1784820887908;
        Thu, 23 Jul 2026 08:34:47 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1bc886sm21031976eec.26.2026.07.23.08.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:34:47 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_sync: Fix advertising data UAFs
Date: Thu, 23 Jul 2026 23:34:40 +0800
Message-ID: <20260723153440.3224299-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720164738.2921802-1-nicoyip.dev@gmail.com>
References: <20260720164738.2921802-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_find_adv_instance() returns an adv_info pointer that is valid only
while hdev->lock is held.  The advertising command-sync paths perform
instance lookups without that lock and, in some cases, retain the pointer
while waiting for a controller response.

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

Protect the instance lookup and payload construction in the extended
advertising, scan response, and periodic advertising data paths.  Snapshot
the advertising parameters under hdev->lock, but release the lock before
waiting for the controller.

Clear advertising-data dirty bits before issuing their commands and
restore them after a failure using a fresh lookup.  Likewise, update the
reported transmit power through a fresh lookup after the parameter command
completes.  No adv_info pointer then survives an HCI command wait.

Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Cc: stable@vger.kernel.org
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---

Changes in v2:
- Address Sashiko review findings in the extended advertising data,
  parameter, and periodic advertising data sibling paths.
- Keep the original scan-response fix unchanged.

Sashiko: https://sashiko.dev/#/patchset/20260720164738.2921802-1-nicoyip.dev%40gmail.com
Link: https://lore.kernel.org/linux-bluetooth/20260720164738.2921802-1-nicoyip.dev@gmail.com/ [v1]

 net/bluetooth/hci_sync.c | 131 +++++++++++++++++++++++++++++----------
 1 file changed, 97 insertions(+), 34 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 532534bc601c..24cfad721b2d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1224,10 +1224,11 @@ static int hci_set_adv_set_random_addr_sync(struct hci_dev *hdev, u8 instance,
 }
 
 static int
-hci_set_ext_adv_params_sync(struct hci_dev *hdev, struct adv_info *adv,
+hci_set_ext_adv_params_sync(struct hci_dev *hdev, u8 instance,
 			    const struct hci_cp_le_set_ext_adv_params *cp,
 			    struct hci_rp_le_set_ext_adv_params *rp)
 {
+	struct adv_info *adv;
 	struct sk_buff *skb;
 
 	skb = __hci_cmd_sync(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(*cp),
@@ -1255,11 +1256,15 @@ hci_set_ext_adv_params_sync(struct hci_dev *hdev, struct adv_info *adv,
 
 	if (!rp->status) {
 		hdev->adv_addr_type = cp->own_addr_type;
-		if (!cp->handle) {
+		if (!instance) {
 			/* Store in hdev for instance 0 */
 			hdev->adv_tx_power = rp->tx_power;
-		} else if (adv) {
-			adv->tx_power = rp->tx_power;
+		} else {
+			hci_dev_lock(hdev);
+			adv = hci_find_adv_instance(hdev, instance);
+			if (adv)
+				adv->tx_power = rp->tx_power;
+			hci_dev_unlock(hdev);
 		}
 	}
 
@@ -1275,9 +1280,13 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 	int err;
 
 	if (instance) {
+		hci_dev_lock(hdev);
+
 		adv = hci_find_adv_instance(hdev, instance);
-		if (!adv || !adv->adv_data_changed)
+		if (!adv || !adv->adv_data_changed) {
+			hci_dev_unlock(hdev);
 			return 0;
+		}
 	}
 
 	len = eir_create_adv_data(hdev, instance, pdu->data,
@@ -1288,16 +1297,27 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
 	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
 
+	if (adv) {
+		adv->adv_data_changed = false;
+		hci_dev_unlock(hdev);
+	}
+
 	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
 				    struct_size(pdu, data, len), pdu,
 				    HCI_CMD_TIMEOUT);
-	if (err)
+	if (err) {
+		if (instance) {
+			hci_dev_lock(hdev);
+			adv = hci_find_adv_instance(hdev, instance);
+			if (adv)
+				adv->adv_data_changed = true;
+			hci_dev_unlock(hdev);
+		}
+
 		return err;
+	}
 
-	/* Update data if the command succeed */
-	if (adv) {
-		adv->adv_data_changed = false;
-	} else {
+	if (!instance) {
 		memcpy(hdev->adv_data, pdu->data, len);
 		hdev->adv_data_len = len;
 	}
@@ -1351,22 +1371,22 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	struct adv_info *adv;
 	bool secondary_adv;
 
-	if (instance > 0) {
-		adv = hci_find_adv_instance(hdev, instance);
-		if (!adv)
-			return -EINVAL;
-	} else {
-		adv = NULL;
-	}
-
 	/* Updating parameters of an active instance will return a
-	 * Command Disallowed error, so we must first disable the
-	 * instance if it is active.
+	 * Command Disallowed error, so disable it before taking a snapshot.
 	 */
-	if (adv) {
+	if (instance > 0) {
 		err = hci_disable_ext_adv_instance_sync(hdev, instance);
 		if (err)
 			return err;
+
+		hci_dev_lock(hdev);
+		adv = hci_find_adv_instance(hdev, instance);
+		if (!adv) {
+			hci_dev_unlock(hdev);
+			return -EINVAL;
+		}
+	} else {
+		adv = NULL;
 	}
 
 	flags = hci_adv_instance_flags(hdev, instance);
@@ -1377,8 +1397,11 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	connectable = (flags & MGMT_ADV_FLAG_CONNECTABLE) ||
 		      mgmt_get_connectable(hdev);
 
-	if (!is_advertising_allowed(hdev, connectable))
+	if (!is_advertising_allowed(hdev, connectable)) {
+		if (instance)
+			hci_dev_unlock(hdev);
 		return -EPERM;
+	}
 
 	/* Set require_privacy to true only when non-connectable
 	 * advertising is used and it is not periodic.
@@ -1389,8 +1412,11 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	err = hci_get_random_address(hdev, require_privacy,
 				     adv_use_rpa(hdev, flags), adv,
 				     &own_addr_type, &random_addr);
-	if (err < 0)
+	if (err < 0) {
+		if (instance)
+			hci_dev_unlock(hdev);
 		return err;
+	}
 
 	memset(&cp, 0, sizeof(cp));
 
@@ -1441,6 +1467,9 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	cp.channel_map = hdev->le_adv_channel_map;
 	cp.handle = adv ? adv->handle : instance;
 
+	if (instance)
+		hci_dev_unlock(hdev);
+
 	if (flags & MGMT_ADV_FLAG_SEC_2M) {
 		cp.primary_phy = HCI_ADV_PHY_1M;
 		cp.secondary_phy = HCI_ADV_PHY_2M;
@@ -1453,12 +1482,12 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 		cp.secondary_phy = HCI_ADV_PHY_1M;
 	}
 
-	err = hci_set_ext_adv_params_sync(hdev, adv, &cp, &rp);
+	err = hci_set_ext_adv_params_sync(hdev, instance, &cp, &rp);
 	if (err)
 		return err;
 
 	/* Update adv data as tx power is known now */
-	err = hci_set_ext_adv_data_sync(hdev, cp.handle);
+	err = hci_set_ext_adv_data_sync(hdev, instance);
 	if (err)
 		return err;
 
@@ -1466,9 +1495,14 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	     own_addr_type == ADDR_LE_DEV_RANDOM_RESOLVED) &&
 	    bacmp(&random_addr, BDADDR_ANY)) {
 		/* Check if random address need to be updated */
-		if (adv) {
-			if (!bacmp(&random_addr, &adv->random_addr))
+		if (instance) {
+			hci_dev_lock(hdev);
+			adv = hci_find_adv_instance(hdev, instance);
+			if (!adv || !bacmp(&random_addr, &adv->random_addr)) {
+				hci_dev_unlock(hdev);
 				return 0;
+			}
+			hci_dev_unlock(hdev);
 		} else {
 			if (!bacmp(&random_addr, &hdev->random_addr))
 				return 0;
@@ -1490,9 +1524,13 @@ static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
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
@@ -1502,15 +1540,27 @@ static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
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
@@ -1525,8 +1575,14 @@ static int __hci_set_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 
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
@@ -1661,9 +1717,13 @@ static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
 	struct adv_info *adv = NULL;
 
 	if (instance) {
+		hci_dev_lock(hdev);
+
 		adv = hci_find_adv_instance(hdev, instance);
-		if (!adv || !adv->periodic)
+		if (!adv || !adv->periodic) {
+			hci_dev_unlock(hdev);
 			return 0;
+		}
 	}
 
 	len = eir_create_per_adv_data(hdev, instance, pdu->data);
@@ -1672,6 +1732,9 @@ static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
 	pdu->handle = adv ? adv->handle : instance;
 	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
 
+	if (adv)
+		hci_dev_unlock(hdev);
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_PER_ADV_DATA,
 				     struct_size(pdu, data, len), pdu,
 				     HCI_CMD_TIMEOUT);
@@ -6514,7 +6577,7 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
 	if (err)
 		return err;
 
-	err = hci_set_ext_adv_params_sync(hdev, NULL, &cp, &rp);
+	err = hci_set_ext_adv_params_sync(hdev, 0, &cp, &rp);
 	if (err)
 		return err;
 
-- 
2.43.0

