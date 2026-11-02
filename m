Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614386;
	b=HxCn3RBZu8qm2acS72IVGNEd8xTr4lf/+fjx5vm+zHxIsqgThUqTyeXKW2rrj4RAguJN
	 qzft66WchXhGstinXj6vg2u5eC9XJ3ZNvFUo0t3Ub6Uj1TBMLBKu9wlAnPADC6or8bseo
	 SFvUBQ0oeVBGdfjVkAle4Dh6Bfgeoibf0TsRJP8B8Vvhmc7tC2NuwdhQPiDHYBagy7RQr
	 BaXSLu+8wIoPZpZ/MWzqoy4bYEHJNzPCSjKx27OhnXvLOSo9jxYctAuQWnEFcvsPJWQMS
	 WOyhIeCvVFJk/E1yXBEWPzYvOwbdPB/VZjkPj72akPD5Geooze2VdGawBtUfBfJRQvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614386;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc;
	bh=8NOgtRfUb45JbTnE3PvdUUTHh6WL9fHsVcCBynzubH4=;
	b=s+/plyTM8rNm7rLYMeV0gzTGPhNN0LTodVsaitkYgzyfJSX0O2cggPfK8lrRFfS22Vh5
	 JOO/6iW2kXuqRu+clHsBMycWes/fa6uWpsUXX8lDnZgblKOJipVtEFOZMoozWh0MUV8Cm
	 t9e3UlrkddCKPxrxOphNDTw+S9l2bpgvurXrwCoUqzkrMn0CrgUIUY3j16JJuD2d5U/x4
	 5xQA3siL8T4eLpbnrhbd3/lBJATdm2C3ocLdiews/4cin7b/Zq7YjnraoDU3Rt+IQKWCh
	 CbgTJzw18oD83j5KCXzq1m6B2w79Yk8Qow1nEOBwte8oqlOAwS75oW6XSxH4u5GD0wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=d4lPDpAJ;
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E81460A260F
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E81460A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=d4lPDpAJ
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A20T7xo3066465;
	Mon, 2 Nov 2026 10:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=8NOgt
	RfUb45JbTnE3PvdUUTHh6WL9fHsVcCBynzubH4=; b=d4lPDpAJ7ofW2/c1nKNLl
	Vo3vSPUF45CAcQ7HdY+jnPBc0hd7XGG3dffyEXRZic8KqFltqkagN/tGJLhKaz8v
	ISnZPQ6OF96D0qWztmzogjcgfEgdfXlPhNJWKpSflTyz5LVUmvE04nzoC8seQLmZ
	MjbPtqzwi0AAAHJrqNzGBIkwM1w/Ut8/hntHWkSur647Eu9aty5i5tRKD5AgBbUX
	cu9hOkkNsZIMkrPBAg5za+fPFNf8fCK3XLJffIRs00hT607BCaWYrSVttUQhkt67
	4VsFE37zUmOmX/TyrKfPfrukbzXacJrwkN1OR9/Ko5CDwwewnni1QHIkWBOIzGkP
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn8vr1j5j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:13:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29Cq0X2995680;
	Mon, 2 Nov 2026 10:13:01 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hpqfja56j-6;
	Mon, 02 Nov 2026 10:13:00 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Anand Khoje <anand.a.khoje@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 05/11] ipv6: use RCU in ip6_output()
Date: Mon,  2 Nov 2026 02:12:33 -0800
Message-ID: <20261102101239.1557688-6-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfXwH7v+93P8Fus
 Q8qNY+VxI8opxmnBejUcl8l4pvTRp0Gp++O6xmIDjptkYDd5zWEO1qHTWANzrytdpvyqaMiXvMt
 m3ZPR/hFXN6PkxoEEwaVODIfdpDvO2AlWlnJkbwmtuHfCj/JfPUT
