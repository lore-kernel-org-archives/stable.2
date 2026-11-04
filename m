Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.61.82.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784241;
	b=1qVhRbkePFFyUIkZB1skoJazkVlQSG29L1/25SnRZ5M7Ih1+UoovAuciio591isjVjqR
	 M5yk4vEDlvOU1EkD0W6tERL0c0K33iMGjJ+dpRxOemfiCcfcNmgOQ/fMP/GWoFSHA0sXH
	 aDe+In7wsp2Noss1J+M11NQXYQ4C8iLsXVJdti8wbe8DfzeyklMirNB5htgD+iLco0mTw
	 /jdqEvnRmHJ+qyVvtxF4lV2FzmECeIsCXJHIbQSHzOD3E2X97Jf0VZjaHDgOOkCf1iRzm
	 yA8q7vhn+BzHWuzianXwn9lyfnLLlyF8bjIW4mU2Kk77SsSKCL7I9qlCiXGmgvFrzUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784241;
	h=DMARC-Filter:X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-MTK;
	bh=Px5iYRExR1FUkSAwsUCyyip7Mo3PRTQrKEuMvrKDnRo=;
	b=eClXVF+1kt7aNI3HCmNBC+VNR1BjFCvsSyMjjovgkhv/Vp5cVAShQF+HWPV2RdAoBlB0
	 CuJMF6tmqkgIi/S8lLu5F22YrQi1fmlMxkbcCZThfPMSuQzAk2QVRLG9NjWyx2/702lEC
	 b7H15q4pdCvDyKpi4eH6RGJT29NRcsWuXZqzcWWHRnf3UU9PWAlTOh2NWkDB1sDK5nt+v
	 mNx/B1L+n+EAiHNBdq3x/3upTgGmPk4p532a8rmXwL8Sr1Az5TgMxPoGtd85cALPZgBco
	 2YE0d499E7I90Kpeg3EZ9iZruBuFJ5ILKigTMYj0S8Yx0HyMxcAlDp5lklH6icmJqFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=pIbJBTi+;
	arc=none smtp.remote-ip=210.61.82.184
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E48606A329;
	Wed,  4 Nov 2026 09:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17E48606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=pIbJBTi+
X-UUID: 73df8f02d83111f18dc8c9802ae25ab1-20261104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Px5iYRExR1FUkSAwsUCyyip7Mo3PRTQrKEuMvrKDnRo=;
	b=pIbJBTi+AD7vk5U1tnuyvpxBDC39gIXu5CT+Dk0BrAT4nGWyFqF8P8A0br5r0Ej1AWXimdogJAm6ZFZh/zMEUfYMJMjVW2f2ZFuqwZpc4rCVya+v13yNLi0ZNdGB1D02GwQVHmzGEriBun/TIUJlvy+MG24Nj9cxe9NsOIpVJas=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21,REQID:37760759-adbe-4dfa-90d4-ff1aa7054a97,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:b0318ac,CLOUDID:810925da-e88e-4ef1-b702-a0dba11ad564,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|136|836|865|888|898,TC:-5,Content:0|
	15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 73df8f02d83111f18dc8c9802ae25ab1-20261104
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 515512279; Wed, 04 Nov 2026 17:23:53 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 4 Nov 2026 17:23:52 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 4 Nov 2026 17:23:52 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Sean.Wang@mediatek.com>, <James-LY.Huang@mediatek.com>,
	<jb.tsai@mediatek.com>, Jacobs Wu <jacobs.wu@mediatek.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 9/9] wifi: mt76: mt7925: send the common scan IEs and size the request
Date: Wed, 4 Nov 2026 17:23:44 +0800
Message-ID: <20261104092344.1932406-9-jb.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261104092344.1932406-1-jb.tsai@mediatek.com>
References: <20261104092344.1932406-1-jb.tsai@mediatek.com>
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
Content-Type: text/plain
X-MTK: N

From: Jacobs Wu <jacobs.wu@mediatek.com>

