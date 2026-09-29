Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9DA37CD33
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689955; cv=none; b=FZPYkujSlmK+wpN58WTMZNMu6gCUc4gqoLRFeRKKC2+0wRdebK6e6JFonGcQKB+QN2nMsxdz1NrHvQQpmEVm5x4Gl32irFI/bGp74dHM1wxhNYaBE0x+9+k/VVxPCGT3nWZaehThesSsfVQt/bcFmnAjt8VXAYKMuB52zCFb8LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689955; c=relaxed/simple;
	bh=XRCPqYUjJXRf6MLfVDLPZAJ+WEAtcCGP8dnA0jy6Mxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMBHHhAIpKo4tAEa5vl4OmsqOCTqg/SNolWapJkmFzop6Ce6NnAoSBOuzro3TCqKr3SdikbbsqurIUf2dPwPs8/GfNqkejBZlUioeLYxwgBAO37aG/5hk+RWnhLAtlCf3u5g7QZZZvX2UIkSAtRrwt8euHejvGqCar/J5ldZXk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nk1dDbKV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nk1dDbKV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366601F0089A;
	Tue, 29 Sep 2026 13:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790689953;
	bh=Gwb5It4Uy9w8eNIyqNdPNWlorYJMEBGp4fzEN0sHaDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nk1dDbKV4O7DutV0P0SGtss0BWjrEMURJD8rMXVHpalC6dTDSBpdN/kS4Hb2t9vdm
	 AncpixqRWhXSeyFhsxQ41HQwW7N2Qfynk173hm5CtEXi9SmTffuonnWL2dVtfXC3Po
	 hEAkUNWu8n4VO2kmtq6btbFC5EK8xdkXwj0iDbzy/EHY51QzZMEdBN35pNLeATFLVy
	 6uGGci9fEk803ExaaiUFNneC1zxD6ftCIAuBXf/8iEd9tQkJ/puVKmre7Us6ZBLgHX
	 fqTK2ZAmpG6kAy2QAQq4pKiDOjb1D31AiLnrh4VU/4t/NyE1vUnK9Yopyz6HWxEcUo
	 R7Gd5+p0EsLww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 3/3] super: make iterate_supers_type() deletion-safe
Date: Tue, 29 Sep 2026 09:52:30 -0400
Message-ID: <20260929135230.3522081-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929135230.3522081-1-sashal@kernel.org>
References: <2026092911-clunky-same-c5c5@gregkh>
 <20260929135230.3522081-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 2d2a2d7aa98741b58f54cacc99b52024e4d865f9 ]

iterate_supers_type() drops sb_lock while invoking the callback and keeps
only a passive reference to the current superblock. That reference keeps
the object allocated, but does not keep its s_instances node linked.

After the iterator releases s_umount, final teardown can unlink the current
s_instances node. The iterator then advances through a reinitialized node.
With the current hlist it stops without visiting the remaining superblocks.
The unlink moved from generic_shutdown_super() to kill_super_notify(), but
the cursor lifetime has been unsafe since the helper was introduced.

The CIFS DFS lookup can consequently miss a matching superblock and return
-EINVAL.

Move removal from fs_supers to put_super(), alongside removal from
super_blocks, so a passive reference keeps both list nodes linked. Keep
the filesystem module reference until then, since unlinking s_instances
may touch type->fs_supers.

Make sget_fc() skip SB_DEAD superblocks before invoking test(), and set
SB_DEAD under sb_lock to serialize with those callbacks. This allows
kernfs to free its private information after kill_anon_super() returns.
Keep matching SB_DYING superblocks until SB_DEAD is set so concurrent
mounts still wait for teardown before retrying.

Fixes: 43e15cdbefea ("new helper: iterate_supers_type()")
Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
Closes: https://lore.kernel.org/r/20260903013336.92081-1-kmehltretter@gmail.com
Suggested-by: Jan Kara <jack@suse.cz>
Cc: stable@vger.kernel.org
Tested-by: Karl Mehltretter <kmehltretter@gmail.com>
[kmehltretter: supplied the commit message]
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Link: https://patch.msgid.link/20260909193034.7467-1-kmehltretter@gmail.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ adjusted kill_super_notify() context for missing device-to-superblock table cleanup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/kernfs/mount.c |  4 ++--
 fs/super.c        | 39 +++++++++++++++++++--------------------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index f183a96778b9a..a57399021c8b0 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -434,8 +434,8 @@ void kernfs_kill_sb(struct super_block *sb)
 	up_write(&root->kernfs_supers_rwsem);
 
 	/*
-	 * Remove the superblock from fs_supers/s_instances
-	 * so we can't find it, before freeing kernfs_super_info.
+	 * Mark the superblock dead so sget_fc() can't find it,
+	 * before freeing kernfs_super_info.
 	 */
 	kill_anon_super(sb);
 	kfree(info);
