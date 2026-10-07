Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0F93546FC;
	Wed,  7 Oct 2026 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791339213; cv=none; b=Oj74AT5MACmu9w83DcZC4OH+Vlg4HcriO+yUPEd4V17B+e5z7ARFuI0BKu6I7l3ameQcXGEzXTmQsVg3oQxcV6W6Rfwj5i98uGul5Lfe3mCZ8v1TOGwCKavsD9dWt7wMyWSgMStz9eMxNk8OviopBeGgFG/vibRt4UrRPGchYNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791339213; c=relaxed/simple;
	bh=BXEx4IxE9IVAq6iOuwoxPEfuNMjSTFUXAF0CDYIhHVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rxe5ze5pZ6LGTdVn9vfm5f0tpHhN/zeHAPgd52Nslp8IiW3cjen2ar1TQvDm1lKgTWnSG5iTt6/KjerraKKkYCOCp+BFJ0IxSuEHFpedHAtaRHE02hasbPCb2aAB5t+i0WLtOHXJr4jkpaNjMLPcPTgWMV7Fc5RnsO+N3GlGQ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=URCbctp7; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="URCbctp7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=yNjhHTiICdPRSkHBCtEN75cF7naElFR0UE3xeF4iQaA=; b=URCbct
	p7mmfcqizQvr/cK17TflxjdjyOb0wOoGm4Xfez+dEwA+x0bIRRzcFpw6fRcmG/vagoyK5Z7Lmp6SQ
	RpF64+w9oc3mO88qQlNk5VbHmKEv5IV/V+gSbxSsSOxEilv5dgdZeF6IA23Q/XuECQziKDqZEUGWk
	w36mETdkhgqN8hwKcwO3lqnb5XVO7y6ekDOv3qEIC1363UZvKQdAJupOrZXZY8nkcIN5spVeuU+YG
	mRcVvmNfvpur/h/yQv9eeW4xH6u/LxDbPfOcqtC8W4QGlz1fV8bzaW/NFrcX3UNiBhXOb+1I3eikt
	Upq4P+elZI2nn/DBOAUUOD9IxMDQ==;
Received: from [2601:18c:8100:a0e0:2541:b86e:2586:d219] (helo=fangorn.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <riel@surriel.com>)
	id 1xEH9M-0000000B2cT-3wVc;
	Wed, 07 Oct 2026 02:12:56 +0000
From: Rik van Riel <riel@surriel.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	linux-mm@kvack.org,
	Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org
Subject: [RFC PATCH 1/5] mm/page_alloc: count guard pages as free again when their buddy merges
Date: Tue,  6 Oct 2026 22:12:46 -0400
Message-ID: <20261007021250.1665929-2-riel@surriel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007021250.1665929-1-riel@surriel.com>
References: <20261007021250.1665929-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With debug_guardpage_minorder set, expand() turns the unused halves of a
split into guard pages, which page_del_and_expand() leaves out of the free
counts. Freeing the allocated half credits only that half, and
__free_one_page() then merges the guard buddy with clear_page_guard(),
which no longer touches the counters.

The merged block goes on a free list with the guard pages never counted,
so NR_FREE_PAGES falls behind the free lists by every guard that merges.
Before commit e0932b6c1f94 ("mm: page_alloc: consolidate free page
accounting"), __set_page_guard() and __clear_page_guard() adjusted the
counts themselves; that commit dropped both adjustments but kept the
subtraction implicit in expand().

Count the guard pages under the merged block's migratetype when the
buddy is cleared. account_freepages() skips an isolated block as it does
for every other free page, and moving the block off the isolated list
counts it then.

Booting a 16GB VM with debug_pagealloc=on debug_guardpage_minorder=1,
check the difference in free pages reported between /proc/vmstat
and /proc/buddyinfo.

At three points (idle, after a read and file-creation load, after
a second load), check the difference between nr_free_pages and the
buddyinfo numbers in the normal zone, as a number of pages:

                idle   after load   after second load
    unpatched   -130        79205               99121
    patched      -16           45                   0

The small remaining difference seems to be due to the numbers
not being read at exactly the same time, and is also seen
without guard pages.

Fixes: e0932b6c1f94 ("mm: page_alloc: consolidate free page accounting")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 mm/page_alloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 12fac9084c483..4658af97be010 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -988,10 +988,12 @@ static inline void __free_one_page(struct page *page,
 		 * Our buddy is free or it is CONFIG_DEBUG_PAGEALLOC guard page,
 		 * merge with it and move up one order.
 		 */
-		if (page_is_guard(buddy))
+		if (page_is_guard(buddy)) {
 			clear_page_guard(zone, buddy, order);
-		else
+			account_freepages(zone, 1 << order, migratetype);
+		} else {
 			__del_page_from_free_list(buddy, zone, order, buddy_mt);
+		}
 
 		if (unlikely(buddy_mt != migratetype)) {
 			/*
-- 
2.53.0-Meta

