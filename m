Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363930;
	b=GwmnjgoOiQUe2NM0GzNKxDytufjIXaT5bsYzkkJ+fTfW/kOh3S8Wr8pU6+Mp33l4sbfa
	 RLi5uVs9J2gXZVmOkl9FoZ7eis18ijx+Gh7xmpKE1lnTbtwY7ECsIlg6CcsDLgdefjz/D
	 UJZGC5ot1u60JOE6zFhjqfGxtCjsxD8jiFpTISNTbz8+pOSZ4BXKNh0zohGplL7DK8Gi8
	 KKTjcSwKfa7aBGCWcACzdOzNF/HFvY8ti1WpRNBwcDgMuOs8CguuXa/c7OH4jNYDvQU6y
	 0eTjtXIJFcMVflu6nZZl1jItSjQjPEHCUubjhWES/8oqcoPJnrUCfDgewfbXeRq5n2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363930;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=W8Bqt19jQKnBl13PUewVE+0aaIqmV/mxnsKiXjHXnqg=;
	b=tJHVSMOs47eBIOS1k7VXjNsgf+DhPxjdISS79p81Dp7+knqHH/VOX6pVzTYX9CH7/eph
	 Z4ox0U/yRlxAKirvKvkmXZ/Wek3wLaQf5A272MacCx/neuESakvEUus0sDyUTQtmvK1EH
	 15GXyLcIEZifBYOQuMQ7huBczxPxJguSxXrv0pZHCqc5of904rFWXWq95fRGdu/W+ShbH
	 rM+Lf32pQjJ/H5Ptc77x2zt0W54WsIbR4c7o6zvXpnWT7lKY62vcPzpovQaOOVblYsvLX
	 Ea8gjWKBeo9f+pexQxv3AhaYjojutQ0U7GQMREElJme50T23CXg5LWzm35t1jNQijQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJggAzD4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CF8606A31D;
	Fri, 30 Oct 2026 12:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJggAzD4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6C51F00A16;
	Fri, 30 Oct 2026 12:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793363930;
	bh=W8Bqt19jQKnBl13PUewVE+0aaIqmV/mxnsKiXjHXnqg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HJggAzD4PQlB3X8f1gUJXNR9jMvWPP/c3TuCsgFnPKu8HdBBRi6GwVbV83RqoX81E
	 hyzzdN7Nb8RbFWP711f1e1OP3zoUwcKJ3oPt1Vbr0IbC0qXFlsjG/RExkF/kA44fpv
	 kkIJ11CvT5YO18P7T58lBD7PrwXTYed1zDnSVhwBIg1a/a3JbM4p/+jdbzYGXQi2Jc
	 KMiVL20k2vnuqpZwZmVI3lBUvGuEEym1a8fiU/qjfbBcC6xMNIiu6ghCF4aUwzT/k9
	 mmX1sOflvoZDI/GJU1HS6AR3cxEgCKnUR4BioPQOoKF+fiKHyi3nFz3cIv4dNnYVnd
	 NGREWXPEqZH9w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Oct 2026 13:38:24 +0100
Subject: [PATCH 3/3] dcache: let umount find a disconnected ex-mountpoint
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-work-dcache-ai-v1-3-cd6b86e0ccc7@kernel.org>
References: <20261030-work-dcache-ai-v1-0-cd6b86e0ccc7@kernel.org>
In-Reply-To: <20261030-work-dcache-ai-v1-0-cd6b86e0ccc7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Karl Mehltretter <kmehltretter@gmail.com>, 
 Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4036; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6409oWCeBJepy7ZP27TjzDxlqAoguHTVft15pL8mJ8U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ96T8f/yozfkXtA2PObKWgnJOd/F84S26s+ijsM2vfS
 j2W2z6vO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby7igjw6uVoTO5j506sNCC
 5YG/0oOFLiHtJTqv19ZvFm31+brYyo2Rocm3tkk3IWv5qQ1L+P3kV3/Vdn6aa9H1e+aaj4FPbC+
 uZwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

From: Josef Bacik <josef@toxicpanda.com>

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
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/dcache.c                    | 16 ++++++++++++++--
 include/linux/fs/super_types.h |  2 +-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c1d8b398b2d1..f902936e38d5 100644
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
@@ -1102,7 +1103,18 @@ void dput_to_list(struct dentry *dentry, struct list_head *list)
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

-- 
2.53.0

