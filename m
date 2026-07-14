Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8A947D94D
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039948; cv=none; b=S2ha5a9zLng5etb6F+QBl/kOuuRv1+9yUUQFr7JkC/oelN2trf+WY6X8QCvvN12JXCQpEDlyFXBXIoH2VqQQ7TabP6jBNLIhHGwksu1URe46agdTLa/VPjHFsY6/vRgQI3CeDtmvZr0T+8IB99F08NukTbQwPKVUsVZnz2DdwB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039948; c=relaxed/simple;
	bh=4WhoCNU5Nv0LyrishSIvqDqYM/iHnT2hedkg4LCWug4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VNYXwUY7x/qY+lcNxDw7X9MeyULwqORMOXYJmk0w24Lb2BlqGkUBlR2US/M1eqBqy++UOAmVGEj+ROohEp3YM0qeFw4Y9iNgTkr4uzxIXaB/SzWVMDczq61RPkyGR+tPxD78Pe0Gb7UWrl98Lmevftml5oFIoz4v1rya+TSIV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JfFjlik0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JfFjlik0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017391F000E9;
	Tue, 14 Jul 2026 14:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784039947;
	bh=e+LwOOducQ+p/hBc8q0N/zNeK4iQIDnoXjtNkF4q/Kc=;
	h=Subject:To:Cc:From:Date;
	b=JfFjlik0gU5yrRBr5FacoxXZbBzUhohNnzJ9cqOmMtiG6Ml6JssMs4qCfchfwbIub
	 M3tf4yWsAleQ3uRmvPp+G8mHxLrIMMS3OJ1IY1VP8n/a6M+8GN0aZi87tDEy9IQEQH
	 2nRAdGFyQw7uj/+daoxaE48v7NI3wq/f9DeS2akQ=
Subject: FAILED: patch "[PATCH] ksmbd: fix path resolution in ksmbd_vfs_kern_path_create" failed to apply to 5.15-stable tree
To: d.ornaghi97@gmail.com,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:38:51 +0200
Message-ID: <2026071451-filling-affidavit-5bad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1c8951963d8ed357f70f59e0ad4ddce2199d2016
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071451-filling-affidavit-5bad@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

