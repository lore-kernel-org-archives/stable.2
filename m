Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614390;
	b=MLrhl5p7aj6NE8SbSYoiNzaymxK97W/KvXmVAjK6AJ6t2lc+Lxf1tg8W/ip8mLApSSZv
	 u05ZppopDRHfr7K7iE5yCESIo9bUi3ome5cWewVbAnqJIcrAJV6z+oclMfvVNaBOApfyr
	 7duqsogvb/uEYy4R/pWXgDR+yFfmeWLcn50vgm4nsTKEuWfiSRN1phm1SX43KokX3dyQr
	 gXeu3phUJ/pYdcUMFYEcbanynK2oHZTfFhZSt1IeLCTSAPG+pCQ59wco0tJQSSXp9gUJG
	 S0mmdQBIm1yOEcCHiOBV5xbyMzefNgjpyeGwHGomcUs3w/fHNuSydbhO6A3jZOed+IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614390;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info;
	bh=WaWeQql9T1CR583EusQmkcGv4tOsFtrdG/YxEXx1uio=;
	b=rOSR+kYqUTRu5Kq0Em1cvGong7Q541sMjJ3s6fjgKvoGsGvipoLIVt8JCLqSZvu3oG1S
	 U8xk/zhtodytZV+5ic4L2nGN/ycdBDMgToTJgpr9NrBCvOxW7/HmvtANeFWTEs64Oowet
	 +lk7j5DioG0IOujrR/hR3Q3jyMHbW1DB1L+u3n6qDDX9sRHsEBMWWbQrDa8LIrRjSrmfd
	 V9bOx5rbBrMldNhyGHjcbBkKB4AaFOCUTTY50xDyDffBeln46aquwt/Fxd0FfY7C9o7In
	 XIPTwmRS5embJN1nXzwcCv7S27OCkpbBXExIQOoFltSIKlnU6Zh63+iclnzeU310ZBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b="PY/g0WxC";
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BAA60A2624
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6BAA60A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=PY/g0WxC
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1Nt2sk1181321;
	Mon, 2 Nov 2026 10:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=WaWeQ
	ql9T1CR583EusQmkcGv4tOsFtrdG/YxEXx1uio=; b=PY/g0WxCgBGoU2trP5SYV
	VmEFRhp6HT8Eh1IhqBF6sYKRrIekEmU/utlbyCuZD1W4FEXkxEgpyuZ66ZcakEZH
	QD2IDHW90S+lr6PRjDLruR4jiyu6BYcxz6jjQ9wOVtccZd57YO/yhbd7XEl2Ob8d
	jQSkN3ucZmr3rZ23M72dHXgEx2yy6Cb00qZ5ASZO6NkCPHLtU7T+wm1l6g5yUpR4
	JjOT0OJZmcNcWmY52q1WIeqtpLNaEtV5clMPe+CgcZtihRC3Gakq88l2+lyq/yZD
	tFN1TYPjf1BJSBSKFcXvN+5mOVY7GbDXtZdtqvoVNow9JU5Gk8OPVUcW7VT5saAf
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn876hk7x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:13:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29CqjN2995687;
	Mon, 2 Nov 2026 10:13:03 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hpqfja56j-7;
	Mon, 02 Nov 2026 10:13:03 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Qing Luo <luoqing@kylinos.cn>, Xin Long <lucien.xin@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 06/11] sctp: auth: discard auth_chunk when skb_clone fails
Date: Mon,  2 Nov 2026 02:12:34 -0800
Message-ID: <20261102101239.1557688-7-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: qFnAIWVQNxiYfdzEMf0Bqibb_ONqoS4r
X-Proofpoint-ORIG-GUID: qFnAIWVQNxiYfdzEMf0Bqibb_ONqoS4r
X-Authority-Analysis: v=2.4 cv=JJauIMKb c=1 sm=1 tr=0 ts=6ae86230 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=bC-a23v3AAAA:8 a=Byx-y9mGAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=_JKKyeupEGsTx9GmwKEA:9
 a=WmVTiCyuxqgg3mnwYu6p:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfXw0imxpyhYVAm
 sLMu8v4uJ/2gqdPc1cWf4uQQbM2QM52CUXPotHUNX1LPvBES7Jx5wwPtrcWhxoAxhBGTxRTj84o
 pPLBy0R4GiU3mVoSSchv5yfjHVvPeBv4qco+DQigec9hRZnT8eLzv38ohpBZ83Run2xvFQEGU43
 dLIPFbR5d+//jtfx5t3rBOhm9W48LVW98y2If1BH1UufX1kgTVeYOruKZTQLiTHPMJ8+as1z/0z
 BukDs4cxclj5eqS5pc/vEVm2HinN6onjvmBVOdi97ldvhB4zcTbbf/Ouj56h6IxWO5EGhE94Igc
 Y6ZyuiKjXkgosOlfYltGcckyMvJEMObp20V1LaXjtLm13WjGjWI+zaahZz0tewiit7fgZRIYuhk
 RlmLwqbj0T2+NjKZTfmMswOyD9JMCZJ9ZlvYs/WVq9HB5aoG+i9/KSLwyiF3sXcPZw6RYqg//Jl
 OJ2OgtAXMiFBac36+Nw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX48KG6EEImmNe
 NqvkS5YW9YMkvXF1e3k3mASns67HSnjoKoiKsnuJFz1uIWuiKa0nSjmAx+rjtYeoVYaew1whL9g
 nOK3Zc72f6AQfmMnotKUjr/sdZKKyKnZpy01oUU9wvp7K59BWqYw

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

