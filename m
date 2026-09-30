Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62DC51DE14
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793720; cv=none; b=m2pU1TZXkIKke7Nx5tnQiwh6Qz+E2dn/TejYFCDggOUGDRiOE5gA9GyeCp2oXKoXiVNGh46x/lGR/y+frYt+cl8EDdQ6UcR8PWTGbi4BT1rNI27ykhfmnzaHQOJuj4/z2KRbSU3Z354thzmLhE4XB5bI0oVqmDMKMFldjekfDgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793720; c=relaxed/simple;
	bh=O9tPl1pETkGCj8enOi+8HdQsjgb7Wxysol71CHQ1zV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNiz+6yZb6pSCZMuRyZDHp05jLAomKQilTZzGHunurCtj71Fhy9/A55njxloDCiuB7XyY1mC8LzaanvJLnpquECzTBOGInXoYZDXW0HyhpMr+bPW5SOLgC2dz3xq9d5WPtmWJu8JanrSgLmc+4TIMnGx5mhi/u7QwiUmcjpZqOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeQCptq/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeQCptq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71491F00898;
	Wed, 30 Sep 2026 18:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790793718;
	bh=rbNB2AIQGlm56m3md6t1CL19NmHEq8G+SeEsmbCatOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XeQCptq/P1UPqAIPCy0z0OdQlHKKhHn9uMBw4+H6xqVlt0fYFuZ49UER6OoKB5ucx
	 +1SLyMfWq7eEcSCu4+64sGZ52Uyd08G8sztYBBoTmbCf4qWpFZ7u5Mnyy7dLgKyy+f
	 1zG/H9rDdoSxroqkGATaqmSg4aS+ufulPnfow1UBf/OkGTrw7NHt01fkSgSCjUSXLs
	 U8ccTc2Blph/EHvvY66/S7zD4im7m7tgJFlCWNvS57gTWVoqLclsfW/UAutKMz+Eqi
	 B/QAbNlFnfWw/iP203/sCXyfF4ZpypqlBo5xLc0doG/f9TG5w9FdLDrLZQVntB9iiD
	 0dt/ZhyukqbvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: use finish_no_open() for non-regular inodes
Date: Wed, 30 Sep 2026 14:41:55 -0400
Message-ID: <20260930184156.247870-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092924-unmolded-acts-04be@gregkh>
References: <2026092924-unmolded-acts-04be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit e66cf1625ec4a3fe68346119f371def713fd0a4d ]

An O_CREAT open can find an existing symlink or another non-regular
inode. cifs_atomic_open() calls finish_open() on it and attaches a
cifsFileInfo. Symlink inodes have no CIFS release operation, so the
dentry reference held by cifsFileInfo is leaked. FMODE_OPENED also
prevents the VFS from following the symlink.

Track whether cifs_do_create() returned an open server handle. For
non-regular inodes, close the handle if present, remove the pending
open, and call finish_no_open() so the VFS can continue the lookup.
Do not set FMODE_CREATED unless a regular file was opened. For
O_NOFOLLOW with __O_REGULAR, return -ELOOP before the VFS's
-EFTYPE check.

Defer closing a legacy POSIX handle on a non-regular inode until
after inode lookup. This avoids closing it again if lookup fails.

Fixes: d2c127197dfc ("cifs: implement i_op->atomic_open()")
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/dir.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 73d43d8911aa5..0366ac28ff07c 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -225,7 +225,7 @@ check_name(struct dentry *direntry, struct cifs_tcon *tcon)
 static int
 cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 	       struct tcon_link *tlink, unsigned oflags, umode_t mode,
-	       __u32 *oplock, struct cifs_fid *fid)
+	       __u32 *oplock, struct cifs_fid *fid, bool *opened)
 {
 	int rc = -ENOENT;
 	int create_options = CREATE_NOT_DIR;
@@ -239,6 +239,7 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct cifs_open_parms oparms;
 
+	*opened = false;
 	*oplock = 0;
 	if (tcon->ses->server->oplocks)
 		*oplock = REQ_OPLOCK;
@@ -254,6 +255,7 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 				     oflags, oplock, &fid->netfid, xid);
 		switch (rc) {
 		case 0:
+			*opened = true;
 			if (newinode == NULL) {
 				/* query inode info */
 				goto cifs_create_get_file_info;
@@ -270,11 +272,9 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 				/*
 				 * The server may allow us to open things like
 				 * FIFOs, but the client isn't set up to deal
-				 * with that. If it's not a regular file, just
-				 * close it and proceed as if it were a normal
-				 * lookup.
+				 * with that. Keep the handle until the caller
+				 * can finish the lookup.
 				 */
-				CIFSSMBClose(xid, tcon, fid->netfid);
 				goto cifs_create_get_file_info;
 			}
 			/* success, no need to query */
@@ -370,6 +370,7 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 		cifs_dbg(FYI, "cifs_create returned 0x%x\n", rc);
 		goto out;
 	}
+	*opened = true;
 
 	/*
 	 * If Open reported that we actually created a file then we now have to
@@ -452,7 +453,7 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 	return rc;
 
 out_err:
-	if (server->ops->close)
+	if (*opened && server->ops->close)
 		server->ops->close(xid, tcon, fid);
 	if (newinode)
 		iput(newinode);
@@ -472,6 +473,8 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	struct cifs_pending_open open;
 	__u32 oplock;
 	struct cifsFileInfo *file_info;
+	bool is_regular;
+	bool opened;
 
 	/*
 	 * Posix open is only called (at lookup time) for file create now. For
@@ -526,16 +529,29 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	cifs_add_pending_open(&fid, tlink, &open);
 
 	rc = cifs_do_create(inode, direntry, xid, tlink, oflags, mode,
-			    &oplock, &fid);
+			    &oplock, &fid, &opened);
 
 	if (rc) {
 		cifs_del_pending_open(&open);
 		goto out;
 	}
 
-	if ((oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
+	is_regular = d_is_reg(direntry);
+	if (!is_regular || !opened) {
+		if (opened && server->ops->close)
+			server->ops->close(xid, tcon, &fid);
+		cifs_del_pending_open(&open);
+	}
+
+	if (is_regular && opened &&
+	    (oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
 		file->f_mode |= FMODE_CREATED;
 
+	if (!is_regular || !opened) {
+		rc = finish_no_open(file, NULL);
+		goto out;
+	}
+
 	rc = finish_open(file, direntry, generic_file_open);
 	if (rc) {
 		if (server->ops->close)
@@ -585,6 +601,7 @@ int cifs_create(struct inode *inode, struct dentry *direntry, umode_t mode,
 	struct TCP_Server_Info *server;
 	struct cifs_fid fid;
 	__u32 oplock;
+	bool opened;
 
 	cifs_dbg(FYI, "cifs_create parent inode = 0x%p name is: %pd and dentry = 0x%p\n",
 		 inode, direntry, direntry);
@@ -601,8 +618,8 @@ int cifs_create(struct inode *inode, struct dentry *direntry, umode_t mode,
 		server->ops->new_lease_key(&fid);
 
 	rc = cifs_do_create(inode, direntry, xid, tlink, oflags, mode,
-			    &oplock, &fid);
-	if (!rc && server->ops->close)
+			    &oplock, &fid, &opened);
+	if (!rc && opened && server->ops->close)
 		server->ops->close(xid, tcon, &fid);
 
 	cifs_put_tlink(tlink);
-- 
2.53.0

