Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324633;
	b=dSMrtoPrBAFHaLCUnoUuEwXybZh0kJdBvP5gIco8iJKBBVWuia6iW3Te4svDDxyObdPj
	 RD2muP9JgMOxIqubWnRn826KvhwtIFOB7IkphJzG7avr2ALKtpX3Y1FlZAiYRtvUsMxBz
	 KayK1QZ++HhYtqradqnZ7GWCV1RvRqZpEXhDCmebQtTSFC97Z6l7uFlZQuexjAXE0BoCb
	 OdDrQB1894M+HbYV7LRVPW0nX4xgITxcB7Xahub5QQ1rMBi6OyGSWVQq6nq3x0LAZGTbF
	 MieMaopUPoGOZNA0VLYArt53nJ/xjjya3m/i9X7ASc6gDSp9MhcaSwKm67nOWD+T6cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324633;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lNdHacJWdiHbSwjXD5XnjVBwgpc+uBoQowtqRYYLvsQ=;
	b=Yssk3nnSuTlccJxx49WJRLSxt26ho7snvEymUd36uiQvWZbSNNmUoCytpa0Kgoiz/wu+
	 VK8UJAl3QBE62WYyWUjqERH7UZyyFLcpL0jhPnM/t8xpPaPHs+BWWX7Oo23QnI3pQXmRf
	 r8cuwIxLeGGvNp9MipieVynyYM10Sg+uRL4d5/S9qz1kTYjq4GNNjvsB3jfXtPQJPDa+0
	 Hy3ThvqZhzXzUnZVwagjd7ItlpCS+S5qujMXfWeChwoZIi/0faP79CGJWNC/r31rDse3B
	 1ShMXeaYYZgRemT1wGkoprQHk22a7W/ZUyypKlHbf4Leu5qF271b1xI2D5aaeipN+Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SpEymjKH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D5660A2615
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SpEymjKH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612801F008A2;
	Tue, 10 Nov 2026 15:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324633;
	bh=lNdHacJWdiHbSwjXD5XnjVBwgpc+uBoQowtqRYYLvsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SpEymjKHgcp2aLxWuvs/JrPuwIGNFAa2vJizQhwdZXCNCF5eqGGboqATTDR15u2LB
	 2cMZRyRUnUplmUBqRETMVpzOYZlhfHbOL84W4c80611ot2AdLOPXTvL+hTm/UXw7L+
	 5xctf1Rmji4ojhvygBSW6I8g6hSq/u+VtAYJR9Gy6InBlv49myfVVW3TwfA7RH5MDV
	 D6PLmalO/87f+rHu4tb2lMNBo75Ctdcg3rx6gfyozXBlyCQgqggvBhW2/8qZ+PPmqQ
	 znben7ZdGVxUMQKpsVoYrGMO7qkQrl4W0InGBO7YoUWnH9vbaIfI4YgBZkyEBRl6XK
	 QTu9HFfSF34Kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ridong Chen <chenridong@xiaomi.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <baohua@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Chris Down <chris@chrisdown.name>,
	David Hildenbrand <david@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Yu Zhao <yuzhao@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/mglru: fix ineffective memory protection for non-kswapd reclaim
Date: Tue, 10 Nov 2026 10:30:30 -0500
Message-ID: <20261110152946.2096061-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053305-failed-6.6-15da1e4978dd@kernel.org>
References: <20261107053305-failed-6.6-15da1e4978dd@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ridong Chen <chenridong@xiaomi.com>

[ Upstream commit 15da1e4978dd4ea8f5faa6e15ee967ba4ad9a30a ]

For MGLRU, memory.min/low is not honored during global proactive reclaim
(writing to the root memory.reclaim) and global direct reclaim, because
these paths shrink memcgs using stale protection (emin/elow).  It can be
reproduced as follows:

  # echo 7 > /sys/kernel/mm/lru_gen/enabled
  # cd /sys/fs/cgroup
  # mkdir -p a/b
  # echo 100M > a/memory.min
  # echo +memory > a/cgroup.subtree_control
  # echo 100M > a/b/memory.min
  # echo $$ > a/b/cgroup.procs
  # dd if=/dev/zero of=/tmp/testfile bs=1M count=200
  # cat a/b/memory.current
  222650368
  # echo 500M > memory.reclaim
  -bash: echo: write error: Resource temporarily unavailable
  # cat a/b/memory.current
  6070272

memory.min is 100M, yet reclaim drops a/b down to 6M, breaking the
protection.  The traditional LRU path is not affected because
shrink_node() calls mem_cgroup_calculate_protection() for each memcg it
visits during a top-down tree walk.

