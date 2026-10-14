Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA881E5018
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 02:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791945902; cv=none; b=Z7ZTrjaJKs6V1ZjqzfQmNS5mzcSVzaDY/FIDpAB1i5rsdfbHNL+MAseH9cj3tuwSkXFh7pbYGQuUAW/eZVJCeV7CFqsOGGOSQzJXIG31GPjvY6ujODTwSin58sFhOkFCTN9wchscJ+jJzKtyXQdv4tUqmggPg5QVc7I/xSyXtU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791945902; c=relaxed/simple;
	bh=n3DpcopqXTWNAyzkVX1Twg3Lh/eizYVmmDsVVjw1ZDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhuwfrOT9lT9EtmTFqfQstbyfFJxKPgVvzbF/d7vyy4iMXLUuhQWyKXC7EE74Mm4LO7Mj3MfQWvGPRa85YNGMi7JiYyTnfm/rDSm96LvBzE5YH81dv63/Ltr96NZWaN33zOTZkCM2lCe1oLqGyfJ6QB0bL5Rn0X39K/w3Q/PbIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWbMy6y+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWbMy6y+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831001F00893;
	Wed, 14 Oct 2026 02:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791945900;
	bh=E/friIO334K45u8uxTYFmeqN88VWDMY31dBRtEYJaRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aWbMy6y+WjcXzWk4p35KPKrJChoeJRpJreBdaNyrGVWnVRP+/vl+Rt3DodQIb6FAf
	 jg80Hgu5jYNHmlb3mXjO6giS19McWaHZYsE5r3lPDrZxwk7TivGTu6tAX0iJvPhuLY
	 McNywajBrcIgGJer5LPpv6aDh64KDeryA1sZVNFPyWj4OG1yqwVM58vMbdmg1UN49U
	 qRqyLvEsxkRMN5EIOLDGeATa1FhJVaBzo7HkvV/7+aiqNa6T9+malU14HdAXL0IjcI
	 Q1BL0Dlxbf23iCBkwQCs1NKPF8ikQhSruCyQHSxcMOsqmnxKEtIwM8gGAxyLbxQOaR
	 0H4OIwudk1HwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] namespace: check the mounts before reading their parents in pivot_root()
Date: Tue, 13 Oct 2026 22:44:59 -0400
Message-ID: <20261014024429.1774154-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101251-valiant-haunt-74b5@gregkh>
References: <2026101251-valiant-haunt-74b5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 6b7c001eb5857fa09041f47673666060a2e5fc1c ]

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
[ sashal: Adapted the checks to the pivot_root syscall implementation using goto out4 instead of return -EINVAL. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 769f22c0bc66d..f8e063a69f3ec 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3884,14 +3884,15 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	new_mnt = real_mount(new.mnt);
 	root_mnt = real_mount(root.mnt);
 	old_mnt = real_mount(old.mnt);
+	/* only a mounted mount has a parent that namespace_sem pins */
+	if (!check_mnt(root_mnt) || !check_mnt(new_mnt))
+		goto out4;
 	ex_parent = new_mnt->mnt_parent;
 	root_parent = root_mnt->mnt_parent;
 	if (IS_MNT_SHARED(old_mnt) ||
 		IS_MNT_SHARED(ex_parent) ||
 		IS_MNT_SHARED(root_parent))
 		goto out4;
-	if (!check_mnt(root_mnt) || !check_mnt(new_mnt))
-		goto out4;
 	if (new_mnt->mnt.mnt_flags & MNT_LOCKED)
 		goto out4;
 	error = -ENOENT;
-- 
2.53.0

