Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D414A4EE6;
	Wed, 14 Oct 2026 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992793; cv=none; b=I6YXjDJOu/SMMbkf1MGiQ+PyN89rryJ/bcG7A+FMsm2NV91FWJXToMJK6HxOVNRYN6i0meTDq1onyhfcr15BjWjHzXbKp/ojbuEulPaCA+XE2FRx57bQLyvgbw+Kk4jb1GEphUK9Vg3fhsGzqMLvdWJYf3oTCyEDjhKsfqhNzR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992793; c=relaxed/simple;
	bh=ccKR6pewzp3zZMmycW2Bk4rHSSS9C7rwMGxwqRO0ZTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X65U7sAbLkzQ/AaB7pakSXyVcjy920qIvLZjlnEqXKF3VuxjaMxcBQjbJDghpqYpzcRWGefInHeaFIlXOdjFniXS0i9ttXGB9w/pNKHjMG/1S0XwQ7l6OnGslhmat+VouGCvOB520SckQNOCdhH6RRA0V+1n1SE5WDKBHLAeItQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=pyMcdMZQ; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pyMcdMZQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
	:From; bh=7vC0C3sp4wt6zauR/zTBNv+UfY1Rq7XzZhYx35u+Pg0=; b=pyMcdMZQB5ZqvVLfY1c
	7rwJCGcTAyuR7AiTeZGd0MdA2aYDFZJzn58phDbodFcBKdGH7IN2YcOx3wdqcl5v26RPIOQRJk+9W
	wdmRJF/vyDaBrq3xJRM0EjzN0coRIHYANvzMBDssbnclJzBt4qh4LA9B8GdUKXYM6PFonfPMLYXdd
	wZZu00DxSxjZ9mCUYfoW3kg7GiCkivih1R3rIox90CkrPBOdH7kkAFvASow/eK1Jd0T76aGIHteb5
	XSnMa3S42jsDsfOC4EyCiu1su0r/rdLS4S/NgC22IbUqLTpbtr/ZPXCK5sTWpIdaEyU1lhmwn/6nK
	ETmdNvppmvsaPeQ==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xH17r-006OFq-1f;
	Wed, 14 Oct 2026 17:46:15 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Wed, 14 Oct 2026 17:46:10 +0200
Subject: [PATCH v3 2/2] mm/huge_memory: deposit a page table for a special
 PMD copied by fork
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-2-85eaec8417f6@virtuozzo.com>
References: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-0-85eaec8417f6@virtuozzo.com>
In-Reply-To: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-0-85eaec8417f6@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, 
 dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Konstantin Khorenko <khorenko@virtuozzo.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Sashiko <sashiko-bot@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2295;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=ccKR6pewzp3zZMmycW2Bk4rHSSS9C7rwMGxwqRO0ZTE=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBqz6PFClTyKPLrnnz2A76nCcPaPtA7BJ8STorQS
 2LGmEvfjtGJAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCas+jxQAKCRBRlgpH+WFc
 KiGVEACF48BxKLRtenct26B7UErEMP4cCXXKBBh2OQTdVQG/gTnTUQmsq/rRFofn4M3McyTNw82
 ySfEk1gWQrQAKYowENQdUkKwKyDbgkCZOtL5nnOp40ZO6LPu35KF7+CNCkxOzXX0ZK4KnCz1ZTl
 x8DcoUMCJPp2pneC9getMw4C6zGaSomDz7heiaT1Rjzl69SToQWP/YEjdBfkVqbepbWKDUkFdSf
 P3FiHQ+K9+uVwKO0rUM+RpUW4x6PoDxfAC9pYTYVGENU76vAHXbbQWjLLQ496MoINpTBeQ+icLy
 FodLaYFVmgD0y597BAwMwDAp/8OTUeMF46epEQ4Qg05XHsn1mWEm7qZEYY4u/vdLRdmwt6PiHRj
 TGZJnxg9ywOfkLjRQtnfTh7AQtXhed6tvMcaZ3dZqXIe9kWA3sy2puP1B/Gy8lmWRiXmYAVYY74
 9cmCRDVPu9RcTZZrkdjaDI6kLpuntZeN0JyPiFsJNTxVpkLjCj02cZLuQTGrFJMwQhF8DNCfL3H
 gxbA1Ha344ZOgRPMoKvyFErRvSqB59yIGmamAXa8eIVTo93ZTzYGEnj5fJs6FFsO/EdoTML9NuM
 hZSVV8SY3dYfeBR/monHq2Hq0CZszYYxdozeXI6Zr8RcwERZH/RGXyPJdHgD+df7ZHvxIcRlnD3
 9o96Qx7HyTFbI3g==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A

Where arch_needs_pgtable_deposit() is true, every huge PMD needs a
deposited page table. ppc64 in hash mode keeps the hash slot array of
the huge page in it, so vmf_insert_pfn_pmd() deposits one for each
special PMD it maps.

copy_huge_pmd() copies a special PMD into the child without a table.
The child then dereferences a NULL table:

- on the first hash fault on the PMD, in __hash_page_thp();
- on the zap at munmap() or exit, in hash__pmdp_huge_get_and_clear().

Allocate a table before taking the page table locks and deposit it
with the copy, as insert_pmd() does.

Fixes: d1503aa9ab805 ("powerpc/64s: Add support for huge pfnmaps")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com?part=1
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 mm/huge_memory.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bf788bb231691..2380e4e877f82 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1961,6 +1961,11 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	pmd = pmdp_get_lockless(src_pmd);
 	if (unlikely(pmd_present(pmd) && pmd_special(pmd) &&
 		     !is_huge_zero_pmd(pmd))) {
+		if (arch_needs_pgtable_deposit()) {
+			pgtable = pte_alloc_one(dst_mm);
+			if (unlikely(!pgtable))
+				goto out;
+		}
 		dst_ptl = pmd_lock(dst_mm, dst_pmd);
 		src_ptl = pmd_lockptr(src_mm, src_pmd);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
@@ -1974,6 +1979,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		if (unlikely(pmd_none(pmd))) {
 			spin_unlock(src_ptl);
 			spin_unlock(dst_ptl);
+			if (pgtable)
+				pte_free(dst_mm, pgtable);
 			return -EAGAIN;
 		}
 		/*
@@ -1983,6 +1990,10 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		 * wrongly write to the backend MMIO.
 		 */
 		VM_WARN_ON_ONCE(vma_is_cow_mapping(src_vma) && pmd_write(pmd));
+		if (pgtable) {
+			mm_inc_nr_ptes(dst_mm);
+			pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+		}
 		goto set_pmd;
 	}
 

-- 
2.43.0

