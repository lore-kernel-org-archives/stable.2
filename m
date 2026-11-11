Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366616;
	b=4LuT/Rs1503x19yESYzCRitdBBm0V3GdMxZmH3tyY3z1dOg2EJM2py8w7EdNoXuKaq0A
	 qyLT0qnfbdZDWCxemEvUjGYGBK1zK2s4PprLb6Bo/y4EgOqHsEZ+2u+K/1lQ9wezzURxg
	 aFmjaOMerZT9d3XAwNL1QnrIgRuvAw400ldE7N7N4T9WAvMPFqbojP5JczMkV+ORrKKue
	 kuW5ZlV1sujfywlbopxLVn67UK9yFWsha66VgO+C18OQYWq2y1cj30LIgntkVdtbxNGJZ
	 M2RVh7mQ31/IFyN93yqvo4u0EREOQPprL31TOC5ww29nQnUACwK8UhMG4Co3PzozAyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366616;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HE5tu25mdPovmnItFL0q7p4FaR8zt1JwgcsiwpEbk90=;
	b=Gtbc4yH433a5ZImVtWy9R7FbDr5S0B/v2ZzoxZZHjwcqaIufTUX0NXyO9h1Y+ajYPzYV
	 JAOSUVVfaRo6FqXWs/REAtV0ZFx61WbA7nwsvVsoYiT+eXclOVfMH+h/tVVgpX6ZugJXM
	 SiolPDUJlVo4DDsGVWzdGvDGpvDynW/AxHJsNHOWoP4E9qvvR7EI4ADjw1afVpajQeEvc
	 DPtUOQzWzdAEjlPdvv7bq+S/XCrbsH+IMDbdm9M1KMrvDEq4gAUJHicgNWrv4qcGPiPqa
	 v4VbIfJp57wocLlo4arh+buqpTFCQKJ3sBPcDr5iNejbJa1GHNz6vQg3te4pmAOduRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcwxdSyX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98B9606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcwxdSyX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C9E1F00A0E;
	Wed, 11 Nov 2026 03:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366616;
	bh=HE5tu25mdPovmnItFL0q7p4FaR8zt1JwgcsiwpEbk90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bcwxdSyXpxl7/Dr/LGBvQylyQ9VEud4sOsDPaPyTVw1ri7LcqxoWwb8zchY0lnLsg
	 2S2CFACCM/YnYWQwS9DqtNNyN/KXjIFnXrSftFnRO7o2oaxqKf+Fckyw9lU1ublAhc
	 bqBChxKPVYUJB3qK1bmsuk50KAB+YdPg5O0esPX4TlQpWtyC0U9NCBgBHnIG+xdTKu
	 f578wzzsp/JmtYard5btymTsEkBpLdw0B9tknujt9Vn0BURgP8OF19bz8SSl4KHYUo
	 jUi5d4sUoQ4sEltQBfjQOMBX/Bq8f2N92BN3+A1W2CaYAN41VQkIHZgs/Nu8cSwBq/
	 26EWHp/ZDteEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hongfu Li <lihongfu@kylinos.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chris Down <chris@chrisdown.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] mm/memcg: migrate per-node hugetlb lruvec stat together with hugetlb folio
Date: Tue, 10 Nov 2026 22:10:08 -0500
Message-ID: <20261111030947.831164-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111030947.831164-1-sashal@kernel.org>
References: <20261107051423-failed-6.18-02e0c8cc2815@kernel.org>
 <20261111030947.831164-1-sashal@kernel.org>
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

From: Hongfu Li <lihongfu@kylinos.cn>

[ Upstream commit 02e0c8cc2815f0082b5b5aabafe3b46688082adc ]

memory.numa_stat exposes per-node hugetlb counters from per-node lruvec
stats.  These stats are accounted against folio_nid(): incremented on the
folio's node when handed to a user, decremented when the folio is returned
to the pool.

