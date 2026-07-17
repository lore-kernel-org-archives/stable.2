Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ABA24A07C;
	Fri, 17 Jul 2026 02:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784256978; cv=none; b=G3dMeMsRMYIv2DvU97dLzjkKG0C+EjMr8xL2c2kfpDjPhkyriR6D5/wj7jdvtCiX3oaE2Qm6urzsksM3EjjYpD5StdRi1cMLNyr63Ov3rCN0nTTIB1jaiVrMKFjOAffNuaSAJmP1LEO4MTb5vAHVTfLwKY4j3OP7OqyNQ1JRRUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784256978; c=relaxed/simple;
	bh=Vpb1BU3/U6gHwbAKD5b+6BHmEWVYkaUsfG0Yr559dJg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tDgATYYdlxNRIwd65oMtwPm9TKY66gRxT/SHDb8rwB16TBq8Pq0VRR+D7LdCiXv1MKpRvPW5S3SD8Pzfgnyi382cLd53QG+Yn0pfTcWVi919nEs9AcJ+Hw/Z4ajGBAwWKHsxcEtF6W9z6j1hDKFyzbMtJDae+xSyuSDSThwTn4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Ds20sJPZ; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Ds20sJPZ"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 468584280;
	Fri, 17 Jul 2026 10:56:09 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3 ath-current] wifi: ath12k: convert scan timeout to wiphy delayed work
Date: Fri, 17 Jul 2026 10:56:02 +0800
Message-Id: <20260717025602.262916-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f6e00b99403a1kunmdec449f220c0f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDH08YVh5DQxpJHhpISE5IS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Ds20sJPZf3UlcCC6he7PMb0+TD9q0mC5p1aa4+qDmjxBtBM5FX6kCxONxHcLhT7aNgl31x5jwiJQKJVr32N1sPOKk+pn0CHvMwORbBne3Y6pgHNliWC5Siwfqw6omiu/yv/AONZnbApKBEIlvhMD1MBxXyL5AXNd1O67C8lPaAA=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=FSO2j91TkEpI8QtMWnZWa6dR1VeafzmNPq3IfWih298=;
	h=date:mime-version:subject:message-id:from;

ath12k_mac_op_stop() is called with the wiphy mutex held and calls
ath12k_mac_stop(), which cancels ar->scan.timeout. The timeout worker
also takes the wiphy mutex before aborting the scan, so synchronously
cancelling it from the stop path can deadlock if the worker has started
and is waiting for the same mutex.

Do not drop the wiphy mutex inside the mac80211 stop callback. Convert
ar->scan.timeout to wiphy_delayed_work instead, so the timeout callback
runs in wiphy work context with the wiphy mutex held. This matches the
locking model used by the scan vdev cleanup work and lets stop/cancel
paths use wiphy_delayed_work_cancel() while they already hold the wiphy
mutex.

The old scan-finish path could cancel the delayed work directly from WMI
event context. With wiphy_delayed_work that cancellation must happen from
wiphy context, so keep it in scan.vdev_clean_wk. Mark scans whose cleanup
work has been queued so a timeout work item that was already queued before
cleanup runs does not abort a scan that is already finishing.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
Changes in v3:
  - Convert scan.timeout to wiphy_delayed_work instead of dropping the
    mac80211-owned wiphy lock in ath12k_mac_op_stop().
  - Cancel the timeout from scan.vdev_clean_wk to preserve the
    scan-finish cancellation from wiphy context.
  - Add scan.finish_queued so an already queued timeout work item does not
    abort a scan that has already queued its cleanup work.

Changes in v2:
  - Rebase on ath.git ath-current.
  - Use ath-current subject tag as requested.
  - Move the synchronous scan timeout drain out of the locked stop path
    instead of adding it in the wrong start-path context.
  - Update Fixes to the ath12k commit that introduced the stop-time
    scan.timeout drain.

 drivers/net/wireless/ath/ath12k/core.c |  2 +-
 drivers/net/wireless/ath/ath12k/core.h |  3 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 50 ++++++++++++++++++--------
 3 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 742d4fd1b598..95673d3be9da 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1463,7 +1463,7 @@ void ath12k_core_halt(struct ath12k *ar)
 
 	ath12k_mac_scan_finish(ar);
 	ath12k_mac_peer_cleanup_all(ar);
