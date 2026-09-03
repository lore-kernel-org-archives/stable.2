Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7794EC659
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460030; cv=none; b=jsBJOAo/5BPrlzYIoGU2wwJVZ6cLcGJQX8D+G8AaVX9cy6xoPjw+Lo0X4dRYHK6jTeT1svQ7MxpdlkdlQuBUzcJGP6lV9PhK56mp/sYqk7da5DfsP1R0bo0H1V3+XjimLtVw3b38OYTW0RnXM4cuAOk1kwaHYf6Ba9QM55QJ7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460030; c=relaxed/simple;
	bh=NTHEgobFKWPXgsyTVETDcQkEnOYlmoOVxIpEQLBD5m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BN4/594xmKXzdrSjxWmeFwTumzWzGMQXV5x7PGIU00NiACuxPmmBAUDzadNryA+LNJ51Cfj5Pt7cYzi6h0P4vN5augRNTprIjTsoQrLxNFYb56OaeFEcpMv9mGod23wu5KA+DmArzKZVIN6s6JbNRHcz+jnNKmdiy6Fj3kmnKao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y84M4tkh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y84M4tkh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80B11F00AC4;
	Thu,  3 Sep 2026 18:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788460022;
	bh=OXuGj52YRJxu2DF5vTUU6ZdFgH15vFwtJLsHlKgBOVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y84M4tkh/OAuKLmXd+vsxU5wKUJ5Wt0cP6w3iALPuENtccV8cS3rmBAlG02Z0EWLz
	 p/i17rxZa8BtiE1N4ZCmFvgxyP+CND4EUJ+wJfgHKl/YerWnQ+CiPD88CNKHZtOWq7
	 TFHVglvSVenhhBpo4001fguLCcjfAulpOEM3Srf07OvAbclJf7wD2+3zHZMXYG3eN0
	 rQAVrmhgOCU6OgwK+GfGL0xPRi9LK/mhK7Wp8ML2N0UW0l3ysU7akZdEIbdKAM29sJ
	 GLfxKI+HfDuJVA1UjWW+z1mB6WGVhmh6MvZPt5gJGovTiomXeKZKBpuU85H5Z4+jP0
	 VsypiXsPYCKoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Jann Horn <jannh@google.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Lance Yang <lance.yang@linux.dev>,
	Liam Howlett <liam.howlett@oracle.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Rik van Riel <riel@surriel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/6] migrate: replace RMP_ flags with TTU_ flags
Date: Thu,  3 Sep 2026 14:26:49 -0400
Message-ID: <20260903182650.1451393-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903182650.1451393-1-sashal@kernel.org>
References: <2026090356-glacial-cornball-be8c@gregkh>
 <20260903182650.1451393-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit 832d95b5314eea558cf4cc9ca40db10122ce8f63 ]

Instead of translating between RMP_ and TTU_ flags, remove the RMP_ flags
and just use the TTU_ flag space; there's plenty available.

Possibly we should rename these to RMAP_ flags, and maybe even pass them
in through rmap_walk_arg, but that can be done later.

Link: https://lkml.kernel.org/r/20260109041345.3863089-3-willy@infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Jann Horn <jannh@google.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: c299a2285d9d ("mm/huge_memory: use folio's memcg inside __folio_split()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/rmap.h |  9 +++------
 mm/huge_memory.c     |  6 +++---
 mm/migrate.c         | 12 ++++++------
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index daa92a58585d9..7afc6abe1c235 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -92,6 +92,7 @@ struct anon_vma_chain {
 };
 
 enum ttu_flags {
+	TTU_USE_SHARED_ZEROPAGE	= 0x2,	/* for unused pages of large folios */
 	TTU_SPLIT_HUGE_PMD	= 0x4,	/* split huge PMD if any */
 	TTU_IGNORE_MLOCK	= 0x8,	/* ignore mlock */
 	TTU_SYNC		= 0x10,	/* avoid racy checks with PVMW_SYNC */
@@ -1000,12 +1001,8 @@ int mapping_wrprotect_range(struct address_space *mapping, pgoff_t pgoff,
 int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 		      struct vm_area_struct *vma);
 
-enum rmp_flags {
-	RMP_LOCKED		= 1 << 0,
-	RMP_USE_SHARED_ZEROPAGE	= 1 << 1,
-};
-
-void remove_migration_ptes(struct folio *src, struct folio *dst, int flags);
+void remove_migration_ptes(struct folio *src, struct folio *dst,
+		enum ttu_flags flags);
 
 /*
  * rmap_walk_control: To control rmap traversing for specific needs
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7df0a1380738c..4febfb980e2b0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3296,7 +3296,7 @@ static void remap_page(struct folio *folio, unsigned long nr, int flags)
 	if (!folio_test_anon(folio))
 		return;
 	for (;;) {
-		remove_migration_ptes(folio, folio, RMP_LOCKED | flags);
+		remove_migration_ptes(folio, folio, TTU_RMAP_LOCKED | flags);
 		i += folio_nr_pages(folio);
 		if (i >= nr)
 			break;
@@ -3700,8 +3700,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	struct folio *new_folio, *next;
 	int nr_shmem_dropped = 0;
 	enum ttu_flags ttu_flags = 0;
-	pgoff_t end = 0;
 	int ret;
+	pgoff_t end = 0;
 
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
@@ -3946,7 +3946,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		shmem_uncharge(mapping->host, nr_shmem_dropped);
 
 	if (!ret && is_anon)
-		ttu_flags = (enum ttu_flags)RMP_USE_SHARED_ZEROPAGE;
+		ttu_flags = TTU_USE_SHARED_ZEROPAGE;
 	remap_page(folio, 1 << old_order, ttu_flags);
 
 	/*
diff --git a/mm/migrate.c b/mm/migrate.c
index e66d9cc67dda3..acf93087d5ab3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -451,11 +451,12 @@ static bool remove_migration_pte(struct folio *folio,
  * Get rid of all migration entries and replace them by
  * references to the indicated page.
  */
-void remove_migration_ptes(struct folio *src, struct folio *dst, int flags)
+void remove_migration_ptes(struct folio *src, struct folio *dst,
+		enum ttu_flags flags)
 {
 	struct rmap_walk_arg rmap_walk_arg = {
 		.folio = src,
-		.map_unused_to_zeropage = flags & RMP_USE_SHARED_ZEROPAGE,
+		.map_unused_to_zeropage = flags & TTU_USE_SHARED_ZEROPAGE,
 	};
 
 	struct rmap_walk_control rwc = {
@@ -463,9 +464,9 @@ void remove_migration_ptes(struct folio *src, struct folio *dst, int flags)
 		.arg = &rmap_walk_arg,
 	};
 
-	VM_BUG_ON_FOLIO((flags & RMP_USE_SHARED_ZEROPAGE) && (src != dst), src);
+	VM_BUG_ON_FOLIO((flags & TTU_USE_SHARED_ZEROPAGE) && (src != dst), src);
 
-	if (flags & RMP_LOCKED)
+	if (flags & TTU_RMAP_LOCKED)
 		rmap_walk_locked(dst, &rwc);
 	else
 		rmap_walk(dst, &rwc);
@@ -1530,8 +1531,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 		rc = move_to_new_folio(dst, src, mode);
 
 	if (page_was_mapped)
-		remove_migration_ptes(src, !rc ? dst : src,
-				ttu ? RMP_LOCKED : 0);
+		remove_migration_ptes(src, !rc ? dst : src, ttu);
 
 	if (ttu & TTU_RMAP_LOCKED)
 		i_mmap_unlock_write(mapping);
-- 
2.53.0

