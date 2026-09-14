Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E55633998;
	Mon, 14 Sep 2026 02:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789352378; cv=none; b=PGVZRtskdBfyqifz5Mo+mDvQFIte3DVoo3ZqKAkGNCpagRWFKMkKlhVrp9oTFJfDw9J9+JTAwOt6zooonPMwnYmhJFEkqCSVYUu0eZNzTV58ie1o+SWY5Vdi40h2fTsKKoB4fQtJP6aALv+zKc07Q2VYqQ8/LuFsfQrL0VgJbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789352378; c=relaxed/simple;
	bh=E+ISmf3Rk8oViYEcjf5LxZP0f/oWVRwey3P9FW2J4+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQJ+m0HUp2a8hTNY740mIiJ//ZJWQPIwP15OJspFwK4w5IFBgK/cB4QLvjTrN2H0WMs1ilu2UumdQkayBuLR3QfEd+k4KyEP80lvhrXcMbam/HSOJPPIU36BkktFe+edPD6W1h3OgoyyZ0RsWPK7kzpER8botG7q+lVXcEivCsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=tBCny/7h; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tBCny/7h"
X-UUID: b47a4420afe211f18dc8c9802ae25ab1-20260914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=O9i6s6p8vgsMvcWKdXghGsBuJ/Y2ADIePCQPvKyAxig=;
	b=tBCny/7huf132D8HkR5BP6wKWDgJfzIwz1gbnKQ4XxVGZP1P+EhLF2TBuMjnXnCVR5ws3/xuc4mJ2exmczbmBkttFi6Csff1qxgkRdMXixVhSFFxSq7AjEF3H+YIQa4T4cX5p7jFmBGgpA7LU5wFOB/JnUeCGGaxkK++V1cYzV4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:03bad8ab-dab0-44a6-91d5-3a8095d535c7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:a4fc5f10-b0ca-45fb-a2c7-7f923da2cfe3,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|136|836|865|888|898,TC:-5,Content:0|
	15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b47a4420afe211f18dc8c9802ae25ab1-20260914
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <eason.lai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1159596752; Mon, 14 Sep 2026 10:19:25 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
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
Subject: [PATCH v5 0/2] wifi: mt76: refine USB/SDIO TX path error handling
Date: Mon, 14 Sep 2026 10:19:18 +0800
Message-ID: <20260914021920.32246-1-eason.lai@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260827083526.1621600-1-eason.lai@mediatek.com>
References: <20260827083526.1621600-1-eason.lai@mediatek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series fixes a UAF in the SDIO TX path when out of memory and
a memory leak in the USB TX path.

Eason Lai (2):
  wifi: mt76: mt792x: fix UAF in SDIO TX path when out of memory
  wifi: mt76: fix memory leak in USB TX path

 drivers/net/wireless/mediatek/mt76/tx.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/usb.c | 31 ++++++++++++++++++++----
 2 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.45.2

