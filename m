Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FDE3BCD33
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405893; cv=none; b=doW5Q2CxLOA2//w8ICFvs48bTcfBzya3cL9kgY+2FN8PfHaA3H/LnyyGnBObwu1l7o+RYDQ1dhXce4EvrgmqRcgEx7UeSURtA++VPvmROol4CEViNLLVM5DEhiwE3JvNdKIFRibcyr/D/iMVbESmcu55GvmMTSpzolf0XoG51ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405893; c=relaxed/simple;
	bh=LTBhq8eBVG7saok9nM1aU4++GPWCZUsGzxScTgiocGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqPEErBhanjVqlNMNqqLEdJ/tp5Rh2WCx3gmZ0gSNz4G0TEsqy3uHD21+vty70AqdGR6Z2Scifkeeai7YyODK7gEtVrZCIborKYtVc+b2l1LEdo5t0yTVq+79ekIvehdO3i9acZQU6nTbdhkeqB9/Lqw9HkOQHP8iyYQ6xDXP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lh59jPXf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lh59jPXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D6B1F000E9;
	Mon, 10 Aug 2026 23:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786405891;
	bh=qVkf25u2Ltlqd15VGwbZs9IGkdAz8sdKIE/0TdHUXSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lh59jPXf2loIwXsPdIKYjMkgzSvJGCyqmglFG6monQY+dcgArqEDMEcTFmpay2wUD
	 4RA2BuiDNM25CLQaJAcDS5yPi1WhrxfeTl9KgSS9hPRRLewmpvyJDIiZcoIf+4Xw69
	 WLUGl5/tCndiXbB09DcsWTyv4fMnQ9Prd2BpN1QVZQZA4FfR6PqndzE3pcijgqN5JP
	 jvlQN7HgvU5blUxCkyuZmpNM4pa54iBhJTYkbIFtCij5PPzB1R+HnYLHpsUvXSaptC
	 QNmYDH4u8BazemAxmO78kMerZHzjkuoW7137V0obPleKQI48WrkA3lfCvdc3W2wfnJ
	 Z64Ztk6ypRB3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 7/7] Bluetooth: hci_sync: Fix advertising data UAFs
Date: Mon, 10 Aug 2026 19:51:24 -0400
Message-ID: <20260810235124.3217231-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810235124.3217231-1-sashal@kernel.org>
References: <2026080500-repeater-crust-fca2@gregkh>
 <20260810235124.3217231-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengfeng Ye <nicoyip.dev@gmail.com>

[ Upstream commit cdc36db204ffd97b947d64374cf23a210dc74777 ]

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
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sync.c | 131 +++++++++++++++++++++++++++++----------
 1 file changed, 97 insertions(+), 34 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a947738ed50df..939fd8f08f778 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1252,10 +1252,11 @@ static int hci_set_adv_set_random_addr_sync(struct hci_dev *hdev, u8 instance,
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
@@ -1283,11 +1284,15 @@ hci_set_ext_adv_params_sync(struct hci_dev *hdev, struct adv_info *adv,
 
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
 
@@ -1303,9 +1308,13 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
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
@@ -1316,16 +1325,27 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
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
@@ -1379,22 +1399,22 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
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
@@ -1405,8 +1425,11 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
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
@@ -1417,8 +1440,11 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
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
 
@@ -1467,6 +1493,9 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	cp.channel_map = hdev->le_adv_channel_map;
 	cp.handle = adv ? adv->handle : instance;
 
+	if (instance)
+		hci_dev_unlock(hdev);
+
 	if (flags & MGMT_ADV_FLAG_SEC_2M) {
 		cp.primary_phy = HCI_ADV_PHY_1M;
 		cp.secondary_phy = HCI_ADV_PHY_2M;
@@ -1479,12 +1508,12 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
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
 
@@ -1492,9 +1521,14 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
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
@@ -1516,9 +1550,13 @@ static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
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
@@ -1528,15 +1566,27 @@ static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
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
@@ -1551,8 +1601,14 @@ static int __hci_set_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 
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
@@ -1687,9 +1743,13 @@ static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
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
@@ -1698,6 +1758,9 @@ static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
 	pdu->handle = adv ? adv->handle : instance;
 	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
 
+	if (adv)
+		hci_dev_unlock(hdev);
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_PER_ADV_DATA,
 				     struct_size(pdu, data, len), pdu,
 				     HCI_CMD_TIMEOUT);
@@ -6402,7 +6465,7 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
 	if (err)
 		return err;
 
-	err = hci_set_ext_adv_params_sync(hdev, NULL, &cp, &rp);
+	err = hci_set_ext_adv_params_sync(hdev, 0, &cp, &rp);
 	if (err)
 		return err;
 
-- 
2.53.0

