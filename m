Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793439849;
	b=RF0zLNU38Pmauq4ySVSojkeGTRtuXG5kRb+/iiHniq1EU3RFO/u6yJWm5boQH6BNHKW/
	 OTAJqRUzBv/yJPE2F989DySA3/V/fIw9rKSZ1CpJ7ipEK9iMi7aCNAYw4asSwvFI/KYVT
	 MoTIeqmu+A2Hf+L/aLuhO+TsvcKm9g1ZyunxaMHMhkVgtoRChyNtqOzLgOyWVHTtHvbzv
	 uTZzjwEn7lJBAfFvcfD7rqA687KTjDxWnctYlVVrQxV33LPshtaOY8f6cms3b1/E8EaW3
	 eAwb1JxjKUQybbk1ruCviIjIb79PTuRd0zpqtmwuDyWDfXxLfrEdtu+JqPygUtRvP7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439849;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dD8bNaZIuViD1rMmSH8A86u/ZWtm1YEV/epD2uKBbxE=;
	b=CbilSzJ1EipERfxr4Jmd8EVvfyBp8glCxDhfNCzGy7XC6WwoxP9R8QqxqKfpUae+UGqK
	 kUgPMCYcSiS2Aa1pOpRe4EcDq048o/aSlxLwR4ORhPcijEnrs3CqFmGEXqTwvp7wpfbf1
	 oGVf7xzXZ93wNLVRzaAUcI3zoPhZBPnODTOgbB3xP2uARNYCOxFVBuBF1Onfc5gUxgqnI
	 XdrdeyJY3BqpaB43UsQxK+h0sx0ojr5m0blWJLA6SDN6pTD2Vl+zZiSFuIbFQMP5JQEYw
	 PJKjZk4XN5ox+HG4WrFPU9Mxl+oyxiV6zQXFoTekro4wdWrCoATHXy645OC5Mla3Gog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SBYWyFJB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9F9606A31E;
	Sat, 31 Oct 2026 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SBYWyFJB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBC31F0093A;
	Sat, 31 Oct 2026 09:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793439849;
	bh=dD8bNaZIuViD1rMmSH8A86u/ZWtm1YEV/epD2uKBbxE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SBYWyFJBjrqmvQU0SLK/yXNYDG03UfEHLHBfhq+cgw3Mp75MofH2A8dc6wPjeEDVv
	 OgsCgMr8avGx4SVXvGmJOt4L0WLdm8QTqbVfd3IgM2F9nzP1NKoikT78JhjLalaX6y
	 MJa8/PAIKKtuVGZ6zyGm2qn8asC2gEIT2/RlnUQdveNPyGdqArZM+nJ3oFiB4QJBUD
	 FqHedcFM3LOFsdKvRRAW7qIWlFNsNLMIvP2f0hRzi9q6829DtyPX0OMj/JaKxv8REN
	 3jH/Ga4Nqjvn8Vw5Hr0RDErkQgv1hA578/T4CTyi0+/C11MmrghwGE7RVwyCq1+EpW
	 sR34AEi7oNxPg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:44 +0100
Subject: [PATCH v3 15/47] mm/khugepaged: always recheck the pmd in
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
Message-Id: <20261031-fixes_core-v3-15-d6437171ecc3@kernel.org>
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
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1665; i=david@kernel.org;
 h=from:subject:message-id; bh=CS7nU47snOvzHXKT1Jq5YnXJ98oWY8rgSlPg1efCrZ0=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebk9PenzlJu+Me5oLPjgcPt+x3vBE0sRXv9/FJ7pPE
 V46WSm6vaOUhUGMg0FWTJElKPi+wcuX62qr3fiYYeawMoEMYeDiFICJnF7PyNBhvkr/s0eeQtOS
 xA+ZX8KZxEMW5rmvFv7Ty3PvlKhu4G9Ghhu37Loa9P4Ieh2Osa9PXXbdul0vIGFp3yn3w0uKr5Z
 OYAYA
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
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/khugepaged.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 3a6f4b7b28453..81496887d827e 100644
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

