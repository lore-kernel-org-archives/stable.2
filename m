Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94EA4E9C01;
	Wed, 30 Sep 2026 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775150; cv=none; b=A3TBZTAMv1CK9mqysnDxagxOj+4ZmnGGwhpiCbwsxy9sZY8NQeOAGSqxSUOxHhXdEp0GCK2P762QjjVKXUgG6Ep2MhJ+GYWBN/Cwe0mH4sOq4dxpUwjgD+OZ1vh2B4B5oaMUuOGTE7uzji2EYv1vVz09GLqfg/YsagjnaQTZHKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775150; c=relaxed/simple;
	bh=PdwOTA7Ty67aDZ+6DeUVKBmyc0cvnk9BlYFt7MdUk+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RJILomIPgAk/ODQbpmgDDxfa1LVyaobF86O4r7rl9DNk6YH6kVlHg3+FH5rdIK6vpUJJ3oNRWUm55VGMvobY7Q8toapCZzUls7nXx6iPYeKrR/ieYdo1oJcYY65xioDBe2PHc94Jgfg6k0dNZTMIlF5SnlvlAOB0PbMC4GfyUVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ef9+VN7Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef9+VN7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439131F000FF;
	Wed, 30 Sep 2026 13:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775140;
	bh=UhPmOAIp9YcCKBoBQeFCqy/yhzZcxsik8Pvpf1m894c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ef9+VN7YYTTGi8dNa4c1ALXk0OcCvVx74UZIIzmbbU5HiJkRx1iAewDHiHhgINULO
	 3oYFWhzzaXe83iPhkEBZC/D5cgXgJ1BM/XRpAcov5gec1OCDlwPEJKvYbatwKbeqwh
	 9f5wuTdj3DOwCnpjtxVmGZakX0qi4RJNWL6v9UDkZFIlDhBreQuiaLZc96zM2e9viA
	 5wkgf2nR15n5EsFA+Uwf3RdqwMfEZpNRCdU5aSg0IPpPv/82TJW0yfrDXOFcW1HtQQ
	 gr5ymTErpgOnmLZM6YJUH/DCutxEgvYLBj1Gtca3D1bqrDro/ColRGaUyIC9oOnVN/
	 gE0kxVhVS/2WQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Sep 2026 15:31:58 +0200
Subject: [PATCH 06/17] namespace: keep covered mounts covered in
 OPEN_TREE_NAMESPACE
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-work-mount-fixes-3-v1-6-be34c83956ae@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4678; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PdwOTA7Ty67aDZ+6DeUVKBmyc0cvnk9BlYFt7MdUk+M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt5ffffSfyRd/SM8XyqVELc+7/V347bY3kybqb6rpPt
 I5KPPv2s6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAizPsY/id+0viyLulUb8Vv
 q5Xf1mzbbrmZM/aEVpR6y4Se+kmnXrYx/JVbJmhTqPFz0y7POcIs7BVcZYprxT1+8c3c0bFfVVv
 7PDsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

open_tree(OPEN_TREE_NAMESPACE) creates a new mount namespace from a
copy of the tree at the given path. The caller needs to be privileged
over its current user namespace because the new mount namespace will be
owned by it. It doesn't need to be privileged over the mount namespace
the tree is copied from. An unprivileged user just needs to create a
user namespace first.

The copy follows the rules of a detached bind mount. Without
AT_RECURSIVE only the mount itself is cloned and its children are left
out. With AT_RECURSIVE unbindable mounts are skipped. Both is fine when
the caller has privileges over the source mount namespace because it
could unmount those mounts anyway. Not so for an unprivileged user in
that mount namespace. For them a mount namespace copy is what unshare()
does. copy_mnt_ns() copies everything including unbindable mounts and
lock_mnt_tree() makes sure nothing can be unmounted in the copy. Nothing
that was covered gets revealed.

