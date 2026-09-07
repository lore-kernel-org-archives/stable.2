Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0D4286A4
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 01:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788743000; cv=none; b=FsGk898A6Da/8lxEF3PouQP1qvo0xvA9mRZF2zP2u9J1LGqktjxB+Dw2gVHCWOwkWM43hVt4OGh8K42MfGpnF5fNjKRrGeshSCd9/iIKTjf1vdr+XJ+HCJLiInjDFPYyOkV8+rbE70R4ZwVOzdqgIMipgfdEYfU4iGP979rcRtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788743000; c=relaxed/simple;
	bh=8IiXlecqzLgIpduvEgkTGTMjkFnkdLeZvMiL1zfAnIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lf1bCsVIz78kzk2yVypqe4OjXuBonJwH5zxcJ3hMynLUpoBCAckWhbu/FyJzgVtonToylOmwGa4ronPiXkI0z5DB8WL2XojuC6RL6BL02si7tkmZUHUtwIFWYDN2koTNd/HWLnXNhpVgnp+KCvHphLVuyESopGPAJG4eS+k4+CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yfpyrb5s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yfpyrb5s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5470E1F00A3D;
	Mon,  7 Sep 2026 01:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788742997;
	bh=K+hcI9/TTkk0Q6hcPmH8oLLv+LJwCoJQDVYhTObrF44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yfpyrb5stbxpeOdeaZt23LO0mqv27bx7P8c07GUZ1XpJPnkH+oBkiEaCk7Ci7r4z8
	 3Tricm1s2OIMD1ZKhAbT9eQdvlASWM+gAwg3GIbx1WIpRzEwqf0W9sBvmsR85ZFmsg
	 IedmnzH6Jl9jwwGNBN3Uybp47ltFxUmVJnCZS5lxpbhot32Wcyl5M0qy5ES2+KX7oB
	 6IQhDG++s6pZzLk6jW2y99ko1yuUC+Q5lzFS9598Tsl7veXNYYfBdIuxZUGunhQ2A+
	 6DrGsohYenIGKmtdlxcsOxqdjk9NLZJsF7TXQ4onmHMEu1i5NI6G9wzZszBa1FfxmP
	 NH3UwwURbU1xA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] cifs: add cifs_resize_file_locked() to guard fscache_resize_cookie() under i_rwsem
Date: Sun,  6 Sep 2026 21:03:13 -0400
Message-ID: <20260907010313.1949936-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907010313.1949936-1-sashal@kernel.org>
References: <2026090359-ahoy-outage-a083@gregkh>
 <20260907010313.1949936-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit 32a7af68df7361fe7cf153cf36124d04b94aec00 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsfs.h  |  1 +
 fs/smb/client/inode.c   | 24 +++++++++++++++++++-----
 fs/smb/client/smb2ops.c |  9 +++------
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index 0935d2168fa65..9f90f2cab55a4 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -136,6 +136,7 @@ extern ssize_t cifs_file_copychunk_range(unsigned int xid,
 
 long cifs_ioctl(struct file *filep, unsigned int command, unsigned long arg);
 void cifs_setsize(struct inode *inode, loff_t offset);
+void cifs_resize_file_locked(struct inode *inode, loff_t offset);
 
 struct smb3_fs_context;
 extern struct dentry *cifs_smb3_do_mount(struct file_system_type *fs_type,
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index a37abb0311253..96e0534c244bf 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2965,7 +2965,23 @@ void cifs_setsize(struct inode *inode, loff_t offset)
 	cifs_i->time = 0;
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
 
 static int
@@ -3031,10 +3047,8 @@ cifs_set_file_size(struct inode *inode, struct iattr *attrs,
 		cifs_put_tlink(tlink);
 
 set_size_out:
-	if (rc == 0) {
-		netfs_resize_file(&cifsInode->netfs, size, true);
-		cifs_setsize(inode, size);
-	}
+	if (rc == 0)
+		cifs_resize_file_locked(inode, size);
 
 	if (rc == 0) {
 		/*
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index f933dfb74fd9e..cec9e7444e015 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2114,8 +2114,7 @@ smb2_duplicate_extents(const unsigned int xid,
 		rc = smb2_set_file_size(xid, tcon, trgtfile, dest_off + len, false);
 		if (rc)
 			goto duplicate_extents_out;
-		netfs_resize_file(netfs_inode(inode), dest_off + len, true);
-		cifs_setsize(inode, dest_off + len);
+		cifs_resize_file_locked(inode, dest_off + len);
 	}
 	rc = SMB2_ioctl(xid, tcon, trgtfile->fid.persistent_fid,
 			trgtfile->fid.volatile_fid,
@@ -3624,8 +3623,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 			}
 
 			new_eof = off + len;
-			netfs_resize_file(&cifsi->netfs, new_eof, true);
-			cifs_setsize(inode, new_eof);
+			cifs_resize_file_locked(inode, new_eof);
 
 			qrc = SMB2_query_info(xid, tcon,
 					      cfile->fid.persistent_fid,
@@ -3650,8 +3648,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 		if (rc)
 			goto out;
 
-		netfs_resize_file(&cifsi->netfs, new_eof, true);
-		cifs_setsize(inode, new_eof);
+		cifs_resize_file_locked(inode, new_eof);
 
 		qrc = SMB2_query_info(xid, tcon,
 				      cfile->fid.persistent_fid,
-- 
2.53.0

