Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046161;
	b=IxEkaYHnQiuVsAK9KJ/0sW6pXHvUlsBQoNz7jPFlWRAOEhfpuOI+xA59viFFhPfY8Y44
	 qPerC2Fez40AOi/lihK/iANuLt9iugTx7pLM0cwMaZH3zdnIopuZE6SzezxWJBFt9N942
	 8GDHxlPDeD4ajlngSEBvSppuBerp9MjGo66UND38+SN1AbU0OWXd+p+1whqlHk/kv8DEy
	 QhBLM3YC50gUc2Nd++NGqrwAAWnURZp0xmLwg97Mp4tFnTxoaKl6k58GGKgnW6i389SWF
	 eBIAGLvARJZBKJVbZEC6QLSKtiWJFIVhjHVrpURPLHGp1NuZzw2EsZ3VEPwUX1MJdbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046161;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=j4tGXk+Mo2k9vZnEBKgAKywXjDLUYeiQX67KLWm5y8I=;
	b=SQsbsutPciYZ9zo03imaUMETEqajpPwh9oDpxYXs1LQJgIIUdyzXnyfJsOg8+Pz7NS+3
	 BkiRR6bYl/ENRttPJ8q2jkHU+5Opxk3wQcHIqKDMETMMogkJV1MtkLgtDf1h8eLLNfnmS
	 Mrauf+KFgCj3ZWvDuukl3bxziEcn5Ur0Y0RIav8lIxFO8RalBm8qLnm9qyJUlkRF8UPnd
	 dqRhlZKCjIHwUICmQJkm+8ntJv4L+ig1vMjyVo2k8358ufteepONPNmG4UiaEp9Voxvoe
	 ouLDLk94kihtDivnueEXVZKAVj54gvB7hVO1mp96LK1kxrRQZgvEe3cc6EHqGX9L1aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZA59HleM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9A4606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZA59HleM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D781F0089F;
	Sat,  7 Nov 2026 10:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046160;
	bh=j4tGXk+Mo2k9vZnEBKgAKywXjDLUYeiQX67KLWm5y8I=;
	h=From:To:Cc:Subject:Date;
	b=ZA59HleMJrzvcjAJQDaMC+Rzbk1XvntZJn7k71J1UgewmRGgKa3BB3sIQPkf4SpDf
	 eRQpAZiZUEwMYprgH3HV354bjUgSm6S3xExV+MA5E4mVrFNZ7taYU7tbNnOF+ckzd0
	 6eMXK4kZy5yfoAYD5/Ko/vv0a5XqhO8cOXOB9vRyEm981Co+KipwbVO5Nu6yo3fKr3
	 H29u1F8EbGBwUV7tZctDze2pp4fA6uoQsyHNQNk+rgYNegiBN5lGhTYrR5Evqy5AgY
	 M3yubVN5CoVkTaJ2RfH2MBBiuAl9cxolEJTwKK2ieuU7Tarfc6xjPwnmtLp6UJHyLS
	 8sdW4sBt2Gv9Q==
From: Sasha Levin <sashal@kernel.org>
To: lucid_duck@justthetip.ca,
	hoopyfrood42@gmail.com,
	nbd@nbd.name
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] wifi: mt76: move the channel survey when the channel changes" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:09:19 -0500
Message-ID: <20261107050919-failed-6.18-68342a7bd7e5@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 68342a7bd7e5e273e2969e3c0f4c62ee3d006ce8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050919-failed-6.18-68342a7bd7e5@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 68342a7bd7e5e273e2969e3c0f4c62ee3d006ce8 Mon Sep 17 00:00:00 2001
From: Devin Wittmayer <lucid_duck@justthetip.ca>
Date: Wed, 30 Sep 2026 17:35:01 -0700
Subject: [PATCH] wifi: mt76: move the channel survey when the channel changes

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
---
 drivers/net/wireless/mediatek/mt76/mac80211.c    | 14 ++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h        |  2 ++
 drivers/net/wireless/mediatek/mt76/mt7921/main.c |  1 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c |  2 ++
 drivers/net/wireless/mediatek/mt76/mt792x_core.c |  1 +
 5 files changed, 20 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 0e45533ea89c7..3991696515e27 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1045,6 +1045,20 @@ void mt76_update_survey(struct mt76_phy *phy)
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
index 2ade848fe3bbb..e9bbec1269fac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1555,6 +1555,8 @@ void mt76_sta_ps_transition(struct mt76_dev *dev, struct mt76_wcid *wcid,
 bool mt76_has_tx_pending(struct mt76_phy *phy);
 int mt76_update_channel(struct mt76_phy *phy);
 void mt76_update_survey(struct mt76_phy *phy);
+void mt76_phy_chandef_set(struct mt76_phy *phy,
+			  struct cfg80211_chan_def *chandef);
 void mt76_update_survey_active_time(struct mt76_phy *phy, ktime_t time);
 int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 		    struct survey_info *survey);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index d0f6460c7fd88..d041df807f615 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1421,6 +1421,7 @@ mt7921_change_chanctx(struct ieee80211_hw *hw,
 	} else {
 		mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->bss_conf.mt76, ctx);
 	}
+	mt76_phy_chandef_set(mvif->phy->mt76, &ctx->def);
 	mt792x_mutex_release(phy->dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index d124d46667071..3a5d6f51832ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -2077,6 +2077,7 @@ mt7925_change_chanctx(struct ieee80211_hw *hw,
 						      link_conf, ctx);
 		}
 	}
+	mt76_phy_chandef_set(mvif->phy->mt76, &ctx->def);
 
 	mt792x_mutex_release(phy->dev);
 }
@@ -2413,6 +2414,7 @@ static int mt7925_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	mconf->mt76.ctx = ctx;
 	mctx->bss_conf = mconf;
+	mt76_phy_chandef_set(mvif->phy->mt76, &ctx->def);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 0ad33f74c2285..f56f03bfe3874 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -472,6 +472,7 @@ int mt792x_assign_vif_chanctx(struct ieee80211_hw *hw,
 	mutex_lock(&dev->mt76.mutex);
 	mvif->bss_conf.mt76.ctx = ctx;
 	mctx->bss_conf = &mvif->bss_conf;
+	mt76_phy_chandef_set(&dev->mphy, &ctx->def);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
-- 
2.53.0




