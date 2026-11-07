Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047588;
	b=cIuVnNOarO+IwnerpKb0Rt6uwEAiy+hmoB5uhLH6A97UbL4n7r/9Sc3IyN8y6P9f4pxd
	 PT/mVJzBishHMQLcu6HnZJlG0QkDVd2sbId6P7m3yxwo00mT2k9PGp+0PXSB3RO0pTsRJ
	 oh1H9SYD65sfL5svELy+l1p2JqMyXnEQCd/ZDRa7oPM0/zxgeafwrXdtgzgXhBvmAaZxM
	 isjqREzCu/GJ9KwQfDbA65DsugoDdhhBwTCgrxjGM9cbSUGmVCvpmzEJlkT0pj6oxZDd1
	 k9XbrQFcJx0WeebQtJ4sZkaFeHdO+t2HmXrtxZY3bYkVzyaeMCN+o4SsVGwZ1OWiVRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047588;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tB3LGHsFQHsXuRBL2wqH0IHItJqAxbyTCMXIIDHLeUE=;
	b=SFDHQvvO1uO5tY7LR21ESl2HYqGyCWUZB8kNwzBbEu4hMZrZTjOsuVWbyDR98Kk9IttZ
	 3+2mFbzAcqPdsu3h0TkkrfI3XF1RQGCKF2mhahBm3AQugz1MNwDIMW4d7FFXbCHF1vCbu
	 nhdFHyv1wPU+c8XErHkDn0iEuwE99GODuh3dYZa+zalSEzNMKuBTLMfHUsAFqszl4wnqo
	 FwWYWv6tRr2GsaLZmCrR7Ju1fWTePy7Uk/Ju4LvfC6rX5vaFgLs3z/k9/BP9R9tcbf2uZ
	 JJ3sOL8xMr4e3u7oDOenzYacFgYfylWQTKTzXF0T+vyLc/Dm7rJafKZb5e/FsdEU2Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIbq6+YT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F19606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIbq6+YT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC7C1F0089F;
	Sat,  7 Nov 2026 10:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047588;
	bh=tB3LGHsFQHsXuRBL2wqH0IHItJqAxbyTCMXIIDHLeUE=;
	h=From:To:Cc:Subject:Date;
	b=EIbq6+YTwo/I3JDXLaJjFax0PzGlE71TkPDrwo8lXs9KOVnMDJAUO4+1KUlAUFfnh
	 eHDMOmQJqF3vqw2x9NgaHQVRr7keL/hxc2A6UJK8ZvvFQkvsysD16rvpCmwhn6qZiG
	 Lgrb3PA/oSjmtEwyVoGVGaJ214lSxdqj128iQXdV6wbzZoLpAvjlCDxqIsVBby+8+y
	 7//Xdd3VA9jlioVPIa8pocz4+BtoZZalg8XkhC4PZY0yQ25siZ8g8KVbPzEOAwk6Z1
	 VxnMDbR3O9/PZxcSbLdWfxk1+vnNRZJkwKsPZahJ+QKj8JU/Qf9Y1vuIuWav6YfUyc
	 fUzDpnzd2Fx8Q==
From: Sasha Levin <sashal@kernel.org>
To: chenridong@xiaomi.com,
	akpm@linux-foundation.org,
	baohua@kernel.org,
	hannes@cmpxchg.org,
	axelrasmussen@google.com,
	chris@chrisdown.name,
	david@kernel.org,
	kasong@tencent.com,
	ljs@kernel.org,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	weixugc@google.com,
	yuanchu@google.com,
	yuzhao@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/mglru: fix ineffective memory protection for non-kswapd reclaim" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:33:05 -0500
Message-ID: <20261107053305-failed-6.6-15da1e4978dd@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 15da1e4978dd4ea8f5faa6e15ee967ba4ad9a30a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053305-failed-6.6-15da1e4978dd@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 15da1e4978dd4ea8f5faa6e15ee967ba4ad9a30a Mon Sep 17 00:00:00 2001
From: Ridong Chen <chenridong@xiaomi.com>
Date: Mon, 7 Sep 2026 10:54:45 +0800
Subject: [PATCH] mm/mglru: fix ineffective memory protection for non-kswapd
 reclaim

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
---
 include/linux/memcontrol.h | 10 +++++++++
 mm/memcontrol.c            | 45 ++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                |  8 ++++++-
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 4f720791a31c9..46bf724cae7af 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1921,6 +1921,16 @@ static inline bool memcg_is_dying(struct mem_cgroup *memcg)
 }
 #endif /* CONFIG_MEMCG */
 
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
 #if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)
 bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
 void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cf53d4ac7ecc1..791e536efaebe 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5267,6 +5267,51 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 	page_counter_calculate_protection(&root->memory, &memcg->memory, recursive_protection);
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
+	bool recursive_protection =
+		cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT;
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
+		cur = mem_cgroup_from_css(cgroup_css(cg->ancestors[i],
+						     &memory_cgrp_subsys));
+		if (cur)
+			page_counter_calculate_protection(&root->memory,
+							  &cur->memory,
+							  recursive_protection);
+	}
+	rcu_read_unlock();
+}
+#endif /* CONFIG_LRU_GEN */
+
 static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 			gfp_t gfp)
 {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8e9c73dcd19bb..80041e2b8049c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5251,7 +5251,13 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
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




