Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197869;
	b=svgPkdK5yw/4Bob6eCdgCTXqgAbnZa1c/S2ZVNThxw1bYzF9o8fqZ75ZnFh4OjUfRFTi
	 IvTKDUov//yA4a/BtiTQ915a3NR5rnFZroQ9q9/51xa8QKf+CQgHxnu2UrPNvIBC/fLAU
	 dF8i4X1mVVEq005oBBFnjz75U6MEuT5e0Td/G20nYKR3OYq5Sl5a0h3CTqXUDSz6TiU7u
	 WaIvd+JwmtHBrRD/oaXVr9HEJcXrDSUer4Ji1uBKKv3xeo5nzPHOmHNv3CGJz0YPboX+n
	 +OVFX/qZAr276/olDJo/dDp6l3PgJgUEw22htFRhcQnKc7jEkXMAnNaW+p7CpPqZf5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197869;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=J0QK1OpEj8MOc+a4Z8C3tyBKSqbXKVT+nLcJzaXcaM4=;
	b=ETjVwwppzDpbmqBtpA92AmxCWw0tekqelFDIJQYtrEIbv77pXWRjfJHL/dBfEck7Toef
	 ZJKQgLD0mo33foNwdgYqfrSfsiXfrQ9mPmVHKWytmRmFh7WAbFpwaZMQSbILVuCunLveT
	 02YrPlonBRnwGFf8OtEpsOzQlaZekZ5cK9vWnZwZ+IBLcmQ2oomNpaP6qhKdwRZZz+W52
	 Dfr7wFpKSWsfXa7qs2fkdkBRl6iGBizcXpifYr6TZd/eclN78Xil0WhnDJZ1ciGaRK0a7
	 OOah+o4dI76+hbWKbFQVyS6F0w59Pf8vH5rBmY+mwgS2yBm0qcTkDwp+kZ/RppXy5PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WHQ0DFE+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F68606A31A;
	Wed, 28 Oct 2026 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WHQ0DFE+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF52E1F01825;
	Wed, 28 Oct 2026 14:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793197868;
	bh=J0QK1OpEj8MOc+a4Z8C3tyBKSqbXKVT+nLcJzaXcaM4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WHQ0DFE+ngDULGY7SoOzQLb5JEeGdErVNhDqVG1i02G6JyRlVlF9azX9OwFZmKojv
	 MeyuPm9MErnp2nd52ldGNYSE2ga10rvgxgRMwHUJGi4/gVZ5jt0hnKty5GImpszU2R
	 +T1qf5AobyIKmXo90/2APMAugzQr6j5zy7Tkv9ON72gm4fhGUbVhfEft/h7k+ikkhP
	 XiM1xMtRM2u0PXJqoQqZYddBlaDgmfF9q8jZXnpuDH8mXwMIz07IIB4cKOQtOO/lb9
	 1ZdPEZeiG17zqifcu6Cyrppc/r0LL/VKfTbFZVerzTodNOU0yIXKpMLwx2vG+ifWAo
	 UkCDyyb2Lr4Hw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 28 Oct 2026 15:30:38 +0100
Subject: [PATCH 2/4] namespace: don't reveal overmounted dentries that lost
 their mounts
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
Message-Id: <20261028-work-mount-trap-b4-v1-2-f20d9d0730d6@kernel.org>
References: <20261028-work-mount-trap-b4-v1-0-f20d9d0730d6@kernel.org>
In-Reply-To: <20261028-work-mount-trap-b4-v1-0-f20d9d0730d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <miklos@szeredi.hu>, NeilBrown <neil@brown.name>, 
 Chris Mason <mason@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=13718; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tzex1Pf4Ujz5WK1WW7OeAJREF7TfOH74Zx9frE/CfhQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9Ylep+bjU8t9MqRVzn/jExbVpX7nJYRl3/E6BcXlS7
 L8nHA1LO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyVZ2RYXe1ys5/s6+tkVs0
 qTJ+l11v+fVNpR+jT1y/9To6fGbHn+uMDG2szdo9r/ImzBXZ9y3YWu2DZlAb478tr80Tz1VdlOs
 6wAcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

