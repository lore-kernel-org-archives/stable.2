Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AEC1E5B88;
	Tue, 30 Jun 2026 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782786951; cv=none; b=nAGU9UVwO8SqWAkBQCKRNA7afhksx+f96OBYyhsSSQlnQ9kjRxIzpmZzU6VvOsHxsWFp3KQAoYrVySO4iP0hmgptJPeFFdZq/6LURLhuUhfO7VU+aVIQ60+HqE4mbPDrqiBAQq7ji7eHZ9m9K2aAszRyYr/5EU3Pm705rzeokko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782786951; c=relaxed/simple;
	bh=4zXRYB+fkG9JLPCj3JM/53AYPEKpg3SY0dCqPkLx5mU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HB791bLXfapLHSndlig10PN/AdsOky2tTEi5O0UM2+iCHXO8zQxmOk8JEPgFoCfGozkEUeO/3FwJSP+9HrTMpWyfDMJpPIgcGtxg0noIf/grWtPG6EV6PoGafbQtAdYg7HGoX3D1qaT2rl/aD00dZxqocmJB/DC6mbMQIbnslaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UTxYgOo8; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UTxYgOo8"
X-UUID: 5fb8fa18742c11f18dc8c9802ae25ab1-20260630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=roUf/zuvB6EYzKdWEjz0GHQvKg6pHRTjmrvxGeJquGQ=;
	b=UTxYgOo8+DKdBRGUkC3/T+MFxh6zOnDiQlpfKCFkQYAsONkqlfoPj8k+DWUZSGVWrLAr0sF4FMrazm7Bp0OVi0LfNeDCapGwrsz6iYOGGidQhWnokL+ZziCCQTWvpLE7AuZAi0sQBzlujzyZVSh1B1Y/k0I+PMF86iWoWbYsXS8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:40b4e8a5-a00a-4d1c-a7ec-708d17f55a75,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:a4f51b04-3795-4a90-800e-68e9393a343e,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5fb8fa18742c11f18dc8c9802ae25ab1-20260630
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1004192259; Tue, 30 Jun 2026 10:35:35 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 30 Jun 2026 10:35:34 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 30 Jun 2026 10:35:33 +0800
From: Shiming Cheng <shiming.cheng@mediatek.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <willemb@google.com>,
	<daniel.zahka@gmail.com>, <alice@isovalent.com>, <sd@queasysnail.net>,
	<eilaimemedsnaimel@gmail.com>, <imv4bel@gmail.com>, <nbd@nbd.name>,
	<dsahern@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: <stable@vger.kernel.org>, <lena.wang@mediatek.com>,
	<shiming.cheng@mediatek.com>
Subject: [PATCH v3] Subject: [PATCH] net: gro: fix double aggregation of flush-marked skbs
Date: Tue, 30 Jun 2026 10:35:02 +0800
Message-ID: <20260630023512.26927-1-shiming.cheng@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

The new skb_gro_receive_list() function is missing a critical safety check
present in the legacy skb_gro_receive() path. Specifically, it does not
validate NAPI_GRO_CB(skb)->flush before allowing packet aggregation.

This allows already-GRO'd packets with existing frag_list to be
re-aggregated into a new GRO session, corrupting the frag_list chain
structure. When skb_segment() attempts to unpack these malformed packets,
it encounters invalid state and triggers a kernel panic.

Scenario (Tethering/Device forwarding):
  1. Driver: Generated aggregated packet P1 via LRO with frag_list
  2. Dev A: Receives aggregated fraglist packet and flush flag set
  3. Dev A: Re-enters GRO, skb_gro_receive_list() is called
  4. Missing flush check allows re-aggregation despite flush flag
  5. Frag_list chain becomes corrupted (loops or dangling refs)
  6. Dev B: TX path calls skb_segment(), crashes on corrupted frag_list

Root cause in skb_segment():
  The check at line ~4891:
    if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
        (skb_headlen(list_skb) == len || sg)) {

  When frag_list is corrupted by double aggregation, when list_skb is
  a NULL pointer from skb->next, skb_headlen(list_skb) dereference
  NULL/corrupted pointers occurs.

Call Trace:
 skb_headlen(NULL skb)
 skb_segment
 tcp_gso_segment
 tcp4_gso_segment
 inet_gso_segment
 skb_mac_gso_segment
 __skb_gso_segment
 skb_gso_segment
 validate_xmit_skb
 validate_xmit_skb_list
 sch_direct_xmit
 qdisc_restart
 __qdisc_run
 qdisc_run
 net_tx_action

Fix: Add NAPI_GRO_CB(skb)->flush validation to the early-return check in
skb_gro_receive_list(), matching the defensive programming pattern of
skb_gro_receive().

Fixes: 8928756d53d5 ("net: add fraglist GRO/GSO support")
Cc: stable@vger.kernel.org
Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
---
 net/core/gro.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/gro.c b/net/core/gro.c
index 35f2f708f010..076247c1e662 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -229,7 +229,8 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 
 int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 {
-	if (unlikely(p->len + skb->len >= 65536))
+	if (unlikely(p->len + skb->len >= 65536 ||
+		     NAPI_GRO_CB(skb)->flush))
 		return -E2BIG;
 
 	if (!pskb_may_pull(skb, skb_gro_offset(skb))) {
-- 
2.45.2

