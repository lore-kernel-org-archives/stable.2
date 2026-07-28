Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3AD443E56;
	Tue, 28 Jul 2026 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246504; cv=none; b=q1oLETCdm74nNmW9wl17UXMffkGojQ0oOgKRAm30+VuuxBdhp5XcqiBIMIvGlwmh2uWl5cBXeiQkOM/gVOppy2BzYtmdRjnL/UOudSxczHLi0amvaUvtVw4tf4fiZouKaE/c3dD+1c7XXjcEa0c6/NP+KCDw7z2bLyGUeKrTQAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246504; c=relaxed/simple;
	bh=GfZf4OtiPvKmem6JowvFOniZu3fnPQf7hYId+0iuxks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fruw2jFtMgLScRWQ8++KCcbfGvKB69cnYx/DBau3SvNVbT5CwuoTLz6EMJeUHA6RIkOism71Ic4mXly/eFTpTZqu3omEiJllLAtCMyrA2zCY44BoZZFNTI8D7SImQirKvMgN2xBF6JE0uUznoTKuX6tInJdCt8q2dLpTVtq+ffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzSj2fnz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzSj2fnz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF851F000E9;
	Tue, 28 Jul 2026 13:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785246503;
	bh=M13c9yrS8i19jL6P1wyYS28jNcW+SVKbY4SPV3JN170=;
	h=From:Date:Subject:To:Cc;
	b=LzSj2fnzFxkDQEz0jAWTEyWdwJtEYTd+w6PpGK9wNAweCVLTU9kBuXBPTm6CFhePi
	 SdU6U98d4FV7WPFrgkswIAfexxvtPTuYw/uEXSQ1yeKRieh2ln0Osk1eRTA98LtnvX
	 JCaHRHIPqUG4MPJO6IUZVt9P9NnCLlvV37ldL1joUcAj2iu7XwNjCF+rK5qyVzJxu6
	 CRNJameCmxNuxLBnMxlw4Kh0p+5vqgAEHFzJYsL/TGLmv+BY4jve/L5d3b7/L/4Awu
	 lbDFiMlSpjFAKqAE5YtH01mk7uQmVPdt7v4gY9FR0X+vQ90tV+CiotyDVixQ1AqmqX
	 pwiUMRxgBhN9Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Jul 2026 15:48:10 +0200
Subject: [PATCH] binfmt_misc: don't leak the user namespace when the mount
 fails
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-work-binfmt_misc-usernsleak-v1-1-dbd8d5e626e7@kernel.org>
X-B4-Tracking: v=1; b=H4sIABmzaGoC/yXM3Q6CMAyG4VshPbYGF8WfWyHGrLOTigyzApoQ7
 t1NDt+m3zODchRWuBQzRJ5EpQ8pdpsCXGPDg1HuqcGUpiqP5oSfPrZIEnw33DpRh2MSgr7Ytui
 M2fPhXBGThSS8I3v5/vX6uraO9GQ3ZDJ/kFVGija4Jp8mr9t1sSw/f1SaopsAAAA=
X-Change-ID: 20260728-work-binfmt_misc-usernsleak-c224e596beba
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 Farid Zakaria <farid.m.zakaria@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 bpf@vger.kernel.org, jannh@google.com, mail@johnericson.me, 
 stable@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-cca4b
X-Developer-Signature: v=1; a=openpgp-sha256; l=5088; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GfZf4OtiPvKmem6JowvFOniZu3fnPQf7hYId+0iuxks=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlbFbhnyO8/+nWyrYq9wz588vSZ791rj+53Pvo6/cZn
 lFvHiz+0lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARVTFGho/bPKKvBacxK99s
 eF144ZaL45d5DSZ6zTWc39JVbW6yBjEyTOIw0vT0dQtVfJ34Z9ka/+YcxtW2x+NSfOLea0S8PXu
 WBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

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

Fixes: 21ca59b365c0 ("binfmt_misc: enable sandboxed mounts")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Note for stable: this applies as-is only from v6.19 onwards. Before
7beafd51c4e1 ("convert binfmt_misc") ->kill_sb is kill_litter_super()
and bm_kill_sb() has to call that instead of kill_anon_super(): back
then simple_fill_super() left the dentries it created pinned and
d_genocide() is what drops them. Taking this patch verbatim on v6.7 to
v6.18 turns every binfmt_misc umount into a "Dentry still in use"
BUG() in shrink_dcache_for_umount().
---
 fs/binfmt_misc.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index a73a37b8a013..c97f10b48b5b 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -921,18 +921,9 @@ static const struct file_operations bm_status_operations = {
 
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
@@ -990,13 +981,12 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
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
 
@@ -1022,6 +1012,14 @@ static const struct fs_context_operations bm_context_ops = {
 	.get_tree	= bm_get_tree,
 };
 
+static void bm_kill_sb(struct super_block *sb)
+{
+	struct user_namespace *user_ns = sb->s_fs_info;
+
+	kill_anon_super(sb);
+	put_user_ns(user_ns);
+}
+
 static int bm_init_fs_context(struct fs_context *fc)
 {
 	fc->ops = &bm_context_ops;
@@ -1038,7 +1036,7 @@ static struct file_system_type bm_fs_type = {
 	.name		= "binfmt_misc",
 	.init_fs_context = bm_init_fs_context,
 	.fs_flags	= FS_USERNS_MOUNT,
-	.kill_sb	= kill_anon_super,
+	.kill_sb	= bm_kill_sb,
 };
 MODULE_ALIAS_FS("binfmt_misc");
 

---
base-commit: 61d2304c0f286fe4a14ec6cee87588350c276d02
change-id: 20260728-work-binfmt_misc-usernsleak-c224e596beba

