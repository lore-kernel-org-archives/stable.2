Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350D454B1B8
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932681; cv=none; b=DI0oBM2ZhknYVMG0YLn0NToXDLyp7mY1gE60G7ZkPuItebV7HFK5U2Srpg0+uugf1KDFQKYDbSQYYTUQjGYIvHZ7U8GdWFLMisaNpRGJj1lal+2TKH0h+6coj1ZlROJJ+KS0LmW61xLtdrrqnGlQTKh5t78oR9XmU5PP+StZQx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932681; c=relaxed/simple;
	bh=Oc4YGxtMKq/CTKnNhj4ADAhoyarqFOhGhkGt6riiTAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwk3ZqPOQf6sWy/OY9suZFi/RCkUpcr3THgRsWBbPbwp0jdD1S5l1esMREbFTsq85XzDGDp30N18D1BL+XsnK7gtjRhZpuzqWYKHRN8PEWaXrH/eyXzu6HjkD+kJfYj1FOYj8oaklxCT6iEfRRv6mqyXGzytTu86GVP2XAxHv/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TM+meep5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TM+meep5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C1E1F00893;
	Tue, 13 Oct 2026 23:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791932680;
	bh=spYSQD9iWJFwl2a2J/f1I4k/3L/ZSRS29fUMwSt2v+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TM+meep57ApLFcCojTp37Dgipx058qWrFyDYoIMP8N4+SQJpGaGyxJaFmp83OZzVu
	 VvC5KZelb4mO6U3lnoDPrQmCMHXHliQY9gzXEAjG1yI7hyxmdvmRcElYixNXrvJfHm
	 Xdsiax8GYecdism/Nz8SY1Ea2JubtBZN5WY0PPK5QF9YaKiYFOWB9JOVlOcU8I/yOE
	 5SLaIPUMLeYM1qySq0+jpokYaPMU3SYDDinbnyWYptsYwMcOpLaVB/jM6vwaNVbV8p
	 9fmZ7rleI6w5hBdo4KoQTgaBOWOigWMCWhyvoAmQa1oxJxjTwhbw4wWpiNSt0pMTuq
	 sJbH//caR1sPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] namespace: don't inherit MNT_UMOUNT in clone_mnt()
Date: Tue, 13 Oct 2026 19:04:38 -0400
Message-ID: <20261013230338.1058174-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101219-dinginess-glandular-9342@gregkh>
References: <2026101219-dinginess-glandular-9342@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit e2c6d326216642011da318b9edfd5d57ebd5a56f ]

MNT_UMOUNT gets raised on a mount that umount_tree() or umount_one() has
taken out of its namespace. It's never cleared. __detach_mounts()
unhooks a mount that carries it instead of unmounting it.

disconnect_mount() lets an unmounted child stay attached only if its
parent carries it. propagate_umount() takes it as the sign that a mount
is going to be unmounted when it decides what else can be unmounted,
where a chain of locked mounts ends and where a for reparenting an
overmount.

clone_mnt() copies the flags of the source and only masks
MNT_INTERNAL_FLAGS which doesn't include MNT_UMOUNT. A mount that was
lazily unmounted but is kept alive by a file descriptor can still be
copied when its root is an nsfs or pidfs file because may_copy_tree()
accepts those before checking whether the source is mounted at all:

  mount --bind /proc/self/ns/net /tmp/x
  exec 3< /tmp/x
  umount -l /tmp/x
  mount --bind /proc/self/fd/3 /tmp/y

The mount on /tmp/y is attached to the caller's namespace with
MNT_UMOUNT already set and every copy of it inherits the flag again.

That causes a number of bugs:

- Unlink its mountpoint from a mount namespace where it isn't one.
  __detach_mounts() takes it for a mount that was unmounted earlier,
  unhooks it from its parent and drops the reference the namespace
  holds on it. It stays in the namespace with one reference too few
  and as its own parent, so it can't be unmounted through the file
  descriptor anymore and the namespace never finds it again. When the
  namespace goes away it's leaked and points to a freed struct
  mnt_namespace that may_change_propagation() and anon_ns_root() read
  on the next propagation change or mount_setattr() through the file
  descriptor.

- Make it shared and unmount a peer. trace_transfers() follows the
  flag from the peer into it and strips it from its peer group.

- Let a propagated umount reach it. gather_candidates() marks it with
  T_UMOUNT_CANDIDATE but never puts it on the candidate list, so the
  mark is never cleared and every later propagated umount skips it. If
  it's the parent of a locked mount handle_locked() takes it as the
  cutoff and commits the locked child that should have stayed and
  disconnect_mount() leaves that child attached to it, unmounted under
  a mounted parent, which is what disconnect_mount() exists to
  prevent. When the namespace goes away umount_tree() visits the child
  a second time. And once __detach_mounts() has made it its own parent
  reparent() never finds the end of the chain of unmounted parents.

A clone is a new mount that has never been unmounted. Add MNT_UMOUNT
to MNT_INTERNAL_FLAGS so clone_mnt() never copies it. And warn when
umount_tree() reaches a mount that already has it set.

Fixes: 590ce4bcbfb4 ("mnt: Add MNT_UMOUNT flag")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260926-work-mount-fixes-2-v1-3-f357abf3d17b@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ sashal: adapted mount-flag handling to the explicit flag-clearing mask in clone_mnt() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c        | 4 +++-
 include/linux/mount.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 42ecf070b6f76..2492d5286cef6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1122,7 +1122,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	}
 
 	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
-	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
+	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL|MNT_UMOUNT);
 
 	atomic_inc(&sb->s_active);
 	mnt->mnt.mnt_userns = mnt_user_ns(&old->mnt);
@@ -1561,6 +1561,8 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 
 	/* Gather the mounts to umount */
 	for (p = mnt; p; p = next_mnt(p, mnt)) {
+		/* A mount is unmounted once. */
+		WARN_ON_ONCE(p->mnt.mnt_flags & MNT_UMOUNT);
 		p->mnt.mnt_flags |= MNT_UMOUNT;
 		list_move(&p->mnt_list, &tmp_list);
 	}
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 55a4abaf67155..76c21958e8426 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -50,7 +50,7 @@ struct path;
 
 #define MNT_INTERNAL_FLAGS (MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL | \
 			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED | \
-			    MNT_CURSOR)
+			    MNT_CURSOR | MNT_UMOUNT)
 
 #define MNT_INTERNAL	0x4000
 
-- 
2.53.0

