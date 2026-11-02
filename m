Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614413;
	b=JNPzue7wI6qap4IxmnPimikL46rbnDlnqSI2NW+2U7+UwG52DJm9SLAtiWn27CMxH9SZ
	 umb6dnWDkb7yqLE1KYa8DxKIExwnbpaQuy7VShqV7bDyGzok/j/iUgsylsI5qTd6vERP4
	 0NmczM6XN6bGeweTn4Y02O8+0jfNqm+Ln25mTuQcoPZMignTQnon4MSF+rEh2Q69lqIlv
	 r3UMItMIkVDRn+tzQ8CR+eayYq73CLynm3TdizcdoY4ZkAbot0rL2kokyWvi4Wj0c+K+8
	 qXQ9qj/uHp9UtBxwksoyxzGvwDbXPs/qSWAZa+J3vtPdngyRMdmYgfz3yRB343Da4cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614413;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info;
	bh=oYLpTWG9C77wubb/x2b38bdgnU4giBzlQ8bxySDdwdE=;
	b=3bhWo4zsGLnF55WIwasHXBHO2jJDvnefvZQTd74v7nhHEPBNZdWcLHbzpPHbk+Id46WJ
	 /HM/B1cja/b34IHgUnv/H9xfZooytLFQRn86yOotxjek+pyszmHpY8Mpr4A2AurqDYaMy
	 QKu+1Nf40F8c8yO3f4ZPL2HIpi5BRXjQM9PGld78Hgn3kS9o5cdu8RTWIznA9EO2G0IQH
	 cJaJKwnuF4kxPYPh2XBcQb0CC7D7m1zE6W+IYCe71jIxFvjlEv4xqh05bXYxmXqfFSzO+
	 oB7tW0neOEAEU0xRIccnusH5QHauhy7GvmBYp7xDlmpuvg4VXoqeDSSAsxoXLsKDChw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=qcO2TCEJ;
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21742606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21742606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=qcO2TCEJ
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1Nt2sp1181321;
	Mon, 2 Nov 2026 10:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=oYLpT
	WG9C77wubb/x2b38bdgnU4giBzlQ8bxySDdwdE=; b=qcO2TCEJ6H3+0LXRp4AMm
	OBkakifaQNIBmrLqV/IpWzqmYs3llUN2f9iVkfBAUPjVn9bvx4hzUspWxsnhbcOs
	CA8D8D8wRawVbbSiUZNpYvH8JlFdE19zrkxFurcNb2dfi9hETbE2/t0PeiAbSZ6q
	bXWxtFIakJhy6RW2VUpZO6mUBh/r2SVDSbt/Diq8LgXxp+2eTd41kycB2gP5HNIs
	mJKpOAh6Efejy99eQgnyCgh0kSfk4eowa9teK7x1NF7oPVNwfq9srbWMV4YsigBT
	tJ1XAv/V/ougOqRwR6z1hzofkTuGtq7DXpNQOwAdN6gzneFOc8yR7BoKO7HxofrP
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn876hk8t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:13:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29D28u2995966;
	Mon, 2 Nov 2026 10:13:27 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hpqfja56j-12;
	Mon, 02 Nov 2026 10:13:26 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Mark Tinguely <mark.tinguely@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Srikanth C S <srikanth.c.s@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 11/11] xfs: remove xfs_attr_leaf_hasname
