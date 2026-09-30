Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ABF4CA784
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789663; cv=none; b=eWIHdcqFp6wlahd1coqOPnu3P9PhveUNHiglfSAqmyc3EgZbPi4jxbpVKT2UbUvhQ/S3zyf49YKtbFzz+dl0foqB6Bn68m5rszYycIn7UQeVbaRj29ts1gVFyRXBtcXm0sBx97QkO8xy5x74UYsiAEE1GEDrq/3xxs24LLq6VkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789663; c=relaxed/simple;
	bh=Bu3i6ZqBbjB5DKyN1GHtZ/nb1CKceYpFflcD17QZmfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bze2uzr4ZZCAUD00YAYU3E9JgZCmQnidnjq3Zo1iJStMjukj5EGZdUvmj0Ja6kvMpNcjcP+W1GhBKJEWD0sPMHNYNjaxS42/QxzstSaT5KFzP4Muyf38B52EAcZSs3xZR+I/A1vgatAwxfZe25hvYGAk8np2bb0Alxv/z/Sk//8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdJwrgKs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdJwrgKs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39421F000FF;
	Wed, 30 Sep 2026 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790789662;
	bh=vxFN3IaHAzrLxS00LxJRjZORecQsunJMHci4oLq/tzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YdJwrgKsf+POjibH9T49rzVq/CtCCfxwBND/7A6Y0/jHdF9r7Tu3Xa+qoF2YCx6US
	 /qFO9pdqBpmmvcCsx8n/+h6o5WuHmqyVUWo7mnp5WNWpReQOUz9GxDwJLfT6Yui16W
	 VBwC/vef3acea7Pa7/kYkBzD0DhKDF8sY5Sp2BIy42oq9Dy8hy2kqS481QkGC9FRXp
	 uhavA1qJirvwj+z0h5hrwZLJaychAf25dy9c3t49CuWNblp9X5X8OmKqIIU0Mvf77j
	 +ZeFtElNFxxMsoykw4BRpk3nDkTDTUq3sTSLz2gcq1/p7961gZUVzPH6F3DbjxdQUQ
	 I3BgC+zAeytnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: use finish_no_open() for non-regular inodes
Date: Wed, 30 Sep 2026 13:34:20 -0400
Message-ID: <20260930173420.3644421-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092923-marina-tried-e350@gregkh>
References: <2026092923-marina-tried-e350@gregkh>
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
[ used d_is_reg(direntry) because the older cifs_do_create() already attaches the inode. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/dir.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 83c929dd6ed59..5b7d419a81862 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -167,7 +167,7 @@ check_name(struct dentry *direntry, struct cifs_tcon *tcon)
 static int
 cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 	       struct tcon_link *tlink, unsigned oflags, umode_t mode,
-	       __u32 *oplock, struct cifs_fid *fid)
+	       __u32 *oplock, struct cifs_fid *fid, bool *opened)
 {
 	int rc = -ENOENT;
 	int create_options = CREATE_NOT_DIR;
@@ -182,6 +182,7 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct cifs_open_parms oparms;
 
+	*opened = false;
 	*oplock = 0;
 	if (tcon->ses->server->oplocks)
 		*oplock = REQ_OPLOCK;
@@ -199,6 +200,7 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 				     oflags, oplock, &fid->netfid, xid);
 		switch (rc) {
 		case 0:
+			*opened = true;
 			if (newinode == NULL) {
 				/* query inode info */
 				goto cifs_create_get_file_info;
@@ -215,11 +217,9 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
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
@@ -314,6 +314,7 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 		cifs_dbg(FYI, "cifs_create returned 0x%x\n", rc);
 		goto out;
 	}
+	*opened = true;
 
 	/*
 	 * If Open reported that we actually created a file then we now have to
@@ -398,7 +399,7 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 	return rc;
 
 out_err:
-	if (server->ops->close)
+	if (*opened && server->ops->close)
 		server->ops->close(xid, tcon, fid);
 	if (newinode)
 		iput(newinode);
@@ -418,6 +419,8 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	struct cifs_pending_open open;
 	__u32 oplock;
 	struct cifsFileInfo *file_info;
+	bool is_regular;
+	bool opened;
 
 	if (unlikely(cifs_forced_shutdown(CIFS_SB(inode->i_sb))))
 		return -EIO;
@@ -475,16 +478,29 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
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
@@ -534,6 +550,7 @@ int cifs_create(struct user_namespace *mnt_userns, struct inode *inode,
 	struct TCP_Server_Info *server;
 	struct cifs_fid fid;
 	__u32 oplock;
+	bool opened;
 
 	cifs_dbg(FYI, "cifs_create parent inode = 0x%p name is: %pd and dentry = 0x%p\n",
 		 inode, direntry, direntry);
@@ -555,8 +572,8 @@ int cifs_create(struct user_namespace *mnt_userns, struct inode *inode,
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