X-Proofpoint-ORIG-GUID: JaxAXVLnONgi8WPhWUSlv0yKhAye0ubV
X-Proofpoint-GUID: JaxAXVLnONgi8WPhWUSlv0yKhAye0ubV
X-Authority-Analysis: v=2.4 cv=RPcmjIi+ c=1 sm=1 tr=0 ts=6ae8622e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=bC-a23v3AAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=P4Gq05XyLVYQ0yX0wKoA:9 a=WmVTiCyuxqgg3mnwYu6p:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX26WM8vNnhnE1
 WdFItWaHPgacWmsgMeJi7gdv6NtXdKBYUfCVnHsam62Pr0TbfDMQbzoPYi/BomgTo+0b3dnMjTP
 40XteYxP1p8Oe86QxmldkX0XMR1XojlEywOlu8Ehl2vLw1TrFlvZ4G9l8ZdTSMsxcQR2B+xqkat
 uhHCbrSAlyZ4d2OgfN4F9KeP+DEcqwV3fBnT7jsgG00hjUGbvaE2oMmeHXc+7Gaw4oPTSNyfjSI
 Ae47bTKU76sO9htfB9LtbrfoOQq6X/IqkgpfvbEsffUKv4J8Sthn7EuQKeTMPbFr0VG3SZQ8yvJ
 taFGqwHn2V1d8X+1fhiW6EZ6cWJDty/RKmboxGWAL3XyWV1tUCj6NwtpgJ6Ot9Wln+K4lLN973I
 Haxq9FL50wwsq6pBRNvqPLzW/jnIoGzmtDo3Mgn9cqbfSQbe3j812o3k25kNUaqasKur/0EhShK
 Kw31VfY+3rjVpsQzQRg==

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 11709573cc4e48dc34c80fc7ab9ce5b159e29695 ]

Use RCU in ip6_output() in order to use dst_dev_rcu() to prevent
possible UAF.

We can remove rcu_read_lock()/rcu_read_unlock() pairs
from ip6_finish_output2().

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250828195823.3958522-5-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

(cherry picked from commit 11709573cc4e48dc34c80fc7ab9ce5b159e29695)

Conflicts:
 - Retain 5.15 BH neighbor path, skb free API, and stable header refresh

Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/ipv6/ip6_output.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 6db5f2501736..bc6c02918ca7 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -59,7 +59,7 @@
 static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb);
-	struct net_device *dev = dst->dev;
+	struct net_device *dev = dst_dev_rcu(dst);
 	struct inet6_dev *idev = ip6_dst_idev(dst);
 	unsigned int hh_len = LL_RESERVED_SPACE(dev);
 	const struct in6_addr *daddr, *nexthop;
@@ -69,15 +69,12 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 
 	/* Be paranoid, rather than too clever. */
 	if (unlikely(hh_len > skb_headroom(skb)) && dev->header_ops) {
-		/* Make sure idev stays alive */
-		rcu_read_lock();
+		/* idev stays alive because we hold rcu_read_lock(). */
 		skb = skb_expand_head(skb, hh_len);
 		if (!skb) {
 			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
-			rcu_read_unlock();
 			return -ENOMEM;
 		}
-		rcu_read_unlock();
 	}
 
 	hdr = ipv6_hdr(skb);
@@ -221,22 +218,30 @@ static int ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff *s
 
 int ip6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb_dst(skb)->dev, *indev = skb->dev;
-	struct inet6_dev *idev = ip6_dst_idev(skb_dst(skb));
+	struct dst_entry *dst = skb_dst(skb);
+	struct net_device *dev, *indev = skb->dev;
+	struct inet6_dev *idev;
+	int ret;
 
 	skb->protocol = htons(ETH_P_IPV6);
+	rcu_read_lock();
+	dev = dst_dev_rcu(dst);
+	idev = ip6_dst_idev(dst);
 	skb->dev = dev;
 
 	if (unlikely(!idev || READ_ONCE(idev->cnf.disable_ipv6))) {
 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
+		rcu_read_unlock();
 		kfree_skb(skb);
 		return 0;
 	}
 
-	return NF_HOOK_COND(NFPROTO_IPV6, NF_INET_POST_ROUTING,
-			    net, sk, skb, indev, dev,
-			    ip6_finish_output,
-			    !(IP6CB(skb)->flags & IP6SKB_REROUTED));
+	ret = NF_HOOK_COND(NFPROTO_IPV6, NF_INET_POST_ROUTING,
+			   net, sk, skb, indev, dev,
+			   ip6_finish_output,
+			   !(IP6CB(skb)->flags & IP6SKB_REROUTED));
+	rcu_read_unlock();
+	return ret;
 }
 EXPORT_SYMBOL(ip6_output);
 
-- 
2.55.0

