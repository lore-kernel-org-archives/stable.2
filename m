Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884268;
	b=UncyaDcvmOwK/wCM1MHE9ds0HlKtvaRv7hLll2UCNdQOHYuIWgSsspgWOygCnEdm4ZUR
	 L9brXs5XH9PkQAfW3OSFI1a6uo0kcS1Vwd+28J9b1g34vLlDuhU5Z6wTsW7VxsY75udJc
	 PtFt6Bfn14MGYQKlVKxT4iUV/4w0naXVlBchJ3K/LSKCdkBQj+m00eUPB7OVaPgjYOR97
	 L7lDPHLqRawfRaLCodyqRNwJwPAsr2KvsC0av8CpbK6KFWVvEXq+wlFMd8YwMkTnIiNSl
	 4kQIPvuJxdPOWYQhUJ21kkAMckmiGdxo4jdzgD0CNNNF45DvKHVi1oGSajsD2pKJiXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884268;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=KCJIKkyLRcnhroO1aaONY++L92KXRYW5XDFDK8Wryfs=;
	b=Uo16S2Qkb8h1EfrxVT9gyNnbteQ7Rr0Fze41KJUILE7qm1mzyzkFGcehspGmKYLtWPnC
	 gOLZU+JjCC6LSOeR43YBg16K/4D7dHdwp/rUuWhIF70SulmoWE4hgpVNvERBytRm9UI22
	 PZORlXAyXw9JgoosDvHTwtkbl+pN+zRaKSNFISMptYL1A5xkUDpH5ASjU9XXA6oLWKwu7
	 UZSSJA1RNs0t2UOoCAwvu4OcNcZQrE3p5xMN4tRicrauqBEhmmTP5AZnxZymYuzIQVr2N
	 tjAZnQBF0Fhd/AXbAFuRTRUAwsjX0WcWMWW3V1/bd8Ft3QAAtgg6drOGDyvyHvA8kVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mVrw6HHV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DC0606A32D;
	Thu,  5 Nov 2026 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mVrw6HHV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390651F000C1;
	Thu,  5 Nov 2026 13:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884268;
	bh=KCJIKkyLRcnhroO1aaONY++L92KXRYW5XDFDK8Wryfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mVrw6HHV+bupF80pNKlnzcHxZw7ocqJUw/vupnR9C6ML8QwB2ebc8FIKYBQGXMg03
	 AmLAafGsgoET5s5J7aC2Uhm9bA1+jRFQXsPZbz0ViqK426+QPJab6y/dIiuiPtzkBW
	 qwU5R30Xe6wdVFOjA3awVfFYZZg040ThA3bZhNUI+yzPM07XXLKG7a+6eJEiqaUEe5
	 HlpkZHYAeQwU9q7oMs0L0FbS5ekVtDfvcU32wh2CP20ffvo0b9SSJXzbsefbmSrWKX
	 7Kxb8btNKdCjJozD1GqxSDedQ4ioKKWr05D5rzTQfPKB6PnB/ILLTuIhZyBnOicXuz
	 hF0wsoc9x7VuA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 05 Nov 2026 14:10:13 +0100
Subject: [PATCH 4/5] iommufd: fix cleanup when adding memfd folio pins
 fails
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
Message-Id: <20261105-refcount_overflow_stable-v1-4-70b9c655da3e@kernel.org>
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
In-Reply-To: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Song Liu <songliubraving@fb.com>, 
 Rik van Riel <riel@surriel.com>, Hugh Dickins <hughd@google.com>, 
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 iommu@lists.linux.dev, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3513; i=david@kernel.org;
 h=from:subject:message-id; bh=xhwhJlBPehyF74AdW/XvbNaMmG2B0qFeGlvJE2A5afE=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLeNFiGOoi/Tqjd2rLuo3LI1uLV80+ylDX63QtS+rj86
 OueK6VRHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExE6DbDfz/rnLXTG9YuvdW2
 v51td9KxD6+qG2787ev49NvQfrud2EmG//4fPNv0dn6R3P9i937u91PqfXfvuqq7qbV7yhZB1rP
 durwA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

