Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3056351814E
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682693; cv=none; b=ll+TGrc22foNPI/so5IHzVQXISSI249EYWJ6D85OzQC011MrrxSAJz84UsOjmog/vwfX+pTxIv5d0n0nizxcY9yuASNyOp3I6No8JD6/CdsiMa06o6p4W6tzYELt/KeLHSHndDME1Kc91y9zOi1GhfQX6ZYEIjgbtnbrMgf4tck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682693; c=relaxed/simple;
	bh=St19Fu9wjRVUvKoHmNI4m54f/dJJpYKAN+JP0VyXeM0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eKSwdkf4tVAsO8RRber+zBR2tb7YMjJgDfidme55I0xtsnPkZJ7tcYBeoQA4vve+0HJZTpjco2hhT0zyjVYyDglipClYZCO8UjeQ94zmo3Ue1v2lfSpPtT0a5D+CFFsaeH6KVpm0k9ZBahmjHW8g4uRf3/uV6qJyCzTNt7LYmv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gLCOH2Dh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gLCOH2Dh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFE01F000FF;
	Tue, 29 Sep 2026 11:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682691;
	bh=XOI0Hk6IGWXsdGDXy+GI7wsu3c1S9e37JdD6vgLdUVM=;
	h=Subject:To:Cc:From:Date;
	b=gLCOH2Dh/6cVF5CY4p6LQbM3vIsUutFf4qcxO5cTCsPioXYkP4YzokIVXgMHDrygS
	 27BuoU4huoQDNPsXZtEtUJlMQUhzypyq8bL7tHmozKOdJSNrdmySVFtiRR8aa7Bfvr
	 i5o5KzECyKfKzMyUJHtN7KbWyOI+ly+2rkkNacfQ=
Subject: FAILED: patch "[PATCH] smb: client: use finish_no_open() for non-regular inodes" failed to apply to 6.12-stable tree
To: linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:51:22 +0200
Message-ID: <2026092922-daisy-goofy-8f2c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e66cf1625ec4a3fe68346119f371def713fd0a4d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092922-daisy-goofy-8f2c@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e66cf1625ec4a3fe68346119f371def713fd0a4d Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 23 Sep 2026 20:25:49 +0900
Subject: [PATCH] smb: client: use finish_no_open() for non-regular inodes

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

diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index 6fa6d48fdfd3..1a56fa4d0e89 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -199,7 +199,7 @@ static int __cifs_do_create(struct inode *dir, struct dentry *direntry,
 			    struct tcon_link *tlink, unsigned int oflags,
 			    umode_t mode, __u32 *oplock, struct cifs_fid *fid,
 			    struct cifs_open_info_data *buf,
-			    struct inode **inode)
+			    struct inode **inode, bool *opened)
 {
 	int rc = -ENOENT;
 	int create_options = CREATE_NOT_DIR;
@@ -216,6 +216,7 @@ static int __cifs_do_create(struct inode *dir, struct dentry *direntry,
 	__le32 lease_flags = 0;
 
 	*inode = NULL;
+	*opened = false;
 	*oplock = 0;
 	if (tcon->ses->server->oplocks)
 		*oplock = REQ_OPLOCK;
@@ -232,6 +233,7 @@ static int __cifs_do_create(struct inode *dir, struct dentry *direntry,
 				     oflags, oplock, &fid->netfid, xid);
 		switch (rc) {
 		case 0:
+			*opened = true;
 			if (newinode == NULL) {
 				/* query inode info */
 				goto cifs_create_get_file_info;
@@ -253,11 +255,9 @@ static int __cifs_do_create(struct inode *dir, struct dentry *direntry,
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
@@ -384,6 +384,7 @@ retry_open:
 		}
 		return rc;
 	}
+	*opened = true;
 	if (rdwr_for_fscache == 2)
 		cifs_invalidate_cache(dir, FSCACHE_INVAL_DIO_WRITE);
 
@@ -475,7 +476,7 @@ cifs_create_set_dentry:
 	return rc;
 
 out_err:
-	if (server->ops->close)
+	if (*opened && server->ops->close)
 		server->ops->close(xid, tcon, fid);
 	if (newinode)
 		iput(newinode);
@@ -487,7 +488,7 @@ static int cifs_do_create(struct inode *dir, struct dentry *direntry,
 			  unsigned int oflags, umode_t mode,
 			  __u32 *oplock, struct cifs_fid *fid,
 			  struct cifs_open_info_data *buf,
-			  struct inode **inode)
+			  struct inode **inode, bool *opened)
 {
 	void *page = alloc_dentry_path();
 	const char *full_path;
@@ -496,10 +497,11 @@ static int cifs_do_create(struct inode *dir, struct dentry *direntry,
 	full_path = build_path_from_dentry(direntry, page);
 	if (IS_ERR(full_path)) {
 		rc = PTR_ERR(full_path);
+		*opened = false;
 	} else {
 		rc = __cifs_do_create(dir, direntry, full_path, xid,
 				      tlink, oflags, mode, oplock,
-				      fid, buf, inode);
+				      fid, buf, inode, opened);
 	}
 	free_dentry_path(page);
 	return rc;
@@ -529,6 +531,8 @@ int cifs_atomic_open(struct inode *dir, struct dentry *direntry,
 	struct inode *inode;
 	unsigned int xid;
 	__u32 oplock;
+	bool is_regular;
+	bool opened;
 	int rc;
 
 	if (unlikely(cifs_forced_shutdown(cifs_sb)))
@@ -581,12 +585,26 @@ int cifs_atomic_open(struct inode *dir, struct dentry *direntry,
 	cifs_add_pending_open(&fid, tlink, &open);
 
 	rc = cifs_do_create(dir, direntry, xid, tlink, oflags, mode,
-			    &oplock, &fid, &buf, &inode);
+			    &oplock, &fid, &buf, &inode, &opened);
 	if (rc) {
 		cifs_del_pending_open(&open);
 		goto out;
 	}
 
+	is_regular = S_ISREG(inode->i_mode);
+	if (!is_regular || !opened) {
+		if (opened && server->ops->close)
+			server->ops->close(xid, tcon, &fid);
+		cifs_del_pending_open(&open);
+		if (S_ISLNK(inode->i_mode) &&
+		    (oflags & (O_NOFOLLOW | __O_REGULAR)) ==
+		    (O_NOFOLLOW | __O_REGULAR) && !(oflags & O_EXCL)) {
+			iput(inode);
+			rc = -ELOOP;
+			goto out;
+		}
+	}
+
 	if (d_in_lookup(direntry)) {
 		alias = d_splice_alias(inode, direntry);
 		if (!IS_ERR_OR_NULL(alias))
@@ -595,9 +613,15 @@ int cifs_atomic_open(struct inode *dir, struct dentry *direntry,
 		d_instantiate(direntry, inode);
 	}
 
-	if ((oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
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
@@ -660,6 +684,7 @@ int cifs_create(struct mnt_idmap *idmap, struct inode *dir,
 	struct inode *inode;
 	struct cifs_fid fid;
 	__u32 oplock;
+	bool opened;
 	struct cifs_open_info_data buf = {};
 
 	cifs_dbg(FYI, "cifs_create parent inode = 0x%p name is: %pd and dentry = 0x%p\n",
@@ -682,10 +707,10 @@ int cifs_create(struct mnt_idmap *idmap, struct inode *dir,
 		server->ops->new_lease_key(&fid);
 
 	rc = cifs_do_create(dir, direntry, xid, tlink, oflags,
-			    mode, &oplock, &fid, &buf, &inode);
+			    mode, &oplock, &fid, &buf, &inode, &opened);
 	if (!rc) {
 		d_instantiate(direntry, inode);
-		if (server->ops->close)
+		if (opened && server->ops->close)
 			server->ops->close(xid, tcon, &fid);
 	}
 
@@ -1078,6 +1103,7 @@ int cifs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	struct inode *inode;
 	unsigned int xid;
 	__u32 oplock;
+	bool opened;
 	int namelen;
 	int rc;
 
@@ -1116,7 +1142,7 @@ int cifs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 		namelen = scnprintf(name, namesize, CIFS_TMPNAME_PREFIX "%x",
 				    atomic_inc_return(&cifs_tmpcounter));
 		rc = __cifs_do_create(dir, dentry, path, xid, tlink, oflags,
-				      mode, &oplock, &fid, NULL, &inode);
+				      mode, &oplock, &fid, NULL, &inode, &opened);
 		if (!rc) {
 			rc = d_mark_tmpfile_name(file, &QSTR_LEN(name, namelen));
 			if (rc) {

