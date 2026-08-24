Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BAC40F759
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574477; cv=none; b=WJZqXKNbJht2hdm/nsqy3koG48xUJBdnGfl0qSOxdgX3Qy+q9LytZ3ZunrQ81QZkMYfJffEb9c9MpqPMcXT2UrWScbUBuckQL2QdNGQ6Xq+mz5sQFLH5+N6xWD/2rluiFyP/G/o8fMd+iYtXAcZ/BeargHo8XEtx9Jiy7j3fXfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574477; c=relaxed/simple;
	bh=hpjocg6hDarCmtLqIsQJ3jeRbN3K2JyQ/qAlCVdp7as=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ABJD21cSP/c5KT7TJdqpbJD2bA+U1QhrXOUFzR5Y7SwOZawsdYihHIRo5Kd7QBkuTxublYUS40+Y2qP++DoaTxvvHBYvKpjzm6By1vFE/mRzgmQTryhI2kP7kr7iv0ib2+kZJhot/gvOzQphkEvVtACVNRZ3U3ppVuzXxa78Lwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vtbFbJGt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vtbFbJGt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD8C1F000E9;
	Mon, 24 Aug 2026 12:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787574475;
	bh=qj2WcBfoUmKIVroxaFd7GB29MpcQ0cQlJlfeiVZzqlg=;
	h=Subject:To:Cc:From:Date;
	b=vtbFbJGtvmEb6i4wxC1DXm2ke/T62jtGPSuJwABA6uAGyHEEpdyjydy3KLAJrNhje
	 PgX1jqMDFn14gDGbLf7puCFtTikrd2u0E9slQkapAECphHUg+IKKD5htDcAroLmKg/
	 qUjBudw+6Qt+LiNRPz9GCRCNL8cuP73U5A4DIkKA=
Subject: FAILED: patch "[PATCH] ext4: protect WRITE_ZEROES written extents with orphan list" failed to apply to 7.1-stable tree
To: yi.zhang@huawei.com,jack@suse.cz,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Aug 2026 14:27:48 +0200
Message-ID: <2026082448-destiny-guzzler-a437@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x f7237a775c8f3e99e0e77b7c10fb626815fb2877
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082448-destiny-guzzler-a437@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f7237a775c8f3e99e0e77b7c10fb626815fb2877 Mon Sep 17 00:00:00 2001
From: Zhang Yi <yi.zhang@huawei.com>
Date: Wed, 29 Jul 2026 16:59:18 +0800
Subject: [PATCH] ext4: protect WRITE_ZEROES written extents with orphan list

In ext4_alloc_file_blocks(), the WRITE_ZEROES path converts unwritten
extents to written in one transaction, while i_disksize is updated to
cover them only in a later transaction. A crash in between leaves
written extents beyond i_disksize on disk, which fsck will complain
about.

To fix this, add the inode to the orphan list in the same handle that
does the conversion, and remove it once i_disksize has caught up.
Also add a sanity check to ensure conversion does not extend beyond EOF.

Since ext4_alloc_file_blocks() is called from the fallocate() path,
partial allocation is safe. On partial conversion failure, advance
i_disksize only up to the boundary of successfully converted blocks, so
that orphan cleanup sees a consistent state. Document this behavior in
the function comment.

Reported-by: Jan Kara <jack@suse.cz>
Closes: https://lore.kernel.org/linux-ext4/3f6ao5amv7glbgigndtegcucgo3n34ij3lau6l3da3hgdxgn3v@ev66wv3r5umt/
Fixes: f4265b8d32c4 ("ext4: add FALLOC_FL_WRITE_ZEROES support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260729085918.3336221-3-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 1ab1a6e2ed83..a3dde7ba0d23 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4571,6 +4571,22 @@ int ext4_ext_truncate(handle_t *handle, struct inode *inode)
 	return err;
 }
 
