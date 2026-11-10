Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273237;
	b=k/sunOyWZYcnSkc/DeGchus2wQpDFh19zbIqZ4lgN0QvctEo0WEnXxLyUCXVKX+Z2kMv
	 VEFg/IiO8d2lRonhHwoF3eA5PtwPJtKHfdQ0TadjanNe08V1SzRizIGqZ/xZFD7QMcDsU
	 Qes5bUhn3e81UDrKNMKqaYfDsADjcMREYaSO8JjMo/SLkpAqLWkizY1Y9Bgr4KZaWJo1X
	 Kz8jTUxc8dovZBnzsJlbAlYI+BIMM/tQwRf/HP5Trl0oJkmVweMYxaOWJcOwbyRtI9wDi
	 LzkvSxkiqTjYj5CMuYghG9LB9nivici8+TV/WLynbunea7TaYyI72RRdTYufL7j35Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273237;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=doXKe6oTRqXkUQrk6TEDGergZOr4wemdLvl2XRwdu0c=;
	b=fHQAwv/MxTWY4SBYc/hIJaWB/wfTIOlDfBEr0c+6yw1yxDTDo+BpxMp97uCPL1ST+sQU
	 pUwoee2pLhM4sdTHk8AFNJGXxkLIhZV30cqa6xHi5Il9mDttpmPv6MH491SFhQCfM5P9j
	 iYwfiE9qLjcCgeX31u1fswtA7nW60pVm4bCtwUC4Ep6X8I6i7FwohxWnu7PcgWWPqn+Iz
	 /dYcnnL7f1yp2oHRUlXjzpbs1KcfjX5otsW02vem0uRkx7OXFJpQ2rIj5Q8+pjYEUk3p5
	 xA9F9+jz81i+r9629YjCCSqotrB7x/Bui84qH4lR9KWiOoAkwURoL0j6b+z6efOmkiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZ+6ovfs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE0E606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZ+6ovfs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AFA1F0089F;
	Tue, 10 Nov 2026 01:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273236;
	bh=doXKe6oTRqXkUQrk6TEDGergZOr4wemdLvl2XRwdu0c=;
	h=From:To:Cc:Subject:Date;
	b=EZ+6ovfsnp1NQzPIqBBHbpeZw8iGE//wIGkPvQ3hmjeICjD7KC3hmYQ8kKznpvejM
	 RazfDWzYhSgRlY8kDZxWtXIFCtDOltmGltSjHQ8J7YLvC8a3pEl3ayea9BmQq7t/OT
	 KaU9cEtn/vHa83ZzyyMcybtJriVxy9my9WdkG47g95/LhwvjF6d4chgAxvtyf4ceXS
	 fsoWkQhE5vbFOdQkbu6UwcS47UqMigMIcBReZzbEivtNDijYiNVk2xvpTzrRiq84Pz
	 nJFDtqXctIVxGl/S8tt+3loniva5HaqAbGVkna76OL26SQ5J0+9C7zNQ+yKX8Oign9
	 JYlHYT0n33V0Q==
