Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA1052D2C9;
	Wed, 14 Oct 2026 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792002886; cv=none; b=GgCL4GDUho886Rw7DeYBSMaedLwL0m9wgsLDOYV6LsU/CJLaBCrQ7ry/xrxMgM19VYLjtT2OnzrOVISQMwjW4XQ3zIVhSjeUto1/VXx1O02LW3u+h20KVHnIhIAhpUTDPoxjol+BFTGmjVs6qj0VDR6h4O5qwYJrtrtiD2TRK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792002886; c=relaxed/simple;
	bh=BkD6Y/HalsjYwf57ZhS64XjHmYuqd0mBJqkuOfKzqG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=G9sz0bm8/MSk8xsEA3kuySqwOR0E58ARW2/x/TWbbXokSxmE7RgYI+jiKhtk4twJRqKbg2CZlX61rH7hy3ejs2so15qJri4ThFb5sp3hEg0X8MCF7CbsS3G+r99F+dRBopC/bjAVheXfLW7wnlLizVJOF5j4oN1l4jjamqZbXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHdY2vAd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHdY2vAd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E49B1F000C4;
	Wed, 14 Oct 2026 18:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792002885;
	bh=3LdUyDK01DQtoFjrGZ/bknkjNppQ8Sk8UdpqBq/9h0s=;
	h=From:Date:Subject:To:Cc;
	b=fHdY2vAdxwRHcOMrmHw0tMpWucDoeb7pkiGpEg1hggSyl9bvxP0hE/UermQFqYHxS
	 ZuoztCR38h9schyLvMfzp8hCojRB6VhIHKC6Z+A8NaA7y77qlR5i4FmJo/7qBgkYfq
	 AzQfQL+pcOBBh9bsca9YG0AoARe15urQ42RsBpElKOnAXWvZmBro9FjkoUDgWQBCqP
	 zVdbwqXFX2SORT1kULtEJkE/dmBJcPiA1Yn2LIhuSTB94aT6smbYRLjlfLl1BLZKJ0
	 bLPUHetJRvsS+E5mn5CMOwHkKVb/M8VyDaBJ40kiWSrqBF7d8FcTlZ8WMMOiMEy9P+
	 U73NJQLFGX1Tg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 14 Oct 2026 20:34:28 +0200
Subject: [PATCH v2] mm: fix address wraparound when scanning large folio
 PTEs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-folio_pte_scan_range-v2-1-00cf9bbaa364@kernel.org>
X-B4-Tracking: v=1; b=H4sIADPLz2oC/4WNQQ6CMBBFr0JmbU0LkYgr70EIKdMBRklLpkg0h
 LsLeACXL3n//QUiCVOEW7KA0MyRg98gPSWAvfUdKXYbQ6rT3GiTqTYMHOpxojqi9bUcDuZoTYF
 4pcLBNh2FWn4f2bL6cXw1D8Jpb+1Gz3EK8jl+Z7N7fy5mo4zCi3aY6abNrbs/STwN5yAdVOu6f
 gHIdRFYywAAAA==
X-Change-ID: 20261013-folio_pte_scan_range-c6ca19cc8e9d
To: Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Ying Huang <huang.ying.caritas@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
 Ryan Roberts <ryan.roberts@arm.com>, Chuanhua Han <hanchuanhua@oppo.com>, 
 Mike Rapoport <rppt@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, 
 Kyle Zeng <kylebot@openai.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Lance Yang <lance.yang@linux.dev>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4955; i=david@kernel.org;
 h=from:subject:message-id; bh=BkD6Y/HalsjYwf57ZhS64XjHmYuqd0mBJqkuOfKzqG0=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLOn7bzuPw7lznL52h1+/dgZqaVHXNO9d05fPf0663L7
 b7aCHf+7ChlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAiXhMY/gfe7TERiHqrwPL4
 8YRd9bn8DTdtbY7b7P2jE7zP6FX4us2MDC9OnV915VGwncbp9Vvn3GEqbC3itvPrlXeewH/LNXp
 KMgsA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

numa_rebuild_large_mapping() and do_swap_page() can be tricked into
generating an address wraparound, crashing the kernel. All that's required
is to map a tail page of a large folio close enough to the start/end of
the address space to e.g., make

	unsigned long addr_start = addr - (nr << PAGE_SHIFT);

to wrap around.

Let's fix it by providing a better helper, folio_scan_range(), that
takes care of staying within VMA and page table boundaries while
handling possible wraparounds.

There are some nasty details, like not being able to use pmd_addr_end()
in this context. Add some helpful comments for these cases.

