Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADDB52B1C5
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791920300; cv=none; b=InSYxgO2M42j8L18b4YTyTZbecfKxptrb2NIwWMFU6N0LNSmGEoukbTCo3jCYQBFFb1Xh/sfpTvESbI79qoXTrTbdYH5ZuDLnWvzENObn+IOp62B/A4TMHHTboD/OKZHzhtd03XnGoiMmnbBLS6Bmhyme1clg9mz8C+AKkTLS/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791920300; c=relaxed/simple;
	bh=vnqi5HjSjnhUijERoj4GYUEH6LwL1FpWpuTyfhoOMQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhPfciK1tFN6Mez3QBvgJro6toa8ZsTguT/8QXCuBoYq5/QLg5FDhXHErmAuGbd1DjW8dNNjcsGMNpyUIM+IUK2F5UFhBO1bqpbWn2Z5ppxhSu6o/4LIF8C4ojXvlTEim9sf2aUaWCvHiYX/D0i1FAc6ZzL5qlz53OTUvsNRz+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmvycDwd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmvycDwd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A471F00898;
	Tue, 13 Oct 2026 19:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791920298;
	bh=g5mi6ZdOxIYpIDWUtrFDRTcKzx+tjj5VkAfo3Md6tEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RmvycDwdkXh6Q7g9AxWiC9AvxuMaBtyBRK02aMbBkLb2DDfarFqbgdRmNFeoK+o9+
	 KDBsYmSyiAZ7mJwzNw5W3EdzJp/F/5A7xODmqJ+ojmJy4yzsEhhbS6R8HYb7tk4x2N
	 I6xgykdZfJASxIbATapultW4/x9fI8SBQmeBQSTft7LVBQMvv3NHlfGmDNKqMfuvnB
	 qRDyiReRfDWvE6lztzWR1xdkYQuk7CI9fa5O070TqHQg3A3J+sg9/F0MqZAosgOezl
	 T5RqR07mvbssDOt1pHEKRaUp9Rn434id3qUVpkl32rY8BvMR1aLokR4ChDwQU/2d/Y
	 U7Ri/qayUmJew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] namespace: check the target before walking it in do_mount_setattr()
Date: Tue, 13 Oct 2026 15:38:17 -0400
Message-ID: <20261013193735.855575-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101206-tag-crisply-1381@gregkh>
References: <2026101206-tag-crisply-1381@gregkh>
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
[ sashal: replaced anon_ns_root() with explicit checks using existing mount helpers. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 42ecf070b6f76..63ccd426fb4ee 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4213,6 +4213,13 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
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
@@ -4225,6 +4232,7 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 	err = -EINVAL;
 	lock_mount_hash();
 
+	/* Checked under namespace_sem already if the propagation changes. */
 	/* Ensure that this isn't anything purely vfs internal. */
 	if (!is_mounted(&mnt->mnt))
 		goto out;
-- 
2.53.0

