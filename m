Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01EB4A43E8
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820255; cv=none; b=cGc0gYVujyDwGZ+JAkBxMQPZ+R2ovbEaZTxmtIfv65hcK3qCWY5IKeB/qbaa9GsVwowvJwMMJsBksTlPirQbmmE6+4oBvrEzr/JJ5tWKb73uanqi/DkBWrznwZGmYxv8fT6p1c76H4xv+a9snKm+pBQ/bPLiCx14+gfY48V7X+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820255; c=relaxed/simple;
	bh=e/fWHfrf8BTPdSFI/bUdqj9jJyzSSp+i1HqQnx25eno=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=H1VmVawtfxAZOpkO1YAlD5g6ViGqgdQLsq+YxdtZ+DeTWoNzC5LL2dm0aV1eZmDQ2T17XfbwI5oeec5sI/K58lRxuN3ABPPavwWh2v2KXT7qX57Y71WjoPN2svlQCi1WrKCFGy3d3ggOdloJkte/KXM3I6P5usGL3FfqkFtNmSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XLUiGebJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XLUiGebJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76FA1F0089C;
	Mon, 12 Oct 2026 15:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791820252;
	bh=LeWUhknwQiftM6/OMe535hX4xFBM4m3ah64EEHy21ao=;
	h=Subject:To:Cc:From:Date;
	b=XLUiGebJVUrq1ZKOWVuNxdsD6MrAZucYlzCwmGZuoS1mOVGMZ5E/DM95Hr4fD31Ax
	 gkA4FnKJ6P9kXftbX/ET9c9qHJ31N9OknoAOfa7Sz1dF0hxqwzcQz/lRMNiLkXkCfY
	 iF/8fKgxWaxJjdkhOInrrdtLXUptQp3n7iXd/asQ=
Subject: FAILED: patch "[PATCH] namespace: check the mounts before reading their parents in" failed to apply to 6.6-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:50:49 +0200
Message-ID: <2026101249-monogram-subscript-9e06@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6b7c001eb5857fa09041f47673666060a2e5fc1c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101249-monogram-subscript-9e06@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6b7c001eb5857fa09041f47673666060a2e5fc1c Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Sep 2026 15:32:02 +0200
Subject: [PATCH] namespace: check the mounts before reading their parents in
 pivot_root()

path_pivot_root() reads the parents of new_root and of the caller's root
and checks whether they are shared before it checks that either mount is
in the caller's mount namespace. Only namespace_sem is held. That's fine
for a mount that is in the caller's mount namespace.

But new_root can be a file descriptor to a mount that has been unmounted
and that only the file descriptor keeps alive. If that mount stayed
attached to its parent when it was unmounted nothing pins the parent for
it. The final mntput() of the parent unhooks the children under
mount_lock alone and frees the parent afterwards:

  pivot_root()                     close(fd), last ref on the parent
  ------------                     ---------------------------------
  ex_parent = new_mnt->mnt_parent
                                   mntput_no_expire_slowpath()
                                     __umount_mnt(new_mnt)
                                   cleanup_mnt()
                                     call_rcu()
  IS_MNT_SHARED(ex_parent)

  BUG: KASAN: slab-use-after-free in path_pivot_root+0xf1a/0x1840
  Read of size 4 at addr ffff8881047382f8 by task pivot_widen/157
   path_pivot_root+0xf1a/0x1840
   __x64_sys_pivot_root+0x165/0x190

The same goes for the caller's root via chroot(). Both outcomes of the
check end in EINVAL so nothing but the read itself goes wrong. It's the
same thing commit bb4609405752 ("statmount: read the parent of an
unmounted mount under mount_lock") fixed for statmount().

Check that both mounts are in the caller's namespace before their
parents are read. Every path returns EINVAL either way.

Fixes: e0c9c0afd2fc ("mnt: Update detach_mounts to leave mounts connected")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260930-work-mount-fixes-3-v1-10-be34c83956ae@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/namespace.c b/fs/namespace.c
index f66f4609ef9d..0a7d50db228d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4780,14 +4780,15 @@ int path_pivot_root(struct path *new, struct path *old)
 
 	new_mnt = real_mount(new->mnt);
 	root_mnt = real_mount(root.mnt);
+	/* only a mounted mount has a parent that namespace_sem pins */
+	if (!check_mnt(root_mnt) || !check_mnt(new_mnt))
+		return -EINVAL;
 	ex_parent = new_mnt->mnt_parent;
 	root_parent = root_mnt->mnt_parent;
 	if (IS_MNT_SHARED(old_mnt) ||
 		IS_MNT_SHARED(ex_parent) ||
 		IS_MNT_SHARED(root_parent))
 		return -EINVAL;
-	if (!check_mnt(root_mnt) || !check_mnt(new_mnt))
-		return -EINVAL;
 	if (new_mnt->mnt.mnt_flags & MNT_LOCKED)
 		return -EINVAL;
 	if (d_unlinked(new->dentry))

