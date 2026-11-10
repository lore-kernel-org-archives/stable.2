Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347154;
	b=kMdsPJfCjwNyLzsar8pUz6ZHAwOG5AhF25OwHVoB+Eqglfl5QYp6VZaQubmiwKvDJaFh
	 pbgQTdRRp7kHFXodNJQgclYAcAszcyvCUljy0iWKrZk0O2zsF9+yfU7Pzq29imBpf/Tvz
	 lovG7rtZaxzbEU69uKKqak48bYuR7tbaV45Wk3uA7VscwxkxXpDvjckhwYf+U2UGO5NAy
	 +ue98fIU5Cbsd2qE0Vvvv7OUFOjfK8QEBapTOyKbGze78znQjZZMasLsa0UE6cfJsoC1E
	 5EcAAv/6phGoYRsEcx7HoTsNqtgrRc+2q+BEVQDhO7o4Bnuzrfr7uG2CsOjatIBJqZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347154;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IxzIYHVcDJ/G3u83DiqVD+kcq/D6hH3rA8mdudbIKfA=;
	b=h2jQqqVoS6EPhP6kaMnTHb6iakl+sD8P3hUf50Q9jIlE9zhg2JA3kG8hWx9+6Tfw59hW
	 YO+syMcvkUNrPlOLMxKigHF/WfXC1nrZTVkCsHig2BvdjUtxNS621V3ARUGiONzxxbQCR
	 fpwmXghJpekP5JVpQTNRRP16wtlTPk0WDFuFw2va4TyiFsakYls8xuKdmJRhHsR6jVHmP
	 CxmY+FDDjZNMBHktJVJdivXyiTL4Z5ZG3WBIVAOoxaOXAeCsBDZN2hWWLgfothD6788Og
	 IX1yTp3BgFfdIvCsHGN9c3sj0orktgrc5ZlunsvJEVEEUwVOQ9puQm/b8N+xxCVSEyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WdmeVlg5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34709606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WdmeVlg5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516631F008A6;
	Tue, 10 Nov 2026 21:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794347153;
	bh=IxzIYHVcDJ/G3u83DiqVD+kcq/D6hH3rA8mdudbIKfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WdmeVlg5ssOQWzmYH26VFEPWUzwFpDNmJDahPJBmmHdG3J24egNHDqnAuJ1UKtmKG
	 MeJhKicKOLXWzrPH4zh5Kp6rYdFYdZg0GLvjw68ShDB9TIyz/wNOCHyG9icOOYIL9u
	 7qacLSW770ppS8M+qGyyS7ChAgJrplT5tPz2ZR3Ew4p9sKondANKR4pmohG7H7H1W6
	 mYxjGPtY7JXxy/AFw+9tj1oNj55NsHaWIoi8+LCw0kzH/6U5tCvGvYv/ePPvK598Tl
	 qPXT8O/wZZfc6M7rYXKSGjC1ZXfqW2zHyaU/CuACqRKJA630qbTGfIPSalhixntBXA
	 g2QY21mBrDsuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>,
	Chris <hoopyfrood42@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] wifi: mt76: move the channel survey when the channel changes
Date: Tue, 10 Nov 2026 16:45:51 -0500
Message-ID: <20261110213540.3913326-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110213540.3913326-1-sashal@kernel.org>
References: <20261107050919-failed-6.18-68342a7bd7e5@kernel.org>
 <20261110213540.3913326-1-sashal@kernel.org>
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

From: Devin Wittmayer <lucid_duck@justthetip.ca>

[ Upstream commit 68342a7bd7e5e273e2969e3c0f4c62ee3d006ce8 ]

mt7921 and mt7925 report every survey counter against one channel and
never mark the one in use. With firmware channel management, both use
channel contexts and never call __mt76_set_channel(), so
phy->chan_state, phy->chandef and phy->main_chandef keep the first
channel of the band.

Update them when a context is assigned or changed, after booking the
time spent on the old channel. This also makes the legacy rate lookup
in mt76_connac2_mac_fill_txs() and mt7925_mac_add_txs_skb() use the
band of the current channel.

With two channel contexts (multi-channel or MLO), the survey follows
the context that was assigned or changed last, since the driver reads
the band 0 counters only.

Tested on MT7922 over PCIe, MT7921AU and MT7925 over USB.

Fixes: 41ac53c899bd ("wifi: mt76: mt7921: introduce chanctx support")
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Cc: stable@vger.kernel.org
Reported-by: Chris <hoopyfrood42@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/CAHaeJsT8O8Nhq351hFp3NAL8e0iU85N-LBdYZ9nYHFHVy7t_hQ@mail.gmail.com/
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Link: https://patch.msgid.link/20261001003501.2425492-1-lucid_duck@justthetip.ca
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c    | 14 ++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h        |  2 ++
 drivers/net/wireless/mediatek/mt76/mt7921/main.c |  1 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c |  2 ++
 drivers/net/wireless/mediatek/mt76/mt792x_core.c |  1 +
 5 files changed, 20 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 2d8cd627ef4c6..53c9cd0cfadb7 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1034,6 +1034,20 @@ void mt76_update_survey(struct mt76_phy *phy)
 }
 EXPORT_SYMBOL_GPL(mt76_update_survey);
 
+void mt76_phy_chandef_set(struct mt76_phy *phy,
+			  struct cfg80211_chan_def *chandef)
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
+EXPORT_SYMBOL_GPL(mt76_phy_chandef_set);
+
 int __mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
 		       bool offchannel)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 6ca5f3b2c6ba8..9542c4fbdee23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1531,6 +1531,8 @@ void mt76_sta_ps_transition(struct mt76_dev *dev, struct mt76_wcid *wcid,
 bool mt76_has_tx_pending(struct mt76_phy *phy);
 int mt76_update_channel(struct mt76_phy *phy);
 void mt76_update_survey(struct mt76_phy *phy);
+void mt76_phy_chandef_set(struct mt76_phy *phy,
+			  struct cfg80211_chan_def *chandef);
 void mt76_update_survey_active_time(struct mt76_phy *phy, ktime_t time);
 int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 		    struct survey_info *survey);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 1e9070a010345..26595de275bff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1411,6 +1411,7 @@ mt7921_change_chanctx(struct ieee80211_hw *hw,
 	} else {
 		mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->bss_conf.mt76, ctx);
 	}
+	mt76_phy_chandef_set(mvif->phy->mt76, &ctx->def);
 	mt792x_mutex_release(phy->dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 7c63c7f5caf3e..70068c9eb8ea8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1864,6 +1864,7 @@ mt7925_change_chanctx(struct ieee80211_hw *hw,
 						      link_conf, ctx);
 		}
 	}
+	mt76_phy_chandef_set(mvif->phy->mt76, &ctx->def);
 
 	mt792x_mutex_release(phy->dev);
 }
@@ -2176,6 +2177,7 @@ static int mt7925_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	mconf->mt76.ctx = ctx;
 	mctx->bss_conf = mconf;
+	mt76_phy_chandef_set(mvif->phy->mt76, &ctx->def);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index d00807075c71f..62c40450472af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -342,6 +342,7 @@ int mt792x_assign_vif_chanctx(struct ieee80211_hw *hw,
 	mutex_lock(&dev->mt76.mutex);
 	mvif->bss_conf.mt76.ctx = ctx;
 	mctx->bss_conf = &mvif->bss_conf;
+	mt76_phy_chandef_set(&dev->mphy, &ctx->def);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
-- 
2.53.0