unlink(), rmdir() and rename() may remove a name that is a mountpoint in
another mount namespace. The mounts on it are detached and the dentry is
unhashed.

But a lookup that found the name before the removal still holds the
dentry. If it takes the mount step after the mounts are gone it ends up
on what they covered. And as is customary, FUSE makes that window as
wide as the server wants.

An earlier variant tried to catch this in the refwalk but it's brittle
as hell. So fix it in the mount handling of lookup itself. The remover
marks the dentry with DCACHE_CANT_MOUNT before it detaches the mounts.
DCACHE_MOUNTED is kept when the last mount leaves such a dentry so that
every walk still takes the mount step on it. We then let
__traverse_mounts() fail when the hash has nothing for a removed name
once it is unhashed. The walk is redone with LOOKUP_REVAL and can't find
the unhashed name again.

RCU lookup needs no changes. The unhash invalidates d_seq and a lockless
walk never grabs a dentry whose d_seq changed. So it ends up in the
refwalk on its own.

The trap only fires once the name is unhashed. Until __detach_mounts()
unhashes the name the mounts are still there and a walk through a mount
with nothing on the name must get the name itself. __lookup_mnt() stays
as it is because the propagation code must see nothing where nothing is
mounted.

One thing that the original connected mount stuff happily ignored is the
case of a mount on the root of it's parent. That's not reached by name.
The parent is a bind mount of the removed dentry and keeps working like
a file descriptor on it does. So such a mount stays as long as its
parent does and the trap skips the root. Covers on the root of their
parent stay for the same reason. All other covers are dropped as before.

A stale name loses all its mounts and covers in d_invalidate() as
before. find_submount() skips removed names since they keep
DCACHE_MOUNTED and d_invalidate() would loop on them forever. d_delete()
clears DCACHE_MOUNTED with DCACHE_CANT_MOUNT when nobody else holds the
dentry.

A walk that already holds the dentry didn't find a name and isn't
trapped. That specifically means ".." from below, ".." at the root of a
chroot or of an openat2() walk with RESOLVE_IN_ROOT and the in-place
step of umount("."). They pass WALK_HELD to the mount step and work like
a file descriptor on the removed object does. This prevents any
large-scale userspace visible regressions.

nfsd and ksmbd get the ESTALE from follow_down() like every other
lookup. ksmbd with crossmnt answers ENOENT, nfsd NFS4ERR_STALE.

