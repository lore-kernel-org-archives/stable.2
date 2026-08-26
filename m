Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23281226CFE
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787705383; cv=none; b=pg5eJ3CUg93Gs7leL4U4GxXoJlPdceVBsNYvuRl+D4857QS2lL4YFtvSrHruGId1Vq2/781RP78J0o34b8IddINquCQx/gSYMnfwIX8A4a9rhUGbDSsZL6u3Ms/PIAIqWyBEZS7srYMdHjDUAaX55MbCEx23mhqFnapv3EGMLC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787705383; c=relaxed/simple;
	bh=U2NaoP+8UaHUUkDdFSRx8/u0+b4LyaTMqcs+raZflzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sD2ks+v/okYd4lrpqPG7CYpGIP4QPaRWTL6Q5X+tVcmgOY0jjvVj1Lc2SmihAIDqIXdvaE5grjrCTKjMcSosNs6tmeJZcExE0k5leBx834BpfsSaFDwypQZ9eZLsXGmg1ZMJhO8rp/dikeb6vHUw/nC4d7CyfuPnJNlkpjaAPrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSlvy0r6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSlvy0r6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E171F000E9;
	Wed, 26 Aug 2026 00:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787705382;
	bh=fg2KmhJK6AJSi2LRpHWmIxmQCFrjlG7wzLL0+sRW5Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BSlvy0r6v3kex/UQN/2w1IQahWdsnxz5IRXqxjR7+OUKXHwaC/q2MjJXURvxk4+sM
	 aBY/nG8+BV0S1+QzJxS8hMswYU1l3SK/ylwkpUEW6uXiZDyYoC+jBs/3FEl1O5oc1y
	 h84cjktG/A5sUgJxxjGse9N+AXS5vVfwEWGIqvIKjeil5orZiZq88HZh9lcwg5Vte8
	 QV7rXPQoUyAkH/Yx6gcUxtyAAPnjS8qgRiLWHcUaExcsoRugNU3ewyWZQkGyH+mRPy
	 FM+TuUi0P+vlo8MnF4OVE2WIQz9uaypBxVaBOeRlFZ1v0eiYXfHm+MLT9Z2D8d0uep
	 T6TeHMscWCyvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/2] ext4: export converted block count from ext4_convert_unwritten_extents()
Date: Tue, 25 Aug 2026 20:49:38 -0400
Message-ID: <20260826004939.828750-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082448-destiny-guzzler-a437@gregkh>
References: <2026082448-destiny-guzzler-a437@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 5b3dcb924a38ecd2c0d828ff30c357357eda1da8 ]

ext4_convert_unwritten_extents() currently returns only a success or a
failure indication. A zero return means all requested blocks were
converted, and a negative value means the conversion failed. However,
some blocks may have already been converted when the function fails
partway through, and callers have no way to learn how many were done.

The WRITE_ZEROES caller in ext4_alloc_file_blocks() needs this
information to decide whether to add the inode to the orphan list before
updating i_disksize to cover the already-converted written extents, so
that a crash before i_disksize catches up can be recovered via orphan
truncation.

Switch the function to pass out the number of converted blocks through
the new output parameter @converted, which will be used by later
patches.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260729085918.3336221-2-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: f7237a775c8f ("ext4: protect WRITE_ZEROES written extents with orphan list")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ext4.h    |  3 ++-
 fs/ext4/extents.c | 53 ++++++++++++++++++++++++++++++-----------------
 fs/ext4/file.c    |  3 ++-
 3 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 6569d1d575a01..f16d3af8ca839 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3813,7 +3813,8 @@ extern void ext4_ext_release(struct super_block *);
 extern long ext4_fallocate(struct file *file, int mode, loff_t offset,
 			  loff_t len);
 extern int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
-					  loff_t offset, ssize_t len);
+					  loff_t offset, ssize_t len,
+					  ext4_lblk_t *converted);
 extern int ext4_convert_unwritten_extents_atomic(handle_t *handle,
 			struct inode *inode, loff_t offset, ssize_t len);
 extern int ext4_convert_unwritten_io_end_vec(handle_t *handle,
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 125f628e738ab..cf45b25ebfa83 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4664,7 +4664,7 @@ static int ext4_alloc_file_blocks(struct file *file, loff_t offset, loff_t len,
 			if (likely(!ret))
 				ret = ext4_convert_unwritten_extents(NULL,
 					inode, (loff_t)map.m_lblk << blkbits,
-					(loff_t)map.m_len << blkbits);
+					(loff_t)map.m_len << blkbits, NULL);
 			if (ret)
 				break;
 		}