During hugetlb folio migration, mem_cgroup_migrate() moves the charge to
the new folio and drops the memcg data of the old one, so the free of the
old folio right after the migration skips the memcg per-node lruvec
decrement.  The hugetlb count stays attributed to the old node for the
rest of the life of the charge, while the target folio gets no increment
on the new node; its later free decrements a counter that was never
incremented.

Migrate the per-node lruvec accounting alongside migration.  Global memcg
totals remain balanced because they track resource consumption, not node
placement.

Link: https://lore.kernel.org/20260923-for-hugetlb_state3-v2-2-e8a36245bfab@kylinos.cn
Fixes: 05d4532b60e3 ("memcg/hugetlb: add hugeTLB counters to memcg")
Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Tested-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Muchun Song <muchun.song@linux.dev>
Cc: David Hildenbrand <david@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Chris Down <chris@chrisdown.name>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/memcontrol.h |  8 ++++++++
 mm/hugetlb.c               | 25 +++++++++++++++++++++++++
 mm/memcontrol.c            |  5 ++---
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 706ddda4a60b1..f6b25317e7b7d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -953,6 +953,9 @@ unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx);
 unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 				      enum node_stat_item idx);
 
+void mod_memcg_lruvec_state(struct lruvec *lruvec,
+			    enum node_stat_item idx, int val);
+
 void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
 void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);
 
@@ -1422,6 +1425,11 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return node_page_state(lruvec_pgdat(lruvec), idx);
 }
 
+static inline void mod_memcg_lruvec_state(struct lruvec *lruvec,
+					  enum node_stat_item idx, int val)
+{
+}
+
 static inline void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 {
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 92db6fdf44339..da7cc875a0cd9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -25,6 +25,7 @@
 #include <linux/mmdebug.h>
 #include <linux/sched/signal.h>
 #include <linux/rmap.h>
+#include <linux/rcupdate.h>
 #include <linux/string_choices.h>
 #include <linux/string_helpers.h>
 #include <linux/swap.h>
@@ -7957,12 +7958,36 @@ void folio_putback_hugetlb(struct folio *folio)
 	folio_put(folio);
 }
 
+static void move_hugetlb_lruvec_stat(struct folio *old_folio,
+				     struct folio *new_folio)
+{
+	struct mem_cgroup *memcg;
+	long nr_pages = folio_nr_pages(old_folio);
+	int old_nid = folio_nid(old_folio);
+	int new_nid = folio_nid(new_folio);
+
+	if (old_nid == new_nid)
+		return;
+
+	guard(rcu)();
+
+	memcg = folio_memcg(new_folio);
+	if (!memcg)
+		return;
+
+	mod_memcg_lruvec_state(mem_cgroup_lruvec(memcg, NODE_DATA(old_nid)),
+			       NR_HUGETLB, -nr_pages);
+	mod_memcg_lruvec_state(mem_cgroup_lruvec(memcg, NODE_DATA(new_nid)),
+			       NR_HUGETLB, nr_pages);
+}
+
 void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio,
 			enum migrate_reason reason)
 {
 	struct hstate *h = folio_hstate(old_folio);
 
 	hugetlb_cgroup_migrate(old_folio, new_folio);
+	move_hugetlb_lruvec_stat(old_folio, new_folio);
 	folio_set_owner_migrate_reason(new_folio, reason);
 
 	/*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 84ab1ed9eb602..2fecc80769f26 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -756,9 +756,8 @@ static void __mod_memcg_lruvec_state(struct mem_cgroup_per_node *pn,
 	put_cpu();
 }
 
-static void mod_memcg_lruvec_state(struct lruvec *lruvec,
-				     enum node_stat_item idx,
-				     int val)
+void mod_memcg_lruvec_state(struct lruvec *lruvec,
+			    enum node_stat_item idx, int val)
 {
 	struct mem_cgroup_per_node *pn;
 
-- 
2.53.0

