Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606430;
	b=fMHkatxR6/vKRaW1AYF/wgdOj7TQMVmQ9Vw08R2JYC2YhcOZL55Tun8smS7RzvPcICNN
	 i6W6L34X6uN+rW/qPI9gvRlV/R9FtSk1FxZIEr1AH/4Er9q7QRZYc41193OMzsSyl7ChP
	 eFE014pSDb/HRZ/NKyu7a6i7KMXg0Pf1Psfy+kOeZoeBjCcQ1O45yfXz/uxJQNZFPq9yx
	 Sr9p6NPyQoQUfMxqKIqMaSUCF6WQFow/jn9xovRKWTfRYPLuv5k8lLbfhUVTCBju8TDcp
	 KvplyZUNF441KFvWTcsMrLm4IWtG1ozByvhDUn1edncYW2abEsxgQBrT67DvOCVomhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606430;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=apAT4VjpJC36vVjxGEJmMW5TwbguNTu7ge9I4OVkMS8=;
	b=LtJVeVH1EUKM1Pg2Lts+I6JaTiMLxA/BfkkuUF8YUNLO+xgB9wqr25RLa36vwgFBGxbz
	 TjioQIIKQXJSTQni6Pfa5kQKz6V7kGcd0EHGzPIFnm9fASKVBTaTsg5yr6+si+mrEZ1TQ
	 XUXWqKDcOdH7nHtvj/fJWtifYqBiWt/d0mNg8UcftJQBlcTJfxFKWwUU2iB6AAWDa67K+
	 9NKA8/rEY5TznoY2zn2ohav8K6cRx1k/+yZw+F/7/L/SglzNXZ2Inse/+9M6lTba0R4aC
	 uxUb8iW/a/pjIeCDOigpP6q5f+jT9o8/a7WTEAFiTY8vjw10yIHV2bo+DgPuN7m4xYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m3MKDB77;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B5606A885;
	Fri, 13 Nov 2026 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m3MKDB77
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455181F000C4;
	Fri, 13 Nov 2026 21:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606429;
	bh=apAT4VjpJC36vVjxGEJmMW5TwbguNTu7ge9I4OVkMS8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=m3MKDB77Ap4k/9FV325kHd7dhlR5iioZTOIr0DiIMZH0JljSRcnA2DJxvlFLC9n+H
	 c54nMPE7y8quq0sj0qQPd4lXplLnVS51jx3geyudAWreMzKhsSXOjgGjWqkQwCdZBM
	 1bLml3OtBeDqd73kvAjdA6pMrXTlQYNdA54I5BWofbgaNp8LqqPKkvKy9HcZGlVwkl
	 3ORM9hxVgh+CyndWH2w1pUuA4vkxfPNj5yp4bzINF8eLIhp44xq2iHfhtMClMaBWhp
	 V4qtiIjPGP+e/4nC1PkPYeB+k3AyC1cfxC6w2v8jlvXALy+GmS+mAwGXLd9vBCINQ4
	 LmUXwLaUISmEQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 13 Nov 2026 21:45:27 +0000
Subject: [PATCH v2 09/13] mm/migrate_device: fix use-after-free of the anon
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
Message-Id: <20261113-mason-migrate-et-al-fixes-v2-9-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5530; i=ljs@kernel.org;
 h=from:subject:message-id; bh=OX27u7rU+9JbIx9DBrYTwdwqvdYrHdIaQA8QSBlifPs=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+t/yMLL5cc07vbbfb2jn6rg+0tK7svDX1n5nTr1Xbz
 667I5DzpKOUhUGMi0FWTJHl+Rfx/UEiYfM6L/i7wcxhZQIZwsDFKQATUTvOyDBbS6LtTvq5TxIb
 Vn8LlCwodQjXWHpjUtx6rYM6DhHv42cyMlw8HnnSLV6/7c/Kda78ufJmXx0T50euvC3wUK7jSxX
 ze14A
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
Cc: stable@vger.kernel.org
Reviewed-by: Zi Yan <ziy@nvidia.com>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
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
index 141d60d27e90..b4660eeb975a 100644
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
@@ -1331,6 +1353,7 @@ static void __migrate_device_finalize(unsigned long *src_pfns,
 		if (!folio_is_zone_device(dst))
 			folio_add_lru(dst);
 		remove_migration_ptes(src, dst, 0);
+		unpin_anon_rmap(src, src_pfns[i]);
 		if (fault_folio != src)
 			folio_unlock(src);
 		folio_put(src);
@@ -1380,6 +1403,7 @@ EXPORT_SYMBOL(migrate_vma_finalize);
 
 static unsigned long migrate_device_pfn_lock(unsigned long pfn)
 {
+	unsigned long src_pfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
 	struct folio *folio;
 
 	folio = folio_get_nontail_page(pfn_to_page(pfn));
@@ -1391,7 +1415,13 @@ static unsigned long migrate_device_pfn_lock(unsigned long pfn)
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
@@ -1427,6 +1457,7 @@ int migrate_device_range(unsigned long *src_pfns, unsigned long start,
 		nr = folio_nr_pages(folio);
 		if (nr > npages - i) {
 			if (src_pfns[i] & MIGRATE_PFN_MIGRATE) {
+				unpin_anon_rmap(folio, src_pfns[i]);
 				folio_unlock(folio);
 				folio_put(folio);
 			}
@@ -1470,6 +1501,7 @@ int migrate_device_pfns(unsigned long *src_pfns, unsigned long npages)
 		nr = folio_nr_pages(folio);
 		if (nr > npages - i) {
 			if (src_pfns[i] & MIGRATE_PFN_MIGRATE) {
+				unpin_anon_rmap(folio, src_pfns[i]);
 				folio_unlock(folio);
 				folio_put(folio);
 			}
@@ -1505,6 +1537,11 @@ int migrate_device_coherent_folio(struct folio *folio)
 
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

