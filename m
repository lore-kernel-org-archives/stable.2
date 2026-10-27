Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116016;
	b=VTVwP64KCyM1EagU7ZrUc+dmZJaRq47+0z6DCtRIDtHT3iLTpTMH+Ak0rlJB/AnK9923
	 6fJlTN16Yna13P97P6MdU03cBALshbZSVjQB+FbL63kkQ3byIXjtCs0mGT6BlbVvu+Z5r
	 cT25cwB/mgYrlMX4sRWac9ax1gApEHA8764KgZvwm4TuWoIrEDiaUaYQw5r2IKcA3GCMc
	 3b89uTXNEw9wt0310vTSWezTYhzLmR7cqGvW7rSmjov1m5zZdEiR9YWU8rKM6R56PmIXv
	 XkCv7d6NvhB57dbEfq9laoFcETXfKyvsZXewFf8M1sQdvIXXnjIpstxl6NqSmnCFIEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116016;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=CF4JG26SyUmlFQ+N2KC4es1n4tmJXfM005qUTadw3Gc=;
	b=MCtIkfR+SK2EPZLUc3+hnJajW8z1TMbUXIUxWCb1AnCcos9h4a+kuICav9O96DWcRxI+
	 COJtjYcCqfdfXVc3QEWGy1mqrJVCYt/RvR3CmYOiWFeUcCYBxRswoksGqU2Mohx9mQed4
	 kLlimFZFpZ4/em3hIXMqvZ8+aMDLm2bQxO6fyWllNeQa+dqD4RK+6NfuFxZtwJiVakp28
	 /EbiI1QolnulHe0hWQJj4OBD4ofS3b1lJWw+0NlIqUaGRYkSdt/anhFLvFisJOmmd4RHd
	 VBbdUXs/XF4I+gq77fAakItC+iPQXzlqYkxLQ4bjnXK6ccOqbIq/cdGZhPy0+Te4Trw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6oFFEUT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC9960A3816;
	Tue, 27 Oct 2026 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6oFFEUT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA381F01825;
	Tue, 27 Oct 2026 15:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793116016;
	bh=CF4JG26SyUmlFQ+N2KC4es1n4tmJXfM005qUTadw3Gc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=W6oFFEUTbkszQPQTUqjH2nM9wxzFXgif+iYI3lQBmt4ANfuR5U3fylXGePiEljIs1
	 B4mwUBBvANjpGZ2PiIfJAMQrhHVr6KjsAN0wYrILRw70Ng0eN4GgP/LdvaNTzVERgb
	 c3Fgtbs4k1uZyjXLwHFG1ek5AHdr/f6Vlof00Jl3xVO2XLFHS4YIEGBxUJ1HiqqIQc
	 797DlQNMMTBp45i9AiXjBXhhjGFHEhcpKkL83+tvLnnjpaWylwM8HUW01MgAroXrIc
	 91Hu/G2BSQafZEw0VndL2EHCjgZk/jzyU/tFfWeSMUSvT98nwszudKpJRxmuLcj4jS
	 a4mb+yAAmPnHw==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Tue, 27 Oct 2026 16:46:32 +0100
Subject: [PATCH 6/9] mm/compaction: trust zone->contiguous only in the span
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
Message-Id: <20261027-pgalloc-ai-hotfixes-v1-6-9c7d1aca801e@kernel.org>
References: <20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org>
In-Reply-To: <20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0

From: Josef Bacik <josef@toxicpanda.com>

compact_zone() keeps the positions of its scanners in cc->migrate_pfn and
cc->free_pfn for the whole run. Memory offlining can shrink the zone in
the meantime. At the end of remove_pfn_range_from_zone(),
set_zone_contiguous() only looks at what is left of the zone. If that has
no hole, or if nothing is left, zone->contiguous is set again, and
pageblock_pfn_to_page() returns the memmap of any pfn unchecked, also of
one that the zone does not span any more.

The memmap of the range that left the zone is poisoned if CONFIG_DEBUG_VM
is set. Once the memory has been removed, the memmap and the pageblock
flags are freed. Ejecting DIMMs that were online in ZONE_MOVABLE while
other tasks write to /proc/sys/vm/compact_memory, no debug options set:

  BUG: unable to handle page fault for address: ffffea0004000008
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 3fee9067 P4D 3fee9067 PUD 3fee8067 PMD 0
  RIP: 0010:isolate_migratepages_block+0x32f/0x1280
  Call Trace:
   compact_zone+0x673/0x1140
   compact_node+0xb6/0x130
   sysctl_compaction_handler+0x77/0xd0

kcompactd and direct compaction walk into such ranges in the same way.

Only trust the flag for a pfn that the zone spans. Everything else goes
to __pageblock_pfn_to_page(), which finds the section offline or gone.
The span is written before the flag is set, so read them in the opposite
order.

Fixes: 7cf91a98e607 ("mm/compaction: speed up pageblock_pfn_to_page() when zone is contiguous")
Cc: <stable@vger.kernel.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/mm_init.c    | 4 ++--
 mm/page_alloc.h | 7 ++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index df1f888e59b8..262e4e5e97be 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2270,8 +2270,8 @@ void set_zone_contiguous(struct zone *zone)
 		cond_resched();
 	}
 
-	/* We confirm that there is no hole */
-	zone->contiguous = true;
+	/* We confirm that there is no hole, see pageblock_pfn_to_page() */
+	smp_store_release(&zone->contiguous, true);
 }
 
 /*
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index 2b1017a91928..e24d1203c514 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -216,7 +216,12 @@ extern struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
 static inline struct page *pageblock_pfn_to_page(unsigned long start_pfn,
 				unsigned long end_pfn, struct zone *zone)
 {
-	if (zone->contiguous)
+	/*
+	 * A scanner may still be at a pfn that has left the zone: the zone is
+	 * shrunk before set_zone_contiguous() says that it has no holes.
+	 */
+	if (smp_load_acquire(&zone->contiguous) &&
+	    zone_spans_pfn(zone, start_pfn))
 		return pfn_to_page(start_pfn);
 
 	return __pageblock_pfn_to_page(start_pfn, end_pfn, zone);

-- 
2.56.0

