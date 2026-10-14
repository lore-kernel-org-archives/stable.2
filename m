Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCC054B1A0
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988943; cv=none; b=OPEhs+ufiG5YmYMpf+PTnBdzP2rhwdsKqBTsrlWuChRuPIKdwOqeR1RTKnE+sQkBPjXg+OMZVlZ9KxNrcBzn621T5Dy3l8fj5yF8Rt7zPR3gG+YibfPphw/PlASp6x8kl5rR4mDdfaknlqiRUuIOEPHL7mDO275rjhlvf0Emjeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988943; c=relaxed/simple;
	bh=9+Z57/fT203hU9BeRxc638JVVqvFBDSFTXd4VH555I8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cv746xENIaqPxq9lLyB9dj0HqubEJHwUuej/Qj6oFWTBbzJ0wJP2jXdhgeebE7MStlawkpfEclpuWmjP+RkpYBpX/d67ZiRYKPM8A4PfGxup8rFMkJ85gYTVIwJUfLrxfTwRathW5T2DednlAdXSrWzVrCkVWjnQQW8U36u4x04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2woubX/; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2woubX/"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-154e9d2d979so931549c88.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 07:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791988939; x=1792593739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c09mXcRnV5q5H6ODDyTLkOJUZSgZHv50rgmvtfn99Wc=;
        b=V2woubX/RSyL4BW0Je5IjIMXqXbMhelrW/CD38olRh3dxlo6LDJgU2HOBI9GUPMb0e
         YiNVoGFRIa2xcmR3WcDoEarh5hhhNW+mrcwtRSjOxKqLqpxoEsQCba/oxuNm7Bgsw5r2
         qLqJpyggjh/fIX866tUPmqpeZw/dESws0F2OCLnQk0OL4xfoIP6hMNXLo8JsZL4lwf7F
         ybbjpPiDK2j5WQ/CWhiIM7K2UmBzP6y1nAa1nmDumNpzBl8u2IWeGe5A6dDkfh61DyRe
         Dz1B0Ns1UPWHnblsX6+UApBFjfbdrZ5wnINSKdxqePp5R+Wm1V4amiV9L+VRHRjCosJ0
         CBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791988939; x=1792593739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c09mXcRnV5q5H6ODDyTLkOJUZSgZHv50rgmvtfn99Wc=;
        b=yfEFjd9dCrAOqs1vD17Mjaqx6MoNTi3urXsX+UiyZy+l9Rh6vlzfZ0TuzgBSmHAmbi
         7CaOG+3lzgWDs2xjxKxNZf7dacG915l+xI2cDtWcfYymqaopNlwF4Vf56i7tNSaWV80F
         xu2b8V+8+P7lKsh+C7Tig2YbijurgHLToFWMGbwlWg8P3tMlIldol/EEZ8NT5McNoLAd
         Tbt8xmRer/7YtQYdETIvIx/w/ImEzzpIqxdJP2uUATE8rIdqQ5Yd6CavoyT/zKS3lCIa
         Ikgbcn3tGmZT9HpsxvMq1mr5L1n/vPBfWDzlBSo/aAtC1R1WHgPQgqOeatynhpRNiU44
         s7Qw==
X-Forwarded-Encrypted: i=1; AKwUvBwDAW0YZizwl6c+UBpxcfpHQIH8ZfNd2abM6s61lFnyHEpNDRGkQ19Q0zDQ3KeQrKKQeIHf5eU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMBrHeqG5TSr9KfGPL2e8XhFO0rJ1fivTkNYysMqMc50mKh8Uc
	lSaqiQMx0D15dKJFuhscrIGIHMU05sn3joB8Kb48vqbhnFbPkGbN30Su
