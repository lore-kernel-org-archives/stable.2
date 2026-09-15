Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E906FC5;
	Tue, 15 Sep 2026 06:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455495; cv=none; b=KiNOovu3rMmRO5QMeOXihL8m7HGrG3uGcIxL1nxI5lyVIJdz7yds/q07e7+FIMyUOG4nYtMq1fNUFmiI3FGnS/j+FIC94lYDnWFXze6op3jxt/6ICQKVkSTBquYuxUsQXXRpqpWOcMDplZW6X7+HNuLXEk2t21LULK9WA89XOEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455495; c=relaxed/simple;
	bh=hLBfhLs+QJPPVKt9pww7qSYMH8xH526cQJNe3X2tHAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cjw8DHgKTnZ0eWc/PcFpxnHUQJqqH9vjCSzsqaAxEEKFw/463NsuxRlO1MwKkHzmLt2/6wDiYy/G4mV5jHs6+79511esPn/Ha/ArYt4UB7zcKiHbSfI2vwokii5ou2+bUlod8Lmlnycu97nopSjLBaVrGvpkUvoBuvK4UKeOuQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=mJZ2cae3; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="mJZ2cae3"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4dce2401c;
	Tue, 15 Sep 2026 14:57:56 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: jeff.johnson@oss.qualcomm.com
Cc: jjohnson@kernel.org,
	quic_kangyang@quicinc.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	jianhao.xu@seu.edu.cn,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v4 ath-current] wifi: ath12k: convert scan timeout to wiphy delayed work
Date: Tue, 15 Sep 2026 14:57:50 +0800
Message-Id: <20260915065750.981425-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <dded65dd-56df-4637-b3f5-c244651435a6@oss.qualcomm.com>
References: <dded65dd-56df-4637-b3f5-c244651435a6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0a3dba6cd03a1kunmb9a76b022c5627
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQh8fVkpPSh4fQ04fQhlNHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVU
	pLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=mJZ2cae3JOpeNihISaz8Dddtg6SF9p9MDXgRz2NanQ4zu7Cm0IsvhpGhTlplVK0ibc6ETt6iC+icDm7eu7jAayotD2rLRTPjpjfouGP3Iwt3DvX7YWqNXFVr7DAqjnYJ89Nw/y7ewYkL6AEt8U5nrDjcKOsQy4NSZAGOMo+Svn4=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=omVd0en5JuM5f7ZQLXdWivjaELrP2L8caSgg+mzX5P8=;
	h=date:mime-version:subject:message-id:from;

ath12k_mac_op_stop() runs with the wiphy mutex held and calls
ath12k_mac_stop(), which synchronously cancels ar->scan.timeout.
The timeout worker takes the same mutex before aborting the scan. If
the worker has started and is waiting for the mutex, stop waits for the
worker while the worker waits for the mutex, resulting in a deadlock.

Convert ar->scan.timeout to a wiphy_delayed_work. Its callback then runs
as wiphy work with the mutex held, allowing stop and other cancellation
paths to use wiphy_delayed_work_cancel() without waiting for the work
callback. The same conversion is applied to ath12k_core_halt(), which
also runs with the wiphy mutex held.

WMI event handlers call __ath12k_mac_scan_finish() while holding only
data_lock, so they cannot cancel the wiphy delayed work directly. Set
finish_queued and rely on the existing vdev_clean_wk to cancel the
timeout from wiphy context. Check finish_queued in ath12k_scan_abort()
under data_lock before changing a running scan to aborting, so a timeout
racing with completion does not abort a scan whose completion has already
queued cleanup.

Fixes: b8c67509b91ec ("wifi: ath12k: switch to using wiphy_lock() and remove ar->conf_mutex")
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
Changes in v4:
  - Rebase on Linux 7.3-rc2.
  - Rewrite the commit message and close the completion/timeout race by
    checking scan.finish_queued under data_lock.

 drivers/net/wireless/ath/ath12k/core.c |  2 +-
 drivers/net/wireless/ath/ath12k/core.h |  3 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 46 ++++++++++++++++++++++----------
 3 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 262a2045309b1f1b85a9ad2fc72cbfcd18bc0586..7290616607795365963f6d4b538575abce918b37 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1444,7 +1444,7 @@ void ath12k_core_halt(struct ath12k *ar)
 
 	ath12k_mac_scan_finish(ar);
 	ath12k_mac_peer_cleanup_all(ar);
