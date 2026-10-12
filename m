Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF1C35C1A6
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823276; cv=none; b=dZ3eWrL+We+x90yDQts0KIkP8arI/Lj+KPjKfgiSdrucJSs3MyCRgss5EMABYVhwPKuLUqUOGJIFcbJiiJwK7QcEH60DtHsG31Vmhp6+NR7GKtKGx2CcsdJukT+y5FGx6XKeyUezaCHEPOBvSjCobF3f91IpM4jMWUUM9+EDPOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823276; c=relaxed/simple;
	bh=OW6wx7iOROhhwHW5fUPWjchjd3rpdU85obfXhXK8QTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcAVFWGjyDRTJPDT/H/Qb8ZoOMIJ91JRiKx2Tuw2QF5DPN8MfCu51DL2eeLPo4dbqyB+ciJQLDDTvXRzBOoOzzo6Hn9dTg8UEOxraSkWGEJy8OS948uT+yx7dut3Cy8J4gv0NDgTCNG0NBBPFm4AHZdgFVczTtrvb53uKZNmNl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PuegHKTF; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PuegHKTF"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFR0Uu2344809;
	Mon, 12 Oct 2026 16:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=tsvHP
	mEzXZnPxhY8Od9sODUHROgPuoquf9nx5s5nO/Y=; b=PuegHKTFWNrih2A0PxAWJ
	0R4/DaNdWXGDMHlDMGbuUaThd4hl9A/v0Pur0O6bv5sFKERBcF57Xc+1YAUPnHPI
	05kUhYtrVXivwoAZtZdpLs1FJU0ioUye1D3jSsOVX992KL4+/UDrt5WkgYyyejbh
	Opkj8PO//dIPZ4TK3ZwtyZPZnR2GE65muF37f4bGknSskigB/dmSXgbE+p/w5Gq8
	qrLq8mKcEUsNQeayw34/DewbbataMXyng1mqhVa2mKDGC5/qm+VRvRcYyJIctSZf
	2jeL0PROBFWk3hc8Npb/QDTbo+6fJI1brzKDKXxru+LvWHrCweMyos1Dqwbxjuwz
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7de1jken-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 16:41:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69CGbml6032764;
	Mon, 12 Oct 2026 16:41:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btnf1hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 16:41:10 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CGf1wS006762;
	Mon, 12 Oct 2026 16:41:10 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h7btnf18f-2;
	Mon, 12 Oct 2026 16:41:09 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Ezrak1e <ezrakiez@gmail.com>, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Srikanth C S <srikanth.c.s@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 1/8] dlm: validate length in dlm_search_rsb_tree
Date: Mon, 12 Oct 2026 09:40:50 -0700
Message-ID: <20261012164057.709105-2-harshit.m.mogalapalli@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=O9SsLx9W c=1 sm=1 tr=0 ts=6acd0da7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=oAUGvwMqMISqIZqjYIQA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12107
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX9GypZA4V1BFD
 P4afX9krfVLmkOz70H9wAWtkv1/a6i0oXMbqi5lcoGD38hlvUEZXHnYCw8MCLBToBmbYfB8doYz
 3FcBXfw/yX/gZGWgy65pFT2khiuHPrsWKj39FxqQogqQhmmTSEoP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX9wNo7lIksWUK
 WF3Gi+OFOaKu8bFb0Skk9yuAa8kb9NhzWxTJx9HwcRXisNEu9ANhsr5UrTr4csp5Dak8KB5XKA5
 dbUbJHH9g8hPaZpMGM9uK4ETvk/c2XAkbWAAFWmz9iZiFK4XvScFfBA4byaUJEpY9wPYveAWjLl
 tZiFrZXXvDzKT2ffSN52eEw1HLcn5ZzGiHrTJPXdvGHc07ylUG+0sZD/AOEmFycc1IaeY2B1bW7
 V/4vBKpZ9FESRPaySlMpjBLDxw/J8OAf7ah5xfKPg5n+nTRTrpQtbCmYmC2MpZ7tv37aTAseAvb
 jzd45Wg75eU/CXJCJFsHpRJDaknztC/iop9CmTQTn0UeexMnx5Us0Y7oB+1YsyXRaHkihtN/aRb
 2u/bj2Rgpge4WM17996zhuAVkWgQ9FjqIXxYMDhXz2mEJDOQYF1BtCliHAu0/fEbr/VCFI8WPuP
 tBgfF0cTPfD/yt8XBRdOsWRbOPJG+uNzI3Sszdn8=
X-Proofpoint-GUID: 9pMbHekvpHDEE4V-ZrvmbA-ARIyjXERl
X-Proofpoint-ORIG-GUID: 9pMbHekvpHDEE4V-ZrvmbA-ARIyjXERl

From: Ezrak1e <ezrakiez@gmail.com>

[ Upstream commit 080e5563f878c64e697b89e7439d730d0daad882 ]

The len parameter in dlm_dump_rsb_name() is not validated and comes
from network messages. When it exceeds DLM_RESNAME_MAXLEN, it can
cause out-of-bounds write in dlm_search_rsb_tree().

Add length validation to prevent potential buffer overflow.

Signed-off-by: Ezrak1e <ezrakiez@gmail.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
[Contextual conflict due to dlm_search_rsb_tree() using the RB-tree
implementation instead of rhashtable.]
Signed-off-by: Srikanth C S <srikanth.c.s@oracle.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 fs/dlm/lock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index ffe12593a8b7..88ef7ad1494e 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -449,6 +449,8 @@ int dlm_search_rsb_tree(struct rb_root *tree, char *name, int len,
 	struct dlm_rsb *r;
 	int rc;
 
+	if (len > DLM_RESNAME_MAXLEN)
+		return -EINVAL;
 	while (node) {
 		r = rb_entry(node, struct dlm_rsb, res_hashnode);
 		rc = rsb_cmp(r, name, len);
-- 
2.52.0

