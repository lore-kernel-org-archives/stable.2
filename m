Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163853;
	b=SGPSLoYpHpqyZeDvSuRpN7OYIq4n+DPyhlhrBOlMRtpenVvaxBQul4YM2hwt12XlbOSC
	 v+T1ZrRLdu1sQVhY085gOI0btvJgSLJCT579+JwMAO0rG083n8EGGUW4ifHu1nZpm1f31
	 msE+/iHY0XmL39Re7jbXzSjPQ/hwV1qYpdhOT2RNa3aB35Q9jzQmWxbZAxxL5kqNbvJl8
	 KaKZMIkmEVUDFA9umMdTXs+maSim4SM4PA1waUMjZIVtwzyw0VXI3ZawtVJPRb30qIM6T
	 Zh27RijZmji++IQLe17+Pvdlg9OOfUTfVJgjqXvVe5EKE2zZAr5NzuDidIMaJSebROQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163853;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=dhv+8FlBddRkoW7HUJioYxqmcNV+Dawhev5ggsbsEWE=;
	b=KEg9Lt2kDZ6hh5AMnfvrupnMU0u/1zbmPZtb0DQl5KsHuwzNUoJwmjlXY9+Lj8o7b4sy
	 CUNcsDnq99NWgr2vQHSyeXO9VR2UscY253lWb1Sm+7xJkE9GHRWESt2+AU0xxtRP6Q0xh
	 iksUxQCmV1PxM+I6oA0VgcpqxsVJ2VuMRjs3zvRqxOXnvkKHrFZcoCBIRqpq+IVrm9WLC
	 vZnzJRcOtzwR4vw/hPTVDwal8yWZHRULPoLpSgpMVqOOxN5S2RTTZsYrQ7g1bP1q27VwL
	 F1lJiUCWXVlAnHLxyoXGb1aP/ZlIENyN/UfdA+L2FMiHXw5TNHwySYanHt0JwGW35Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Oad0yl4O;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9703606A327;
	Wed, 28 Oct 2026 05:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9703606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Oad0yl4O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dh
	v+8FlBddRkoW7HUJioYxqmcNV+Dawhev5ggsbsEWE=; b=Oad0yl4OirsQ5GShYM
	hygXEMibdlSmJwexZovzN75xOJNVE5doZxC38Z8aTjxrNz6sTeGdiv7uTsFFSmAU
	/RXoZBCRWbhE5V+UQn750371DT0scAjGJXQ0GaicYMaOyEn6z3wOtkW/+t+8EaDY
	fAXE2XKBEN8MxS7uWHUen29BY=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3X28rguFqvXzDCw--.30877S5;
	Wed, 28 Oct 2026 13:03:43 +0800 (CST)
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
Subject: [PATCH 3/4] wifi: mt76: mt7921: unwind interface restore failures
Date: Wed, 28 Oct 2026 13:03:36 +0800
Message-Id: <20261028050337.127464-4-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028050337.127464-1-yaojiale02@163.com>
References: <20261028050337.127464-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3X28rguFqvXzDCw--.30877S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr13tryDtFW7CrykWr1rJFb_yoW8CFW3pF
	47KayYkry8Jw45Ja1xGFW8uF95t3Z5GF1Uury3Aw18Zrn5AryrJF4j9Fy3tFyjyFs7t34f
	trWvqFn8uwsY9a7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jva0PUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQ+++Grhgi+qLAAA3k

The reset recovery callback ignores failures while restoring an interface
in firmware and continues issuing per-vif configuration commands. A failed
two-command device addition can leave partial firmware state, while the
following commands operate on an interface that was not restored.

Check the restore result, remove any partially created firmware state and
stop configuring that interface on failure.

Fixes: 0c1ce9884607 ("mt76: mt7921: add wifi reset support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 6f5e31489e2d..0d19f2d7dd5e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -628,13 +628,23 @@ mt7921_vif_connect_iter(void *priv, u8 *mac,
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_dev *dev = mvif->phy->dev;
 	struct ieee80211_hw *hw = mt76_hw(dev);
+	int ret;
 
 	if (vif->type == NL80211_IFTYPE_STATION)
 		ieee80211_disconnect(vif, true);
 
-	mt76_connac_mcu_uni_add_dev(&dev->mphy, &vif->bss_conf,
-				    &mvif->bss_conf.mt76,
-				    &mvif->sta.deflink.wcid, true);
+	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, &vif->bss_conf,
+					  &mvif->bss_conf.mt76,
+					   &mvif->sta.deflink.wcid, true);
+	if (ret) {
+		mt76_connac_mcu_uni_add_dev(&dev->mphy, &vif->bss_conf,
+					    &mvif->bss_conf.mt76,
+					    &mvif->sta.deflink.wcid, false);
+		dev_err(dev->mt76.dev,
+			"failed to restore interface after reset: %d\n", ret);
+		return;
+	}
+
 	mt7921_mcu_set_tx(dev, vif);
 
 	if (vif->type == NL80211_IFTYPE_AP) {
-- 
2.34.1

