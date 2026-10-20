Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.239.133.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792492349;
	b=4hUmFwGGZJps+/A7ztYdqQgO+duaTUmxksv7KV7kpMcsTc4lypGth+blub/KY8dawgSn
	 g8wnkI4lVBnyo7rJJLoZ5pdat8YAwd4Rc+/l3RaWBcSQZ5jummejRCPy7SnIxVhd+v5RW
	 n8n6dSXr7pr4/FW0yaq7YTlYFZe/PQZVGkOyWxsuvZLGKxGQq7Tezv8jRESXwBl5+6s04
	 acpMStQBgqRCe7APNrlsdR0YAsC95XYcxqhrE7yRJyI/47dwizbdzaqybfnc1/lYqL6Zl
	 wJzQ1C6WZdeS/+w9u5j95J8ROflwb7Y0yHU7z22a9nsFuXHXxhNozt0IR/HG+dZIqGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492349;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Authenticated-Id;
	bh=wxre4AtewTJSInxw2JUwhQj2XUPHhCudcMSclvhy3+Q=;
	b=4lvXPGHNTn+ATBiQwygdbDVVCI3gABtF5h3Hs0uMbtFXn3awoqDFUnFt9De5EBXyXBTr
	 6ws+aiEm61Df34ICZIn1B10efpShGRxw+3mAeI5VJCulTHmt3APoOI+MKvhnztcRk8IYX
	 D/bYXEmP8F/rA9NxZTAJNe11AMM45IieindtruV5o7dHCmVqHUtio8r+hZq/VG1fPPeAr
	 bnxe1ueIwLLDOIh9+A75ea6JktfZoPJUuXOvGqy/FlcFZ5kVuMFYsaT2KOzvB6/ucMz5F
	 mwyVo1wBb6S5uSEE5Gn0YdJkaQS6nK+rmtPKxP/XF3iTgDe34nQtettyY9SUYWzvLOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kubik.pl;
	spf=pass smtp.mailfrom=kubik.pl;
	arc=none smtp.remote-ip=213.239.133.37
Received: from mail-e842.seohost-mail.eu (mail-e842.seohost-mail.eu [213.239.133.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B35606A319;
	Tue, 20 Oct 2026 10:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4B35606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kubik.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kubik.pl
Received: from static-46-238-236-132.awacom.net ([46.238.236.132] helo=localhost)
	by h84.seohost.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <piotr@kubik.pl>)
	id 1xJ78l-0000000Bk51-0PQF;
	Tue, 20 Oct 2026 12:32:19 +0200
From: Piotr Kubik <piotr@kubik.pl>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	MeiChia Chiu <MeiChia.Chiu@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Piotr Kubik <piotr@kubik.pl>,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: mt76: mt7996: send no MLD group in a non-MLD link operation
Date: Tue, 20 Oct 2026 12:31:26 +0200
Message-ID: <20261020103126.46675-1-piotr@kubik.pl>
X-Mailer: git-send-email 2.55.0
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
X-Authenticated-Id: piotr@kubik.pl

The driver keeps the link of an AP after the AP stops, and it sends
the link operation again when the AP starts. The command carries the
MLD group and the remap index of the vif. Only an MLD vif gets these
indexes, so a non-MLD AP sends 0 for both. When an MLD on the same
device holds group 0 and remap 0, for example the station MLD of a
repeater, the firmware takes the address of the AP for that MLD. The
station then sends its data with the BSSID of the AP as transmitter
address, and its AP drops the station for inactivity.

Send 0xff for both indexes for a non-MLD vif, as the BSS MLD TLV of
mt7996_mcu_add_bss_info() already does.

Fixes: e7ec71d9f8fa ("wifi: mt76: mt7996: Add mcu APIs to enable/disable vif links.")
Cc: stable@vger.kernel.org
Signed-off-by: Piotr Kubik <piotr@kubik.pl>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index cd7587c..c0b467f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2701,8 +2701,13 @@ int mt7996_mcu_mld_link_oper(struct mt7996_dev *dev,
 	mld_op->link_operation = add;
 	mld_op->own_mld_id = link->mld_idx;
 	mld_op->link_id = link_conf->link_id;
-	mld_op->group_mld_id = add ? mvif->mld_group_idx : 0xff;
-	mld_op->remap_idx = add ? mvif->mld_remap_idx : 0xff;
+	if (add && ieee80211_vif_is_mld(vif)) {
+		mld_op->group_mld_id = mvif->mld_group_idx;
+		mld_op->remap_idx = mvif->mld_remap_idx;
+	} else {
+		mld_op->group_mld_id = 0xff;
+		mld_op->remap_idx = 0xff;
+	}
 	memcpy(mld_op->mac_addr, vif->addr, ETH_ALEN);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
