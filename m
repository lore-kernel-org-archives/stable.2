Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597325;
	b=2nvq9RjiDFM1kht3cDtmh6p1MYHnKb8WTtzJQR8xklCI3wIv2q1wvpgWOo7LS2k7NqFS
	 /DlkYyO6LtppoOE+/tWq8Yf2IfvjzHcCoswfST11FUkcHML4kQniBHKQnhBN28ypqVbTc
	 7efzK8SQtDIaS4vd74oi3Q8FWj4QscBSGTNVZJbh0U2CxtWj/JQKYYD1wZoqh9CKDuxgf
	 oUkxoG2mMcpsY9ts6ji98j6seZSnM3oH9os18P4hZYSK3RlpTe23RKG0ubLkzjHulWId2
	 SWLrgNHi0V+dJrBaJ7cxgHMj4Pem+VctgSpRR6zkR96mabsZODOacfAnWFnjF3s1hHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597325;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SdJ/lI1iW1LYgR5AkN6rdJnRJt4yvDKZkV+8At7lN28=;
	b=c6IwKJWWnIzVhH8rULlVKf90H9SA9WebDbc6xnbD4HAW3CdQkE/9+037kRsOvd02eGyt
	 Sg6DtXC/ge4wFWt8oE8vbMvlSSLotkTYrg2Bz0Zm5OxZpWDJ0Bd5/dHjpWbaIrn7k63rX
	 parWx2hUa6G1/rrkV15X2WW4ubhzBjof8XLEoHFIRl8tWyLL01+MRL+8OZihK0sgP/K6q
	 EdKb79RzDiJCOIna2n2Sec8HbO6FhYfi2xiEHMSjJfx8HVJMaN++8wQ9EYzW/KpmYyMn7
	 898UcWBa0oaTLv5dOWic32/pXIfip+MTXJ+cT9EOzL2dS8tBoLB8Vd+IPOdeLl65bAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=noFkp7Qj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449FC606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=noFkp7Qj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A341F1F000C4;
	Fri, 13 Nov 2026 19:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597325;
	bh=SdJ/lI1iW1LYgR5AkN6rdJnRJt4yvDKZkV+8At7lN28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=noFkp7Qjaoo1iraPCyUaJcYauOHQYDQlMMdjHJgrLKYXX6ZIXD4ykozmLDyFAd5Km
	 tXfKemqlwV2Bkj+dxNuZtfNyeUWspiOdJyHcZ1Qo9ihV4wBuN0UeZ/gIBl4JnkeVSz
	 TnMNFrfTLvgeSTKDjAwOlC5qk19xp0THbGaz9vTEaJDmxvXY4Aajubgjmr1R0ldSyP
	 fmCLh4OoshMP7dzpDUJB63oZdJXi9kYkSsnSJGiHrgm5v0HOjk9rfg3KfFrNWYr7My
	 2+9nmqKsnnXPZr7C31wHjgEGhViD71ysc6FIYeIG9Gv3Dk/nitf0jlNvG2+aeVNUOB
	 GUQhx/5g8TvTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Edvard Conrad <edvard@tuta.io>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ovl: inherit FMODE_NONOTIFY when reading directory layers