+/*
+ * Pre-allocate blocks for the range [@offset, @offset + @len). Allocated
+ * blocks are marked as unwritten by default. If EXT4_GET_BLOCKS_ZERO is
+ * set, the allocated blocks are zeroed on disk and their extents are
+ * converted to written state.
+ *
+ * When @new_size is nonzero, the caller intends to extend the file, and
+ * the file size should be updated to the end of the allocated blocks.
+ *
+ * Allocation may partially succeed due to some non-fatal issues. In that
+ * case, i_disksize (and i_size) is advanced up to the successfully
+ * processed portion of the range.
+ *
+ * Return 0 on success, or a negative error code on failure or partial
+ * failure.
+ */
 static int ext4_alloc_file_blocks(struct file *file, loff_t offset, loff_t len,
 				  loff_t new_size, int flags)
 {
@@ -4585,6 +4601,7 @@ static int ext4_alloc_file_blocks(struct file *file, loff_t offset, loff_t len,
 	loff_t epos = 0, old_size = i_size_read(inode);
 	unsigned int blkbits = inode->i_blkbits;
 	bool alloc_zero = false;
+	bool orphan = false;
 
 	BUG_ON(!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS));
 	map.m_lblk = offset >> blkbits;
@@ -4659,19 +4676,49 @@ static int ext4_alloc_file_blocks(struct file *file, loff_t offset, loff_t len,
 
 		if (alloc_zero &&
 		    (map.m_flags & (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN))) {
+			ext4_lblk_t converted;
+
+			WARN_ON_ONCE(map.m_lblk + map.m_len >
+				EXT4_B_TO_LBLK(inode, new_size ?: old_size));
+
 			ret = ext4_issue_zeroout(inode, map.m_lblk, map.m_pblk,
 						 map.m_len);
-			if (likely(!ret))
-				ret = ext4_convert_unwritten_extents(NULL,
-					inode, (loff_t)map.m_lblk << blkbits,
-					(loff_t)map.m_len << blkbits, NULL);
-			if (ret)
+			if (unlikely(ret))
 				break;
+
+			handle = ext4_journal_start(inode, EXT4_HT_MAP_BLOCKS,
+						    credits);
+			if (IS_ERR(handle)) {
+				ret = PTR_ERR(handle);
+				break;
+			}
+
+			ret = ext4_convert_unwritten_extents(handle,
+					inode, (loff_t)map.m_lblk << blkbits,
+					(loff_t)map.m_len << blkbits,
+					&converted);
+			if (ret)
+				map.m_len = converted;
+
+			/*
+			 * If blocks beyond i_disksize are converted, add
+			 * the inode to the orphan list and advance the epos.
+			 */
+			if (new_size && converted) {
+				ret2 = ext4_orphan_add(handle, inode);
+				ret = ret ? ret : ret2;
+				orphan = true;
+			}
+
+			ret3 = ext4_journal_stop(handle);
+			ret = ret ? ret : ret3;
 		}
 
 		map.m_lblk += map.m_len;
 		map.m_len = len_lblk = len_lblk - map.m_len;
 		epos = EXT4_LBLK_TO_B(inode, map.m_lblk);
+		if (ret)
+			break;
 	}
 
 	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
@@ -4687,11 +4734,23 @@ static int ext4_alloc_file_blocks(struct file *file, loff_t offset, loff_t len,
 	if (epos > new_size)
 		epos = new_size;
 
-	handle = ext4_journal_start(inode, EXT4_HT_MISC, 1);
-	if (IS_ERR(handle))
-		return ret ? ret : PTR_ERR(handle);
+	handle = ext4_journal_start(inode, EXT4_HT_MISC, 2);
+	if (IS_ERR(handle)) {
+		/*
+		 * The conversion has successfully completed. Not much to
+		 * do with the error here so just cleanup the orphan list
+		 * and hope for the best.
+		 */
+		if (orphan && inode->i_nlink)
+			ext4_orphan_del(NULL, inode);
+		ret2 = PTR_ERR(handle);
+		goto out;
+	}
 
 	ext4_update_inode_size(inode, epos);
+	if (orphan && inode->i_nlink)
+		ext4_orphan_del(handle, inode);
+
 	ret2 = ext4_mark_inode_dirty(handle, inode);
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 	ret3 = ext4_journal_stop(handle);
@@ -4699,6 +4758,9 @@ static int ext4_alloc_file_blocks(struct file *file, loff_t offset, loff_t len,
 
 	if (epos > old_size)
 		pagecache_isize_extended(inode, old_size, epos);
+out:
+	if (ret2)
+		ext4_std_error(inode->i_sb, ret2);
 
 	return ret ? ret : ret2;
 }

