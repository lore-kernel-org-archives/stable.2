Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554D9542804
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079570; cv=none; b=Z2bqcifH4t57pEjlDQ33LoMHLs8vJQ/pkOxChcBJtWuRLdimuetHHbCWvS+92vwGC4xTCDFK4grz0l0sYZY7n92+XxsvROtM/jhw31DDk81v0DZYXcYEEYjVOizsZQA8vLrIxIWh7CPCih3Oq8yAod0Cpf5j4RsaEFbFATpw1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079570; c=relaxed/simple;
	bh=vQpKIRepio16cOuzTLhJ/Lh+fAWs2FUnLjVje43ysJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpYmG5Dse17O9BgSU/h0DgPNGWXH2mwB7XDLYt7WdnLkM7trPldt0iU2hNRTs5gFutM7c3nX35zV6xF7oT3kZ4OXX7jhFwkJHJnQnPjfgFeuz4fViUoF2JgJOv4zvqQujiDhQ2mMWCnT3t6DtFhcXxHatwIUg6VJqvW11L2DmjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGrtrJYn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGrtrJYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA3C1F00899;
	Tue, 22 Sep 2026 12:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790079569;
	bh=Vo4DUuzeQNKSY6R1oz+1ethLOEmfpKhmamHd3/ogwIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JGrtrJYne7Cxuh+ipMazMyhqEQ2kp63/4UvSrkyhKfwD0S2ZIRCTgcDNQIe5/d4zW
	 F71uOUEcBNUUSo1SenglBAa5jMRxt8xFZj7b44Q8ToZqFR+CuBE5la0AdDgW5HwKQN
	 KR+cAbDNSpkFaDDQalGAkZxj+T7UxbupV191gTJOAtZpRC459sWoSE3bkK+/89xu6r
	 AelPDe+B2tDP91Z5oILn8W3H5/prrfzEIiAPhSDeTDDqyX9keOoB/seh1kzwUEpz7s
	 uvMnkt2e1m99LIbPmKr6k7SaXEjLPftURR/cIrgGogcBLsX6DpuL9Jg6nGd5FTg2k8
	 kB0IrDLYK3jkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qi Zheng <zhengqi.arch@bytedance.com>,
	Usama Arif <usama.arif@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] fs: fix missed removal of super_fs_objects_eligible()
Date: Tue, 22 Sep 2026 08:19:25 -0400
Message-ID: <20260922121925.2214152-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922121925.2214152-1-sashal@kernel.org>
References: <2026092250-stool-feed-1f18@gregkh>
 <20260922121925.2214152-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qi Zheng <zhengqi.arch@bytedance.com>

[ Upstream commit 641aade99f06df0037e52b5c81645461b7132947 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/super.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index feac9ba5abe81..a257b154f7f7f 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -170,19 +170,6 @@ static void super_wake(struct super_block *sb, unsigned int flag)
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
@@ -212,7 +199,7 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 	if (!super_trylock_shared(sb))
 		return SHRINK_STOP;
 
-	if (sb->s_op->nr_cached_objects && super_fs_objects_eligible(sc))
+	if (sb->s_op->nr_cached_objects)
 		fs_objects = sb->s_op->nr_cached_objects(sb, sc);
 
 	inodes = list_lru_shrink_count(&sb->s_inode_lru, sc);
@@ -273,8 +260,7 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 		return 0;
 	smp_rmb();
 
-	if (sb->s_op && sb->s_op->nr_cached_objects &&
-	    super_fs_objects_eligible(sc))
+	if (sb->s_op && sb->s_op->nr_cached_objects)
 		total_objects = sb->s_op->nr_cached_objects(sb, sc);
 
 	total_objects += list_lru_shrink_count(&sb->s_dentry_lru, sc);
-- 
2.53.0

