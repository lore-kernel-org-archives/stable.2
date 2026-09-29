Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E16D3D0BEC;
	Tue, 29 Sep 2026 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676204; cv=none; b=fGsQj8tNbw0ks0RR6pTPdoNn7BCv17+9/EKjtDSqZeemcazAGPsDizU4LY5RR1uw19xFDlXHVUjXlvPc6P0tbVH8esuNhTZKaCguqH6MimVlUaJYRjMsVr/F35h1kHiP3kzyOjSNtJ4LL5kwkNw9/xER6QeYWawibJQ5LnwG3FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676204; c=relaxed/simple;
	bh=5m8t+DqmOklJ09PVxKp0kK8/O8id53KIQfHN2u983ec=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ANOg4FKtyuXo9gShOl/Zrzt6cDRTa8JB4+rNd2tBzJc+XVKGhU6qBa/TWnovbObDKuKIwxzEeayHFYTIjvOBHFC5mHk2y6fq8n3ZyoTJ5HeB44XKCet8SM8NO6R5tJk7TlYCFQqPxfiWXNcmRE6mlDsL9sxGdub5YMr5FjBD5y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=g7y+dHa2; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="g7y+dHa2"
X-UUID: f7c0bb22bbec11f18dc8c9802ae25ab1-20260929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=dyYbTObh62hi+fWsCU7QOW9sp8JH41mugoLKDlkqq68=;
	b=g7y+dHa2TSK84tqdvo6a8NdeubMdWavuWlXtN4l9lDYc3w6JIcTx90cDO/JlsF0DA6/ZV0betAf6mWfW3FjqyVQdRQZaEK+PFexVhics5U4xPRe+VHPsosO9S1xI6vChCDkgelnCj4SyHEboVRdEBf6sGpdsg0xB3ugIp2j81Bs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:2fe61261-c9d3-45a1-be16-804012babc49,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:291e20b,CLOUDID:b5431909-d10d-41b3-a8f1-bc707284d0ce,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f7c0bb22bbec11f18dc8c9802ae25ab1-20260929
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1036863433; Tue, 29 Sep 2026 18:03:06 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 29 Sep 2026 18:03:05 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 29 Sep 2026 18:03:03 +0800
From: Shiming Cheng <shiming.cheng@mediatek.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <willemb@google.com>,
	<daniel.zahka@gmail.com>, <alice@isovalent.com>, <sd@queasysnail.net>,
	<eilaimemedsnaimel@gmail.com>, <imv4bel@gmail.com>, <nbd@nbd.name>,
	<dsahern@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: <stable@vger.kernel.org>, <steffen.klassert@secunet.com>,
	<lena.wang@mediatek.com>, <shiming.cheng@mediatek.com>
Subject: [PATCH] net: gro: mark frag_list GRO packets as SKB_GSO_DODGY when a list element exceeds gso_size
Date: Tue, 29 Sep 2026 18:02:48 +0800
Message-ID: <20260929100256.23192-1-shiming.cheng@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK: N

When RX LRO (or similar offload) is enabled, the TCP/IPv4 GRO path may
aggregate traffic using frag_list. The resulting skb is later segmented
via the frag_list segmentation path (skb_segment_list()).

However, some drivers can hand GRO/LRO-aggregated frames to the stack
where individual frag_list elements are already larger than skb_shinfo(p)
->gso_size (i.e., an element itself contains multiple MSS worth of
payload) and may be non-linear (nr_frags > 0). This shape is not
naturally produced by the software GRO aggregation logic for devices
without LRO, and can lead to unexpected behavior in the frag_list
segmentation path.

Detect this condition during frag_list aggregation and mark the
aggregated packet as SKB_GSO_DODGY when a list element’s length exceeds
gso_size. This forces a more conservative segmentation/linearization
behavior downstream and avoids relying on assumptions that do not hold
for LRO-produced aggregates.

No change for normal software GRO aggregation: the new check only
triggers when skb_shinfo(p)->gso_size is set and a frag_list element
length exceeds that size.

Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
---
 net/core/gro.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/gro.c b/net/core/gro.c
index 29b4d02bf519..e70ecf19b0a7 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -259,6 +259,9 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 	skb_shinfo(p)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
 
 	NAPI_GRO_CB(skb)->same_flow = 1;
+	/* frag_list element larger than gso_size (already coalesced before list-append) */
+	if (skb_shinfo(p)->gso_size && skb->len > skb_shinfo(p)->gso_size)
+		skb_shinfo(p)->gso_type |= SKB_GSO_DODGY;
 
 	return 0;
 }
-- 
2.45.2