Date: Mon,  2 Nov 2026 02:12:39 -0800
Message-ID: <20261102101239.1557688-12-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: q-bgO47F-hHimJ7z89JxCmxQvK78B_Mp
X-Proofpoint-ORIG-GUID: q-bgO47F-hHimJ7z89JxCmxQvK78B_Mp
X-Authority-Analysis: v=2.4 cv=JJauIMKb c=1 sm=1 tr=0 ts=6ae86247 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=FywrB9mEr2nvRk0Q_dsA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX/ZPknxxMp0hY
 rRCSjFT2obeSYKb/fSLYd6UKf00/5KuksCZiWZlHH95KwxJI7EFspK8rEaV1XndR/5+ylhJb62Z
 V27QSHCdpDPxIiPBLtswYYOFPOkL4v6IDSt+73kKfcPqfKdBHnLl2QVXBP6cOOTTYpyY8S4Wr8I
 4be9IoOR6JY70utj+DYm21vDOxayXvH5rJ/yQgx2HnEXQABwEgpmR7tBT1coTB2byVGxoDrGu1T
 gsrXNRqlSHLwqmJHkzgYixbrvgsIo44JJOsrv8jCc5/8/T/iTaY7Ah0Hykyw82Eopraa31G0SFU
 4QM90T2gEgPvfMOum6tyXs9iBX/ds53QPamTkV8ifZTMLi76n68ryGfHC14j95emTni0KZfRAq1
 D0jDgOXs8G5wLVru/NoG2FsMlmOs063H3DNHhGgGw7EmXVt7rZ2xSk2r51xsbgtKtJuAOT/vcXb
 CbGoxtC0RtDS2DOZz+Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfXyDTlsXdE4ox9
 ybYyquzH4XvI2Q51o2s7vvh6Spa2OZXFWQkXzR2KUstTyncx2bQoBcZEDnQElqvVdz5VYvnzFii
 3jRB79nEqJRuXt971F2qpN9X8V6RVowT0dOr198BAAiXdZs/XNfR

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 3a65ea768b8094e4699e72f9ab420eb9e0f3f568 ]

The calling convention of xfs_attr_leaf_hasname() is problematic, because
it returns a NULL buffer when xfs_attr3_leaf_read fails, a valid buffer
when xfs_attr3_leaf_lookup_int returns -ENOATTR or -EEXIST, and a
non-NULL buffer pointer for an already released buffer when
xfs_attr3_leaf_lookup_int fails with other error values.

Fix this by simply open coding xfs_attr_leaf_hasname in the callers, so
that the buffer release code is done by each caller of
xfs_attr3_leaf_read.

Cc: stable@vger.kernel.org # v5.19+
Fixes: 07120f1abdff ("xfs: Add xfs_has_attr and subroutines")
Reported-by: Mark Tinguely <mark.tinguely@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit 3a65ea768b8094e4699e72f9ab420eb9e0f3f568)
[Srikanth: Fix the additional leaf-add caller retained in 5.15 and
adapt leaf reads to the four-argument API.]
Signed-off-by: Srikanth C S <srikanth.c.s@oracle.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 fs/xfs/libxfs/xfs_attr.c | 80 ++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 53 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index 23523b802539..baeaf8805a2a 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -45,7 +45,6 @@ STATIC int xfs_attr_shortform_addname(xfs_da_args_t *args);
  */
 STATIC int xfs_attr_leaf_get(xfs_da_args_t *args);
 STATIC int xfs_attr_leaf_removename(xfs_da_args_t *args);
-STATIC int xfs_attr_leaf_hasname(struct xfs_da_args *args, struct xfs_buf **bp);
 STATIC int xfs_attr_leaf_try_add(struct xfs_da_args *args, struct xfs_buf *bp);
 
 /*
@@ -657,11 +656,11 @@ xfs_attr_lookup(
 		return xfs_attr_sf_findname(args, NULL, NULL);
 
 	if (xfs_attr_is_leaf(dp)) {
-		error = xfs_attr_leaf_hasname(args, &bp);
-
-		if (bp)
-			xfs_trans_brelse(args->trans, bp);
-
+		error = xfs_attr3_leaf_read(args->trans, args->dp, 0, &bp);
+		if (error)
+			return error;
+		error = xfs_attr3_leaf_lookup_int(bp, args);
+		xfs_trans_brelse(args->trans, bp);
 		return error;
 	}
 
@@ -934,9 +933,12 @@ xfs_attr_leaf_try_add(
 	 * Look up the given attribute in the leaf block.  Figure out if
 	 * the given flags produce an error or call for an atomic rename.
 	 */
