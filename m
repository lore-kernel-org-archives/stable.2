Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6204E4AF9F3
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211518; cv=none; b=FiY5hArhxB6Q6sBUzaBhasBvZ9b8dH2soOZLF67oJP7S5AGWm47NlGaWH23N9YqxN1ILlbo8sgAn2H73/Q4RvGDLW4PmukHkP5GKTSzZxeZqSh239B7+gDQyD8km0srOXJn3MnMs/jWy5emzSMVUUilhWNYyagrIO6U7evmXZik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211518; c=relaxed/simple;
	bh=TgyZrqt36OuHEVUoQ1BGffj2dKoBChjZlHINMDbxWKE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fER1q5pWqKVW8bCgLYl4+prGfStxHtQlrWA5i5rATV03ukHc4H9UotPPKicThDIJM+KEnjzNQcq3/u08ICH8jrQumoUQR2smn44E+Q0uOb1UFY8bVVJF4M5oUuXGNYrv1PsmdpDShcM+AjqwdQST9j1DtajiNTN4uQNtyBDWm1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CNf8bG49; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CNf8bG49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E906B1F000FF;
	Mon,  5 Oct 2026 14:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211505;
	bh=ypXGqnPvIuL5u7xr1Nrtvp7iMEbNmG2OC6lP2JNmymM=;
	h=Subject:To:Cc:From:Date;
	b=CNf8bG49Wx0HHlW2nn6VLQ4jktmjwFK7kyjtqG8ZA/2b5n65c+DitJEIO/RXdtrHx
	 v6yUA6EZSnIdhatoVAs1uBL81C5k+Y2gJwK+CM4hR7hy9K97r8TuiQ3Ia2nN/35M3u
	 cerJlgNcvi0wctbAzvalI9seWpKFMZzRn5qqLAOg=
Subject: FAILED: patch "[PATCH] smb: client: clear post-EOF pagecache when extending a file" failed to apply to 7.2-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,brauner@kernel.org,dhowells@redhat.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:45:02 +0200
Message-ID: <2026100502-cognitive-zipping-a488@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 35024595f641e790e24609f3f046e1667e3b280a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100502-cognitive-zipping-a488@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 35024595f641e790e24609f3f046e1667e3b280a Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Sun, 20 Sep 2026 15:05:44 -0300
Subject: [PATCH] smb: client: clear post-EOF pagecache when extending a file
 via truncate

cifs_setsize() relied on pagecache_isize_extended() to zero the tail of
the folio straddling the old EOF, but that helper is a no-op on CIFS
(i_blkbits is 14), so data dirtied past EOF through an mmap survived
and became visible once the file was extended.

Use netfs_clear_stale_post_isize() instead, called after i_size is
updated since cifs_setsize() callers hold i_rwsem exclusively for the
whole resize.  truncate_pagecache() is then called as in
truncate_setsize(): a no-op on extend, and it drops the pagecache
beyond the new EOF on shrink.

Also thread old_size as an explicit parameter through cifs_setsize()
and cifs_resize_file_locked(), captured by each caller before its own
resize RPC.  This closes a race where a concurrent stat() could adopt
the RPC's already-updated server size via is_size_safe_to_change()
before cifs_setsize() reads old_size itself.

Closes: https://sashiko.dev/#/patchset/20260921230755.1133425-1-pc%40manguebit.org
Fixes: c510edb9734a ("cifs: call pagecache_isize_extended() in cifs_setsize() when extending")
Reviewed-by: David Howells <dhowells@redhat.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org

diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index 0c85daa8386e..e3d820c9778b 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -146,8 +146,9 @@ ssize_t cifs_file_copychunk_range(unsigned int xid, struct file *src_file,
 				  unsigned int flags);
 
 long cifs_ioctl(struct file *filep, unsigned int command, unsigned long arg);
