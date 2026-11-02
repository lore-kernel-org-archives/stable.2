Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613134;
	b=NN+mOXJVJxxEoXyYBbi6RxY09XFDAH0afpVNg15DOcdGWBpbhasL0j15MkZYn+/agLiS
	 nNuGbKqGriq9hyoZ0c/j2M9ylkD4alE5/u0lbO+xFkLiAgz1gfsZIGKnQt61L1V7l1rUV
	 jddYbce5GF4Ss4dq+hC4Ae9FEGnKROs4FQgB+1OJxfCjIhAWECm6m5fgGIhfSq3USwxOc
	 htdjFt5FXZyhjhxMcAtKZm9r0sN77IYs7cPx80i4lH+rjvBT4MooUVTy3GKAok1zdCpLg
	 kwf1Y196MXUrkmFW0Oagd1pMZH+tMfMRs/4BN0sn5Eb7E7pqzA8hU4w1HdhnGCyZYug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613134;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc;
	bh=mdTdMiz11OwjFDuQPUpInPXEYyjJ06QsX5+vG3JFC18=;
	b=HPCqBHmnh1+PDIG/U2gaIrmNWIMQnhTS2V+uzfJ9Ktr+TEFi8HuzGc9t2a5p2YvJ7NP3
	 eIOeR/4IFJ13PGLYbN5PXGhSsJ8JP5rMjVaV5MLIbtbZxSMPCw3Loe+8AFoCe2Hbp1iT3
	 pSCe2Z3OEiHA4fOAhVE7CFZOsg0isnwZRmfc4Xi5PiE1w6iYQlAqql+cPM2Ds3faURZRp
	 3jIg9oqWMSKSvC1NryurZxFZjW6em0uj++/RQ/k+17kAzefCn6wEyK8MG7dROpwGOrO1L
	 L8K0jJKdhOcmSVrJY0m81WbV4FFWKHKqkqRrUh/gdr6vS/w1nLH9LfA8jwotJ+2t5qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=fJFWfGCn;
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E97260A260B
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 09:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E97260A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=fJFWfGCn
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1MSTeM3111058;
	Mon, 2 Nov 2026 09:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=mdTdMiz11OwjFDuQPUpInPXEYyjJ0
	6QsX5+vG3JFC18=; b=fJFWfGCndbqsuWIFF60mPQiVr7Fd6rh4Jr8INefaF+Ubd
	hsWH21J43KSx2hc0OnHKKncajwTmpMKpLAicAdsRn4M3S3zZ6rLL9p+Q1kZWeGBL
	x/G6a9wl4tRjIj+0EPWKu1ZHg+WTh5PXpkUyza23ZFKFp+c98pcqLYX0H0VaPCIS
	vVwV554PaHxP2oQzSxqjUd5gL0UcAWOndR/oBLQVeVUSYo0NnKJYO6SpEkvw9FWI
	ojVaXNO/x7N7726KAoEoL0jOtbWg5k8Qk2ur2z6A+uzQS9eV4/4Or9ll3vL4kuVW
	zOeFDsKn76eWhR1gPC2RQ9T00rDMt21gFAIbftaww==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn6x01k0n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 09:52:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29D6Xw3047535;
	Mon, 2 Nov 2026 09:52:05 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hpq8ehupe-1;
	Mon, 02 Nov 2026 09:52:05 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Qing Luo <luoqing@kylinos.cn>, Xin Long <lucien.xin@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.18.y] sctp: auth: discard auth_chunk when skb_clone fails
Date: Mon,  2 Nov 2026 01:52:02 -0800
Message-ID: <20261102095202.1516572-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020038
X-Proofpoint-GUID: GWIlrTQvP8f__7oW92pXMZqRBR3cS495
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzOCBTYWx0ZWRfXz0qoYhhN4S3C
 rEsGq1ZozKfDThGd9hxCjwAu8WpqqTbqXQ3Vku37VtmrNcSrhYKng6du8DC8B41mWeCMj0Oa0aY
 SxfZo7MiorMiFJXGLXC0MGca0FGXMEClOLLMpmPU/DYes2Qvayqt
X-Proofpoint-ORIG-GUID: GWIlrTQvP8f__7oW92pXMZqRBR3cS495
X-Authority-Analysis: v=2.4 cv=J6g/fwnS c=1 sm=1 tr=0 ts=6ae85d46 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=bC-a23v3AAAA:8 a=Byx-y9mGAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=_JKKyeupEGsTx9GmwKEA:9
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzOCBTYWx0ZWRfX9NPUcCA6kKqW
 pocAkZsurYF2T5+coLHaObD6aWM29uuZ0nRcGxhzSHduwM9CQn79HEvKROIHDdoG6ZRQeYhfE7C
 uQq032/Wxi8SMYLfOhugcy/ylQihP7WZleRh0lBA/DKCSJJCt8R1rhGLJQ9QMDGn4G+fUuv7tz7
 SS3JDS0/fcch1usQTYCC1Y4BjzzgPTzBdwl0ooX/WD+MShoVBfvlBuFm1wcFhgkikGqjGqQhJPi
 RmBZI9OzEP8EGRKdahzmshQ78tTEPrDUx//la5NESCmlRvEanEpunpcunNa4GbpFNqjrVmGp8DQ
 tWk7678T2mq/aCVw1iGi7vkbJuegqOZ7By++3dV0RoBQGgRD0wG/FIuMn90b9BGZShyPgxG0je0
 Q4Yx5LWL35gVoUriyrUQS5fcPsaFBnCDxJoAFCX1V6wZ51Q2ZcKc13hcdsuThIhgDNDZu2KrdFs
 GzRMfau1PLHt4CIv4RQ==

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
index ca55be94e8d4..db339618ba55 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -1009,6 +1009,10 @@ static void sctp_assoc_bh_rcv(struct work_struct *work)
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
index 31e989dfe846..be2e2bb2c117 100644
--- a/net/sctp/endpointola.c
+++ b/net/sctp/endpointola.c
@@ -368,6 +368,10 @@ static void sctp_endpoint_bh_rcv(struct work_struct *work)
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

