Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.177.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613385;
	b=wSG3Y1Efdh+V3miJOM13TvQC1Jj7LWV2MqkaV4a8NF/cYg/O+LqSJCICejCD0P3LSdBi
	 6DkPfZIO2+CHqFhMekncECsZJg6yszpi5c28YXKJdVZgmXNUvjU79eMrIo0v2SIYRvd0a
	 bDMfZ3AjqOHsrJUMZSUf6DwuF7gC7UdTLRFm5D3GgLtghK2fz+ePJEmE+jB1sQhFkl7sS
	 WHM/p/M2QYyuOzkF9zZ5LI74VEK/vrOOFbtRZuEcUmwrTiBPTnpPIQ7Nd6gdEPRO/VtGF
	 0/slUPvZNzTLarSnDl8niv6I55fMaumPo7tgvEaTjaF63JYBCUn+mQxrkcqO5TbuWsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613385;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID;
	bh=ap3wtaqCy2sH0gafWCXkXfxFnMi494bpjxSjvVyWxjc=;
	b=0hvgYLg211BndjbxozR9ojpAdpItNzxZ3pGgSsBv325FjL13ohtbmi8oJuFDkJqxoozX
	 COmHETaoxSbD17tBjtWuoiTbR1fiPY/jSjj2O00L5Ud233ygcRFBNs7wka2REX8AbWRf5
	 TfRj2xwS9gRw7h3YUfrNqu9DhmCflL5M7rfc92QjqEhqb6QV8umeA6gA/7uTWvPZl/ULq
	 MgM31MPrAdFpStKWfjhHGuju40kD/DoWHdLlBD2LuKYLhXqJgrqlXoPzd0AsaZLfUyVqA
	 qEiJGIMggyxyHE/j9EWkDe5Ksgchaa2JRBBt4gLX7x7EkDKabYYKd+kjj4y29rCaFzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=ZuBqJ9L3;
	arc=none smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BBD606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 09:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9BBD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=ZuBqJ9L3
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A24Mcmk102338;
	Mon, 2 Nov 2026 09:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=ap3wtaqCy2sH0gafWCXkXfxFnMi49
	4bpjxSjvVyWxjc=; b=ZuBqJ9L3qlvdu+priI8FtiZKipHBEkP7NaKkLHvLat5I4
	OXMNttYrDmRwMJRKOlCjCdGvXa+AOi/jzzyZQRWRynyVUSvITZS/MlFhLax3OVh+
	TWAj7sttC8S4EdB98pqueMrc14FmDaeGDvKVbyv0sZqSJaRn65QKvkI6McO5Nw75
	evDnrYAebiqZvMW/cz3iRux+JVh4QoWg8vlUYOTDwWYw56Zy3FMXNzVaJmM4fipB
	x2MYv20YwQM4mc+htUNtdeAB5I1W7SDMXHiArpBeuoEHeW9H15H8JZre4HPIA7pk
	IWpruQ7G9LVsd+7JwsvCHiGjO0mOzaxRvU98P7paw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn6r9skfr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 09:56:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29D2cd1424341;
	Mon, 2 Nov 2026 09:56:16 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4hpqhu99ww-1;
	Mon, 02 Nov 2026 09:56:16 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Qing Luo <luoqing@kylinos.cn>, Xin Long <lucien.xin@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.6.y] sctp: auth: discard auth_chunk when skb_clone fails
Date: Mon,  2 Nov 2026 01:56:12 -0800
Message-ID: <20261102095612.1536236-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610300000 definitions=main-2611020039
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfX6BvlvnVolu4K
 ofY9PYR4sWLLJBLYCvCKgaTL+PlAl7RnHkb+bXPw1x8S7B9Vph+cI4iP1XrGdBRavOuXuR2hkgB
 yhuvRT12FuEjf4VxeqmwqCwk4mRkjQaa0qgBmRTMefwbbJWHnovJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfXy2gz+LqLI/EW
 rG6fI2IUTlJMYGGMzsAMIldsYQj50RZuaCqR881LsFStmUfWw4if240DFHVKiRKAWbgmFuluxnj
 MwZczO/o8dUgAwS9ypmvU5WJx5xjq/7mZBLSmyOEupTk1qFqJAsiCzEO7eYP6fm1YFeMq3TSbHg
 XxKnmjlRhTLXLFNP1uzImiKD0xh+kGHv50P8AMRDJMG9UteqHU+r4TP9xh4JldSoELPwNyyiTGv
 7ZKuCY/ZLkpWzIspJ57XuGtM+CB5/vuskvv7OhK1qw7gxrZKBBQrtDtanAvp1IPehxnasg4TzQa
 q48thiqVd79/vToxehYSuYyiDcQUWwLw9SuUeqVWrZNuuW+UZaR4nMxmlh8Ddz/Cl5PF8e5far3
 sRnhCOwBFnZny1JKeDRGrtimqkugiQ4HYPfyCuNz+w6TudtiTNdVrXXO8ynP8vcqxFeXoi9a9Ju
 /7fQldx/mZunwGOM2Gkj3KLXFiE4C0SEWIaYmuvY=
X-Proofpoint-GUID: 6zO1iKO9nKTRgpLWYgsEyWV3M0AU6YmK
X-Authority-Analysis: v=2.4 cv=EdZd0/mC c=1 sm=1 tr=0 ts=6ae85e41 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=bC-a23v3AAAA:8 a=Byx-y9mGAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=_JKKyeupEGsTx9GmwKEA:9
 a=FO4_E8m0qiDe52t0p3_H:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13537
X-Proofpoint-ORIG-GUID: 6zO1iKO9nKTRgpLWYgsEyWV3M0AU6YmK

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

