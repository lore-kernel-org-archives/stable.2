Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614407;
	b=I8fOW1iSv4oBHKS/12SWnEIiBZE6Vblgdba5jzlKmQRwPVNdVWN9z5OtR7vllMxFFmvA
	 7UQvd4i6fKndrQMMvZIj7xPtTB9iTjaq2z0eUjZWmXOtiLVjwySN+62GpbN/HfpfDa8b4
	 Ha4wFKLPsa7pvEsrZAkywKpZWxtcQVOtrZF8kosGkZeQAws2mTVlEGKUp8kJLc3ZoiurX
	 4Ufj4XHPbZnuehxdn7Q09499OZYskB7mpXe7pDdeadsTDy0KHDFnjiBKef79hklfPPMl9
	 pr/nSl8jE0eGl+Ibb+eTyFNgfBCySG7doCFtP69OesXwVqleYU2+lK/bQTILbqh01lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614407;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc;
	bh=WxP7qV2fviklkpdMSNR/tgSx02XzzkWo4C6zDhaPBw8=;
	b=3i5snshkL2J+3W8ZnAEbhKZ0PV7cmWEf94dayMFiFfMN16pAJubdCqUkpfVisk0Dc9Bd
	 ubu+tRv+7JAX5xKTBVbLjjGyGWk6/seu6e7G8XDUVrcg7K+K7aVT9tH5qAmLdUfd0hp+C
	 u+fv7vN4Bs338fiOZV9+4jVsAxPAqYMKODdRpZUMgtTR3zk0LJWK/gyL0y019eOTys8uu
	 TzdOnGUQrqxQnDZaCMEFRzW6TK2Rq0v88KHFg7TCelIRa+ziODUjGOBW9i4BTLdOhqArx
	 0JCIeyBoAW1HKQ05OQ/0JlQdycbU3C0I5AG4HicOWkvgAOwfpgX8Uh7dR1WrapTwGpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=iafkMn9Z;
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C00606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50C00606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=iafkMn9Z
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1MSTgH3111058;
	Mon, 2 Nov 2026 10:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=WxP7q
	V2fviklkpdMSNR/tgSx02XzzkWo4C6zDhaPBw8=; b=iafkMn9Z6S+FedLSv98a6
	5RHJPMYizo0LPUJB6iV53Llds/g9RofQglCESJioKjqk+2bU98ORUDDcPAQ41ZjF
	Gbmv8lUu4gafxQD0uSEoQjV239TS6TXvF3v5FZn2BxiBgj0Z9cC0SPEWtZDfZbLz
	KYaQ0xZQDkF87hThabYFh6YOOUzZZyL8Ywp4kMX2I4k87TnYna7JA5RT7MCNg+Jp
	OI6jgOO5hQrmE2HBYnqH6ZL6FpdOjq6vtboc1AboeL3tT6VGFPd+c+ne2wp2fdQe
	4T/YAzo5YmiXME6yF26CpsScx/S/dU5FjdgF7VfA1z7Cq1bxyhROrhVe6ISA7ZdE
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn6x01kx2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:13:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29CuOe2995840;
	Mon, 2 Nov 2026 10:13:06 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hpqfja56j-8;
	Mon, 02 Nov 2026 10:13:05 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Yucheng Lu <kanolyc@gmail.com>, Yifan Wu <yifanwucs@gmail.com>,
        Juefei Pu <tomapufckgml@gmail.com>, Yuan Tan <tanyuan98@outlook.com>,
        Xin Liu <bird@lzu.edu.cn>, Yuhang Zheng <z1652074432@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Wengang Wang <wen.gang.wang@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 07/11] net/sched: sch_netem: fix out-of-bounds access in packet corruption
