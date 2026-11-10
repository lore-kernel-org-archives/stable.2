Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.61.82.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280412;
	b=EbpKluK3O1Lt1eGo9wHuv/z5C24Ze0oA3C+GmbmETdqX6BTS3C0qP3O+6twGNrlhVi6W
	 SPzW68imnPhdf1OWRhYlce2N8roZvaK0coBYSiQp3MzLwsQkkW2McyYf9NCaIqZvVNA+v
	 pEOGPDTcreywpay8MavNz2/phGlNKHe3uflbI2wu9u59f8QYybZojEVodXyustGHl6MuU
	 pUWBrPZkq+DVVQtz8FK2vCDVbtKD/EVllvh5R+OOf+N3EvXj7MV4I1NqeyQNlzbsPFj4C
	 YzP0qn0BmCeO7P/xQKHa1Q+TTl5/VgiiT6VXouA7OvDLL+DPl6dckWbHrEjpIj1hpWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280412;
	h=DMARC-Filter:X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-MTK;
	bh=p2FBISASke6tj+A+Ecr6Vf40pR1tBsOCu9ra75n8WqA=;
	b=Q3o5XbbB3H5wFDEZimrNrWdiX5xOb5xGrQgnpgGlI6m4+1qmvf6hRLSnyA2otwkyvRU/
	 4u78b6ZYTWAHoMc3mVYI0jb+G9XrlXps7M53ei8Rt8scAvlTOvcuDFcoIljY256zYLSl8
	 Y0ui5Q6xfuPcbIP0HiC+o8r7SUyNuOVi1xw99Y8zG1baCD2Xpwkb5FsEJndK1B3rk3M7F
	 +hbkTBuqlEAJRweLEHnoteyxn9aAsRqD+/u2Yq2urZ5dmoTebCgGN9UpxbotJ2x5rMKGa
	 /FU62gobrQSSOor2Tq3UM0XHkYNhSJVdCxKBfg5NcsJyxMaaZ/4F90FnI0c5e3uQi3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=RH+y4yIa;
	arc=none smtp.remote-ip=210.61.82.184
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DB6606A338;
	Tue, 10 Nov 2026 03:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8DB6606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=RH+y4yIa
X-UUID: b0827e6adcb411f18dc8c9802ae25ab1-20261110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=p2FBISASke6tj+A+Ecr6Vf40pR1tBsOCu9ra75n8WqA=;
	b=RH+y4yIauMS4ce4h7Ne9FBc3kQtuxeFaPx7QopIXnuQp/jJLBaHBYTgUpm+q5n5vQhjWmXgwwWq7jigP6bmlxQdm9zW0YkDYnVgs7u7dOTTvQGnYuoBQlwKlgKhE0QZx9JL08IsU8QK6EWSw8d9UJeZNcSMG75dZr8Upx+Fap+s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21,REQID:29fa2357-8a17-4e4e-8179-a1dbabb45871,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0318ac,CLOUDID:7a931366-4b51-4c95-bb1b-80ac6aad9c96,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b0827e6adcb411f18dc8c9802ae25ab1-20261110
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <emery.hsin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 491402088; Tue, 10 Nov 2026 11:13:23 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 10 Nov 2026 11:13:23 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 10 Nov 2026 11:13:23 +0800
From: Emery Hsin <emery.hsin@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <Sean.Wang@mediatek.com>, <jb.tsai@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Emery Hsin <emery.hsin@mediatek.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 02/28] wifi: mt76: mt7925: fix MLO sub-link memory leak on disconnect
Date: Tue, 10 Nov 2026 11:12:18 +0800
Message-ID: <20261110031244.369014-3-emery.hsin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261110031244.369014-1-emery.hsin@mediatek.com>
References: <20261110031244.369014-1-emery.hsin@mediatek.com>
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

mt7925_change_vif_links() resolved removed links through
mt792x_vif_to_link(), which falls back to the deflink after mac80211
clears vif->valid_links, so sub-link mconf/mlink were leaked.

Fixes: 69acd6d910b0 ("wifi: mt76: mt7925: add mt7925_change_vif_links")
Cc: stable@vger.kernel.org
Signed-off-by: Emery Hsin <emery.hsin@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 222836699d15..0a6c931843ec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -2383,14 +2383,18 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mt792x_mutex_acquire(dev);
 
 	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
-		mconf = mt792x_vif_to_link(mvif, link_id);
-		mlink = mt792x_sta_to_link(&mvif->sta, link_id);
+		mconf = rcu_access_pointer(mvif->link_conf[link_id]);
+		mlink = rcu_access_pointer(mvif->sta.link[link_id]);
 
 		if (!mconf || !mlink)
 			continue;
 
-		if (mconf != &mvif->bss_conf) {
-			mt792x_mac_link_bss_remove(dev, mconf, mlink);
+		if (link_id != mvif->deflink_id) {
+			/* STATION already deactivated the sub-link FW BSS in
+			 * mt7925_mac_sta_remove(); AP has no such path.
+			 */
+			if (vif->type != NL80211_IFTYPE_STATION)
+				mt792x_mac_link_bss_remove(dev, mconf, mlink);
 			mt7925_p2p_bmc_remove(dev, mconf);
 			devm_kfree(dev->mt76.dev, mconf);
 			devm_kfree(dev->mt76.dev, mlink);
-- 
2.45.2

