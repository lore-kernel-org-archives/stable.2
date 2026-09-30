Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063ED4E4317;
	Wed, 30 Sep 2026 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775141; cv=none; b=n9qArK6IJOWlrEsh3+Q9UiGz7ffGGafAYUfsPCdqec+Gn3O4i1scnZwRMrnXS9vLnlTR3BcwlVy+OpCOco/0DuHZgiGRuzqm70pbFZd49DXYezl6BuZP0K3SdwB/UOVVHy5gclOZyR0FwWF3cOrdf0SdkuGfcJ/3FivvciWLEfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775141; c=relaxed/simple;
	bh=fgxnBCAP/4BzQ1SZ8zLd2EKRKi+w2Vu04CLm5Iap1yM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JJGg7nTzzgH+AWD3bgphxjiusT2Ta4xlDPqfVIk3UeG/uLq3Pts9YQQJ8j2EwRvrAgMb0zmLXNjWM4Ri/gxcBQcCGbGMoqV7T+9dMcZTx3nfi0RacVrMoT8SNVdQhGP02hIRUfLpKCzaPD7cLyreXxvfCQoVwAvW+XwyvnXfNK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyZaKyeR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyZaKyeR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0C11F00898;
	Wed, 30 Sep 2026 13:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775130;
	bh=8nqbRtGx9U80yTGRfT25nbavLWXOVirImeMh4fYzwW4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EyZaKyeRxV4ZcWIuiOsqW1xDJE7OFSF63LVjOmTCkQPpffcvWNjepe81iIUn37H9M
	 L0k4awum3idSVLK6NSq5yRilJOibRUaLQP8ioH41Vn8YPY3XvsTSsaeUeZCLP1+kTm
	 5qyTIiH3PyuGeSrEtn8565iShi/lI0RfY8D9IeeyRdQA6uOKtGFuPMqSc2D383hoKX
	 XKy2VGQF2X4WplGlgMsYJWD7Ab+FIPkYiYMmDMvvzNugEqFZWopNlyotvCPuvh9Uli
	 MNqTUK10Mtx3wnvve/mP8Ly6yKySxPxq0bKUAMFUHnsHn9jh1IDUlrLnngKGXVlip3
	 SXRPuJgyTanYw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Sep 2026 15:31:54 +0200
Subject: [PATCH 02/17] namespace: check a submount for references right
 before unmounting it
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-work-mount-fixes-3-v1-2-be34c83956ae@kernel.org>
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
In-Reply-To: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Chris Mason <mason@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, Amir Goldstein <amir73il@gmail.com>, 
 bpf@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=5493; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fgxnBCAP/4BzQ1SZ8zLd2EKRKi+w2Vu04CLm5Iap1yM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt5fdrPiSoq+TKl9ic9D7gx9z++Sm3NY7cO7TtVEfQx
 c+rv0yS6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiITB8jQ/9kPbEp6e0PVHdu
 Td5Rc1vh2CnNX7bLJH4/ZczbMctVvYmR4UTkp88bO2N/Tu4z2Ka6PHnBdH3uV0l8f3R2ZD3ft1z
 fmwsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

shrink_submounts() and mark_mounts_for_expiry() first collect all the
mounts they are allowed to unmount and then unmount them.

Whether a mount is busy is decided by propagate_mount_busy() on the
tree. But unmounting the first mount changes the tree that the second
one propagates into. propagate_umount()
moves a surviving overmount off a copy it unmounts and mounts it where
the copy was mounted. If that's where the propagated copy of the second
victim is looked up the overmount becomes a candidate of the second
umount_tree(). It's childless and so trim_one() commits it without
looking at its reference count.

So a synchronous umount pulls out a busy mount that is in use somewhere
else and marks it MNT_SYNC_UMOUNT while it has users:

  umount2(/tmp/plshrink/p1, 0) = 0 errno 0
  cwd is (unreachable)

The same two umounts requested one after the other fail with EBUSY.
This needs a mount with MNT_SHRINKABLE, i.e., automounted submounts of
NFS, AFS and CIFS or the tracefs mount below debugfs. Bind mounts
inherit the flag.

Check each mount right before it is unmounted under the same hold of
namespace_sem and mount_lock as the umount itself. Make sure that the
algorithm stays linear.

