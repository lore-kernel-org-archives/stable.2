Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253C4245020;
	Mon, 14 Sep 2026 02:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789352378; cv=none; b=gsDomS1NRDDjadToAzQ3iQ9wEYFVy8lYOd+WC+/yMehkUMKF7KjyEmCevogbp1muPbLv7d/gujgmRQU/8Dc2n31uiwc3A5IQY3cS4fM02YioprBUVIFJQkUvlkeAjwWlEvqm9d2WQFay2uAwIKz30wsLsazmO73sgUvn5EpXOtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789352378; c=relaxed/simple;
	bh=IbTDYFDGKof4KHnZZIZ/bLj3faCmBfbA1/TqPzbfJVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtPt2YIjXouOl0MDQP/TtRCxEKk89kIFC1qr7jwTeDJ4GKBPtYDRgIdx9aJUkXsMNBiezFwyTb40iXnn8sxG4xeau2pLCdRa8HLBS6uqceve5ot7kNi4Fs5zN9SP8hulqC67POstZEBhNifVc2a8QEIdbjTEXElOQ3plLa3DeYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IQfFOwjo; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IQfFOwjo"
X-UUID: b49caa9cafe211f1b1788b6acf885367-20260914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=In2QW9qvbO1raXYia7GjPfhlfTvBqxPiC+dEcTWs4mY=;
	b=IQfFOwjojSWJBb36kLSm0coDtcVcU04NAXjivJAYMRvkSJQbkTgFjDgg2vivXlWw6r0M0CHklsxTS/q8b/M/qC4TMO0dLf5379jyeAEFJ/mcibElTnGywFY93J1s/3PLVQ4UW/ga89q3fwSEA/c70URBu4MewwkwCHiqSKSzArA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:362f2d40-7df2-4d5b-ab2b-ea4b43418b71,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:c2467f81-d3d7-465b-8027-55881c8b818d,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b49caa9cafe211f1b1788b6acf885367-20260914
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <eason.lai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1613551319; Mon, 14 Sep 2026 10:19:25 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 14 Sep 2026 10:19:23 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 14 Sep 2026 10:19:23 +0800
From: Eason Lai <eason.lai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<kun.wu@mediatek.com>, <deren.wu@mediatek.com>, <sean.wang@mediatek.com>,
	<quan.zhou@mediatek.com>, <ryder.lee@mediatek.com>, <leon.yen@mediatek.com>,
	<litien.chang@mediatek.com>, <jb.tsai@mediatek.com>,
	<lucid_duck@justthetip.ca>, <eason.lai@mediatek.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v5 1/2] wifi: mt76: mt792x: fix UAF in SDIO TX path when out of memory
Date: Mon, 14 Sep 2026 10:19:19 +0800
Message-ID: <20260914021920.32246-2-eason.lai@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260914021920.32246-1-eason.lai@mediatek.com>
References: <20260827083526.1621600-1-eason.lai@mediatek.com>
 <20260914021920.32246-1-eason.lai@mediatek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Using __skb_pad() instead of skb_pad() in mt76_skb_adjust_pad()
to prevent double-free, as the caller handles cleanup.

Fixes: 808f2767d421 ("wifi: mt76: mt792x: Fix memory leak in SDIO TX path")
Cc: stable@vger.kernel.org
Closes: https://github.com/morrownr/mt76/issues/83
Co-developed-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
Signed-off-by: Eason Lai <eason.lai@mediatek.com>
---
v2: no v2 change
v3: add Signed-off-by: Devin Wittmayer and send as series
v4: add CC stable
v5: no change
---
 drivers/net/wireless/mediatek/mt76/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 3707ee19e4ae..ec503521ae63 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -879,7 +879,7 @@ int mt76_skb_adjust_pad(struct sk_buff *skb, int pad)
 		}
 	}
 
-	if (skb_pad(last, pad))
+	if (__skb_pad(last, pad, false))
 		return -ENOMEM;
 
 	__skb_put(last, pad);
-- 
2.45.2