Date: Mon,  2 Nov 2026 02:12:35 -0800
Message-ID: <20261102101239.1557688-8-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: 3ICpIw_ApDU3a0soAonUhbzuoMD5DQ8i
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfXwzjq3szxBNcc
 uXf6DNZ9tR3SNW1e8GlErpIy2U9Sp4B3y9YPQAWvs3yYvRJzyov+J+YE2V6HXL9dFghlsGuv9uW
 scei8uL7MIDPQ6dFwNFrslF3nChxXGb7zCUy2percEAHbpdB9rAX
X-Proofpoint-ORIG-GUID: 3ICpIw_ApDU3a0soAonUhbzuoMD5DQ8i
X-Authority-Analysis: v=2.4 cv=J6g/fwnS c=1 sm=1 tr=0 ts=6ae86233 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=UqCG9HQmAAAA:8
 a=jZVsG21pAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=9i_USOwr8XsMwLcr2esA:9
 a=WmVTiCyuxqgg3mnwYu6p:22 a=FO4_E8m0qiDe52t0p3_H:22 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX9aFbsgAi7g1p
 cUmnJbAiC+v3R4/REMn2oCCEXkVBcANxkxr5txK+JXDOzc1bB9qqleFLD34+zvOgWOR75GBO2om
 jGD8mJICbKJQO0iIpzJongvc0fY/NmiMqkLY9e1V+h9A0z+D/pCmeOy8S+yZ6PtAX18qox5+nJ2
 /DPVvA25wugs66Ox7yvcyFiJlTVOCvkRi8KiVrvMa5XejOz3S/mrCB0gSbyhjNiraug/P+bpSuF
 WRKPy+aGCOxIj+/hv63OgMibwpIc4ZstZrdkeOg1DY0bIb4lnL1l+ivK88UPdCJqLU8I8Nr556M
 F6Cd/myjB3HHHgG8oo4Ngv8xkRfLRIGcViosvTpH9zD2AUDAysSmT/GURf/dur3nSsvzVoY315p
 /B3ZLAipvOVbh6ZNqalAuBoqMUg4HqSTqie+Kvfmo1XVsB5GwNK5zQLP8m1O+q/zBQ9NT661Ea9
 XE2dYAermIP+c2teUiw==

From: Yucheng Lu <kanolyc@gmail.com>

[ Upstream commit  d64cb81dcbd54927515a7f65e5e24affdc73c14b ]

In netem_enqueue(), the packet corruption logic uses
get_random_u32_below(skb_headlen(skb)) to select an index for
modifying skb->data. When an AF_PACKET TX_RING sends fully non-linear
packets over an IPIP tunnel, skb_headlen(skb) evaluates to 0.

Passing 0 to get_random_u32_below() takes the variable-ceil slow path
which returns an unconstrained 32-bit random integer. Using this
unconstrained value as an offset into skb->data results in an
out-of-bounds memory access.

Fix this by verifying skb_headlen(skb) is non-zero before attempting
to corrupt the linear data area. Fully non-linear packets will silently
bypass the corruption logic.

Fixes: c865e5d99e25 ("[PKT_SCHED] netem: packet corruption option")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
Signed-off-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Yuhang Zheng <z1652074432@gmail.com>
Signed-off-by: Yucheng Lu <kanolyc@gmail.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
Link: https://patch.msgid.link/45435c0935df877853a81e6d06205ac738ec65fa.1774941614.git.kanolyc@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit d64cb81dcbd54927515a7f65e5e24affdc73c14b)
Signed-off-by: Wengang Wang <wen.gang.wang@oracle.com>

Conflicts:
	net/sched/sch_netem.c
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/sched/sch_netem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 3e3bced82c56..6c206c97759a 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -508,8 +508,9 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			goto finish_segs;
 		}
 
-		skb->data[prandom_u32() % skb_headlen(skb)] ^=
-			1<<(prandom_u32() % 8);
+		if (skb_headlen(skb))
+			skb->data[prandom_u32() % skb_headlen(skb)] ^=
+				1 << (prandom_u32() % 8);
 	}
 
 	if (unlikely(sch->q.qlen >= sch->limit)) {
-- 
2.55.0

