Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB12FFF8B
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002043; cv=none; b=Wta/UnHGCYvzZy5Sv+zbxGDfFpjTIMkMKyriNSGlsWcoAeJxrJ9h0IUwwby59VLrhuGP5N877ZTqHa7m8Lg4pv1a3U4w4jjI91IMoXRCpfV2XHEcmRsoebtjqw5Oe8tBJOlxGH8aLK6cgcMINeenW6ezNw1199ym011iWxyvLIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002043; c=relaxed/simple;
	bh=k6Xaw2Yxy6vCTZreNY82EaSjzHzEt1zaOHt27evBn3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObpS+uwzHNcQxhwoRgq5IixLG5ERpGydJTmyiIV0JMct4/xBW1UcgJpGfKdsVZsLsUnTAAe4c2ZO3Hpyn4SfZWHZDyE/NhvbVOqAtKMr5ykpn4SJP+3ofjrZ2gsccB8MWeuiv6u8yliK3+CpgAYJ2naGcoBGNlIp9DRyvDTF+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGJw2D6m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGJw2D6m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8DE1F00899;
	Thu, 10 Sep 2026 01:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002041;
	bh=EmCx0RHnCW3TnNjc0zpAWsG0oo0EBqFf2QMIMimsaHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XGJw2D6m88hJJfee8wxvEDb79AWPnYPWfdj5nZUrrp4P85iSkRHbGwRJILkCZ7Lcs
	 q6jNEMKKsL6IeEkxPn2sPif3vi3JY/XCxvnd4tewRsbHJskdgDafcO/nVVCrEyRGB6
	 3zGK7TKHQXxMuBzpo6jg+XCgXu3nsM36DGZiomjdwDk5YuSDXURkR2j6LZAcD8/DVv
	 ePGKZWZdr/9G0QRfulVFEffUHMParCOq/gjnkfPbyX1rXRmZRfM2Vgunwmscql9Nuw
	 mZ9K1dSAu1QG6c76zT0y74iLhBM6XqrCzXZOdvLG9F4PD0j9cYb1CysqvCWJL4sMXe
	 Q3L+5+gSUhsbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] mt76: move mac_work in mt76_core module
Date: Wed,  9 Sep 2026 21:00:36 -0400
Message-ID: <20260910010037.3789515-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910010037.3789515-1-sashal@kernel.org>
References: <2026090448-broiling-unsworn-6960@gregkh>
 <20260910010037.3789515-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit a782f8bfdd46a6028dee41b99a990534737ad997 ]

Move mac_work delayed_work and mac_work_count in mt76_phy since it is
used by all drivers. This is a preliminary patch to create a common mcu
library used by mt7615 and mt7921 drivers

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>

Stable adaptation: retain the 5.10 device-based testmode data and API,
mt7603 tasklet_init callback, and unconditional mt7915 watchdog scheduling.
Apply the external-PHY watchdog initialization change to the existing
mt7915_register_ext_phy implementation at its stable-tree location.
No functions or newer testmode/DBDC infrastructure are added.

This keeps the MAC work relocation needed by bda8324270b1 while preserving
stable suspend helpers and beacon filtering. The target applies cleanly
with a three-way application after this dependency.