mt7925_mcu_build_scan_ie_tlv() sends the per-band sets of
struct ieee80211_scan_ies but not scan_ies->common_ies. mac80211 puts
only the band capabilities, and the custom IEs that must precede them,
into the per-band sets; every other custom IE of the request, the
vendor specific elements (P2P, WPS, MBO, ...) included, goes to
common_ies. Since commit 9f8f4a51f3c1 ("wifi: mt76: mt7925: fix
incorrect scan probe IE handling for hw_scan") these IEs are missing
from the probe requests.

Send common_ies in a UNI_SCAN_IE TLV without a band: the firmware
appends such a TLV to the probe requests of every band. It keeps up to
MT76_CONNAC_SCAN_IE_LEN bytes of it, which max_scan_ie_len already
guarantees for hw_scan; sched_scan shares the TLV, so give it the same
limit instead of the IEEE80211_MAX_DATA_LEN of the connac devices that
have a sched_scan command of their own. The per-band TLVs keep carrying
the per-band sets; the firmware stores their length in a byte, so a
longer set is left out instead of being truncated.

Size the request for the IEs it carries. hw_scan reserved a fixed
sizeof(struct scan_ie_tlv) + MT76_CONNAC_SCAN_IE_LEN, which the
per-band TLVs of a request can exceed, and sched_scan reserved nothing
beyond the TLV header since struct scan_ie_tlv lost its ies[] array, so
mt76_connac_mcu_add_tlv() put the TLVs past the end of the buffer,
which skb_put() turns into a panic, whenever the kmalloc slack did not
happen to cover them. The builder now checks the tailroom of the skb
instead of a budget of its own.

Fixes: 9f8f4a51f3c1 ("wifi: mt76: mt7925: fix incorrect scan probe IE handling for hw_scan")
Cc: stable@vger.kernel.org
Signed-off-by: Jacobs Wu <jacobs.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/init.c  |   5 +
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 107 ++++++++++++------
 2 files changed, 79 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 8c3049b66a85..05305f4e1db8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -301,6 +301,11 @@ int mt7925_register_device(struct mt792x_dev *dev)
 	if (ret)
 		return ret;
 
+	/* hw_scan and sched_scan share the UNI_SCAN_IE TLV, and the firmware
+	 * keeps at most MT76_CONNAC_SCAN_IE_LEN bytes of IEs for either.
+	 */
+	hw->wiphy->max_sched_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
+
 	hw->wiphy->reg_notifier = mt7925_regd_notifier;
 	dev->mphy.sband_2g.sband.ht_cap.cap |=
 			IEEE80211_HT_CAP_LDPC_CODING |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 24de2ff3a15d..22a6338acaf1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -3347,56 +3347,99 @@ int mt7925_mcu_set_dbdc(struct mt76_phy *phy, bool enable)
 }
 EXPORT_SYMBOL_GPL(mt7925_mcu_set_dbdc);
 
