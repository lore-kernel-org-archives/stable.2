Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C39445AC6
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454075; cv=none; b=qgs3g0NxutBefQMmmS4M4+nSs1XzF0HibnXIICy0sNt0cyk/i5nrIS0+ugh8osIDcMJOQeFlVonj2vJyuUp2Ud/k4O7SOkZDJtPL8Ei0XHtlXI1AKQPmWPnGNvLZbi6nYX5u8oq13P9TbMYOJrRyPmiPc+uXVdkrs2rwnQGorrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454075; c=relaxed/simple;
	bh=or0BLZci4f9yMtR+DB1r5QFBM9QtBw2XMiyBWbDukA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGl3oCbkGc4wUXuHtwTnZ2lbLuq19L+TKDsuibjFRM/sx1MT5Z0tcD/OWZvl4s1X9aeZzuBjWzURKga7upGCm7Lq26zkmvwDxK41jLN7mtQY9kgmW7rJYnWTLzkkXVyzpN8cTKg4IyBDhemoP1EESMLX7b+m7o2Jt8lBlWGVvB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evkJDAyk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evkJDAyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673461F000E9;
	Tue, 11 Aug 2026 13:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786454072;
	bh=Y6Dh5E6hMW07czWScdWvGVDR7rkV6dwOZWkLX9d7qec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=evkJDAykmoCE5OUbnxjv7n9wJFGzv3pSkSr1JfSLQTVBCg7DivvMcxvq0dIURv9S6
	 rQyhrMdQuHR4x94feI3QOep7J280QACDkcKTVKEFtpws+eOEhgrslO4lPEEvzxR+4j
	 VVLt0oMhvSO8EjKMN3QNh9UrqkvsQ/I9fekQkPCF/bKR1MopSqLlfguh7aQl0yEzVU
	 6zcYRYJShPuztF0OKS9YIa1/N6Oi0Lo3Y3VEE68SbQh1X1ZZl1lOivwq6KtzPEcKi0
	 C/oE9rnrXByDKsdxSJnUy9pQXnHLcQigS4ArQ0A0sq4ZNOJxvfLdHEDOhOhu9ME6Yn
	 i3Q7NeuAxuBEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] binfmt_misc: don't leak the user namespace when the mount fails
Date: Tue, 11 Aug 2026 09:14:28 -0400
Message-ID: <20260811131428.2547654-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080520-echo-amplifier-ef92@gregkh>
References: <2026080520-echo-amplifier-ef92@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit b8206f516fe7cbe785cf44bf09c17c438d7c3cad ]

bm_get_tree() takes a reference to the user namespace and hands it to
get_tree_keyed() as the sget key. sget_fc() moves that reference into
sb->s_fs_info and clears fc->s_fs_info, so from that point on the
superblock owns it and bm_free() doesn't see it anymore.

The superblock drops it in ->put_super(). But generic_shutdown_super()
only calls ->put_super() from inside the if (sb->s_root) branch, so
nothing releases it when bm_fill_super() fails:

- The kzalloc_obj() failure leaves s_root NULL and the whole branch is
  skipped.

- A simple_fill_super() failure in the file loop leaves s_root set, but
  s_op still points at simple_super_operations, which has no
  ->put_super(). bm_fill_super() installs s_ops only once
  simple_fill_super() returned success, and installing it earlier
  wouldn't help either because simple_fill_super() overwrites s_op.

Either way vfs_get_super() calls deactivate_locked_super() and the
reference is gone for good. binfmt_misc mounts are available in a user
namespace and both the inode and the dentry cache are SLAB_ACCOUNT, so
an unprivileged caller under a tight memory cgroup can fail
simple_fill_super() on demand and leak one user namespace per attempt.

Drop the reference in ->kill_sb() instead, which runs unconditionally,
the same way nfsd and rpc_pipefs release their keyed s_fs_info.

That also stops ->put_super() from clearing s_fs_info while the
superblock is still on @fs_supers. generic_shutdown_super() leaves it
there on purpose so that sget_fc() keeps finding it until kill_sb() has
run, but a NULL s_fs_info makes test_keyed_super() miss it, so a
concurrent mount for the same user namespace skips the grab_super()
wait and creates a second superblock for a namespace that is still
being torn down.

Link: https://patch.msgid.link/20260728-work-binfmt_misc-usernsleak-v1-1-dbd8d5e626e7@kernel.org
Fixes: 21ca59b365c0 ("binfmt_misc: enable sandboxed mounts")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/binfmt_misc.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 5edc41bb100ec..8239a831ece8d 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -928,18 +928,9 @@ static const struct file_operations bm_status_operations = {
 
 /* Superblock handling */
 
-static void bm_put_super(struct super_block *sb)
-{
-	struct user_namespace *user_ns = sb->s_fs_info;
-
-	sb->s_fs_info = NULL;
-	put_user_ns(user_ns);
-}
-
 static const struct super_operations s_ops = {
 	.statfs		= simple_statfs,
 	.evict_inode	= bm_evict_inode,
-	.put_super	= bm_put_super,
 };
 
 static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
@@ -997,13 +988,12 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
 	/*
 	 * When the binfmt_misc superblock for this userns is shutdown
 	 * ->enabled might have been set to false and we don't reinitialize
-	 * ->enabled again in put_super() as someone might already be mounting
-	 * binfmt_misc again. It also would be pointless since by the time
-	 * ->put_super() is called we know that the binary type list for this
-	 * bintfmt_misc mount is empty making load_misc_binary() return
-	 * -ENOEXEC independent of whether ->enabled is true. Instead, if
-	 * someone mounts binfmt_misc for the first time or again we simply
-	 * reset ->enabled to true.
+	 * ->enabled again during shutdown as someone might already be mounting
+	 * binfmt_misc again. It also would be pointless since by then we know
+	 * that the binary type list for this binfmt_misc mount is empty making
+	 * load_misc_binary() return -ENOEXEC independent of whether ->enabled
+	 * is true. Instead, if someone mounts binfmt_misc for the first time or
+	 * again we simply reset ->enabled to true.
 	 */
 	misc->enabled = true;
 
@@ -1029,6 +1019,14 @@ static const struct fs_context_operations bm_context_ops = {
 	.get_tree	= bm_get_tree,
 };
 
+static void bm_kill_sb(struct super_block *sb)
+{
+	struct user_namespace *user_ns = sb->s_fs_info;
+
+	kill_litter_super(sb);
+	put_user_ns(user_ns);
+}
+
 static int bm_init_fs_context(struct fs_context *fc)
 {
 	fc->ops = &bm_context_ops;
@@ -1045,7 +1043,7 @@ static struct file_system_type bm_fs_type = {
 	.name		= "binfmt_misc",
 	.init_fs_context = bm_init_fs_context,
 	.fs_flags	= FS_USERNS_MOUNT,
-	.kill_sb	= kill_litter_super,
+	.kill_sb	= bm_kill_sb,
 };
 MODULE_ALIAS_FS("binfmt_misc");
 
-- 
2.53.0