From: Sasha Levin <sashal@kernel.org>
To: amir73il@gmail.com,
	edvard@tuta.io
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ovl: inherit FMODE_NONOTIFY when reading directory layers" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:13:55 -0500
Message-ID: <20261109201354-failed-6.6-9ff338af0e00@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9ff338af0e002fe217cfa16b1289b76f6b21fc72
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201354-failed-6.6-9ff338af0e00@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9ff338af0e002fe217cfa16b1289b76f6b21fc72 Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 30 Oct 2026 18:07:02 +0100
Subject: [PATCH] ovl: inherit FMODE_NONOTIFY when reading directory layers

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
---
 fs/overlayfs/readdir.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 5d21a328fad46..4cd4af097e5c1 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -43,6 +43,7 @@ struct ovl_dir_cache {
 
 struct ovl_readdir_data {
 	struct dir_context ctx;
+	const struct file *user_file;
 	struct dentry *dentry;
 	bool is_lowest;
 	struct rb_root *root;
@@ -377,7 +378,8 @@ static inline int ovl_dir_read(const struct path *realpath,
 	struct file *realfile;
 	int err;
 
-	realfile = ovl_path_open(realpath, O_RDONLY | O_LARGEFILE);
+	realfile = ovl_path_open_realfile(rdd->user_file, realpath,
+					  O_RDONLY | O_LARGEFILE);
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 
@@ -421,13 +423,14 @@ static void ovl_dir_reset(struct file *file)
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
@@ -498,9 +501,10 @@ static struct ovl_dir_cache *ovl_dir_cache_check(struct inode *inode,
 	return cache;
 }
 
-static struct ovl_dir_cache *ovl_cache_get(struct dentry *dentry)
+static struct ovl_dir_cache *ovl_dir_cache_get(struct file *file)
 {
 	int res;
+	struct dentry *dentry = file->f_path.dentry;
 	struct ovl_dir_cache *cache;
 	struct inode *inode = d_inode(dentry);
 
@@ -521,7 +525,7 @@ static struct ovl_dir_cache *ovl_cache_get(struct dentry *dentry)
 	INIT_LIST_HEAD(&cache->entries);
 	cache->root = RB_ROOT;
 
-	res = ovl_dir_read_merged(dentry, &cache->entries, &cache->root);
+	res = ovl_dir_read_merged(dentry, &cache->entries, &cache->root, file);
 	if (res) {
 		ovl_cache_free(&cache->entries);
 		kfree(cache);
@@ -665,8 +669,8 @@ static bool ovl_fill_plain(struct dir_context *ctx, const char *name,
 	return true;
 }
 
-static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
-			       struct rb_root *root)
+static int ovl_dir_read_impure(const struct path *path, struct list_head *list,
+			       struct rb_root *root, const struct file *user_file)
 {
 	int err;
 	struct path realpath;
@@ -674,6 +678,7 @@ static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
 	struct ovl_readdir_data rdd = {
 		.ctx.actor = ovl_fill_plain,
 		.ctx.count = INT_MAX,
+		.user_file = user_file,
 		.list = list,
 		.root = root,
 	};
@@ -710,9 +715,10 @@ static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
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
@@ -731,7 +737,7 @@ static struct ovl_dir_cache *ovl_cache_get_impure(const struct path *path)
 		return ERR_PTR(-ENOMEM);
 
 	cache->is_refcounted = false;
-	res = ovl_dir_read_impure(path, &cache->entries, &cache->root);
+	res = ovl_dir_read_impure(path, &cache->entries, &cache->root, file);
 	if (res) {
 		ovl_cache_free(&cache->entries);
 		kfree(cache);
@@ -852,7 +858,7 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 	dput(parent);
 
 	if (ovl_is_impure_dir(file)) {
-		rdt.cache = ovl_cache_get_impure(&file->f_path);
+		rdt.cache = ovl_cache_get_impure(file);
 		if (IS_ERR(rdt.cache))
 			return PTR_ERR(rdt.cache);
 	}
@@ -866,14 +872,13 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 static int ovl_iterate_merged(struct file *file, struct dir_context *ctx)
 {
 	struct ovl_dir_file *od = file->private_data;
-	struct dentry *dentry = file->f_path.dentry;
 	struct ovl_cache_entry *p;
 	int err;
 
 	if (!od->cache) {
 		struct ovl_dir_cache *cache;
 
-		cache = ovl_cache_get(dentry);
+		cache = ovl_dir_cache_get(file);
 		if (IS_ERR(cache))
 			return PTR_ERR(cache);
 
@@ -1120,7 +1125,7 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 	struct rb_root root = RB_ROOT;
 
 	with_ovl_creds(dentry->d_sb)
-		err = ovl_dir_read_merged(dentry, list, &root);
+		err = ovl_dir_read_merged(dentry, list, &root, NULL);
 	if (err)
 		return err;
 
-- 
2.53.0




