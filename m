Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794677856;
	b=mg/YhZguo8yekLUSSBqFAyDBqvjj/5l3u8maDx+fsXTwld6l0V9XZPEEbCV6E6DwyKqM
	 pB6ukkJz160MQC4XHhNhvGJ3er+hwqlo93Jnvy5Y0YcyyFrcLNXh/AhYWV4PaQrjIquun
	 DVtIiRlsbR4yOD0wwrZWnymr2GAtZaJ3OMxEX7OuQxpJjbzOxOf+pJRaWaZr3RaQxOKY/
	 ByZYCnO9tDgcMHO0JzB/44sSyJnEZTRD3/Hgk5h4G/Zvr3vm887BOIl6E8bent6xNnIpF
	 KwMpDsKJ7hpJqTU+UuygjSN+rXrHt3lxSBQGpWqWxD0gYSfp9sbVlryt5Fcqie20jHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794677856;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6SBH8xigIaMfpVkNAgLeBV5qATGFn0HZmmqcoaIWlz4=;
	b=3zEEom2OMz6xOHUXuJTGFUWYc5LvPt6+nP5QSD8kpvlFjVd84uYNVX1d1taYNA/i8Q/p
	 b29CYVE1C0DSwxNqnNTSt2sKu4cv/204ycqXRd65dZMnITWtTXiAQ0zG/pf6/JdDzBSit
	 /4cSKGUH/bJ9Cy3nBnELDVkOWIkO19CC5POtGS6MJowgjTavKWK0PyOahXsv9e1Jgyp5q
	 fb1jcP/0xhivHYNQAvCcq0wEUCAKcddsYbOSTO7ANAgtiRCsqLQfAk1udmzGNI2bCDmP1
	 4c7IFMqjWGNWIdgfGUh8FW3NLLpBZsKq+/r97hFw9KxrEHI3bM/uv7KjuwE4eTWzHzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hr+Q+q+I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58027606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hr+Q+q+I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9739E1F000C5;
	Sat, 14 Nov 2026 17:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794677856;
	bh=6SBH8xigIaMfpVkNAgLeBV5qATGFn0HZmmqcoaIWlz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hr+Q+q+IxrugFKaitnUMuNC//DaCRGF9Ebs/DZqL3CnrCFZgobqu9fBrZXwl0my8f
	 GUjnv2f8IB1PhRkRWzJFFHIey1NY4dw3NM/L/Z+kWuLh50z1IYdJtkjgb/PvM10x55
	 /lHB5dlCLByPWtjBvjvZCGznbg6f95E2MAE8AGed3HRNLjJwnTmPd3LrvCRn/yasQ2
	 7g3EJky6MTKuKwDNvFhOg7hDpxYYDdzugM2mmXlZlMGuOxcfoZHqWX2MVi9h544lY7
	 n8YKBimPKUIlvSVZ9AqwZ8yTDmpSpwvdgCbeD71X8yutdKOmnJ2UtgeEuWUvVpKFhh
	 jmwQmNzb2M6BA==
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
Subject: [PATCH 6.6.y] mm/migrate: snapshot the source nid before the misplaced migration
Date: Sat, 14 Nov 2026 12:37:33 -0500
Message-ID: <20261114173721.336559-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201228-failed-6.6-fe623a81ad9e@kernel.org>
References: <20261109201228-failed-6.6-fe623a81ad9e@kernel.org>
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
[ sashal: Replaced folio_nid(folio) with page_to_nid(page) to fit migrate_misplaced_page(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/migrate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 0b8c4fe36c714..8612b22aa08ed 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2572,6 +2572,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	int isolated;
 	int nr_remaining;
 	unsigned int nr_succeeded;
+	int src_node = page_to_nid(page);
 	LIST_HEAD(migratepages);
 	int nr_pages = thp_nr_pages(page);
 
@@ -2609,7 +2610,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
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

