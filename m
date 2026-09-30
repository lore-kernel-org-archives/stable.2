Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BFA4F5E1A
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784200; cv=none; b=ayCUka6Nfyjt7kqD08jBxhHSHiylgoXnUDzhnaDf6yMppdKfVJm4WkHXPJ5i4CXIyw2yck81c/gPs+1UEkC36615RXAYKpIx9+GuE5pI05FR69yD5giT6guXsRdvmLYIyvigP0SgVQdhcR5H0WmtSaS1HXsVmXHuiUSkVyAWOPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784200; c=relaxed/simple;
	bh=o3VWXj4aM1dOVIw43d5IRgCqCB1N7PY73uc7FozG9oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsYKfVMShti5QDRFWR1JwmkrnRGE7ETnba+76sQIU0GzhDcm4gA3FUetPyUGBvg4KJPpfBYuLGjNH5I0oNn7o12fdolPp9UZVYJ+015PioKxHckEu5kVavX7UW3H+JXtpG0dQwrd4hgbfnWDfWb2/VrAbTJUFx5QgpZ7gV8a79Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HG9MZWPw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG9MZWPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A101F00893;
	Wed, 30 Sep 2026 16:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790784194;
	bh=/07Z/TAChUMpkmrRauRjTii0Cmw8n2s96aDpdw3cUM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HG9MZWPw/aJof12GR01o9mKiFfEkA9r6a6gB2Hia47aRxwlmLDrjnEm0F4NFctRNh
	 6mgN4uxQ6bbTIphTTSVeXgmfbVmRh6iHiCGgeGb86KV+wjhcsPFCjOeOEd/Dth+J56
	 CcRJhJ2hUXZOPcCFwUNIYiB8uKF8p25j+EyP94Rm7cAzAX7NfJGAsjv3+FtAwBnMlT
	 IEfKalGRU5VzDfdb7YC6hNeE32ZYJ1NgVxM+Xfq+Vr6RbkFBCHHxB6ra8Z0RyQ9v/x
	 HkcZvbZ6ZLmApl1p7LzLKfFhIRYdx7RQqY8ORfcgztjKw8Y0O8Ud3hapbPd5bIR2g8
	 tfjEtScn2bgoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] smb: client: use finish_no_open() for non-regular inodes
Date: Wed, 30 Sep 2026 12:03:12 -0400
Message-ID: <20260930160312.2981980-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092922-pacifier-unnoticed-68fb@gregkh>
References: <2026092922-pacifier-unnoticed-68fb@gregkh>
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
index 30368ddd0a1e6..8675edf73693d 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -177,7 +177,8 @@ check_name(struct dentry *direntry, struct cifs_tcon *tcon)
 
 static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 			  struct tcon_link *tlink, unsigned int oflags, umode_t mode, __u32 *oplock,
-			  struct cifs_fid *fid, struct cifs_open_info_data *buf)
+			  struct cifs_fid *fid, struct cifs_open_info_data *buf,
+			  bool *opened)
 {
 	int rc = -ENOENT;
 	int create_options = CREATE_NOT_DIR;
@@ -194,6 +195,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 	int rdwr_for_fscache = 0;
 	__le32 lease_flags = 0;
 
+	*opened = false;
 	*oplock = 0;
 	if (tcon->ses->server->oplocks)
 		*oplock = REQ_OPLOCK;
@@ -216,6 +218,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 				     oflags, oplock, &fid->netfid, xid);
 		switch (rc) {
 		case 0:
+			*opened = true;
 			if (newinode == NULL) {
 				/* query inode info */
 				goto cifs_create_get_file_info;
@@ -232,11 +235,9 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
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
@@ -359,6 +360,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 		}
 		goto out;
 	}
+	*opened = true;
 	if (rdwr_for_fscache == 2)
 		cifs_invalidate_cache(inode, FSCACHE_INVAL_DIO_WRITE);
 
@@ -449,7 +451,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 	return rc;
 
 out_err:
-	if (server->ops->close)
+	if (*opened && server->ops->close)
 		server->ops->close(xid, tcon, fid);
 	if (newinode)
 		iput(newinode);
@@ -468,6 +470,8 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	struct cifs_fid fid = {};
 	struct cifs_pending_open open;
 	__u32 oplock;
+	bool is_regular;
+	bool opened;
 	struct cifsFileInfo *file_info;
 	struct cifs_open_info_data buf = {};
 
@@ -521,15 +525,28 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
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
@@ -584,6 +601,7 @@ int cifs_create(struct mnt_idmap *idmap, struct inode *inode,
 	struct TCP_Server_Info *server;
 	struct cifs_fid fid;
 	__u32 oplock;
+	bool opened;
 	struct cifs_open_info_data buf = {};
 
 	cifs_dbg(FYI, "cifs_create parent inode = 0x%p name is: %pd and dentry = 0x%p\n",
@@ -605,8 +623,9 @@ int cifs_create(struct mnt_idmap *idmap, struct inode *inode,
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

