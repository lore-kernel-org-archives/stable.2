Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=60.244.123.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153468;
	b=iZuverqhHE4PPfqpOyHJf8Af1zJjKu9Kao28htGoPxukfZ1Pp6g5a8zJdxDvIq1jywd/
	 ubb23gU7b3KS7bJFI8vAFonG3yAL1+i+3IaB7RstEGdpeg46euc6Pe8+RhgnYwqCcr9Mz
	 9cXVq2YBySYwrTlGc/Vr/64ZhZxzkDRyUNkKlA7ZaF5S0tEXTmJgGQ+ommq9siCIgqBV5
	 kEzRGa24WdiQ7jfF4FKUPGYym6NZgpqHtAcoIS2JyX7j4yX+Epm0lGNWiLc5YFc1Gjtwp
	 WhBMWcBf0uY4/LWbadyyUUPGRy7fjd4ywGzefXSYufAqDPHEYUfn7Pikbsa2+kzbt+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153468;
	h=DMARC-Filter:X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=pU84ryAqBxxtpx45yf2pYZAxb2k4EGwbTEnuyYGjFGo=;
	b=gE66nqP5RkKvP1QuovUdms++k+regExxpHAA/pV6Rion9vrGUtPfzI3HfiiX1/SC8rr7
	 TQ1IPL+D0Ol9ZpWPWi/6dHLOBcvgQexwrfoaJRKhtOa3yWQukJbqO26NdO1LxD28d+W98
	 tDCVGDPI3Fe7sO14/Ec46PO9ApY1h1yKb/qicEaatQ+ECj7OQ0+21C3G0PYmHvkB/8VMR
	 XhttQ9MxtKJnr0Po5ukAsIpGqN1TidzPoCdCDNfVubLBLpClo90UZIdp9al2aUi7Vh9Yg
	 zPZp4Q0RHUWlHhsTnzLEsgJCI0Z0HgOAGh410a+tvc541voZRouNp/kCCdJ95i0bZ7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=fFYxLP4u;
	arc=none smtp.remote-ip=60.244.123.138
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F34E606A31D;
	Wed, 28 Oct 2026 02:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F34E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=fFYxLP4u
X-UUID: d173b53ed27411f1b1788b6acf885367-20261028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pU84ryAqBxxtpx45yf2pYZAxb2k4EGwbTEnuyYGjFGo=;
	b=fFYxLP4u015j13agb72gXKhZs2+EU27QPpIgkYbrHDJ88VOKatVu5worFsioCT97HxM4PYCpDOYOHubrWmA0ujKAUKXJluDGJ1tLjF/RufQZGYAqSHqfI8YngPG5GGa5j4mElIb1SHkefVfFaFp701pjWlBrmMF+JlvKNYq1DNs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:d93af29c-c838-4c45-b46a-a1da7d3cf6cf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:291e20b,CLOUDID:5d2a0811-191d-4342-81c6-7ef97658e3d6,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d173b53ed27411f1b1788b6acf885367-20261028
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <eason.lai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1980579808; Wed, 28 Oct 2026 10:10:59 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 28 Oct 2026 10:10:58 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 28 Oct 2026 10:10:58 +0800
From: Eason Lai <eason.lai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<kun.wu@mediatek.com>, <deren.wu@mediatek.com>, <sean.wang@mediatek.com>,
	<quan.zhou@mediatek.com>, <ryder.lee@mediatek.com>, <leon.yen@mediatek.com>,
	<litien.chang@mediatek.com>, <jb.tsai@mediatek.com>,
	<lucid_duck@justthetip.ca>, <eason.lai@mediatek.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v1 2/2] wifi: mt76: free a partial rx A-MSDU when the phy is unregistered
Date: Wed, 28 Oct 2026 10:10:53 +0800
Message-ID: <20261028021053.2220951-3-eason.lai@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261028021053.2220951-1-eason.lai@mediatek.com>
References: <20261028021053.2220951-1-eason.lai@mediatek.com>
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

mt76_rx_release_burst() keeps the first subframes of an A-MSDU in
phy->rx_amsdu[q] until the last subframe arrives. If the phy or device
is unregistered in the meantime, nothing frees this skb and it leaks.

Free any parked A-MSDU after ieee80211_unregister_hw(), once rx has
stopped.

Fixes: cc4b3c139ad3 ("mt76: mt7915: enable hw rx-amsdu de-aggregation")
Signed-off-by: Eason Lai <eason.lai@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 19a2e8a26c3e..fb8494ad8f8d 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -603,6 +603,19 @@ int mt76_register_phy(struct mt76_phy *phy, bool vht,
 }
 EXPORT_SYMBOL_GPL(mt76_register_phy);
 
+static void mt76_rx_amsdu_purge(struct mt76_phy *phy)
+{
+	int q;
+
+	for (q = 0; q < ARRAY_SIZE(phy->rx_amsdu); q++) {
+		spin_lock_bh(&phy->rx_amsdu[q].lock);
+		dev_kfree_skb(phy->rx_amsdu[q].head);
+		phy->rx_amsdu[q].head = NULL;
+		phy->rx_amsdu[q].tail = NULL;
+		spin_unlock_bh(&phy->rx_amsdu[q].lock);
+	}
+}
+
 void mt76_unregister_phy(struct mt76_phy *phy)
 {
 	struct mt76_dev *dev = phy->dev;
@@ -614,6 +627,7 @@ void mt76_unregister_phy(struct mt76_phy *phy)
 		mt76_led_cleanup(phy);
 	mt76_tx_status_check(dev, true);
 	ieee80211_unregister_hw(phy->hw);
+	mt76_rx_amsdu_purge(phy);
 	dev->phys[phy->band_idx] = NULL;
 }
 EXPORT_SYMBOL_GPL(mt76_unregister_phy);
@@ -811,6 +825,7 @@ EXPORT_SYMBOL_GPL(mt76_register_device);
 void mt76_unregister_device(struct mt76_dev *dev)
 {
 	struct ieee80211_hw *hw = dev->hw;
+	int i;
 
 	if (!test_bit(MT76_STATE_REGISTERED, &dev->phy.state))
 		return;
@@ -820,6 +835,13 @@ void mt76_unregister_device(struct mt76_dev *dev)
 	mt76_tx_status_check(dev, true);
 	mt76_wcid_cleanup(dev, &dev->global_wcid);
 	ieee80211_unregister_hw(hw);
+
+	/* radio phys sharing dev->hw (e.g. mt7996) are not unregistered
+	 * separately
+	 */
+	for (i = 0; i < ARRAY_SIZE(dev->phys); i++)
+		if (dev->phys[i])
+			mt76_rx_amsdu_purge(dev->phys[i]);
 }
 EXPORT_SYMBOL_GPL(mt76_unregister_device);
 
-- 
2.45.2