-	cancel_delayed_work_sync(&ar->scan.timeout);
+	wiphy_delayed_work_cancel(ath12k_ar_to_hw(ar)->wiphy, &ar->scan.timeout);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ar->regd_channel_update_work);
 	cancel_work_sync(&ab->rfkill_work);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index fc5127b5c1a3..b6fd5e9dfdb7 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -635,11 +635,12 @@ struct ath12k {
 		struct completion started;
 		struct completion completed;
 		struct completion on_channel;
-		struct delayed_work timeout;
+		struct wiphy_delayed_work timeout;
 		enum ath12k_scan_state state;
 		bool is_roc;
 		int roc_freq;
 		bool roc_notify;
+		bool finish_queued;
 		struct wiphy_work vdev_clean_wk;
 		struct ath12k_link_vif *arvif;
 	} scan;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 51c4df32e716..f53df8d4c808 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5162,7 +5162,7 @@ void __ath12k_mac_scan_finish(struct ath12k *ar)
 			ieee80211_remain_on_channel_expired(hw);
 		fallthrough;
 	case ATH12K_SCAN_STARTING:
-		cancel_delayed_work(&ar->scan.timeout);
+		ar->scan.finish_queued = true;
 		complete_all(&ar->scan.completed);
 		wiphy_work_queue(ar->ah->hw->wiphy, &ar->scan.vdev_clean_wk);
 		break;
@@ -5254,14 +5254,23 @@ static void ath12k_scan_abort(struct ath12k *ar)
 	spin_unlock_bh(&ar->data_lock);
 }
 
-static void ath12k_scan_timeout_work(struct work_struct *work)
+static void ath12k_scan_timeout_work(struct wiphy *wiphy,
+				     struct wiphy_work *work)
 {
-	struct ath12k *ar = container_of(work, struct ath12k,
-					 scan.timeout.work);
+	struct wiphy_delayed_work *dwork;
+	struct ath12k *ar;
+
+	dwork = container_of(work, struct wiphy_delayed_work, work);
+	ar = container_of(dwork, struct ath12k, scan.timeout);
+
+	spin_lock_bh(&ar->data_lock);
+	if (ar->scan.finish_queued) {
+		spin_unlock_bh(&ar->data_lock);
+		return;
+	}
+	spin_unlock_bh(&ar->data_lock);
 
-	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);
 	ath12k_scan_abort(ar);
-	wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
 }
 
 static void ath12k_mac_scan_send_complete(struct ath12k *ar,
@@ -5292,6 +5301,8 @@ static void ath12k_scan_vdev_clean_work(struct wiphy *wiphy, struct wiphy_work *
 
 	arvif = ar->scan.arvif;
 
+	wiphy_delayed_work_cancel(wiphy, &ar->scan.timeout);
+
 	/* The scan vdev has already been deleted. This can occur when a
 	 * new scan request is made on the same vif with a different
 	 * frequency, causing the scan arvif to move from one radio to
@@ -5323,6 +5334,7 @@ static void ath12k_scan_vdev_clean_work(struct wiphy *wiphy, struct wiphy_work *
 	}
 
 	ar->scan.state = ATH12K_SCAN_IDLE;
+	ar->scan.finish_queued = false;
 	ar->scan_channel = NULL;
 	ar->scan.roc_freq = 0;
 	spin_unlock_bh(&ar->data_lock);
@@ -5609,6 +5621,7 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
 		reinit_completion(&ar->scan.completed);
 		ar->scan.state = ATH12K_SCAN_STARTING;
 		ar->scan.is_roc = false;
+		ar->scan.finish_queued = false;
 		ar->scan.arvif = arvif;
 		ret = 0;
 		break;
@@ -5665,6 +5678,7 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
 
 		spin_lock_bh(&ar->data_lock);
 		ar->scan.state = ATH12K_SCAN_IDLE;
+		ar->scan.finish_queued = false;
 		spin_unlock_bh(&ar->data_lock);
 		goto exit;
 	}
@@ -5672,9 +5686,10 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac scan started");
 
 	/* Add a margin to account for event/command processing */
-	ieee80211_queue_delayed_work(ath12k_ar_to_hw(ar), &ar->scan.timeout,
-				     msecs_to_jiffies(arg->max_scan_time +
-						      ATH12K_MAC_SCAN_TIMEOUT_MSECS));
+	wiphy_delayed_work_queue(ath12k_ar_to_hw(ar)->wiphy,
+				 &ar->scan.timeout,
+				 msecs_to_jiffies(arg->max_scan_time +
+						  ATH12K_MAC_SCAN_TIMEOUT_MSECS));
 
 exit:
 	if (arg) {
@@ -5757,6 +5772,7 @@ int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 				spin_lock_bh(&ar->data_lock);
 				ar->scan.arvif = NULL;
 				ar->scan.state = ATH12K_SCAN_IDLE;
+				ar->scan.finish_queued = false;
 				ar->scan_channel = NULL;
 				ar->scan.roc_freq = 0;
 				spin_unlock_bh(&ar->data_lock);
@@ -5792,7 +5808,7 @@ void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
 
 		ath12k_scan_abort(ar);
 
-		cancel_delayed_work_sync(&ar->scan.timeout);
+		wiphy_delayed_work_cancel(hw->wiphy, &ar->scan.timeout);
 	}
 }
 EXPORT_SYMBOL(ath12k_mac_op_cancel_hw_scan);
@@ -9935,7 +9951,7 @@ static void ath12k_mac_stop(struct ath12k *ar)
 
 	clear_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags);
 