@@ -5026,21 +5026,26 @@ int ext4_convert_unwritten_extents_atomic(handle_t *handle, struct inode *inode,
  * all unwritten extents within this range will be converted to
  * written extents.
  *
- * This function is called from the direct IO end io call back
- * function, to convert the fallocated extents after IO is completed.
- * Returns 0 on success.
+ * This function is called from the direct/buffered I/O end io call back
+ * function and FALLOC_FL_WRITE_ZEROES, to convert the fallocated
+ * unwritten extents after data I/O is completed.
+ *
+ * Returns 0 on full success, or a negative error code on partial
+ * success or failure. The number of blocks converted is returned via
+ * @converted.
  */
 int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
-				   loff_t offset, ssize_t len)
+				   loff_t offset, ssize_t len,
+				   ext4_lblk_t *converted)
 {
-	unsigned int max_blocks;
+	ext4_lblk_t max_blocks, conv_blocks = 0;
 	int ret = 0, ret2 = 0, ret3 = 0;
 	struct ext4_map_blocks map;
 	unsigned int blkbits = inode->i_blkbits;
 	unsigned int credits = 0;
 
 	map.m_lblk = offset >> blkbits;
-	max_blocks = EXT4_MAX_BLOCKS(len, offset, blkbits);
+	map.m_len = max_blocks = EXT4_MAX_BLOCKS(len, offset, blkbits);
 
 	if (!handle) {
 		/*
@@ -5048,9 +5053,8 @@ int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
 		 */
 		credits = ext4_chunk_trans_blocks(inode, max_blocks);
 	}
-	while (ret >= 0 && ret < max_blocks) {
-		map.m_lblk += ret;
-		map.m_len = (max_blocks -= ret);
+
+	while (max_blocks) {
 		if (credits) {
 			handle = ext4_journal_start(inode, EXT4_HT_MAP_BLOCKS,
 						    credits);
@@ -5067,23 +5071,34 @@ int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
 		ret = ext4_map_blocks(handle, inode, &map,
 				      EXT4_GET_BLOCKS_IO_CONVERT_EXT |
 				      EXT4_EX_NOCACHE);
-		if (ret <= 0)
+		if (ret <= 0) {
 			ext4_warning(inode->i_sb,
-				     "inode #%llu: block %u: len %u: "
-				     "ext4_ext_map_blocks returned %d",
-				     inode->i_ino, map.m_lblk,
-				     map.m_len, ret);
+				     "inode #%llu: block %u: len %u: ext4_map_blocks returned %d",
+				     inode->i_ino, map.m_lblk, map.m_len, ret);
+			if (unlikely(ret == 0))
+				ret = -EINVAL;
+		} else {
+			conv_blocks += map.m_len;
+		}
+
 		ret2 = ext4_mark_inode_dirty(handle, inode);
 		if (credits) {
 			ret3 = ext4_journal_stop(handle);
 			if (unlikely(ret3))
 				ret2 = ret3;
 		}
-
-		if (ret <= 0 || ret2)
+		ret = ret < 0 ? ret : ret2;
+		if (ret)
 			break;
+
+		map.m_lblk += map.m_len;
+		map.m_len = (max_blocks -= map.m_len);
 	}
-	return ret > 0 ? ret2 : ret;
+	/* Converted some or all blocks successfully? */
+	if (converted)
+		*converted = conv_blocks;
+
+	return ret;
 }
 
 int ext4_convert_unwritten_io_end_vec(handle_t *handle, ext4_io_end_t *io_end)
@@ -5106,7 +5121,7 @@ int ext4_convert_unwritten_io_end_vec(handle_t *handle, ext4_io_end_t *io_end)
 	list_for_each_entry(io_end_vec, &io_end->list_vec, list) {
 		ret = ext4_convert_unwritten_extents(handle, io_end->inode,
 						     io_end_vec->offset,
-						     io_end_vec->size);
+						     io_end_vec->size, NULL);
 		if (ret)
 			break;
 	}
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index eb1a323962b10..78db5749cbcc3 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -400,7 +400,8 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
 		error = ext4_convert_unwritten_extents_atomic(NULL, inode, pos,
 							      size);
 	else if (!error && size && flags & IOMAP_DIO_UNWRITTEN)
-		error = ext4_convert_unwritten_extents(NULL, inode, pos, size);
+		error = ext4_convert_unwritten_extents(NULL, inode, pos, size,
+						       NULL);
 	if (error)
 		return error;
 	/*
-- 
2.53.0

