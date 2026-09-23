Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C827516160;
	Wed, 23 Sep 2026 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166506; cv=none; b=oE7TEDzpF9hBKPK8hgb9j6w/v5m/bYmluN3P5B17Fbv9GwNkJmRT6y72D4n3HNMCGGdagYrYehu64seGmz4n4x6bDgK0VgfI/E/XAIpnyNC1WczRBgYP1SVKiaaFySBWymSSKoxZ+XKVcBXQuLgTDXqgQ/MiMWeVGumTCPfoqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166506; c=relaxed/simple;
	bh=KRI8omNOMCiI6IgA1rLIMiWlRU5g0GVvzt4XXgMRDW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bytOxyVRaUHVCY8im3QBsJfQ3D5dhCfgpYA7ygxWn28QG267Sgv1BdCFNlP2p8EJon3eV3DqKCN9+xzM+lk4enyQsYjcUqf3ElubOKUCn2Be+xcOOGzGeeX4ruzbbM3rnCDVH0UZtWMHHBnkBho8XAS2A8kYKL8+fZwx4CbF1eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNpnU9Zd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNpnU9Zd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4A41F00893;
	Wed, 23 Sep 2026 12:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790166504;
	bh=HmZI40rnH0E1cwCoxsUDuC4zgJUjo+2gHOoQq3EJ9QE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HNpnU9Zd8DAeSZfKxuFtGDo+jGSfd/6XQIg9f1Oi8Z/2SJVJSlv9rPzmNf5ddu5VW
	 i/RPIIcXoxaW5wFWl5QkW8L381w0f7ttuX5k2j6QqEoyadTK74le59fowAsoLJLBT2
	 bOZzFKTkziyL2cEa0f84Ynss5f0ZDyXAhB9ebYNoklPjQFQtr+aedpIedK/YGjec+q
	 Ivv/jh+8iMWa56zS9yxzf866WRcjTXf6dVQCZ7ntDMrTaVbtmhvmyRB8oAKXJvwbZ4
	 +YkQT/RAP1JGogqIS5+Ft4vukOJygTWrQUcv1U92qrPaXibBzx5bLVWHt/WoYpH5Ue
	 p/lGSkaWDft9g==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 23 Sep 2026 14:27:57 +0200
Subject: [PATCH 5/8] fs: don't silently unmount busy mounts
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-work-mount-fixes-v1-5-f424cf8d3242@kernel.org>
References: <20260923-work-mount-fixes-v1-0-f424cf8d3242@kernel.org>
In-Reply-To: <20260923-work-mount-fixes-v1-0-f424cf8d3242@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=8497; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KRI8omNOMCiI6IgA1rLIMiWlRU5g0GVvzt4XXgMRDW4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtPnpnyt616w8dr51wwb3Gc6pATEawhM4Wv47V01W84
 u/e7Plv3lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRzGxGhn/c3sntt/i3TFzf
 pez4+YvJM0OT1kMBtQ+mc4Q9KznkyMfIsHj+naMryjaFvLqctPBvAMvcx7HzJ8Y2RvY6PpqYwr0
 8nQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The propagate_mount_busy() helper exists to decide whether a synchronous
can suceed. It does that by looking at the copies of the victims in the
mounts its parent propagates to. One of those functions from propagation
hell.

It skips a copy that has child mounts except for the case of a single
child mount covering the copy's root. That algorithm used to be exact.
It isn't anymore.