Reported-by: Kyle Zeng <kylebot@openai.com>
Fixes: d2136d749d76 ("mm: support multi-size THP numa balancing")
Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
Cc: stable@vger.kernel.org
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Changes in v2:
- s/folio_scan_pte_range/folio_pte_range/
- Add more comments + improve existing ones.
- Link to v1: https://patch.msgid.link/20261013-folio_pte_scan_range-v1-1-c50dc30bf6ad@kernel.org
---
 mm/memory.c | 50 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 1f5d5f7d39cd2..fa29d7a8d0c20 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4933,6 +4933,34 @@ static void check_swap_exclusive(struct folio *folio, swp_entry_t entry,
 	} while (--nr_pages);
 }
 
+/*
+ * Get the address range in which a folio might be mapped, assuming its pages
+ * are mapped consecutively and the folio page at the given idx is mapped at
+ * the given address.
+ */
+static void folio_pte_range(const struct folio *folio,
+		const struct vm_area_struct *vma, unsigned long addr,
+		unsigned long idx, unsigned long *start, unsigned long *end)
+{
+	/* Stay within the page table and VMA boundaries. */
+	const unsigned long pmd_start = addr & PMD_MASK;
+	const unsigned long pmd_end = pmd_start + PMD_SIZE;
+	const unsigned long lower = max(pmd_start, vma->vm_start);
+	/*
+	 * We cannot use pmd_addr_end(), as it does not clamp reliably. To
+	 * avoid wraparounds, compute using the inclusive end.
+	 */
+	const unsigned long upper = min(pmd_end - 1, vma->vm_end - 1) + 1;
+	const unsigned long offset = idx << PAGE_SHIFT;
+
+	/*
+	 * Avoid start/end addresses wrapping by not adding/subtracting more
+	 * than the lower/upper limits would allow.
+	 */
+	*start = addr - min(addr - lower, offset);
+	*end = addr + min(upper - addr, folio_size(folio) - offset);
+}
+
 /*
  * We enter with either the VMA lock or the mmap_lock held (see
  * FAULT_FLAG_VMA_LOCK), and pte mapped but not yet locked.
@@ -5121,16 +5149,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	address = vmf->address;
 	ptep = vmf->pte;
 	if (folio_test_large(folio) && folio_test_swapcache(folio)) {
-		int nr = folio_nr_pages(folio);
-		unsigned long idx = folio_page_idx(folio, page);
-		unsigned long folio_start = address - idx * PAGE_SIZE;
-		unsigned long folio_end = folio_start + nr * PAGE_SIZE;
+		const int nr = folio_nr_pages(folio);
+		const unsigned long idx = folio_page_idx(folio, page);
+		unsigned long folio_start, folio_end;
 		pte_t *folio_ptep;
 		pte_t folio_pte;
 
-		if (unlikely(folio_start < max(address & PMD_MASK, vma->vm_start)))
-			goto check_folio;
-		if (unlikely(folio_end > pmd_addr_end(address, vma->vm_end)))
+		folio_pte_range(folio, vma, address, idx, &folio_start,
+				&folio_end);
+		if (unlikely((folio_end - folio_start) >> PAGE_SHIFT != nr))
 			goto check_folio;
 
 		folio_ptep = vmf->pte - idx;
@@ -6280,16 +6307,11 @@ static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct vm_area_stru
 				       struct folio *folio, pte_t fault_pte,
 				       bool ignore_writable, bool pte_write_upgrade)
 {
-	int nr = pte_pfn(fault_pte) - folio_pfn(folio);
+	const unsigned long idx = pte_pfn(fault_pte) - folio_pfn(folio);
 	unsigned long start, end, addr = vmf->address;
-	unsigned long addr_start = addr - (nr << PAGE_SHIFT);
-	unsigned long pt_start = ALIGN_DOWN(addr, PMD_SIZE);
 	pte_t *start_ptep;
 
-	/* Stay within the VMA and within the page table. */
-	start = max3(addr_start, pt_start, vma->vm_start);
-	end = min3(addr_start + folio_size(folio), pt_start + PMD_SIZE,
-		   vma->vm_end);
+	folio_pte_range(folio, vma, addr, idx, &start, &end);
 	start_ptep = vmf->pte - ((addr - start) >> PAGE_SHIFT);
 
 	/* Restore all PTEs' mapping of the large folio */

---

base-commit: 634cbf5b794b734c78631b92e381cfc85f357bbe

change-id: 20261013-folio_pte_scan_range-c6ca19cc8e9d

--

Cheers,

David

