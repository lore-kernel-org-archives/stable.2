Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CA924A078;
	Fri,  3 Jul 2026 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783058876; cv=none; b=X3s/Wnx+BOLEZQoKdArhm3cR9t39hOtOPZB35baegb8OljgWwLenB9ek+3Anex64FyRSDbvFyVmKuwviGuO547cjIUS8qxUW3f9WmhckWg1e4lySaCPymzudk6Tud7j7MgBFhSycmsaPYY4XJBcWXxRRPX2CdGO3N+2klXF90VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783058876; c=relaxed/simple;
	bh=6FlYfQN1UOSeRESpTusWClmF3MQ6REC3pfVy+Velra0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pWFH6c1ujqY0sDfsbOtxsT/iB+fQ3yFxgGzGwMDiBS7kG6apM2P2PHpy9XCKHywqeHF+96T5DfFo0HDoJOoTDuj9WbrfoqaS1PxJptsZmNfUO9558gqIhkIqdi8YLgCu9vAAk17C5nc6o8bfxzIpUJu6WnqRaT4D9bm3bgzKa80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=PA6+wwdd; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="PA6+wwdd"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 44c2aee32;
	Fri, 3 Jul 2026 14:02:32 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Wen Gong <quic_wgong@quicinc.com>,
	Carl Huang <quic_cjhuang@quicinc.com>,
	Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
	P Praneesh <quic_ppranees@quicinc.com>,
	Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2 ath-current] wifi: ath12k: avoid flushing scan timeout under the wiphy lock
Date: Fri,  3 Jul 2026 14:02:19 +0800
Message-Id: <20260703060219.2998148-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f2692561303a1kunm8b79284b267b6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTEwfVhoeT0tCSB9LS0tLGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=PA6+wwddAlFfYNDLvDiyuDnCF83FhOsXPDZo5caFThSqJOK2VVZCNfC7RS5cKXl9mEYJodTKIET2Jyn8pCAL08JGiCVhlVv5/Xrg58ahLQ3qT9kXYoNzXGtAiInoC58olsElJQrm0idUvNhVWinpBs6z7Pk+AmZ+uAEQidcM/ms=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=gImCEmtMsWutE6Xcg5AbO+j7S75qhJcqK6Q0eqEnk5c=;
	h=date:mime-version:subject:message-id:from;

ath12k_mac_op_stop() is called with the wiphy lock held. It then takes
ah->hw_mutex and calls ath12k_mac_stop(), which synchronously cancels
ar->scan.timeout.

That can deadlock if the delayed work has started. The timeout worker
ath12k_scan_timeout_work() takes the same wiphy lock before aborting the
scan, so stop waits for a worker that cannot make progress until the
wiphy lock is released.

Drain ar->scan.timeout before entering the locked stop teardown, and
remove the synchronous cancel from ath12k_mac_stop(). This preserves the
stop-time drain while avoiding the wait-under-wiphy lock ordering.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
Changes in v2:
  - Rebase on ath.git ath-current.
  - Use ath-current subject tag as requested.
  - Move the synchronous scan timeout drain out of the locked stop path
    instead of adding it in the wrong start-path context.
  - Update Fixes to the ath12k commit that introduced the stop-time
    scan.timeout drain.

 drivers/net/wireless/ath/ath12k/mac.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index af354bef5c0d..6da9a2bda9fe 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9931,7 +9931,6 @@ static void ath12k_mac_stop(struct ath12k *ar)
 
 	clear_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags);
 
-	cancel_delayed_work_sync(&ar->scan.timeout);
 	wiphy_work_cancel(ath12k_ar_to_hw(ar)->wiphy, &ar->scan.vdev_clean_wk);
 	cancel_work_sync(&ar->regd_channel_update_work);
 	cancel_work_sync(&ar->regd_update_work);
@@ -9975,6 +9974,15 @@ void ath12k_mac_op_stop(struct ieee80211_hw *hw, bool suspend)
 
 	lockdep_assert_wiphy(hw->wiphy);
 
+	/*
+	 * scan.timeout takes the wiphy lock before aborting the scan, so do
+	 * not wait for it from the locked stop path below.
+	 */
+	wiphy_unlock(hw->wiphy);
+	for_each_ar(ah, ar, i)
+		cancel_delayed_work_sync(&ar->scan.timeout);
+	wiphy_lock(hw->wiphy);
+
 	ath12k_drain_tx(ah);
 
 	mutex_lock(&ah->hw_mutex);
-- 
2.34.1
