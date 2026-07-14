Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A711547D947
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039951; cv=none; b=crx5gEar5As2a5QkwLqD03Sybg3kKab0csKjMnL72pedn1ztDKGcJ2QOePYnpXF453A9ij4eeTwDFfla04KRu6QmavSiEthsbtiqbOjEk4oRkr6zO69B80VtqzTMdlF4cfxvPtE9eVFceIFpw0/fnKnFMPsl9D6Hsp+qJSepV6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039951; c=relaxed/simple;
	bh=hLNae8O0sCgiO489SIudTub1bWRON70PClM1Lmw1PGs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=r6TudRjcbIl4cSwJAYxQCR4G0lkhAI5iLVPW2VZKlKCNf2jpEuiaJLRPhQAVCw5TyPZq1HQ6acmoP+Q/4Qt18AHHpsE0aL7SJBmdkTzAHN3kqOlwfRFon2cbRVkAmfdBmXpQR9GJc96ZnpoqiLb99schAYZJXWknGtcPAJ2o/MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KjMLJ41A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KjMLJ41A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1AD1F000E9;
	Tue, 14 Jul 2026 14:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784039950;
	bh=7oWQDCkbq3tc/La2wOqnSRUiv66AQ29DniLnjfOoQd4=;
	h=Subject:To:Cc:From:Date;
	b=KjMLJ41A943KASx7pWKY8cBbgnpqeXIrBEjwrL3gDBTcyhR4Mi+pSI+QlyrD/p9DN
	 tlSFb5xlKCl5UsOrAOt52mmqTycvDdqLDXJvK5HlwqfHhoXzanzsQ1wc4sOApPKaqA
	 TPdAcRbxNlO5uFEuR2SatrwTPamnGePjsqo8Cj90=
Subject: FAILED: patch "[PATCH] ksmbd: fix path resolution in ksmbd_vfs_kern_path_create" failed to apply to 6.1-stable tree
To: d.ornaghi97@gmail.com,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:38:51 +0200
Message-ID: <2026071451-doubling-cozily-11ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1c8951963d8ed357f70f59e0ad4ddce2199d2016
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071451-doubling-cozily-11ad@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c8951963d8ed357f70f59e0ad4ddce2199d2016 Mon Sep 17 00:00:00 2001
From: Davide Ornaghi <d.ornaghi97@gmail.com>
Date: Mon, 15 Jun 2026 20:35:01 +0900
Subject: [PATCH] ksmbd: fix path resolution in ksmbd_vfs_kern_path_create

The SMB2 open lookup is rooted at the share with LOOKUP_BENEATH, but the
create/mkdir/hardlink sink is not: ksmbd_vfs_kern_path_create() builds an
absolute path with convert_to_unix_name() and resolves it from AT_FDCWD
via start_creating_path(), so a ".." component is walked from the real
filesystem root and escapes the export.

An authenticated client races a missing path component so the rooted open
lookup returns -ENOENT (taking the create branch) while the same component
is present (a directory) when the create walk runs; the create then
resolves ".." out of the share.

Root the create walk at the share like the lookup and rename paths already
are: resolve the parent with vfs_path_parent_lookup(..., LOOKUP_BENEATH,
&share_conf->vfs_path) and create the final component with
start_creating_noperm(). convert_to_unix_name() then has no callers and is
removed.

Fixes: 265fd1991c1d ("ksmbd: use LOOKUP_BENEATH to prevent the out of share access")
Cc: stable@vger.kernel.org
Signed-off-by: Davide Ornaghi <d.ornaghi97@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/misc.c b/fs/smb/server/misc.c
index a543ec9d3581..966004c414a8 100644
--- a/fs/smb/server/misc.c
+++ b/fs/smb/server/misc.c
@@ -283,39 +283,6 @@ char *ksmbd_extract_sharename(struct unicode_map *um, const char *treename)
 	return ksmbd_casefold_sharename(um, name);
 }
 
-/**
- * convert_to_unix_name() - convert windows name to unix format
- * @share:	ksmbd_share_config pointer
- * @name:	file name that is relative to share
- *
- * Return:	converted name on success, otherwise NULL
- */
-char *convert_to_unix_name(struct ksmbd_share_config *share, const char *name)
-{
-	int no_slash = 0, name_len, path_len;
-	char *new_name;
-
-	if (name[0] == '/')
-		name++;
-
-	path_len = share->path_sz;
-	name_len = strlen(name);
-	new_name = kmalloc(path_len + name_len + 2, KSMBD_DEFAULT_GFP);
-	if (!new_name)
-		return new_name;
-
-	memcpy(new_name, share->path, path_len);
-	if (new_name[path_len - 1] != '/') {
-		new_name[path_len] = '/';
-		no_slash = 1;
-	}
-
-	memcpy(new_name + path_len + no_slash, name, name_len);
-	path_len += name_len + no_slash;
-	new_name[path_len] = 0x00;
-	return new_name;
-}
-
 char *ksmbd_convert_dir_info_name(struct ksmbd_dir_info *d_info,
 				  const struct nls_table *local_nls,
 				  int *conv_len)
diff --git a/fs/smb/server/misc.h b/fs/smb/server/misc.h
index 13423696ae8c..3909104e18ad 100644
--- a/fs/smb/server/misc.h
+++ b/fs/smb/server/misc.h
@@ -25,7 +25,6 @@ void ksmbd_strip_last_slash(char *path);
 void ksmbd_conv_path_to_windows(char *path);
 char *ksmbd_casefold_sharename(struct unicode_map *um, const char *name);
 char *ksmbd_extract_sharename(struct unicode_map *um, const char *treename);
-char *convert_to_unix_name(struct ksmbd_share_config *share, const char *name);
 
 #define KSMBD_DIR_INFO_ALIGNMENT	8
 struct ksmbd_dir_info;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index fe376453a519..74b0307cb100 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1259,15 +1259,30 @@ struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 					  unsigned int flags,
 					  struct path *path)
 {
-	char *abs_name;
+	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
+	struct qstr last;
 	struct dentry *dent;
+	int err;
 
-	abs_name = convert_to_unix_name(work->tcon->share_conf, name);
-	if (!abs_name)
-		return ERR_PTR(-ENOMEM);
+	/* resolve the name beneath the share root so ".." cannot escape */
+	CLASS(filename_kernel, filename)(name);
 
-	dent = start_creating_path(AT_FDCWD, abs_name, path, flags);
-	kfree(abs_name);
+	err = vfs_path_parent_lookup(filename, flags | LOOKUP_BENEATH,
+				     path, &last, &share_conf->vfs_path);
+	if (err)
+		return ERR_PTR(err);
+
+	err = mnt_want_write(path->mnt);
+	if (err) {
+		path_put(path);
+		return ERR_PTR(err);
+	}
+
+	dent = start_creating_noperm(path->dentry, &last);
+	if (IS_ERR(dent)) {
+		mnt_drop_write(path->mnt);
+		path_put(path);
+	}
 	return dent;
 }
 

