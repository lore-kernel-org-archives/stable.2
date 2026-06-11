Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B091E304BCB
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184561; cv=none; b=cPLOOc8AGY/k7TKrtXBtYHTbGiDVGbewPHwkGC6AglVq4HmC/jYsuUJcirrj6LyBHrBSqU3H0mq1VxXbqCal54I7pimLZZ4I1pIZi/WvTvRl2OYBm5mcjViXuI2VpAoA6yup02pUVsbFdcGdTUr6BmkIWiqtk/0W2oi34JXh2Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184561; c=relaxed/simple;
	bh=kA+ELX7sqCCc9ZFq1sCrJU2v1Zzn9kpE0MKK5Wy8kIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=juEl5n4ro2MA1tZlle7jsJSPG4FrGX1cLo6oRXY3FYxbL5cWYCoaR50Ut0+EfuFAYg30mJxDbx6OOJfCIVVUsoPYZFkA9XGQSd6FmVCpFXnyJQ3QPswd24kaswMDpybvdd+wwAfDKl7XWMq5x9CPFHihYbwA7SqXC2dIiFOQ0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TLwz2RSq; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TLwz2RSq"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BDQkhW255080;
	Thu, 11 Jun 2026 13:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=bx+t/IgK7gcS5AsNidzFgeuoZakuZ
	OSUD0nlkIg6M1I=; b=TLwz2RSqMzOc/xpFWaHheRZ6wtPrifUcEUioTP7TseBlg
	MayiO3d4AV8oRDyk6NfIl4jJdgvpysk95yd+NOBC95ZiPNwqwu7QM+DrZi/f3PxE
	jGbTEsObJhI8bu8LS3ZzPb00p3aYKfwZFtkz+OlP8pZtPykGAMevNe/F7aPEXdYe
	SQJ0BkJ/zvch/qRBTHW9XlGNn4BldnUDsieaahe9m+3cPJClg2KkzTFwvKkPQZdy
	7Z++ng4qMNzkvIL02NWVSr16WJYKjln+RTOaIwA3DFAGfovhI18ik2qF7hM+gzDF
	nBSC2VXlrOGnTdq8+kJqhbJx/nZ8piv6JuZMDiPqw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eqe6y181r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 13:29:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65BDSeT0020245;
	Thu, 11 Jun 2026 13:29:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4eqwn60qqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 13:29:12 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65BDT5rc024623;
	Thu, 11 Jun 2026 13:29:05 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4eqwn60qfb-1;
	Thu, 11 Jun 2026 13:29:05 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Weiming Shi <bestswngs@gmail.com>, Xiang Mei <xmei5@asu.edu>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.10.y,5.15.y] tun: free page on build_skb failure in tun_xdp_one()
Date: Thu, 11 Jun 2026 06:28:53 -0700
Message-ID: <20260611132853.617320-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606040000 definitions=main-2606110135
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEzNCBTYWx0ZWRfX5lIcT5tEQh25
 oCR1sgSGenv8rULSnfisnsncGg0wI5+GySv7ut1f2NUvSd62gJLX8XJpiWy8105jM165IZjJXjD
 ZaTL8cRcgn+FX+Un/K4yUhS04grGw5rFKb0xGU2hioLmRAPO1KxqyV43SJ3iJtQedBXU3iGIJim
 Wxp59hR8ih2drQoxP8DNFTYhnctDLzj8mCKittvWxeAN+vfNe5ftZnpyTfMkxNSc3uBoSpqQ487
 rze+wyMuO2apLDYuBJ6xwouMF5R98T33dizZ7g5cmMqiWQmzsa/803O6ITeGudMZD9f4spGWCAu
 cDfiSGk6b6aQE3uBKILXhzz09KVnE2u9Zeq/tB8VeRuK3GaiA6IYIcbsrM//omJQZXjlVfjI2mY
 29A9y1whqbHgBh1729gjnZXjyvguOYn5+yW1hoAXhWJW04RLLZP7ha9WAgA9Fd85/fr1h19Rc5v
 ksAzAQtT3H5Lnip22tKiXpcjFPVCWlYUFpt8KH6s=
X-Authority-Analysis: v=2.4 cv=GqJyPE1C c=1 sm=1 tr=0 ts=6a2ab829 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=JtBfmJAPDU2J1nMF1nwA:9
 a=FO4_E8m0qiDe52t0p3_H:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12313
X-Proofpoint-GUID: lsNm6ClH6JM5N64XIg4TuzPMQ2_r8w1H
X-Proofpoint-ORIG-GUID: lsNm6ClH6JM5N64XIg4TuzPMQ2_r8w1H
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEzNCBTYWx0ZWRfX0WMMF+B1WymT
 23I1sPRcPomyOP3Z6JnRHBRmkeg0SY6ASTmwmsjdXQuZOD8IHACf5PSSgKgowGmlAfcV9rAT6Bv
 fYoUPjj63ALQXxj47vKRPkYUdQ4U/Hu443um8MujhuOcjYv0DbMy

From: Weiming Shi <bestswngs@gmail.com>

[ Upstream commit aa8963fdce667a42fb7f0bdd2909fadcab02f9a8 ]

When build_skb() fails in tun_xdp_one(), the function sets ret to
-ENOMEM and jumps to the out label, which returns without freeing the
page that vhost_net_build_xdp() allocated for the frame. As with the
short-frame rejection path, tun_sendmsg() discards the per-buffer error
and still returns total_len, so vhost_tx_batch() takes the success path
and never frees the page. Each build_skb() failure in a batch leaks one
page-frag chunk.

Free the page before taking the error path, matching the put_page() the
other error exits of tun_xdp_one() already perform.

Fixes: 043d222f93ab ("tuntap: accept an array of XDP buffs through sendmsg()")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Reviewed-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260521163312.1479805-2-bestswngs@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit aa8963fdce667a42fb7f0bdd2909fadcab02f9a8)
[Harshit: Backport to 5.15.y/5.10.y, use err instead of ret, no change
needed]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Build tested, contextual conflict resolved.

 drivers/net/tun.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 5c9e7d0beffa..7a2d2fa90b81 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2466,6 +2466,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 build:
 	skb = build_skb(xdp->data_hard_start, buflen);
 	if (!skb) {
+		put_page(virt_to_head_page(xdp->data));
 		err = -ENOMEM;
 		goto out;
 	}
-- 
2.50.1

