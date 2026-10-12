Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2436F4A6889
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820791; cv=none; b=BqOow0UMsaTBc2p8LHDcIh/knCZU92Mod7dr5DP0jIiJJz2AdHHQlIt/8OboA3OIKbQ7bGGyZ7DWBAyC7w5Ltbb8TIjwWFtIFmHai8G7rRYfpNw9k0LsbHGCZbYJANlosrYcQPCXxFYznVY/Mhv8Hd/xvaUc2qx3GZ6AbmD4GY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820791; c=relaxed/simple;
	bh=TBqTkHo9bDVVnMGpix0Cm9lueWgsn1kwB4BJqFNw6w8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VhcCAdh1oYLX4Zgx7lrOIaYjI3VD0dy4JQ242C0QksmXhV9uxcbBuCnotWMEKdpa34gxiOgpzC4iBc0txY9zsJNkDmdAoZKLlfSvbVFQqKFT3Epg6+ebairPYdgA/KSfqLMsxJHqX+oLEvKt+aZ+NEsxi1hyQ1H+SEr2zfl4fgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rtPPv8vu; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rtPPv8vu"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFQxpQ353403;
	Mon, 12 Oct 2026 15:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=Mq9aEJ2Y6k6aK1qQqfuhg8xCXw/e2
	fGkBDwf6V0+ESk=; b=rtPPv8vul9eC81D1NGOHW1qyh+wwjrD4tzBMeRIT3/mJV
	eRQbsVItuIH/alZSTqmjcw+K7kUdGMUaCRSU9M9CjFRUVlfrky3q9bzhsdLeWS9u
	IBjEJ7Ef3sFHaqMISTfoFx30E7QuDNlZ/10A9e1wOmxQ9twp2843lKOKh5z81OWp
	/x19zzvUkhHyuf9KTz/gdv12lulRzQ5NlLwyqlueMUkk4IdujPJTu+qXou1wMPyL
	Nk8UI+a8aiyjPoFv1w9ywAhbCnjIzEyOEl2ohVxT8g/76Y0Go5B28hqAKV6z1dun
	tj3VUa6/xDoEIjSKCfB62saxfGVXcIbzYaMXTukrQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7df7thk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 15:59:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69CFaNum010930;
	Mon, 12 Oct 2026 15:59:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h7bt8hjxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 15:59:46 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CFxjJN036269;
	Mon, 12 Oct 2026 15:59:45 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4h7bt8hjx7-1;
	Mon, 12 Oct 2026 15:59:45 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Ezrak1e <ezrakiez@gmail.com>, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Srikanth C S <srikanth.c.s@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.6.y,6.1.y] dlm: validate length in dlm_search_rsb_tree
Date: Mon, 12 Oct 2026 08:59:42 -0700
Message-ID: <20261012155942.703925-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610120062
X-Authority-Analysis: v=2.4 cv=N+a8hG9B c=1 sm=1 tr=0 ts=6acd03f2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=oAUGvwMqMISqIZqjYIQA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MyBTYWx0ZWRfXzQEjEWb6hlvg
 vhfSuF/UEiqVy0xjPAR+B0sjiPieasSuvfpoIVah2s1o7K83GQgiXEvttSddEOKRicW0Ag5daCr
 tESj2JqsmLCTW+ZBv23N2PA7jmlJJgFgz1vcsF6ScaJTG6FoCxXF1zdivdiAwa12ivk0em8+0CH
 u4DQZL5QGA5w9SWZq963JpjAXyyg2aM952cnDvZJwa8EGv/KdQJR3NitijEQ23wKz3p8R5qXmS8
 T6J6qWQUyZT2NBEtPhp4Mujd5a3jyvSzBfO2LiZzYqOagZZPJcWpWOM9zMMGf/FuaixgoJG3z6q
 RxXfTl/gZGzOduLltWkkYBkjQq7jIKEEepPo7Z8nc0fCjFCfucdS3cKyKspPPLlNhgJpCHQlaBO
 RWsI0c798qYA7KsrHgnIakGz8wadgRlfAew4AayokTOn5xA7n4927pyZT5Dcb1jCcDY40VdMUgs
 jQurKfVB2uBLtT5Scog==
X-Proofpoint-ORIG-GUID: seMx3XzBL9sEyP0BC_mY3n9CSNKSfhbq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MyBTYWx0ZWRfX6F4fS3QY161d
 N7JqatPjhVuMUxLqQBCnBCj3YNC0AJZ7WanEh0t49fQQ261zcPUy5ppJq+RINP0QvDPFk6CvwW9
 7fs8gWbQbdg9D5jJAm+72ibYGW16WT3VAIkR7uP4vXXP0FV/Shbg
X-Proofpoint-GUID: seMx3XzBL9sEyP0BC_mY3n9CSNKSfhbq

From: Ezrak1e <ezrakiez@gmail.com>

[ Upstream commit 080e5563f878c64e697b89e7439d730d0daad882 ]

The len parameter in dlm_dump_rsb_name() is not validated and comes
from network messages. When it exceeds DLM_RESNAME_MAXLEN, it can
cause out-of-bounds write in dlm_search_rsb_tree().

Add length validation to prevent potential buffer overflow.

Signed-off-by: Ezrak1e <ezrakiez@gmail.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
[ Contextual conflict due to dlm_search_rsb_tree() using the RB-tree
implementation instead of rhashtable.]
Signed-off-by: Srikanth C S <srikanth.c.s@oracle.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 fs/dlm/lock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 6712d733fc90..dd2fa54f2b7d 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -444,6 +444,8 @@ int dlm_search_rsb_tree(struct rb_root *tree, const void *name, int len,
 	struct dlm_rsb *r;
 	int rc;
 
+	if (len > DLM_RESNAME_MAXLEN)
+		return -EINVAL;
 	while (node) {
 		r = rb_entry(node, struct dlm_rsb, res_hashnode);
 		rc = rsb_cmp(r, name, len);
-- 
2.52.0

