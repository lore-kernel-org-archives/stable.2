Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273436;
	b=UssDBDXj5j3i7xNwKUYTZhxqtye1RoHfv0dJIQvBxaCy4BOHW1FUJey2IrdaizsD3SP3
	 DVrh5fT5IB5LHFs4FopwapTyiS7N5yFQ/AGIeYgZH0Vm8SeocpajRpkCuWiQqwlzyYr/D
	 T1nbb8xE5crzZP1HuLXrJU2ri49pgdLUwrUZlljsPZX/Lqpu1pdcnVIbDPbWNOi9bC5R6
	 mwKKVn27hyMvrQ3GWeP9Lj7XlHL8X932OBnwchshGeP0ZG2riQ5O+1X5VouwW1O2Z0E+R
	 GuoFgrS4f3NVTkmriEYvxx1bSnx3z3w1IaEcYpaWuQr2zH+XuP49o7Mu8p4FIVEMKnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273436;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wyyfShe2QyQ+Mi71b53C5Xm2Iqrqat/k5Lp8tknsI4Y=;
	b=md/wyGVVUeQJTkw4nZs/qA85ImFNzQRvnjEYihW+j6MP6g8GRzihTmD/SF/3TaAzTKRH
	 AQ8lFpx/+jH4/FGkEOL5LmcsUeRZVxQApxlHZwT1kjlMaAgVaQtep8pi6Xc9lF4K9dDLY
	 33aB1hhO2bF/zXphkSkwcJ6tQ6EvVbadmdr83OgoZwTTfBGqasRXm4bwJI1lB3ljPMmcD
	 58Xt/y87yGeE+RHFrboDXK2AS0PZFuS8RUVQSyVyMDVhDKizuro1IymyO30X71AEQRRJ7
	 80lLl1Vd5rbKGgL0xmPBZcZGunHEYSxDGyy7gMg3GD7KPDWaPprT5jQkrmPVrAPnVrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cu7U/pU/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8FF606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cu7U/pU/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8091F0089F;
	Tue, 10 Nov 2026 01:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273435;
	bh=wyyfShe2QyQ+Mi71b53C5Xm2Iqrqat/k5Lp8tknsI4Y=;
	h=From:To:Cc:Subject:Date;
	b=cu7U/pU/Glvml/gMqeiFFWD8+LD/IWkIYlJLExeEDLZJsoUFHDEAKVdj1qmKKRcKr
	 k5TPews7bx8f38Zop+9YI8gi8SlS5syHelUCi+RlAagJRYrvcpk/JKIyzCzcwtmorI
	 6Xu71QHWHZGPQjhzq1klw3SCL86Wz2iz+aRkIyHdi0Hw9sdsazrVJXlOAB1O83k9ba
	 vc5octkcTLQXbY753shWgpFbw1+EyES/t51rFb6Q1W0RyF2yV72a7YpQRgNaODXM+w
	 tPNxpyxqTprGLUBmwj04p8K+UVZ1vLmz+46/QDOkqAeoRgYWeyQtvZZyMFCx5xZhuo
	 Qkfe8wSVEJU7w==
From: Sasha Levin <sashal@kernel.org>
To: laoar.shao@gmail.com,
	akpm@linux-foundation.org,
	ziy@nvidia.com,
	david@kernel.org,
	ying.huang@linux.alibaba.com,
	willy@infradead.org,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	gourry@gourry.net,
	apopple@nvidia.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/migrate: snapshot the source nid before the misplaced migration" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:17:13 -0500
Message-ID: <20261109201713-failed-6.1-fe623a81ad9e@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x fe623a81ad9eddf10059b4e44bca0440d9120613
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201713-failed-6.1-fe623a81ad9e@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From fe623a81ad9eddf10059b4e44bca0440d9120613 Mon Sep 17 00:00:00 2001
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 27 Oct 2026 10:17:20 +0800
Subject: [PATCH] mm/migrate: snapshot the source nid before the misplaced
 migration
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A successful migration frees the source folio before the promotion
counter update, so the folio_nid() read there operates on a freed
folio — which may already have been reallocated. It happens to work
today, as Zi explained:

  : Strictly speaking, it can be seen as a benign UAF. It works, because
  : 1. folio->flags happens to be the same as page->flags,
  : 2. folio/page nid is stored in the ->flags and never changed.
  :
  : In memdesc world, after a folio is freed, I assume folio->flags would be
  : zeroed since struct folio is freed and calling folio_nid() on a freed
  : folio would give a bogus result (yeah, it can be mitigated by not
  : zeroing node field and each node has its own struct folio pool, but that
  : makes folio_nid() implementation dependent).

and Matthew explained further:

  : once struct folio is separately allocated, it's a UAF.  It could be
  : recycled to a different NID or maybe the slab containing the folio could
  : be freed (assuming we're not holding the RCU read lock at this point in
  : migration, and I don't see why we would be).

A separate concern is memory hot-removal.  With memory-tiering mode
enabled, successful migration can release the source before the
promotion-accounting folio_nid() read.  If the task is preempted there,
an otherwise-free source block can be offlined and removed first.  On
the x86 path, removal can unmap the source's vmemmap, so the later read
can fault.  The snapshot avoids that read.

Link: https://lore.kernel.org/20261027021721.95781-1-laoar.shao@gmail.com
Fixes: e39bb6be9f2b ("NUMA Balancing: add page promotion counter")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: Zi Yan <ziy@nvidia.com>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: <stable@vger.kernel.org>
---
 mm/migrate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d649a6cfce6c0..875079464930a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2756,6 +2756,7 @@ int migrate_misplaced_folio(struct folio *folio, int node)
 	pg_data_t *pgdat = NODE_DATA(node);
 	int nr_remaining;
 	unsigned int nr_succeeded;
+	int src_node = folio_nid(folio);
 	LIST_HEAD(migratepages);
 	struct mem_cgroup *memcg = get_mem_cgroup_from_folio(folio);
 	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
@@ -2770,7 +2771,7 @@ int migrate_misplaced_folio(struct folio *folio, int node)
 		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
 		count_memcg_events(memcg, NUMA_PAGE_MIGRATE, nr_succeeded);
 		if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
-		    && !node_is_toptier(folio_nid(folio))
+		    && !node_is_toptier(src_node)
 		    && node_is_toptier(node))
 			mod_lruvec_state(lruvec, PGPROMOTE_SUCCESS, nr_succeeded);
 	}
-- 
2.53.0




