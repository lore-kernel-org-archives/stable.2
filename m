Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420937;
	b=oi+MA6yR+usVjhzEWnc/ddfKymGrZv0MkAKjrEyCpDZUZHHfEQRbrPkgebZeDU6x5M7R
	 EY3/bQ0uNzS1x48syJtLVS7GgEgZAxR843ZwTpDYg5IWdqC24VbLuD+T+lKrj+jyruwH9
	 T/dZnAI96SiyKhFgRCWwnHL6zwnVRXaoPQUNIllgqPDIu2AXwy1ELyO5RszVA9+OeUo+u
	 AvIekl4DO8ryGdA7z/jUxPS71P7YdPs4YWYDQ9MvZpDVjzdfNh2523lc8SL3zADtJ7OXL
	 O/WHTYQ4ZN6ecPd+EZ1gFZKpFJWSElw+1zKR3bk+mCJHGz7chPcLb/0gzwdv+UoUzsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420937;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=F+0on+c6fgbk8jYItKkTyblkgmfkgI4yLzH5xLDODzE=;
	b=wNfmq3k/8JBWOYPYmFT30IFb4deLt0S8Obw4GckrUslaop7AlyGm27FPF1df4ZmrW4Kh
	 +q22RUayrRe77niqXwytysjUXeMKkgyGKZNzSeLfyyRcoU4thlit8s8iC5bT0NRjdmk0f
	 CV8p3ynOPm6Ba2+4//T+/52zVzrA9qidZJVp59+5+0sAnmSQOTTqwTHrL0q6FIPdlGrT3
	 Fm+e7ORIu9J67CmQi3YrMGsrMIumoYesiI4rW3lIaph14HAsrI2sYENGK0OtiWa3vNN2l
	 rw1dMsboOzDnzhi28dwz5WFQjPk2hdlyZpyzvparKnanYnYiZwTG0M+hQtEBENSUg6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5nxKlFa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64AA606AE24;
	Wed, 11 Nov 2026 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5nxKlFa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BC81F00A05;
	Wed, 11 Nov 2026 18:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420937;
	bh=F+0on+c6fgbk8jYItKkTyblkgmfkgI4yLzH5xLDODzE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Z5nxKlFapIrfQ2+7YDWIgZpI228prJbwMKR+k0L5557K/aWV0vkipZ07h6WUzbIo+
	 xHFhBH9mMF69uLXElOfTWf6qN/CQyftV/YElYK4638b1WVPVCqTxBoRZmZnBfp7/Hr
	 8+vwPkLMmQP/iL4zjiizcELRHhjnhJC0Ax4MG7gE/4/lnFHXgpHAyiD4jPqG7e9Z4s
	 l8rqxrj56O9E4thsdAHBCT7l4+OVxZbMe78vWUONdypjknEufaJmRHPTi/6EF9rc0M
	 wtEeTPO2/pLuBAw3m4letXcBGvZLqOzuJSdSb8I6OwELY4prDm5RzkZ/DX3LGCj4r6
	 ui+7WzbAwgVbA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 11 Nov 2026 18:13:23 +0000
Subject: [PATCH 09/13] mm/migrate_device: fix use-after-free of the anon
 rmap
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-mason-migrate-et-al-fixes-v1-9-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
To: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
 Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5441; i=ljs@kernel.org;
 h=from:subject:message-id; bh=K1/UpDA00InuyltqYw3wsCTORYhmIFURHVM5zyIq1ds=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+bMjJfB18ea4BB8tus9nZie9r7LIvdu83Ljp6KKT6D
 HuEw3uNjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEzk+ROG/+k/bfel9karHj51
 uDUvKs40lu/u++ysaTc4Hs7j8pzSU83w3+PylJotWz0uifMpGZ+fs6TsWfrVSW/3vVe+PEXg/6M
 3cSwA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

A munmap() of anonymous memory can result in a use-after-free of the
anonymous rmap if a concurrent device memory migration occurs and the
migration runs without the mmap_lock held.

This can occur for a long-term pin of device-coherent memory, or a driver
evicting its device memory by PFN.

Consider:

    eviction                        munmap()
    ========                        ========
    migrate_device_range()
      migrate_device_unmap()
        try_to_migrate()
                                    zap the migration entry
                                    unlink_anon_vmas()
                                      last VMA: free the anon_vma
    migrate_device_finalize()
      remove_migration_ptes()
        /* locks and walks the freed anon_vma */

If munmap() runs before try_to_migrate() instead, the folio is no longer
mapped and gets no migration entry. The walk still runs, and follows the
stale folio->mapping to the freed anon_vma.

Resolve this by pinning the anon rmap of each folio which possesses one in
migrate_device_range(), migrate_device_pfns() and
migrate_device_coherent_folio() before its PTEs are replaced, and
unpinning it once the walk is done.

