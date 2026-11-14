Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794673860;
	b=w1Uaq3dyDN9s8a+TaZg1IaiHPOPRZjZr0wZAxPtmlaEp0tKvawYIXbUdwH4aexJhK9aH
	 a8xHfU6cHCCnk+gvLrBaoKPf5odHwou324OaLO2qYhrJrWsbqp3XF8zWssdypkj6zAuPY
	 nftbI8H74C8GZe3twGZ8YX15Apy5BknCKKZGzcQEJnNFabBX8MkjJlqoJ0vGqI3nTA+sb
	 UVbd5m6Z8BpI83fxD7YffKf6ofV7jEFS9nHrwLi8xLbKlVsxHJhTyQXsyhg934nr4kO+P
	 8Qhcjvvndv68e8qVfMh+iGAH5456BvtGr/ZT1O+5uurJ4N9Z2NeOSO+7PR7n+nvcgoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794673860;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9a/lcsSmPMMHD6WcAcyrB8OEOt4K1iPf/VMTtqKW+JU=;
	b=jV8UpPblowk0qJ62RXRU4pUpnoncnHK5IWcGvoXq8tRzQdgqX5tsaq3birjMUh0Bo3L3
	 +Ypjb0l7JeIvZZx7LzsBLk80iWiRUX+bZt3k7xh96nBldPdpd1PhEns+3lLAq29XkFTLU
	 MFRo7VcSKtlnuNqh5p4Hh+tfGvmD+rTbHb3U1BJYuQo2NmkijzIr4FlBN0l3baCcu03kw
	 fgmQZOpdT4MJrbicnvXvqOFuGnEBSszOueNmjGM4O5oXHZDMal3lDiESymUi0eVvYkGAD
	 alkxFv/KO2/CVExHfhNRp27mn1CjrPr+YMKft4lIX/trHjS4VVie/rTMd4Nx51PpEWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDMjOmUN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A103606A330
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDMjOmUN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471711F000C4;
	Sat, 14 Nov 2026 16:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794673859;
	bh=9a/lcsSmPMMHD6WcAcyrB8OEOt4K1iPf/VMTtqKW+JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VDMjOmUN+LhN06z86c2u4BrXEi+5/2IHztYHCxwUGtl5/CVGHLw8fkExBEfiAcuc4
	 SlWB9KAqhfEOnsi9zh8Nz7KCF6xo5iFwg8wstNDmJKJuDaEyiGUjusWvd0I05xDD1N
	 dl3cg8cNTxmZ4QgGH3KBHVAnIJyEYtMOQmP69GaALiB+OIv+vVcC5c/8Q+xVfkKou5
	 SiI8QncA63zCiU8DtLBb8dfIjHMhw3/2RNe/NCXFEQqTTbp6SVO3ajfh8wwtIakWvB
	 3fpwLLtdWz+uaRPdOTAMiAuImO3oaMoppStLkdyHDMOtQuf/Ky+lcgDEHtZyRGS5hZ
	 MMHTXRKETEA3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Edvard Conrad <edvard@tuta.io>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ovl: inherit FMODE_NONOTIFY when reading directory layers
Date: Sat, 14 Nov 2026 11:30:57 -0500
Message-ID: <20261114162916.4002284-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201354-failed-6.6-9ff338af0e00@kernel.org>
References: <20261109201354-failed-6.6-9ff338af0e00@kernel.org>
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
[ sashal: replaced unavailable ovl_path_open_realfile() with ovl_path_open() using inline __FMODE_NONOTIFY flag handling. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/readdir.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index ed79c2ad3593e..6e24581983ca6 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -37,6 +37,7 @@ struct ovl_dir_cache {
 
 struct ovl_readdir_data {
 	struct dir_context ctx;
+	const struct file *user_file;
 	struct dentry *dentry;
 	bool is_lowest;
 	struct rb_root *root;
@@ -295,9 +296,13 @@ static inline int ovl_dir_read(const struct path *realpath,
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
 	struct inode *inode = d_inode(dentry);
 
@@ -412,7 +419,7 @@ static struct ovl_dir_cache *ovl_cache_get(struct dentry *dentry)
 	INIT_LIST_HEAD(&cache->entries);
 	cache->root = RB_ROOT;
 
-	res = ovl_dir_read_merged(dentry, &cache->entries, &cache->root);
+	res = ovl_dir_read_merged(dentry, &cache->entries, &cache->root, file);
 	if (res) {
 		ovl_cache_free(&cache->entries);
 		kfree(cache);
@@ -549,14 +556,15 @@ static bool ovl_fill_plain(struct dir_context *ctx, const char *name,
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
@@ -594,9 +602,10 @@ static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
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
@@ -614,7 +623,7 @@ static struct ovl_dir_cache *ovl_cache_get_impure(const struct path *path)
 	if (!cache)
 		return ERR_PTR(-ENOMEM);
 
-	res = ovl_dir_read_impure(path, &cache->entries, &cache->root);
+	res = ovl_dir_read_impure(path, &cache->entries, &cache->root, file);
 	if (res) {
 		ovl_cache_free(&cache->entries);
 		kfree(cache);
@@ -730,7 +739,7 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 	dput(parent);
 
 	if (ovl_is_impure_dir(file)) {
-		rdt.cache = ovl_cache_get_impure(&file->f_path);
+		rdt.cache = ovl_cache_get_impure(file);
 		if (IS_ERR(rdt.cache))
 			return PTR_ERR(rdt.cache);
 	}
@@ -778,7 +787,7 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	if (!od->cache) {
 		struct ovl_dir_cache *cache;
 
-		cache = ovl_cache_get(dentry);
+		cache = ovl_dir_cache_get(file);
 		err = PTR_ERR(cache);
 		if (IS_ERR(cache))
 			goto out;
@@ -993,7 +1002,7 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 	const struct cred *old_cred;
 
 	old_cred = ovl_override_creds(dentry->d_sb);
-	err = ovl_dir_read_merged(dentry, list, &root);
+	err = ovl_dir_read_merged(dentry, list, &root, NULL);
 	revert_creds(old_cred);
 	if (err)
 		return err;
-- 
2.53.0

