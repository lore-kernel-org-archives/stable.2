Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790384A68BD
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820263; cv=none; b=kwR7AXjMUh9mx62gO/Ix/ZEPPZkD3b3gwclf/QBw4XPDBM8oXsAznsFSpT0zqTRt35KXAWSUushDLgUqcwPCoVDsOEptbZLIRdo9StN1VwOxCHDQM2Kmo2y5StLwgj8Vmrik4nGY51eKTNiHz+yreo5xvFcuaMdhqzecy1VB1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820263; c=relaxed/simple;
	bh=JASNZkGryQYfXtXD9xdPQoVr4QqS78N1J58If020vTo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UeklXu7aUm2yBpOyr8MXhF1NFtZp596DtgHtBtlS2HNjSOeg1364HqkFItLJf29Ej10fBX1bQIFbT5X9RPbRs43MqHJI1j+Rfkp7Qvj6aJO3xmFY3/wq7nrdSfD5pi6kt6H2VUebbifId+CIIr1g1cZd+8/9isUtZ4EqKCCo3Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2lr1awDi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2lr1awDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6ACF1F0089B;
	Mon, 12 Oct 2026 15:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791820262;
	bh=LlwjFrxMCIifo8haLLKJZW8VWE/DPgl94hLGfQ4TTwc=;
	h=Subject:To:Cc:From:Date;
	b=2lr1awDiTXfD2JoHvN8Nf6jTjnPtBpHT0Veyb2ULSLgaIZOMhGAzsF/i1hj9jyiwf
	 6o1H7rtnwiS1gf9OjJPQu32az8KkOihM4BzXDFpt4dHPM/ljtmSyCOn4pliwHMwIzC
	 fb55XHhm9hz1y9nef0SmHh5lj1svp7od2SA4TSvM=
Subject: FAILED: patch "[PATCH] namespace: check the mounts before reading their parents in" failed to apply to 5.10-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:50:51 +0200
Message-ID: <2026101251-valiant-haunt-74b5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6b7c001eb5857fa09041f47673666060a2e5fc1c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101251-valiant-haunt-74b5@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