The reproducers of commit 528b383dc35d ("namespace: unhash a dentry
before detaching the mounts on it") and of the reverted refwalk check
(cf. [1]) and the stacked and self-bind overmounts in qemu, KASAN and
lockdep on, 8 CPUs:

                                                     before   after
  unlink_covered, 4 walkers, 60 s, SECRET reads           31       0
  unlink_symlink, 20 rounds, followed the symlink         20       0
  reval_reveal, read through the ESTALE link           UNDER  ESTALE
  stacked bind, root name unlinked or renamed over    SECRET    MASK
  self-bind race, 1000 rounds, SECRET reads               32       0

reval_reveal needs root and fuse. F is a fuse mount it serves itself
with the file f1 and the symlink lnk -> f1. F' is an open_tree() copy of
F with a tmpfs file mounted on F'/f1. The server answers the
revalidation of f1 in the LOOKUP_REVAL walk only after it had F/f1
unlinked, which detaches the mount. UNDER is the content of f1. With the
trap the open fails and the child prints "Stale file handle":

[1]: https://lore.kernel.org/linux-fsdevel/20261012-work-namei-reval-v1-0-515664de33b5@kernel.org

Fixes: 8ed936b5671b ("vfs: Lazily remove mounts on unlinked files and directories.")
Cc: stable@vger.kernel.org # v7.3+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/dcache.c    |  5 +++--
 fs/namei.c     | 36 +++++++++++++++++++++++++++---------
 fs/namespace.c | 50 ++++++++++++++++++++++++++++++++++++++++----------
 3 files changed, 70 insertions(+), 21 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index efd9332c8407..711b96cb0fed 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1862,7 +1862,8 @@ void shrink_dcache_for_umount(struct super_block *sb)
 static enum d_walk_ret find_submount(void *_data, struct dentry *dentry)
 {
 	struct dentry **victim = _data;
-	if (d_mountpoint(dentry)) {
+	/* Skip mounted and removed but still mounted dentries. */
+	if (d_mountpoint(dentry) && !cant_mount(dentry)) {
 		*victim = dget_dlock(dentry);
 		return D_WALK_QUIT;
 	}
@@ -2779,7 +2780,7 @@ void d_delete(struct dentry * dentry)
 	if (dentry->d_lockref.count == 1) {
 		if (dentry_negative_policy)
 			__d_drop(dentry);
-		dentry->d_flags &= ~DCACHE_CANT_MOUNT;
+		dentry->d_flags &= ~(DCACHE_CANT_MOUNT | DCACHE_MOUNTED);
 		dentry_unlink_inode(dentry);
 	} else {
 		__d_drop(dentry);
diff --git a/fs/namei.c b/fs/namei.c
index 0fa9a5b7b377..267a98af4742 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1565,12 +1565,20 @@ static int follow_automount(struct path *path, int *count, unsigned lookup_flags
 	return finish_automount(dentry->d_op->d_automount(path), path);
 }
 
+/* WALK_HELD: the walk holds @dentry already, it didn't find it by name */
 enum walk_flags {
 	WALK_TRAILING	= (1 << 0),
 	WALK_MORE	= (1 << 1),
 	WALK_NOFOLLOW	= (1 << 2),
+	WALK_HELD	= (1 << 3),
 };
 
+static inline bool mountpoint_removed(const struct path *path)
+{
+	return unlikely(cant_mount(path->dentry)) &&
+	       d_unhashed(path->dentry) && !path_mounted(path);
+}
+
 /*
  * mount traversal - out-of-line part.  One note on ->d_flags accesses -
  * dentries are pinned but not locked here, so negative dentry can go
@@ -1578,7 +1586,8 @@ enum walk_flags {
  * sufficient for ->d_inode and ->d_flags consistency.
  */
 static int __traverse_mounts(struct path *path, unsigned flags, bool *jumped,
-			     int *count, unsigned lookup_flags)
+			     int *count, unsigned lookup_flags,
+			     enum walk_flags walk_flags)
 {
 	struct vfsmount *mnt = path->mnt;
 	bool need_mntput = false;
@@ -1615,6 +1624,11 @@ static int __traverse_mounts(struct path *path, unsigned flags, bool *jumped,
 				}
 				continue;
 			}
+			if (!(walk_flags & WALK_HELD) &&
+			    mountpoint_removed(path)) {
+				ret = -ESTALE;
+				break;
+			}
 		}
 
 		if (!(flags & DCACHE_NEED_AUTOMOUNT))
@@ -1639,7 +1653,8 @@ static int __traverse_mounts(struct path *path, unsigned flags, bool *jumped,
 }
 
 static inline int traverse_mounts(struct path *path, bool *jumped,
-				  int *count, unsigned lookup_flags)
+				  int *count, unsigned lookup_flags,
+				  enum walk_flags walk_flags)
 {
 	unsigned flags = smp_load_acquire(&path->dentry->d_flags);
 
@@ -1650,7 +1665,8 @@ static inline int traverse_mounts(struct path *path, bool *jumped,
 			return -ENOENT;
 		return 0;
 	}
-	return __traverse_mounts(path, flags, jumped, count, lookup_flags);
+	return __traverse_mounts(path, flags, jumped, count, lookup_flags,
+				 walk_flags);
 }
 
 int follow_down_one(struct path *path)
@@ -1678,7 +1694,7 @@ int follow_down(struct path *path, unsigned int flags)
 {
 	struct vfsmount *mnt = path->mnt;
 	bool jumped;
-	int ret = traverse_mounts(path, &jumped, NULL, flags);
+	int ret = traverse_mounts(path, &jumped, NULL, flags, 0);
 
 	if (path->mnt != mnt)
 		mntput(mnt);
@@ -1732,7 +1748,7 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path)
 }
 
 static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
