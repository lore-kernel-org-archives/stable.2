Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835DB3C3C09;
	Wed, 19 Aug 2026 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127756; cv=none; b=rvUqDCNNcrQAeNZ+r1ioqMLorfP7VwaEjxLhASVwmtF8pg8O+qMyQcbltohQV0kRl4kEifejRUVhOebD4ONuFaPtQlDijnC4JaZAuvxBT88dWg911+akS2f0Ct2I5oNkzqyj53ZOvbHWupcBf0/Z565UbbF8ZBV0+uUYaRCGiQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127756; c=relaxed/simple;
	bh=E+ISmf3Rk8oViYEcjf5LxZP0f/oWVRwey3P9FW2J4+A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q6fpqq3fwukXjVzyJh+lIPCVWBaNW48eBLgnS3rsn1S2+JkmkL8Qc4741kitcxgusr/+gYHIK0k0bknAK5eE2G09cmYcttM7TfQqmd3sM+Vp7WvHdapsmWlX7f9dtwah8M9Xr1aE1GUq0wuj0kt5fc5sazY/vYMeGxHOTCjknJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=b6vFSw3w; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="b6vFSw3w"
X-UUID: 1829c1269ba711f18dc8c9802ae25ab1-20260819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=O9i6s6p8vgsMvcWKdXghGsBuJ/Y2ADIePCQPvKyAxig=;
	b=b6vFSw3wwjpMmQRhiRYJs077os0vgvFf+ga7cjM1CEYHQOsbUHmcoV/phOfCV6GlPZz25HcyezpHTMOnbCKIEtn0n22PsQ/S8sWXiqkwQ3UQkTdwPR+nTk/6Z3Z7QtuCZT/+7s3a0MmyoPfEd3PDmsuMMe7UkzeBYtzmGqUoIU8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:aa74ef79-1f69-4459-9579-8c2c42c329da,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:656107f2-0685-46a3-9cac-19d8f3a05ae7,B
	ulkID:nil,BulkQuantity:0,SF:102|136|836|865|888|898,TC:-5,Content:0|15|50|
	99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1829c1269ba711f18dc8c9802ae25ab1-20260819
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <eason.lai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1447000614; Wed, 19 Aug 2026 16:22:19 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 19 Aug 2026 16:22:18 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 19 Aug 2026 16:22:17 +0800
From: Eason Lai <eason.lai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<kun.wu@mediatek.com>, <deren.wu@mediatek.com>, <sean.wang@mediatek.com>,
	<quan.zhou@mediatek.com>, <ryder.lee@mediatek.com>, <leon.yen@mediatek.com>,
	<litien.chang@mediatek.com>, <jb.tsai@mediatek.com>,
	<eason.lai@mediatek.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 0/2] wifi: mt76: refine USB/SDIO TX path error handling
Date: Wed, 19 Aug 2026 16:21:27 +0800
Message-ID: <20260819082129.1062282-1-eason.lai@mediatek.com>
X-Mailer: git-send-email 2.45.2
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

