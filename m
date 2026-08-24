Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5991117A586
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570126; cv=none; b=iHy+XDBMU0UmjSNfAETTzp99QmYIFToH8ds1h5uBE1PjOA2cMO5Vqt+nx9I3ymIKDT4mD5u25warpqwg7uHKc0bIKMqFePxHENZjReUViawsBTyoJO2JC3oU0O0N/dbpdXLOcpiy2O0e3JE1QCJIlGaqM8VYB/HYI5W2N0kOaH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570126; c=relaxed/simple;
	bh=oQM7ns456EmqWWekx6KcLjuz45/dT38oO8GStHjDQMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXLKKRdDTN+3YtD4Bp84gaamm5S1KrSLiJ0NUfYP1qrXEzkdzv1uorhscasrjbVtWoSU+qnNqX4AX7N/nH6AgUUp8fg0/Ke1IWKUKp1vdG/cWZilkuE8r1OIOOL3IQmVCemCVxgKvxLXMU/pgdpg07Gm2FWzisvcxht+EIpB+90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5RqKDVS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5RqKDVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65ADD1F000E9;
	Mon, 24 Aug 2026 11:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787570124;
	bh=fW8qMpa1GMUwi9+TJXem/MesCRQ7OruunVAAklLNWkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J5RqKDVSVwFMIGp/nT6WppqJnaOKqKzvUE7/usdO7eHfPTsG21ilZPvOBBC5xzJ9m
	 J2vqpNxwcx189ha9PxijWCLbswY1AlkxFiPr8RVE304Z2ZTQDWXpY2yu1+ylnoneUV
	 daqEfU+X1pbKDna8NFtcC4QFE10ejn+Koq+5HHrJbsVbbbM/9XIW7YyogQ6UZrF3zp
	 mk1H+aq3U0WJUEw1TGduqdWI+EkBofmKaI7ojXEoe6HeykltpcqwiKUftZ0hzpvkn5
	 2R5na8sZeDKMg7JKolMRPIffS9rHYULNfBo/QWRFkL73ipLfBqS9wy9qOs8aKuJ+fy
	 dZkLcZCxbjSRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ibrahim Hashimov <security@auditcode.ai>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xfs: bounds-check buffer log item's dirty bitmap
Date: Mon, 24 Aug 2026 07:15:21 -0400
Message-ID: <20260824111521.304665-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082046-courier-bottling-21bc@gregkh>
References: <2026082046-courier-bottling-21bc@gregkh>
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
[ adapted `ri_buf[]` field names `iov_base`/`iov_len` to 5.15's `i_addr`/`i_len` and dropped the hunks for the absent `xlog_recover_do_primary_sb_buffer()` and primary-SB branch while keeping the `error = 0` reset ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_buf_item_recover.c | 53 +++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/fs/xfs/xfs_buf_item_recover.c b/fs/xfs/xfs_buf_item_recover.c
index 31cbe7deebfaf..63cb5b60b6248 100644
--- a/fs/xfs/xfs_buf_item_recover.c
+++ b/fs/xfs/xfs_buf_item_recover.c
@@ -441,7 +441,7 @@ xlog_recover_validate_buf_type(
  * given buffer.  The bitmap in the buf log format structure indicates
  * where to place the logged data.
  */
-STATIC void
+STATIC int
 xlog_recover_do_reg_buffer(
 	struct xfs_mount		*mp,
 	struct xlog_recover_item	*item,
@@ -469,8 +469,24 @@ xlog_recover_do_reg_buffer(
 		ASSERT(nbits > 0);
 		ASSERT(item->ri_buf[i].i_addr != NULL);
 		ASSERT(item->ri_buf[i].i_len % XFS_BLF_CHUNK == 0);
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
@@ -524,6 +540,7 @@ xlog_recover_do_reg_buffer(
 	ASSERT(i == item->ri_total);
 
 	xlog_recover_validate_buf_type(mp, bp, buf_f, current_lsn);
+	return 0;
 }
 
 /*
@@ -532,10 +549,10 @@ xlog_recover_do_reg_buffer(
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
@@ -544,6 +561,7 @@ xlog_recover_do_dquot_buffer(
 	struct xfs_buf_log_format	*buf_f)
 {
 	uint			type;
+	int			error;
 
 	trace_xfs_log_recover_buf_dquot_buf(log, buf_f);
 
@@ -551,7 +569,7 @@ xlog_recover_do_dquot_buffer(
 	 * Filesystems are required to send in quota flags at mount time.
 	 */
 	if (!mp->m_qflags)
-		return false;
+		return 0;
 
 	type = 0;
 	if (buf_f->blf_flags & XFS_BLF_UDQUOT_BUF)
@@ -564,10 +582,12 @@ xlog_recover_do_dquot_buffer(
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
@@ -962,13 +982,16 @@ xlog_recover_buf_commit_pass2(
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

