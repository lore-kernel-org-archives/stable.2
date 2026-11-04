Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802895;
	b=b8SRSbI9/8H5O2mqWmimxjMY+IPo/zkZZPzRQ6Ewm0NUqt94YUaXrGa+x8IvItA9qvJ4
	 Q+bYivdL7bJNdE3eKe0cpaDHiz3rUvQAxzV18TuFboZ+/M1XGCvTonTHINz6vmsSYXJ5E
	 uaUsvsttVIe5AnaR3dkhxcNfzKEpveM8KQl/RGF42uYHO5jfITpMY2roHxShk7yJi+pHM
	 q30RXZvPbTxpibuR/oodzitTB8zZt/ZZEnZLPp67Z6jadR0TlBQ+1UPNT57hnH+oBPw4p
	 M/95w16KTmYR7dp6E//HKZLCQYCZByIELwyc+r78FhhiNFtOY89qndEvG/c5qCehEHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802895;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sxuk2xcju7HU4V3MUW1XYbyijbw1VT4EQNF5fRzLzEg=;
	b=bHdzTAwVqcrlsfzrLr6HRBQXwiyKdER98H6V+6UYH6t6A7bEmenaiX+/OLwsdkshP30j
	 WwUBpvwxfqyX5wLE+9S9EYYDOZd6R64RAXQHF7VXIROXdUUGsHCt5XUgqb8/6WK23utg4
	 jgsShgqXXI18Wh1xBOSlHoYgu3upaS0UJxp4sf82P4nDmv2SW9nb1760jWrmvWpfnOjSZ
	 /e1wTnn8+Xw2dcfyIvnPo3mMc3GPgz7su+G6qJf4/79S18NDm64owKj4pTwTZhKUuTE+N
	 PRPB1/I2Qpgf7J22eOfEiwdH9BbqQUIA6CMK/oejQWDhkXhFsJLfJgNBBEGNMztuv7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Mc5J159g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F47D606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Mc5J159g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87631F000C1;
	Wed,  4 Nov 2026 14:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802895;
	bh=sxuk2xcju7HU4V3MUW1XYbyijbw1VT4EQNF5fRzLzEg=;
	h=Subject:To:Cc:From:Date;
	b=Mc5J159g0o+XRSTWYVvGtkK51bP7zNEf+/N0TiX9xcYEN+1khmfxTeFzQlOHJuXof
	 jD88Jm6RmXE5bwFpSqFVwQZWW2PGg+OlZl1HFfI3hA1voPMGQXmgOa0YbTK/f/L7l1
	 HE5dcF0EUPptwoxL8Yo++cgjZxt6UZsqfdyzO+9Q=
Subject: FAILED: patch "[PATCH] ovl: hold a reference on the parent in readdir" failed to apply to 6.1-stable tree
To: mason@kernel.org,amir73il@gmail.com,josef@toxicpanda.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:34:48 +0100
Message-ID: <2026110448-running-steadfast-67b5@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 16d319e12328acafeafd3eecdf09c46d7fb43452
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110448-running-steadfast-67b5@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 16d319e12328acafeafd3eecdf09c46d7fb43452 Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Wed, 7 Oct 2026 10:53:10 +0000
Subject: [PATCH] ovl: hold a reference on the parent in readdir

Listing a directory on an overlay uses a freed dentry and crashes the
kernel when a lookup moves the directory at the same time.

Code that can sleep may only use d_parent without a reference while
something stops a move of the dentry. ovl_iterate_real(),
ovl_need_adjust_d_ino() and ovl_cache_update() use the d_parent of the
listed directory and hold only the lock of that directory. When a
lookup finds the directory under another parent after a change to a
layer, d_splice_alias() moves it without that lock and drops its
reference on the old parent.

With a delay in ovl_iterate_real(), getdents64 on an overlay directory
raced a rename in the lower layer and a lookup that moved its dentry,
and after an rmdir of the old parent KASAN reported a use-after-free in
security_inode_getattr().

Fix this by using dget_parent() in the three functions.

Fixes: b5efccbe0a12 ("ovl: constant d_ino across copy up")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: fix comments in ovl_need_adjust_d_ino()]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index b875332107d3..45239ef63e8c 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -588,8 +588,8 @@ static int ovl_cache_update(const struct path *path, struct ovl_cache_entry *p,
 			goto get;
 		}
 		if (p->len == 2) {
-			/* we shall not be moved */
-			this = dget(dir->d_parent);
+			/* d_splice_alias() can move even a locked dir */
+			this = dget_parent(dir);
 			goto get;
 		}
 	}
@@ -818,6 +818,7 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 	struct dentry *dir = file->f_path.dentry;
 	struct ovl_fs *ofs = OVL_FS(dir->d_sb);
 	const struct ovl_layer *lower_layer = ovl_layer_lower(dir);
+	struct dentry *parent;
 	struct ovl_readdir_translate rdt = {
 		.ctx.actor = ovl_fill_real,
 		.ctx.count = ctx->count,
@@ -829,18 +830,26 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 	if (rdt.xinobits && lower_layer)
 		rdt.fsid = lower_layer->fsid;
 
-	if (OVL_TYPE_MERGE(ovl_path_type(dir->d_parent))) {
+	/*
+	 * The lock on dir does not stop d_splice_alias() from moving it to
+	 * another parent, which drops the reference dir holds on this one.
+	 */
+	parent = dget_parent(dir);
+	if (OVL_TYPE_MERGE(ovl_path_type(parent))) {
 		struct kstat stat;
 		struct path statpath = file->f_path;
 
-		statpath.dentry = dir->d_parent;
+		statpath.dentry = parent;
 		err = vfs_getattr(&statpath, &stat, STATX_INO, 0);
-		if (err)
+		if (err) {
+			dput(parent);
 			return err;
+		}
 
 		WARN_ON_ONCE(dir->d_sb->s_dev != stat.dev);
 		rdt.parent_ino = stat.ino;
 	}
+	dput(parent);
 
 	if (ovl_is_impure_dir(file)) {
 		rdt.cache = ovl_cache_get_impure(&file->f_path);
@@ -896,8 +905,10 @@ static bool ovl_need_adjust_d_ino(struct file *file)
 {
 	struct dentry *dentry = file->f_path.dentry;
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
+	struct dentry *parent;
+	enum ovl_path_type type;
 
-	/* If parent is merge, then need to adjust d_ino for '..' */
+	/* With xino, need to map real d_ino to the unified overlay ino space */
 	if (ovl_xino_bits(ofs))
 		return true;
 
@@ -906,8 +917,14 @@ static bool ovl_need_adjust_d_ino(struct file *file)
 		return false;
 
 	/* If dir is impure then need to adjust d_ino for copied up entries */
-	if (ovl_is_impure_dir(file) ||
-	    OVL_TYPE_MERGE(ovl_path_type(dentry->d_parent)))
+	if (ovl_is_impure_dir(file))
+		return true;
+
+	/* If parent is merge, then need to adjust d_ino for '..' */
+	parent = dget_parent(dentry);
+	type = ovl_path_type(parent);
+	dput(parent);
+	if (OVL_TYPE_MERGE(type))
 		return true;
 
 	/* Pure: no need to adjust d_ino */

