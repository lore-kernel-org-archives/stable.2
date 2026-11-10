Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348872;
	b=bdCJLDMMTe3Gm3tUAg3XGaOF/ilPPbWGj6/VIfY0rKWoUOW86oewcwjo4ATeY6N9p4C6
	 f1s3CugjCPxUszWJpU4v16l9fFo+Ns8VuZKcrNi9vOcFHZSZpHtVWJuZ/jJtrS3IrvWt3
	 MyKBNcrvLMYsNp13W22hXZHAeFCMGOmfg2UHe6USFj9rH69QakKzNNN+thQWVV95Q60aZ
	 Y44eai2nXewj295PDjMAFdN2ITktqd8VOgKSNMkUV1IerERLOg55kPNEvdgmIixxOsYlj
	 SXr3pPZA10fkegon9pEp8ZRMi5xSWBPDpSpx/wId7XaFKr4d4wZuPVIa2GS0HW256oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348872;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FQAQbSIAghiKiQQ3gHyUBjguGvXwSH2aGXODUgTh4Hs=;
	b=YhyPVZw0TW8ABWyrZBd7X/K/2y1pqBoKszgL5zaeRKnA53iuTPKg0uKTbLLUTMivA8rX
	 ctHTMxozQfxOxAQ6x1byI66lqUYiB2YZWs+gxRT9eUOGxrf67k/SIBSgo9ZwSJad9Xfhr
	 Y9LUOojjtrqrMSTg9m4o0TF90y8BvpxygyWw6Q1459NM7vGE56dyI2lovOnAPql9ixMT7
	 tpXlueUywwazp/Ax8GB0XaqIgI4U7OvOYHa3qFmTnnrxaT1rsqWOtcEzIT31QDBYSjNlz
	 mGrKfKDfM8ZMz2mQsRpO+oO0C6bbA4FJi9i8JFRFl6v4Dc8Re8QC40Hkv9KLxgp87gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGwFvihe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A04606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGwFvihe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEB61F0089F;
	Tue, 10 Nov 2026 22:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348871;
	bh=FQAQbSIAghiKiQQ3gHyUBjguGvXwSH2aGXODUgTh4Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LGwFvihef7Arkq6Ogof6Kb+kd71C1W+STt55T/qvEsCTyT1ZV4opHZqdtkBe+XXZd
	 i8wVNrCK7AxXQ2a7ZrlqN2iF6E524gD2s9rmVsy5wgdJj8MlrY8SJsezqcVXT31YEF
	 +PPDkSBZ8MOUU8tJisSzeJMbOKkoKDt8ST2LR7wD8K7pv9pjhiGLzfjyGz2RmIctp7
	 PlUcpl0YOej4S2H8uyOKWv9NZYg2GYoos9fpc6Q5QQFisOFTtDnojPdGnnLkoYYeSC
	 WJ2MGokNOyW9m8vN1ao+2inqr5AdhtxXHHYIRpMXZKPDSEUPMVnpcHZytecr0WpXRX
	 4MakTQ91nozeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Devin Wittmayer <lucid_duck@justthetip.ca>,
	Chris <hoopyfrood42@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] wifi: mt76: move the channel survey when the channel changes
Date: Tue, 10 Nov 2026 17:14:30 -0500
Message-ID: <20261110220413.3980988-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052003-failed-6.12-68342a7bd7e5@kernel.org>
References: <20261107052003-failed-6.12-68342a7bd7e5@kernel.org>
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
[ sashal: Changed phy->main_chandef = *chandef to phy->main_chan = chandef->chan. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c    | 14 ++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h        |  2 ++
 drivers/net/wireless/mediatek/mt76/mt7921/main.c |  1 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c |  2 ++
 drivers/net/wireless/mediatek/mt76/mt792x_core.c |  1 +
 5 files changed, 20 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index cd02dff7ab347..13e6594945180 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -973,6 +973,20 @@ void mt76_update_survey(struct mt76_phy *phy)
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
 int mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
 		     bool offchannel)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8addbffa97c55..d709b74159689 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1400,6 +1400,8 @@ void mt76_release_buffered_frames(struct ieee80211_hw *hw,
 bool mt76_has_tx_pending(struct mt76_phy *phy);
 int mt76_update_channel(struct mt76_phy *phy);
 void mt76_update_survey(struct mt76_phy *phy);
+void mt76_phy_chandef_set(struct mt76_phy *phy,
+			  struct cfg80211_chan_def *chandef);
 void mt76_update_survey_active_time(struct mt76_phy *phy, ktime_t time);
 int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 		    struct survey_info *survey);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 99561094640f1..18eb934da570a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1394,6 +1394,7 @@ mt7921_change_chanctx(struct ieee80211_hw *hw,
 		mt7921_mcu_config_sniffer(mvif, ctx);
 	else
 		mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->bss_conf.mt76, ctx);
+	mt76_phy_chandef_set(mvif->phy->mt76, &ctx->def);
 	mt792x_mutex_release(phy->dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 9a52607dc5a8f..dba0f48922072 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1873,6 +1873,7 @@ mt7925_change_chanctx(struct ieee80211_hw *hw,
 					     link_conf, ctx);
 		}
 	}
+	mt76_phy_chandef_set(mvif->phy->mt76, &ctx->def);
 
 	mt792x_mutex_release(phy->dev);
 }
@@ -2170,6 +2171,7 @@ static int mt7925_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	mconf->mt76.ctx = ctx;
 	mctx->bss_conf = mconf;
+	mt76_phy_chandef_set(mvif->phy->mt76, &ctx->def);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index a3ca93c9af63e..86b45807481fe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -308,6 +308,7 @@ int mt792x_assign_vif_chanctx(struct ieee80211_hw *hw,
 	mutex_lock(&dev->mt76.mutex);
 	mvif->bss_conf.mt76.ctx = ctx;
 	mctx->bss_conf = &mvif->bss_conf;
+	mt76_phy_chandef_set(&dev->mphy, &ctx->def);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
-- 
2.53.0

