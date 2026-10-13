Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350244A4F04
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932682; cv=none; b=naa3ifRjeyBV7KJK5e+3RuJIurzd+AImmohKUYVT8WnKmOibCzfY9PhPuv3lO0Zsj3rccuaAAERCR9bTCSEjEqoXfm1AGGDyBkm3ienFWoLILx1vuwiqQd4SyzFoymdP/zO8IAZan6z2Iqp9QbfgwVoK0m5OMvqIPyMSKJMey5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932682; c=relaxed/simple;
	bh=CvXlApr1sqSpr8FrQqLIrLk4T/FLmkGUqGoITcrtRBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcL+JYFFsXqFZbP0YLOeMDwj1fpVt6f7RWTG0UUziBCruZ4zEgpIbFFYWMzn9dDbbDdMkRsc+QqmTamTxmU74kkYAHsh5A28Dc4lr6xBJe1JUHjINfy/ePWbXKIUedM+i1tiXarQjxUThnpqkc4hnsUWfC1iuf4ZWZtMT2xDYrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naZjI7oD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naZjI7oD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833841F000FF;
	Tue, 13 Oct 2026 23:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791932679;
	bh=LWaMdoQH8fF3wIGP7V43eOHnJkSv9twBYr8AnSCYPfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=naZjI7oDKDjMOJ1iRJlrReoQnQVwtqtn0tDhGUDXDIHgPEM1z6vR/SE/tM30lXFoL
	 uvCwRlppXAm6J2Tul3oc0/GuwZp2Y5YIc8mQk1dk4CnwX1NODJOaemoTzeSLoY5fNI
	 yPkJMAOTss6A42SmuzTLb44tXAmNucCtoMMCprLCKZkxI8s7V5yHdNGxLMeLtkxgMJ
	 9N/alWCrJFM/Tfdg1QflpeGkZ7YaDKpSs9QGYT3tSaTfcX83XuUYCGRO/ckqBBtcim
	 0zP6NNDo8P3sWho+RbZkgsb1hizSZjUp/HaLdFkLxnD1mX6hNtgO+5ElugYO7JE8xW
	 vASitCXIlcS/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] namespace: check the mounts before reading their parents in pivot_root()
Date: Tue, 13 Oct 2026 19:04:38 -0400
Message-ID: <20261013230341.828552-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101249-monogram-subscript-9e06@gregkh>
References: <2026101249-monogram-subscript-9e06@gregkh>
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
[ sashal: replaced return -EINVAL with goto out4 in the inline pivot_root syscall ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3311e4edbc734..5ba59fe4f3e42 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4282,14 +4282,15 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
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

