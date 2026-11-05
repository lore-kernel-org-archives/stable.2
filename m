Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884258;
	b=CHxC9epFTJtDs9/gK1zWS/j6aubINCWPnFwploeyfp4kpNvemrrB+R3xYhjKUYlEPCIg
	 C6f+YBbT0Bu8ZQc52OuA545Ihx5eaNVeOjSypNs+7N1Y6ROhQfDT/pDvpz5sRVIrP0Iht
	 PI2hDRFuxmLhWptzyRjDqbb5AciF7+/zkGcnNIwFdJp8X+O7tsPBJVhN4Nf0K6FVbHM3N
	 iER4Mz5n/6VDiD2CR5R2ozL1v+uJrcdZljvgS4YabHtSjQZphcJ0uwSHuJA7UADc9AQ6T
	 cJu5EP6NL2M5vbzZIC9/9/UAV54QxzAJp/+S1QGtvAqE64KWMPKk0n7kGBNvtPWxlEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884258;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ptRwXs+qFV9fEGNsWtKWJXuC1Otq2C/mie9e+Nydci0=;
	b=wa6zjlf00bnngDXe5iaTQUw9MASSfszjXW1CJYJD0RW0tiEj7Fjyra6VgZaJkWWyfQQp
	 M5t6on1IMMR9D2QSydp3Fu4NAinTvZuuAfQwTOALwno9/sB+BMHHvwydlEeVHvxA1UPWX
	 IvPCqGGGuYo/QVJ5D1BtvlCYjtgOasDHz/Q/t13pt6c651X+x+Fa2h7EnlSgVlaZEGmjs
	 zrJaRS5kAp0sBjMEX/7A2JWAQLTk4mthR3ELv6iHfl4OMKJMou1SsFLbFrJ4mAyKVnHN4
	 Xb2IBo4W6SddPD137ptWOytR8nfcpk2u/hNfZo+4PhrfZeUXopmS4e4MvDWpn27ar9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JpWp30tP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078B2606A326;
	Thu,  5 Nov 2026 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JpWp30tP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1031F00919;
	Thu,  5 Nov 2026 13:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884257;
	bh=ptRwXs+qFV9fEGNsWtKWJXuC1Otq2C/mie9e+Nydci0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JpWp30tPOH2G0O7Q+53HnI7DrsDN+ie7Vbv6Rj4tMlqFaLM9bmEK1T6UnAYe0T+n8
	 Lxhg1fmeREyo7PFhObfrNFMBDkFQr3eiPTRGEeU404BRNBFNY5Hfs6OvoyfiGElW61
	 k0gcU7S6Q60oMBRO5n2xqYTFyCyPBWSfG9pQWC7w2hRzaF4dWRjLtNStY6CXae/TRp
	 1zPwa3WISiVXwWwEs5LpLTmc4UZfgiLPJEj+RAh3a4oOTZ9PRFhkvhYuC7RII3w1L6
	 QcT3qA2M3XbyI2uYA7meu5Nz83wgTYHVmiExh5WvyJs8Wm25X+0HOrz4YH5JGyk/yP
	 zVUURe72g+LBg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 05 Nov 2026 14:10:12 +0100
Subject: [PATCH 3/5] mm/mmu_gather: flush pending references early before
 the folio limit
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
Message-Id: <20261105-refcount_overflow_stable-v1-3-70b9c655da3e@kernel.org>
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2738; i=david@kernel.org;
 h=from:subject:message-id; bh=MIAUtxrNu7UMyrPfJ9US1972uvFhMmrdah8Cfagy62k=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLeNFiq3/mjLcK9MvXw3uXbsj6veW5f4bigbqJ15pvXZ
 8PfzbY36ChlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAi6zcwMry2UqzpjmZuylT/
 eeLMYuYd3u2qtYsWsJuvPMy68MCnoAagiuD10075KxZt8v7A+kxYMkBt1qGF6xXVD+26n75zafd
 iFgA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

When a task zaps mappings (e.g., MADV_DONTNEED), it can drop the PT lock
and defer dropping the folio references. In the meantime, page faults
can refault pagecache folios, creating more references for the same
folios.

Let's just request a flush after enqueueing a pagecache folio whose
refcount reached a certain threshold. Start flushing well before new
references are refused, regardless of the caller's privileges.

This is a temporary measure until we have something better.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 10ebac4f95e7 ("mm/memory: optimize unmap/zap with PTE-mapped THP")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mm.h | 1 +
 mm/memory.c        | 4 ++--
 mm/mmu_gather.c    | 5 +++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a82cfbce18215..87f7646a7f3ba 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2232,6 +2232,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
 /* Leave separate reserves for administrators and concurrent reference gains. */
 #define FOLIO_REF_COUNT_LIMIT		(INT_MAX - (1U << 26))
 #define FOLIO_REF_COUNT_ADMIN_LIMIT	(INT_MAX - (1U << 25))
+#define FOLIO_REF_COUNT_FLUSH_LIMIT	(INT_MAX - (1U << 27))
 
 /**
  * folio_ref_count_over_limit - Check whether to refuse more folio references.
diff --git a/mm/memory.c b/mm/memory.c
index 4800a0da14a32..d2eb313832559 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2061,8 +2061,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	pte_unmap_unlock(start_pte, ptl);
 
 	/*
-	 * If we forced a TLB flush (either due to running out of
-	 * batch buffers or because we needed to flush dirty TLB
+	 * If we forced a TLB flush (either to release batched
+	 * references or because we needed to flush dirty TLB
 	 * entries before releasing the ptl), free the batched
 	 * memory too. Come back again if we didn't do everything.
 	 */
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 9f353f0e2ef4d..5988c42cc5144 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -190,6 +190,11 @@ static bool __tlb_remove_folio_pages_size(struct mmu_gather *tlb,
 		batch->encoded_pages[batch->nr++] = encode_page(page, flags);
 		batch->encoded_pages[batch->nr++] = encode_nr_pages(nr_pages);
 	}
+	/* Flush pending references well before new references are refused. */
+	if (unlikely((unsigned int)folio_ref_count(page_folio(page)) >=
+		     FOLIO_REF_COUNT_FLUSH_LIMIT))
+		return true;
+
 	/*
 	 * Make sure that we can always add another "page" + "nr_pages",
 	 * requiring two entries instead of only a single one.

-- 
2.43.0

