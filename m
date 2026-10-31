Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440287;
	b=L5erVeJfmSJ8qVijgPtpSmtGJxWLCsH6l8IkV1o+K2LKXi6gWaYSetppHGwsx7i69fF2
	 GQ3wqTp713C64uojytlSHTRquWV95tsfKm1PyZHZCL5RrcFiLXEWPq9PVYYaU2YK09Lvi
	 siluUtVMKT0ruEEIIWL0D06MMz1yKGubPoCdFkOD8NqFki5IlqZguYday6tjWHxB2bLZX
	 K746avzvbSTg4gZ4AHlt3/cgKNLV7F2UfWsCGKOrZBTJpV1QnDmCKsd8iYx+2avd6SuJh
	 SBkG+F3DmduVpn4cpgJ7EvUd396DRsHJf3pttL/Fxcm92Siqv4jblMk02MvzXLQJmww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440287;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Bt7ehAYquGHqadXRoM20dpnXtFEOJTcVdVq62A0TzPE=;
	b=Gmd04GSReFOu+eEUJw+6VFltoBu1GI6ktQyMjguRsNB4tb8UtOBp16+Cx7Zz4E+NReWv
	 pmSdBhPPE9UPuRJF8uKhi6bjIuypUeUdUB3OElng5tRkC2BnT0DCYpTdsm7oLgDiThBk3
	 yAd3lT5mjVQpDA5bsnXKEaXTp/Y2utTEpu8x3VdShBuIdN/76SPWXpcAi8sOMLziYnPBh
	 6dyGDwWc9D0x+i3+89mC51qY42Dtymcsibs+HctF+JcYtGLSydzjyaCQfFKDy8R2aPMy9
	 OwiFkuYvIXx8JHDOAc6ZGFMzSd8QnV9s3UyWwdyP2ZOkSyIo8h+zLd9d2RshutR6UtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gARMRHKR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520DB606A31A;
	Sat, 31 Oct 2026 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gARMRHKR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3DA1F000C1;
	Sat, 31 Oct 2026 09:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793440286;
	bh=Bt7ehAYquGHqadXRoM20dpnXtFEOJTcVdVq62A0TzPE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gARMRHKRSZW+Rtn51q/B3p7bChiPz7SGx8rC55xE7b3IrYX8Hj8UEXyO/8oTRo7MA
	 tclLcy+C+oiRiDlftxUmjcKLtHhFhBeCCZPB59ygvtYYk4k4lnQh81+p9hz+VLyt/+
	 wTZMZmGtCUYvka44gGyB12TS5bsKX6mMQTMDmeUqN0Y1O7ljdslf+TFxMvgcQQh9gS
	 7u+2MOe4G3It29EuWxOwZ5ZDqYLwjFzMEd2gDHz5Jl62fvUEVdcYz4zD/FacfohV3z
	 sts78ZnyYnNydgh9uoToJ2bFLqDddPMs8ZZWlKoWwu5KTbRMp+F6aUVpT1gWwEF3pp
	 ZF4J8T/RlvAmw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:40:12 +0100
Subject: [PATCH v3 43/47] mm/huge_memory: split huge PUDs when adjusting
 VMA boundaries
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
Message-Id: <20261031-fixes_core-v3-43-d6437171ecc3@kernel.org>
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
 stable@vger.kernel.org, Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4044; i=david@kernel.org;
 h=from:subject:message-id; bh=ux76JCpmRxhgE3mwKD3Uu8GXf+p+Ys6S4PuFPm9MXlM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebs/S1Hat1n96YGfGsWoN9RPHS5TWzKv4P6HUg5X1L
 l9U8+UZHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExEIZjhf7V0KNe+grtTFm9o
 mRbyMLbjIeeboHlP0j8Y9QbyJGnEnWdkmPpcvVthq8WqtilXkzatnytud3yB97UE1pZbBe0TqkO
 PcAAA
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
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/huge_memory.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 196de7fe6b4ee..63607ff1efecc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3504,16 +3504,66 @@ void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
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
+	if (pud_leaf(*pud))
+		__split_huge_pud(vma, pud, address);
+	if (!split_pmd || !pud_present(*pud))
+		return;
+
+	pmd = pmd_offset(pud, address);
+	__split_huge_pmd(vma, pmd, address, false);
 }
 
 void vma_adjust_trans_huge(struct vm_area_struct *vma,
@@ -3522,14 +3572,14 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
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