A folio which is no longer mapped cannot be pinned and has no migration
entries to remove, so skip it rather than migrating it.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: e778406b40db ("mm/migrate_device.c: add migrate_device_range()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/migrate.h |  1 +
 mm/migrate_device.c     | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 78424b3824c2..c6cce7925b9b 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -136,6 +136,7 @@ static inline int migrate_misplaced_folio(struct folio *folio, int node)
 #define MIGRATE_PFN_MIGRATE	(1UL << 1)
 #define MIGRATE_PFN_WRITE	(1UL << 3)
 #define MIGRATE_PFN_COMPOUND	(1UL << 4)
+#define MIGRATE_PFN_ANON_RMAP	(1UL << 5)	/* mm internal */
 #define MIGRATE_PFN_SHIFT	6
 
 static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 7ebd02ec303b..5fe11dd01291 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -552,6 +552,27 @@ static bool migrate_vma_check_page(struct page *page, struct page *fault_page)
 	return true;
 }
 
+/*
+ * Pin the anonymous rmap if present to allow migration entries to be safely
+ * removed. Returns true if the pin succeeded or no pin is required, and false
+ * if the folio is no longer mapped.
+ */
+static bool pin_anon_rmap(struct folio *folio, unsigned long *src_pfn)
+{
+	if (!folio_test_anon(folio) || folio_test_ksm(folio))
+		return true;
+	if (!folio_get_anon_vma(folio)) /* Pin the anon rmap. */
+		return false;
+	*src_pfn |= MIGRATE_PFN_ANON_RMAP;
+	return true;
+}
+
+static void unpin_anon_rmap(struct folio *folio, unsigned long src_pfn)
+{
+	if (src_pfn & MIGRATE_PFN_ANON_RMAP)
+		put_anon_vma(folio_anon_vma(folio)); /* Unpin the anon rmap. */
+}
+
 /*
  * Unmaps pages for migration. Returns number of source pfns marked as
  * migrating.
@@ -633,6 +654,7 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
 
 		folio = page_folio(page);
 		remove_migration_ptes(folio, folio, 0);
+		unpin_anon_rmap(folio, src_pfns[i]);
 
 		src_pfns[i] = 0;
 		if (fault_folio != folio)
@@ -1335,6 +1357,7 @@ static void __migrate_device_finalize(unsigned long *src_pfns,
 		if (!folio_is_zone_device(dst))
 			folio_add_lru(dst);
 		remove_migration_ptes(src, dst, 0);
+		unpin_anon_rmap(src, src_pfns[i]);
 		if (fault_folio != src)
 			folio_unlock(src);
 		folio_put(src);
@@ -1384,6 +1407,7 @@ EXPORT_SYMBOL(migrate_vma_finalize);
 
 static unsigned long migrate_device_pfn_lock(unsigned long pfn)
 {
+	unsigned long src_pfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
 	struct folio *folio;
 
 	folio = folio_get_nontail_page(pfn_to_page(pfn));
@@ -1395,7 +1419,13 @@ static unsigned long migrate_device_pfn_lock(unsigned long pfn)
 		return 0;
 	}
 
-	return migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
+	if (!pin_anon_rmap(folio, &src_pfn)) {
+		folio_unlock(folio);
+		folio_put(folio);
+		return 0;
+	}
+
+	return src_pfn;
 }
 
 /**
@@ -1431,6 +1461,7 @@ int migrate_device_range(unsigned long *src_pfns, unsigned long start,
 		nr = folio_nr_pages(folio);
 		if (nr > npages - i) {
 			if (src_pfns[i] & MIGRATE_PFN_MIGRATE) {
+				unpin_anon_rmap(folio, src_pfns[i]);
 				folio_unlock(folio);
 				folio_put(folio);
 			}
@@ -1474,6 +1505,7 @@ int migrate_device_pfns(unsigned long *src_pfns, unsigned long npages)
 		nr = folio_nr_pages(folio);
 		if (nr > npages - i) {
 			if (src_pfns[i] & MIGRATE_PFN_MIGRATE) {
+				unpin_anon_rmap(folio, src_pfns[i]);
 				folio_unlock(folio);
 				folio_put(folio);
 			}
@@ -1509,6 +1541,11 @@ int migrate_device_coherent_folio(struct folio *folio)
 
 	folio_lock(folio);
 	src_pfn = migrate_pfn(folio_pfn(folio)) | MIGRATE_PFN_MIGRATE;
+	if (!pin_anon_rmap(folio, &src_pfn)) {
+		folio_unlock(folio);
+		folio_put(folio);
+		return -EBUSY;
+	}
 
 	/*
 	 * We don't have a VMA and don't need to walk the page tables to find

-- 
2.56.0

