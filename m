Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598782;
	b=n9Xu+gDkJ5E+V+laNndJMCJ75LGKLYn2JU7QAdjXEJyz9VOt7nwoe/h8ev6bYFhMB+BH
	 asjNPZ8hMjXVsui7Gd705IanzYL/PNknHzTugZzAfrsWqEmgrWgnqqqHiPBk76cTWK4aG
	 A7KzHKS3ZajK0VZ+m3w1ZGA8V4gmgj2VBev0s4vU1rEOVorcoy3689XhFzwiLrlgx31Fw
	 iumQo7Vq3Sz8u5/OeacxSszwKxEW2oxxweZrk3y9Zh3bjcugFpbtpAGLZ+w3w1mvzFoP1
	 lYM7hP5Gq9FwyG0HR3XGKp6wyOQus4S0o0AeDqdzsySTvRsoOsPtmKgsf8I06CDQpBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598782;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4WH4I5X78CjWTxHCZHCAgxDX2PibC1Y/6mp3Q6vWd5M=;
	b=t8ZCYgualGRWZTgO8GTI/jp/gWRddh0z+YgqvPdYb6u0edSou8u6s5Ct1GfGnM/1d26E
	 Ef9/xlled/bMyPi3jJ8eCvr2USP3j1aUR9q98UeF/PdkwX9G7i8CJBmZ53fEbO0RAiFnb
	 872XDNBwoCD7l8I9gQzDrsilhJ4OEslB/PHrXGfb9uRSAXursxlbLwK55yuzqC44xrW2l
	 CxlzEiX9LbgOitbSzT3ndZZaqkgsONdtFFNgs29VUBmP6VF+LlW/cejZLnrojsJ/j4J52
	 8wmmJ0EaQLdkhaM3L8J6ZSC6cYZlSn3dkzwsdw0eM4sYu8NwFX/h2HZreiBtEHVhPlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="x4/mcZ8I";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE49606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=x4/mcZ8I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C681F000C4;
	Wed, 25 Nov 2026 09:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795598782;
	bh=4WH4I5X78CjWTxHCZHCAgxDX2PibC1Y/6mp3Q6vWd5M=;
	h=Subject:To:Cc:From:Date;
	b=x4/mcZ8ILCUGV1Hg0fXP6nHMw7ilfbO9r/B5KxOOHGRgbLL5HgwHLwFkrk2r9SZww
	 7KwJxsSRH02y3ahtR2GnPufgJTnt+L0RWkfx+S5IMe8ypjh9pIxgIzxdg0XPa5izYS
	 OVkxqvIs352ScHjlqtdLlujZ1h4NYjmCAwIQ31co=
Subject: FAILED: patch "[PATCH] dcache: let umount find a disconnected ex-mountpoint" failed to apply to 6.18-stable tree
To: josef@toxicpanda.com,brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:19:45 +0100
Message-ID: <2026112545-encrypt-friend-e924@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 32e564e222b7ca3811b2acee404b73fcaf43f312
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112545-encrypt-friend-e924@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 32e564e222b7ca3811b2acee404b73fcaf43f312 Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 30 Oct 2026 13:38:24 +0100
Subject: [PATCH] dcache: let umount find a disconnected ex-mountpoint

When a mount goes away the reference to its mountpoint is dropped with
dput_to_list() and namespace_unlock() evicts the dentry after dropping
namespace_sem. Nothing pins the filesystem at that point so it can be
unmounted at the same time. That's fine as long as
shrink_dcache_for_umount() finds the dentry. It then either evicts it
itself or waits for the eviction to finish.

But it can't find a disconnected root as those are neither in the tree
nor on ->s_roots. And they can be mounted on:

  fd = open_by_handle_at(mnt_fd, handle of a file with no dentry, O_PATH);
  tree = open_tree(AT_FDCWD, "/tmp/x", OPEN_TREE_CLONE);
  move_mount(tree, "", fd, "", MOVE_MOUNT_F_EMPTY_PATH |
			       MOVE_MOUNT_T_EMPTY_PATH);
  close(fd);

  thread A                              thread B
  umount2("/proc/self/fd/<tree>", MNT_DETACH)
    namespace_unlock()
      up_write(&namespace_sem)
                                        umount of the filesystem
                                          shrink_dcache_for_umount()
                                          evict_inodes()
                                          "Busy inodes after unmount"
      shrink_dentry_list()
        dentry_kill()
          iput() of an inode of a superblock that is gone

So put such a dentry on ->s_roots when it's put on the shrink list. From
then on it's a secondary root like any other.

This needs the previous patch. Otherwise do_one_tree() takes the dentry
off ->s_roots and umount doesn't wait for an eviction in progress.

The stable tag is narrower than the Fixes tag on purpose. Before commit
e9895609cb7f ("wind ->s_roots via ->d_sib instead of ->d_hash") umount
doesn't wait for a secondary root that is being evicted either.

Fixes: 4edbe133f851 ("make struct mountpoint bear the dentry reference to mountpoint, not struct mount")
Cc: stable@vger.kernel.org # v7.2+
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Link: https://patch.msgid.link/20261030-work-dcache-ai-v1-3-cd6b86e0ccc7@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/dcache.c b/fs/dcache.c
index 6279bfcf3507..228a853c3969 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -45,7 +45,8 @@
  * dcache_hash_bucket lock protects:
  *   - the dcache hash table
  * s_roots_lock protects:
- *   - the s_roots list (see __d_move()/dentry_unlist()/d_obtain_root())
+ *   - the s_roots list (see __d_move()/dentry_unlist()/d_obtain_root()/
+ *     dput_to_list())
  * dentry->d_sb->s_dentry_lru_lock protects:
  *   - the dcache lru lists and counters
  * d_lock protects:
@@ -1117,7 +1118,18 @@ void dput_to_list(struct dentry *dentry, struct list_head *list)
 {
 	if (likely(fast_dput(dentry)))
 		return;
-	__move_to_shrink_list(dentry, list);
+	/*
+	 * The list owner need not pin the superblock, so make a disconnected
+	 * root a secondary one for shrink_dcache_for_umount() to find.
+	 */
+	if (__move_to_shrink_list(dentry, list) &&
+	    unlikely(IS_ROOT(dentry) && hlist_unhashed(&dentry->d_sib))) {
+		struct super_block *sb = dentry->d_sb;
+
+		spin_lock(&sb->s_roots_lock);
+		hlist_add_head(&dentry->d_sib, &sb->s_roots);
+		spin_unlock(&sb->s_roots_lock);
+	}
 	spin_unlock(&dentry->d_lock);
 }
 
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index 72f4288e16c5..6ce105fe8359 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -173,7 +173,7 @@ struct super_block {
 	struct unicode_map			*s_encoding;
 	__u16					s_encoding_flags;
 #endif
-	struct hlist_head			s_roots;	/* alternate root dentries for NFS */
+	struct hlist_head			s_roots;	/* alternate root dentries for NFS and ex-mountpoints */
 	spinlock_t				s_roots_lock;
 	struct mount				*s_mounts;	/* list of mounts; _not_ for fs use */
 	struct block_device			*s_bdev;	/* can go away once we use an accessor for @s_bdev_file */