Fixes: 1064f874abc0 ("mnt: Tuck mounts under others instead of creating shadow/side mounts.")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 78 +++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 25 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2a1e77c0cb6e..23d3bfa9c14d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3987,6 +3987,11 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 	}
 	while (!list_empty(&graveyard)) {
 		mnt = list_first_entry(&graveyard, struct mount, mnt_expire);
+		/* an earlier umount_tree() may have moved a busy mount here */
+		if (propagate_mount_busy(mnt, 1)) {
+			list_move(&mnt->mnt_expire, mounts);
+			continue;
+		}
 		touch_mnt_namespace(mnt->mnt_ns);
 		umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
 	}
@@ -3994,17 +3999,37 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 
 EXPORT_SYMBOL_GPL(mark_mounts_for_expiry);
 
+/*
+ * Unmount @mnt if it's a shrinkable mount without children that nobody uses.
+ *
+ * mount_lock must be held for write
+ */
+static bool shrink_submount(struct mount *mnt)
+{
+	if (propagate_mount_busy(mnt, 1))
+		return false;
+	touch_mnt_namespace(mnt->mnt_ns);
+	umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
+	return true;
+}
+
 /*
  * Ripoff of 'select_parent()'
  *
- * search the list of submounts for a given mountpoint, and move any
- * shrinkable submounts to the 'graveyard' list.
+ * unmount the shrinkable submounts of @parent that aren't busy, children
+ * before their parent, and say whether anything went
+ *
+ * The cursor into the children of @this_parent survives the umount of a
+ * child mount without child mounts. The mounts that get umounted together with
+ * it are located under receiving mounts of @this_parent and never under
+ * @this_parent itself. The one exception is @this_parent getting unmounted
+ * then the walk starts over.
  */
-static int select_submounts(struct mount *parent, struct list_head *graveyard)
+static bool __shrink_submounts(struct mount *parent)
 {
 	struct mount *this_parent = parent;
 	struct list_head *next;
-	int found = 0;
+	bool shrunk = false;
 
 repeat:
 	next = this_parent->mnt_mounts.next;
@@ -4023,42 +4048,45 @@ static int select_submounts(struct mount *parent, struct list_head *graveyard)
 			this_parent = mnt;
 			goto repeat;
 		}
-
-		if (!propagate_mount_busy(mnt, 1)) {
-			list_move_tail(&mnt->mnt_expire, graveyard);
-			found++;
-		}
+		if (!shrink_submount(mnt))
+			continue;
+		shrunk = true;
+		if (unlikely(this_parent->mnt.mnt_flags & MNT_UMOUNT))
+			return true;
 	}
 	/*
 	 * All done at this level ... ascend and resume the search
 	 */
 	if (this_parent != parent) {
-		next = this_parent->mnt_child.next;
-		this_parent = this_parent->mnt_parent;
+		struct mount *mnt = this_parent;
+
+		next = mnt->mnt_child.next;
+		this_parent = mnt->mnt_parent;
+		/* its children are gone, maybe it can go as well */
+		if (shrink_submount(mnt)) {
+			shrunk = true;
+			if (unlikely(this_parent->mnt.mnt_flags & MNT_UMOUNT))
+				return true;
+		}
 		goto resume;
 	}
-	return found;
+	return shrunk;
 }
 
 /*
- * process a list of expirable mountpoints with the intent of discarding any
- * submounts of a specific parent mountpoint
+ * unmount the shrinkable submounts of @mnt that aren't busy
+ *
+ * The busy check and the umount of a mount are adjacent. An umount can
+ * still empty or move a mount in a part of the tree that was walked
+ * already, so walk again until nothing goes.
  *
  * mount_lock must be held for write
  */
 static void shrink_submounts(struct mount *mnt)
 {
-	LIST_HEAD(graveyard);
-	struct mount *m;
-
-	/* extract submounts of 'mountpoint' from the expiration list */
-	while (select_submounts(mnt, &graveyard)) {
-		while (!list_empty(&graveyard)) {
-			m = list_first_entry(&graveyard, struct mount,
-						mnt_expire);
-			touch_mnt_namespace(m->mnt_ns);
-			umount_tree(m, UMOUNT_PROPAGATE|UMOUNT_SYNC);
-		}
+	for (;;) {
+		if (!__shrink_submounts(mnt))
+			break;
 	}
 }
 

-- 
2.53.0

