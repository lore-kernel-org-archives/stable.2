Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614397;
	b=pj60O+fzC7D8qhojFZc+cIHK1di1d10y2dTBAZ0mTqx077J04eibmIJoLPHt9R4vqHJ+
	 tfGtfahxHm48XqAF/E560KTWDP6TPiDOv0FYXlmPF8Mt1xjvDGZ9MA4Opk3ayYK02O4Sy
	 JmeQAtoBcGn/tv4NMZ1AAnhot5k0w5qvWdptFupEhveadYzq6gZQVZTfuz5OVPwTya0gt
	 U9hcTOmiwj3Y+2JyVgnsdPKYuLwCNLHZbUsV4XZ/0nuCR6vassFgdkr5UD/4SF74+2AgZ
	 wBMRzX4DDx3AeRPrNCp+K+5GBEB+noKStAe/bJ81sCZyFP4OMkzIthLDuoyyGUN7dOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614397;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID;
	bh=0x/2M/i9MTAHnBLm57Omm6Wke0JZLV91H+uZ/09Sg/U=;
	b=qerhJgXoijJ9JVdGu2hjaHiEUThyiERNLSkiKsWlQWcZeKajNGaug2UBqyMFQ6tS6rbb
	 Ml32IIx8ogIuVlanEDnGW8fr17sK9ojJDx1JmPXGZuFf/GN5IWK+3FWWpt2xxNks3zAXz
	 kCepmc6COTEq5SP6DN51ZJmV/boI52UXjep6sFV78c73M2JhFu/mk9T23HYxHdtLmJt97
	 6FLejo/ZTBnWkTLs80Z5rtC/1wh6v+zxU54/fwWPR4ZwGVrZimMvvN+VjcrjlJpDZkjWo
	 g93jxIgzaUVzYYwhjQ5/p0goNFfQjpsStJhI4KFf49gwdYjETjL0mg/rI9kO7fRYtdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=GP9JyIFi;
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2F7606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF2F7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=GP9JyIFi
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A22RpNS2102114;
	Mon, 2 Nov 2026 10:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=0x/2M
	/i9MTAHnBLm57Omm6Wke0JZLV91H+uZ/09Sg/U=; b=GP9JyIFizJKuHyHv5zIMl
	tDgwcoEo0JRTri3NAPjWJy14OuTf/3cnehPKv3EhU6R6XPqY7vYbHv1fimlWT7cC
	X73nlyxslVNqY78daTj30QqDuK4PtVcLfMdAikWcKfQahd6ihBVUwUlTEfjCMo/V
	9BwU2Xpib2JHorVE+8pwj4UKUYJfFYIm7QVNu++eQe/uZOvijiyedfMZlZbcsGF0
	lHNCEK6HaVygAXvO3knnU64APu8k1Cg3jQTbPdBbnkeCFYIjFk/MuHAD0tdVZQ8Q
	ydc0/rW762FevQUjEc267mFL/qlyjVCO7F1EDyz77Fnw+WP3mfRXI7K7kU43O4HR
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn78a9m8a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:13:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29Cvk32995860;
	Mon, 2 Nov 2026 10:13:11 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hpqfja56j-10;
	Mon, 02 Nov 2026 10:13:09 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Shiming Cheng <shiming.cheng@mediatek.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 09/11] net: gro: fix double aggregation of flush-marked skbs
Date: Mon,  2 Nov 2026 02:12:37 -0800
Message-ID: <20261102101239.1557688-10-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102101239.1557688-1-harshit.m.mogalapalli@oracle.com>
References: <20261102101239.1557688-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020040
X-Proofpoint-GUID: 2ZRJRLYECnxtqsf2b5auXi-YmdF_6jmS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX7dSomSUSvtXY
 J3/vJJxFJyQXYoTIfioaF3LcoMaQ/nwQ1nLK4nB2hQGVV81YizEXIulChrOJT2yoJ5ZoFw/Uo7G
 53H/l40ZQJVZ7bp2iR98/D7iGB87mJu35eEOJDmkDWt1oGpEMfRc
X-Authority-Analysis: v=2.4 cv=Mo3HeGae c=1 sm=1 tr=0 ts=6ae86237 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=bC-a23v3AAAA:8 a=mpaa-ttXAAAA:8 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=2NbHboc6qYvcHGEiEssA:9
 a=WmVTiCyuxqgg3mnwYu6p:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfXxkhtPnno04wK
 oGXnqxg6vtBcmGnmDvRAOLYpFyB7CegSSX8elKKwI/Ywj2YtEa3z+IcSmm0WJGuW7q4775Q02NM
 mp2axEk8B7vQePD94Q7+mkqc4s6j/bBgb6wGfgsB6Q9GG2DcejzgYbpRWZ9nzczRB5/bIYnebIF
 rZOuAVo/ATCUyrF5GtcGk9lUsLVEKQc2oc73hCQSGqMsgOVE2f8QSFXD/pLaCw291vsalinlfd0
 j4dV9L3dWWHCDT3AvueAAU/TFu+JfFW3IkwIMrSIQ4WKoPaULaAWwxxfvoIXoKyz+K2sh2u6YP+
 iTMP9hg7KM2b5GWC/IdTDPOHEzdorJs4JxYRDsOBVIrALLYLkWzYtqS64FHiUbni7gBf/iTsnnJ
 S7Z7fqAB25DxZMgYki3zvCENw2w4ftOxB3TZyasv1bRiQcr5LXwYJOEyXVbt6sB4x4CI00hEVMf
 2He36Db6Gxn1ojGLPvg==
X-Proofpoint-ORIG-GUID: 2ZRJRLYECnxtqsf2b5auXi-YmdF_6jmS

From: Shiming Cheng <shiming.cheng@mediatek.com>

[ Upstream commit e751256486d0ded20f5a9f9863467f1dce65142f ]

Commit 0ab03f353d36 ("net-gro: Fix GRO flush when receiving a GSO
packet.") added a flush check to skb_gro_receive(), but
skb_gro_receive_list() lacks the same validation.

As a result, packets marked with NAPI_GRO_CB(skb)->flush may still be
re-aggregated.

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

Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
Cc: stable@vger.kernel.org
Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260709014704.3625-1-shiming.cheng@mediatek.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Harshvardhan Jha: Apply the flush guard in net/core/skbuff.c, where 5.15 keeps this helper]
Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/core/skbuff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f35d32561c36..9008a1229ba7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4003,7 +4003,9 @@ EXPORT_SYMBOL_GPL(skb_segment_list);
 
 int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 {
-	if (unlikely(p->len + skb->len >= 65536))
+	/* make sure to check flush flag and to not merge */
+	if (unlikely(p->len + skb->len >= 65536 ||
+		     NAPI_GRO_CB(skb)->flush))
 		return -E2BIG;
 
 	if (NAPI_GRO_CB(p)->last == p)
-- 
2.55.0

