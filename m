Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746888;
	b=e/V+crW4Lq89fB6JEDv5zUscEZ+KE9j9bHVcy74CVbDykPA01U29zqGaFGa7OfjEy/XG
	 y9g0yUGqD/2QSTT1mvfusMOx6owQTDhDrzBwXWd0pVBNSPxudf69Si1KwArWdtJZcL33K
	 OLoG53GuDPx4QxKwE6IhiHl968u3qZSBqy8/nOigVGiw9BDOKy3NtpNQpyBwSupheXEYY
	 DI/rb5R+XRV+kUeRhV412v63JlXo7X2oFGq/1muQKdTi9RX+JQf9T2WGvJVsO6++bOBju
	 eSjc8vbhxOElkLx76IGu4j0q1ZAqTccpotvrvfvLAAuFSuqUPj+4F4wnjEf7N2zfrBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746888;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=h0FdeRztEg1QCFC1aOzIYL7zluCbo3+kF/F1IiavlMk=;
	b=mFeTBzkn7UVZvk/8qDiR9dVtSf4HNKEpNPRQMPzEgZFUS99JYShQDb9qKqlsxrEwCYJH
	 oIi5JIcqVu2wujb+bFMt1KhLyp0URKOjVNuZDSdMh6iq2qVKgdgQlc9b1vhuehRjtqobg
	 3nB35GQ+tjxSrMORQyOlyH9eTmUIZ10JCOxGUzmDDFV2Sl4AnX9Ukf9fGAGmZ/fuGDymZ
	 lsXSyvH1ZqhZPZv2HNnEfLMcjKqxAPiQ0UmcewxXu8a22OI216JwYdGaCmDDz4YhZrfW/
	 p5wQ6ngSf21j5wYsx7UcZH/sZILaOPDkxiKZIJy5hxw9RnnHL/IG716EBuKn0MCsjhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DrGNk5uG;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9947606A31A;
	Fri, 23 Oct 2026 09:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9947606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DrGNk5uG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=h0
	FdeRztEg1QCFC1aOzIYL7zluCbo3+kF/F1IiavlMk=; b=DrGNk5uGKYBSKz+kcA
	rIa1Ho5I64GbEvOy/71cC+dNcqsd8weRNu5fHPMou2K45cQLSHWaN8/fYcTKiBow
	/cXPNx8yXnzyshCs4kYyAbOmWIEZY/hLvMDZ+ke6m7EMgwRZAHaq/M5LpxDh2rXZ
	Y7h6DTrK34evKdIEv5mSGJ5Cw=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3d3ljJdtqy8kCCA--.31461S2;
	Fri, 23 Oct 2026 17:14:15 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] wifi: mt76: mt7996: stop radios after add failure
Date: Fri, 23 Oct 2026 17:14:10 +0800
Message-Id: <20261023091410.627175-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3d3ljJdtqy8kCCA--.31461S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFWrGr4DKr4fGrW5tw1kZrb_yoW5uw1kp3
	yjka98tr17Zr95WF18Cr4jvF1rC3y8Kry3JFs5u3Z0kwn5CrZ3Jr40vF9FvF95CrWxA3Wa
	vF4kta1DWanxWFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUIDcUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8AfzLmrbJWf1LgAA3C

A multi-radio interface can start one radio before starting a later
radio fails. add_interface returns without stopping the radios started
by that failed request. It can also leave monitor mode enabled on radios
that were already running before the failed request.

mt7996_run can leave firmware radio state enabled when setup fails after
radio enablement. Disable the radio on those failures. Track radios
started by add_interface and monitor states changed by it, then roll
back both when a later radio fails to start.

Fixes: 69d54ce7491d ("wifi: mt76: mt7996: switch to single multi-radio wiphy")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---

Notes:
    Changes in v2:
    - Rebase on the current mt76 tree.
    - Handle the newly added TX power setup failure.
    - Restore monitor state on radios that were already running.

 .../net/wireless/mediatek/mt76/mt7996/main.c  | 33 ++++++++++++++++---
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 9321c8146e2a..9f1927cad5c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -24,20 +24,20 @@ int mt7996_run(struct mt7996_phy *phy)
 
 	ret = mt7996_mcu_set_chan_info(phy, UNI_CHANNEL_RX_PATH);
 	if (ret)
-		return ret;
+		goto disable_radio;
 
 	ret = mt7996_mcu_set_thermal_throttling(phy, MT7996_THERMAL_THROTTLE_MAX);
 	if (ret)
-		return ret;
+		goto disable_radio;
 
 	ret = mt7996_mcu_set_thermal_protect(phy, true);
 	if (ret)
-		return ret;
+		goto disable_radio;
 
 	ret = mt7996_mcu_set_tx_power_ctrl(phy, UNI_TXPOWER_SKU_POWER_LIMIT_CTRL,
 					   true);
 	if (ret)
-		return ret;
+		goto disable_radio;
 
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
@@ -50,6 +50,11 @@ int mt7996_run(struct mt7996_phy *phy)
 	}
 
 	return 0;
+
+disable_radio:
+	mt7996_mcu_set_radio_en(phy, false);
+
+	return ret;
 }
 
 static int mt7996_start(struct ieee80211_hw *hw)
@@ -563,6 +568,8 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct wireless_dev *wdev = ieee80211_vif_to_wdev(vif);
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	unsigned long monitor_changed = 0;
+	unsigned long started = 0;
 	int i, err = 0;
 
 	mutex_lock(&dev->mt76.mutex);
@@ -577,10 +584,14 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 			err = mt7996_run(phy);
 			if (err)
 				goto out;
+			set_bit(i, &started);
 		}
 
-		if (vif->type == NL80211_IFTYPE_MONITOR)
+		if (vif->type == NL80211_IFTYPE_MONITOR) {
+			if (phy->rxfilter & MT_WF_RFCR_DROP_OTHER_UC)
+				set_bit(i, &monitor_changed);
 			mt7996_set_monitor(phy, true);
+		}
 	}
 
 	mt76_vif_init(vif, &mvif->mt76);
@@ -590,6 +601,18 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 
 out:
 	mutex_unlock(&dev->mt76.mutex);
+	if (err) {
+		for_each_set_bit(i, &monitor_changed, MT7996_MAX_RADIOS) {
+			struct mt7996_phy *phy = dev->radio_phy[i];
+
+			mutex_lock(&dev->mt76.mutex);
+			mt7996_set_monitor(phy, false);
+			mutex_unlock(&dev->mt76.mutex);
+		}
+
+		for_each_set_bit(i, &started, MT7996_MAX_RADIOS)
+			mt7996_stop_phy(dev->radio_phy[i]);
+	}
 
 	return err;
 }
-- 
2.34.1

