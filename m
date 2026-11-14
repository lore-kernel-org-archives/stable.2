Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672513;
	b=XcagKB49UeJQCLHpHEjv321aoxZAmcJjBhY/pFDQqpYwtEbVSxd4wJFJcMSYxQkWYeXn
	 HHQMO+RRSqNNUOsvq/PrYeurm0azbnl74n6ftgRHVJVAd5fURohK8aBD6C0Vkk/tx5F/3
	 hi2cRpV5mKAS9GeWntSTUgN8Y94Wv6/fwT3S5ZBCrG/N2vWbATW7wUN7Nt5mdVg+P3x8E
	 eZ8YzlY341x9F2Mmr+oM99HwplBUoFAcxQzvfF/knCMGkxfCrm7p4Uen/SRp7TEJKs+Yj
	 2LnomCEbepbotpYfaWpXeJu3DiPXvWa2zyFcXB5W4DH2qeELWuPNPlDT+3HNFitlxPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672513;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ttk5Cg9W27d16Bd72OIb0nsDSU6C0TJQeWcWsj1YW7Y=;
	b=vNqUf74FdmBvowPiIkLLqMw4mRrx8kxKsHzlbe7qk63lSApPPfQOIscQL7Sq4O7s1Lq2
	 BmLWKRPR/JDsnHPBKay0T5a4zWbA2LK7hXmsWEyzFHBiX48LD+MZVLScaJSe9UXztMzTD
	 zjkSDlYax+Gq1Y/vt9TYV4dQzBprge21sjwf2C8zYF6qwJwvSrIpnb8HqvrgTp0iPzydI
	 4QQvkT8ntZAzLEfGJxYegzPDKvNvz0bf1GVVAVbXHRLwiUbLD/hM7ZxAjAuXPkRlrNevm
	 EdY9DmUg6pG3zclV1mByiO7BqAOt0KPf3D7QAEy8ib6doBc2d0mLY3IRNRyhTKu7gtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SDty6xOL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E00606A881
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SDty6xOL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BE71F000C5;
	Sat, 14 Nov 2026 16:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794672512;
	bh=Ttk5Cg9W27d16Bd72OIb0nsDSU6C0TJQeWcWsj1YW7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SDty6xOLSFrPTh6ta/S4OI7RlyDfgzDNYzwccLJtQIhEQGemUhzp0jRbhJPWyr3Gi
	 pmZSw02/++Zbp6DRYXDnFXfUdAjQaSMEWR8V1eLi9neBkp0oX2xPnFqxrXpdntHF89
	 S9i0x79lLVg8ogEYqyOY7vMLQc+khRMISFXSh/sadKwGdSdvBe+974vYU91+spa+7f
	 eVktw4zkm7zGbHbUy608PzS4K6TQOuZt4zif3siPr7a0ip4LScpxFdoposoDtEQu9/
	 UUtQVY+KS3lAZbnYjf2dcvFGoZQk9gotGvjM4CP1cLbehSFxEUwqDBHn2yt4T7b6U3
	 B7KOcyyM3qrkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Edvard Conrad <edvard@tuta.io>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ovl: inherit FMODE_NONOTIFY when reading directory layers
