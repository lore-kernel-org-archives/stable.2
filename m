Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95D8EACD
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065616; cv=none; b=aPaTTuRFXW20xe2Kb3NAimWa55w0xq0/jMKIAiJTNJqm4Lo8upV7e5EzDLnIX2/4x2UVSUHWLuxnqmwxViY4YjBRYK6eKBpQDVTPVmllA7m7nSSy0xM2DZnjSnIn4u+Q6nxrPhbsuM2L2xTW2F0L1vZaZRNF0XgAA8FAaF1sVDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065616; c=relaxed/simple;
	bh=0xPEGfs2iC33caxfJ4bg0PxJpJATZjRbe6UhD2CwwpE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B4H5BNzzDjLVy2wHB7fC4454i5rQLGzlD8iPsUuASuxE7hdr5/FDozJjC0lLGY+kuI8GhD+f/ZhXrhBKup441HQECSw6ft3VdcXN5bbdcd4cFbtpw2fxSqDRdesYsdRm3Mv3XUNe7zw6F1hjuOINzd8F9VFPPpvPVN7vYHTV89E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vMxnM7LY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vMxnM7LY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BA91F000FF;
	Tue, 22 Sep 2026 08:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790065614;
	bh=LDKk88uCp/8E6pfx7iZ8W+aZwR0Sy/f9vS3WUYHzKNk=;
	h=Subject:To:Cc:From:Date;
	b=vMxnM7LY9qCDTx02+UoGdz9kUBV/Rrh/Hr4YmzEq4tT8AmzsIAIX87aQgDfuiNkyT
	 KqcjfpA3PjHNmUyUgQUMy0S6c6sN3RbIKKaqk//JQ4spOYYXagEQzoDaP+r8iIwLRO
	 L5AH8nQE8uh6fpGywJJd8P+cfhRPBQFboYrKlqjA=
Subject: FAILED: patch "[PATCH] fs: fix missed removal of super_fs_objects_eligible()" failed to apply to 7.2-stable tree
To: qi.zheng@linux.dev,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,brauner@kernel.org,david@kernel.org,hannes@cmpxchg.org,hughd@google.com,mhocko@kernel.org,muchun.song@linux.dev,roman.gushchin@linux.dev,shakeel.butt@linux.dev,stable@vger.kernel.org,usama.arif@linux.dev,zhengqi.arch@bytedance.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 10:26:50 +0200
Message-ID: <2026092250-stool-feed-1f18@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 641aade99f06df0037e52b5c81645461b7132947
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092250-stool-feed-1f18@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 641aade99f06df0037e52b5c81645461b7132947 Mon Sep 17 00:00:00 2001
From: Qi Zheng <qi.zheng@linux.dev>
Date: Mon, 17 Aug 2026 17:03:25 +0800
Subject: [PATCH] fs: fix missed removal of super_fs_objects_eligible()

Commit 0ef8faff490be ("fs: push nr_cached_objects memcg gating into
individual filesystems") was meant to drop the blanket memcg gate in
fs/super.c and let each ->nr_cached_objects() implementation decide for
itself whether it is meaningful in per-memcg reclaim.  However, when
that patch was applied the removal of super_fs_objects_eligible() and
its two call sites in super_cache_scan() / super_cache_count() was
lost, so the helper is still gating every ->nr_cached_objects() hook
and 0ef8faff490be is effectively a no-op.

Consequences of the leftover gate:

   - XFS's inode-reclaim hook, which is intentionally driven from
     per-memcg contexts to free memcg-charged slab, is still
     short-circuited in fs/super.c  exactly the regression from
     commit 0baad6f9b997 ("fs/super: skip non-memcg-aware
     nr_cached_objects in memcg slab shrink") that 0ef8faff490be was
     written to undo. Memcg-charged XFS inode slab therefore keeps
     piling up under per-memcg pressure until global reclaim kicks in.

   - Any future ->nr_cached_objects()/->free_cached_objects() that
     grows memcg awareness is likewise blocked before it can run, so
     filesystems cannot opt in to per-memcg reclaim on their own
     defeating the whole point of pushing the gating decision down
     into the callbacks.

Drop the leftover helper and its call sites so the intent of
0ef8faff490be actually takes effect.

Link: https://lore.kernel.org/cover.1786955972.git.zhengqi.arch@bytedance.com
Link: https://lore.kernel.org/3b038d373c70ebac7cdabfb0035bb91d1d6e6cfe.1786955972.git.zhengqi.arch@bytedance.com
Link: https://lore.kernel.org/all/20260715103516.2410175-1-usama.arif@linux.dev/ [0]
Fixes: 0ef8faff490b ("fs: push nr_cached_objects memcg gating into individual filesystems")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Usama Arif <usama.arif@linux.dev>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/super.c b/fs/super.c
index 05e443173038..3ecce24328f6 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -171,19 +171,6 @@ static void super_wake(struct super_block *sb, unsigned int flag)
 	wake_up_var(&sb->s_flags);
 }
 
-/*
- * The s_op->nr_cached_objects hooks (used for example by btrfs and xfs)
- * operate on filesystem-global state and ignore sc->memcg. Driving them
- * from per-memcg shrink_slab_memcg() invocations only burns CPU walking
- * per-cpu counters and queueing duplicate work: the actual reclaim happens on
- * the global path (kswapd or root direct reclaim) regardless. Restrict them
- * to that path.
- */
-static inline bool super_fs_objects_eligible(struct shrink_control *sc)
-{
-	return !sc->memcg || mem_cgroup_is_root(sc->memcg);
-}
-
 /*
  * One thing we have to be careful of with a per-sb shrinker is that we don't
  * drop the last active reference to the superblock from within the shrinker.
@@ -213,7 +200,7 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 	if (!super_trylock_shared(sb))
 		return SHRINK_STOP;
 
-	if (sb->s_op->nr_cached_objects && super_fs_objects_eligible(sc))
+	if (sb->s_op->nr_cached_objects)
 		fs_objects = sb->s_op->nr_cached_objects(sb, sc);
 
 	inodes = list_lru_shrink_count(&sb->s_inode_lru, sc);
@@ -274,8 +261,7 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 		return 0;
 	smp_rmb();
 
-	if (sb->s_op && sb->s_op->nr_cached_objects &&
-	    super_fs_objects_eligible(sc))
+	if (sb->s_op && sb->s_op->nr_cached_objects)
 		total_objects = sb->s_op->nr_cached_objects(sb, sc);
 
 	total_objects += list_lru_shrink_count(&sb->s_dentry_lru, sc);

