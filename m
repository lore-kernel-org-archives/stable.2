Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BE65372F2
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917571; cv=none; b=n+y0rW5HJRH1z3eDJpmR3R99eRFgpVum/KRbklc1X/7kqmoKVdtCVYmcj34TLg26YNqNKvxoi/5fYyb+AwuYNaMsFwcgZP6neoJSjK2bTj9c9GhrknAJaEI9ZHBqrCFM/dKcj0pm1OtECL7SmsuSzc2ZIULxIsjisRShbHPEPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917571; c=relaxed/simple;
	bh=Z10U/r56uh8COEqp9gyd+IxN9LDZxvGWYpAiXtnuix4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhIkFxn34em+jZKyN8Crg75cN7A8DPemzChnFHs5UuspZOKpZZQiaPim7M1KNEhIHplbHVq/NO9ru7mi2AP+JTOhl2aJr4fAzEd3HOAEHJLOaeHJnLH/uNoWJTyrxKO39Szr37im7X69mcl6fdm0IjEQV+4lbY7AVxdmdp0Z7JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVWqJEhc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVWqJEhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536CB1F000FF;
	Tue, 13 Oct 2026 18:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791917569;
	bh=RY+VhlIsQHIz66KzWuiZl7RJIV1VfCe8KveoSBcAtlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oVWqJEhcigIpVuHeqqnAoX86Z0rETLTHsVf8zqtZDF4NkM4+gwGWhAhaLxO5/4gx4
	 egzr+jmvGCqmL0fG45WZYciXGf7PQIrXiBIvaRSJc7w8T+RJmCgG5dIsre0S7Um7jt
	 yCe54yYN7ltx1VhVWZJUFWm5LPKkn/x+f9piM5XvHcUPXLoLZJCZocFQl/vJMLfj6j
	 cBDzxrcVvfhoB9qWy8qEoAprQPtjzr4Sq/Vu70LN7fdjgGA6BXPwNQpRXRbX7TN4Uy
	 Yvdq3j52Rq07UThFm5/CtYDxBBN7DEzMPV2Xn7k+MM2Bd1FbeDZmtgDoqnE0N+uMPj
	 kVm9Ap0mc4GoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] namespace: check the target before walking it in do_mount_setattr()
Date: Tue, 13 Oct 2026 14:52:48 -0400
Message-ID: <20261013185202.653837-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101257-raisin-lustily-ecda@gregkh>
References: <2026101257-raisin-lustily-ecda@gregkh>
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
[ sashal: Replaced unavailable anon_ns_root() with equivalent checks using existing mount and namespace helpers. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index f87bdff661664..a207aef47ff90 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4713,6 +4713,13 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 		 * propagation.
 		 */
 		namespace_lock();
+		/* invent_group_ids() walks the tree, only walk a mounted one */
+		if (!is_mounted(&mnt->mnt) ||
+		    ((mnt_has_parent(mnt) || !is_anon_ns(mnt->mnt_ns)) &&
+		     !check_mnt(mnt))) {
+			namespace_unlock();
+			return -EINVAL;
+		}
 		if (kattr->propagation == MS_SHARED) {
 			err = invent_group_ids(mnt, kattr->recurse);
 			if (err) {
@@ -4725,6 +4732,7 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 	err = -EINVAL;
 	lock_mount_hash();
 
+	/* Checked under namespace_sem already if the propagation changes. */
 	/* Ensure that this isn't anything purely vfs internal. */
 	if (!is_mounted(&mnt->mnt))
 		goto out;
-- 
2.53.0

