Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA2550EC15
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790786059; cv=none; b=GxYhUU8AkoguPCET7UtG/OtdtOGIIPpMoTS8bUvMXV0rEWuh1NMsMlBEr2sdcI3hjWpeJuaFXHmBYS+JtOlkfYP0f1Zrs32MylK5SgeQ15vUvEbxiRwJaov31axpSS9b8U5y3sbHLpt8ZjSnIld8DfRXVHgO9rma/SrozIuOrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790786059; c=relaxed/simple;
	bh=DHdndg8Qi6YGHwDNthJkbY11WTHHzupOrZV2sH93tkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B013oAOo76M5vPGRR6vgbZtjzP2w2B8mSapMi0rJHd8otAHwf1uN8QBjSN5KZn+r5jWdwq0EB0Egu0GC9YNyErMj1qULjt/19aSJpO8XaLx3UqfWU/COVnBOIzYIQVVXxE5ettxwc7U8I1ATCowRkXyCeOZtcJ5lDAuYD3tUATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dp3qoXxE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dp3qoXxE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494831F00893;
	Wed, 30 Sep 2026 16:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790786057;
	bh=1UYZNMXAes3Kmu2cfGNSYQAWa5acJhamwYKZE8/GQkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dp3qoXxEI2xzb1huvhAsjE/55gHUYOiI38FPARVjtvWwB6XacBicmo/yKJtJ92JFx
	 xm82YkRNm1hp6V08V48atjoX51Yi0FDjvOpx/6lMU39ZM25Bp/q0uc6xQ2Ev5uOAoL
	 kSBff+GdoXVf0LPCrN/wwHLAbHwyZR8j1e6w/YChoxoxyifo1BpqwpXpC1J9+frVCJ
	 raIX3bhxOItdYg1lmrwCi0jzQPqTcpbrpzpepQrPK/CTWFErV7wFv2yNcpSD7P//n1
	 f86lvC4Y/MzMRRxH9Omly+xlAzuV8JRtFo/09T9zz/aKgn4cyeqGLWVjgXTi3u6/HV
	 mH9Dhr5oJ49mg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] smb: client: use finish_no_open() for non-regular inodes
Date: Wed, 30 Sep 2026 12:34:15 -0400
Message-ID: <20260930163415.3202882-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092923-stuffed-sift-28b2@gregkh>
References: <2026092923-stuffed-sift-28b2@gregkh>
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
[ replaced S_ISREG(inode->i_mode) with d_is_reg(direntry) because the older cifs_do_create() already attaches the inode. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/dir.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index b5b64b061b715..d34230b8e1246 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -176,7 +176,8 @@ check_name(struct dentry *direntry, struct cifs_tcon *tcon)
 
 static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 			  struct tcon_link *tlink, unsigned int oflags, umode_t mode, __u32 *oplock,
-			  struct cifs_fid *fid, struct cifs_open_info_data *buf)
+			  struct cifs_fid *fid, struct cifs_open_info_data *buf,
+			  bool *opened)
 {
 	int rc = -ENOENT;
 	int create_options = CREATE_NOT_DIR;
@@ -191,6 +192,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 	struct cifs_open_parms oparms;
 	int rdwr_for_fscache = 0;
 
+	*opened = false;
 	*oplock = 0;
 	if (tcon->ses->server->oplocks)
 		*oplock = REQ_OPLOCK;
@@ -213,6 +215,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 				     oflags, oplock, &fid->netfid, xid);
 		switch (rc) {
 		case 0:
+			*opened = true;
 			if (newinode == NULL) {
 				/* query inode info */
 				goto cifs_create_get_file_info;
@@ -229,11 +232,9 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
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
@@ -333,6 +334,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 		}
 		goto out;
 	}
+	*opened = true;
 	if (rdwr_for_fscache == 2)
 		cifs_invalidate_cache(inode, FSCACHE_INVAL_DIO_WRITE);
 
@@ -423,7 +425,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 	return rc;
 
 out_err:
-	if (server->ops->close)
+	if (*opened && server->ops->close)
 		server->ops->close(xid, tcon, fid);
 	if (newinode)
 		iput(newinode);
@@ -442,6 +444,8 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	struct cifs_fid fid = {};
 	struct cifs_pending_open open;
 	__u32 oplock;
+	bool is_regular;
+	bool opened;
 	struct cifsFileInfo *file_info;
 	struct cifs_open_info_data buf = {};
 
@@ -501,15 +505,28 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	cifs_add_pending_open(&fid, tlink, &open);
 
 	rc = cifs_do_create(inode, direntry, xid, tlink, oflags, mode,
-			    &oplock, &fid, &buf);
+			    &oplock, &fid, &buf, &opened);
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
@@ -564,6 +581,7 @@ int cifs_create(struct user_namespace *mnt_userns, struct inode *inode,
 	struct TCP_Server_Info *server;
 	struct cifs_fid fid;
 	__u32 oplock;
+	bool opened;
 	struct cifs_open_info_data buf = {};
 
 	cifs_dbg(FYI, "cifs_create parent inode = 0x%p name is: %pd and dentry = 0x%p\n",
@@ -585,8 +603,9 @@ int cifs_create(struct user_namespace *mnt_userns, struct inode *inode,
 	if (server->ops->new_lease_key)
 		server->ops->new_lease_key(&fid);
 
-	rc = cifs_do_create(inode, direntry, xid, tlink, oflags, mode, &oplock, &fid, &buf);
-	if (!rc && server->ops->close)
+	rc = cifs_do_create(inode, direntry, xid, tlink, oflags, mode,
+			    &oplock, &fid, &buf, &opened);
+	if (!rc && opened && server->ops->close)
 		server->ops->close(xid, tcon, &fid);
 
 	cifs_free_open_info(&buf);
-- 
2.53.0