Originally only childless copies were unmounted during propagation.
And 1064f874abc0 ("mnt: Tuck mounts under others instead of creating
shadow/side mounts.") ended up adding covered mounts to both sides in
one go.

Along came 99b19d16471e ("mnt: In propgate_umount handle visiting mounts
in any order") and that started to unmount more than before:

[1]: A copy of a mount is unmounted when each of its children is either
     its overmount or a copy of the victim itself. In the former case
     the overmount gets reparented. In the latter case the copy of the
     victim will end up being unmounted.

So propagate_umount() ended up being rewritten without adjusting
propagate_mount_busy(). And currently propagate_mount_busy() doesn't
look at copies of the victim that have two or more children nor a single
child that is not the overmount.

So any such copy in [1] is not checked for
references. The result is that a synchronous unmount succeeds, pulling
out a mount that is still in use.

A container can run into this with its own mounts. The host shares a
tree with the container and the host has a mount in that tree:

  mount -t tmpfs none /mnt
  mount --make-shared /mnt
  mount -t tmpfs none /mnt/a

The container's /mnt is a slave copy of the host mount. The container
now takes a detached copy of the tree and mounts that copy beneath its
propagated copy of /mnt/a and keeps the file descriptor to the tree
open:

  unshare -m --propagation unchanged
  mount --make-rslave /
  fd = open_tree(AT_FDCWD, "/mnt", OPEN_TREE_CLONE | AT_RECURSIVE)
  move_mount(fd, "", AT_FDCWD, "/mnt/a", MOVE_MOUNT_BENEATH)

  grep /mnt /proc/self/mountinfo
  775 355 ... /mnt ...     master:646
  777 775 ... /mnt/a ...   master:646
  776 777 ... /mnt/a ...   master:647
  778 777 ... /mnt/a/a ... master:647

The now attached tree (777) is now mounted beneath the container's copy
of /mnt/a. That's also where the host mount sits (as seen from the host
mount namespace). So the propagated copy (776) of the host's mount is on
top of its root and the copy of that (778) is inside it. Now the host
runs:

  umount /mnt/a

and it succeeds. The moved tree tree and the copy inside of it are gone
from the container. Now only the propagated copy is left and it got
reparented to where it was before:

  grep /mnt /proc/self/mountinfo
  775 355 ... /mnt ... master:646
  776 775 ... /mnt/a ...

But the file descriptor still refers to the moved tree. So a synchronous
umount detached a mount that is still in use.

Teach propagate_mount_busy() the same checks that propagate_umount()
does. It now checks for a single victim mount without children
for which it can assume that MNT_LOCKED is cleared on every copy like
propagate_umount() does. The copies form chains. IOW, when a copy itself
receives propagation from the victim's parent then the mount at the same
mountpoint inside that copy is a copy as well. Whether a mount receives
propagation from the victim's can simply be checked by walking its
masters. Walk each chain once from its top so we are sure that nested
copies stay linear. Check every reference once of every copy that gets
unmounted.

Fixes: 99b19d16471e ("mnt: In propgate_umount handle visiting mounts in any order")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/pnode.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 90 insertions(+), 18 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index 5d91c3e58d2a..2cd667958efe 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -410,19 +410,99 @@ bool propagation_would_overmount(const struct mount *from,
 	return false;
 }
 
+/* Does @m receive propagation from @parent? */
+static bool receives_from(struct mount *m, struct mount *parent)
+{
+	if (m == parent)
+		return false;
+	for (; m; m = m->mnt_master)
+		if (m == parent || peers(m, parent))
+			return true;
+	return false;
+}
+
+/*
+ * Does @m receive propagation from the victim's parent as well? If so, then
+ * the mount at the victim's mountpoint inside of @m is a umount candidate as
+ * well. So it's the next candidate in the chain. Otherwise the chain ends at
+ * @m.
+ */
+static struct mount *next_candidate(struct mount *m, struct mount *victim)
+{
+	if (!receives_from(m, victim->mnt_parent))
+		return NULL;
+	return __lookup_mnt(&m->mnt, victim->mnt_mountpoint);
+}
+
+/*
+ * Would propagate_umount() pull out a mount of the chain of candidates that
+ * starts at @c, and does that mount have references beyond its own?
+ *
+ * This mirrors how trim_one(), trim_ancestors() and handle_locked() handle a
+ * synchronous umount:
+ *
+ * - single victim
+ * - without children
+ * - with MNT_LOCKED already cleared on every candidate by propagate_mount_unlock()
+ *
+ * A copy of the victim gets unmounted when each of its children is
+ * the next candidate in the chain or its overmount, unless the next
+ * unmount candidate is not its overmount and some unmount candidate further
+ * down has a child outside the chain.  Keep this in sync with
+ * Documentation/filesystems/propagate_umount.txt.
+ */
+static bool chain_busy(struct mount *c, struct mount *victim)
+{
+	struct mount *m, *n, *next, *deepest = NULL;
+	bool above;
+
+	/* the deepest candidate with a child outside the chain */
+	for (m = c; m; m = next) {
+		next = next_candidate(m, victim);
+		list_for_each_entry(n, &m->mnt_mounts, mnt_child) {
+			if (n != next && n != victim) {
+				deepest = m;
+				break;
+			}
+		}
+	}
+
+	above = deepest != NULL;	/* @deepest is at or below @m */
+	for (m = c; m; m = next) {
+		bool goes = true;
+
+		next = next_candidate(m, victim);
+		list_for_each_entry(n, &m->mnt_mounts, mnt_child) {
+			if (n != next && n != m->overmount && n != victim) {
+				goes = false;
+				break;
+			}
+		}
+		if (goes && next && next != m->overmount && above && m != deepest)
+			goes = false;
+		if (m == deepest)
+			above = false;
+		if (goes && do_refcount_check(m, 1))
+			return true;
+	}
+	return false;
+}
+
 /*
  * check if the mount 'mnt' can be unmounted successfully.
  * @mnt: the mount to be checked for unmount
  * NOTE: unmounting 'mnt' would naturally propagate to all
  * other mounts its parent propagates to.
- * Check if any of these mounts that **do not have submounts**
- * have more references than 'refcnt'. If so return busy.
+ * Check if any of the mounts that propagate_umount() would pull out
+ * along with it have more references than their own. If so return busy.
  *
  * vfsmount lock must be held for write
  */
 int propagate_mount_busy(struct mount *mnt, int refcnt)
 {
 	struct mount *parent = mnt->mnt_parent;
+	struct dentry *mp = mnt->mnt_mountpoint;
+	struct mount *m;
 
 	/*
 	 * quickly check if the current mount can be unmounted.
@@ -435,24 +515,16 @@ int propagate_mount_busy(struct mount *mnt, int refcnt)
 	if (mnt == parent)
 		return 0;
 
-	for (struct mount *m = propagation_next(parent, parent); m;
-	     		m = propagation_next(m, parent)) {
-		struct list_head *head;
-		struct mount *child = __lookup_mnt(&m->mnt, mnt->mnt_mountpoint);
+	/* the candidates are the mounts at @mp below the receivers */
+	for (m = propagation_next(parent, parent); m;
+	     m = propagation_next(m, parent)) {
+		struct mount *c = __lookup_mnt(&m->mnt, mp);
 
-		if (!child)
+		/* each chain once, from its top: skip receivers that are candidates */
+		if (!c || (mnt_has_parent(m) && m->mnt_mountpoint == mp &&
+			   receives_from(m->mnt_parent, parent)))
 			continue;
-
-		head = &child->mnt_mounts;
-		if (!list_empty(head)) {
-			/*
-			 * a mount that covers child completely wouldn't prevent
-			 * it being pulled out; any other would.
-			 */
-			if (!list_is_singular(head) || !child->overmount)
-				continue;
-		}
-		if (do_refcount_check(child, 1))
+		if (chain_busy(c, mnt))
 			return 1;
 	}
 	return 0;

-- 
2.53.0

