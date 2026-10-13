Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8225349CC
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918422; cv=none; b=HACnaXy3rCiRLos9PyV/4oxVNCtvpXxzi3eFNdOUn+VL4NNqOtVVYLntmBUw5agbgxIGmHhujJz+k39GY4+2raN/fgawbM8/9C1ABNS+S1jEPjGQi45YTHb4unH2uNwMe5MB30zSUKZZrFM6Xv9PWn/byF/tvAOwhFFQcLZxtcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918422; c=relaxed/simple;
	bh=fYi1h53Cv+XGdedZcLFVl4B5vljwt9RH55t6e/FPCQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJhUkKJfrLJfVEdM0+wo17SwF3Y+Sm01B6kIZDMQc+ijVmNPCJefVqawjSBLNKTuNEpymF1c3Wg7VuXcliQ7UoN21LUVBxn1KZ/2AGfdipOcJLXuwanG371v1QUZppMRS+234xPTwmE/qt/dVDI3TWDVmvqN9yPi7Thi8rUO4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FN+jsjSr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FN+jsjSr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72CC1F000FF;
	Tue, 13 Oct 2026 19:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791918421;
	bh=JCJ//6wrtwXvavoX8tclxcY4PjoRbJB+Iba6Gi66dAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FN+jsjSrW0WWOrlGimF7Al6L5HVVazNyRDhnRktqoiDPVhkpiUBaslBJLiyhKQPS5
	 5UnJs0AVWNlewvRe67lIeoGZPLug/kBGXtUVXa0p04If6/yX9Nu1oy8PR36U0WxoOI
	 s/vSIteKzrw2N8SAQqLvXV5HZDV8YAC5gIUOBeHdX5nCEjPSFpyEJrGXIGRJy4ymxZ
	 swl2yxupjF+JUsvbCJ+KFNIlMVUYvbVsLY1L2EIIDo0gPPJQVjdqcEH1HOQOLjrQRf
	 VRAGdZwSl/SoaGYfnttGaLtRR9XkDRpxkORaBWh12Zl169PZQbLqWYHGA/EZQ7J6zX
	 yFS37ba8BeKiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] namespace: check the target before walking it in do_mount_setattr()
Date: Tue, 13 Oct 2026 15:06:59 -0400
Message-ID: <20261013190624.829930-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101201-thrower-fascism-1179@gregkh>
References: <2026101201-thrower-fascism-1179@gregkh>
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
[ sashal: replaced anon_ns_root() with explicit checks using is_mounted(), mnt_has_parent(), and is_anon_ns() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3311e4edbc734..3ef78370ed297 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4524,6 +4524,13 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
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
@@ -4536,6 +4543,7 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 	err = -EINVAL;
 	lock_mount_hash();
 
+	/* Checked under namespace_sem already if the propagation changes. */
 	/* Ensure that this isn't anything purely vfs internal. */
 	if (!is_mounted(&mnt->mnt))
 		goto out;
-- 
2.53.0

