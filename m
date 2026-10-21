Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594185;
	b=l622+sr8QZHAj0lZ5swhXkLkjESrWb6G6AQuCHytEjKBKTiZLd9UjzfyfQxlda7hEa1e
	 vr2dYq92X+++I9lvUwFCC7uUOwA4FpAqJ2+A6nWGZcLAyrYRlQFdK279nrKV+2oY17tIh
	 gT7I76c6WV8RtvTjwPm5EbU/mmLIkr2MtaPNS7I8akyqnKooXCiUJLHkNLInzCU7TZ+sy
	 HV+QT/mTpA9jKwF3qlhih6YS0iticTuM+QbS6OEbZnedAugW8Rw+imI6DiHDZUoz4hKSQ
	 GLzG2AHWXvYzmw/x3ezZTs3fp79/u9muSXBlDjCEB0uTXMgy199X16bBaJlwXvR+HuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594185;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jdt5fZ9qU6qKCuNUSPrJOW52FNpa1p7BsS9+NpANxKE=;
	b=UyB9wsJlhN3e/WIUo8isRloJybsm6qssI2/gAKJHGh1cE8ySrKPUBSsODlAzg7+jo170
	 0284p+vWGo23ZQ7mzujS8PnvQMef/jeHv8GACLTZbthePJAloLca7LRdjkUnBpqCXb0sv
	 wd4MREXedAib7Sz+/v3Hz0gBNriMYX15BtAJscRwR0IHm592lxc32o5pgcMRURV2OnisR
	 gyS8QDNZ57Iy1LjjN1laTqL74tQbhY2oRrBSaoCrexf/NvggG6H4ftVNE/660mD08owRN
	 xpznjAagcAXAki2VUwmtxk77w+N1ugyzm+tyYM4v6MaPA2UIh8mjp2Mo3mCO8SrDemQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="zeZpl/+H";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDA2606A323
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zeZpl/+H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32471F000C1;
	Wed, 21 Oct 2026 14:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594184;
	bh=jdt5fZ9qU6qKCuNUSPrJOW52FNpa1p7BsS9+NpANxKE=;
	h=Subject:To:Cc:From:Date;
	b=zeZpl/+HcaXSZMenRyd8WMfTYM2tjSiMvL5+jGEeJorz3lLsX9g5B+D8Vd6ijzKsJ
	 b5Gfe/NBYfJ1f+ofihPYs6VIs8DVKvJKhw/pih5gE/rY3CBLEJAPGZh1QMuu2c+p6k
	 XDs4K+Dv46BEDyuWexRSJmmQFvjju9igTV1ZbbBQ=
Subject: FAILED: patch "[PATCH] ntfs3: free replaced mount options after a grace period" failed to apply to 7.2-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:39:07 +0200
Message-ID: <2026102107-stilt-haste-457a@gregkh>
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


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 56c3824de56b5275c02ff6b6aa27ddbacfbb9b25
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102107-stilt-haste-457a@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 56c3824de56b5275c02ff6b6aa27ddbacfbb9b25 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 9 Oct 2026 23:51:58 +0200
Subject: [PATCH] ntfs3: free replaced mount options after a grace period

ntfs_fs_reconfigure() replaces the old mount options with new mount
options in sbi->options. The old mount options land in fs_context and
are freed as soon as remount returns. With a pathwalk held up in
ntfs_nls_to_utf16() between loading sbi->options and dereferencing it
while a remount replaces them:

  BUG: KASAN: slab-use-after-free in ntfs_nls_to_utf16+0x7ae/0x7c0
  Read of size 8 at addr ff110001044fd448 by task walker/98
  Call Trace:
   <TASK>
   ntfs_nls_to_utf16+0x7ae/0x7c0
   ntfs_d_hash+0x22b/0x500
   link_path_walk+0x11ad/0x1d30
   path_lookupat+0x63/0xb00
   filename_lookup+0x1f1/0x5b0
   vfs_statx+0xd7/0x3b0
  [...]
  Allocated by task 95:
   __kmalloc_node_track_caller_noprof+0x2a2/0x730
   kmemdup_noprof+0x25/0x50
   ntfs_fill_super+0x1e5/0x4550
  [...]
  Freed by task 97:
   kfree+0x1db/0x5b0
   put_fs_context+0x13c/0x7d0
   path_mount+0x54a/0x2130
   __x64_sys_mount+0x20c/0x270

