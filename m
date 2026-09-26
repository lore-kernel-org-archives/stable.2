Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC86B3A83AC;
	Sat, 26 Sep 2026 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790430306; cv=none; b=VwOVGe7g5jNWqzZYXAPS/Ljx1vteq1oEL0EyQ60eg2wS18qyl1XO/duTOg1rle2lKxd/QgtpN5X57uH663fiBknNCzSIm5pGpH36UHlxCpUpvalwTXk/i0y6i4q+k8V78h8/KvqL423LXK+6nLS7AZRFH/daN9M/Tg7iKSaoWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790430306; c=relaxed/simple;
	bh=zXomIoI+vZFKPF7zJgI5yEoLh7Vj6L1o9v9PdSpv6kQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kxV5FhBGa9prCxPP5uzrnbcl8Au2z5jN9kYqa2Q/FMD7w7NNRteAK3jj6HN0Wm7k2Ag9ALd7UXELtOdFLh3/RHJDnRwo3khs0AYkHqfRKSkh7CL227wlN0d4t2sTDDV6E0f76JtZQ9WyU/ZAsXPAmxshQzWaIE31itqN795eAv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5ACq8hl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5ACq8hl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CAF1F00893;
	Sat, 26 Sep 2026 13:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790430305;
	bh=CKvnfsCSUlliikvhztE/eN4DlCI2w9mJAK3tYMBFdXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=m5ACq8hlCx0ymvuy2g8BJrJKusfsxmH9LMVxaaMXmPeLc94fZo7z1ZYCT3bu6tXR8
	 cGCQsy+BYg8rXXKJVH+4hL/k4GY/6AAx6qvvEAV8nxA6j3W6VNePjp4fE/l1540T1D
	 1Fj5fY1t1Kz4U0GILrdnvGPiqxHKUsgqx1MR/BKItARjA4phBhI/Jcgie/A/U7Dpvn
	 /0ngop0MOtG0D0NvehzTvEmbvNZ0/mi7DjMofMepAh/pyNextiRvuBnNj9LgGhN+FP
	 QxHRRCQxts8BdXkzzEHnULOS3u26IT6ubn4CYwGjzaig/ALMf0jEpFVPc3jShQizM3
	 DmlvTPnD8SvKg==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 26 Sep 2026 15:44:24 +0200
Subject: [PATCH 01/10] namespace: reset the old parent's ->overmount in
 mnt_change_mountpoint()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-work-mount-fixes-2-v1-1-f357abf3d17b@kernel.org>
References: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
In-Reply-To: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2057; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zXomIoI+vZFKPF7zJgI5yEoLh7Vj6L1o9v9PdSpv6kQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtPxOVdmP7pwlGil5bZvH77anem+6zUIZBrOJq+fOWl
 briC29c6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIxS5GhkPtJnaOO7eJ/DXP
 9ixdeJLx4V5ZG75Vq3oXeE0os9mYr8jI8CkpJrk0Z8XV9WKbc347iMk0nZy5W+Le8n39BQ6i1Y0
 /+AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

__umount_mnt() resets ->overmount of the parent when it unmounts the
mount that overmounts it. mnt_change_mountpoint() doesn't. It moves the
mount to its new parent and leaves the old one pointing at it.

For a mount that is moved beneath in attach_recursive_mnt() that doesn't
matter. The new mount has already reset ->overmount of the old parent by
the time the old top mount is moved onto it.

It matters for reparent() though. propagate_umount() moves a surviving
overmount onto the first ancestor that isn't going to be unmounted. The
mount it was taken from is unmounted immediately afterwards. If a file
descriptor keeps that unmounted mount alive ->overmount points at the
moved mount. That's a dangling pointer and UAF as the moved mount is
unmounted and freed.

do_lock_mount() follows ->overmount from the target path under
mount_lock. With a file descriptor on such a mount as the target of a
mount beneath topmost_overmount() walks into the freed mount and
do_lock_mount() takes references on whatever it finds there.

So reset ->overmount of the old parent in mnt_change_mountpoint() the
same way __umount_mnt() does. A mount's ->overmount is then always a
mount that is attached to it.

Fixes: ffdc52fbbd58 ("prevent mount hash conflicts")
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 73215f84e04d..230f95675a93 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1069,7 +1069,10 @@ static void attach_mnt(struct mount *mnt, struct mount *parent,
 void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct mount *mnt)
 {
 	struct mountpoint *old_mp = mnt->mnt_mp;
+	struct mount *old_parent = mnt->mnt_parent;
 
+	if (old_parent->overmount == mnt)
+		old_parent->overmount = NULL;
 	list_del_init(&mnt->mnt_child);
 	hlist_del_init(&mnt->mnt_mp_list);
 	hlist_del_init_rcu(&mnt->mnt_hash);

-- 
2.53.0

