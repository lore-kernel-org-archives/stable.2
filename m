Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.61.82.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953816;
	b=fNTrkOi5VS0xO0Oj7ZA03H5nqqoj4G1LJ40Cjyq1lHBxjJB2v2K8MIqGGv/m1d1EHTzY
	 26vApG8wd4EdA1jHbnk36i7JrDVuOciTc/vjobPPuJoxOIxPgPk+j6O/+OEp5G+XESqR0
	 8oWX55F0LaRu9LHScFA4Zc5b/biPN0phEIe1FqvTrV/FYUZBnmRW0U80jQQo5HYDhiIxE
	 KDfewDWh1rq2dk/+THy7QSHWuGyBexJ15afWGWNbFeJaSqaoS4s99GJEdFZMLCK0EyCgA
	 dZnFLLFuTAfhXKo+pILhVXrAXjF6cA7BNhc3CCXzIKSVG4hs8BNzCOe5n8s1Mu66XMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953816;
	h=DMARC-Filter:X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-MTK;
	bh=J5WkbCyWET3mP0lGp2C+rKGBoikF2s1awaOWTUy2kgQ=;
	b=Ue9cRdboUAp8bsaNheH74MlQMs2WnOAaApP+Dx1XwoKT+xPsSZc5URHI8Ma44xfGCHRU
	 sxGh1RVdRpmXmtw92ZlNKfyAt88yH8ZoBYhmpTyWoO5WV53/Dhe4l288+7lz6i+CBsd3h
	 yeO/4jZswdwnfRr1mhndPQ6ZJ/R4GjJ8ohXkw3lbLuNNU0TVv+ELu9kJZRrfmhjeVF5uF
	 yJUkcNc25mO2dqUYHOAys939HcSRnn53ajk98ND94N6NON3vOYgArX9Qn2XbDB+YATYMl
	 LNwDgY5vwqHMwlXs6AvHwR5a0v4KdlMIX0vFuRsKPkg9rIlm0pN375tkjBdbB2x71mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=d49uQ2lX;
	arc=none smtp.remote-ip=210.61.82.184
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B9F606A333;
	Fri,  6 Nov 2026 08:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29B9F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=d49uQ2lX
X-UUID: 4796feeed9bc11f18dc8c9802ae25ab1-20261106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=J5WkbCyWET3mP0lGp2C+rKGBoikF2s1awaOWTUy2kgQ=;
	b=d49uQ2lXdL95KFoL6Qfejfs0PkKswiSs9wpStau/7unWkFPygcUlEq8CU+wSw8IWBMv/wvISmKmlJzRGKI7hupnq+bfFyPOs8XbzfLMxxguhBeukftpfgO6QOk48zLLFsmD3InWabfSFEh5rlal7/oDh5RPWnImCkVsoE4QWxhA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21,REQID:f1e82809-62df-4134-8aa9-82b60e3bcca6,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:b0318ac,CLOUDID:47e574bb-4006-44bb-949c-6e25a7b8dad4,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|136|836|865|888|898,TC:-5,Content:0|
	15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4796feeed9bc11f18dc8c9802ae25ab1-20261106
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <james-ly.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1057213204; Fri, 06 Nov 2026 16:30:10 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 6 Nov 2026 16:30:10 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 6 Nov 2026 16:30:10 +0800
From: James-LY Huang <james-ly.huang@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<sean.wang@mediatek.com>, <jb.tsai@mediatek.com>, <kun.wu@mediatek.com>,
	<James-LY.Huang@mediatek.com>, Jacobs Wu <jacobs.wu@mediatek.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v2 9/9] wifi: mt76: mt7925: send the common scan IEs and size the request
Date: Fri, 6 Nov 2026 16:30:04 +0800
Message-ID: <20261106083004.3156085-10-james-ly.huang@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261106083004.3156085-1-james-ly.huang@mediatek.com>
References: <20261106083004.3156085-1-james-ly.huang@mediatek.com>
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
v2: no change
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

