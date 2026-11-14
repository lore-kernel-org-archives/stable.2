Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794678067;
	b=kIE2Bj7ROHWRJ6TBtaL7heGu/j6G7b9DdPy9qugy5E/rbSaBPo5BIUJ4su+yut02Zjbd
	 0peC1p3KWwaLQgUL2ApuIq0GXo3oTBID4eLSdppy0Imhelg2Ts1HFKbvyH5zWlHMCeQQJ
	 6JfJc0k2pealpCP1cwm0SJJpYhbZjQjt2T3mnZf2n9oUdLr+4wWbZ33pdS4/x373M5FUk
	 Vv7eCNzOkH+kQkXLZPJ9emWkdwb5CbR50Amo7HIyA4q8ZkhVZII29ToW1fvG6LOSiJExn
	 AEl106B6PYSMRdpzuSxMG0dFY0obN7UCSyN7B+UPeDqrDT7yolayeQgGwjIhZF4egoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794678067;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UO80MmRLeyMOa2KH/SAgFT76/LTjDkH5bGA2Qna/hN0=;
	b=LnE5Gq2xxjJIjxvOrA30ghR+wNnCo2dxm/2v7zetbMmagUOBTTQ+qt2EeYTA59V5FXuJ
	 qdPkPsg/AjKbHaIsd0+drwzy48cB0H8bLO+R4ahg//m6s7WnZRwhx1Dj0Ap4XueVoVVyj
	 Dkohhc6FCCHMilmqD6CGdMpJWeLLLFkTGFqd4nay3yLJOyH8AEwjTPb83r8CdT8BWgdio
	 LmmLUv+0USvQiqe/LOfGmO0KWkOUsOXhKsAUQVYIG4exFziQitS3e/P5dH5HuPhevoswa
	 DFgTCt1p2oQcPr1yN7/g2hyTpZxcbbwfV0iuDtjEfsRtoaPOdTKCKVaLk+MeG/Rj6Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQa5UXDY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0566A606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQa5UXDY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0967B1F000C4;
	Sat, 14 Nov 2026 17:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794678066;
	bh=UO80MmRLeyMOa2KH/SAgFT76/LTjDkH5bGA2Qna/hN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RQa5UXDYvf+yQIOCnWfXf+ZdhYdeAVWy0JSVvjDgGu+GksYTeKO8ogUqYC2wmlQFd
	 xZPoO28AWJpOIA67jmW88dcyKETydjhNUV0DW+xO6vfYc6NOOY4K2R2eozMsxhCKGf
	 FiO8WKIo9DSNFG3AizhL4mRzZCZosSPmhCKiOhg3ZSwKAir4r3OV61AV8auVwkcSOt
	 tvihZ7iwXaGDHZRmjy4kk/TnvPSFGYcalTQtS8K4WGtq9yjLqHZWYsL+htrHS+mxFY
	 cRKhvSj+vHtuTOj1A3VvrwR4lLiLeHJpc1Nt/TKLcyWZYwo7HxYCKBI++Xa1+8P5Au
	 ZKd9rdM4ijpzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Edvard Conrad <edvard@tuta.io>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ovl: inherit FMODE_NONOTIFY when reading directory layers
Date: Sat, 14 Nov 2026 12:41:04 -0500
Message-ID: <20261114174046.4185066-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202354-failed-5.15-9ff338af0e00@kernel.org>
References: <20261109202354-failed-5.15-9ff338af0e00@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 9ff338af0e002fe217cfa16b1289b76f6b21fc72 ]

Listing a merged or impure overlay directory opens the real layer
directories from ovl_dir_read(), when the readdir cache is filled.
Those opens use plain ovl_path_open(), so when the directory fd is
one that fanotify created for a permission event, they can still raise
FS_OPEN_PERM.  A listener that also marks the backing filesystem and
calls getdents() on the event fd before answering then deadlocks the
same way as with the directory open fixed by the previous commit.

Store the overlay user file in struct ovl_readdir_data and pass it to
ovl_path_open_realfile() from ovl_dir_read(), for both the merged and
the impure cache.  Internal readers such as ovl_check_empty_dir() and
the mount-time workdir cleanup still pass no user file.

A note about severity and real world impact: The FAN_OPEN_PERM event is
traditionally used by anti-malware protection agents and security/audit
agents. The scope that is often used in those use cases is FAN_MARK_MOUNT
and agents typically monitor multiple mounts in a mount namespace.
FAN_OPEN_PERM from directory open requires user opt-in with FAN_ONDIR.
It is often not the case that anti-malware agents monitor open of
directories. Security/audit engines are more likely to opt-into
FAN_OPEN_PERM on directories, but are less likely to list the content
of a directory within the scope of FAN_OPEN_PERM event, so the real
world impact of this bug is likely not significant.

