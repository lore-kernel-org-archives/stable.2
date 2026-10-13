Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271E3556BA6
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932693; cv=none; b=M9SZ0+BgPwBZppeXXMJzgWgJl9bsaVkogMEeroEPaxwAQPkIXEogqs0wB0yrD1KeJKKn4CrzlVWG12NTv35K2qTvtreA2+KVF7yDdUGs3UuMrNqdw/X1C2p9A2dhMVIPbs0WUyaQ9pID+Xp1MQH3zWd5PsBmvCQSJhphJaJ1cyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932693; c=relaxed/simple;
	bh=jsjSWrOf7uf5EXf93OM0RwNcoibCW2ls/3jH/W1rRFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjSAsd/dkC2NC1xtAqjYOrE59KVagCdndIZv9AQq2lxWiEaRFwdD2ZH7TyKxWzM11JiD0LndyGJhfoBZf6qioS6daXAJXuDiq8Y94jja/9gD1NFYcBydteUChO0A0ZVlw/cx6R6C0k5K7/d3K2oY7PvlKJtGc1OMyp8F5maL++w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOzG21y6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOzG21y6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189011F000FF;
	Tue, 13 Oct 2026 23:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791932690;
	bh=E2922ulcQWuImm8Hx4Mj4kqyRIPCWBZ2c6J2nybU0QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BOzG21y6uvkJKJdFoyaMBmiOLd5N5bGvIjQ6Is5fgY9j/gHQ651+jUQMwowivcWx6
	 cwDL4gy0WTnTVWQ2r9dw4bJhAwRYsFDbTSnjBUJ+IcP0eas09FMFczksOsEowBoO6a
	 AMu19htTTE3WHdw57GRUFdQBPZZMX9TDeLi1DDwLMllBXevPdZMxFWG53ZrL4q1I2p
	 pALLbK/WHO0OMpHJBsbMijCKTmMkqsvImrqrzM+/GM+Vzqmxyqso5q/0BE2CzLZjeS
	 uzFV8P212z5UdIy95TPDdB/hmBU3k7hF9pWZ/nBjqSEq6fcu38dI/81cogNpCDS4a9
	 ltm3LYM2rkLug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] namespace: check the target before walking it in do_mount_setattr()
Date: Tue, 13 Oct 2026 19:04:48 -0400
Message-ID: <20261013230341.1058210-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101210-barge-alkalize-e6de@gregkh>
References: <2026101210-barge-alkalize-e6de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 08f4288a37ef4b3d19b4a9599ec3048219cac828 ]

When mount_setattr() changes the propagation type to MS_SHARED
do_mount_setattr() takes namespace_sem and calls invent_group_ids()
which walks the whole target tree with next_mnt() and allocates a peer
group id for every mount that doesn't have one.

Whether the caller may touch the target at all is only checked
afterwards under mount_lock. If it may not, cleanup_group_ids() walks
the tree a second time on the way out to free the ids again.

A detached tree that a file descriptor keeps alive, a mount in another
mount namespace or a mount below the root of an anonymous mount
namespace does a bunch of allocation work that is completely useless
because it will fail and revert right after.

Do the right thing and check the target right after taking namespace_sem
instead. A mount leaves its namespace only under namespace_sem so the
mount stays stable. The check under mount_lock stays for the case where
no propagation change is requested and namespace_sem isn't taken.
Callers get the same EINVAL as before.

Fixes: 2a1867219c7b ("fs: add mount_setattr()")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260926-work-mount-fixes-2-v1-5-f357abf3d17b@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ sashal: Replaced anon_ns_root() with existing mount eligibility checks guarded by is_mounted(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index ff8d16a3eeb2d..e81aa0fdb397b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4063,6 +4063,7 @@ static struct mount *mount_setattr_prepare(struct mount_kattr *kattr,
 {
 	struct mount *m = mnt, *last = NULL;
 
+	/* Checked under namespace_sem already if the propagation changes. */
 	if (!is_mounted(&m->mnt)) {
 		*err = -EINVAL;
 		goto out;
@@ -4172,6 +4173,13 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 		 * propagation.
 		 */
 		namespace_lock();
+		/* invent_group_ids() walks the tree, only walk a mounted one */
+		if (!is_mounted(&mnt->mnt) ||
+		    !(mnt_has_parent(mnt) ? check_mnt(mnt) :
+		      is_anon_ns(mnt->mnt_ns))) {
+			namespace_unlock();
+			return -EINVAL;
+		}
 		if (kattr->propagation == MS_SHARED) {
 			err = invent_group_ids(mnt, kattr->recurse);
 			if (err) {
-- 
2.53.0

