Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366613;
	b=Pi07d6zJOwBiW/O7ses8zWpt00SqggEE2P5T3iaBxiIjCmQwMUUDXKdSqzGLsChW7A6g
	 96+CqT2+b9xQuyIWsKMvfekvtnFvTxCIF0d9ecrxmEc7QouCwqXkJrpSvBLGNxBZCU3Ec
	 SM9ZZRC2aJ3EqYwKEAq3abXhtAZd6e/1dHDJdic6vDRgNgvok0V2OuHcfxUIM/8PSDtDH
	 Iuz9vnLmFATK4A1Bi8es17GgxwKc7l7qJk66rD53HhEdHXQYoWLOqhiMiPZ7ofYZVaQRs
	 4rLFk9SmuVdadyOUNyxkEEqFW1f3Kkc3q+dQGocL8rZKsEQF55qaC3MCUVIqt4RPIzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366613;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZAaFw5PkYAQdLE5zF5Q6GhbnSEf6ZV0B2TM+EL0zrko=;
	b=IRsc9Mi9cxsNyTqN7CdLZb+N3pNPAhRnrAO3j+mgIyXv0K4VOP4YO+ZRJXcnoJtuVb+j
	 g+oEgtZIm0/8leJa7h1oQKeDVhuV3zTN0tpCuL9Nj5tjw7NIKpsUROoC4EZ5n8WTjEqSg
	 KPs3dF6uN4wXjN3gFQ7UKGebPSeLHHLq9pLXXKYVQvfU+8U4DYiIyHBs1gwRCmtCvHyqH
	 DZxKwnUf5IpcfKgbNqlHeUM7yjTohuW9ZUtPnYCAnuXF9wjmNzq5FspOWQSnVblZIm630
	 8TbqbDOECqyZQcOKMo6zimrBuaQMO4Pr7kRsXbFQuWnUs9kQNqhj4okfAzfHtPTAPxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAzdzQFP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E17606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAzdzQFP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271BB1F0089F;
	Wed, 11 Nov 2026 03:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366613;
	bh=ZAaFw5PkYAQdLE5zF5Q6GhbnSEf6ZV0B2TM+EL0zrko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aAzdzQFPYfVRfFv65n6YOp/0Y4IlwBgp0KeX32IwPXHDMdQIz7WHo5uJikocsjsJz
	 rmLtTt4VBu1zCquKwFGJGeLhsTM/PgeD4pCpuyURwSe8tIu1ILo5S4ukUOS7sHDIyS
	 npyYSv2XhWwxdpV1z3G82lFxAs0Kn26BkTzj3yshK5mKOrowCGjLM5L1k2liOdetsm
	 bDmEHZuGPs3jZW+OTvqJmOiuSRL9Yb91wahgRanC++nE1+wWmmg4mq9yTaZc9TbjDc
	 bQdZZxm3/pYBAXFyJ4HeHIyoPqfYk0l4uyGKUVmTIrulXX9mXLIFBK3f1VTvtNWUIv
	 tuvqrCbTjX41A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qi Zheng <zhengqi.arch@bytedance.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Allen Pais <apais@linux.microsoft.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baoquan He <bhe@redhat.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chen Ridong <chenridong@huawei.com>,
	David Hildenbrand <david@kernel.org>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Hugh Dickins <hughd@google.com>,
	Imran Khan <imran.f.khan@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Lance Yang <lance.yang@linux.dev>,
	Liam Howlett <Liam.Howlett@oracle.com>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Usama Arif <usamaarif642@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] mm: memcontrol: refactor mod_memcg_state() and mod_memcg_lruvec_state()
Date: Tue, 10 Nov 2026 22:10:06 -0500
Message-ID: <20261111030947.831164-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051423-failed-6.18-02e0c8cc2815@kernel.org>
References: <20261107051423-failed-6.18-02e0c8cc2815@kernel.org>
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

From: Qi Zheng <zhengqi.arch@bytedance.com>

[ Upstream commit 5371e350fda70bbdbee364215ca37b7fea25047b ]

Refactor the memcg_reparent_objcgs() to facilitate subsequent reparenting
non-hierarchical stats.

Link: https://lore.kernel.org/7f8bd3aacec2270b9453428fc8585cca9f10751e.1772711148.git.zhengqi.arch@bytedance.com
Co-developed-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Allen Pais <apais@linux.microsoft.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Chen Ridong <chenridong@huawei.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: Harry Yoo <harry.yoo@oracle.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Imran Khan <imran.f.khan@oracle.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam Howlett <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Michal Koutný <mkoutny@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Wei Xu <weixugc@google.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 02e0c8cc2815 ("mm/memcg: migrate per-node hugetlb lruvec stat together with hugetlb folio")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memcontrol.c | 50 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 97ed5ad4053f0..84ab1ed9eb602 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -678,21 +678,12 @@ static int memcg_state_val_in_pages(int idx, int val)
 		return max(val * unit / PAGE_SIZE, 1UL);
 }
 
-/**
- * mod_memcg_state - update cgroup memory statistics
- * @memcg: the memory cgroup
- * @idx: the stat item - can be enum memcg_stat_item or enum node_stat_item
- * @val: delta to add to the counter, can be negative
- */
-void mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
-		       int val)
+static void __mod_memcg_state(struct mem_cgroup *memcg,
+			      enum memcg_stat_item idx, int val)
 {
 	int i = memcg_stats_index(idx);
 	int cpu;
 
-	if (mem_cgroup_disabled())
-		return;
-
 	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return;
 
@@ -706,6 +697,21 @@ void mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 	put_cpu();
 }
 
+/**
+ * mod_memcg_state - update cgroup memory statistics
+ * @memcg: the memory cgroup
+ * @idx: the stat item - can be enum memcg_stat_item or enum node_stat_item
+ * @val: delta to add to the counter, can be negative
+ */
+void mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
+		       int val)
+{
+	if (mem_cgroup_disabled())
+		return;
+
+	__mod_memcg_state(memcg, idx, val);
+}
+
 #ifdef CONFIG_MEMCG_V1
 /* idx can be of type enum memcg_stat_item or node_stat_item. */
 unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
@@ -725,21 +731,16 @@ unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 }
 #endif
 
-static void mod_memcg_lruvec_state(struct lruvec *lruvec,
-				     enum node_stat_item idx,
-				     int val)
+static void __mod_memcg_lruvec_state(struct mem_cgroup_per_node *pn,
+				     enum node_stat_item idx, int val)
 {
-	struct mem_cgroup_per_node *pn;
-	struct mem_cgroup *memcg;
+	struct mem_cgroup *memcg = pn->memcg;
 	int i = memcg_stats_index(idx);
 	int cpu;
 
 	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return;
 
-	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	memcg = pn->memcg;
-
 	cpu = get_cpu();
 
 	/* Update memcg */
@@ -755,6 +756,17 @@ static void mod_memcg_lruvec_state(struct lruvec *lruvec,
 	put_cpu();
 }
 
+static void mod_memcg_lruvec_state(struct lruvec *lruvec,
+				     enum node_stat_item idx,
+				     int val)
+{
+	struct mem_cgroup_per_node *pn;
+
+	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
+
+	__mod_memcg_lruvec_state(pn, idx, val);
+}
+
 /**
  * __mod_lruvec_state - update lruvec memory statistics
  * @lruvec: the lruvec
-- 
2.53.0

