Received: from mta0.migadu.com (out-45.mta0.migadu.com [91.218.175.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ADF369D59
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 00:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790814917; cv=none; b=LCx10hXgAQiRqE08A7yoc6nfHBNtjIfe5a1/TMs0BuUPaY7DLL7gEfZu8uXdDqpbRMb7NEtEAGuBH+vo9Nn3uI/N/e76z4ra7kFd6SGpI/YqHGV9XQPmpPz7aeEb1ZQSHuNJqq49pka85XPLdKos05P5z2YivLq7507eGxvWQ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790814917; c=relaxed/simple;
	bh=XP0uLIKc7uD/gvJmK2M/9HInEogfnzAWga4JpZMlWrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mt6WPfPdGvizQS1l2EupdXDYnoxncsEPFERVVbhzbe2T/z6GPoNJX/bVEC6F98cySMgLJV9EKwluxF514HuFOdNVkq5sqhrRcTHeiTLwQoUIgMiMSnbQBdvojACPHA0vwmM4ptH6ztIFlSwOVpMOwHZs+r3BUEqJwPkv5pB5nMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=sGS39MCW; arc=none smtp.client-ip=91.218.175.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="sGS39MCW"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XP0uLIKc7uD/gvJmK2M/9HInEogfnzAWga4JpZMlWrI=;
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790814906; v=1; x=1791419706;
 b=sGS39MCWeBEEYsh0moZ5Aw4by4/TZympxmyGDh0xc0dLtH4n/w1lNhZP2AaM1+2r/+l9oGcb
 O+y/cuw1W+b7VkAAPBVowdKpuQnXnnoo+cYhceErmUc2lp04Vs6jyatNafnCwRskq2sPZOnVS/q
 VUnlFuLWYZyDplc1E/qIffiDVZWf99lZsuIAcKrXj09l5DB/zAjuDGi9kf5m7L+Ps929o/E9Y6w
 cOLPi6S4tqmM7H5lU8hFJLihSiq1OEldFpvL3tY5sfFYX6z7gaRu+bpwDRIRCInhZRKgIjqdcf6
 tbpX3FB3xLgUUjjn2VkGTo6poLEKCUEgaVn3zThHvtrTQ==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 92f0de8b0071edec;
	Thu, 01 Oct 2026 00:35:04 +0000
X-Mizu-Trace-ID: 92f0de8b0071edec
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Deren Wu <deren.wu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Chris <hoopyfrood42@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH wireless v2] wifi: mt76: move the channel survey when the channel changes
Date: Wed, 30 Sep 2026 17:35:01 -0700
Message-ID: <20261001003501.2425492-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt7921 and mt7925 report every survey counter against one channel and
never mark the one in use. Both use channel contexts, so the code that
moves the survey never runs.

Move it when a context is assigned or changed, after booking the time
spent on the old channel.

Tested on MT7922 over PCIe, MT7921AU and MT7925 over USB.

Fixes: 41ac53c899bd ("wifi: mt76: mt7921: introduce chanctx support")
Cc: stable@vger.kernel.org
Reported-by: Chris <hoopyfrood42@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/CAHaeJsT8O8Nhq351hFp3NAL8e0iU85N-LBdYZ9nYHFHVy7t_hQ@mail.gmail.com/

Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
v2: aim it at the wireless tree and tag it for stable. No code change.

 drivers/net/wireless/mediatek/mt76/mac80211.c   | 17 +++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h       |  2 ++
 .../net/wireless/mediatek/mt76/mt7921/main.c    |  1 +
 .../net/wireless/mediatek/mt76/mt7925/main.c    |  2 ++
 .../net/wireless/mediatek/mt76/mt792x_core.c    |  1 +
 5 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index abbe65cbcd89..fdfdb324ab98 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1045,6 +1045,23 @@ void mt76_update_survey(struct mt76_phy *phy)
 }
 EXPORT_SYMBOL_GPL(mt76_update_survey);
 
+/* For drivers that retune without __mt76_set_channel(): book the time spent
+ * on the old channel before moving the survey to the new one.
+ */
+void mt76_set_survey_channel(struct mt76_phy *phy,
+			     struct cfg80211_chan_def *chandef)
+{
+	if (!chandef->chan)
+		return;
+
+	mt76_update_survey(phy);
+
+	phy->chandef = *chandef;
+	phy->main_chandef = *chandef;
+	phy->chan_state = mt76_channel_state(phy, chandef->chan);
+}
+EXPORT_SYMBOL_GPL(mt76_set_survey_channel);
+
 int __mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
 		       bool offchannel)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 62b41c8bb7c0..2cbe9884ab46 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1548,6 +1548,8 @@ void mt76_sta_ps_transition(struct mt76_dev *dev, struct mt76_wcid *wcid,
 bool mt76_has_tx_pending(struct mt76_phy *phy);
 int mt76_update_channel(struct mt76_phy *phy);
 void mt76_update_survey(struct mt76_phy *phy);
+void mt76_set_survey_channel(struct mt76_phy *phy,
+			     struct cfg80211_chan_def *chandef);
 void mt76_update_survey_active_time(struct mt76_phy *phy, ktime_t time);
 int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 		    struct survey_info *survey);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 68a059504e83..915d6789c668 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1423,6 +1423,7 @@ mt7921_change_chanctx(struct ieee80211_hw *hw,
 	} else {
 		mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->bss_conf.mt76, ctx);
 	}
+	mt76_set_survey_channel(mvif->phy->mt76, &ctx->def);
 	mt792x_mutex_release(phy->dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 5993b31e1aae..e21bd79dcc56 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -2063,6 +2063,7 @@ mt7925_change_chanctx(struct ieee80211_hw *hw,
 						      link_conf, ctx);
 		}
 	}
+	mt76_set_survey_channel(mvif->phy->mt76, &ctx->def);
 
 	mt792x_mutex_release(phy->dev);
 }
@@ -2399,6 +2400,7 @@ static int mt7925_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	mconf->mt76.ctx = ctx;
 	mctx->bss_conf = mconf;
+	mt76_set_survey_channel(mvif->phy->mt76, &ctx->def);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 0ad33f74c228..6a0d5b2c2d59 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -472,6 +472,7 @@ int mt792x_assign_vif_chanctx(struct ieee80211_hw *hw,
 	mutex_lock(&dev->mt76.mutex);
 	mvif->bss_conf.mt76.ctx = ctx;
 	mctx->bss_conf = &mvif->bss_conf;
+	mt76_set_survey_channel(&dev->mphy, &ctx->def);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
-- 
2.55.0

