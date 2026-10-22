Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674826;
	b=by9YV6hmyRi1JbEtBDbMRfITs/pcwMKZJWmFFWgitPb+pABVPaV6oFAWREa6yFgqa86l
	 N6O6/VleBTiMByaVUUOentQW1b3OMsXDQJZ5xwF8pBMZry4wL+OKHsaFBz8MklUlNpcxx
	 W5Rpjyh43Zp3jdzbZ5cydrtkpeKIpwB8vHB0tA/JncMBJhK+90FKdKB/TnwvF4jlYUO1v
	 Jlfn8PwkQUfy/Y2hGawugJQgvbxp9pKP9M/ESSQfOHvJUj9YWDeusJA+m3dKw8gL+xOue
	 l3s3WGzrg6YvVy4DlTcr8eLcfzAEOph/gnBk05Q7/LAcidkODbU9Z1ClKKzMgwiVy4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674826;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Nij4UFex7vIZGvPRaWIyk3v+cFyndrkTWXfYRn1JmnE=;
	b=uXYiP0G1ODhb2JyCrQN68a2KJMt3URiAz02JIk1aj+i2aKhyZ37tIaaPUarsh/NbQLBB
	 wy7fi/VKYlxKI+BM3neLBabn/ZHPlr5jeLR2K+ocYGCaqXZ+Kg3+DrZfBUYjnjRGrPbSM
	 o/gDiPqWBmFylT9arWRHfxhoNOPwOutgb/dV+Nd35LMZZ7Ui10bfE2VHrAWrmuoaEl5qf
	 Ao6DgIETeivSiZ2UMsQ+2/+EbS28BZBc9rEb8LJTyjmTSIXhOZONZbDP5DoNmO+HElb8F
	 v5XlEFWJ8S8JId4TKHoq2OY0s7EpTV2Rmxfi9SxYLsEe5SCd8HBgzuQ6y9m0SonlOrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="DuMjTdD/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB08606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=DuMjTdD/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CAF1F000C3;
	Thu, 22 Oct 2026 13:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792674825;
	bh=Nij4UFex7vIZGvPRaWIyk3v+cFyndrkTWXfYRn1JmnE=;
	h=Subject:To:Cc:From:Date;
	b=DuMjTdD/cqUB/S1gaxiA+j0lxp4llVbXSUGLYNkUeS14zfdkrJaXNR7KKlCZbExsO
	 K2Jm7iF0YYtQvMST8RGZmrXC116T720vG34C6SGXPQPZPUfVgw6GdGQ26dbQZHmHq5
	 +Ti9Lp/bbsw1XEt1AYFvotP8m4zRPHssIcmwJAFA=
Subject: FAILED: patch "[PATCH] ntfs: take invalidate_lock in ntfs_filemap_page_mkwrite()" failed to apply to 7.2-stable tree
To: zenghongling@kylinos.cn,hyc.lee@gmail.com,linkinjeon@kernel.org,liubaolin@kylinos.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 22 Oct 2026 15:12:40 +0200
Message-ID: <2026102240-impending-elusive-74a7@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 0fecc393f2060e6bc25138df32cb923ec7071c6b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102240-impending-elusive-74a7@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0fecc393f2060e6bc25138df32cb923ec7071c6b Mon Sep 17 00:00:00 2001
From: Hongling Zeng <zenghongling@kylinos.cn>
Date: Mon, 31 Aug 2026 16:32:52 +0800
Subject: [PATCH] ntfs: take invalidate_lock in ntfs_filemap_page_mkwrite()

ntfs_filemap_page_mkwrite() calls iomap_page_mkwrite() without holding
mapping->invalidate_lock, so a concurrent truncate or fallocate can be
in the middle of invalidating pagecache and rewriting the runlist while
the write fault maps blocks and dirties the folio.  This races with
ntfs_attr_fallocate(), which merges clusters into the in-memory
runlist, drops the runlist lock, and only afterwards zeroes the newly
allocated clusters on disk; and with the punch-hole/insert/collapse
paths that free clusters after truncating the cache.

Per Documentation/filesystems/locking.rst, ->page_mkwrite() must ensure
there are no truncate/invalidate races, "usually mapping->invalidate_lock
is suitable for proper serialization".  xfs takes its mmaplock (= the
invalidate_lock rwsem) shared in exactly this path.

Take invalidate_lock shared around iomap_page_mkwrite().  The read-only
fault path is already covered because filemap_fault() itself grabs
invalidate_lock shared on instantiation/read paths; only page_mkwrite
was bypassing it in this driver.

Fixes: 9c87959601e8 ("ntfs: update file operations")
Cc: stable@vger.kernel.org
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Co-developed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 585ab2145797..8164326b7812 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -676,6 +676,7 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 static vm_fault_t ntfs_filemap_page_mkwrite(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct address_space *mapping = inode->i_mapping;
 	vm_fault_t ret;
 
 	if (NInoWofCompressed(NTFS_I(inode)))
@@ -684,7 +685,14 @@ static vm_fault_t ntfs_filemap_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vmf->vma->vm_file);
 
+	/*
+	 * Serialize against truncate/fallocate which hold the lock
+	 * exclusively while invalidating pagecache and changing extents.
+	 */
+	filemap_invalidate_lock_shared(mapping);
 	ret = iomap_page_mkwrite(vmf, &ntfs_page_mkwrite_iomap_ops, NULL);
+	filemap_invalidate_unlock_shared(mapping);
+
 	sb_end_pagefault(inode->i_sb);
 	return ret;
 }
@@ -1185,13 +1193,15 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 
 	err = file_modified(file);
 out:
+	if (!err && mode == 0 && NInoNonResident(ni) &&
+	    offset > old_size) {
+		truncate_pagecache(vi, old_size);
+		pagecache_isize_extended(vi, old_size, offset);
+	}
+
 	filemap_invalidate_unlock(vi->i_mapping);
+
 	if (!err) {
-		if (mode == 0 && NInoNonResident(ni) &&
-		    offset > old_size) {
-			truncate_pagecache(vi, old_size);
-			pagecache_isize_extended(vi, old_size, offset);
-		}
 		NInoSetFileNameDirty(ni);
 		inode_set_mtime_to_ts(vi, inode_set_ctime_current(vi));
 		mark_inode_dirty(vi);