X-Gm-Gg: AYBFou2jAAWhIp/AAZzbloUmtdDGoC+1C8I1jQPIUuYp33Im9BOcF7uB5+asHCh87Jh
	qJDykprpuSQezJ/yv4dIdy55HLc2ylUtOobEPErwlbGfoHzY9L2eSMojonDVkDyWFVm4UzzTss0
	l1L2dsGYoXrnqbOAG8x/koskdxRvAeRumxE1ZPGOPdpvyBQALiTgmAKN0aincbTZUMDCbljbvhn
	CMeedWUGPGGls+pWQbkrW0ZeSnEJ3aVGhCMFawY1pcK6FCcQwcsWOMNVK0nxJmHqaBk5clnCqyy
	WZOIjpjXZruvRcenw2SS38iPOtdsBGTGOYLkttam0Ef7nwOYALVFEKMx+KipoG1xjUNyMEh/kK6
	jBFzxjutOI+xKGqJqh13XlBXXVSljssDdrzuJQF7q41bCvVLS31V/s4mEzwZ0FobAb+YEyHDNLu
	uRED//bfZJ98HqMxzcplNNWib+McnEeA0zMaGJw1cC9R1VwatTN/HuBIVvkPUnPD9cncvZh62IT
	k0TnOvJXGQqceuwW0df4I5iVBxue3Ws1OmSt2aNZRfDZw==
X-Received: by 2002:a05:701b:280f:b0:159:f192:5290 with SMTP id a92af1059eb24-16a1206e482mr20316282c88.13.1791988938546;
        Wed, 14 Oct 2026 07:42:18 -0700 (PDT)
