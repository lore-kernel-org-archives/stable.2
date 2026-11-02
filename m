Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.177.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613794;
	b=SEKffjLZ4nDFhf2LQs6yIHj36R/LBwz+9ihrGjaswkZGPV0WZ92t8M7Ha2PUkZF3GpAD
	 Wx6LjVS3wnOVwd8Sm206LJMC0aFtrD1gFI1J8cRaX1t/OsByRpk2jfGMfMaTURG2smvHT
	 1YG5dIarzBd1QUCw0b7letPWqd18ClthUdGJbrDqVHLRBJvSmbI4LslyaJ2Rt7Ts6gyIV
	 DG4HSlgZmFHpo+KyqwpODJEj1qnTwRYOSeO4KCpFVFuvVi51LATQF+1QtI1VQy0056P94
	 C6kxWBKwnSJQ/2dwbG48Y9sJSC2ob4duL9a5jQq7OuqcIrZ5u2ZU+h5z36SomkI3ntg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613794;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID;
	bh=WaWeQql9T1CR583EusQmkcGv4tOsFtrdG/YxEXx1uio=;
	b=oOcrFb8W1+oBSbdh2eka1HDLec2MYuXRtmZkTqdt0QK5BOvQ4/eH10JyY+1cyQ97EBbB
	 6EhRbYlNFDhjLWftQYGQfUY89LFgBm7R3/FpNnETr3inrNGh/IPgBT5naBfIXL77DlMta
	 ihAZBpfDgojeBVYO5Nho1piwpmt/sZbSVisCigBcHeHAspEQLbrfhSZfol037kz55XppE
	 7JFdgKXMedx+8pnh5LTQkdBa9zzBGn+Mm50i34nSdgU0ySJIsOi7Kkcpv+IIs4JuM9vOt
	 iiBe7D8L7a5phLQA64LzFurZMAahQpKdoZVqCZSsTfGZnfmnXGOObB2RH5MhKQqSrtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=jFAMxPw3;
	arc=none smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB957606A330
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB957606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=jFAMxPw3
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A20U1L73917987;
	Mon, 2 Nov 2026 10:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=WaWeQql9T1CR583EusQmkcGv4tOsF
	trdG/YxEXx1uio=; b=jFAMxPw3tvgtwXnRB5FO9DxyoGNvtoAeg7ozuIxtXqefX
	tzg0rQLLeZs+lmeW6MWa60DLpek/rHdE3YYhk1GxIzoHmwUxDl6fC+I+OSxLTGmZ
	seQwFlYnNsqNy2Z/8SA8ZR0Mw2tJRf5skJ02FANXtr/4WiVOVY87nifDXmbQiR0B
	5VL/9w4BO2VSvhgq8+CdPhYArN1lZNqISCC23lAyuTOzQ5gLnLe1G0KkYpv+uHwb
	bdnB4mfqZBiGC4AdnlLdslZ9vVJja7q6nCHJ/t5b4wAMA+5cWrpANfShQsD2cm+T
	mJiKjf4sGFkuiPKIeAiuqxIrcUTRlGbZBWAhx8zsQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn6r9skr4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:03:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29Cquq2995680;
	Mon, 2 Nov 2026 10:03:05 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hpqfj9v9n-1;
	Mon, 02 Nov 2026 10:03:05 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Qing Luo <luoqing@kylinos.cn>, Xin Long <lucien.xin@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.1.y 1/2] sctp: auth: discard auth_chunk when skb_clone fails
Date: Mon,  2 Nov 2026 02:02:59 -0800
Message-ID: <20261102100300.1546414-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfX6t7ZEF+XwYRc
 vfanY22sD8zCJpEMvTZLh4asYtwJ9GnM0ZLTcDeVNg9D4Yqi75z5lRl3pf82c98WdE9VecuEr+N
 blk3vhz6yiAQ9ycarp1p/gLn5r4CsuqohEqThX4OTXJZ4PogtKgR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfX5WRHjFuhZ0N6
 RzQiU0NMaShT66KjMXZyBYVnBwkwFPY7Oy1pxtEDeiEnKG6t29CqraMhcqgmYliFWlvpSLc9rvU
 1/8ntvAQsJADNzDw0yQfzfWm6L6freweVCo9wnqgpEE/L4IoKppmJTyR9zNooFQxUQF9dBhJmg2
 2MvwVL+iesJVZpL/CV1q40KJRvWDHgNUoZOQN6wz3hSc8T4vpuLYIWD0/8HGyc3IdhjOzxipkK7
 aFgHKLF4A6BhCgXA6msE699Fb2ThIe8xQBIb6GEi5MvmVFy1pi73gjzAULqJF9eH9n83d7kpU+A
 ooVxuxZHviedhAtIaS53UfjI9G4RhAa2tO5ljmC3vJsJMEPtHRwZwXhDfkqqV0dtaypd9M6P6jt
 fly+wHk3s9pf8o4fsZdfrjGpsVCgJEby8Ux06seQPRHTC6ZRYByxbJdPMIO1aNbZc/uAuaJoLIF
 8QOgl3cdQ/WPC5CKKpw==
X-Proofpoint-GUID: _g0IyIDQb4U7EmrHz4EB5ETxcECyKV7m
X-Authority-Analysis: v=2.4 cv=EdZd0/mC c=1 sm=1 tr=0 ts=6ae85fda b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=bC-a23v3AAAA:8 a=Byx-y9mGAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=_JKKyeupEGsTx9GmwKEA:9
 a=WmVTiCyuxqgg3mnwYu6p:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: _g0IyIDQb4U7EmrHz4EB5ETxcECyKV7m

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
index a957142672cb..5149f744eaf2 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -1029,6 +1029,10 @@ static void sctp_assoc_bh_rcv(struct work_struct *work)
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
index efffde7f2328..2313ea9fbe06 100644
--- a/net/sctp/endpointola.c
+++ b/net/sctp/endpointola.c
@@ -362,6 +362,10 @@ static void sctp_endpoint_bh_rcv(struct work_struct *work)
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

