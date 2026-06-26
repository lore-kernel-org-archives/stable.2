Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FAD3BB681;
	Fri, 26 Jun 2026 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782463507; cv=none; b=E4d7jTBm5ULWIPL6ew6d9x8du+4OH0hoXwkASmIR/iht79QOJAAO6jKZ0HwbljHF6arG9hJroMoNBRxXw7q//azgE11dopK6v8ahgSVS3zR/XtMWe8L7bC7pI3v5Dc25x0dVwD/NX8t/Yhtrs1EzZgpVgJpQGRX67JVtJXSgFMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782463507; c=relaxed/simple;
	bh=P57UOKGR/1lJD0mKrus+RBayRSBuNY+kcCm/0HVEVrE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WZNa8OjbW+EMTIobDUOEEyTf+DlqoheAEyVnvG7ol/1P0mjsfNo5ghtp/uYtuabqJ3AI9Tx1jyN46Kuyo7wgkSRweuTXRLcyMeNklSLPELyfwtQL/+3taxSJ/tkv0hk+p5NHR6GPfYTxiFbcorZyiMPWpSjEIl8sf1U2khRC7CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jb4N5yDH; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jb4N5yDH"
X-UUID: 4f433af2713b11f1b1788b6acf885367-20260626
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=oZxFRT7y6QOtHKSYQsbCKdm/g4+aQqG38KozlNl6MJs=;
	b=jb4N5yDH8kKRQ/fT8Q8bAtWHSXziRWBcw2UXyDZelqD7wtq1OPVpwz/ZmQcvmFmYtDyUnDPXMVIvg7jRPqQkl4rfmlRbJeHegqDAq3KQgtvwGiiliRB2gwFCTfnSDSyqUdEi2yWWDZs2/caN6zpxQs4+WDuSsQNFVe0rvCBUF+w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:20a78760-6d8c-49b8-a904-b07db37cc47d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:99bf23ee-45e6-4692-a476-3f71842ee83b,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4f433af2713b11f1b1788b6acf885367-20260626
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <shiming.cheng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 319282522; Fri, 26 Jun 2026 16:44:57 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 26 Jun 2026 16:44:56 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 26 Jun 2026 16:44:54 +0800
From: Shiming Cheng <shiming.cheng@mediatek.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<willemb@google.com>, <imv4bel@gmail.com>, <alice@isovalent.com>,
	<eilaimemedsnaimel@gmail.com>, <sd@queasysnail.net>
CC: <lena.wang@mediatek.com>, <stable@vger.kernel.org>, Shiming Cheng
	<shiming.cheng@mediatek.com>
Subject: [PATCH v2] Subject: [PATCH] net: gro: fix double aggregation of flush-marked skbs
Date: Fri, 26 Jun 2026 16:44:51 +0800
Message-ID: <20260626084451.27699-1-shiming.cheng@mediatek.com>
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

Fixes: 9dc2c3cd6c11 ("net: add fraglist GRO/GSO support")
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

