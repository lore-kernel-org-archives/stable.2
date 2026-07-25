Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2633859E2
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784976878; cv=none; b=nclyedym9KQF4LAL/k8siP7dAj1oMV/nvwUv/Cvlp5LqslmYXv1rLCVNb4/4N53cUQFcgPT+1d3yM4b44EW9odxebq0VT93FcwEeODstMZJ5IGA6iX3TGS5NyU7vDYmth0fEWWDogP6jPtuLBoBohKwUjFBit2gknX7EyukCxvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784976878; c=relaxed/simple;
	bh=ydxbDh3ZGMLYWiZRKl11xIOQmwqwsGKggfGdRXnarFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGS0m/6wPrtsbmYrPhqIJQ7r+t/o1KpGUfcKOQn9SR8bbZyAseMPRLZvXN8JzaXKS3Q5avfSOhIvu65iZjj6bfonvlzK/JpeMBbyPSyNRNxWu3NCjVdCV3WkatinDJLb6lvHF3vPesofI7j5dRRnv/eljjf99m2FJryOe2My4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odMQVU/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odMQVU/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623C01F000E9;
	Sat, 25 Jul 2026 10:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784976877;
	bh=bRVKPqZCBSzepK906iK2ogclbBAUlOY4UmQb37FxGgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=odMQVU/tvNPRv6tkHkaRTYeDMwEkMo9nQ0p25xSl6A5yaY271Tsd2zGlfNLrkYmqw
	 7FG77OQT1oUkzo7gv+UyEAQ4x2JW0qes0cia3ubnKPFZPWwmzwZw088mYuGdeG+G9u
	 eMHMnlPsx2D4L085MuhhVejURwtdUAfkYdvDbMZMFpeWDG22z6yXNtWvyW9Raqe7vO
	 Y/w9NoZ+gILqlcRwnIp2UksWnCOxPefxUF2t6XokRC27z3XdlLUZm4veq3BVGjzk3Y
	 9IK9thDevPNVUjFGzCGNPeeZI0J7znTOqXXTp76PNtZcoXGZ6JFFqJA0UhLA2RN9Vb
	 bkyRND2Bb3Zeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] kho: add interfaces to unpreserve folios, page ranges, and vmalloc
Date: Sat, 25 Jul 2026 06:54:32 -0400
Message-ID: <20260725105433.1853930-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072031-lapping-tubby-5b19@gregkh>
References: <2026072031-lapping-tubby-5b19@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pasha Tatashin <pasha.tatashin@soleen.com>

[ Upstream commit 36f8f7ef7fd2f238922e9d217e86c69838319d8c ]

Allow users of KHO to cancel the previous preservation by adding the
necessary interfaces to unpreserve folio, pages, and vmallocs.

Link: https://lkml.kernel.org/r/20251101142325.1326536-4-pasha.tatashin@soleen.com
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Alexander Graf <graf@amazon.com>
Cc: Changyuan Lyu <changyuanl@google.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Simon Horman <horms@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 0e39380a7316 ("kho: make sure scratch size is always aligned by CMA_MIN_ALIGNMENT_BYTES")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/kexec_handover.h |  18 ++++++
 kernel/kexec_handover.c        | 104 ++++++++++++++++++++++++++++-----
 2 files changed, 109 insertions(+), 13 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 25042c1d8d54af..e1af332a262fba 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -52,8 +52,11 @@ bool kho_is_enabled(void);
 bool is_kho_boot(void);
 
 int kho_preserve_folio(struct folio *folio);
+int kho_unpreserve_folio(struct folio *folio);
 int kho_preserve_pages(struct page *page, unsigned int nr_pages);
+int kho_unpreserve_pages(struct page *page, unsigned int nr_pages);
 int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
+int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation);
 struct folio *kho_restore_folio(phys_addr_t phys);
 struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages);
 void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