Received: from localhost.localdomain ([181.91.228.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1746482c978sm27641777c88.13.2026.10.14.07.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:42:17 -0700 (PDT)
From: Cristian Papa <pcristian292@gmail.com>
To: nbd@nbd.name
Cc: lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt76x02: keep stations registered during watchdog recovery
Date: Wed, 14 Oct 2026 11:42:06 -0300
Message-ID: <20261014144206.7401-1-pcristian292@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The full watchdog recovery in mt76x02_reset_state() unpublishes every
station WCID, removes it with __mt76_sta_remove() and clears its driver
data, expecting ieee80211_restart_hw() to add it back. mac80211 still
owns these stations, though, and dev->mutex is released before the
restart is requested. A station removed in that interval reaches
mt76_wcid_cleanup() with zeroed list heads:

  [   66.096357] CPU 1 Unable to handle kernel paging request at virtual address 00000000, epc == 849063c4, ra == 849063b0
  [   66.107085] Oops[#1]:
  [   66.109425] CPU: 1 UID: 0 PID: 4280 Comm: iw Tainted: G           O        6.18.44 #0 NONE
  [   66.480557] Code: 1282000d  02a02025  8e42029c <8c440000> 1684007f  8e430298  8c640004  1684007c  00000000
  [   66.496876] Kernel panic - not syncing: Fatal exception in interrupt

The faulting load is the CONFIG_LIST_HARDENED check of
list_del_init(&wcid->poll_list) in mt76_wcid_cleanup(), called from
__mt76_sta_remove() <- mt76_sta_remove() <- mt76_sta_state().

A station added in that interval is replayed by mac80211 afterwards as
well: mt76x02_sta_add() clears it again and allocates a second WCID, so
the station ends up published under two indexes, one of which leaks, and
is counted twice in phy->num_sta.

Keep the stations registered instead. During recovery, stop their RX
reorder sessions, drop and clear their hardware WCID entries and flush
them with mt76_wcid_cleanup(), which leaves the lists, queues and packet
IDR initialized. Also clear the cached TX status aggregation, so the
first status after recovery is not merged with one from before it.

When mac80211 replays a station whose WCID is still published, only
restore its hardware entry, honouring the preserved power-save state.
Count a station in mt76_sta_add() only on its initial registration, and
check for an existing publication before the driver callback, since some
drivers publish a newly allocated WCID from there.

Fixes: 004960423fe1 ("mt76: mt76x2: implement full device restart on watchdog reset")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cristian Papa <pcristian292@gmail.com>
---
Based on mt76 master 467ae2e3f190.

Testing: TP-Link Archer XR500v, MT7612E (mt76x2e), Linux 6.18.44 with
backports 7.2. A test-only module change forces a full watchdog recovery
and keeps dev->mutex for 3 s after mt76x02_reset_state(), while
`iw dev <ap> station del <sta>` removes an associated station inside
that window. The window is widened artificially; without the test change
it is much shorter, and this crash needs a recovery and a station removal
to coincide.

- mt76 master, unpatched: the router reboots with the oops above.
- mt76 master with this patch: 3/3 runs without a crash; the removed
  station reconnects and no warnings are logged.
- The same change on OpenWrt's mt76 (be5ce7910521): 4/4 crashes before,
  5/5 clean after.
- A forced recovery without a station removal does not crash, before or
  after the patch.

The orderings of recovery, removal, addition and replay were also
checked exhaustively in a host model (61 orderings): 28 fail without the
patch (crash, double publication, use-after-free, index leak, num_sta),
none with it.

AI assistance: LLM agents were used for the code analysis, the host
model and drafting. The tests ran on my hardware and I reviewed the
change.

 mac80211.c     |  6 +++++-
 mt76x02_mmio.c | 29 ++++++++++++++++-------------
 mt76x02_util.c | 14 +++++++++++++-
 3 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 41d3636..d3ea506 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1610,11 +1610,14 @@ mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
 	struct mt76_dev *dev = phy->dev;
 	struct mt76_wcid *published;
+	bool already_present;
 	int ret;
 	int i;
 
 	mutex_lock(&dev->mutex);
 
+	/* Before the driver callback: some drivers publish a new WCID there. */
+	already_present = rcu_access_pointer(dev->wcid[wcid->idx]) == wcid;
 	ret = dev->drv->sta_add(dev, vif, sta);
 	if (ret)
 		goto out;
@@ -1640,7 +1643,8 @@ mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		wcid->phy_idx = phy->band_idx;
 	}
 
-	phy->num_sta++;
+	if (!already_present)
+		phy->num_sta++;
 
 out:
 	mutex_unlock(&dev->mutex);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index dc7c03d..7392aae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -403,27 +403,30 @@ static void mt76x02_reset_state(struct mt76x02_dev *dev)
 	rcu_read_unlock();
 
 	for (i = 0; i < MT76x02_N_WCIDS; i++) {
-		struct ieee80211_sta *sta;
-		struct ieee80211_vif *vif;
 		struct mt76x02_sta *msta;
 		struct mt76_wcid *wcid;
-		void *priv;
+		int tid;
 
 		wcid = rcu_dereference_protected(dev->mt76.wcid[i],
 					lockdep_is_held(&dev->mt76.mutex));
 		if (!wcid)
 			continue;
 
-		rcu_assign_pointer(dev->mt76.wcid[i], NULL);
-
-		priv = msta = container_of(wcid, struct mt76x02_sta, wcid);
-		sta = container_of(priv, struct ieee80211_sta, drv_priv);
-
-		priv = msta->vif;
-		vif = container_of(priv, struct ieee80211_vif, drv_priv);
-
-		__mt76_sta_remove(&dev->mphy, vif, sta);
-		memset(msta, 0, sizeof(*msta));
+		/* mac80211 still owns the station and may remove it before
+		 * ieee80211_restart_hw() replays it. Keep the WCID published
+		 * and its software state initialized; only flush the station
+		 * and clear its hardware entry.
+		 */
+		for (tid = 0; tid < ARRAY_SIZE(wcid->aggr); tid++)
+			mt76_rx_aggr_stop(&dev->mt76, wcid, tid);
+
+		mt76x02_mac_wcid_set_drop(dev, wcid->idx, true);
+		mt76x02_mac_wcid_setup(dev, wcid->idx, 0, NULL);
+		mt76_wcid_cleanup(&dev->mt76, wcid);
+
+		msta = container_of(wcid, struct mt76x02_sta, wcid);
+		memset(&msta->status, 0, sizeof(msta->status));
+		msta->n_frames = 0;
 	}
 
 	dev->mt76.vif_mask = 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index e5d9d1b..21bfa20 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -241,7 +241,19 @@ int mt76x02_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt76x02_dev *dev = container_of(mdev, struct mt76x02_dev, mt76);
 	struct mt76x02_sta *msta = (struct mt76x02_sta *)sta->drv_priv;
 	struct mt76x02_vif *mvif = (struct mt76x02_vif *)vif->drv_priv;
-	int idx = 0;
+	int idx = msta->wcid.idx;
+
+	/* Recovery replays the station while it is still registered: keep
+	 * its WCID and software state, and only restore the hardware entry.
+	 */
+	if (mt76_is_mmio(mdev) &&
+	    rcu_access_pointer(mdev->wcid[idx]) == &msta->wcid) {
+		mt76x02_mac_wcid_setup(dev, idx, mvif->idx, sta->addr);
+		mt76x02_mac_wcid_set_drop(dev, idx,
+					  test_bit(MT_WCID_FLAG_PS,
+						   &msta->wcid.flags));
+		return 0;
+	}
 
 	memset(msta, 0, sizeof(*msta));
 
-- 
2.47.3

