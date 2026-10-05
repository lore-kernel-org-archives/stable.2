Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AD92F28FF;
	Mon,  5 Oct 2026 05:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791178975; cv=none; b=FGujTTMAabzqgWrHVpeGXB6KmlfnZJrHfQxXqBI09A/4XoUrZ6l1fwJNWZ8qQbnItu5AdJ8fRmlTJQSYqzAwhyWBWdtI/+sD36usSM68/7jpkEFvrQlroK67gdXbBb4BRDYhfPGyp6w9CBiIvX4FAhfuuRW0ZxbNgniTZiMiabM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791178975; c=relaxed/simple;
	bh=iZKk1mOm72ZcpBXMoWPHIkLSDEHxpIolabCThdQcIbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fYC+MkA5UkP+byEaSY5D8LQ6yKlEFK5TMO9DMe/RHcfCQumdS25zuxaTOfLV+rX1W7r9FsfG2XTZTWqzboX+hgNBLVSqWYop1dPtyWYi/pvJkUjxNcKmE9OO581P0bdw2VDDIBIxQ74sGmzTysjHql+W+SZo6JIkaAUdQDNf2rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IzcRkuke; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IzcRkuke"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 694NKadJ349013;
	Mon, 5 Oct 2026 05:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=9qxMOmifwaGARzYGyIm/C408IJ5GA
	I+fqFCtRhndamY=; b=IzcRkukehjfgSdqvtTui4zRE3TVqm+uSZit5DejNZJhpA
	XgDkfOMjPwp0uANVKn4gJxwBFIlSxDz/hrsEa/1ZYlkUkf+flZTZXBmpA8TYfTp0
	y9HAosIc0mGl1Q8n5+gz0bWjSdGCD8kZzx/XWdXGM2/Own26QElGtppHvOhE65wD
	tyH6PnljWd+QbgYhafwo8Q9eLN2lIDyIRZ4ocRqtajQeCKIr38Pt9E0RARJkf+Sx
	A5Q2pbIW8PM2+Mj3QYgxo71kElhgEoDwV1rtYcMfGhHtUSnTX7TJGuIklWKacrsw
	eHrWtH87L+AkaAvd7jBtkfMqXN6vdGxK4cGJayMRA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h2r4b9bnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Oct 2026 05:42:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6955ZPX4019083;
	Mon, 5 Oct 2026 05:42:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h2r5ndmbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Oct 2026 05:42:30 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6955gUML038101;
	Mon, 5 Oct 2026 05:42:30 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h2r5ndmb1-1;
	Mon, 05 Oct 2026 05:42:29 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: maheshb@google.com, willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, peterpenkov96@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH] tun: fix skb length underflow in NAPI frags path
Date: Sun,  4 Oct 2026 22:42:24 -0700
Message-ID: <20261005054224.4154727-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610050022
X-Proofpoint-GUID: T9z6oaFHaBD3IS1aRcqR6kBWkUksulyb
X-Proofpoint-ORIG-GUID: T9z6oaFHaBD3IS1aRcqR6kBWkUksulyb
X-Authority-Analysis: v=2.4 cv=BIQmP1QG c=1 sm=1 tr=0 ts=6ac338c7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=K3LnMWoHZJQLLBG9_8cA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12107
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyMiBTYWx0ZWRfX2gzoK3nww98S
 V3lDSjmYrWRdtp7kKlkX8ECWD8o6IFbEkgAZ1SX7CFVZnsVn0kXGn7SRw4MNonaET3ul35MXU5h
 Id2KAe6uGAWBedyrcXuPAKvBM8muOPfG+8pedoQ/6tZfa8FhqoAp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyMiBTYWx0ZWRfX2QQCn3KE/1nG
 wxs7uphXL88Rlm2mZmoG9iWttlSpI9FOUJxgTXx+UM5m6R40/iTEqwe3r176fF0tvNLk53oveeU
 P0Qry8WtpmXHEOqvnKk0n648tYHkgt/pqrzLSAZ6leR2wuJ2KKJMfpcY/E6l0EqMTHUnSkSKRsb
 jw6IvAjxhYFMZQzosgtjIZO36ZjWlZ8qLkvR8UapY33L4cbzuTDKedtSaYtfXqk+9c9KsN2A8Yp
 cYmrZ33TSA02isgofTdq/BnnLcwgtZb7dyKsTdPMjol2FQqwfwYo0Rtkl6elA+dmePFxY6Th4R/
 tAhKbXHDuWty/4cLRx9OSUFtUvaQW6UJvu+XtXZaIejUBAyuzDlh+Vwf/9hxaYN3KLzvo/GZ7RP
 4UcW2U+TW5188biZ63xDRerOmNk0p7exUqB9OwytTDCrOanVpX7h/F6TXg6COA/Zn2bsuGSdqAR
 2v1uV9DVORgxNCBIcYF7+Zphm/1wm9JASsbmDQZE=

When experimental vhost-net zero-copy TX is used with an IFF_NAPI_FRAGS
TAP backend, tun_get_user() receives msg_control, selects zerocopy, and
limits copylen to the linear prefix.

The NAPI frags path subsequently disables zerocopy after allocating the
skb and copies the complete frame instead. tun_napi_alloc_frags() derives
the linear length from the first iterator segment, so a segment larger
than copylen makes skb->data_len underflow. Pulling the Ethernet header
then triggers BUG() because skb->len is smaller than skb->data_len.

Disable zerocopy before calculating the allocation length so this path
allocates and copies the complete iterator.

Fixes: 90e33d459407 ("tun: enable napi_gro_frags() for TUN/TAP driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/net/tun.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 5a302709a68a..1124b8b33664 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1848,6 +1848,10 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 			zerocopy = true;
 	}
 
+	/* The NAPI frags path copies the complete iterator. */
+	if (frags)
+		zerocopy = false;
+
 	if (!frags && tun_can_build_skb(tun, tfile, len, noblock, zerocopy)) {
 		/* For the packet that is not easy to be processed
 		 * (e.g gso or jumbo packet), we will do it at after
@@ -1868,11 +1872,6 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		if (frags) {
 			mutex_lock(&tfile->napi_mutex);
 			skb = tun_napi_alloc_frags(tfile, copylen, from);
-			/* tun_napi_alloc_frags() enforces a layout for the skb.
-			 * If zerocopy is enabled, then this layout will be
-			 * overwritten by zerocopy_sg_from_iter().
-			 */
-			zerocopy = false;
 		} else {
 			if (!linear)
 				linear = min_t(size_t, good_linear, copylen);
-- 
2.52.0

