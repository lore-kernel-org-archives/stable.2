Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3768030DEBA
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454705; cv=none; b=bNY3rIj+XQIkxZIucwIY3QzbhN9dDJlm6s903ga0UNIkYjypVeSF+5Q1UrMKNlpet3WBvbX+eW5R3+gPfo4FfKldTQiiDhJAQOnXSXE0Kq0NTqGEju1DhJqIKACGeRRiI9nfyPDWXudbdpem32Cph9um3bVFDTbEzKtoRLKNjP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454705; c=relaxed/simple;
	bh=0PsAe3zXNkpGRytx3fN50js3GjA9NXfOGzNwvwichVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cu9IgsAy1W0vkQI4HbrjMJTjLVWXnRMbhdNR6lMv7ea8VFOxUUVkiQowyzKpRWz4GpyEARWOKq9ozM8eprVUARcX9WHW9w7GSfYmf3EmSekRKJCuOm9GsH90bGp3aU8tEzoAPsHvhDK9fiyZK0KLwm5vdIzD9aVfcSEtvtCl86g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJnCN+Ii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJnCN+Ii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1760F1F000E9;
	Tue, 11 Aug 2026 13:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786454703;
	bh=FOzrysghneOEwOZdZE8aNsFh+m88DY+5/U7ydBZMHCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nJnCN+IiosQ2F7GKdrHbum2shHIXP/ZYO8Tv306xoEqbT+QiBRjSLBDyX23AmeVj7
	 /mjXqaPZdhtYuZeyltTANp1ILiIfVgi/cOsF8R3maa41pLxru2/GGk1PikJKVps9Vl
	 cNSp58UnsPvQNXih9CpyP4yQaF1Qjct8AsmoG88RicHVdsNEsbe4mTWr+DIFp/BPEh
	 5q8oxq9+J1bp0WhVwMt2/inqxcZ3s9ShOeV884y6y1dArXMatH7qxO8iqwb+0BpB+W
	 wa+R//EJuulvvkXCYdzu9/MO1vbsvbN/F9A7ORBnPDM8fwmJYPeFP8JaYoMhllmirT
	 I2Zy9rj2wSvBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] binfmt_misc: don't leak the user namespace when the mount fails
Date: Tue, 11 Aug 2026 09:25:01 -0400
Message-ID: <20260811132501.2570009-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080521-kissing-decree-6a90@gregkh>
References: <2026080521-kissing-decree-6a90@gregkh>
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
index f85ee577c34d6..9ef7311d1c110 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -958,18 +958,9 @@ static const struct file_operations bm_status_operations = {
 
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
@@ -1027,13 +1018,12 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
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
 
@@ -1059,6 +1049,14 @@ static const struct fs_context_operations bm_context_ops = {
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
@@ -1075,7 +1073,7 @@ static struct file_system_type bm_fs_type = {
 	.name		= "binfmt_misc",
 	.init_fs_context = bm_init_fs_context,
 	.fs_flags	= FS_USERNS_MOUNT,
-	.kill_sb	= kill_litter_super,
+	.kill_sb	= bm_kill_sb,
 };
 MODULE_ALIAS_FS("binfmt_misc");
 
-- 
2.53.0

