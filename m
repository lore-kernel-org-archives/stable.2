Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9661E492D
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 01:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784166324; cv=none; b=P3yT6DOzAvEDT5mayc3q/zRl6H8MgLbt4y7yta80qFbgRgpVJN7EphCEl4f5ZU5w4ThdeBuABn9iMAoq7sY1OP77Ojznsh9RdxLnqgtUUNvlvdubEfEaW+LgeVlJxCauVS8J+M0mr6p6J/Y6iBgICv1bILSZo8deRAZ2RW8DDEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784166324; c=relaxed/simple;
	bh=F5Rze1WYh1ieDFYcW8g62/yCXJ9WLL6AqM9brVgkmUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAJ5sqCslQZftKbJijKfcwSVzVx2xQ7uui9qUVcv1fYVEc+gOH/rb3sBG7R8JUNOofF1GNB2JO30fmQFrxuE1nb9J0OPFrUhoDE+MHbgU+GJ8eIiK1EETqTHNSTAUNvOrmoCi7HnPt05FA3HSa8Okjc8DPp51jOZSevnvgyGk1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdBuWge0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdBuWge0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5D81F000E9;
	Thu, 16 Jul 2026 01:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784166320;
	bh=6I/OHv/438TWhRHPPGmEf3Ubt3W2hDDaRvXVGajKWPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JdBuWge00fbKIygpnnlal+F4W81CN74cRjjU4rCv4MDKzvqp+C9IfilC4bJTJ4dvF
	 6meUVJcq0dOJGFnPliR31oUkxUsixa5T6WuX0tUIGZWt6M4LVWWG6rOZGjPDL1rJ/R
	 QtOOaZSUJpkUMLH5bPiFYLtHbXej2IZsivi1UcbaEGF6jBmq0y7crh7YXgHhQbVTQQ
	 A6XPozsa1HPd2JM3ScbpGXQiydr/D4tKa4KRgpBsGpWI4oq/j7pLxlxLQNOQf4W7IQ
	 RP4JjPhyWRcqFfjA551CpLYaJPiu2Cls7wHUyG+7kJSFHQ/Fp/V085eMNqOxnDECBb
	 J8U66L+dW8U+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Davide Ornaghi <d.ornaghi97@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y] ksmbd: fix path resolution in ksmbd_vfs_kern_path_create
Date: Wed, 15 Jul 2026 21:45:17 -0400
Message-ID: <20260716014517.777818-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071457-shrank-luster-94bc@gregkh>
References: <2026071457-shrank-luster-94bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Davide Ornaghi <d.ornaghi97@gmail.com>

[ Upstream commit 1c8951963d8ed357f70f59e0ad4ddce2199d2016 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/misc.c | 33 ---------------------------------
 fs/smb/server/misc.h |  1 -
 fs/smb/server/vfs.c  | 33 +++++++++++++++++++++++++++------
 3 files changed, 27 insertions(+), 40 deletions(-)

diff --git a/fs/smb/server/misc.c b/fs/smb/server/misc.c
index a543ec9d358177..966004c414a8c8 100644
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
index 13423696ae8c62..3909104e18ad48 100644
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
index d08973b288e581..5109ba5894490f 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1251,15 +1251,36 @@ struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 					  unsigned int flags,
 					  struct path *path)
 {
-	char *abs_name;
+	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
+	struct qstr last;
 	struct dentry *dent;
+	int err, type;
 
-	abs_name = convert_to_unix_name(work->tcon->share_conf, name);
-	if (!abs_name)
-		return ERR_PTR(-ENOMEM);
+	/* resolve the name beneath the share root so ".." cannot escape */
+	CLASS(filename_kernel, filename)(name);
+
+	err = vfs_path_parent_lookup(filename, flags | LOOKUP_BENEATH,
+				     path, &last, &type,
+				     &share_conf->vfs_path);
+	if (err)
+		return ERR_PTR(err);
 
-	dent = start_creating_path(AT_FDCWD, abs_name, path, flags);
-	kfree(abs_name);
+	if (unlikely(type != LAST_NORM)) {
+		path_put(path);
+		return ERR_PTR(-EINVAL);
+	}
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
 
-- 
2.53.0

