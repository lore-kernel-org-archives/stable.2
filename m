Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF60D3A83AC;
	Sat, 26 Sep 2026 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790430309; cv=none; b=Vt/JgVSWBES5UhZXBDMkBvgU1T1oKi//HWSAioPBWBZfAdtb6nzzVRL+TPnDDwIUelM/X+qwJqiZRpjM7nRefu+iJA2tQ/0Su4kopFvoZUTE5rzl8CK329Dcy2ciT9Bc/rCyTE+iYCDQpApyf7ybaSYJCE6dLV977PdxQZRPOj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790430309; c=relaxed/simple;
	bh=6cdALDwvy9Pvr2FgvR66gxhqT9o7/4iyapYCJHIv56g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a79X5eAcBAAMalApdURbe1cMRmWH1iMrfV0+unT+gWIdNhKCW8fsV0ofJQpQWJpVI1q87qexauHvnj172dkcQXVfFyjJKhr075JmoOVIpkR1zMaM6coVE1R7XSbGEsITLqJec/GKGK793lgLTwtaZhAFscpOrNSPQqlJbwesPho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAQ0GpdE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAQ0GpdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A491F000FF;
	Sat, 26 Sep 2026 13:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790430307;
	bh=AvtGJR2jYLthiursZ/IVSSS3cZlVfS/SUFs/g+loBMo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GAQ0GpdEptYc+JGV5Yg8ptW/inKQkLlC0vBczukVmVeMYXlE3+CMjeD63qSLWN7BW
	 LYttNBo5NvuXYe3I+xboK0e8JBIyfZv3G758zc9Q8b37FpNPpi2j+Oip2Yeni0yHhS
	 TNYDdSegTu5wc6TP+OARDSj6mW8c4ZF56mNpoAqVliTd0+CvcdlGJforv3YGd1hW7n
	 KjPmepiyyvbyZfVcPZRTHwNuGXfVtizA8qVz7G0KQcxkuV6RcipSMOygcLefUDgt10
	 OydZYT0xBs0Dr72+B7uUvohvpi1dFPPyhf6UaI7OB7ICsux7OTQ4YztvqJPvu5019y
	 QHPJt9ZTmcwCA==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 26 Sep 2026 15:44:25 +0200
Subject: [PATCH 02/10] statmount: read the parent of an unmounted mount
 under mount_lock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-work-mount-fixes-2-v1-2-f357abf3d17b@kernel.org>
References: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
In-Reply-To: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2500; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6cdALDwvy9Pvr2FgvR66gxhqT9o7/4iyapYCJHIv56g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtPxOlqLP9oW6yZuB7GVHvs44p4cFxn2z3HZnLJ7pj9
 s8n29YadJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkaxDD/3BusUVpbYfFvqpb
 prov+p118sdp+YtfrJ9VzQ1ddPqqQAsjw4K6e5LBJ8+EVMjH14hMYtpSIvfrywULsyiNon8Phfh
 nsAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

statmount_mnt_basic() reads the ids of the parent through m->mnt_parent
with namespace_sem held for reading. That's fine for a mount that is
in a namespace. Everything above it is pinned by that namespace.

STATMOUNT_BY_FD also accepts a file descriptor on a mount that has
been unmounted on purpose and that only the file descriptor keeps alive.
If that mount stayed attached to its parent when it was unmounted the
parent is unmounted as well and nothing pins it for the child.

The final mntput() unmounts the children under mount_lock alone and
frees the parent afterwards. Concurrently, statmount_mnt_basic() reads
m->mnt_parent twice while that can happen and can easily dereference a
mount that's already gone.

Read the parent of an unmounted mount under mount_lock. The parent
can't be put while it is held and both ids come from the same mount. A
mounted mount's parent is pinned by the namespace and a mount can't
leave its namespace while namespace_sem is held, so the common case
takes no global lock.

Fixes: 0e5032237ee5 ("statmount: accept fd as a parameter")
Cc: stable@vger.kernel.org # v7.0+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 230f95675a93..d1e8dd2e1e8e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5335,15 +5335,25 @@ static void statmount_sb_basic(struct kstatmount *s)
 	s->sm.sb_flags = sb->s_flags & (SB_RDONLY|SB_SYNCHRONOUS|SB_DIRSYNC|SB_LAZYTIME);
 }
 
+static void statmount_mnt_parent(struct kstatmount *s, const struct mount *m)
+{
+	s->sm.mnt_parent_id = m->mnt_parent->mnt_id_unique;
+	s->sm.mnt_parent_id_old = m->mnt_parent->mnt_id;
+}
+
 static void statmount_mnt_basic(struct kstatmount *s)
 {
 	struct mount *m = real_mount(s->mnt);
 
 	s->sm.mask |= STATMOUNT_MNT_BASIC;
 	s->sm.mnt_id = m->mnt_id_unique;
-	s->sm.mnt_parent_id = m->mnt_parent->mnt_id_unique;
 	s->sm.mnt_id_old = m->mnt_id;
-	s->sm.mnt_parent_id_old = m->mnt_parent->mnt_id;
+	/* An unmounted mount is cut loose from its parent under mount_lock alone. */
+	if (likely(is_mounted(s->mnt)))
+		statmount_mnt_parent(s, m);
+	else
+		scoped_guard(mount_locked_reader)
+			statmount_mnt_parent(s, m);
 	s->sm.mnt_attr = mnt_to_attr_flags(&m->mnt);
 	s->sm.mnt_propagation = mnt_to_propagation_flags(m);
 	s->sm.mnt_peer_group = m->mnt_group_id;

-- 
2.53.0