That info is needed in rcu lookup in the dentry hash and dentry compary
methods for ntfs3 and causes a UAF today. Delay freeing with an rcu
grace period.

ntfs_nls_to_utf16() reads ->nls and ->ads once under rcu_read_lock() so
the hooks pair with the release in ntfs_fs_reconfigure(). That also
covers callers outside of rcu pathwalk such as ntfs_lookup(). They don't
hold rcu_read_lock() themselves and wouldn't be protected by the grace
period otherwise. Remount refuses to change the iocharset so ->nls stays
valid after rcu_read_unlock().

Fixes: a3a956c78efa ("fs/ntfs3: Add option "nocase"")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261009-work-fixes-rcu-v1-8-7446d2d335e6@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index eb9152e9fa22..14ca54e54578 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -186,11 +186,20 @@ int ntfs_nls_to_utf16(struct ntfs_sb_info *sbi, const u8 *name, u32 name_len,
 {
 	int ret, slen, i;
 	const u8 *end;
-	struct nls_table *nls = sbi->options->nls;
+	struct ntfs_mount_options *opts;
+	struct nls_table *nls;
+	bool ads;
 	u16 *uname = uni->name;
 
 	static_assert(sizeof(wchar_t) == sizeof(u16));
 
+	/* ntfs_fs_reconfigure() may replace the options, but not ->nls */
+	rcu_read_lock();
+	opts = READ_ONCE(sbi->options);
+	nls = opts->nls;
+	ads = opts->ads;
+	rcu_read_unlock();
+
 	if (!nls) {
 		/* utf8 -> utf16 */
 		ret = _utf8s_to_utf16s(name, name_len, endian, uname, max_ulen);
@@ -230,7 +239,7 @@ int ntfs_nls_to_utf16(struct ntfs_sb_info *sbi, const u8 *name, u32 name_len,
 
 	uni->len = ret;
 	uni->ads_len = 0;
-	if (ret > 0 && sbi->options->ads) {
+	if (ret > 0 && ads) {
 		uname = uni->name;
 		/* Find delimiter in range [1 : ret-2). */
 		for (i = 1; i + 1 < ret; i++) {
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index bbcd2e02bf63..44d59b444648 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -91,6 +91,8 @@ enum utf16_endian;
 struct ntfs_mount_options {
 	char *nls_name;
 	struct nls_table *nls;
+	/* ->d_hash() and ->d_compare() read the options in rcu pathwalk */
+	struct rcu_head rcu;
 
 	kuid_t fs_uid;
 	kgid_t fs_gid;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 841f9068d82f..58ef6be3286b 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -251,6 +251,11 @@ static inline void put_mount_options(struct ntfs_mount_options *options)
 	kfree(options);
 }
 
+static void put_mount_options_rcu(struct rcu_head *head)
+{
+	put_mount_options(container_of(head, struct ntfs_mount_options, rcu));
+}
+
 enum Opt {
 	Opt_uid,
 	Opt_gid,
@@ -444,6 +449,7 @@ static int ntfs_fs_reconfigure(struct fs_context *fc)
 	struct super_block *sb = fc->root->d_sb;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	struct ntfs_mount_options *new_opts = fc->fs_private;
+	struct ntfs_mount_options *old_opts;
 	int ro_rw;
 
 	ro_rw = sb_rdonly(sb) && !(fc->sb_flags & SB_RDONLY);
@@ -473,7 +479,15 @@ static int ntfs_fs_reconfigure(struct fs_context *fc)
 	}
 
 	sync_filesystem(sb);
-	swap(sbi->options, fc->fs_private);
+	old_opts = sbi->options;
+	/* pairs with the READ_ONCE() in ntfs_nls_to_utf16() */
+	smp_store_release(&sbi->options, new_opts);
+	fc->fs_private = NULL;
+	/*
+	 * ntfs_d_hash() and ntfs_d_compare() of a pathwalk in rcu mode may
+	 * still read the old options through the sbi.
+	 */
+	call_rcu(&old_opts->rcu, put_mount_options_rcu);
 
 	return 0;
 }

