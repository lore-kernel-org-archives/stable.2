Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272634;
	b=gKmWcDR5EdCLP1FrkHb9+yef1iqpNBUA+rzxYGicXViU8+ainfNA8vZIL3NoyZJh4rmV
	 kvflC5mFo0ovgRKmFCreJKpBDLNEtSGMGqVLDwff28/3wfwLiPAi1gwT4vuDLB4/AFnab
	 QZXgbWb+L53WZVR0sqhiDB+JbzRzPhou9jRGsjdy5qfoV2R70/lGDIridEqXoT3a0xRrm
	 EDllKvpNbxKloCCee31PKjJrJtlBFTXSwridMjtW0y5YcgKIKipf4T4lkqA/BiaC3BZHP
	 5t//q4+zM7tRpoi2724tI7ei1sRmkAJEMotHcU11hqzMlDDyI2eyHt/CdkeOBD943UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272634;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=I5BJjrRNfmCqpBirfkmsAzJEzezOYizrZ35LZe1oMao=;
	b=C+AjDt+U1pXflvaNr+GFbL+waGS6tm65Mv5svj8HL0QQcFgdK7YYfTIMQaGXlAS70WX8
	 iSLElmKfhguHCZw4yYoWEIjEyaIlgv9q6LsrRJJsO9br4y7ZKqBeMw8zl8835neWbBSCz
	 QKa7sKZaOndwC+rV2yfBGXp2ssZdn2MPVOhV6mxtKDswoSgBv7C6o6ah42f/P5aLDjzq7
	 6YphvqEMpSSQcxN0tAEmcIJELR7vD/JfCXS1Ed6ioEmjcTb6YZ64SdHVReWjk/yJEkFUF
	 /HuJJzDruC/wiWgLFKmq+aRAIK1NktvoYZhr1BQJ73gQr4M/3QJ4imNXmUgEKo6++rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FNk6XLVs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63496606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FNk6XLVs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CDB1F008A2;
	Tue, 10 Nov 2026 01:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272634;
	bh=I5BJjrRNfmCqpBirfkmsAzJEzezOYizrZ35LZe1oMao=;
	h=From:To:Cc:Subject:Date;
	b=FNk6XLVsi2NaQ/WnjQhclKMpo9bo1yrLKIn38d+aw2+1uSdBMUgMNPw6z5HUHdjG0
	 +jg34K3h1hlGu/zs5MV7BAaNt//1+OEva+DZqwqZHHru48LACPoN936YnD4To2dcav
	 4HAS/sWd6OH3+zTnOE3KcD9Jy0NmJm7StPtuPoPN1FyNsDFrDK5qissvPNeKzjQvDr
	 tb/15QJUiQELdXWq0FO/D6TDQXJEi0N7+JCZbA36XsA8T1NprXkjitWnWlobKz0rQp
	 ao034Exry/fgsUuhAuSMg5ZA4kkKGUoGxCk88DcBmSFQI+sV3X+d+aMmWvRfPAUfeL
	 uRkYHNHOj6Pbw==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	akpm@linux-foundation.org,
	kylebot@openai.com,
	ljs@kernel.org,
	kas@kernel.org,
	baolin.wang@linux.alibaba.com,
	lance.yang@linux.dev,
	baohua@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	huang.ying.caritas@gmail.com,
	ryan.roberts@arm.com,
	hanchuanhua@oppo.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm: fix address wraparound when scanning large folio PTEs" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:03:51 -0500
Message-ID: <20261109200351-failed-6.18-f681d4580d5c@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f681d4580d5c3c749f623cda722a21aefd3147b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200351-failed-6.18-f681d4580d5c@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f681d4580d5c3c749f623cda722a21aefd3147b3 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 14 Oct 2026 20:34:28 +0200
Subject: [PATCH] mm: fix address wraparound when scanning large folio PTEs

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

Link: https://lore.kernel.org/20261014-folio_pte_scan_range-v2-1-00cf9bbaa364@kernel.org
Fixes: d2136d749d76 ("mm: support multi-size THP numa balancing")
Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Kyle Zeng <kylebot@openai.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Barry Song <baohua@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Ying Huang <huang.ying.caritas@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Chuanhua Han <hanchuanhua@oppo.com>
Cc: <stable@vger.kernel.org>
---
 mm/memory.c | 50 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0fb676dd2bd63..591592bc5a941 100644
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
-- 
2.53.0