create_new_namespace() only does the locking and so the covered content
is right there in the new mount namespace:

  # mount -t tmpfs none /tmp/otn; mkdir /tmp/otn/covered
  # echo hidden > /tmp/otn/covered/under.txt
  # mount -t tmpfs none /tmp/otn/covered

  uid 1000, after unshare(CLONE_NEWUSER):
  fd = open_tree(AT_FDCWD, "/tmp/otn", OPEN_TREE_NAMESPACE);
  setns(fd, CLONE_NEWNS);
  open("/covered/under.txt", O_RDONLY)  -> "hidden"

Covering paths with mounts is how container runtimes mask parts of
/proc and /sys and how admins hide things.

When the caller's user namespace doesn't own the source mount namespace
copy the way unshare() does and refuse a non-recursive copy of a mount
that has anything mounted below the requested directory and copy
unbindable mounts in a recursive copy. A caller that is privileged over
the source mount namespace sees no change.

Fixes: 9b8a0ba68246 ("mount: add OPEN_TREE_NAMESPACE")
Cc: stable@vger.kernel.org # v7.0+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c2f54636ec9d..de3900dd02f6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2369,6 +2369,18 @@ bool has_locked_children(struct mount *mnt, struct dentry *dentry)
 	return __has_locked_children(mnt, dentry);
 }
 
+/* locks: namespace_shared && pinned(mnt) || mount_locked_reader */
+static bool __has_children(struct mount *mnt, struct dentry *dentry)
+{
+	struct mount *child;
+
+	list_for_each_entry(child, &mnt->mnt_mounts, mnt_child) {
+		if (is_subdir(child->mnt_mountpoint, dentry))
+			return true;
+	}
+	return false;
+}
+
 /*
  * Check that there aren't references to earlier/same mount namespaces in the
  * specified subtree.  Such references can act as pins for mount namespaces
@@ -3141,12 +3153,18 @@ static struct mnt_namespace *create_new_namespace(struct path *path,
 	struct mount *mnt;
 	unsigned int copy_flags = 0;
 	bool locked = false, recurse = flags & MOUNT_COPY_RECURSIVE;
+	bool foreign = user_ns != ns->user_ns;
 
 	if (unlikely(!d_can_lookup(path->dentry)))
 		return ERR_PTR(-ENOTDIR);
 
-	if (user_ns != ns->user_ns)
-		copy_flags |= CL_SLAVE;
+	/*
+	 * Without privileges over the mount namespace the copy is made from
+	 * nothing mounted below @path may be left out. It would reveal what
+	 * it covers. That's what unshare() gives such a caller as well.
+	 */
+	if (foreign)
+		copy_flags |= CL_SLAVE | CL_COPY_UNBINDABLE;
 
 	new_ns = alloc_mnt_ns(user_ns, false);
 	if (IS_ERR(new_ns))
@@ -3180,10 +3198,14 @@ static struct mnt_namespace *create_new_namespace(struct path *path,
 	/*
 	 * We don't emulate unshare()ing a mount namespace. We stick to
 	 * the restrictions of creating detached bind-mounts. It has a
-	 * lot saner and simpler semantics.
+	 * lot saner and simpler semantics. A caller without privileges
+	 * over the mount namespace can't leave out any child though.
 	 */
 	if (flags & MOUNT_COPY_NEW)
 		mnt = clone_mnt(real_mount(path->mnt), path->dentry, copy_flags);
+	else if (foreign && !recurse &&
+		 __has_children(real_mount(path->mnt), path->dentry))
+		mnt = ERR_PTR(-EINVAL);
 	else
 		mnt = __do_loopback(path, recurse, copy_flags);
 	scoped_guard(mount_writer) {
@@ -3200,7 +3222,7 @@ static struct mnt_namespace *create_new_namespace(struct path *path,
 		 * of the real rootfs we created.
 		 */
 		attach_mnt(mnt, new_ns_root, mp.mp);
-		if (user_ns != ns->user_ns)
+		if (foreign)
 			lock_mnt_tree(new_ns_root);
 	}
 

-- 
2.53.0

