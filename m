Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D21F4B1277
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443288; cv=none; b=aa4N3j7sOAiR2eF3YsAZwGvedFcVPiDMqjcli88j3ib/6IFHi5V5s7OT7l8BvlSE9vWFzqXdV4AWFK/gLXpFKeclJ4jwry36nX3r0andsDhUQFObYH1/QPISQ5F+Wr5eMWjSRdirJDIHtbEvXIgOIavwydwviut0k/RkQ/4r17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443288; c=relaxed/simple;
	bh=uxFOPKT3DMHkgvyf8gSVFPVMU7vPEzJjvke87klGQlY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Q2bDFD7sjSvX4ZlEz98gYWSjyhARh1dsFy8GrEXndN7fOm1BMMzN8raf/1JR11nAKYT+5kdtrIZQ7Prcwr4ZKTSXMSKJS5F7fq9NBjtm9yNn6zJLW6M3X2LKPKmLAgy8WBeZ94ohSXLX1lkyyDvTC5eUz1RC4To38bt5MJbmVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cleTy0rL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cleTy0rL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCF61F000E9;
	Thu,  3 Sep 2026 13:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443279;
	bh=WDAyto5ZKH5GbNOanDN1SPpEIzlu7Jsftdkb6ZQdUPk=;
	h=Subject:To:Cc:From:Date;
	b=cleTy0rLpWomM2aBb0vw7J9e6rjp3rJuFo/dqmjPZv9Hnvvmx4I5T9812NYHHG8JS
	 xgOrrHFZJQTMFtuCnC6feAKQFYwqoIeELxA1iV9kruKvJ6r1c5SzUyB/6InUqxjdk3
	 BRI+7A1GLJ3/OLQcqfbm8/wfb3h2ynlT3y3btKAg=
Subject: FAILED: patch "[PATCH] cifs: add cifs_resize_file_locked() to guard" failed to apply to 6.18-stable tree
To: sorenson@redhat.com,dhowells@redhat.com,linkinjeon@kernel.org,pc@manguebit.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:24:58 +0200
Message-ID: <2026090358-afar-boss-f2c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 32a7af68df7361fe7cf153cf36124d04b94aec00
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090358-afar-boss-f2c3@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 32a7af68df7361fe7cf153cf36124d04b94aec00 Mon Sep 17 00:00:00 2001
From: Frank Sorenson <sorenson@redhat.com>
Date: Fri, 31 Jul 2026 12:12:29 -0500
Subject: [PATCH] cifs: add cifs_resize_file_locked() to guard
 fscache_resize_cookie() under i_rwsem

cifs_setsize() calls fscache_resize_cookie() without holding i_rwsem.
When the fscache cookie is active (FSCACHE_COOKIE_IS_CACHING is set),
fscache_resize_cookie() performs a real resize that requires i_rwsem
held exclusively.  If another file descriptor has the same inode open,
fscache_use_cookie() was already called from that cifs_open(), making
the cookie active.  In that case, calling cifs_setsize() from
cifs_do_truncate() (invoked from cifs_open() without i_rwsem) races
against concurrent fscache I/O.

Strip fscache_resize_cookie() from cifs_setsize(), making it a pure
size/page-cache helper.  Add cifs_resize_file_locked() for callers
that already hold i_rwsem: it calls netfs_resize_file() and
cifs_setsize(), then temporarily activates the cookie with
fscache_use_cookie() to perform the resize under the lock, then
deactivates it with cifs_fscache_unuse_inode_cookie().  Using
fscache_use_cookie() before the resize ensures correctness whether or
not another fd already holds the cookie active.

Switch cifs_file_set_size(), smb2_duplicate_extents(), and both size-
extension branches of smb3_simple_falloc() to the new wrapper; those
paths already hold i_rwsem via VFS setattr, lock_two_nondirectories(),
or cifs_fallocate() respectively.  cifs_do_truncate() continues to
call cifs_setsize() followed by cifs_invalidate_cache(), since it runs
without i_rwsem.

Fixes: fa724e235cfd ("cifs: add fscache_resize_cookie() to cifs_setsize()")
Cc: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index 854e672a4e37..651670c19c2b 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -147,6 +147,7 @@ ssize_t cifs_file_copychunk_range(unsigned int xid, struct file *src_file,
 
 long cifs_ioctl(struct file *filep, unsigned int command, unsigned long arg);
 void cifs_setsize(struct inode *inode, loff_t offset);
+void cifs_resize_file_locked(struct inode *inode, loff_t offset);
 
 struct fs_context;
 struct smb3_fs_context;
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 5f58fb46363d..098d5496e779 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -3059,7 +3059,23 @@ void cifs_setsize(struct inode *inode, loff_t offset)
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	truncate_pagecache(inode, offset);
 	netfs_wait_for_outstanding_io(inode);
-	fscache_resize_cookie(cifs_inode_cookie(inode), offset);
+}
+
+void cifs_resize_file_locked(struct inode *inode, loff_t offset)
+{
+	struct fscache_cookie *cookie = cifs_inode_cookie(inode);
+
+	lockdep_assert_held_write(&inode->i_rwsem);
+
+	netfs_resize_file(netfs_inode(inode), offset, true);
+	cifs_setsize(inode, offset);
+
+	if (!cookie)
+		return;
+
+	fscache_use_cookie(cookie, true);
+	fscache_resize_cookie(cookie, offset);
+	cifs_fscache_unuse_inode_cookie(inode, true);
 }
 
 int cifs_file_set_size(const unsigned int xid, struct dentry *dentry,
@@ -3125,10 +3141,8 @@ int cifs_file_set_size(const unsigned int xid, struct dentry *dentry,
 	cifs_put_tlink(tlink);
 
 set_size_out:
-	if (rc == 0) {
-		netfs_resize_file(&cifsInode->netfs, size, true);
-		cifs_setsize(inode, size);
-	}
+	if (rc == 0)
+		cifs_resize_file_locked(inode, size);
 
 	return rc;
 }
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 192649fec25d..0e872d58fae7 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2222,8 +2222,7 @@ smb2_duplicate_extents(const unsigned int xid,
 		rc = smb2_set_file_size(xid, tcon, trgtfile, dest_off + len, false);
 		if (rc)
 			goto duplicate_extents_out;
-		netfs_resize_file(netfs_inode(inode), dest_off + len, true);
-		cifs_setsize(inode, dest_off + len);
+		cifs_resize_file_locked(inode, dest_off + len);
 	}
 	rc = SMB2_ioctl(xid, tcon, trgtfile->fid.persistent_fid,
 			trgtfile->fid.volatile_fid,
@@ -3776,8 +3775,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 			}
 
 			new_eof = off + len;
-			netfs_resize_file(&cifsi->netfs, new_eof, true);
-			cifs_setsize(inode, new_eof);
+			cifs_resize_file_locked(inode, new_eof);
 
 			qrc = SMB2_query_info(xid, tcon,
 					      cfile->fid.persistent_fid,
@@ -3825,8 +3823,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 		if (rc)
 			goto out;
 
-		netfs_resize_file(&cifsi->netfs, new_eof, true);
-		cifs_setsize(inode, new_eof);
+		cifs_resize_file_locked(inode, new_eof);
 
 		qrc = SMB2_query_info(xid, tcon,
 				      cfile->fid.persistent_fid,

