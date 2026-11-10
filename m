Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273151;
	b=ruhcAgpmsWusz9aRun7kVHDAyBNDd4Nfm3hGsyX3BdbDsFfJ8T/L9jbTj1ELVgeTA2Ao
	 UOvc5UiftIdxVDwpg0zrayhT7H4KqBa0kk2x2DQ0lyOFAO1O/rXTPJmWtJaxwrCH2tUqf
	 fpjcyuInY+66Gz2wkdR7Fb0gjk7SR82+KZtG0Kh7VSNZz0rE8DtVZ0FEf6MLuYIpc7pRQ
	 7qza4SBQ2O4X0JZYhFP+mUyWgxIdA+VMQK/uxUzlZ027wlg3ERc3qbtgVLactbNg5YIJA
	 xraLGc5dduRcxy/OYKi0Ulm8wCbXxkdV4foTfZTfqxXiejHz59ZqfVgR8ZS4nvTjGRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273151;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ESBhqemej8YOgYb3s3fIRrUHUAPyPyvC/gutHk922G8=;
	b=n9JNHKmr6rkv2xhKrbWc0MY4F5gOaA+xH4Bc7fln/91GKBZlL1/2X1At5uQbRONw3a9l
	 cRgax0txBsORHDbKRMys49U8XKPELWr+iIXEgDlrWN58/PvSOaMnZRZ99+37Zyid6VaNc
	 srS4pPqEsSfejzSwp+n9wxDSx7cqtzBbkzkZj14OP4JJQpBkJidoYFBFtZdk64jkjYXYz
	 DBTN4b7pv6wmXVC5Xom52tTYL5Y/Cc5JOtpDQ9EOK7S0BnSxCq4MKgcL28FN6abWWNPgz
	 22dIZwcVKGXLwcmzZB8944fwGw6DbrTxhv6LzDMGqAYEj5a72APNsM3hx0fPgwO60iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oeHtB6Zg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA6F606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oeHtB6Zg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638811F0089F;
	Tue, 10 Nov 2026 01:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273150;
	bh=ESBhqemej8YOgYb3s3fIRrUHUAPyPyvC/gutHk922G8=;
	h=From:To:Cc:Subject:Date;
	b=oeHtB6ZgpJxg/SKX9eJk/rlhUo4FRPP9YJf3myt2a5/6/AqoN07QMZUYk4aGe3/6f
	 PSf5qbZ+IbmN8N4ffG876/MPlqpJVTzH82uQyAINSuCeybyRpT6RoOXpOaNKypY5x9
	 EtofBGp2krXuAfZQOaUkHCMWYU/guRYLjrgtXIZV8hkYjCYUjA9YqDg3e/SXaT6ZZ9
	 n2MaEAYqLfivYwhS6B1+YLeOx44jX2vnT1yf2PujNpewgwuFZnmEREWxJ9Y6E2ITRW
	 QmpXBbBvV12rcPLnNd4maHhOIg1xyShNJrrKmGQ3LmLHjhRy68ZcqLYxph1UatpUlW
	 rGmtsL2avNv6Q==
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
Subject: FAILED: patch "[PATCH] mm/migrate: snapshot the source nid before the misplaced migration" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:12:28 -0500
Message-ID: <20261109201228-failed-6.6-fe623a81ad9e@kernel.org>
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
git cherry-pick -x fe623a81ad9eddf10059b4e44bca0440d9120613
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201228-failed-6.6-fe623a81ad9e@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




