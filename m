Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085C4B1B26
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823301; cv=none; b=gMvM4Oy3bLkpiukEwqyY00NrU0kWQ2tKgxnbBzG3dcT9eI5VQ4qSaSPv7alJKJYETIm2TqQSUBeBSWYm2YN0PLaHL60JP2IqnZ56UIDZI3YT3lxyZJoK45haTOBr4N3pn4yGN6iXa1h1X3FYUK+/fgaN/v6h4R5ze6tW80SxiG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823301; c=relaxed/simple;
	bh=Preim9R/7tuG+s9McPkQ8RBwk+EtxkXCckKO4F5w4gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvnDKFRjcrtgOMf0J2rRUN9/G4ADN9Zhzt71glIZXBqjmehkuYdbxkjrGktJ8xoiYWcX7AgGl78i6hAO8qGjcgdKn+Pnr6CEV5jXBpvyHyyyyNUu9vlhS2UT1TQK2/4VwJtnV5CjiBJCtVkZXi7L4DvZUalzLnt/yQUAv/hrOFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S2KUQsnk; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S2KUQsnk"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFQsJT2344424;
	Mon, 12 Oct 2026 16:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=qMkis
	/25ZsP6uPddxs7wasHq/xCqX9vr01DL7XP6Hfo=; b=S2KUQsnkwkustUGt6J1uG
	ypZZkI1W/VmIce0gsR9loykPrvLigJ2vGoX5ZEwrPJMzNVVEsfziqmd8Qe1ElCKE
	/yVLz10FJgjatyPT/S277u/K3laLhe5hXKUlYm6lHUfsB7KtO7YC/3f4LkthcGRl
	aZ2GeaC9p6MJ8yhFzlWY8DlpBacLtNPIHc8la7iC+FVgUgMQ4ilOG1OpNwdY7CMe
	fbCPY42EdCuv59SbUmCkmSqEBX/qZb5H2uaTWszzyrYbdu+KCb4MzOV6ZSjcaYLM
	Tht1RPJdamwKyR9Bd/0ZV6ZpWiI2M2+Skz/NmkDeG2DS+ej/tPLxz1k3DTRsXnQW
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7de1jkfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 16:41:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69CGbnKU032801;
	Mon, 12 Oct 2026 16:41:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btnf1wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 16:41:22 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CGf1we006762;
	Mon, 12 Oct 2026 16:41:22 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h7btnf18f-8;
	Mon, 12 Oct 2026 16:41:22 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>, David Howells <dhowells@redhat.com>,
        Paulo Alcantara <pc@manguebit.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 7/8] smb: client: reject short Next offsets in parse_server_interfaces()
Date: Mon, 12 Oct 2026 09:40:56 -0700
Message-ID: <20261012164057.709105-8-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261012164057.709105-1-harshit.m.mogalapalli@oracle.com>
References: <20261012164057.709105-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610120066
X-Authority-Analysis: v=2.4 cv=O9SsLx9W c=1 sm=1 tr=0 ts=6acd0db4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=tAGQbYHnAAAA:8
 a=yPCof4ZbAAAA:8 a=bOUzYje7VgaeLFARMEEA:9 a=lXWXidlrYx5KKt6n-8sY:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX/EeTf4vju4es
 KU4wtVB5ddcRStW6BR925PeYxT/TZ05fBm/aMqsu7FWMJOEvDd/F8bx6++OyvxTPzBXIgU6QvcZ
 vppdJRyhL80Js8oiYq3XCM+JFgZdoFkaAAQu13TnLXClMqOuRytp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX72pnJAvdoTLh
 4tghnQPdW6bZiaFAL/rqBJOhRc8Zsyrvsrqp5ci/2Em3AGz/ql3KKpw9cAmoqm/FsEwEeGF0H/Q
 efM1p3149hsPMg1LW0jevS1Iz00EhYbrhoXCMD6YYjfDE4PfKWExNnQRzlINXz7O3wCPqvBZNew
 y89baFlvGjEYQlkrCDsYeITHuaKCuTyNkxMAq8kB+nrev9ckKY5cm/vgytn1a0PwGr8Erdq20g/
 XVRyYb/QybliOvnOu9nHcXV8CmhIV4KwOP0hdomD6EE/dHeDw1WBpglY3dJY+CJKXKYU12MQ7sY
 r/5hULKxzQJo0+6aTQZc9tiEbBdm0WK+eTkDnZhlK6Ryxc3R0cnEC3Pz+7g2ezxztoS9Z0N8Nm/
 6/UG0YRy1nOBXKWQ5UzytVXcFHMrPcUxXtzDKL/1AZNdRb9w98cqhwKub83RYj4gLPy1Q8Owfuc
 J/DgqjSz6bUNa50t28yC5aoqLye8mUJaTJS07Aog=
X-Proofpoint-GUID: niNa-hybgeh6O6nDmRKGVhfACuY7iiYj
X-Proofpoint-ORIG-GUID: niNa-hybgeh6O6nDmRKGVhfACuY7iiYj

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit 1b3221bb121079ad79a1f3c3aa360ba649832e7a ]

In parse_server_interfaces(), the server-supplied Next offset is
validated against bytes_left, but not against the size of the interface
structure itself.

A small, non-zero Next value can pass the bounds check but advance the
pointer by less than sizeof(*p). This causes the next iteration of the
loop to read misaligned, overlapping structure fields.

Fix this by ensuring the Next offset is at least sizeof(*p).

Fixes: 7d34ec36abb8 ("smb3: fix for slab out of bounds on mount to ksmbd")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
(cherry picked from commit 1b3221bb121079ad79a1f3c3aa360ba649832e7a)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 fs/cifs/smb2ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index fbba71f6814e..654400a29eed 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -529,9 +529,9 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			break;
 		}
 		/* Validate that Next doesn't point beyond the buffer */
-		if (next > bytes_left) {
-			cifs_dbg(VFS, "%s: invalid Next pointer %zu > %zd\n",
-				 __func__, next, bytes_left);
+		if (next < sizeof(*p) || next > bytes_left) {
+			cifs_dbg(VFS, "%s: invalid Next pointer %zu out of range [%zu, %zd]\n",
+				 __func__, next, sizeof(*p), bytes_left);
 			rc = -EINVAL;
 			goto out;
 		}
-- 
2.52.0