@@ -83,17 +86,32 @@ static inline int kho_preserve_folio(struct folio *folio)
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_unpreserve_folio(struct folio *folio)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 {
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int kho_preserve_vmalloc(void *ptr,
 				       struct kho_vmalloc *preservation)
 {
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct folio *kho_restore_folio(phys_addr_t phys)
 {
 	return NULL;
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index c13b99f7c9891e..37e6048118e8b7 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -153,26 +153,33 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
 	return no_free_ptr(elm);
 }
 
-static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
-			     unsigned long end_pfn)
+static void __kho_unpreserve_order(struct kho_mem_track *track, unsigned long pfn,
+				   unsigned int order)
 {
 	struct kho_mem_phys_bits *bits;
 	struct kho_mem_phys *physxa;
+	const unsigned long pfn_high = pfn >> order;
 
-	while (pfn < end_pfn) {
-		const unsigned int order =
-			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
-		const unsigned long pfn_high = pfn >> order;
+	physxa = xa_load(&track->orders, order);
+	if (WARN_ON_ONCE(!physxa))
+		return;
 
-		physxa = xa_load(&track->orders, order);
-		if (WARN_ON_ONCE(!physxa))
-			return;
+	bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
+	if (WARN_ON_ONCE(!bits))
+		return;
+
+	clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
+}
+
+static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
+			     unsigned long end_pfn)
+{
+	unsigned int order;
 
-		bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
-		if (WARN_ON_ONCE(!bits))
-			return;
+	while (pfn < end_pfn) {
+		order = min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
 
-		clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
+		__kho_unpreserve_order(track, pfn, order);
 
 		pfn += 1 << order;
 	}
@@ -739,6 +746,30 @@ int kho_preserve_folio(struct folio *folio)
 }
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
 
+/**
+ * kho_unpreserve_folio - unpreserve a folio.
+ * @folio: folio to unpreserve.
+ *
+ * Instructs KHO to unpreserve a folio that was preserved by
+ * kho_preserve_folio() before. The provided @folio (pfn and order)
+ * must exactly match a previously preserved folio.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_unpreserve_folio(struct folio *folio)
+{
+	const unsigned long pfn = folio_pfn(folio);
+	const unsigned int order = folio_order(folio);
+	struct kho_mem_track *track = &kho_out.track;
+
+	if (kho_out.finalized)
+		return -EBUSY;
+
+	__kho_unpreserve_order(track, pfn, order);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_unpreserve_folio);
+
 /**
  * kho_preserve_pages - preserve contiguous pages across kexec
  * @page: first page in the list.
@@ -783,6 +814,33 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 }
 EXPORT_SYMBOL_GPL(kho_preserve_pages);
 
+/**
+ * kho_unpreserve_pages - unpreserve contiguous pages.
+ * @page: first page in the list.
+ * @nr_pages: number of pages.
+ *
+ * Instructs KHO to unpreserve @nr_pages contiguous pages starting from @page.
+ * This must be called with the same @page and @nr_pages as the corresponding
+ * kho_preserve_pages() call. Unpreserving arbitrary sub-ranges of larger
+ * preserved blocks is not supported.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
+{
+	struct kho_mem_track *track = &kho_out.track;
+	const unsigned long start_pfn = page_to_pfn(page);
+	const unsigned long end_pfn = start_pfn + nr_pages;
+
+	if (kho_out.finalized)
+		return -EBUSY;
+
+	__kho_unpreserve(track, start_pfn, end_pfn);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_unpreserve_pages);
+
 struct kho_vmalloc_hdr {
 	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
 };
@@ -944,6 +1002,26 @@ int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
 }
 EXPORT_SYMBOL_GPL(kho_preserve_vmalloc);
 
+/**
+ * kho_unpreserve_vmalloc - unpreserve memory allocated with vmalloc()
+ * @preservation: preservation metadata returned by kho_preserve_vmalloc()
+ *
+ * Instructs KHO to unpreserve the area in vmalloc address space that was
+ * previously preserved with kho_preserve_vmalloc().
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
+{
+	if (kho_out.finalized)
+		return -EBUSY;
+
+	kho_vmalloc_free_chunks(preservation);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_unpreserve_vmalloc);
+
 /**
  * kho_restore_vmalloc - recreates and populates an area in vmalloc address
  * space from the preserved memory.
-- 
2.53.0