Stable-dep-of: bda8324270b1 ("wifi: mt76: mt7615: avoid waiting for mac work under the mt76 mutex")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 ++-
 .../net/wireless/mediatek/mt76/mt7603/init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/mac.c   | 14 ++++-----
 .../net/wireless/mediatek/mt76/mt7603/main.c  | 10 +++----
 .../wireless/mediatek/mt76/mt7603/mt7603.h    |  2 --
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  4 +--
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 25 ++++++++--------
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 13 +++++----
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  3 --
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   |  4 +--
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |  4 +--
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  4 +--
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  2 +-
 .../wireless/mediatek/mt76/mt76x2/pci_init.c  |  2 +-
 .../wireless/mediatek/mt76/mt76x2/pci_main.c  |  2 +-
 .../wireless/mediatek/mt76/mt76x2/usb_init.c  |  2 +-
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  4 +--
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 29 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  9 +++---
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 --
 22 files changed, 72 insertions(+), 73 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 16e65020a242d..4a71c61f25c75 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -569,6 +569,9 @@ struct mt76_phy {
 
 	int txpower_cur;
 	u8 antenna_mask;
+
+	struct delayed_work mac_work;
+	u8 mac_work_count;
 };
 
 struct mt76_dev {
@@ -609,7 +612,6 @@ struct mt76_dev {
 
 	struct mt76_worker tx_worker;
 	struct napi_struct tx_napi;
-	struct delayed_work mac_work;
 
 	wait_queue_head_t tx_wait;
 	struct sk_buff_head status_list;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index c4848fafd2705..06f3e7ef41409 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -532,7 +532,7 @@ int mt7603_register_device(struct mt7603_dev *dev)
 	spin_lock_init(&dev->sta_poll_lock);
 	spin_lock_init(&dev->ps_lock);
 
-	INIT_DELAYED_WORK(&dev->mt76.mac_work, mt7603_mac_work);
+	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7603_mac_work);
 	tasklet_init(&dev->mt76.pre_tbtt_tasklet, mt7603_pre_tbtt_tasklet,
 		     (unsigned long)dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 9eb898ebbb445..05a79715b5393 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1796,7 +1796,7 @@ mt7603_false_cca_check(struct mt7603_dev *dev)
 void mt7603_mac_work(struct work_struct *work)
 {
 	struct mt7603_dev *dev = container_of(work, struct mt7603_dev,
-					      mt76.mac_work.work);
+					      mphy.mac_work.work);
 	bool reset = false;
 	int i, idx;
 
@@ -1804,7 +1804,7 @@ void mt7603_mac_work(struct work_struct *work)
 
 	mutex_lock(&dev->mt76.mutex);
 
-	dev->mac_work_count++;
+	dev->mphy.mac_work_count++;
 	mt76_update_survey(&dev->mt76);
 	mt7603_edcca_check(dev);
 
@@ -1815,7 +1815,7 @@ void mt7603_mac_work(struct work_struct *work)
 		dev->mt76.aggr_stats[idx++] += val >> 16;
 	}
 
-	if (dev->mac_work_count == 10)
+	if (dev->mphy.mac_work_count == 10)
 		mt7603_false_cca_check(dev);
 
 	if (mt7603_watchdog_check(dev, &dev->rx_pse_check,
@@ -1846,17 +1846,17 @@ void mt7603_mac_work(struct work_struct *work)
 		dev->rx_dma_idx = ~0;
 		memset(dev->tx_dma_idx, 0xff, sizeof(dev->tx_dma_idx));
 		reset = true;
-		dev->mac_work_count = 0;
+		dev->mphy.mac_work_count = 0;
 	}
 
-	if (dev->mac_work_count >= 10)
-		dev->mac_work_count = 0;
+	if (dev->mphy.mac_work_count >= 10)
+		dev->mphy.mac_work_count = 0;
 
 	mutex_unlock(&dev->mt76.mutex);
 
 	if (reset)
 		mt7603_mac_watchdog_reset(dev);
 
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
 				     msecs_to_jiffies(MT7603_WATCHDOG_TIME));
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index bdff89cc3105e..bd4604e09a759 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -17,7 +17,7 @@ mt7603_start(struct ieee80211_hw *hw)
 	mt7603_mac_start(dev);
 	dev->mphy.survey_time = ktime_get_boottime();
 	set_bit(MT76_STATE_RUNNING, &dev->mphy.state);
-	mt7603_mac_work(&dev->mt76.mac_work.work);
+	mt7603_mac_work(&dev->mphy.mac_work.work);
 
 	return 0;
 }
@@ -28,7 +28,7 @@ mt7603_stop(struct ieee80211_hw *hw)
 	struct mt7603_dev *dev = hw->priv;
 
 	clear_bit(MT76_STATE_RUNNING, &dev->mphy.state);
-	cancel_delayed_work_sync(&dev->mt76.mac_work);
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	mt7603_mac_stop(dev);
 }
 
@@ -137,7 +137,7 @@ mt7603_set_channel(struct mt7603_dev *dev, struct cfg80211_chan_def *def)
 	u8 bw = MT_BW_20;
 	bool failed = false;
 
-	cancel_delayed_work_sync(&dev->mt76.mac_work);
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 
 	mutex_lock(&dev->mt76.mutex);
@@ -178,7 +178,7 @@ mt7603_set_channel(struct mt7603_dev *dev, struct cfg80211_chan_def *def)
 
 	mt76_txq_schedule_all(&dev->mphy);
 
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
 				     msecs_to_jiffies(MT7603_WATCHDOG_TIME));
 
 	/* reset channel stats */
