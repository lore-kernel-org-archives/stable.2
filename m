Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814CB3EB0E7;
	Thu, 27 Aug 2026 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787819765; cv=none; b=ahocg2uqmqVwSY3xcTMZZzeyinNjF5NXcIE7xPsRVkz+PPXXyrcgeZpbE/KhQKFI3MRmAsJWuDJDoOpOqCctMGFI3j3EFgqrk6XaaQUIs8G9y/hFDmj4387SYhgSEPGEpRKflO+JHhZNdvpRnWGjkJKQlUirwuXXTRV4FHCVdrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787819765; c=relaxed/simple;
	bh=E+ISmf3Rk8oViYEcjf5LxZP0f/oWVRwey3P9FW2J4+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWY56rZzYGOXfcQmlgZu1G5+L+juTctpoZShVvmLrENrUDl3jv5Rx1wvx9A665Am2I4kzSDJhbvibLgM5zMq/CsVLAb0nsyWAfCYQtVFcK03F0TF2eT1kOD1a9Swi2bAkPWU7d8eO5j6MMrqkGPUH/TPqG/ruaUilkvv2vR9bOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CZAvY0s2; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CZAvY0s2"
X-UUID: 50498ab8a1f211f18dc8c9802ae25ab1-20260827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=O9i6s6p8vgsMvcWKdXghGsBuJ/Y2ADIePCQPvKyAxig=;
	b=CZAvY0s2gwdyEzGHY8vI8VBn5PXOaDaXgJfEVWcejXpw1vb01FLMMmwtzcp0klFLxGdp+Yt3E85x/pVkpf2XPYMA7EvIs6FxNz+pgAI7nKlBliUxpT19vd4q3cDQyR8R8u5ONXvh+CZz21kle5COnrCt9vSW9s+xWTJgsSLsA+I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d5c48930-a9fc-46e2-adac-5a79c57439c4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:aa5825f2-6b5d-4016-ba8d-9f799a78b7e4,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|136|836|865|888|898,TC:-5,Content:0|
	15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 50498ab8a1f211f18dc8c9802ae25ab1-20260827
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <eason.lai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 759548882; Thu, 27 Aug 2026 16:35:52 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Aug 2026 16:35:51 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 27 Aug 2026 16:35:51 +0800
From: Eason Lai <eason.lai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<kun.wu@mediatek.com>, <deren.wu@mediatek.com>, <sean.wang@mediatek.com>,
	<quan.zhou@mediatek.com>, <ryder.lee@mediatek.com>, <leon.yen@mediatek.com>,
	<litien.chang@mediatek.com>, <jb.tsai@mediatek.com>,
	<lucid_duck@justthetip.ca>, <eason.lai@mediatek.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v4 0/2] wifi: mt76: refine USB/SDIO TX path error handling
Date: Thu, 27 Aug 2026 16:35:24 +0800
Message-ID: <20260827083526.1621600-1-eason.lai@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260819082129.1062282-1-eason.lai@mediatek.com>
References: <20260819082129.1062282-1-eason.lai@mediatek.com>
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

