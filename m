Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9619D53D9E3;
	Wed, 14 Oct 2026 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988988; cv=none; b=NazAXNrIU+4HHgSeC7Z1+RQ2qrgr//rZFpW3yW+3lheuw4c73Lun9ZgP9VmuFs/Rl39vDlC4ykVFAC9aED7DQD4WDj5MHbfInjza8ytjc4gzFZ5iFVlfMwKRt4AENp7sFPV5KftrW0tRflE+FtuHnWGFQHnA8VHauN/JY7I1j7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988988; c=relaxed/simple;
	bh=slTLN+HTnyPRDcPUmB57Ei1RxAqdQ9VfazOYgqTzQcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UgjhyGwQVr706WWe8lamc3oNOW1mO5o4sttyEo3+T3BiSzAc3Gk41NTDRrIxRN7IqijfeWLP9qTjj26OFML+7bXXggx2/NlL3Dijb+4TBDtxP2MF5y2V8wjLw9lhDLh5rBop88Eslej2mx9loaNRqs+pt1UAC+l6SBTBRUW/Ghg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=hKxNDQ+M; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hKxNDQ+M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
	:From; bh=hcluCPw1guoo6eTwrCk1DCm8wcF/REa2+vS/gGt+sB4=; b=hKxNDQ+Mxr8X0fXgQst
	/YjlCa98braEHiObqAQKG+I7vG6ASme9WEz7OHdIuQoBQ7mS/yKw92c7UfFjYRlkM/SX9Elk64WQl
	0/ybId+BHOwJm25kPFfLmOrrxG/DAnuIgXvag/SiF22z4RCcS2pTdRWnYq3fKXh5qr2aAf8E1RRKh
	B3xoVHiWYuUjjdZsAy0kefl7DJ2lLt//dRyehTGyoUNkkCb4WrnreGcmv0xP+X+sbEbsyOSrm92UC
	i4P4L6LPwv0RU40qqChiewDx25NGPpTnyEQGqizEOU6mKIY2CsMbmvnbWr/R1VTz7P7o7d7DXsQ1a
	meV6BVNBgwjMF2g==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xH08B-005A8J-1T;
	Wed, 14 Oct 2026 16:42:31 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Wed, 14 Oct 2026 16:42:22 +0200
Subject: [PATCH v2 2/2] mm/huge_memory: deposit a page table for a special
 PMD copied by fork
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v2-2-e1548488fa68@virtuozzo.com>
References: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v2-0-e1548488fa68@virtuozzo.com>
In-Reply-To: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v2-0-e1548488fa68@virtuozzo.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2320;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=slTLN+HTnyPRDcPUmB57Ei1RxAqdQ9VfazOYgqTzQcY=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBqz5TVF9flfaIoTBYEiUAWlbx9oilAi3NU4+UWI
 atXUxHOcduJAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCas+U1QAKCRBRlgpH+WFc
 KjwfD/9U0aEkzB3l6KdM/Gq9P4U7CV+cgd/WlsK1UMK9FIbgJK5laBYK4Ck5WwwgRBu9UZ3HtKf
 dD7edkPu8wofgeRbl1WdoRIqbuXUG0I25ZocjDd/bU92I4JWUTAgDBVT3MfWlF8qzL9k1dB2v/x
 2jUSNletnpdxeWXf3f2Pfs3ir7L0eWLWKyzIb6FjMSLYyuWUkyGc3UoxTgezkHBDEfrsmB3MDHP
 Mzml9YdTYFrhlm5uLMDQIRz7tw1/tyXwaKXB5Hspr53+rZX2exiKHT7YSXiIQplnc4hSGYGt7bD
 5OdsSBg/x8Em5EoTBZyXjEBZ2E9e6FQfIeFs/8TFGdsZs9bABelVioMTVAw8k6qtI3Pvs8hkF+u
 +lgubCv6nAg80h7jbyf73ScVaQ/q8A7eoDKvlwq0AWIjpCr+qUExs7+xoYiWDiEn6xwKnBu8MVh
 fKyARguMKFEU5frQbxbblhR5ZEZiTj4lCfHourTERhuUCcLcZhsYpoHjJvlUJUi+Z5ca2jkmtQv
 f0qsdex4TvgJzEF2NEaHT4FGMDkywzg6MTIzEFOTVmB+/LVcA77yPvXH7IlaNSM+rI5k5Cs/Ed7
 /hkF7GUMKFLVY+hCE6Owk4FqZF5P1H5FQOWL1zOyU/h6clHjiV+CZAuv5Hva7D33XDc/5Vi5FkJ
 yiWyJbgY4OozYGA==
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
index fcea98f0d8865..d53db73f52676 100644
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
 		if (unlikely(!pmd_present(pmd) || !pmd_special(pmd))) {
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