@@ -200,7 +200,7 @@ mt7603_set_channel(struct mt7603_dev *dev, struct cfg80211_chan_def *def)
 	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 
 	if (failed)
-		mt7603_mac_work(&dev->mt76.mac_work.work);
+		mt7603_mac_work(&dev->mphy.mac_work.work);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 2a6e4332ad06d..d7a199007c101 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -132,8 +132,6 @@ struct mt7603_dev {
 
 	spinlock_t ps_lock;
 
-	u8 mac_work_count;
-
 	u8 mcu_running;
 
 	u8 ed_monitor_enabled;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index e194259c84e90..902750ea7e0bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -408,7 +408,7 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	mphy->antenna_mask = BIT(hweight8(phy->chainmask)) - 1;
 	mt7615_init_wiphy(mphy->hw);
 
-	INIT_DELAYED_WORK(&phy->mac_work, mt7615_mac_work);
+	INIT_DELAYED_WORK(&mphy->mac_work, mt7615_mac_work);
 	INIT_DELAYED_WORK(&phy->scan_work, mt7615_scan_work);
 	skb_queue_head_init(&phy->scan_event_list);
 
@@ -464,7 +464,7 @@ void mt7615_init_device(struct mt7615_dev *dev)
 	init_completion(&dev->pm.wake_cmpl);
 	spin_lock_init(&dev->pm.txq_lock);
 	set_bit(MT76_STATE_PM, &dev->mphy.state);
-	INIT_DELAYED_WORK(&dev->phy.mac_work, mt7615_mac_work);
+	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7615_mac_work);
 	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7615_scan_work);
 	skb_queue_head_init(&dev->phy.scan_event_list);
 	INIT_LIST_HEAD(&dev->sta_poll_list);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 0c9201e073b27..519a6ffd21195 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -2015,17 +2015,17 @@ int mt7615_pm_set_enable(struct mt7615_dev *dev, bool enable)
 void mt7615_mac_work(struct work_struct *work)
 {
 	struct mt7615_phy *phy;
-	struct mt76_dev *mdev;
+	struct mt76_phy *mphy;
 
-	phy = (struct mt7615_phy *)container_of(work, struct mt7615_phy,
-						mac_work.work);
-	mdev = &phy->dev->mt76;
+	mphy = (struct mt76_phy *)container_of(work, struct mt76_phy,
+					       mac_work.work);
+	phy = mphy->priv;
 
 	mt7615_mutex_acquire(phy->dev);
 
 	mt7615_update_survey(phy->dev);
-	if (++phy->mac_work_count == 5) {
-		phy->mac_work_count = 0;
+	if (++mphy->mac_work_count == 5) {
+		mphy->mac_work_count = 0;
 
 		mt7615_mac_update_mib_stats(phy);
 		mt7615_mac_scs_check(phy);
@@ -2033,8 +2033,8 @@ void mt7615_mac_work(struct work_struct *work)
 
 	mt7615_mutex_release(phy->dev);
 
-	mt76_tx_status_check(mdev, NULL, false);
-	ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mac_work,
+	mt76_tx_status_check(mphy->dev, NULL, false);
+	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
 				     MT7615_WATCHDOG_TIME);
 }
 
@@ -2137,11 +2137,11 @@ void mt7615_mac_reset_work(struct work_struct *work)
 	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
-	cancel_delayed_work_sync(&dev->phy.mac_work);
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	del_timer_sync(&dev->phy.roc_timer);
 	cancel_work_sync(&dev->phy.roc_work);
 	if (phy2) {
-		cancel_delayed_work_sync(&phy2->mac_work);
+		cancel_delayed_work_sync(&phy2->mt76->mac_work);
 		del_timer_sync(&phy2->roc_timer);
 		cancel_work_sync(&phy2->roc_work);
 	}
@@ -2196,10 +2196,11 @@ void mt7615_mac_reset_work(struct work_struct *work)
 
 	mt7615_mutex_release(dev);
 
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->phy.mac_work,
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
 				     MT7615_WATCHDOG_TIME);
 	if (phy2)