-	cancel_delayed_work_sync(&ar->scan.timeout);
+	wiphy_delayed_work_cancel(ath12k_ar_to_hw(ar)->wiphy, &ar->scan.timeout);
 	wiphy_work_cancel(ath12k_ar_to_hw(ar)->wiphy, &ar->scan.vdev_clean_wk);
 	cancel_work_sync(&ar->regd_channel_update_work);
 	cancel_work_sync(&ar->regd_update_work);
@@ -10962,6 +10978,7 @@ void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 			}
 
 			ar->scan.state = ATH12K_SCAN_IDLE;
+			ar->scan.finish_queued = false;
 			ar->scan_channel = NULL;
 			ar->scan.roc_freq = 0;
 			spin_unlock_bh(&ar->data_lock);
@@ -13876,7 +13893,7 @@ int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
 
 	ath12k_scan_abort(ar);
 
-	cancel_delayed_work_sync(&ar->scan.timeout);
+	wiphy_delayed_work_cancel(hw->wiphy, &ar->scan.timeout);
 	wiphy_work_flush(hw->wiphy, &ar->scan.vdev_clean_wk);
 
 	return 0;
@@ -13956,6 +13973,7 @@ int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 		reinit_completion(&ar->scan.on_channel);
 		ar->scan.state = ATH12K_SCAN_STARTING;
 		ar->scan.is_roc = true;
+		ar->scan.finish_queued = false;
 		ar->scan.arvif = arvif;
 		ar->scan.roc_freq = chan->center_freq;
 		ar->scan.roc_notify = true;
@@ -13998,6 +14016,7 @@ int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 
 		spin_lock_bh(&ar->data_lock);
 		ar->scan.state = ATH12K_SCAN_IDLE;
+		ar->scan.finish_queued = false;
 		spin_unlock_bh(&ar->data_lock);
 		return ret;
 	}
@@ -14011,8 +14030,8 @@ int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 		return -ETIMEDOUT;
 	}
 
-	ieee80211_queue_delayed_work(hw, &ar->scan.timeout,
-				     msecs_to_jiffies(duration));
+	wiphy_delayed_work_queue(hw->wiphy, &ar->scan.timeout,
+				 msecs_to_jiffies(duration));
 
 	return 0;
 }
@@ -15052,6 +15071,7 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	ar->num_tx_chains = hweight32(pdev->cap.tx_chain_mask);
 	ar->num_rx_chains = hweight32(pdev->cap.rx_chain_mask);
 	ar->scan.arvif = NULL;
+	ar->scan.finish_queued = false;
 	ar->vdev_id_11d_scan = ATH12K_11D_INVALID_VDEV_ID;
 
 	spin_lock_init(&ar->data_lock);
@@ -15077,7 +15097,7 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	ar->thermal.temperature = 0;
 	ar->thermal.hwmon_dev = NULL;
 
-	INIT_DELAYED_WORK(&ar->scan.timeout, ath12k_scan_timeout_work);
+	wiphy_delayed_work_init(&ar->scan.timeout, ath12k_scan_timeout_work);
 	wiphy_work_init(&ar->scan.vdev_clean_wk, ath12k_scan_vdev_clean_work);
 	INIT_WORK(&ar->regd_channel_update_work, ath12k_regd_update_chan_list_work);
 	INIT_LIST_HEAD(&ar->regd_channel_update_queue);
-- 
2.34.1