Date: Fri, 13 Nov 2026 14:15:23 -0500
Message-ID: <20261113191040.2211914-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200515-failed-6.18-9ff338af0e00@kernel.org>
References: <20261109200515-failed-6.18-9ff338af0e00@kernel.org>
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
[ sashal: Retained the dentry declaration still required by ovl_iterate(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/readdir.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 3c8fe45b06f12..efa3964041932 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -41,6 +41,7 @@ struct ovl_dir_cache {
 
 struct ovl_readdir_data {
 	struct dir_context ctx;
+	const struct file *user_file;
 	struct dentry *dentry;
 	bool is_lowest;
 	struct rb_root *root;
@@ -380,7 +381,8 @@ static inline int ovl_dir_read(const struct path *realpath,
 	struct file *realfile;
 	int err;
 
-	realfile = ovl_path_open(realpath, O_RDONLY | O_LARGEFILE);
+	realfile = ovl_path_open_realfile(rdd->user_file, realpath,
+					  O_RDONLY | O_LARGEFILE);
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 
@@ -424,13 +426,14 @@ static void ovl_dir_reset(struct file *file)
 }
 
 static int ovl_dir_read_merged(struct dentry *dentry, struct list_head *list,
-	struct rb_root *root)
+	struct rb_root *root, const struct file *user_file)
 {
 	int err;
 	struct path realpath;
 	struct ovl_readdir_data rdd = {
 		.ctx.actor = ovl_fill_merge,
 		.ctx.count = INT_MAX,
+		.user_file = user_file,
 		.dentry = dentry,
 		.list = list,
 		.root = root,
@@ -483,9 +486,10 @@ static void ovl_seek_cursor(struct ovl_dir_file *od, loff_t pos)
 	od->cursor = p;
 }
 
-static struct ovl_dir_cache *ovl_cache_get(struct dentry *dentry)
+static struct ovl_dir_cache *ovl_dir_cache_get(struct file *file)
 {
 	int res;
+	struct dentry *dentry = file->f_path.dentry;
 	struct ovl_dir_cache *cache;
 	struct inode *inode = d_inode(dentry);
 
@@ -505,7 +509,7 @@ static struct ovl_dir_cache *ovl_cache_get(struct dentry *dentry)
 	INIT_LIST_HEAD(&cache->entries);
 	cache->root = RB_ROOT;
 
-	res = ovl_dir_read_merged(dentry, &cache->entries, &cache->root);
+	res = ovl_dir_read_merged(dentry, &cache->entries, &cache->root, file);
 	if (res) {
 		ovl_cache_free(&cache->entries);
 		kfree(cache);
@@ -649,8 +653,8 @@ static bool ovl_fill_plain(struct dir_context *ctx, const char *name,
 	return true;
 }
 
-static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
-			       struct rb_root *root)
+static int ovl_dir_read_impure(const struct path *path, struct list_head *list,
+			       struct rb_root *root, const struct file *user_file)
 {
 	int err;
 	struct path realpath;
@@ -658,6 +662,7 @@ static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
 	struct ovl_readdir_data rdd = {
 		.ctx.actor = ovl_fill_plain,
 		.ctx.count = INT_MAX,
+		.user_file = user_file,
 		.list = list,
 		.root = root,
 	};
@@ -695,9 +700,10 @@ static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
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
@@ -715,7 +721,7 @@ static struct ovl_dir_cache *ovl_cache_get_impure(const struct path *path)
 	if (!cache)
 		return ERR_PTR(-ENOMEM);
 
-	res = ovl_dir_read_impure(path, &cache->entries, &cache->root);
+	res = ovl_dir_read_impure(path, &cache->entries, &cache->root, file);
 	if (res) {
 		ovl_cache_free(&cache->entries);
 		kfree(cache);
@@ -836,7 +842,7 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 	dput(parent);
 
 	if (ovl_is_impure_dir(file)) {
-		rdt.cache = ovl_cache_get_impure(&file->f_path);
+		rdt.cache = ovl_cache_get_impure(file);
 		if (IS_ERR(rdt.cache))
 			return PTR_ERR(rdt.cache);
 	}
@@ -884,7 +890,7 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	if (!od->cache) {
 		struct ovl_dir_cache *cache;
 
-		cache = ovl_cache_get(dentry);
+		cache = ovl_dir_cache_get(file);
 		err = PTR_ERR(cache);
 		if (IS_ERR(cache))
 			goto out;
@@ -1086,7 +1092,7 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 	const struct cred *old_cred;
 
 	old_cred = ovl_override_creds(dentry->d_sb);
-	err = ovl_dir_read_merged(dentry, list, &root);
+	err = ovl_dir_read_merged(dentry, list, &root, NULL);
 	ovl_revert_creds(old_cred);
 	if (err)
 		return err;
-- 
2.53.0