Date: Sat, 14 Nov 2026 11:08:30 -0500
Message-ID: <20261114160728.3931675-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200931-failed-6.12-9ff338af0e00@kernel.org>
References: <20261109200931-failed-6.12-9ff338af0e00@kernel.org>
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
[ sashal: replaced ovl_path_open_realfile() with ovl_path_open() using a conditional __FMODE_NONOTIFY flag ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/readdir.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 843c3d5168f4e..d102819622109 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -38,6 +38,7 @@ struct ovl_dir_cache {
 
 struct ovl_readdir_data {
 	struct dir_context ctx;
+	const struct file *user_file;
 	struct dentry *dentry;
 	bool is_lowest;
 	struct rb_root *root;
@@ -299,9 +300,13 @@ static inline int ovl_dir_read(const struct path *realpath,
 			       struct ovl_readdir_data *rdd)
 {
 	struct file *realfile;
+	int flags = O_RDONLY | O_LARGEFILE;
 	int err;
 
-	realfile = ovl_path_open(realpath, O_RDONLY | O_LARGEFILE);
+	if (rdd->user_file && FMODE_FSNOTIFY_NONE(rdd->user_file->f_mode))
+		flags |= __FMODE_NONOTIFY;
+
+	realfile = ovl_path_open(realpath, flags);
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 
@@ -345,12 +350,13 @@ static void ovl_dir_reset(struct file *file)
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
@@ -397,9 +403,10 @@ static void ovl_seek_cursor(struct ovl_dir_file *od, loff_t pos)
 	od->cursor = p;
 }
 
-static struct ovl_dir_cache *ovl_cache_get(struct dentry *dentry)
+static struct ovl_dir_cache *ovl_dir_cache_get(struct file *file)
 {
 	int res;
+	struct dentry *dentry = file->f_path.dentry;
 	struct ovl_dir_cache *cache;
 	struct inode *inode = d_inode(dentry);
 
@@ -419,7 +426,7 @@ static struct ovl_dir_cache *ovl_cache_get(struct dentry *dentry)
 	INIT_LIST_HEAD(&cache->entries);
 	cache->root = RB_ROOT;
 
-	res = ovl_dir_read_merged(dentry, &cache->entries, &cache->root);
+	res = ovl_dir_read_merged(dentry, &cache->entries, &cache->root, file);
 	if (res) {
 		ovl_cache_free(&cache->entries);
 		kfree(cache);
@@ -563,14 +570,15 @@ static bool ovl_fill_plain(struct dir_context *ctx, const char *name,
 	return true;
 }
 
-static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
-			       struct rb_root *root)
+static int ovl_dir_read_impure(const struct path *path, struct list_head *list,
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
@@ -608,9 +616,10 @@ static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
 	return 0;
 }
 
-static struct ovl_dir_cache *ovl_cache_get_impure(const struct path *path)
+static struct ovl_dir_cache *ovl_cache_get_impure(struct file *file)
 {
 	int res;
+	const struct path *path = &file->f_path;
 	struct dentry *dentry = path->dentry;
 	struct inode *inode = d_inode(dentry);
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
@@ -628,7 +637,7 @@ static struct ovl_dir_cache *ovl_cache_get_impure(const struct path *path)
 	if (!cache)
 		return ERR_PTR(-ENOMEM);
 
-	res = ovl_dir_read_impure(path, &cache->entries, &cache->root);
+	res = ovl_dir_read_impure(path, &cache->entries, &cache->root, file);
 	if (res) {
 		ovl_cache_free(&cache->entries);
 		kfree(cache);
@@ -744,7 +753,7 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 	dput(parent);
 
 	if (ovl_is_impure_dir(file)) {
-		rdt.cache = ovl_cache_get_impure(&file->f_path);
+		rdt.cache = ovl_cache_get_impure(file);
 		if (IS_ERR(rdt.cache))
 			return PTR_ERR(rdt.cache);
 	}
@@ -792,7 +801,7 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	if (!od->cache) {
 		struct ovl_dir_cache *cache;
 
-		cache = ovl_cache_get(dentry);
+		cache = ovl_dir_cache_get(file);
 		err = PTR_ERR(cache);
 		if (IS_ERR(cache))
 			goto out;
@@ -1007,7 +1016,7 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 	const struct cred *old_cred;
 
 	old_cred = ovl_override_creds(dentry->d_sb);
-	err = ovl_dir_read_merged(dentry, list, &root);
+	err = ovl_dir_read_merged(dentry, list, &root, NULL);
 	revert_creds(old_cred);
 	if (err)
 		return err;
-- 
2.53.0

