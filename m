Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.61.82.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153466;
	b=cq70Tghww31R+vS5kZLFxeIj+52IVPixg/CstHq6Z0opGtX5GH22o+ZTQ6mtU5rd54CU
	 MMfRN4DlEhZfMMq14YM69EuH16iAHSobOZknpzOzoJSd6tYObAPFAmnJA6ySF5Fo9Hyct
	 ziJlYtqUT6HUg+SO84Qe/zW6eR1BH2sbgR5Y852PCyMDks6tRJGcphO3iYD68DhOVZ6BF
	 NOfqts+vTjOfD/vlJrPHf+dnSZpDSc3o9T740y2L+TslHlC6qzJGYhRmgpikUW5QsLcAL
	 n1NdBQFXjupyRGCJ8KP+Dwpdpd/GZm2N10t6+phYI0oqncoVBkYs1gqyXlmoaw1GDUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153466;
	h=DMARC-Filter:X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=0DV7tMjRSGpWgrPEB8r/sZahHaIcSHsSwlL4yELocFE=;
	b=IQ7aR0C5IlF/i9OhtFc+33c8/Yk6SSdkvZprJpULVxiYkr8jtY/S3Np1vmr5+VN1rYhu
	 2N++UmmcN+3D972LKWx+g99JtvdJKAiI7U+i3aCZWk8ahDKUVWsWiwHdsjl5qETkaecVM
	 3L/8SBGEokn6OsDfZf9Scorpkkdw8i1XUirGqaEdLnf6PjnGVz1Uys/boI+qmOpiszcOj
	 oKpCwWgqWxWzTIKkl0TMQO2+RK/PVd/Dze9cgIUER+5gbLscSCsddkPj4K+HY1JvNhZCT
	 M5V9sY+QAmaxJdVdqM1NCZcaSwvCa5SE913IRVjtSXGjBOTP64MS3WSrXWJphfy1K4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	arc=none smtp.remote-ip=210.61.82.184
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03E1606A321;
	Wed, 28 Oct 2026 02:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D03E1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cfac8f96d27411f18dc8c9802ae25ab1-20261028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0DV7tMjRSGpWgrPEB8r/sZahHaIcSHsSwlL4yELocFE=;
	b=VEECkWiL/4xjFxhdixNE5KRmJJK1xhyDGPD9dojVcMaLDCPz6ap/7Vm4GhYmpMK8qbERkwvnRHe7VtdJJqUh2qDhoe2n3TFq712RkezEb2mf1JL5njYhKicZXGX1hCbdvmhahr3TBKH7QqMdIdv+NP01rhp+AnjbKqdQN4mn1qk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:40d1c0a8-e1f3-4247-a07b-8e44af41e088,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:291e20b,CLOUDID:3b2a0811-191d-4342-81c6-7ef97658e3d6,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cfac8f96d27411f18dc8c9802ae25ab1-20261028
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <eason.lai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1683640086; Wed, 28 Oct 2026 10:10:56 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 28 Oct 2026 10:10:55 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 28 Oct 2026 10:10:55 +0800
From: Eason Lai <eason.lai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<kun.wu@mediatek.com>, <deren.wu@mediatek.com>, <sean.wang@mediatek.com>,
	<quan.zhou@mediatek.com>, <ryder.lee@mediatek.com>, <leon.yen@mediatek.com>,
	<litien.chang@mediatek.com>, <jb.tsai@mediatek.com>,
	<lucid_duck@justthetip.ca>, <eason.lai@mediatek.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v1 0/2] wifi: mt76: Fix UAF and SKB leaks in RX A-MSDU path
Date: Wed, 28 Oct 2026 10:10:51 +0800
Message-ID: <20261028021053.2220951-1-eason.lai@mediatek.com>
X-Mailer: git-send-email 2.45.2
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

This patch series addresses a Use-After-Free bug and SKB memory leaks
 occurring in the RX A-MSDU reassembly codepath of the mt76 driver.

Eason Lai (2):
  wifi: mt76: flush a partial rx A-MSDU when its station is removed
  wifi: mt76: free a partial rx A-MSDU when the phy is unregistered

 drivers/net/wireless/mediatek/mt76/mac80211.c | 65 +++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 2 files changed, 66 insertions(+)

-- 
2.45.2

