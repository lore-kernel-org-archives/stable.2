Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE194156FB
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923886; cv=none; b=j4yNrxz3Ru+1CajLWuS9lM6E7y6a0nSUhC6Ubj47rd1CB5UH9V+suMKXFMVYPHlsiEMkrWvPzp7UTtp1tytGqiOl0Jp7eekjoaZ/hoygedCjw+2eMYqFvpgkGZEdXKWPNpRBCRDv1Lwg0j4EBGO6PHbJt2zLtz5u9YiM4DZRlWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923886; c=relaxed/simple;
	bh=zjqXhcu8DxdCnfPEPPmkZxBMB6iXeBxr81oFhTCOz/w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WHIHaFVNWR54VzLr7Fhu/hLP+ihUIxmoD2gY/8htG0J8GDUNrNhkMu7Hgim7HH6p9iWphuOOrTZxYbDKapBewBgyeF1eC/LwJ9/n/8Ox6M1qM8oEUkLDnmREPJfF55xx8lMEhSxoAgf0xU/jIS6wCUDq2k37BgTwvOzoA+LThmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eA9RylY3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eA9RylY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1582A1F000E9;
	Wed,  5 Aug 2026 09:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785923884;
	bh=Bnw5HCJtUZQsGwGPUZ4A6wXuoFhFD4oMLiS9x1X6PBU=;
	h=Subject:To:Cc:From:Date;
	b=eA9RylY3ciKXFEHH5oVpXgB91YW//Fx4D+j7v7cw9GvvHOvGw+ZVES31n38UdRgh5
	 cFQELmqryVaWpZ6PtFSnprAkxz4kOTsPGVw3tsxnv4Y1fka7UV5Kth2Tm5PAPDnxPD
	 axqe8K7b/5HmLiICJfJu/sL9/nqHpwkE6bwOtzO4=
Subject: FAILED: patch "[PATCH] binfmt_misc: don't leak the user namespace when the mount" failed to apply to 6.18-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:53:20 +0200
Message-ID: <2026080520-echo-amplifier-ef92@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x b8206f516fe7cbe785cf44bf09c17c438d7c3cad
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080520-echo-amplifier-ef92@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b8206f516fe7cbe785cf44bf09c17c438d7c3cad Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Jul 2026 15:48:10 +0200
Subject: [PATCH] binfmt_misc: don't leak the user namespace when the mount
 fails

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
 

