Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1B44DD6DB;
	Wed, 30 Sep 2026 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775133; cv=none; b=BWwNJAiXICsD5YeCyFr8lxBT30gQv14o9oRV6DUiHpxD63eWntR77ZJwRXnBcZynicYKk+s/xKbmlujP27FcY5vrvwNqfFdYoi0CSF/BqPYUpGnLKBPU3hJrf3ZDpUQrQm7KnwZevnkvvrw9HVhViFlJATTSQfxj6+C3V31Qvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775133; c=relaxed/simple;
	bh=1+tqeO8PqJ2j4hyu9XjYVjP39roEyaXvCq3aP2jqfwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uyxDpvjhpeYnyWJ491OzMz1qzYPUwcX7bycmqHVG+Hm/0tIFsPM1zsbiwg0ff+KRoi5bJ85AQbqnQ9vD0+S6mWN9NrPV0MaFyuPFToTM7IZoDmFl8NIBNuYjKcCXjqp1my148XevKk8Vvajb/9ixXziQH2naXO+C7hu4EbmrcJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIciQONU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIciQONU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558421F00893;
	Wed, 30 Sep 2026 13:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775127;
	bh=Xvsi4k+8fFwuUMFzeW1rbUNTZdrmcW1tNsb0JEzhUvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PIciQONUWEMc/SjvH5wicASEKUYbBUFzFDzhnHOh5vRNDq1pGEdFAU0iK9GWzdMhb
	 1KN7LhXsxlo3ejbwG1QRK/13gdoxSyTz+kLHja3UJ79AQj35zZ315PoT51i3t78Ijo
	 O+roUTDipEdmKRB4I+FhH/mZR5lTMdfl6i2NCIefBXOwnTCPWGL3m7uGmJn2WHF29w
	 PozvbKq/Yd6NqF9VfGi2pM2U5EW/qZw+OPDdAOIHXobk9MzJUVdN/fR2RRNXFVLLxt
	 QYEokIUBTlizTWOvKzPoNt5v+9ZJXALUDlmV1MmSq0i2CE1xiwga/mMV4Gl4VbqieN
	 tQu9duc/7sryg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Sep 2026 15:31:53 +0200
Subject: [PATCH 01/17] namespace: queue a mount only once for mount
 notifications
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-work-mount-fixes-3-v1-1-be34c83956ae@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3144; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1+tqeO8PqJ2j4hyu9XjYVjP39roEyaXvCq3aP2jqfwg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt5fdLErU0WPp+3a4vYXJZVebnFV/8nNAYvtVmevZtr
 hkquSe+dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk6iOG/7kz16vNy5qmcOX+
 pPDAPG3W1qWSvbEp9l3fRf+++fP3tT3D/wSe41qbd7MWVfWdXpX3qav7Tff2V+WJ2pIXJvFKRx+
 wZQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

mnt_notify_add() puts a mount on notify_list. It doesn't check whether
the mount is on the list already. That's fine as long as every mount is
queued at most once per namespace_sem hold. It isn't.

propagate_umount() moves a surviving overmount off a stack of mounts
that are going away and queues it as moved. shrink_submounts() and
mark_mounts_for_expiry() call umount_tree() for several mounts under a
single namespace_sem hold. So the second umount_tree() can take down
exactly the mount the first one reparented, reparent it once more and so
end up queueing it a second time.

The second list_add_tail() cuts the mounts queued in between out of the
list while the head still points at the last of them. notify_mnt_list()
then only visits that one mount and the others are freed after the grace
period with notify_list still pointing at them. Every later mount
operation on the host walks freed memory:

  BUG: KASAN: slab-use-after-free in __list_add_valid_or_report
  Read of size 8 at addr ffff8881003d57e0 by task notify_dq/162
   __list_add_valid_or_report+0x15c/0x1a0
   mnt_add_to_ns+0x322/0x890
   attach_recursive_mnt.isra.0+0xf2a/0x1a00
   path_mount+0x139c/0x1d40

This needs a mount with MNT_SHRINKABLE to bind from. That's what
finish_automount() creates (submounts of NFS, AFS and CIFS and the
tracefs mount below debugfs). Bind mounts inherit the flag. A mount
namespace with a FAN_MARK_MNTNS mark does the rest and root in a user
namespace can have both.

Initialize to_notify in alloc_vfsmnt() and leave a mount alone that is
queued already. mnt_notify() looks at the state the mount has when the
list is drained so a single entry per mount is enough. The move event
for a mount that is unmounted under the same hold is lost. That's fine.
The detach is what matters.

Fixes: bf630c401641 ("vfs: add notifications for mount attach and detach")
Cc: stable@vger.kernel.org # v6.15+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/mount.h     | 3 +++
 fs/namespace.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/fs/mount.h b/fs/mount.h
index 85f136786bbc..2223fb141499 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -234,6 +234,9 @@ static inline struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
 #ifdef CONFIG_FSNOTIFY
 static inline void mnt_notify_add(struct mount *m)
 {
+	/* queued already under this namespace_sem hold */
+	if (!list_empty(&m->to_notify))
+		return;
 	/* Optimize the case where there are no watches */
 	if ((m->mnt_ns && m->mnt_ns->n_fsnotify_marks) ||
 	    (m->prev_ns && m->prev_ns->n_fsnotify_marks))
diff --git a/fs/namespace.c b/fs/namespace.c
index 5b44eee28f39..2a1e77c0cb6e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -333,6 +333,9 @@ static struct mount *alloc_vfsmnt(const char *name)
 		INIT_HLIST_NODE(&mnt->mnt_mp_list);
 		INIT_HLIST_HEAD(&mnt->mnt_stuck_children);
 		INIT_HLIST_NODE(&mnt->mnt_ns_visible);
+#ifdef CONFIG_FSNOTIFY
+		INIT_LIST_HEAD(&mnt->to_notify);
+#endif
 		RB_CLEAR_NODE(&mnt->mnt_node);
 		mnt->mnt.mnt_idmap = &nop_mnt_idmap;
 	}

-- 
2.53.0