-	cancel_delayed_work_sync(&ar->scan.timeout);
+	wiphy_delayed_work_cancel(ath12k_ar_to_hw(ar)->wiphy, &ar->scan.timeout);
 	cancel_work_sync(&ar->regd_update_work);
 	cancel_work_sync(&ar->regd_channel_update_work);
 	cancel_work_sync(&ab->rfkill_work);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index a98fc6e0699d7678ddd86bc44471fc6ff46aa22c..1f6b5547f4d90b6d5299dc2c400c0cbd89a4608d 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -628,11 +628,12 @@ struct ath12k {
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
index 99bf5cf79d10286e9959191536aecacbbf343287..0e1e9117b79fb4532ef2117715e21e1a14d3b887 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5231,7 +5231,7 @@ void __ath12k_mac_scan_finish(struct ath12k *ar)
 			ieee80211_remain_on_channel_expired(hw);
 		fallthrough;
 	case ATH12K_SCAN_STARTING:
-		cancel_delayed_work(&ar->scan.timeout);
+		ar->scan.finish_queued = true;
 		complete_all(&ar->scan.completed);
 		wiphy_work_queue(ar->ah->hw->wiphy, &ar->scan.vdev_clean_wk);
 		break;
@@ -5311,4 +5311,6 @@ static void ath12k_scan_abort(struct ath12k *ar)
 	case ATH12K_SCAN_RUNNING:
+		if (ar->scan.finish_queued)
+			break;
 		ar->scan.state = ATH12K_SCAN_ABORTING;
 		spin_unlock_bh(&ar->data_lock);
 
@@ -5323,14 +5325,17 @@ static void ath12k_scan_abort(struct ath12k *ar)
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
+	lockdep_assert_wiphy(wiphy);
 
-	wiphy_lock(ath12k_ar_to_hw(ar)->wiphy);
 	ath12k_scan_abort(ar);
-	wiphy_unlock(ath12k_ar_to_hw(ar)->wiphy);
 }
 
 static void ath12k_mac_scan_send_complete(struct ath12k *ar,
@@ -5361,6 +5370,8 @@ static void ath12k_scan_vdev_clean_work(struct wiphy *wiphy, struct wiphy_work *
 
 	arvif = ar->scan.arvif;
 
+	wiphy_delayed_work_cancel(wiphy, &ar->scan.timeout);
+
 	/* The scan vdev has already been deleted. This can occur when a
 	 * new scan request is made on the same vif with a different
 	 * frequency, causing the scan arvif to move from one radio to
@@ -5392,6 +5403,7 @@ static void ath12k_scan_vdev_clean_work(struct wiphy *wiphy, struct wiphy_work *
 	}
 
 	ar->scan.state = ATH12K_SCAN_IDLE;
+	ar->scan.finish_queued = false;
 	ar->scan_channel = NULL;
 	ar->scan.roc_freq = 0;
 	spin_unlock_bh(&ar->data_lock);
@@ -5678,6 +5690,7 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
 		reinit_completion(&ar->scan.completed);
 		ar->scan.state = ATH12K_SCAN_STARTING;
 		ar->scan.is_roc = false;
+		ar->scan.finish_queued = false;
 		ar->scan.arvif = arvif;
 		ret = 0;
 		break;
@@ -5734,6 +5747,7 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
 
 		spin_lock_bh(&ar->data_lock);
 		ar->scan.state = ATH12K_SCAN_IDLE;
+		ar->scan.finish_queued = false;
 		spin_unlock_bh(&ar->data_lock);
 		goto exit;
 	}
@@ -5741,9 +5755,10 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
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
@@ -5826,6 +5841,7 @@ int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 				spin_lock_bh(&ar->data_lock);
 				ar->scan.arvif = NULL;
 				ar->scan.state = ATH12K_SCAN_IDLE;
+				ar->scan.finish_queued = false;
 				ar->scan_channel = NULL;
 				ar->scan.roc_freq = 0;
 				spin_unlock_bh(&ar->data_lock);
@@ -5861,7 +5877,7 @@ void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
 
 		ath12k_scan_abort(ar);
 
-		cancel_delayed_work_sync(&ar->scan.timeout);
+		wiphy_delayed_work_cancel(hw->wiphy, &ar->scan.timeout);
 	}
 }
 EXPORT_SYMBOL(ath12k_mac_op_cancel_hw_scan);
@@ -10007,7 +10023,7 @@ static void ath12k_mac_stop(struct ath12k *ar)
 
 	clear_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags);
 
-	cancel_delayed_work_sync(&ar->scan.timeout);
+	wiphy_delayed_work_cancel(ath12k_ar_to_hw(ar)->wiphy, &ar->scan.timeout);
 	wiphy_work_cancel(ath12k_ar_to_hw(ar)->wiphy, &ar->scan.vdev_clean_wk);
 	cancel_work_sync(&ar->regd_channel_update_work);
 	cancel_work_sync(&ar->regd_update_work);
@@ -11024,6 +11040,7 @@ void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 			}
 
 			ar->scan.state = ATH12K_SCAN_IDLE;
+			ar->scan.finish_queued = false;
 			ar->scan_channel = NULL;
 			ar->scan.roc_freq = 0;
 			spin_unlock_bh(&ar->data_lock);
@@ -13943,7 +13960,7 @@ int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
 
 	ath12k_scan_abort(ar);
 
-	cancel_delayed_work_sync(&ar->scan.timeout);
+	wiphy_delayed_work_cancel(hw->wiphy, &ar->scan.timeout);
 	wiphy_work_flush(hw->wiphy, &ar->scan.vdev_clean_wk);
 
 	return 0;
@@ -14023,6 +14040,7 @@ int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 		reinit_completion(&ar->scan.on_channel);
 		ar->scan.state = ATH12K_SCAN_STARTING;
 		ar->scan.is_roc = true;
+		ar->scan.finish_queued = false;
 		ar->scan.arvif = arvif;
 		ar->scan.roc_freq = chan->center_freq;
 		ar->scan.roc_notify = true;
@@ -14065,6 +14083,7 @@ int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 
 		spin_lock_bh(&ar->data_lock);
 		ar->scan.state = ATH12K_SCAN_IDLE;
+		ar->scan.finish_queued = false;
 		spin_unlock_bh(&ar->data_lock);
 		return ret;
 	}
@@ -14078,8 +14097,8 @@ int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 		return -ETIMEDOUT;
 	}
 
-	ieee80211_queue_delayed_work(hw, &ar->scan.timeout,
-				     msecs_to_jiffies(duration));
+	wiphy_delayed_work_queue(hw->wiphy, &ar->scan.timeout,
+				 msecs_to_jiffies(duration));
 
 	return 0;
 }
@@ -15113,6 +15132,7 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	ar->num_tx_chains = hweight32(pdev->cap.tx_chain_mask);
 	ar->num_rx_chains = hweight32(pdev->cap.rx_chain_mask);
 	ar->scan.arvif = NULL;
+	ar->scan.finish_queued = false;
 	ar->vdev_id_11d_scan = ATH12K_11D_INVALID_VDEV_ID;
 
 	spin_lock_init(&ar->data_lock);
@@ -15138,7 +15158,7 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	ar->thermal.temperature = 0;
 	ar->thermal.hwmon_dev = NULL;
 
-	INIT_DELAYED_WORK(&ar->scan.timeout, ath12k_scan_timeout_work);
+	wiphy_delayed_work_init(&ar->scan.timeout, ath12k_scan_timeout_work);
 	wiphy_work_init(&ar->scan.vdev_clean_wk, ath12k_scan_vdev_clean_work);
 	INIT_WORK(&ar->regd_channel_update_work, ath12k_regd_update_chan_list_work);
 	INIT_LIST_HEAD(&ar->regd_channel_update_queue);
-- 
2.34.1