Commit 30d77b7eef01 ("mm/mglru: fix ineffective protection calculation")
moved the protection computation into lru_gen_age_node(), which only runs
for kswapd.  Non-kswapd global reclaim reaches shrink_one() through
lru_gen_shrink_node() -> shrink_many() without any protection computation,
so emin/elow are whatever a previous kswapd run left behind - or zero if
kswapd never ran on this node.  Relying on a prior kswapd pass is not
correct either: a memcg's emin/elow are derived from its ancestors'
memory.min/low settings and from children_min_usage, both of which change
over time, so emin/elow go stale even after kswapd has run and must be
recomputed at the point of reclaim.

Introduce mem_cgroup_calculate_protection_path() which computes emin/elow
along the root-to-target path only, by iterating through the cgroup
ancestors array top-down.  This avoids the full tree traversal that would
be needed with mem_cgroup_calculate_protection(), limiting the cost to
O(depth) per memcg - typically 3-5 levels.

Call it from shrink_one() for the non-kswapd path so that each memcg about
to be shrunk has correct protection values.

Link: https://lore.kernel.org/20260907025445.1836238-3-ridong.chen@linux.dev
Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
Assisted-by: Claude:claude-opus-4-8
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Chris Down <chris@chrisdown.name>
Cc: David Hildenbrand <david@kernel.org>
Cc: Kairui Song <kasong@tencent.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>
Cc: Wei Xu <weixugc@google.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
[ sashal: adapted protection recalculation to use direct RCU controller lookup and the existing mem_cgroup_calculate_protection() helper ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/memcontrol.h | 10 ++++++++++
 mm/memcontrol.c            | 41 ++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                |  8 +++++++-
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 8aee8b75aad01..687179e5ea4d0 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1871,6 +1871,16 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 
 #endif /* CONFIG_MEMCG_KMEM */
 
+#if defined(CONFIG_MEMCG) && defined(CONFIG_LRU_GEN)
+void mem_cgroup_calculate_protection_path(struct mem_cgroup *root,
+					  struct mem_cgroup *memcg);
+#else
+static inline void mem_cgroup_calculate_protection_path(struct mem_cgroup *root,
+							struct mem_cgroup *memcg)
+{
+}
+#endif
+
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
 void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 852fa93efe1be..e6fffb91742a8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7117,6 +7117,47 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 			atomic_long_read(&parent->memory.children_low_usage)));
 }
 
+#ifdef CONFIG_LRU_GEN
+/**
+ * mem_cgroup_calculate_protection_path - compute protection along a path
+ * @root: the top ancestor of the sub-tree being checked (NULL for root_mem_cgroup)
+ * @memcg: the target memory cgroup
+ *
+ * Walk the ancestor path from @root down to @memcg and compute the effective
+ * protection at each level.  This is safe for isolated queries because it
+ * ensures parents are computed before children.
+ */
+void mem_cgroup_calculate_protection_path(struct mem_cgroup *root,
+					  struct mem_cgroup *memcg)
+{
+	struct cgroup *cg;
+	int root_level, i;
+
+	if (mem_cgroup_disabled())
+		return;
+
+	if (!root)
+		root = root_mem_cgroup;
+
+	if (memcg == root)
+		return;
+
+	root_level = root->css.cgroup->level;
+	cg = memcg->css.cgroup;
+
+	rcu_read_lock();
+	for (i = root_level + 1; i <= cg->level; i++) {
+		struct mem_cgroup *cur;
+
+		cur = mem_cgroup_from_css(rcu_dereference(
+				cg->ancestors[i]->subsys[memory_cgrp_id]));
+		if (cur)
+			mem_cgroup_calculate_protection(root, cur);
+	}
+	rcu_read_unlock();
+}
+#endif /* CONFIG_LRU_GEN */
+
 static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 			gfp_t gfp)
 {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index cbc2de77db3ed..d099623bd3ceb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5459,7 +5459,13 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
-	/* lru_gen_age_node() called mem_cgroup_calculate_protection() */
+	/*
+	 * For kswapd, mem_cgroup_calculate_protection() has already
+	 * been called during the top-down cgroup traversal.
+	 */
+	if (!current_is_kswapd())
+		mem_cgroup_calculate_protection_path(NULL, memcg);
+
 	if (mem_cgroup_below_min(NULL, memcg))
 		return MEMCG_LRU_YOUNG;
 
-- 
2.53.0

