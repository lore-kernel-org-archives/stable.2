Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A763F4EF12C;
	Wed, 30 Sep 2026 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775162; cv=none; b=KbpNeQFQuTRACGk7M5afaaXSws83YeqDEnEsjry8PwlZEAmc9SFE9fmHqmpycZkhQz/adC5v1hXDv481bBZvXlRgqsdlj28NHj/5uGfstcCTkv0Bpgpyp5PpSdtb/HGgDtLGbKFvwh0rKegDzNnBBsi+BeZH+XVIsCR4w/zQovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775162; c=relaxed/simple;
	bh=UClxtGPI0ibPm3G6bsaEtUlSwDs52w9PWyIZUQ7YiG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=co9x4DsEdsbALCyXmEHqMeVwuOamLAeQb6uspC947eBoJ7Df1/VUJPa377Ok9HF5sIQFDXnA8eC7CYdavlLNQT5QlbNbaAfi4uO+bQAY/4EL99o4tuDY08okNDmbrEPMk8bF+zqEX4Yh/u5oE1a7TlWXYXjuw93ErwgoUw9mCIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRvlNTZi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRvlNTZi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B461F0089A;
	Wed, 30 Sep 2026 13:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775151;
	bh=Q642X3whE7UbZys6zBoQcPEhdQ6WIpL17INB6vaB8iM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oRvlNTZiryyEDoX0MrpXiM2J3p4YxB2HbWUqLIIa7V1HmND52WCOFEsxFenUYFO6n
	 /0IlUolkHJgvNFWMGTLKOdcVfQOjrhNGQgB7gBNy9go21E5uQrQpiBmQv7LnWeFweT
	 /rTabdqzGtQZL0b0s7ozMvGb9YhTqMKrgmH/NhzjKa2VnB9EVpF9hqGEXUrn/2FNTi
	 keuX9ynUZ8Skuo52bHWz3wUF2qywX2Qm3A6XtLqSc6/PYqQoWbC/Fr4mc9wHKO/Zij
	 A9lJoVQ6ZCe+Qy7K5LrG1YfCnSzMbcdP6mPz/YQ+bpdao98463AUqVfzb0FNMGUC8M
	 Oe9vUqCMrKR1w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Sep 2026 15:32:02 +0200
Subject: [PATCH 10/17] namespace: check the mounts before reading their
 parents in pivot_root()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-work-mount-fixes-3-v1-10-be34c83956ae@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2701; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UClxtGPI0ibPm3G6bsaEtUlSwDs52w9PWyIZUQ7YiG0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt5fc/Y7XiyM8KLQnPO9EPnWKWnG1e6ZMpeEcuvrbT5
 bR67/fsjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm4+jIyPGrebsiw5fW3Gzuj
 Xz5i4n2uduLZi3vFnXEZ/zo3OMXpmTAy9HvPFjWfPHn/zsaz6gd712QnX7HzKr4mda3x4f8EwYm
 PuQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

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
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

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

-- 
2.53.0