-			  struct path *path)
+			  struct path *path, enum walk_flags flags)
 {
 	bool jumped;
 	int ret;
@@ -1752,7 +1768,8 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 		if (unlikely(!try_to_unlazy_next(nd, dentry)))
 			return -ECHILD;
 	}
-	ret = traverse_mounts(path, &jumped, &nd->total_link_count, nd->flags);
+	ret = traverse_mounts(path, &jumped, &nd->total_link_count, nd->flags,
+			      flags);
 	if (jumped)
 		nd->state |= ND_JUMPED;
 	if (unlikely(ret)) {
@@ -2105,7 +2122,7 @@ static noinline const char *step_into_slowpath(struct nameidata *nd,
 	struct inode *inode;
 	int err;
 
-	err = handle_mounts(nd, dentry, &path);
+	err = handle_mounts(nd, dentry, &path, flags);
 	if (unlikely(err < 0))
 		return ERR_PTR(err);
 	inode = path.dentry->d_inode;
@@ -2245,7 +2262,7 @@ static const char *handle_dots(struct nameidata *nd, enum last_type type)
 			parent = follow_dotdot(nd);
 		if (IS_ERR(parent))
 			return ERR_CAST(parent);
-		error = step_into(nd, WALK_NOFOLLOW, parent);
+		error = step_into(nd, WALK_NOFOLLOW | WALK_HELD, parent);
 		if (unlikely(error))
 			return error;
 
@@ -2799,7 +2816,8 @@ static int handle_lookup_down(struct nameidata *nd)
 	if (!(nd->flags & LOOKUP_RCU))
 		dget(nd->path.dentry);
 	nd->next_seq = nd->seq;
-	return PTR_ERR(step_into(nd, WALK_NOFOLLOW, nd->path.dentry));
+	return PTR_ERR(step_into(nd, WALK_NOFOLLOW | WALK_HELD,
+				 nd->path.dentry));
 }
 
 /* Returns 0 and nd will be valid on success; Returns error, otherwise. */
diff --git a/fs/namespace.c b/fs/namespace.c
index e5feb4e48290..0325fc8db4c4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -221,7 +221,10 @@ struct mnt_cover {
 	struct hlist_node pin;		/* mp->m_covers, keeps the mountpoint */
 	struct dentry *dentry;
 	struct mountpoint *mp;
-	struct rcu_head rcu;
+	union {
+		bool root;		/* mount sat on its parent's root */
+		struct rcu_head rcu;	/* valid once the cover is dropped */
+	};
 };
 
 static int mnt_alloc_id(struct mount *mnt)
@@ -970,13 +973,18 @@ static int get_mountpoint(struct dentry *dentry, struct pinned_mountpoint *m)
 /*
  * vfsmount lock must be held.  Additionally, the caller is responsible
  * for serializing calls for given disposal list.
+ *
+ * A removed name keeps DCACHE_MOUNTED so that a walk which found the
+ * name earlier continues walking mounts and fails. The bit dies with the
+ * dentry or in d_delete().
  */
 static void maybe_free_mountpoint(struct mountpoint *mp, struct list_head *list)
 {
 	if (hlist_empty(&mp->m_list) && hlist_empty(&mp->m_covers)) {
 		struct dentry *dentry = mp->m_dentry;
 		spin_lock(&dentry->d_lock);
-		dentry->d_flags &= ~DCACHE_MOUNTED;
+		if (!cant_mount(dentry))
+			dentry->d_flags &= ~DCACHE_MOUNTED;
 		spin_unlock(&dentry->d_lock);
 		dput_to_list(dentry, list);
 		hlist_del(&mp->m_hash);
@@ -1060,6 +1068,15 @@ static void umount_mnt(struct mount *mnt)
 	__umount_mnt(mnt, &ex_mountpoints);
 }
 
+/*
+ * Is @m reached through the name of its mountpoint? A mount on the root
+ * of its parent isn't: the walk gets there by crossing onto the parent.
+ */
+static bool reached_by_name(const struct mount *m)
+{
+	return m->mnt_mountpoint != m->mnt_parent->mnt.mnt_root;
+}
+
 /*
  * @mnt is unmounted together with its parent and would have stayed attached
  * to it. Leave its cover behind before it is detached so that a lookup on the
@@ -1074,6 +1091,7 @@ static void leave_cover(struct mount *mnt)
 	mnt->mnt_cover = NULL;
 	cover->dentry = mnt->mnt_mountpoint;
 	cover->mp = mnt->mnt_mp;
+	cover->root = !reached_by_name(mnt);
 	/* keeps the mountpoint once @mnt has let go of it */
 	hlist_add_head(&cover->pin, &cover->mp->m_covers);
 	hlist_add_head_rcu(&cover->node, &mnt->mnt_parent->mnt_covers);
@@ -2019,23 +2037,24 @@ static int do_umount(struct mount *mnt, int flags)
 }
 
 /*
- * __detach_mounts - lazily unmount all mounts on the specified dentry
+ * __detach_mounts - lazily unmount the mounts on the specified dentry
  *
  * During unlink, rmdir, and d_drop it is possible to loose the path
  * to an existing mountpoint, and wind up leaking the mount.
  * detach_mounts allows lazily unmounting those mounts instead of
  * leaking them.
  *
- * The dentry is unhashed before the mounts go so that no lookup finds
- * what they covered. The caller removes it for good afterwards.
+ * A cover on the root of its parent dies with the parent like an fd
+ * would for regular mounts.
  *
  * The caller may hold dentry->d_inode->i_rwsem.
  */
 void __detach_mounts(struct dentry *dentry)
 {
 	struct pinned_mountpoint mp = {};
+	bool removed = cant_mount(dentry);
+	struct hlist_node *node, *n;
 	struct mnt_cover *cover;
-	struct hlist_node *n;
 	struct mount *mnt;
 
 	guard(namespace_excl)();
@@ -2047,13 +2066,24 @@ void __detach_mounts(struct dentry *dentry)
 	/* the name goes first, what covered it goes second */
 	d_drop(dentry);
 	event++;
-	while (mp.node.next) {
-		mnt = hlist_entry(mp.node.next, struct mount, mnt_mp_list);
+	/* the mounts after the pin still need a look */
+	while ((node = mp.node.next)) {
+		mnt = hlist_entry(node, struct mount, mnt_mp_list);
+		if (removed && !reached_by_name(mnt)) {
+			/* it stays, move the pin past it */
+			hlist_del(&mp.node);
+			hlist_add_behind(&mp.node, node);
+			continue;
+		}
+		/* goes, umount_tree() takes it and its children off the list */
 		umount_tree(mnt, UMOUNT_COVER);
 	}
-	/* the dentry goes away, so do the covers left behind on it */
-	hlist_for_each_entry_safe(cover, n, &mp.mp->m_covers, pin)
+	hlist_for_each_entry_safe(cover, n, &mp.mp->m_covers, pin) {
+		/* same rule as for the mounts above */
+		if (removed && cover->root)
+			continue;
 		drop_cover(cover, &ex_mountpoints);
+	}
 	unpin_mountpoint(&mp);
 }
 

-- 
2.53.0