-		ieee80211_queue_delayed_work(ext_phy->hw, &phy2->mac_work,
+		ieee80211_queue_delayed_work(ext_phy->hw,
+					     &phy2->mt76->mac_work,
 					     MT7615_WATCHDOG_TIME);
 
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index defa207f53d6f..c67ac255059d9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -70,7 +70,7 @@ static int mt7615_start(struct ieee80211_hw *hw)
 
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
-	ieee80211_queue_delayed_work(hw, &phy->mac_work,
+	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
 				     MT7615_WATCHDOG_TIME);
 
 	if (!running)
@@ -86,7 +86,7 @@ static void mt7615_stop(struct ieee80211_hw *hw)
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 
-	cancel_delayed_work_sync(&phy->mac_work);
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
 	del_timer_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 
@@ -293,7 +293,7 @@ int mt7615_set_channel(struct mt7615_phy *phy)
 	bool ext_phy = phy != &dev->phy;
 	int ret;
 
-	cancel_delayed_work_sync(&phy->mac_work);
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
 	mt7615_mutex_acquire(dev);
 
@@ -328,7 +328,8 @@ int mt7615_set_channel(struct mt7615_phy *phy)
 	mt76_txq_schedule_all(phy->mt76);
 
 	if (!mt76_testmode_enabled(&dev->mt76))
-		ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mac_work,
+		ieee80211_queue_delayed_work(phy->mt76->hw,
+					     &phy->mt76->mac_work,
 					     MT7615_WATCHDOG_TIME);
 
 	return ret;
@@ -1146,7 +1147,7 @@ static int mt7615_suspend(struct ieee80211_hw *hw,
 
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 	cancel_delayed_work_sync(&phy->scan_work);
-	cancel_delayed_work_sync(&phy->mac_work);
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
 	mt76_set(dev, MT_WF_RFCR(ext_phy), MT_WF_RFCR_DROP_OTHER_BEACON);
 
@@ -1189,7 +1190,7 @@ static int mt7615_resume(struct ieee80211_hw *hw)
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7615_mcu_set_suspend_iter, phy);
 
-	ieee80211_queue_delayed_work(hw, &phy->mac_work,
+	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
 				     MT7615_WATCHDOG_TIME);
 	mt76_clear(dev, MT_WF_RFCR(ext_phy), MT_WF_RFCR_DROP_OTHER_BEACON);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 4cee76691786e..7489c2147cc82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -201,9 +201,6 @@ struct mt7615_phy {
 
 	struct mib_stats mib;
 
-	struct delayed_work mac_work;
-	u8 mac_work_count;
-
 	struct sk_buff_head scan_event_list;
 	struct delayed_work scan_work;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index f0ad83af9e004..484c184f038ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -29,7 +29,7 @@ static void mt7663u_stop(struct ieee80211_hw *hw)
 	del_timer_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 	cancel_delayed_work_sync(&phy->scan_work);
-	cancel_delayed_work_sync(&phy->mac_work);
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
 	mt76u_stop_tx(&dev->mt76);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index b87d8e136cb9a..02d0aa0b815e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -16,7 +16,7 @@ static int mt76x0e_start(struct ieee80211_hw *hw)
 
 	mt76x02_mac_start(dev);
 	mt76x0_phy_calibrate(dev, true);
-	ieee80211_queue_delayed_work(dev->mt76.hw, &dev->mt76.mac_work,
+	ieee80211_queue_delayed_work(dev->mt76.hw, &dev->mphy.mac_work,
 				     MT_MAC_WORK_INTERVAL);
 	ieee80211_queue_delayed_work(dev->mt76.hw, &dev->cal_work,
 				     MT_CALIBRATE_INTERVAL);
@@ -28,7 +28,7 @@ static int mt76x0e_start(struct ieee80211_hw *hw)
 static void mt76x0e_stop_hw(struct mt76x02_dev *dev)
 {
 	cancel_delayed_work_sync(&dev->cal_work);
-	cancel_delayed_work_sync(&dev->mt76.mac_work);
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	clear_bit(MT76_RESTART, &dev->mphy.state);
 
 	if (!mt76_poll(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_TX_DMA_BUSY,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index ce6b286a81528..f919b65be08e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -82,7 +82,7 @@ static void mt76x0u_stop(struct ieee80211_hw *hw)
 
 	clear_bit(MT76_STATE_RUNNING, &dev->mphy.state);
 	cancel_delayed_work_sync(&dev->cal_work);
-	cancel_delayed_work_sync(&dev->mt76.mac_work);
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	mt76u_stop_tx(&dev->mt76);
 	mt76x02u_exit_beacon_config(dev);
 
@@ -108,7 +108,7 @@ static int mt76x0u_start(struct ieee80211_hw *hw)
 		return ret;
 
 	mt76x0_phy_calibrate(dev, true);
-	ieee80211_queue_delayed_work(dev->mt76.hw, &dev->mt76.mac_work,
+	ieee80211_queue_delayed_work(dev->mt76.hw, &dev->mphy.mac_work,
 				     MT_MAC_WORK_INTERVAL);
 	ieee80211_queue_delayed_work(dev->mt76.hw, &dev->cal_work,
 				     MT_CALIBRATE_INTERVAL);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 677082d8659a6..2417418382351 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -1163,7 +1163,7 @@ static void mt76x02_edcca_check(struct mt76x02_dev *dev)
 void mt76x02_mac_work(struct work_struct *work)
 {
 	struct mt76x02_dev *dev = container_of(work, struct mt76x02_dev,
-					       mt76.mac_work.work);
+					       mphy.mac_work.work);
 	int i, idx;
 
 	mutex_lock(&dev->mt76.mutex);
@@ -1186,7 +1186,7 @@ void mt76x02_mac_work(struct work_struct *work)
 
 	mt76_tx_status_check(&dev->mt76, NULL, false);
 
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
 				     MT_MAC_WORK_INTERVAL);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 0f191bd28417c..ca28bb0c744d9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -149,7 +149,7 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct wiphy *wiphy = hw->wiphy;
 
-	INIT_DELAYED_WORK(&dev->mt76.mac_work, mt76x02_mac_work);
+	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt76x02_mac_work);
 
 	hw->queues = 4;
 	hw->max_rates = 1;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
index 48a3ebc9892a9..4d35c3b793735 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
@@ -271,7 +271,7 @@ static int mt76x2_init_hardware(struct mt76x02_dev *dev)
 void mt76x2_stop_hardware(struct mt76x02_dev *dev)
 {
 	cancel_delayed_work_sync(&dev->cal_work);
-	cancel_delayed_work_sync(&dev->mt76.mac_work);
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	cancel_delayed_work_sync(&dev->wdt_work);
 	clear_bit(MT76_RESTART, &dev->mphy.state);
 	mt76x02_mcu_set_radio_state(dev, false);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index 98f4cf3983207..93fa3f644bb87 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -14,7 +14,7 @@ mt76x2_start(struct ieee80211_hw *hw)
 	mt76x02_mac_start(dev);
 	mt76x2_phy_start(dev);
 
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
 				     MT_MAC_WORK_INTERVAL);
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->wdt_work,
 				     MT_WATCHDOG_TIME);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
index c845e83897659..41b9a99665822 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
@@ -247,7 +247,7 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
 void mt76x2u_stop_hw(struct mt76x02_dev *dev)
 {
 	cancel_delayed_work_sync(&dev->cal_work);
-	cancel_delayed_work_sync(&dev->mt76.mac_work);
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	mt76x2u_mac_stop(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index bab4e6e1904ea..b66836928d9dc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -15,7 +15,7 @@ static int mt76x2u_start(struct ieee80211_hw *hw)
 	if (ret)
 		return ret;
 
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
 				     MT_MAC_WORK_INTERVAL);
 	set_bit(MT76_STATE_RUNNING, &dev->mphy.state);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 99683688a8363..72854de6e3d26 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -618,7 +618,7 @@ int mt7915_register_ext_phy(struct mt7915_dev *dev)
 	mt7915_init_wiphy(mphy->hw);
 
 	INIT_LIST_HEAD(&phy->stats_list);
-	INIT_DELAYED_WORK(&phy->mac_work, mt7915_mac_work);
+	INIT_DELAYED_WORK(&mphy->mac_work, mt7915_mac_work);
 
 	/*
 	 * Make the secondary PHY MAC address local without overlapping with
@@ -660,7 +660,7 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	dev->mt76.phy.priv = &dev->phy;
 	INIT_LIST_HEAD(&dev->phy.stats_list);
 	INIT_WORK(&dev->rc_work, mt7915_mac_sta_rc_work);
-	INIT_DELAYED_WORK(&dev->phy.mac_work, mt7915_mac_work);
+	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7915_mac_work);
 	INIT_LIST_HEAD(&dev->sta_rc_list);
 	INIT_LIST_HEAD(&dev->sta_poll_list);
 	spin_lock_init(&dev->sta_poll_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 1e14d7782841e..8e73b62acfccf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1209,9 +1209,9 @@ void mt7915_mac_reset_work(struct work_struct *work)
 	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
-	cancel_delayed_work_sync(&dev->phy.mac_work);
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	if (phy2)
-		cancel_delayed_work_sync(&phy2->mac_work);
+		cancel_delayed_work_sync(&phy2->mt76->mac_work);
 
 	/* lock/unlock all queues to ensure that no tx is pending */
 	mt76_txq_schedule_all(&dev->mphy);
@@ -1262,10 +1262,11 @@ void mt7915_mac_reset_work(struct work_struct *work)
 
 	mt7915_update_beacons(dev);
 
-	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->phy.mac_work,
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
 				     MT7915_WATCHDOG_TIME);
 	if (phy2)
-		ieee80211_queue_delayed_work(ext_phy->hw, &phy2->mac_work,
+		ieee80211_queue_delayed_work(ext_phy->hw,
+					     &phy2->mt76->mac_work,
 					     MT7915_WATCHDOG_TIME);
 }
 
@@ -1367,17 +1368,17 @@ void mt7915_mac_sta_rc_work(struct work_struct *work)
 void mt7915_mac_work(struct work_struct *work)
 {
 	struct mt7915_phy *phy;
-	struct mt76_dev *mdev;
+	struct mt76_phy *mphy;
 
-	phy = (struct mt7915_phy *)container_of(work, struct mt7915_phy,
-						mac_work.work);
-	mdev = &phy->dev->mt76;
+	mphy = (struct mt76_phy *)container_of(work, struct mt76_phy,
+					       mac_work.work);
+	phy = mphy->priv;
 
-	mutex_lock(&mdev->mutex);
+	mutex_lock(&mphy->dev->mutex);
 
-	mt76_update_survey(mdev);
-	if (++phy->mac_work_count == 5) {
-		phy->mac_work_count = 0;
+	mt76_update_survey(mphy->dev);
+	if (++mphy->mac_work_count == 5) {
+		mphy->mac_work_count = 0;
 
 		mt7915_mac_update_mib_stats(phy);
 	}
@@ -1387,9 +1388,9 @@ void mt7915_mac_work(struct work_struct *work)
 		mt7915_mac_sta_stats_work(phy);
 	};
 
-	mutex_unlock(&mdev->mutex);
+	mutex_unlock(&mphy->dev->mutex);
 
-	ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mac_work,
+	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
 				     MT7915_WATCHDOG_TIME);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 6495d2edf7dc4..3bfeddd1cf23d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -47,7 +47,7 @@ static int mt7915_start(struct ieee80211_hw *hw)
 
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
-	ieee80211_queue_delayed_work(hw, &phy->mac_work,
+	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
 				     MT7915_WATCHDOG_TIME);
 
 	if (!running)
@@ -63,7 +63,7 @@ static void mt7915_stop(struct ieee80211_hw *hw)
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 
-	cancel_delayed_work_sync(&phy->mac_work);
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
 	mutex_lock(&dev->mt76.mutex);
 
@@ -227,7 +227,7 @@ static int mt7915_set_channel(struct mt7915_phy *phy)
 	struct mt7915_dev *dev = phy->dev;
 	int ret;
 
-	cancel_delayed_work_sync(&phy->mac_work);
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
 	mutex_lock(&dev->mt76.mutex);
 	set_bit(MT76_RESET, &phy->mt76->state);
@@ -251,7 +251,8 @@ static int mt7915_set_channel(struct mt7915_phy *phy)
 	mutex_unlock(&dev->mt76.mutex);
 
 	mt76_txq_schedule_all(phy->mt76);
-	ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mac_work,
+	ieee80211_queue_delayed_work(phy->mt76->hw,
+				     &phy->mt76->mac_work,
 				     MT7915_WATCHDOG_TIME);
 
 	return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index c84110e34ede1..89921b6db2710 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -130,8 +130,6 @@ struct mt7915_phy {
 	struct mib_stats mib;
 	struct list_head stats_list;
 
-	struct delayed_work mac_work;
-	u8 mac_work_count;
 	u8 sta_work_count;
 };
 
-- 
2.53.0

