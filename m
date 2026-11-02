Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.177.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614903;
	b=zGfwzCLX5r+L0hrZTnKzdohRJrKbXh2vSwGG8zlJ4JBxR/QEwh0Da/OQAlQWjlG2/cag
	 o13MrL9lBYEKBRbEUdgOAOL5RCZYugG+Hs1juRVtVG1nFULydd/KuObxKOdrCqVGQXEqL
	 RrOd/PZpcPAVVTvzZHB80gHcFLJDaTNJ6nC4az76oZSXtEnEZN44Hj6VsQXQIbptGNjis
	 i8qZ2cvv96Ox/38GqSIkjfBJ5+fG96IIDC7PUYf9W86MkSuoi2tqfw5BD0jxWRaPa2vVR
	 5H1OFMQj64o93JBX1pjQVtP+BXSkL6KthZgfKaOXFT0TjK/S9XSojifi5f7JnYJeVZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614903;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc;
	bh=OyuIekzX2H3dt85C40PmF5/9+dw7ODKhM+xJmU+z0gY=;
	b=MGD2Emjc10lN1vmVDV2nawTHy1glt06f65Rhk76OHo7s7xyBayFhq0ghtPxZLh2x+b1f
	 UWLj9YFJLDy9WvFGyprFUthCjxkG98R398IclgqYacr/dZK9ncvy6bm2Dv6hK8HGp638u
	 l7T7gmgHXcbmE0kCqsmnqluyqLfAaaRJIMVhzjy0a6XjClVh5CpbAOBWt7N7mNjklpgJ5
	 v5HzofaY9AQy/aILvGiu96maP60L2nIQjf7J4RuF9wQvuXRGhv2zRIagkTtRzPNfvnV63
	 +Kzq+tSGYYUxurN/PcRDdCit0CJmwTK0jReKYe3TBBDRTLHqHihN+ayT3KHoGSy3T9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=IsRDVnjb;
	arc=none smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792C8606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 792C8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=IsRDVnjb
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A20e3Ru887237;
	Mon, 2 Nov 2026 10:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=OyuIe
	kzX2H3dt85C40PmF5/9+dw7ODKhM+xJmU+z0gY=; b=IsRDVnjb6tGTIsTjPWKMD
	PzvyQ44+fH9tqUjT5ngumvfIZ3AYQN6gEvGux1wkaGEypZtnml4967V9TRHS8TFO
	uMZaEbsRnAWIW4um12cZrEAoYExOAB2j6jeIDT2KZslOTaMMFK9a/CzkpMkZXxRB
	kr1Qkn7LqHSApqLikeuWAl36Y9JuXHHovtxMjgvZIqKmsALIwXa4j/L7cqPYkHUF
	9+7AsTVMpIP+jNb/6Di3vW1OlI1klYwKKYIEgdNcSpBrXHEkT8fIK88EJQ+QsmtN
	C+sr13Traq1xOwB2wM690BxGNyJ9Ppiog/phPnsTzMX8ExIBAyEZgNCCkiAcZ38a
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn7431kxk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:21:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29D2oG1424341;
	Mon, 2 Nov 2026 10:21:22 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4hpqhua27a-8;
	Mon, 02 Nov 2026 10:21:21 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Yucheng Lu <kanolyc@gmail.com>, Yifan Wu <yifanwucs@gmail.com>,
        Juefei Pu <tomapufckgml@gmail.com>, Yuan Tan <tanyuan98@outlook.com>,
        Xin Liu <bird@lzu.edu.cn>, Yuhang Zheng <z1652074432@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Wengang Wang <wen.gang.wang@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.10.y 7/9] net/sched: sch_netem: fix out-of-bounds access in packet corruption
Date: Mon,  2 Nov 2026 02:21:02 -0800
Message-ID: <20261102102104.1558500-8-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102102104.1558500-1-harshit.m.mogalapalli@oracle.com>
References: <20261102102104.1558500-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610300000 definitions=main-2611020040
X-Authority-Analysis: v=2.4 cv=OpXaWC/t c=1 sm=1 tr=0 ts=6ae86422 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=UqCG9HQmAAAA:8
 a=jZVsG21pAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=9i_USOwr8XsMwLcr2esA:9
 a=FO4_E8m0qiDe52t0p3_H:22 a=3Sh2lD0sZASs_lUdrUhf:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-GUID: dcIqJqpjW_wuz0de0O2mLCed8Pt_PGAe
X-Proofpoint-ORIG-GUID: dcIqJqpjW_wuz0de0O2mLCed8Pt_PGAe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX7B8QsUP12vk6
 nciuUNcod7r0OjQZ9XhG8CyUY8XfRl81veVstRcp+AHrlHcc8WM4b+vFNmM2/eyl0Y/pygD/jf1
 bpUa+WKRL3j9nxW8IoWVABLwtX7mX1YlvxMdlgPVTQRCh5b4m6IX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX9uHOXDrO9yMq
 yo+chgMJbHaf/eu73OJW40fVLtrrk1PYqIUNIaLoiC1cYNyjdZ5EfEjTxH3G79/kKBocrnCnYae
 vlw1BC3eVhzolcBpVNl6F8H9jqpKR6lnfoOXTbeK6LdwU3r0FQFCI/+L6RE9y/YbAphRfnZpDBA
 HCIrKCgbZKCgSZog1rbv2sDGXqJE7DtxA/IGgJ05zT5Vp50d2a7vkPjoZu49GvtvJAkxaD2EQfL
 lpW7dmCmuqqIeqQy/TYb7xastL81jckxReLnz/J+mmIm71lUEUCzjX2JaeugUsrjUsm3DPC7AF3
 vJYIxOKF+YefW3NL1+s6ieX7DnOws4yxCh7u/rZszn5+SF5EvrnwI3GVusW/uOO+bQ9jhoMQzrZ
 SCiga2dF/wvFgYzSiMqF7LfdkufJO1Qnm2p9GEadnfktW7/sJ6TuFsT7F7VeOabbrPkB7+quNuE
 qvNyFZk8KRqYQ8/9zNECGvb5WOv5FymtRemVD+W4=

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

Conflicts:
	net/sched/sch_netem.c
Signed-off-by: Wengang Wang <wen.gang.wang@oracle.com>
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