folio_add_pins() can fail after memfd_pin_folios() succeeded pinning a
folio. Upcoming folio refcount limit checks will make this easier to
trigger.

Let's fix three problems in the error handling:

1. pfn_reader_release_pins() uses the allocated array size instead of the
   number of folios returned by memfd_pin_folios(). With large folios,
   cleanup can unpin uninitialized entries. Remember the number of returned
   folios and use that during cleanup.

2. pin_memfd_pages() returns on failure without releasing the pins acquired
   by the current call. Release the per-page pins for folios already
   expanded into the page array, and the single pins for the remaining
   folios.

3. pfn_reader_next() returns on failure before updating batch_end_index,
   even if the batch already contains successfully expanded folios. Update
   it before propagating the error so cleanup releases those pins as well.

Fixes: 92687c793644 ("iommufd: pfn_reader for file mappings")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 drivers/iommu/iommufd/pages.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 2f6153108add7..fcdbde007a9ab 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -781,6 +781,7 @@ struct pfn_reader_user {
 	struct file *file;
 	struct folio **ufolios;
 	size_t ufolios_len;
+	unsigned long ufolios_count;
 	unsigned long ufolios_offset;
 	struct folio **ufolios_next;
 };
@@ -800,6 +801,7 @@ static void pfn_reader_user_init(struct pfn_reader_user *user,
 	user->file = (pages->type == IOPT_ADDRESS_FILE) ? pages->file : NULL;
 	user->ufolios = NULL;
 	user->ufolios_len = 0;
+	user->ufolios_count = 0;
 	user->ufolios_next = NULL;
 	user->ufolios_offset = 0;
 }
@@ -843,6 +845,7 @@ static long pin_memfd_pages(struct pfn_reader_user *user, unsigned long start,
 
 	offset >>= PAGE_SHIFT;
 	user->ufolios_next = user->ufolios;
+	user->ufolios_count = nfolios;
 	user->ufolios_offset = offset;
 
 	for (i = 0; i < nfolios; i++) {
@@ -859,8 +862,12 @@ static long pin_memfd_pages(struct pfn_reader_user *user, unsigned long start,
 			} else {
 				int rc = folio_add_pins(folio, npin - 1);
 
-				if (rc)
+				if (rc) {
+					unpin_user_pages(user->upages,
+							 upages - user->upages);
+					unpin_folios(user->ufolios + i, nfolios - i);
 					return rc;
+				}
 
 				while (npin--)
 					*upages++ = folio_page(folio, offset++);
@@ -1251,14 +1258,14 @@ static int pfn_reader_next(struct pfn_reader *pfns)
 			return -EINVAL;
 
 		rc = pfn_reader_fill_span(pfns);
+		pfns->batch_end_index = pfns->batch_start_index +
+					pfns->batch.total_pfns;
 		if (rc)
 			return rc;
 
 		if (WARN_ON(!pfns->batch.total_pfns))
 			return -EINVAL;
 
-		pfns->batch_end_index =
-			pfns->batch_start_index + pfns->batch.total_pfns;
 		if (pfns->batch_end_index == pfns->span.last_used + 1)
 			interval_tree_double_span_iter_next(&pfns->span);
 
@@ -1320,7 +1327,7 @@ static void pfn_reader_release_pins(struct pfn_reader *pfns)
 		if (!user->file) {
 			unpin_user_pages(user->upages + start_index, npages);
 		} else {
-			long n = user->ufolios_len / sizeof(*user->ufolios);
+			const unsigned long n = user->ufolios_count;
 
 			unpin_folios(user->ufolios_next,
 				     user->ufolios + n - user->ufolios_next);

-- 
2.43.0

