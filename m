Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614889;
	b=vDUymlPO5wRpekVgPTAWc3ozDHJYd/J7ZLbTmOSxeknQaqGGRufiDbFdXJ6xcVeQuRor
	 Cva6QGeP0qZIMpyizIoQ89qwVofy7ajaI4N9LVEvf10QUW1iP83s1Ni+6kb3Of9cZcpmy
	 QaRPGCn08O12XDXKxXiXUHM1XSxWIx1/aJhN26Pw3mbcYeoKD30J1UPNyhSLNb6aGMQtQ
	 +O+DGFkDzS3GtUf317CC7H6dr0sEXgJQhLTBwA7bmT6ZDn8RHRLRtnxuAQLgAAyAH+KjN
	 MjwOCpRdVfr5vXz0oUVOooNZWTsLFMzMEL8b9B+qT8CuX36T1m+LFrBMGO6p7iOfo1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614889;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc;
	bh=YR9lZMbsfx2BjuilzdABBvina7+PnKrSwYSKMVqFxFg=;
	b=ce4dBoRpxvo2USp7oK51op4BNTYnEiwWw35EIe1AGiUTlbg371Jm54GW07dCYwAxT/Xf
	 7JS9+d+C1Lb9OWm067fZUxocult0Ijhwbpggy6gwwPlokLnNRJILhr+MXmj0BM7nLbJUE
	 ClBhCmjeU2nU2eaa3oNvthH7JgrYXjt5ilczyk8Unpw1mW36Oj35galYHvkM4Mu2yKhbd
	 TuFKTeqhoMFhTKE1oHNtFkkApiDbphSsoB433aUHpvWl1o0EPFK9e6rgp6t8t9lmuTC/3
	 InJD49bkS3w5OiRBpcbjAdmNuaX9ouwHp80OPzHxZThDOMQIboFv5Jy7eszN7zPGIsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=bUMqBK7v;
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D5D606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81D5D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=bUMqBK7v
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1Nwg5Q3016099;
	Mon, 2 Nov 2026 10:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=YR9lZ
	Mbsfx2BjuilzdABBvina7+PnKrSwYSKMVqFxFg=; b=bUMqBK7vPvJp20rbf9Hrd
	7f95HqV0dhjIhF3GzENmjkk94lM8rRQS5l6t+qH8G0tw0h46QQ5m7p1gMQtBxZIH
	Sg2XCijqKVrQCEcO24VK7K165agKHeeF84zCummQVy11NeDaA6k+MvkWYpUB9Htf
	ws761HKbVlj4nPSsI70cpqxkiE5efbqksvirlbysfRi334bAQCod6oOgPSk413Uj
	TPNkaHj5wr4Wp/6UnnK95TxQvRn7ljjC8jRsb6tfGPuWQRNSARGPTfAhFHKtBmYu
	oIjfTi3hKyjN4Doioj3YQ4yn1ZA65sWjTr68A/ypMMwleZS+Jr5LcncKJ7zfjF9Y
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn8vr1jf9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:21:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29CuVU1424136;
	Mon, 2 Nov 2026 10:21:19 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4hpqhua27a-7;
	Mon, 02 Nov 2026 10:21:19 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Qing Luo <luoqing@kylinos.cn>, Xin Long <lucien.xin@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.10.y 6/9] sctp: auth: discard auth_chunk when skb_clone fails
Date: Mon,  2 Nov 2026 02:21:01 -0800
Message-ID: <20261102102104.1558500-7-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX8MZ10fOR46gz
 XdCXZ/Vz8uCX3M4HGxapgEglCaLfNoHg0+ny+GkA6onqcQXpGgXTKW5DAgpsZpn96Eo2wiF2zqJ
 aNtkDNY0seR0UBJSi31y6KkQolOaMaGhTdINYiEjaEKZGmf+sXjM
X-Proofpoint-ORIG-GUID: qLNTow9kMKeVVIBd7udjk17w5hI5zdja
X-Proofpoint-GUID: qLNTow9kMKeVVIBd7udjk17w5hI5zdja
X-Authority-Analysis: v=2.4 cv=RPcmjIi+ c=1 sm=1 tr=0 ts=6ae86420 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=bC-a23v3AAAA:8 a=Byx-y9mGAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=_JKKyeupEGsTx9GmwKEA:9
 a=FO4_E8m0qiDe52t0p3_H:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13537
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfXxUtORsw+8E6d
 DEBaOeHozB/Xcvb+nkKg4XUgDGQAMNOcsxkg2DtlLEbiP11zycu3d0tH3cAUTxkNxOEoMLBkxsZ
 5XBiL46pRuJQQ1+e+aIGjZ5n0AzZ0Wm+mSs9yhMr2OOkb/UI8vB8cLVOn4iJihd+lwOGnqrHPbd
 1+EuAsMu5Fqqew74LXNxb3u3eVnX+DFQISpeWFAh2bOka94lVrxDSuLCg4XIaqqgbaLZdeWpBRC
 1DzW1/tii7JyMAKAspGr+LanMBi84V5a6I/cMKUbCNM1fCb5aFDa+dloyp8L6Lz6t3u+qPskPKb
 B/a/OA/7aLkUOwv5C3eMlOFCvJtfnC4tBPFR9+TvGyFjVPXwDI751Gq+VJSRLMdPkn81o6IVKch
 pDRZ5gSYt9w9oBoJgDsBB3U9/hrhQ48pnmCWhMgVShTCIV5ekk6857eBgNoRstpRa/F2p9uF0Dj
 xlM3V6n2YW58eKdHGfdJRbiSnbKW9akPTuqRXUfA=

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
index ad1a7368f6ab..13a3cb5c95ae 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -1019,6 +1019,10 @@ static void sctp_assoc_bh_rcv(struct work_struct *work)
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