+/* Room for a UNI_SCAN_IE TLV carrying ies_len bytes of IEs */
+static u32
+mt7925_mcu_scan_ie_tlv_len(struct mt76_dev *mdev, u32 ies_len)
+{
+	u32 len = sizeof(struct scan_ie_tlv) + ies_len;
+
+	if (is_mt7928(mdev))
+		len = ALIGN(len, 4);
+
+	return len;
+}
+
+/* Room for the UNI_SCAN_IE TLVs of a scan request */
+static u32
+mt7925_mcu_scan_ies_len(struct mt76_dev *mdev,
+			struct ieee80211_scan_ies *scan_ies)
+{
+	enum nl80211_band i;
+	u32 len = 0;
+
+	if (scan_ies->common_ie_len)
+		len += mt7925_mcu_scan_ie_tlv_len(mdev, scan_ies->common_ie_len);
+
+	for (i = 0; i <= NL80211_BAND_6GHZ; i++) {
+		if (i == NL80211_BAND_60GHZ || !scan_ies->len[i])
+			continue;
+
+		len += mt7925_mcu_scan_ie_tlv_len(mdev, scan_ies->len[i]);
+	}
+
+	return len;
+}
+
+static void
+mt7925_mcu_add_scan_ie_tlv(struct mt76_dev *mdev, struct sk_buff *skb,
+			   u8 band, const u8 *ies, u32 ies_len)
+{
+	u32 alloc_len = mt7925_mcu_scan_ie_tlv_len(mdev, ies_len);
+	struct scan_ie_tlv *ie;
+	struct tlv *tlv;
+
+	if (alloc_len > skb_tailroom(skb))
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_IE, alloc_len);
+	ie = (struct scan_ie_tlv *)tlv;
+
+	memcpy(ie->ies, ies, ies_len);
+	ie->ies_len = cpu_to_le16(ies_len);
+	ie->band = band;
+}
+
 static void
 mt7925_mcu_build_scan_ie_tlv(struct mt76_dev *mdev,
 			     struct sk_buff *skb,
 			     struct ieee80211_scan_ies *scan_ies)
 {
-	u32 max_len = sizeof(struct scan_ie_tlv) + MT76_CONNAC_SCAN_IE_LEN;
-	u32 ies_len, alloc_len;
-	struct scan_ie_tlv *ie;
 	enum nl80211_band i;
-	struct tlv *tlv;
-	const u8 *ies;
+
+	/* The firmware appends a TLV without a band to the probe requests
+	 * of every band: that is where the common IEs of the request go.
+	 */
+	if (scan_ies->common_ie_len)
+		mt7925_mcu_add_scan_ie_tlv(mdev, skb, 0, scan_ies->common_ies,
+					   scan_ies->common_ie_len);
 
 	for (i = 0; i <= NL80211_BAND_6GHZ; i++) {
+		u8 band;
+
 		if (i == NL80211_BAND_60GHZ)
 			continue;
 
-		ies = scan_ies->ies[i];
-		ies_len = scan_ies->len[i];
-
-		if (!ies || !ies_len)
+		if (!scan_ies->ies[i] || !scan_ies->len[i])
 			continue;
 
-		if (is_mt7928(mdev))
-			alloc_len = ALIGN(sizeof(*ie) + ies_len, 4);
-		else
-			alloc_len = sizeof(*ie) + ies_len;
-
-		if (alloc_len > max_len)
-			return;
-
-		tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_IE,
-					      alloc_len);
-		ie = (struct scan_ie_tlv *)tlv;
-
-		memcpy(ie->ies, ies, ies_len);
-		ie->ies_len = cpu_to_le16(ies_len);
+		/* The firmware keeps the length of a per-band set in a byte */
+		if (scan_ies->len[i] > U8_MAX)
+			continue;
 
 		switch (i) {
 		case NL80211_BAND_2GHZ:
-			ie->band = 1;
+			band = 1;
 			break;
 		case NL80211_BAND_6GHZ:
-			ie->band = 3;
+			band = 3;
 			break;
 		default:
-			ie->band = 2;
+			band = 2;
 			break;
 		}
 
-		max_len -= alloc_len;
+		mt7925_mcu_add_scan_ie_tlv(mdev, skb, band, scan_ies->ies[i],
+					   scan_ies->len[i]);
 	}
 }
 
@@ -3415,7 +3458,6 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	struct scan_ssid_tlv *ssid;
 	struct scan_bssid_tlv *bssid;
 	struct scan_chan_info_tlv *chan_info;
-	struct scan_ie_tlv *ie;
 	struct scan_misc_tlv *misc;
 	struct tlv *tlv;
 	int max_len;
@@ -3425,8 +3467,8 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 
 	max_len = sizeof(*hdr) + sizeof(*req) + sizeof(*ssid) +
 		  sizeof(*bssid) * MT7925_RNR_SCAN_MAX_BSSIDS +
-		  sizeof(*chan_info) + sizeof(*misc) + sizeof(*ie) +
-		  MT76_CONNAC_SCAN_IE_LEN;
+		  sizeof(*chan_info) + sizeof(*misc) +
+		  mt7925_mcu_scan_ies_len(mdev, &scan_req->ies);
 
 	skb = mt76_mcu_msg_alloc(mdev, NULL, max_len);
 	if (!skb)
@@ -3546,15 +3588,14 @@ int mt7925_mcu_sched_scan_req(struct mt76_phy *phy,
 	struct scan_sched_req *req;
 	struct scan_ssid_tlv *ssid;
 	struct scan_chan_info_tlv *chan_info;
-	struct scan_ie_tlv *ie;
 	struct scan_sched_ssid_match_sets *match;
 	struct sk_buff *skb;
 	struct tlv *tlv;
 	int i, max_len;
 
 	max_len = sizeof(*hdr) + sizeof(*req) + sizeof(*ssid) +
-		  sizeof(*chan_info) + sizeof(*ie) +
-		  sizeof(*match);
+		  sizeof(*chan_info) + sizeof(*match) +
+		  mt7925_mcu_scan_ies_len(mdev, ies);
 
 	skb = mt76_mcu_msg_alloc(mdev, NULL, max_len);
 	if (!skb)
-- 
2.45.2

