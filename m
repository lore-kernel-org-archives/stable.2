Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163851;
	b=BOlESuGmRgb3dSFQZ5cGrkNyntcrxVbO+LgmiOc9p1xKNo2jUJQhbAHueOulDKiIKQjg
	 BPgzy6X1zs+ffTyFjsMZCsfnMpmn/RK5y8JxeQy6Mxq2Rktx2a20nL09SqWQwgUeTkB9l
	 6UqwsVDLWPVYtgZl9/1mnz/aQVJ8wjUpvFstqS8yOUmyg5NeqL8LIlXbB5Vq+6tSWrtMJ
	 bKZf4IsOfjti0rTHWSZ9LcCpLwbQnR6BtYiOloR/W+XRL4CQ6F1PTDHleAWq0LXmT0/kB
	 w77bt3hIbgD/uo/o1hfTGAgVUzazFUaZa135taw9sEBgUu4yI1ituSxQ4VTQJHxMBjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163851;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=dbh6YGgR0WSkZuJ88x07QU7KuKLYyEQn9r6wPVh799M=;
	b=HVeV9wQz1XI/kx3bX+nHVKfqUwNK5MoCXUMqNOwC9VeJ6tw2TKVqarMg2H0KhIPiyy7/
	 XtwUfsjz/81E9cr3JYfhLvfjT3ds9aXnPOciYJVU3tBkSyBWnoNlJIU0BoZ7xVOVk4pJc
	 gWFbOemmEdWLfqXdqnqrQkLnmYdLc+fylKhBhtkMn29Otz8W7fnENUnYIfeBAZvuAZ4VB
	 5fEMe+7xwbZQJgS4Rmw/wfEi3oq6c/jjco6KwNAjVdaFzQOcDKkunf0DYguTHpsNA4o9p
	 QlOM18lpY1H1xoyLU0I09F6mryIGQJ/VQ89tb3q52tmCCa47EXlziDYE3MN365o/o4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=VVcrQEw9;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D19B606A337;
	Wed, 28 Oct 2026 05:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D19B606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=VVcrQEw9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=db
	h6YGgR0WSkZuJ88x07QU7KuKLYyEQn9r6wPVh799M=; b=VVcrQEw9lZffUHl8W9
	sVWxUz66zEK4SYKm0Ac0ge+8zlHe4qLYQ9iRZhSUUgRtRVKD5qCGFEzE5sGHNrY3
	7p1pmFE5JB3g1dsLQe0KfBUAWfAWBJ+7Ji7o5xoPoiNodhr2Zh2zO8z0SqlAWaxB
	Gzg7B7+55Tm1P/88Qb6VRWBjA=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3X28rguFqvXzDCw--.30877S6;
	Wed, 28 Oct 2026 13:03:44 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Deren Wu <deren.wu@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH 4/4] wifi: mt76: mt7925: unwind link restore failures
Date: Wed, 28 Oct 2026 13:03:37 +0800
Message-Id: <20261028050337.127464-5-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3X28rguFqvXzDCw--.30877S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw43CrWUJw47KFWkWr15Arb_yoW5Gw1rpa
	1DKa9IkrykJw43Ja18Ga48uFnYvan5G3WUCr13Cw1rZw1kZrn5AF4qkFy3tFyUAFWku3W8
	WFWqqrn8uwn5uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joOJ5UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRC-+WrhgjCqOAAA3w

The reset recovery callback ignores failures while restoring each link in
firmware and continues configuring the link and remaining interface. A
failed two-command device addition can leave partial firmware state, while
links restored earlier in the loop remain active on a partially restored
interface.

Track every attempted link and remove their firmware state if any restore
operation fails. Stop configuring that interface after the failure.

Fixes: 14061994184d ("wifi: mt76: mt7925: add link handling in mt7925_vif_connect_iter")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mac.c   | 26 ++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 7af996abe294..7b29e147b19e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1477,11 +1477,12 @@ mt7925_vif_connect_iter(void *priv, u8 *mac,
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	unsigned long valid = ieee80211_vif_is_mld(vif) ?
 			      mvif->valid_links : BIT(0);
+	unsigned long restored = 0;
 	struct mt792x_dev *dev = mvif->phy->dev;
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct ieee80211_bss_conf *bss_conf;
 	struct mt792x_bss_conf *mconf;
-	int i;
+	int i, ret;
 
 	if (vif->type == NL80211_IFTYPE_STATION)
 		ieee80211_disconnect(vif, true);
@@ -1493,8 +1494,13 @@ mt7925_vif_connect_iter(void *priv, u8 *mac,
 
 		mconf = mt792x_vif_to_link(mvif, i);
 
-		mt76_connac_mcu_uni_add_dev(&dev->mphy, bss_conf, &mconf->mt76,
-					    &mvif->sta.deflink.wcid, true);
+		restored |= BIT(i);
+		ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, bss_conf,
+						  &mconf->mt76,
+						 &mvif->sta.deflink.wcid, true);
+		if (ret)
+			goto rollback;
+
 		mt7925_mcu_set_tx(dev, bss_conf);
 	}
 
@@ -1506,6 +1512,20 @@ mt7925_vif_connect_iter(void *priv, u8 *mac,
 				      MT76_STA_INFO_STATE_NONE, NULL);
 		mt7925_mcu_uni_add_beacon_offload(dev, hw, vif, true);
 	}
+
+	return;
+
+rollback:
+	dev_err(dev->mt76.dev, "failed to restore link after reset: %d\n", ret);
+	for_each_set_bit(i, &restored, IEEE80211_MLD_MAX_NUM_LINKS) {
+		bss_conf = mt792x_vif_to_bss_conf(vif, i);
+		if (!bss_conf)
+			continue;
+
+		mconf = mt792x_vif_to_link(mvif, i);
+		mt76_connac_mcu_uni_add_dev(&dev->mphy, bss_conf, &mconf->mt76,
+					    &mvif->sta.deflink.wcid, false);
+	}
 }
 
 /* system error recovery */
-- 
2.34.1

