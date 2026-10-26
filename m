Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057469;
	b=w62rvw0lwZfrElfjyN8zJvaHHm/CaS5dzZDj9+tIjQcIkLxugnY8JWZTAR4KUtbWrEHk
	 R0Ov5FqEbxVH5RzBmk9CLl4a85JALor0HlArMxHqN6b78zx/nGmlOIS8IBxipH+xaYmwo
	 1Mc5SH9FoYrzkZoKAxPM7i/EStpvZ4RhV5ka5u4Pzzf5u1Uc+Osj5FiEIIOYrqJreD4Jj
	 8Rfw78+slVD8/dis/sg+UW5MpQ/x6i18asAkXycQgvaUqSsCr4NSBRhi6CvUVJw9y3pJn
	 bj2Mh9lGjTC+URHzrmKevAYBYfa06q/gAgEq99dhmtrP0BxYHdnD/b+Ud55pjL6aBGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057469;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qpny6E1BVObd7dsWihweCIM0hF7qSfx3wRUjDYjrVHc=;
	b=mhF3mIaLbrUNTbm0zFvDH18h6mg3+cK8Dd+oGmv85yUtOhoWTvqux/T3WHEfpJshgAJt
	 2v89dR2bB7P/3wD34g6OFAZS2wchELXUkus4QLIY8PBu/xvoo68E7aMF3N2qbPZ/M6t+I
	 bGTV64WjpN/AP58nVC2PT5FatMeyP3hGyeZwlsjJIVU+isXQ3WfqRml3hcQRhwv1VADp9
	 gVSihGzlImnzBSuDyJZpeMGOD8QwVy7adDzF4EAkzV12UlEhag+yzjEwQ6NNmbBnWV/5J
	 +irRzJsAHEg7kpdy9stEtL1xxU3ZXhDUKWAxbo27URVqmmJyHoDuvuzs1pY+rrXRbBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bLRVc5gR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02150606A339;
	Mon, 26 Oct 2026 23:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bLRVc5gR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EFE1F01828;
	Mon, 26 Oct 2026 23:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057468;
	bh=qpny6E1BVObd7dsWihweCIM0hF7qSfx3wRUjDYjrVHc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bLRVc5gR+7gHpNcNYDK106P/bzwRPJM3i42hhIFUMNc+gg/w3xZ/vrMnATKC8Q4bD
	 3EljQv1NvcALI2EKTkF2JeDml8GRiigQ7HVxWgAO4jp/SYKo4o69zhuI2VK83+al30
	 pY3LlCvpT2VWTKcVHrKKrnqnEoLVOO8GGg8j+OujCuqvB1gyzgV6RXDtX27xyL9bC9
	 nsCCpNBsysLNV2525AxrTSFsPKjIO3rBbI1EUqkEmbkAWGEPayKgY96GY3ZbzmsPLY
	 EHxlraYONS4v9x846qg+8rmXNG6lly1wiIIYYkpUk1COlm0Rokvkbc5M5Vv8Fo9Wof
	 5Ng2XDxmXi3YA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:18:02 +0100
Subject: [PATCH 42/46] mm/huge_memory: split huge PUDs when adjusting VMA
 boundaries
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
Message-Id: <20261027-fixes_core-v1-42-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
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
 stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3948; i=david@kernel.org;
 h=from:subject:message-id; bh=vNNMWHmNm9srS8jxwzTDXKi766cdoioLtWNbwtZUzeY=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35/Beey19ZkHk3itqxv3LT93mDE+fOI2VdEVCz8tt
 ur+edVZu6OUhUGMg0FWTJElKPi+wcuX62qr3fiYYeawMoEMYeDiFICb/JKRYc4un5UTEvctn3R+
 BYtNyJ+Fxmf8xOcdtQ6W6FcXL9K1E2Zk6DnGLJ51vObHvuYPM3gO9J70/yXtb5I60T3o8c26/mN
 3OAE=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

PFN mappings such as VFIO PCI BAR mappings can use PUD leaves while
allowing VMA splits at page granularity. However, vma_adjust_trans_huge()
only handles PMDs.

