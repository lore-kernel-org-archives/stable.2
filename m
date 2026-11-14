Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794678429;
	b=koE8V4ZFjeHSVmHga4wDZvq8xhDWoRUc8WyoEAtXcnJBhsyaFFXcyw+bVTZPGwRDTUpx
	 7gEpDWBEs4UJ+TJ2M/MhlWdPcaCpVPU6Fiwgj6gfPSfEoRWhHE6m0hnvvnZCbwV3Z6LfS
	 FEUUXcpW9BfP98I7ZQJRNnvNfcDXNSVSD7G0hAWHurVI/Y050SeUkiAJ9ncsyffW5MXSN
	 WUqq2PuhvaxN0/dT77jq/OPlge+h60+YptHGUuQXzYkm20kMSAa1SeDbfk0qg28XHfZWd
	 C3mN0vYRbTZtb93uyNrvWs56Ser+5kkLToZEr85F3qqe8Xj0cm9Wyf1kn/pUVqKe3iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794678429;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wUS99+5bD74l0g6u7scaH+a/BayDu1xBqJPWbuaHkXA=;
	b=EbpTseUUx/Z/JDg3jlxdMSz0DodVEK7aCFakFsBb1YmQAriOv3O/3Y0lSWmqHA5h7fn9
	 e1KnSqdD4jLwyKMcqgiUAtNeOlZ66aaNao2uTv/qQZX6ru3frTXmQ7hLvaysFQwiGBIFe
	 A7dA8tfJb2u2y6EqgF8jj1fRfYRMkXG22WkjzYMymv2GBr7YNX7/lRWSX08ArrQ8ZmdJo
	 B0Hn4D/U4+X7OT1J9OZ9ocoV25tJagP380hKMuu3Asw0jZzs3XB6JjEQYHt82iOUtWEt9
	 OhHMmWSAQejlTOqe8EOKf5BNHP+Zmy92f3qoB8yo+edNMDDq1v4NIUxjh+VDE34XAWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VY/qQQai";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07633606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VY/qQQai
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900CB1F000C4;
	Sat, 14 Nov 2026 17:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794678428;
	bh=wUS99+5bD74l0g6u7scaH+a/BayDu1xBqJPWbuaHkXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VY/qQQaiOQZmqSgdiiS4FfET6cMOK1O757/v8LKMQFzK3v9tIax/40l7QDXIpU0mC
	 JIjpgGNGtdAIdKfbOKUlDp7loWI4cRkG6E9eFPdTg9k7VPq0UmLgGrjlvydZRw4PLb
	 PXVBRwL0xZwvgTLYIOAELF34dpsqHortMY3L8p4npmYYcMQdINP1or3B3Z2JXUhyzM
	 QW+2PUKA6O0X3XxIVyQFtkpoS+Q6Zlw5XPmIDo6WZOS9SThOcT29ciOSS/G/3enRsd
	 4WBmzhPM59tNIZ4YM0Ux5hC7UQe5Kl1Zj0lyThK3qR7HzuQ3MxA6DhF+bFr8SN91eM
	 5t6o2QL2XPfsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Alistair Popple <apopple@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/migrate: snapshot the source nid before the misplaced migration
Date: Sat, 14 Nov 2026 12:47:06 -0500
Message-ID: <20261114174651.355700-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201713-failed-6.1-fe623a81ad9e@kernel.org>
References: <20261109201713-failed-6.1-fe623a81ad9e@kernel.org>
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

From: Yafang Shao <laoar.shao@gmail.com>

[ Upstream commit fe623a81ad9eddf10059b4e44bca0440d9120613 ]

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
[ sashal: adapted folio_nid(folio) to page_to_nid(page) in migrate_misplaced_page() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/migrate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 09acee0c43569..0f3af8eb6356c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2458,6 +2458,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	int isolated;
 	int nr_remaining;
 	unsigned int nr_succeeded;
+	int src_node = page_to_nid(page);
 	LIST_HEAD(migratepages);
 	int nr_pages = thp_nr_pages(page);
 
@@ -2495,7 +2496,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	}
 	if (nr_succeeded) {
 		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
-		if (!node_is_toptier(page_to_nid(page)) && node_is_toptier(node))
+		if (!node_is_toptier(src_node) && node_is_toptier(node))
 			mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
 					    nr_succeeded);
 	}
-- 
2.53.0

