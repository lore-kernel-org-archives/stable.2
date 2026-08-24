Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CC92836F
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787530169; cv=none; b=Sgi4jge6kYIOskoe2/0NIAqSYvUUq6U/ok9cl3mErWBaqpg+2c/2q56gZDQxfT5uT8eQIOqmTMszdsk8PvxD2E3bOqG65Kmg8upz5SOnAmvtDeVvXiV/kiunLf3d+qapHYG4XzUQTjI1MBk7cxdbAmYiBtmtk74sgrkNwygUa4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787530169; c=relaxed/simple;
	bh=23uNE/DkHVKWLy7g/ho75tcGf1aQzt6gD5VdJ3R7IYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alQBymiZnaeO92iwgM3QaEzCb7I8LpLl0n/s+8pOoMSQjBiLhhrkvSIbE/h44wE+YkfhrLU7XPxwMnV8oVZw+D766tXPcplH5U2Wv+Qu8dNvVHOHIIi/iwlPswitzZL07DKgdJEfhiFYhm3oN9V5NlUvcbjvaXrYJV9RsLKzu54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqgrsnrJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqgrsnrJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8941F00A3D;
	Mon, 24 Aug 2026 00:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787530167;
	bh=YAyQGbD9ja0B9jt+0xL3k0U/vTm562zgfMBtYzTXuok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JqgrsnrJzg6FPQ5Me9Ob6ZHy754hmWmxmUed4OD9XZL9kjVb526oO+Sn6wXPVdV/a
	 If2fhBXl7yhRiRnPqjwmq0Kd1UETSKckMLpZKovsMBacLQlC7UMnjApenRcWRponzs
	 7KTFO6z9behK3wjoYGG8pgO7pBHkRSld4ZrYjXSUD5grWBd+0pTYEnrn6QHvG4U9Hq
	 vnTC7iJsp6MBaobrYqKF4VOSqjGEnIZO0YoiD8+nx6BJMmd2NFBqL7kY2aHlFpz9rc
	 YOsDd7pQkktDIZnTSA9QNq8hEQ5sJ3TgVBMtunPw5vg/uP/p4j8ryOJ/A4QyB27lJ7
	 oAgieEqN5ka4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ibrahim Hashimov <security@auditcode.ai>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] xfs: bounds-check buffer log item's dirty bitmap
Date: Sun, 23 Aug 2026 20:09:24 -0400
Message-ID: <20260824000924.2649121-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824000924.2649121-1-sashal@kernel.org>
References: <2026082045-unrest-cloud-20af@gregkh>
 <20260824000924.2649121-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ibrahim Hashimov <security@auditcode.ai>

[ Upstream commit 813f8136a2ce1fee266d02a7df73db6e8a541604 ]

xlog_recover_do_reg_buffer() replays each dirty region described by a
buffer log item's bitmap into the buffer read for that item:

	memcpy(xfs_buf_offset(bp, (uint)bit << XFS_BLF_SHIFT),
		item->ri_buf[i].iov_base,
		nbits << XFS_BLF_SHIFT);

The destination offset (bit/nbits, from the logged dirty bitmap) and the
buffer size (from the logged blf_len) are both attacker-controlled and
otherwise unrelated, yet the only thing bounding the copy is an ASSERT(),
which compiles away on production kernels. A crafted image logging a
small blf_len together with a bitmap bit past the end of that buffer
drives the memcpy() past the buffer's allocation, corrupting adjacent
kernel heap during mount-time log recovery. This is reachable by anyone
who can get a crafted image mounted -- the malicious-filesystem threat
model XFS already guards against elsewhere.

Turn the ASSERT() into a real XFS_IS_CORRUPT() check that aborts recovery
of the buffer with -EFSCORRUPTED, consistent with the validate-and-fail
idiom already used in xlog_recover_do_inode_buffer() and
xfs_dquot_item_recover.c. xlog_recover_do_reg_buffer() therefore becomes
STATIC int and its three callers propagate the error.