After faulting a writable PUD-sized VFIO BAR mapping, changing its first
page to read-only with mprotect() makes the PMD walk treat the PUD leaf
as a PMD table. Applying MADV_DONTFORK to the first PMD-sized chunk leaves
the PUD spanning two VMAs: the PMD-aligned boundary skips splitting.

Walk the page tables once at each adjusted boundary and split a huge
PUD or PMD leaf as needed. Handle PUD leaves even when the boundary is
PMD-aligned.

Fixes: f9e54c3a2f5b7 ("vfio/pci: implement huge_fault support")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/huge_memory.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 08e58cda7d37d..d090642ac8c2b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3503,16 +3503,66 @@ void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
 	__split_huge_pmd(vma, pmd, address, freeze);
 }
 
-static inline void split_huge_pmd_if_needed(struct vm_area_struct *vma, unsigned long address)
+static bool pud_split_required(const struct vm_area_struct *vma,
+		unsigned long address)
 {
+	if (!IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD))
+		return false;
+	if (IS_ALIGNED(address, HPAGE_PUD_SIZE))
+		return false;
 	/*
-	 * If the new address isn't hpage aligned and it could previously
-	 * contain an hugepage: check if we need to split an huge pmd.
+	 * Only selected VMAs support mapping PUDs for now. Lift the
+	 * restriction once this changes.
 	 */
-	if (!IS_ALIGNED(address, HPAGE_PMD_SIZE) &&
-	    range_in_vma(vma, ALIGN_DOWN(address, HPAGE_PMD_SIZE),
-			 ALIGN(address, HPAGE_PMD_SIZE)))
-		split_huge_pmd_address(vma, address, false);
+	if (!vma_is_dax(vma) && !vma_test_any(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT))
+		return false;
+	return range_in_vma(vma, ALIGN_DOWN(address, HPAGE_PUD_SIZE),
+			    ALIGN(address, HPAGE_PUD_SIZE));
+}
+
+static bool pmd_split_required(const struct vm_area_struct *vma,
+		unsigned long address)
+{
+	if (IS_ALIGNED(address, HPAGE_PMD_SIZE))
+		return false;
+
+	return range_in_vma(vma, ALIGN_DOWN(address, HPAGE_PMD_SIZE),
+			    ALIGN(address, HPAGE_PMD_SIZE));
+}
+
+static void split_huge_leaf(struct vm_area_struct *vma,
+		unsigned long address)
+{
+	const bool split_pud = pud_split_required(vma, address);
+	const bool split_pmd = pmd_split_required(vma, address);
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	/*
+	 * mmap, VMA and rmap write locks protect the walk; the split helpers
+	 * take the page table locks.
+	 */
+	if (!split_pud && !split_pmd)
+		return;
+
+	pgd = pgd_offset(vma->vm_mm, address);
+	if (!pgd_present(*pgd))
+		return;
+
+	p4d = p4d_offset(pgd, address);
+	if (!p4d_present(*p4d))
+		return;
+
+	pud = pud_offset(p4d, address);
+	if (split_pud && pud_leaf(*pud))
+		__split_huge_pud(vma, pud, address);
+	if (!split_pmd || !pud_present(*pud))
+		return;
+
+	pmd = pmd_offset(pud, address);
+	__split_huge_pmd(vma, pmd, address, false);
 }
 
 void vma_adjust_trans_huge(struct vm_area_struct *vma,
@@ -3521,14 +3571,14 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 			   struct vm_area_struct *next)
 {
 	/* Check if we need to split start first. */
-	split_huge_pmd_if_needed(vma, start);
+	split_huge_leaf(vma, start);
 
 	/* Check if we need to split end next. */
-	split_huge_pmd_if_needed(vma, end);
+	split_huge_leaf(vma, end);
 
 	/* If we're incrementing next->vm_start, we might need to split it. */
 	if (next)
-		split_huge_pmd_if_needed(next, end);
+		split_huge_leaf(next, end);
 }
 
 /*

-- 
2.43.0