Reported-by: Edvard Conrad <edvard@tuta.io>
Closes: https://lore.kernel.org/all/P5Qu3co--N-9@tuta.io/
Cc: stable@vger.kernel.org
Tested-by: Edvard Conrad <edvard@tuta.io>
Link: https://lore.kernel.org/ltp/P5WKBbq--F-9@tuta.io/
Co-developed-by: Edvard Conrad <edvard@tuta.io>
Signed-off-by: Edvard Conrad <edvard@tuta.io>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[ sashal: replaced ovl_path_open_realfile() with ovl_path_open() using an inline FMODE_NONOTIFY check to set __FMODE_NONOTIFY ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/readdir.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index eef6c5d1b1f8b..2de2e433530ee 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -37,6 +37,7 @@ struct ovl_dir_cache {
 
 struct ovl_readdir_data {
 	struct dir_context ctx;
+	const struct file *user_file;
 	struct dentry *dentry;
 	bool is_lowest;
 	struct rb_root *root;
@@ -295,9 +296,13 @@ static inline int ovl_dir_read(struct path *realpath,
 			       struct ovl_readdir_data *rdd)
 {
 	struct file *realfile;
+	int flags = O_RDONLY | O_LARGEFILE;
 	int err;
 
-	realfile = ovl_path_open(realpath, O_RDONLY | O_LARGEFILE);
+	if (rdd->user_file && (rdd->user_file->f_mode & FMODE_NONOTIFY))
+		flags |= __FMODE_NONOTIFY;
+
+	realfile = ovl_path_open(realpath, flags);
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 
@@ -341,12 +346,13 @@ static void ovl_dir_reset(struct file *file)
 }
 
 static int ovl_dir_read_merged(struct dentry *dentry, struct list_head *list,
-	struct rb_root *root)
+	struct rb_root *root, const struct file *user_file)
 {
 	int err;
 	struct path realpath;
 	struct ovl_readdir_data rdd = {
 		.ctx.actor = ovl_fill_merge,
+		.user_file = user_file,
 		.dentry = dentry,
 		.list = list,
 		.root = root,
@@ -390,9 +396,10 @@ static void ovl_seek_cursor(struct ovl_dir_file *od, loff_t pos)
 	od->cursor = p;
 }
 
-static struct ovl_dir_cache *ovl_cache_get(struct dentry *dentry)
+static struct ovl_dir_cache *ovl_dir_cache_get(struct file *file)
 {
 	int res;
+	struct dentry *dentry = file->f_path.dentry;
 	struct ovl_dir_cache *cache;
 
 	cache = ovl_dir_cache(d_inode(dentry));
@@ -411,7 +418,7 @@ static struct ovl_dir_cache *ovl_cache_get(struct dentry *dentry)
 	INIT_LIST_HEAD(&cache->entries);
 	cache->root = RB_ROOT;
 
-	res = ovl_dir_read_merged(dentry, &cache->entries, &cache->root);
+	res = ovl_dir_read_merged(dentry, &cache->entries, &cache->root, file);
 	if (res) {
 		ovl_cache_free(&cache->entries);
 		kfree(cache);
@@ -547,14 +554,15 @@ static int ovl_fill_plain(struct dir_context *ctx, const char *name,
 	return 0;
 }
 
-static int ovl_dir_read_impure(struct path *path,  struct list_head *list,
-			       struct rb_root *root)
+static int ovl_dir_read_impure(struct path *path, struct list_head *list,
+			       struct rb_root *root, const struct file *user_file)
 {
 	int err;
 	struct path realpath;
 	struct ovl_cache_entry *p, *n;
 	struct ovl_readdir_data rdd = {
 		.ctx.actor = ovl_fill_plain,
+		.user_file = user_file,
 		.list = list,
 		.root = root,
 	};
@@ -592,9 +600,10 @@ static int ovl_dir_read_impure(struct path *path,  struct list_head *list,
 	return 0;
 }
 
-static struct ovl_dir_cache *ovl_cache_get_impure(struct path *path)
+static struct ovl_dir_cache *ovl_cache_get_impure(struct file *file)
 {
 	int res;
+	struct path *path = &file->f_path;
 	struct dentry *dentry = path->dentry;
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct ovl_dir_cache *cache;
@@ -611,7 +620,7 @@ static struct ovl_dir_cache *ovl_cache_get_impure(struct path *path)
 	if (!cache)
 		return ERR_PTR(-ENOMEM);
 
-	res = ovl_dir_read_impure(path, &cache->entries, &cache->root);
+	res = ovl_dir_read_impure(path, &cache->entries, &cache->root, file);
 	if (res) {
 		ovl_cache_free(&cache->entries);
 		kfree(cache);
@@ -726,7 +735,7 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 	dput(parent);
 
 	if (ovl_is_impure_dir(file)) {
-		rdt.cache = ovl_cache_get_impure(&file->f_path);
+		rdt.cache = ovl_cache_get_impure(file);
 		if (IS_ERR(rdt.cache))
 			return PTR_ERR(rdt.cache);
 	}
@@ -773,7 +782,7 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	if (!od->cache) {
 		struct ovl_dir_cache *cache;
 
-		cache = ovl_cache_get(dentry);
+		cache = ovl_dir_cache_get(file);
 		err = PTR_ERR(cache);
 		if (IS_ERR(cache))
 			goto out;
@@ -987,7 +996,7 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 	const struct cred *old_cred;
 
 	old_cred = ovl_override_creds(dentry->d_sb);
-	err = ovl_dir_read_merged(dentry, list, &root);
+	err = ovl_dir_read_merged(dentry, list, &root, NULL);
 	revert_creds(old_cred);
 	if (err)
 		return err;
-- 
2.53.0

