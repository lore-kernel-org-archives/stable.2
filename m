Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968599;
	b=sT16EWOQVfkER3pA55U9eDlkZUYDySlXQ6pQMCt1vTVhz2I05PLqc6Ml1JkC9I4kQAyb
	 c6POFRdt5fb2VKIBkiDdS7YutEyk+7+JXxvEMMttkdsQqZhLFk61flC+jsuBc1Mx1p6rU
	 zZdVXUIaUqJZlgIbgX8cQIRLI8aycBOaWX8rN+6vv1G7DrlY+jGoRgr2DY6nwb7ZFaDk1
	 0JOAbcl4B+8w+vFNOuTEMtjLR4QRoKopAO7gBmrI73w7D2ozd8jUCEr3DAlpTOyv3lE/9
	 RjR9OyOEiCOkty3RE93Vm0QQcQv5uP/yubkisInuXNpVZ/GjyK/k0SQhT22KK0EudXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968599;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=WPaaf/nAUIxU/MujCzQxnBmdoAj91DZqtwr0DLfU74g=;
	b=DrlDeE85AzhdzfRkxIWvbaDER8tdv8syGauSj5f5tpeR7N9siX8cSrDM1u+GEmDH+JN3
	 SaXbpSRUdEE/q2wv6cChZJ8SPgnXoDoqH8+QRdQcqy7ETp4aBk4TYtTZk77Mdm9z3l6vF
	 IzW1WTIAYQc+tlu2f7pPBmrNf1TVf5qPz+N08ddEGJzgkMaZkBtoFVa/S9RPMVdxzwIea
	 tzcBCOREhgjcrGDM2jMP7R/rH6Iwuci5UPWymJbo9HRZoC4R5TiQ14gO8mMKOGvaBPld+
	 tH3K1S0wOOmZClFnkin+4SGqRSBx7ygM4XZGEl5qHKaQnm+zheK1cKD9MTdtgzA/OMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oBlYtI71;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206DE606A333;
	Fri,  6 Nov 2026 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oBlYtI71
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA691F008A1;
	Fri,  6 Nov 2026 12:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793968598;
	bh=WPaaf/nAUIxU/MujCzQxnBmdoAj91DZqtwr0DLfU74g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oBlYtI71uLsKhVv7lyV38yeBfN5N672YIfMRZFQzXth03EH1SfECRBI77Maw2IXFN
	 gegEJLZn7Ty8f51PP2PrEP3G2x1lPCkrWVoN+qYicRwkgL8c+6mg+fh7TD9TsB+feO
	 oJ5F+vpo04+73w6/VmoJfcQQS+XHoQEEy3YBVKQhCaKO3K7smd12C+8VeeG/6CULZD
	 MmE8Ce+eZl7asicy/G8DKDEzw51+uNSIx1/l1PL9XFqckxK1r1ZRLucENVqb1qTjY7
	 2kftkySzx0oWIzYpC7obWNbLlMeV5T0unQ4lMm+VaZZ3WcO1VQhxoAspnrvctVbF7G
	 HHrlbfEDZW67A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 06 Nov 2026 13:36:12 +0100
Subject: [PATCH v2 1/2] mm: free unused page table allocated by
 do_set_pmd()
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
Message-Id: <20261106-khugepaged_set_pmd-v2-1-d2457b5e377a@kernel.org>
References: <20261106-khugepaged_set_pmd-v2-0-d2457b5e377a@kernel.org>
In-Reply-To: <20261106-khugepaged_set_pmd-v2-0-d2457b5e377a@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2341; i=david@kernel.org;
 h=from:subject:message-id; bh=OS/dNIms28mbW/vsOf9xV2Ck+BtJzYDFrVVoI/C2V7I=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLenjz3WX+qichp2en9C24Vffqzf5G3zNy2vJdzuAL7l
 X7P7+Lp6ihlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAiE3cxMhz1zy7UiVeftfl/
 5FdTx9jqCwv8WKoVWx69TvbstoxmiWVk+NSk7nKaa4WczmmfDPt+Hi8GYZ3X76asT8u4ENroFFv
 PDQA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

do_set_pmd() can allocate vmf->prealloc_pte on architectures that need a
deposited page table, such as PowerPC with the hash MMU. If the PMD is
no longer empty when it takes the PMD lock, it returns VM_FAULT_FALLBACK
without consuming that table.

Since collapse_pte_mapped_thp() uses mmap_read_lock(), a concurrent
userfaultfd operation can install a PTE table before taking the folio
lock. If that races with set_huge_pmd(), the unused preallocated table
is lost when its local vm_fault goes out of scope.

Track whether do_set_pmd() allocated the table and free it after dropping
the PMD lock if it was not consumed. Preserve any preallocated table
supplied by the caller for PTE fallback. Successful PMD installation
consumes the table and clears the pointer.

Returning without a preallocated table matches the existing behavior on
architectures that do not need a deposited table. All callers
already handle that case.

Fixes: 1043173eb5eb ("mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()")
Cc: stable@vger.kernel.org
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index becf53a2a0944..421064aef3cf0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5687,6 +5687,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 	struct vm_area_struct *vma = vmf->vma;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
+	bool pgtable_allocated = false;
 	pmd_t entry;
 	vm_fault_t ret = VM_FAULT_FALLBACK;
 
@@ -5725,6 +5726,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 		vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
 		if (!vmf->prealloc_pte)
 			return VM_FAULT_OOM;
+		pgtable_allocated = true;
 	}
 
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
@@ -5755,6 +5757,10 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 	count_vm_event(THP_FILE_MAPPED);
 out:
 	spin_unlock(vmf->ptl);
+	if (pgtable_allocated && vmf->prealloc_pte) {
+		pte_free(vma->vm_mm, vmf->prealloc_pte);
+		vmf->prealloc_pte = NULL;
+	}
 	return ret;
 }
 #else

-- 
2.43.0

