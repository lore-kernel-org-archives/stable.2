Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613239;
	b=UznZp2//fg9r+HaZbosKpH+Jgi2k4BhVJVuT49Ef7C2ljUK/BYLGN/ypysf7v4CNAFjJ
	 cw4PsJeRtLXb6vbgDSoxFvyQghsBv7zGtwdjV9b5eiPGvaWJdAZCbYGfk1x2j7FyTShsv
	 HqB5vAjovOw3V1G+6ckYTiMbgGeojO2bVg3S2eb9EaqWs4IUzs8OMdRUtHxfHP9BxsNxR
	 cp1g1C36Pao9RfRl2I//rensAvnTMDLHRx5MAmSEUyDqsi6A+3jIpHEiH2YG+CYiHUncL
	 hlCUQRFOscvpcLAMA+Um7cAy2mnsoGV2RMVcxb79LQ9qyw8qaZ20E30yszLk/CHVzLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613239;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc;
	bh=ap3wtaqCy2sH0gafWCXkXfxFnMi494bpjxSjvVyWxjc=;
	b=rWL0khzY8wdoQpfxuuufINeNFOUYxg0StB72uk96kSLdOocM5S1bjSO26DM8oa14grld
	 bCdQlsYHwlo3xV2/MDRhdIx7cqKrHBIr9WRW6yuNoInvn15p2waEeIjCtMn4wQ48Hf+HO
	 67xyJ/FwInjqHWnaCrj+wsn5jUsiQW+zfV656pi4IzAhbkVw7VV1dGILelkRRtRdc4nhx
	 gKxnAmgT28Qq/p//BYs52o+nTkHV7z3lylmy4MpchTtLWyyxh2bWPKmJwk9qJ3ihCtiwK
	 qaOLa6FbQqRESNcf0z6kFP+5woDaIpg6ONFs5FJNoLYH/yCQyAizwRXbEQjlUEPd6IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=QuVf9uU5;
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A58C606A32C
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 09:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A58C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=QuVf9uU5
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1NaAmI3220464;
	Mon, 2 Nov 2026 09:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=ap3wtaqCy2sH0gafWCXkXfxFnMi49
	4bpjxSjvVyWxjc=; b=QuVf9uU5guGj/yHDJWLmRkCPu7daALE9yFHFr+pYRPuXZ
	VkrDkCnoB1jo6rKBmrDsymekSf7GFEKIE9in90I9eS1+xEa3+0pPowzgFB4I/YAs
	1N3ppNp2C2xUFY8D3xfIMPRpnKFbqSqb8ilHeTLjL/5H55uhKaUH68psOFYJsPJo
	hu+kbELh16ZjZvafTXEfR03mG4wteUARpzHJDY7kV4c9blBfDdxbdG6qXUW6j06Z
	SYmRNUnzaZJVCqVeCQ5ubBo45zJf1eBJ3cT39jqk/4jUERJAjWFgpv3e43HmhOH3
	zHWmnYbGvOG/rmjsCYXXn7Ovsma1IqZ0tSYnbxRvQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn6x01k2u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 09:53:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29Cs4Z2995785;
	Mon, 2 Nov 2026 09:53:52 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hpqfj9gyx-1;
	Mon, 02 Nov 2026 09:53:51 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Qing Luo <luoqing@kylinos.cn>, Xin Long <lucien.xin@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y] sctp: auth: discard auth_chunk when skb_clone fails
Date: Mon,  2 Nov 2026 01:53:45 -0800
Message-ID: <20261102095345.1526404-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.55.0
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
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020039
X-Proofpoint-GUID: 89GhaJd6CPR2vPXn-6JQMdN6fVa-XO6M
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfX5EWJBC4/+Xi6
 cObwQkwgYHRv0Y8CnkFmhkkY3/5a6w870M+tYXwKj/s7pSjmtaEazXFi6s66rgtMvVeal+nXr3L
 35Ih3+/fbIR2D8PmiG/zB0QMqoSxtIjLmIbqmNjA3RIoNbhZVjHk
