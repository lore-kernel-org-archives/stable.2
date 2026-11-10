Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350674;
	b=sa18VmdriTYiV2rqF0bIclICwnmQ3+Hp6Tt51TsTboZhrD2lYqdgSWaoEcv/G90CYjRB
	 Oca18vTXK1GF2RnGYWXh9cY9fmu56JkScyrUXRcSxFNwvX7ouBHxVvkbpRMZu3Kr74kF9
	 OQz7z2Qk03wX82snhvurLGQKHQEUHagiT81ipLg11AXTpUDYN3KsCRnY1Qu08JEtrIRM3
	 ZnTxmJjNE7DNUI1pznyn+hGgnj61po3/CnwWpxu/QesjU5KRV38rtaSr3CaDCh2JLZDpa
	 COVw8hP/5QsAofvlxERB/amnSAt+p1Za81/xBU0Pex+JQuRDE75nSwjWyqExel/oh2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350674;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vFnD84xzsJbpZSzjq3IWWLmQ9UPjNCr62mXf5P81X+I=;
	b=hVa5HwlCmPZIGXiig8uBrsrH2zSdvSbGjU2cqNR3eS7yDqTWOb6lMTwZq0/d0mzGB8P/
	 dco0QY6Pd+5wuU25hEH5Y6+eXAIAPiNXCx0CcFwoAAgPGtlkEKmiHYQt0I1A+f5Yju7pl
	 6bGI5mJIcwf9nWM9ff4gFgd/36PWkHhbisD1Zz9nVA2RH2MSbdYviQbwmaz1EF+Qbb7a4
	 CarT104TI4BTv7XlgyDXDDe/RccbN2rUZY2C739YxKprd9lz3uc9t0ovwGxyxAaG2LxFn
	 2t6e6vleK3N4/m4CHK3l2qV4aNs3tM1O0gHi3cMSXEh+ic9+5mkN6Rq09fih/G4rCgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HC+7savY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0F9606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HC+7savY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC171F008A2;
	Tue, 10 Nov 2026 22:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350674;
	bh=vFnD84xzsJbpZSzjq3IWWLmQ9UPjNCr62mXf5P81X+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HC+7savYtFwvNyjfAu5BfoYEXilfURCk8ZG92KugPmZAkEsP0iKZBxmL1D/K4ojDA
	 HI0+FX+d5Qop0Vm2DXAnP15WIoC+xDTw24OjIVKvI36tQudEDbnGn4XZ+pL+xwv91K
	 MNr93ByA4qRp2vTFbQx8nxFacYFHrfYS4qgQoRhA9Dnp8TdxD41UbzeJ1Dl5mk49Yh
	 H6tzUoHo7sOiWTSVPu9BqzZE19Xf1yhMZbTpMnZ7ETUbMr+kbRwJeW9dcsW1hUCauk
	 88tMj5+MWqE4QkDotWeLz3Lp6wwfEVf+IgmRetV+wFabdGkscpKYOx9fUTl4YqG0wm
	 f+GtirRUnBSrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>,
	Chris <hoopyfrood42@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] wifi: mt76: move the channel survey when the channel changes
Date: Tue, 10 Nov 2026 17:44:31 -0500
Message-ID: <20261110223343.4033618-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053231-failed-6.6-68342a7bd7e5@kernel.org>
References: <20261107053231-failed-6.6-68342a7bd7e5@kernel.org>
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
[ sashal: adapted channel survey integration to the existing main_chan field and MT7921 context layout. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c    | 14 ++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h        |  2 ++
 drivers/net/wireless/mediatek/mt76/mt7921/main.c |  1 +
 drivers/net/wireless/mediatek/mt76/mt792x_core.c |  1 +
 4 files changed, 18 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 3f09bf58130d4..379eecd09d0f0 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -945,6 +945,20 @@ void mt76_update_survey(struct mt76_phy *phy)
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
+	phy->main_chan = chandef->chan;
+	phy->chan_state = mt76_channel_state(phy, chandef->chan);
+}
+EXPORT_SYMBOL_GPL(mt76_phy_chandef_set);
+
 void mt76_set_channel(struct mt76_phy *phy)
 {
 	struct mt76_dev *dev = phy->dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 5050f640530f8..37ba676ca9038 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1297,6 +1297,8 @@ void mt76_release_buffered_frames(struct ieee80211_hw *hw,
 bool mt76_has_tx_pending(struct mt76_phy *phy);
 void mt76_set_channel(struct mt76_phy *phy);
 void mt76_update_survey(struct mt76_phy *phy);
+void mt76_phy_chandef_set(struct mt76_phy *phy,
+			  struct cfg80211_chan_def *chandef);
 void mt76_update_survey_active_time(struct mt76_phy *phy, ktime_t time);
 int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 		    struct survey_info *survey);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 8f0976e9c295e..acf54f27332f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1292,6 +1292,7 @@ static void mt7921_ctx_iter(void *priv, u8 *mac,
 		mt7921_mcu_config_sniffer(mvif, ctx);
 	else
 		mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->mt76, ctx);
+	mt76_phy_chandef_set(mvif->phy->mt76, &ctx->def);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index d990e34cfcd23..aa76ca4be33a8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -244,6 +244,7 @@ int mt792x_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	mutex_lock(&dev->mt76.mutex);
 	mvif->mt76.ctx = ctx;
+	mt76_phy_chandef_set(&dev->mphy, &ctx->def);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
-- 
2.53.0

