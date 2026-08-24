Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C067F437861
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580364; cv=none; b=YlvRIoMd8KZH9cvVwVKooWf/4wBwbxPyCcw97WqziBHnLIcVOpKwCKIIUG982xIo6031mSIsligcUt9tAROc+Aul2X0P5x2LdHPzhSUjM6Y1RMDTC8J8IFE313k4HIqg8gbF75GSI9+CTwKYuolYdLnA0UsCShXYriIoWvJlx/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580364; c=relaxed/simple;
	bh=T2+FqUUkx0eVdSo71HjNeLdV9XBdqJ/UKsAUMl2AltQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObeTDW0HWc/s5uiRQn3hu9q8FNxLKOWoHRgKoT4Y0Fo3IZ5j/IZiQ8rRhV5+PSNKUk/VTPUhgpxhVbiUOsflMC0QZqbqyQDLbKR9pyR1N1BJWlb8n90GoQTSCm7SiWyifuwQ1pIlfNV8hhzchc8Q5P4x0aq93YIsmb6ZqSRm5wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+9GdSbu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+9GdSbu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095361F00A3F;
	Mon, 24 Aug 2026 14:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787580362;
	bh=2NlF2o+TTq91b9gBH6KfS1QQfwC2+bhN2PKNwQbA5+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W+9GdSbuZbcwdRFUpBIgDWEfF1IVmfxHidSkBGEInxgQ0ATmB/AZYJcmSolicfzeW
	 d0W4z25moBfRQ+9yJI2kLv+LJWnLg02D7g3G8kVDWVb7325D+Q54mKQH+l+dsvXFNm
	 1pbitSQ7nneZXJNyGGvBU5OjHhCQ15h1uF/U6o2ppsOQwSuAbDvIYoQPeJzUJx7LUX
	 RzSUsp8L8xT5rY6oYs5QMaFKZvl6nOhQ3L3CxPJ6o6cZRZf0x4lSVWK9aXT66bPw+9
	 qhEfBfETubzT+SN1AK4N6G43pozfxUXbBPYhUo55BmQBsmHTRdNaIndkHLJfnhB/iU
	 9iXuWAmB6iOfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ibrahim Hashimov <security@auditcode.ai>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: bounds-check buffer log item's dirty bitmap
Date: Mon, 24 Aug 2026 10:06:00 -0400
Message-ID: <20260824140600.3098208-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082047-moonwalk-headwear-455d@gregkh>
References: <2026082047-moonwalk-headwear-455d@gregkh>
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
 fs/xfs/xfs_buf_item_recover.c | 53 +++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/fs/xfs/xfs_buf_item_recover.c b/fs/xfs/xfs_buf_item_recover.c
index a053b0bf79308..eddef2f994678 100644
--- a/fs/xfs/xfs_buf_item_recover.c
+++ b/fs/xfs/xfs_buf_item_recover.c
@@ -432,7 +432,7 @@ xlog_recover_validate_buf_type(
  * given buffer.  The bitmap in the buf log format structure indicates
  * where to place the logged data.
  */
-STATIC void
+STATIC int
 xlog_recover_do_reg_buffer(
 	struct xfs_mount		*mp,
 	struct xlog_recover_item	*item,
@@ -460,8 +460,24 @@ xlog_recover_do_reg_buffer(
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
+				bp->b_bn);
+			return -EFSCORRUPTED;
+		}
 
 		/*
 		 * The dirty regions logged in the buffer, even though
@@ -515,6 +531,7 @@ xlog_recover_do_reg_buffer(
 	ASSERT(i == item->ri_total);
 
 	xlog_recover_validate_buf_type(mp, bp, buf_f, current_lsn);
+	return 0;
 }
 
 /*
@@ -523,10 +540,10 @@ xlog_recover_do_reg_buffer(
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
@@ -535,6 +552,7 @@ xlog_recover_do_dquot_buffer(
 	struct xfs_buf_log_format	*buf_f)
 {
 	uint			type;
+	int			error;
 
 	trace_xfs_log_recover_buf_dquot_buf(log, buf_f);
 
@@ -542,7 +560,7 @@ xlog_recover_do_dquot_buffer(
 	 * Filesystems are required to send in quota flags at mount time.
 	 */
 	if (!mp->m_qflags)
-		return false;
+		return 0;
 
 	type = 0;
 	if (buf_f->blf_flags & XFS_BLF_UDQUOT_BUF)
@@ -555,10 +573,12 @@ xlog_recover_do_dquot_buffer(
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
@@ -943,13 +963,16 @@ xlog_recover_buf_commit_pass2(
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