X-Proofpoint-ORIG-GUID: 89GhaJd6CPR2vPXn-6JQMdN6fVa-XO6M
X-Authority-Analysis: v=2.4 cv=J6g/fwnS c=1 sm=1 tr=0 ts=6ae85db0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=bC-a23v3AAAA:8 a=Byx-y9mGAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=_JKKyeupEGsTx9GmwKEA:9
 a=WmVTiCyuxqgg3mnwYu6p:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfX58GhG8NltXb5
 13MYfInOcPEKap+/U0ehqfCJlXkAAlZ/ACY/abKcsSU41bbo6EhEBCocT9l1VBdyu5wrw8kf997
 eJH0Ppc4avTdcwdoImRBnqzWwb1mOZ5iL33s6RBbO7xuFE7DqQ8BvuugN7pAhAKOh+TmnzLPKJ/
 r5R52XKwL8heq4XS2IPSIXBd/ThbuiS//+IHeWOQNgm47GWJlxmJ4DgZH6+X/LcjeOFCofEP0in
 QdKvEbIJSv5fdI558oYRfD0fRKKPjlcBDa3s/MJ7fqDP3uEB8FGAdtXxO2TYt5fHfwwXXisRLa7
 UR9N1GUR/snqfBZz9TfCCNxyOrDB/dNV9JMJywtCArpSyIDH2X13bT5SyCFU6iJqzug7tz1EUT9
 OHogL34Y1ADm2hd7lqNgURPkYxB8vDSN8OHs5PrybOrnhK4XxfwnpuStRemIPdc1Hljp7Qejzes
 9nELx0mUgEVkghGoyYQ==

From: Qing Luo <luoqing@kylinos.cn>

[ Upstream commit 9ae7ed101cf28613071ebfbc42668c8917a670cf ]

When processing AUTH + COOKIE-ECHO packets, if skb_clone() fails
due to memory pressure, chunk->auth_chunk is NULL. The original
code still sets chunk->auth = 1 and continues, leaving the
COOKIE-ECHO to be processed without a valid auth_chunk for
deferred verification.

Discard the AUTH chunk early via pdiscard when skb_clone() fails,
so that the receive loop can continue processing remaining chunks
in the inqueue instead of stalling the entire packet.

Signed-off-by: Qing Luo <luoqing@kylinos.cn>
Acked-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/20260723061107.384106-1-l1138897701@163.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/sctp/associola.c   | 4 ++++
 net/sctp/endpointola.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/net/sctp/associola.c b/net/sctp/associola.c
index 0a19aea3b524..9f90cf8f9598 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -1027,6 +1027,10 @@ static void sctp_assoc_bh_rcv(struct work_struct *work)
 			if (next_hdr->type == SCTP_CID_COOKIE_ECHO) {
 				chunk->auth_chunk = skb_clone(chunk->skb,
 							      GFP_ATOMIC);
+				if (!chunk->auth_chunk) {
+					chunk->pdiscard = 1;
+					continue;
+				}
 				chunk->auth = 1;
 				continue;
 			}
diff --git a/net/sctp/endpointola.c b/net/sctp/endpointola.c
index 7e77b450697c..ffb7e722c9ea 100644
--- a/net/sctp/endpointola.c
+++ b/net/sctp/endpointola.c
@@ -367,6 +367,10 @@ static void sctp_endpoint_bh_rcv(struct work_struct *work)
 			if (next_hdr->type == SCTP_CID_COOKIE_ECHO) {
 				chunk->auth_chunk = skb_clone(chunk->skb,
 								GFP_ATOMIC);
+				if (!chunk->auth_chunk) {
+					chunk->pdiscard = 1;
+					continue;
+				}
 				chunk->auth = 1;
 				continue;
 			}
-- 
2.55.0

