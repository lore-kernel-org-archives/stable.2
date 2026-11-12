Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524076;
	b=G7B15jvoGdzJ0DVocAhnWl/sZsuq0pyv82VHcDHMXA1cqkwmkrox/qkTDRD+puqWkw+l
	 +erMpg1GwwR5l6inKHOu1ZYFdlkuCkrFjoY7+iVREFbugLZIBfhkTmOOWGAKRVBw9/eDY
	 mzderzUNEEVZhK/ekA6OBdNlByqgpWchmKr95wcjP14rMlpBDWA5ts82+vKwZxlzzJBwb
	 +KtHXjU8AbhhPOoTM3y5wnjekKmFM3geIOx7Zp1r5IH3Tx7RgzUwk1ZZTHBBHatDXssWF
	 YGWFOi4NxUfGILPFDT+PF26hHlagSS3dFwzDe3J4S71EOxUL34A/Z17uvRBMEXntGsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524076;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=K1dZH1YvZhyh+cLEFUJEOBrlUWrIfda/lmT3nY2eVCc=;
	b=TFPDm/AnB07NJkDOHQXL9j843S0HTXh2WCB4ghaQwWTxVXlg3XnMe7QZBdHuVZaJyJDg
	 rsoEqEKAp7+a+vtNvIrSMZUk2xr5ZBlnunAj5hj/xaaCoUCO0OcSICegBVL8r7idlCa6m
	 OdVO8qJYbWjVIjhqLu13ymcwnO9Gb9DZykaF6drIYLrbMqv3FThYdh/+6ieQD6arApsfo
	 pJJ/jEDYgSk/bOXI8kzLMEHF8LmPGqpTedGLX1imG+GDbTrd87Rs1P1g1HhyEOkM6F9g3
	 7+zssmRF4aJi0Qj4lHvHGn8D2kMacUtwhaYa0DvD7BLeryPdPgRfjiu05ISZ67yOxOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cScRwwZn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71742606A31C;
	Thu, 12 Nov 2026 22:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cScRwwZn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8901F000C4;
	Thu, 12 Nov 2026 22:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524076;
	bh=K1dZH1YvZhyh+cLEFUJEOBrlUWrIfda/lmT3nY2eVCc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cScRwwZnVKDY5k4lrXJBaqIB+uxLEnAOvxE85WolNlWGVAsRU9h8PW3BRF8n/DndM
	 9HA2xConM66zJWXUn9LzGQ/yvWkswzV8ZshsXzYDkT52bKq/w8vamAhe/si8Wr73Q6
	 zh63/N5jHEy/4VXmBqE7HBufCnJWZaAp5XtF3Rz/nOzIo3v/B2W0fVuIsff5EYm19Z
	 8KDxl4709Kgpu4wP0rUR8p2GV/N2rYxOslykEnED8R1B7rtgNxXIJVBQvmzdizikA0
	 B7rNwI/wmDwlKmP0d99vZ+Os11k4ujZNf5N/9+fdPhYQ6w+4ALN8vBGF/6HwqFTfiE
	 8Paz4LbPqFjFQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 12 Nov 2026 23:53:22 +0100
Subject: [PATCH v4 3/9] mm/mmu_gather: flush pending references early
 before the folio limit
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
Message-Id: <20261112-refcount_overflow_stable-v4-3-ad3deef0bd23@kernel.org>
References: <20261112-refcount_overflow_stable-v4-0-ad3deef0bd23@kernel.org>
In-Reply-To: <20261112-refcount_overflow_stable-v4-0-ad3deef0bd23@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Song Liu <songliubraving@fb.com>, 
 Rik van Riel <riel@surriel.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>, 
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 John Hubbard <jhubbard@nvidia.com>, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 fuse-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 Pedro Falcato <pfalcato@suse.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4551; i=david@kernel.org;
 h=from:subject:message-id; bh=M6ZE0TzsSadI7DldS4FZfDzB4hM5y3s4Zcai47p6Ir4=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+OWduvClSHzC3evXB9Lxt78xCsy8tnX7iAfebyKv7o
 54JGJ3Y0FHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEuL8z/C9Y+PRZek/930u8
 28Q3x/6aw+HzmDdG0HehxbomVkMPaz+G/znuRwKExbaphVsrmf5YcP5J553Tduz7/+Z7CF7LlWZ
 k5QMA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

When a task zaps mappings (e.g., MADV_DONTNEED), it can drop the PT lock
and defer dropping the folio references. In the meantime, page faults
can refault pagecache folios, creating more references for the same
folios. These deferred references can build up over multiple VMAs.

Let's just request a flush after enqueueing folios whose refcount reached
a certain threshold. Start flushing well before new references are refused,
regardless of the caller's privileges.

When returning "true" from __tlb_remove_folio_pages_size(), PTE zapping
will flush the TLB before dropping the PT lock, but drop the references
afterwards. Refaults can still race with that, but flushing early reduces
the risk of letting others hit the limit.

This is a temporary measure until we have something better.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@vger.kernel.org
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/asm-generic/tlb.h |  4 ++--
 include/linux/mm.h        |  1 +
 mm/memory.c               |  4 ++--
 mm/mmu_gather.c           | 10 ++++++----
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 3f4a180b48f3c..4bba02fd5d543 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -75,8 +75,8 @@
  *  - __tlb_remove_folio_pages_size()
  *
  *    __tlb_remove_folio_pages_size() is the basic primitive that queues pages
- *    for freeing. It will return a boolean indicating if the queue is (now)
- *    full and a call to tlb_flush_mmu() is required.
+ *    for freeing. It returns true when a call to tlb_flush_mmu() is required,
+ *    either because the queue is full or a folio is near its refcount limit.
  *
  *    tlb_remove_page() and tlb_remove_page_size() imply the call to
  *    tlb_flush_mmu() when required and has no return value.
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 383a5c2271d6b..0d00fc1838a01 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2232,6 +2232,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
 /* Leave separate reserves for administrators and concurrent reference gains. */
 #define FOLIO_REF_COUNT_LIMIT		(INT_MAX - (1U << 26))
 #define FOLIO_REF_COUNT_ADMIN_LIMIT	(INT_MAX - (1U << 25))
+#define FOLIO_REF_COUNT_FLUSH_LIMIT	(INT_MAX - (1U << 27))
 
 bool folio_ref_count_over_limit_slowpath(const struct folio *folio,
 		unsigned int ref_count);
diff --git a/mm/memory.c b/mm/memory.c
index f473df474f1b8..855d7d82ce9ce 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2076,8 +2076,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
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
index 9f353f0e2ef4d..e98397ac577c4 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -179,10 +179,7 @@ static bool __tlb_remove_folio_pages_size(struct mmu_gather *tlb,
 #endif
 
 	batch = tlb->active;
-	/*
-	 * Add the page and check if we are full. If so
-	 * force a flush.
-	 */
+	/* Add the pages before deciding whether we need to flush. */
 	if (likely(nr_pages == 1)) {
 		batch->encoded_pages[batch->nr++] = encode_page(page, flags);
 	} else {
@@ -190,6 +187,11 @@ static bool __tlb_remove_folio_pages_size(struct mmu_gather *tlb,
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
2.56.0

