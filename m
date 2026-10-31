Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793439630;
	b=Ix6UMk1R9LBl+7vXS1McPJMhMULZbcO0MBtXp3PVGmExmms0eb1YOMDmDuNmkHKjeyg0
	 kkC/SaxqZww4DjyXmDpTdOqHJQzi6Z07vTl4oiOfBv1M6t0gJVaqf9lBGfq9Psn/VA3Fn
	 EfDSLo0dlLpe/tzs+U28cowMSpHvQxbgebZYs68PN/PDfql2HTwEIGao/puov+t5C60zR
	 Q5j5cs5vRYGuQn/2aIkx2/OlFyORnYt53meApmdJ81dUzSTwBCHftWur6wdaER7fbghHK
	 O5waIcAbDE9TsYdbz8/8mTDcaj67AmEJuXUlchXXmFxyYVO07DCyCiYHCFsvAIKDfLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439630;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=vhzYAmOdAkqyGhBWNfdsKGQhygIIdv6/ZXuoCf/3yVw=;
	b=BAa4l+bfjmvHtG5nNz/FfxK+kA3WizeE6Iypq98rQ052TQ6tHqyj4LA8DyviwTFnuoWL
	 ZqJmOv1wVSwWjlR29Tx4zZzTyvqRroFKpbo8MGQT/ULjB3x0qy6B/+uChVafVSec4KLe9
	 OS26hBqnYft1KhqTWFdLjIAt9LRI4x1hR6rxrYpkzgqgZrM9zTIwDXUHo/hRnSK7LD9x7
	 0DfvgymSEXHUL1uSAf5jLwiAn9cBidiFUZ2eGXZVRYct3BGZvOj7xwB+vLT0SE9j5EmEd
	 6Vxolq2ohIskYyrjBok+rHtxYffmfMhd6E+ZwXtb+iDX0qUmfpK3SEuOcLrN6fhtk0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLdA01ou;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB12606A325;
	Sat, 31 Oct 2026 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLdA01ou
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE891F00919;
	Sat, 31 Oct 2026 09:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793439629;
	bh=vhzYAmOdAkqyGhBWNfdsKGQhygIIdv6/ZXuoCf/3yVw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iLdA01oulWOO6dYvCP+CtRKKHWVIi81CZdc7tIY0Dv0DRrOCh+iPbwNtueXAYD92X
	 Qcgd0tHi3SkRiMvKjvpNjilGV1OUQyFkVExiWCHoRLnRNf3Pg5Quf82DyuCipFvJ5E
	 eveba1t1+pQ0Frfq4xnnrxG3rjX3rvSC7U+WnP1cDs35mX/LmePYgMcd5i0fRatOpU
	 K0EhSHEBTWngDz/8AHMg9CqlauhF73UCYeWW+kZQVnCJZdA6x8MxrgdzmYs95gNe+f
	 Trzk2SBQLZAoy7Sv9Nr/OlxoHxjH0BXgihgLnMIG+CuFpzv14vabuGlY9p6/yQUdK9
	 rtmHADN+zq7bg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:30 +0100
Subject: [PATCH v3 01/47] mm/mglru: don't use stack pointers when walking
 PUD and PMD tables
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
Message-Id: <20261031-fixes_core-v3-1-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
In-Reply-To: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, SJ Park <sj@kernel.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2804; i=david@kernel.org;
 h=from:subject:message-id; bh=zbtgr6vf31Mknvg8yOsqXmy9ZbpWPb8teGHpWqYOrTA=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebk99XM03S8lEQljolPcxvX3C3cw/nzuZuYUnfdt6y
 0Fde9XrjlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACbirs3I8FmT9YONSo2yefGp
 zZ6B64/OyORR9zl9mSHu1nPmfYwLTBgZfm6qjWJeGrhwzfpj/wy9HNQMl3z9rPpC+33etU8qqzy
 s+AA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

MGLRU passes stack copies of page-table entries in walk_pud_range() and
walk_pmd_range() when walking to the next level. These copies can become
stale when khugepaged or MADV_DONTNEED (CONFIG_PT_RECLAIM) removes a PTE
table concurrently.

This pattern dates back to commit bd74fdaea146 ("mm: multi-gen LRU:
support page table walks"). Likely, earlier locking masked the latent
bug. Later changes exposed it: commit 1d65b771bc08 ("mm/khugepaged:
retract_page_tables() without mmap or vma lock") allowed concurrent
retraction, and commit cf4a65539c13 ("memcg-v1: no need for memcg locking
for MGLRU") dropped the walker's outer RCU protection.

The fix is simple, so just fix the original commit so we don't have to
speculate. To fix it, pass the actual PMD/PUD pointers. This restores the
RCU-protected lookup and validation against the live PMD. Note that the PUD
handling is required as well to handle folded page tables correctly in all
cases.

Fix generated by an LLM and sent by Josef Bacik in private.

[ david: handle walk_pud_range() as well, clarify+simplify description,
         adjust Fixes: ]

Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Qi Zheng <qi.zheng@linux.dev>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Kairui Song <kasong@tencent.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9959ca158ce83..6a1af9b92349f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3911,7 +3911,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 
 		walk->mm_stats[MM_NONLEAF_FOUND]++;
 
-		if (!walk_pte_range(&val, addr, next, args))
+		if (!walk_pte_range(pmd + i, addr, next, args))
 			continue;
 
 		walk->mm_stats[MM_NONLEAF_ADDED]++;
@@ -3947,7 +3947,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long start, unsigned long end,
 		if (!pud_present(val) || WARN_ON_ONCE(pud_leaf(val)))
 			continue;
 
-		walk_pmd_range(&val, addr, next, args);
+		walk_pmd_range(pud + i, addr, next, args);
 
 		if (need_resched() || walk->batched >= MAX_LRU_BATCH) {
 			end = (addr | ~PUD_MASK) + 1;

-- 
2.43.0