-void cifs_setsize(struct inode *inode, loff_t offset);
-void cifs_resize_file_locked(struct inode *inode, loff_t offset);
+void cifs_setsize(struct inode *inode, loff_t old_size, loff_t offset);
+void cifs_resize_file_locked(struct inode *inode, loff_t old_size,
+			     loff_t offset);
 
 struct fs_context;
 struct smb3_fs_context;
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 0d428517f454..4bcb87610897 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -1017,6 +1017,7 @@ static int cifs_do_truncate(const unsigned int xid, struct dentry *dentry)
 	if (!rc) {
 		if (cfile) {
 			struct netfs_inode *ictx = netfs_inode(inode);
+			loff_t old_size = i_size_read(inode);
 
 			tcon = tlink_tcon(cfile->tlink);
 			server = tcon->ses->server;
@@ -1025,7 +1026,7 @@ static int cifs_do_truncate(const unsigned int xid, struct dentry *dentry)
 							cfile, 0, false);
 			if (!rc) {
 				netfs_resize_file(&cinode->netfs, 0, true);
-				cifs_setsize(inode, 0);
+				cifs_setsize(inode, old_size, 0);
 				cifs_invalidate_cache(inode, 0);
 			}
 			netfs_wb_end(ictx);
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 1fe0ef0a95db..5062474991cf 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -3053,15 +3053,12 @@ int cifs_fiemap(struct inode *inode, struct fiemap_extent_info *fei, u64 start,
 	return -EOPNOTSUPP;
 }
 
-void cifs_setsize(struct inode *inode, loff_t offset)
+void cifs_setsize(struct inode *inode, loff_t old_size, loff_t offset)
 {
-	loff_t old_size;
 	u64 blocks = CIFS_INO_BLOCKS(offset);
 
 	spin_lock(&inode->i_lock);
-	old_size = i_size_read(inode);
 	i_size_write(inode, offset);
-
 	/*
 	 * Extending EOF does not allocate the intervening range. Only clamp
 	 * i_blocks on shrink; allocation growth comes from writes or from the
@@ -3071,20 +3068,28 @@ void cifs_setsize(struct inode *inode, loff_t offset)
 		inode->i_blocks = blocks;
 	spin_unlock(&inode->i_lock);
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
+
+	/*
+	 * Zero the tail of the folio straddling the old EOF so data dirtied
+	 * past EOF through an mmap isn't exposed.  truncate_pagecache() then
+	 * drops any pagecache beyond the new EOF, as in truncate_setsize().
+	 */
 	if (offset > old_size)
-		pagecache_isize_extended(inode, old_size, offset);
+		netfs_clear_stale_post_isize(inode, old_size, offset);
+
 	truncate_pagecache(inode, offset);
 	netfs_wait_for_outstanding_io(inode);
 }
 
-void cifs_resize_file_locked(struct inode *inode, loff_t offset)
+void cifs_resize_file_locked(struct inode *inode, loff_t old_size,
+			     loff_t offset)
 {
 	struct fscache_cookie *cookie = cifs_inode_cookie(inode);
 
 	lockdep_assert_held_write(&inode->i_rwsem);
 
 	netfs_resize_file(netfs_inode(inode), offset, true);
-	cifs_setsize(inode, offset);
+	cifs_setsize(inode, old_size, offset);
 
 	if (!cookie)
 		return;
@@ -3101,6 +3106,7 @@ int cifs_file_set_size(const unsigned int xid, struct dentry *dentry,
 	struct inode *inode = d_inode(dentry);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct cifsInodeInfo *cifsInode = CIFS_I(inode);
+	loff_t old_size = i_size_read(inode);
 	struct tcon_link *tlink = NULL;
 	struct cifs_tcon *tcon = NULL;
 	struct TCP_Server_Info *server;
@@ -3159,7 +3165,7 @@ int cifs_file_set_size(const unsigned int xid, struct dentry *dentry,
 
 set_size_out:
 	if (rc == 0)
-		cifs_resize_file_locked(inode, size);
+		cifs_resize_file_locked(inode, old_size, size);
 
 	return rc;
 }
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index aa142420dae2..1ada1c0a728d 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2287,6 +2287,7 @@ smb2_duplicate_extents(const unsigned int xid,
 	struct duplicate_extents_to_file dup_ext_buf;
 	struct timespec64 ts;
 	struct cifs_tcon *tcon = tlink_tcon(trgtfile->tlink);
+	loff_t old_size;
 	u64 asize;
 
 	/* server fileays advertise duplicate extent support with this flag */
@@ -2305,11 +2306,12 @@ smb2_duplicate_extents(const unsigned int xid,
 			       trgtfile->fid.volatile_fid, tcon->tid,
 			       tcon->ses->Suid, src_off, dest_off, len);
 	inode = d_inode(trgtfile->dentry);
-	if (i_size_read(inode) < dest_off + len) {
+	old_size = i_size_read(inode);
+	if (old_size < dest_off + len) {
 		rc = smb2_set_file_size(xid, tcon, trgtfile, dest_off + len, false);
 		if (rc)
 			goto duplicate_extents_out;
-		cifs_resize_file_locked(inode, dest_off + len);
+		cifs_resize_file_locked(inode, old_size, dest_off + len);
 	}
 	rc = SMB2_ioctl(xid, tcon, trgtfile->fid.persistent_fid,
 			trgtfile->fid.volatile_fid,
@@ -3883,7 +3885,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 			}
 
 			new_eof = off + len;
-			cifs_resize_file_locked(inode, new_eof);
+			cifs_resize_file_locked(inode, old_eof, new_eof);
 
 			qrc = SMB2_query_info(xid, tcon,
 					      cfile->fid.persistent_fid,
@@ -3931,7 +3933,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 		if (rc)
 			goto out;
 
-		cifs_resize_file_locked(inode, new_eof);
+		cifs_resize_file_locked(inode, old_eof, new_eof);
 
 		qrc = SMB2_query_info(xid, tcon,
 				      cfile->fid.persistent_fid,

