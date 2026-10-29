Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306232;
	b=MNAeS4rZEKO8dZLPi+TpG1QO2iD3rPAqdWbjz3Xj88QZXojEXlkSWx0O9EliZ4MN5sm9
	 nHQRjLTWIN0SyL3/CUU2NSoGfiqzzllZfGLnEBtScExI7t+FNPyXKLWIf2dISa9Vj2BUh
	 TNqLFqPFSKtfV5cXpKVDyKNo0ex2Y4wWhOgPfL8kv8/ckMrjc9cHoSe+grdDo/Sj8Zfp3
	 CUL/qAMFEO5IbMgga3CWy2i/yqcK0M+qp0Zf/B4/XcA7vgh6+mOT7+Xs/BXkP7ezIDOmq
	 LTlheJ93YdpId4gJQ32KyxGdYthMCwaXP4OKYgNjjWYyY/wOA+kyPkIf6bev5bHUmow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306232;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=tNxobpWlUXNjZHphvvtOgvNQKSqjJiSYupG+wXJMVoE=;
	b=DGPqAshNIfsQX1VfLR6HgllLAEggmpb7TVziihBvghn2ZwD/Q58kAGVzOMB/JpfrDbWz
	 BvvlNg0POBhuvScpYnbhWu5jrKSwQ3p0zKvI3EcSwI5ngEQKT8VeYfGFPNTN17b2YpCcC
	 HWCIy1tj+4C+CdYphdnoNkEcNxrunb/nPMFWiu/FIy/8651LFNMIclSeqe+ythQEHcADI
	 jaSAZAUxF19OzQLay115KZFDTCgjkRE+sImLejZzpVXvPvZDXunMo8BAzjeMPdfbpiA2V
	 LMcg4bbLW/q+NLtLgctXPIZ/zcPLgY6WKtAftm/QnUs6z8qg8YKcXNQnQ4kitAfvYyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dnPvAICq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1109E606A32A;
	Thu, 29 Oct 2026 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dnPvAICq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800E91F01816;
	Thu, 29 Oct 2026 20:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306231;
	bh=tNxobpWlUXNjZHphvvtOgvNQKSqjJiSYupG+wXJMVoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dnPvAICqs5R8ijwgTMhLfxbmgHzO9ja4TQwnVekFvzI4/Y7pZ5RiY6O6tVJsThGVV
	 0+fRYRkM1yM1n6cFK+iCf3ZqyzqyhwSxWilIYYeoHZzbo9N29g9v86q9A13gDR/zAg
	 8DtvbNaMzwDgGrBUQB5UExtEwWaK0Dn9sbaFts/LVGL/R1SW2YpAU0BrON2RUO4yYy
	 cu/4SgzAJ0FHs5/Ri+ZxG/yPhlMK/kh2s08tuIv4giMR88cv5B14Ge4CBnqQ8xk6oa
	 1CwTQSEOwzHx7AbzR0KZQSktdzwEh8USZEjLO2tgQvbt5Dkn/jHz3doUQYIsiZKPxC
	 3UQpIdOeycdlw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:10 +0100
Subject: [PATCH v2 15/47] mm/khugepaged: always recheck the pmd in
 try_collapse_pte_mapped_thp()
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
Message-Id: <20261029-fixes_core-v2-15-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
In-Reply-To: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1608; i=david@kernel.org;
 h=from:subject:message-id; bh=KkwG8uxQMmQsjX2diZyIiRGRbeEH7cv/itYGtmQ0sPg=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer23LVcs0DZ+Vey1b3SqpnrEvsuh3u9sunSOS0y9ke
 OvO3DSho5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIl0pTD8Zglw/6lYZenzR8hk
 r8l90wVv172VFuh9dvaBH8e5W5P3izP8DzWJnPD4TI3eYUNe26sd69i/56mUL3HNdaxgFvxTHXi
 AAQA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

try_collapse_pte_mapped_thp() drops the PTE lock after it has cleared the
page table, and takes the PMD lock and the PTE lock to remove it.

In between, MADV_DONTNEED with CONFIG_PT_RECLAIM can reclaim the
page table. The pmd_same() check is supposed to handle this, but it is
only done with CONFIG_SPLIT_PTE_PTLOCKS.

Fix it by performing the check unconditionally.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ david: adjust description ]
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/khugepaged.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4b71d010b2af..f53c50507c83 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2013,12 +2013,11 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 	/* step 4: remove empty page table */
 	if (!pml) {
 		pml = pmd_lock(mm, pmd);
-		if (ptl != pml) {
+		if (ptl != pml)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
-			if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
-				flush_tlb_mm(mm);
-				goto unlock;
-			}
+		if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
+			flush_tlb_mm(mm);
+			goto unlock;
 		}
 	}
 	pgt_pmd = pmdp_collapse_flush(vma, haddr, pmd);

-- 
2.43.0