Found and confirmed with KASAN on a CONFIG_XFS_DEBUG=n build: the crafted
image trips a slab-out-of-bounds write before this change and fails
recovery cleanly with -EFSCORRUPTED after it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_buf_item_recover.c | 57 +++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/fs/xfs/xfs_buf_item_recover.c b/fs/xfs/xfs_buf_item_recover.c
index 058dd10a32282..4432726dfe8fb 100644
--- a/fs/xfs/xfs_buf_item_recover.c
+++ b/fs/xfs/xfs_buf_item_recover.c
@@ -444,7 +444,7 @@ xlog_recover_validate_buf_type(
  * given buffer.  The bitmap in the buf log format structure indicates
  * where to place the logged data.
  */
-STATIC void
+STATIC int
 xlog_recover_do_reg_buffer(
 	struct xfs_mount		*mp,
 	struct xlog_recover_item	*item,
@@ -472,8 +472,24 @@ xlog_recover_do_reg_buffer(
 		ASSERT(nbits > 0);
 		ASSERT(item->ri_buf[i].iov_base != NULL);
 		ASSERT(item->ri_buf[i].iov_len % XFS_BLF_CHUNK == 0);
-		ASSERT(BBTOB(bp->b_length) >=
-		       ((uint)bit << XFS_BLF_SHIFT) + (nbits << XFS_BLF_SHIFT));
+		/*
+		 * The bitmap is only trustworthy to the extent that it
+		 * describes a region that actually fits inside the buffer we
+		 * read in based on the (attacker-controlled) blf_len.  Do not
+		 * rely on an ASSERT() for this -- it compiles away entirely on
+		 * non-DEBUG kernels, which is exactly where this matters, so
+		 * validate it for real and abort recovery of this buffer rather
+		 * than copying past the end of it.
+		 */
+		if (XFS_IS_CORRUPT(mp, BBTOB(bp->b_length) <
+				((uint)bit << XFS_BLF_SHIFT) +
+				(nbits << XFS_BLF_SHIFT))) {
+			xfs_alert(mp,
+	"Bad buffer log item dirty bitmap (bit %d, nbits %d) for %d-byte buffer at daddr 0x%llx.",
+				bit, nbits, BBTOB(bp->b_length),
+				xfs_buf_daddr(bp));
+			return -EFSCORRUPTED;
+		}
 
 		/*
 		 * The dirty regions logged in the buffer, even though
@@ -527,6 +543,7 @@ xlog_recover_do_reg_buffer(
 	ASSERT(i == item->ri_total);
 
 	xlog_recover_validate_buf_type(mp, bp, buf_f, current_lsn);
+	return 0;
 }
 
 /*
@@ -535,10 +552,10 @@ xlog_recover_do_reg_buffer(
  * (ie. USR or GRP), then just toss this buffer away; don't recover it.
  * Else, treat it as a regular buffer and do recovery.
  *
- * Return false if the buffer was tossed and true if we recovered the buffer to
- * indicate to the caller if the buffer needs writing.
+ * Return 0 if the buffer was not recovered (tossed), 1 if it was recovered and
+ * needs writing, or a negative errno if recovery of the buffer failed.
  */
-STATIC bool
+STATIC int
 xlog_recover_do_dquot_buffer(
 	struct xfs_mount		*mp,
 	struct xlog			*log,
@@ -547,6 +564,7 @@ xlog_recover_do_dquot_buffer(
 	struct xfs_buf_log_format	*buf_f)
 {
 	uint			type;
+	int			error;
 
 	trace_xfs_log_recover_buf_dquot_buf(log, buf_f);
 
@@ -554,7 +572,7 @@ xlog_recover_do_dquot_buffer(
 	 * Filesystems are required to send in quota flags at mount time.
 	 */
 	if (!mp->m_qflags)
-		return false;
+		return 0;
 
 	type = 0;
 	if (buf_f->blf_flags & XFS_BLF_UDQUOT_BUF)
@@ -567,10 +585,12 @@ xlog_recover_do_dquot_buffer(
 	 * This type of quotas was turned off, so ignore this buffer
 	 */
 	if (log->l_quotaoffs_flag & type)
-		return false;
+		return 0;
 
-	xlog_recover_do_reg_buffer(mp, item, bp, buf_f, NULLCOMMITLSN);
-	return true;
+	error = xlog_recover_do_reg_buffer(mp, item, bp, buf_f, NULLCOMMITLSN);
+	if (error)
+		return error;
+	return 1;
 }
 
 /*
@@ -706,7 +726,9 @@ xlog_recover_do_primary_sb_buffer(
 	xfs_agnumber_t			orig_agcount = mp->m_sb.sb_agcount;
 	int				error;
 
-	xlog_recover_do_reg_buffer(mp, item, bp, buf_f, current_lsn);
+	error = xlog_recover_do_reg_buffer(mp, item, bp, buf_f, current_lsn);
+	if (error)
+		return error;
 
 	if (orig_agcount == 0) {
 		xfs_alert(mp, "Trying to grow file system without AGs");
@@ -1026,11 +1048,11 @@ xlog_recover_buf_commit_pass2(
 			goto out_release;
 	} else if (buf_f->blf_flags &
 		  (XFS_BLF_UDQUOT_BUF|XFS_BLF_PDQUOT_BUF|XFS_BLF_GDQUOT_BUF)) {
-		bool	dirty;
-
-		dirty = xlog_recover_do_dquot_buffer(mp, log, item, bp, buf_f);
-		if (!dirty)
+		error = xlog_recover_do_dquot_buffer(mp, log, item, bp, buf_f);
+		if (error <= 0)
 			goto out_release;
+		/* write dirty buffer */
+		error = 0;
 	} else if ((xfs_blft_from_flags(buf_f) & XFS_BLFT_SB_BUF) &&
 			xfs_buf_daddr(bp) == 0) {
 		error = xlog_recover_do_primary_sb_buffer(mp, item, bp, buf_f,
@@ -1038,7 +1060,10 @@ xlog_recover_buf_commit_pass2(
 		if (error)
 			goto out_release;
 	} else {
-		xlog_recover_do_reg_buffer(mp, item, bp, buf_f, current_lsn);
+		error = xlog_recover_do_reg_buffer(mp, item, bp, buf_f,
+						   current_lsn);
+		if (error)
+			goto out_release;
 	}
 
 	/*
-- 
2.53.0

