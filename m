Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E830D3FA
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002041; cv=none; b=av7GK4HEjSF9X8pZdkhpZwUM6CPxd4CFeA/SxHDutuaUwQLD/fBOJ6AA+WjpO0raXK601Loo7oHT2oedNdnkdNhQD9h7SNoJNjrq7pCcGfsdn6+0Sr2+I9+gxvybxwRTtzWr1sVr6mh013suGWnW8lZ6/0iPpJ0ZFUwbPwgsSYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002041; c=relaxed/simple;
	bh=NeVTgjmZS9BAze8qph8yKXmAQfZxtsJVwgoaXeWwdWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUNsVsHeRtepanGuL2fDg/4uof/Wf6WwnoCsrfT6A5t2rzOmNwTDCKPMeg+xWzvOw6HA5U4b5YKaUp6gLLr3lkr0GG5wsFpzoAilYDIAN7D5Tv1OlgZUvHNwLw2vV9A7G+ZWzvLaMKGH5qZTzLxdRjnqwUgZ3A1+YwejKaVPN8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVQQnRhh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVQQnRhh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F60B1F000FF;
	Thu, 10 Sep 2026 01:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002040;
	bh=YBdG63pucpa8Ns9Rh1VMHwY9s6EjY36cRD1ZxhObbO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oVQQnRhhFq1vjQXdjeuMS89+gtX2NuL5Df85z6z7cA8NKd5OHW++10M3PVCj8peMm
	 tj6qtLI9m/5LbFUuK3ZjU0J/tworUMHmfY14WqB/LNp0t93cCr3Wmc1NpVh9U/zHt/
	 PpK2U6ijaaUUIXB5G/aVquLaChVEm/bRTKSCX+j0buD8APExlk5UtKt/CIwUvRkXMO
	 tOrZtBGuTVIBxcfbfeT9qb/XGxnN2MlUv4rf3tCnGAQsf4aTF3SOs4cyqtcMTXnQ8b
	 78vVjWgq5/8jJJEFogVhIBdEIWWdF+DHrDRqcDE7remvZ5B+DTsrIWr8n8h47EEw/s
	 bK4XukbR7E8uA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] mt76: rely on mt76_phy in mt76_init_sband_2g and mt76_init_sband_5g
Date: Wed,  9 Sep 2026 21:00:35 -0400
Message-ID: <20260910010037.3789515-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090448-broiling-unsworn-6960@gregkh>
References: <2026090448-broiling-unsworn-6960@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 77af762e42f1f959d8a70c17c24accc96d7ee18d ]

This is a preliminary patch to properly support mt7915 dbdc

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Stable-dep-of: bda8324270b1 ("wifi: mt76: mt7615: avoid waiting for mac work under the mt76 mutex")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 33 +++++++++----------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index dc1191aa0443e..2976aad9c80d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -168,13 +168,14 @@ void mt76_set_stream_caps(struct mt76_phy *phy, bool vht)
 EXPORT_SYMBOL_GPL(mt76_set_stream_caps);
 
 static int
-mt76_init_sband(struct mt76_dev *dev, struct mt76_sband *msband,
+mt76_init_sband(struct mt76_phy *phy, struct mt76_sband *msband,
 		const struct ieee80211_channel *chan, int n_chan,
 		struct ieee80211_rate *rates, int n_rates, bool vht)
 {
 	struct ieee80211_supported_band *sband = &msband->sband;
-	struct ieee80211_sta_ht_cap *ht_cap;
 	struct ieee80211_sta_vht_cap *vht_cap;
+	struct ieee80211_sta_ht_cap *ht_cap;
+	struct mt76_dev *dev = phy->dev;
 	void *chanlist;
 	int size;
 
@@ -204,7 +205,7 @@ mt76_init_sband(struct mt76_dev *dev, struct mt76_sband *msband,
 	ht_cap->mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
 	ht_cap->ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
 
-	mt76_init_stream_cap(&dev->phy, sband, vht);
+	mt76_init_stream_cap(phy, sband, vht);
 
 	if (!vht)
 		return 0;
@@ -222,27 +223,25 @@ mt76_init_sband(struct mt76_dev *dev, struct mt76_sband *msband,
 }
 
 static int
-mt76_init_sband_2g(struct mt76_dev *dev, struct ieee80211_rate *rates,
+mt76_init_sband_2g(struct mt76_phy *phy, struct ieee80211_rate *rates,
 		   int n_rates)
 {
-	dev->hw->wiphy->bands[NL80211_BAND_2GHZ] = &dev->phy.sband_2g.sband;
+	phy->hw->wiphy->bands[NL80211_BAND_2GHZ] = &phy->sband_2g.sband;
 
-	return mt76_init_sband(dev, &dev->phy.sband_2g,
-			       mt76_channels_2ghz,
-			       ARRAY_SIZE(mt76_channels_2ghz),
-			       rates, n_rates, false);
+	return mt76_init_sband(phy, &phy->sband_2g, mt76_channels_2ghz,
+			       ARRAY_SIZE(mt76_channels_2ghz), rates,
+			       n_rates, false);
 }
 
 static int
-mt76_init_sband_5g(struct mt76_dev *dev, struct ieee80211_rate *rates,
+mt76_init_sband_5g(struct mt76_phy *phy, struct ieee80211_rate *rates,
 		   int n_rates, bool vht)
 {
-	dev->hw->wiphy->bands[NL80211_BAND_5GHZ] = &dev->phy.sband_5g.sband;
+	phy->hw->wiphy->bands[NL80211_BAND_5GHZ] = &phy->sband_5g.sband;
 
-	return mt76_init_sband(dev, &dev->phy.sband_5g,
-			       mt76_channels_5ghz,
-			       ARRAY_SIZE(mt76_channels_5ghz),
-			       rates, n_rates, vht);
+	return mt76_init_sband(phy, &phy->sband_5g, mt76_channels_5ghz,
+			       ARRAY_SIZE(mt76_channels_5ghz), rates,
+			       n_rates, vht);
 }
 
 static void
@@ -464,13 +463,13 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 	mt76_phy_init(dev, hw);
 
 	if (phy->cap.has_2ghz) {
-		ret = mt76_init_sband_2g(dev, rates, n_rates);
+		ret = mt76_init_sband_2g(phy, rates, n_rates);
 		if (ret)
 			return ret;
 	}
 
 	if (phy->cap.has_5ghz) {
-		ret = mt76_init_sband_5g(dev, rates + 4, n_rates - 4, vht);
+		ret = mt76_init_sband_5g(phy, rates + 4, n_rates - 4, vht);
 		if (ret)
 			return ret;
 	}
-- 
2.53.0