-	retval = xfs_attr_leaf_hasname(args, &bp);
-	if (retval != -ENOATTR && retval != -EEXIST)
+	retval = xfs_attr3_leaf_read(args->trans, args->dp, 0, &bp);
+	if (retval)
 		return retval;
+	retval = xfs_attr3_leaf_lookup_int(bp, args);
+	if (retval != -ENOATTR && retval != -EEXIST)
+		goto out_brelse;
 	if (retval == -ENOATTR && (args->attr_flags & XATTR_REPLACE))
 		goto out_brelse;
 	if (retval == -EEXIST) {
@@ -969,27 +971,6 @@ xfs_attr_leaf_try_add(
 	return retval;
 }
 
-/*
- * Return EEXIST if attr is found, or ENOATTR if not
- */
-STATIC int
-xfs_attr_leaf_hasname(
-	struct xfs_da_args	*args,
-	struct xfs_buf		**bp)
-{
-	int                     error = 0;
-
-	error = xfs_attr3_leaf_read(args->trans, args->dp, 0, bp);
-	if (error)
-		return error;
-
-	error = xfs_attr3_leaf_lookup_int(*bp, args);
-	if (error != -ENOATTR && error != -EEXIST)
-		xfs_trans_brelse(args->trans, *bp);
-
-	return error;
-}
-
 /*
  * Remove a name from the leaf attribute list structure
  *
@@ -1000,24 +981,20 @@ STATIC int
 xfs_attr_leaf_removename(
 	struct xfs_da_args	*args)
 {
-	struct xfs_inode	*dp;
-	struct xfs_buf		*bp;
+	struct xfs_inode	*dp = args->dp;
 	int			error, forkoff;
+	struct xfs_buf		*bp;
 
 	trace_xfs_attr_leaf_removename(args);
 
-	/*
-	 * Remove the attribute.
-	 */
-	dp = args->dp;
-
-	error = xfs_attr_leaf_hasname(args, &bp);
-
-	if (error == -ENOATTR) {
-		xfs_trans_brelse(args->trans, bp);
+	error = xfs_attr3_leaf_read(args->trans, args->dp, 0, &bp);
+	if (error)
 		return error;
-	} else if (error != -EEXIST)
+	error = xfs_attr3_leaf_lookup_int(bp, args);
+	if (error != -EEXIST) {
+		xfs_trans_brelse(args->trans, bp);
 		return error;
+	}
 
 	xfs_attr3_leaf_remove(bp, args);
 
@@ -1041,23 +1018,20 @@ xfs_attr_leaf_removename(
  * Returns 0 on successful retrieval, otherwise an error.
  */
 STATIC int
-xfs_attr_leaf_get(xfs_da_args_t *args)
+xfs_attr_leaf_get(
+	struct xfs_da_args	*args)
 {
-	struct xfs_buf *bp;
-	int error;
+	struct xfs_buf		*bp;
+	int			error;
 
 	trace_xfs_attr_leaf_get(args);
 
-	error = xfs_attr_leaf_hasname(args, &bp);
-
-	if (error == -ENOATTR)  {
-		xfs_trans_brelse(args->trans, bp);
-		return error;
-	} else if (error != -EEXIST)
+	error = xfs_attr3_leaf_read(args->trans, args->dp, 0, &bp);
+	if (error)
 		return error;
-
-
-	error = xfs_attr3_leaf_getvalue(bp, args);
+	error = xfs_attr3_leaf_lookup_int(bp, args);
+	if (error == -EEXIST)
+		error = xfs_attr3_leaf_getvalue(bp, args);
 	xfs_trans_brelse(args->trans, bp);
 	return error;
 }
-- 
2.55.0