diff --git a/fs/super.c b/fs/super.c
index 2399bb3a17527..addf3ad54a583 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -410,15 +410,19 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 void put_super(struct super_block *s)
 {
 	if (refcount_dec_and_test(&s->s_passive)) {
+		struct file_system_type *type = s->s_type;
 
 		spin_lock(&sb_lock);
 		list_del_init(&s->s_list);
+		hlist_del_init(&s->s_instances);
 		spin_unlock(&sb_lock);
 
 		WARN_ON(s->s_dentry_lru.node);
 		WARN_ON(s->s_inode_lru.node);
 		WARN_ON(s->s_mounts);
 		call_rcu(&s->rcu, destroy_super_rcu);
+		/* The unlink above may touch type->fs_supers, so drop it last. */
+		put_filesystem(type);
 	}
 }
 
@@ -430,24 +434,17 @@ static void kill_super_notify(struct super_block *sb)
 	if (sb->s_flags & SB_DEAD)
 		return;
 
-	/*
-	 * Remove it from @fs_supers so it isn't found by new
-	 * sget_fc() walkers anymore. Any concurrent mounter still
-	 * managing to grab a temporary reference is guaranteed to
-	 * already see SB_DYING and will wait until we notify them about
-	 * SB_DEAD.
-	 */
-	spin_lock(&sb_lock);
-	hlist_del_init(&sb->s_instances);
-	spin_unlock(&sb_lock);
-
 	/*
 	 * Let concurrent mounts know that this thing is really dead.
-	 * We don't need @sb->s_umount here as every concurrent caller
-	 * will see SB_DYING and either discard the superblock or wait
-	 * for SB_DEAD.
+	 * sget_fc() skips SB_DEAD superblocks and calls test() under
+	 * sb_lock, so set it under sb_lock: once we return no test()
+	 * runs on this superblock anymore and none will start. Everyone
+	 * else already saw SB_DYING and either discarded the superblock
+	 * or waits for SB_DEAD.
 	 */
+	spin_lock(&sb_lock);
 	super_wake(sb, SB_DEAD);
+	spin_unlock(&sb_lock);
 }
 
 /**
@@ -474,7 +471,6 @@ void deactivate_locked_super(struct super_block *s)
 		list_lru_destroy(&s->s_dentry_lru);
 		list_lru_destroy(&s->s_inode_lru);
 
-		put_filesystem(fs);
 		put_super(s);
 	} else {
 		super_unlock_excl(s);
@@ -661,12 +657,12 @@ void generic_shutdown_super(struct super_block *sb)
 	}
 	/*
 	 * Broadcast to everyone that grabbed a temporary reference to this
-	 * superblock before we removed it from @fs_supers that the superblock
-	 * is dying. Every walker of @fs_supers outside of sget_fc() will now
-	 * discard this superblock and treat it as dead.
+	 * superblock that it is dying. Every walker of @fs_supers outside
+	 * of sget_fc() will now discard this superblock and treat it as
+	 * dead.
 	 *
-	 * We leave the superblock on @fs_supers so it can be found by
-	 * sget_fc() until we passed sb->kill_sb().
+	 * sget_fc() keeps finding the superblock until SB_DEAD is set, so
+	 * a concurrent mounter waits until we passed sb->kill_sb().
 	 */
 	super_wake(sb, SB_DYING);
 	super_unlock_excl(sb);
@@ -745,6 +741,9 @@ struct super_block *sget_fc(struct fs_context *fc,
 	spin_lock(&sb_lock);
 	if (test) {
 		hlist_for_each_entry(old, &fc->fs_type->fs_supers, s_instances) {
+			/* Only unlinked at the last passive reference. */
+			if (super_flags(old, SB_DEAD))
+				continue;
 			if (test(old, fc))
 				goto share_extant_sb;
 		}
-- 
2.53.0

