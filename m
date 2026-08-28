Received: from mta1.migadu.com (out-11.mta1.migadu.com [95.215.58.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82D837D10A
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787910433; cv=none; b=TgJavEel4ZzGWff5w/y5grD6oBqRlqWdwUG/ZU16U/hEIUAH/L6ove4j68cB4WT239EDWRvf/Vh3lP43IHRe4A9T9siDo6hxFo6UQR1nTqU5+E6SBGZnAZkcv1KWiQYJfRxU1XuDiUYIhBpVRakjt+oQQuGUsp6QHlz4cyg1kV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787910433; c=relaxed/simple;
	bh=xyDcspAYGvgEUA23FnFj1KgLyE0byA+vZxYmYfg/wOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCiP9R2Dgbev68EpB/x9YG+pAFFXxl7C1qm1fxYkklU95G1TqjwQD3p+61wMoc5dymkicP8b+xPL5tfVdjOcG6d4IB4dQ4yY3jiT5uFaBdjrarF/20Mxqmzio4LKrjBJWc1dqawvFiCiqTVehmXh9rWAEN5RvNFdj5cBhBMYpAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BUAGsXYB; arc=none smtp.client-ip=95.215.58.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BUAGsXYB"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xyDcspAYGvgEUA23FnFj1KgLyE0byA+vZxYmYfg/wOw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787910428; v=1; x=1788515228;
 b=BUAGsXYBx+Rokivd7rlvfoNWfnV64jtTMEi7zJIHkW4AXYkB9XeqMwdSoaKgc4io9Y2KlrZW
 BXjvNHue82Lh5hcvVAXnNrdb4PtSpvURr95RH31RAVcdzIXQgcMPcAVT6k9c96dU0xecJY+quK6
 fSmRTc2YsbwmbErcVIouTIDE=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e425fa70d8e74725;
	Fri, 28 Aug 2026 09:47:08 +0000
X-Mizu-Trace-ID: e425fa70d8e74725
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: jthoughton@google.com
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	shy828301@gmail.com,
	zokeefe@google.com,
	hughd@google.com,
	kas@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: Don't collapse uffd-minor-registered VMAs
Date: Fri, 28 Aug 2026 17:47:03 +0800
Message-Id: <20260828094703.11081-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260828005004.2870750-1-jthoughton@google.com>
References: <20260828005004.2870750-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Fri, Aug 28, 2026 at 12:50:04AM +0000, James Houghton wrote:
>Userfaultfd minor faults provides userspace with the ability to manually
>install PTEs with UFFDIO_CONTINUE. Right now, khugepaged collapse can
>map holes in the VMA when a naturally-aligned THP is present without
>explicit action from userspace.
>
>This is a problem, as it bypasses userfaultfd minor faults that
>userspace is expecting to handle.

One basic question first. Should MADV_COLLAPSE refuse to collapse a
UFFD-minor-registered VMA, regardless of whether all PTEs are present?

I'd leave that to the maintainers :D

Anyway, assuming the answer is yes, I wonder whether the new check is
sufficient. See below.

>
>If userspace implements post-copy live migration using userfaultfd minor
>faults, this situation is currently possible:
>1. The VMA for guest memory is userfaultfd-minor-registered and nothing
>   is mapped in the page tables.
>2. A stale copy of a page is present in a naturally-aligned THP (from
>   pre-copy live migration).
>3. khugepaged collapses the mapping of the THP, installs a PMD.
>4. The VM now has access to the stale contents => VM is broken.
>5. After installing the correct contents, userspace attempts to map the
>   page with UFFDIO_CONTINUE; it gets EEXIST, indicating that something
>   unexpectedly mapped the page.
>
>The naturally-aligned THP case is the only case where this is a problem.
>khugepaged otherwise requires all PTEs to be present for
>userfaultfd-registered VMAs (i.e., max none PTEs is 0), which is
>correct. This check is essentially bypassed for naturally-aligned THPs.
>
>To deal with this issue, completely disallow collapsing in
>userfaultfd-minor-registered VMAs. This is slightly pessimistic; it
>would be nice to allow MADV_COLLAPSE to work if all PTEs are in fact
>present, but that seems more complex than it is worth.
>
>Fixes: 58ac9a8993a1 ("mm/khugepaged: attempt to map file/shmem-backed pte-mapped THPs by pmds")
>Cc: <stable@vger.kernel.org> # 6.1
>Signed-off-by: James Houghton <jthoughton@google.com>
>---
>This was caught with manual review while diagnosing a related issue
>that came up with in Google's live migration testing.
>
>I've uploaded a mostly-AI-generated reproducer here[1]. As long as
>/sys/kernel/mm/transparent_hugepage/shmem_enabled is not set to 'deny',
>the repro should work.
>
>[1] https://gist.github.com/48ca/d399bf534158e80241fb4937ef1ff664
>---
> mm/khugepaged.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index b237f6e7662a..66f956d3dd67 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c
>@@ -2804,6 +2804,15 @@ static enum scan_result collapse_single_pmd(unsigned long addr,
> 		goto end;
> 	}
> 
>+	/*
>+	 * Userfaultfd-minor-registered VMAs should not be collapsed, as
>+	 * userspace is expecting to explicitly install PTEs.
>+	 */
>+	if (userfaultfd_minor(vma)) {
>+		result = SCAN_PTE_UFFD;
>+		goto end;
>+	}

Assume UFFDIO_REGISTER_MODE_MINOR completes after collapse_single_pmd()
drops the mmap read lock and before it reacquires it.

Doesn't this still leave a registration race, no?


int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
		     unsigned long end, bool *lock_dropped)
{
...
	cc->is_khugepaged = false;
...
		result = collapse_single_pmd(addr, vma, &mmap_unlocked, cc);
...
}

static enum scan_result collapse_single_pmd(unsigned long addr,
		struct vm_area_struct *vma, bool *lock_dropped,
		struct collapse_control *cc)
{
...
	if (userfaultfd_minor(vma)) {
		result = SCAN_PTE_UFFD;
		goto end;
	}
...
	mmap_read_unlock(mm);
	*lock_dropped = true;
...
	if (result == SCAN_PTE_MAPPED_HUGEPAGE) {
		mmap_read_lock(mm);
		if (collapse_test_exit_or_disable(mm))
			result = SCAN_ANY_PROCESS;
		else
			result = try_collapse_pte_mapped_thp(mm, addr,
							     !cc->is_khugepaged);
...
		mmap_read_unlock(mm);
	}
...
}

static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
		bool install_pmd)
{
...
	struct vm_area_struct *vma = vma_lookup(mm, haddr);
...
	if (!vma || !vma->vm_file ||
	    !range_in_vma(vma, haddr, haddr + HPAGE_PMD_SIZE))
		return SCAN_VMA_CHECK;
...
	if (userfaultfd_protected(vma))
		return SCAN_PTE_UFFD;
...
	result = find_pmd_or_thp_or_none(mm, haddr, &pmd);
	switch (result) {
	case SCAN_SUCCEED:
		break;
	case SCAN_NO_PTE_TABLE:
...
		goto maybe_install_pmd;
	default:
		goto drop_folio;
	}
...
maybe_install_pmd:
	/* step 5: install pmd entry */
	result = install_pmd
			? set_huge_pmd(vma, haddr, pmd, folio, &folio->page)
			: SCAN_SUCCEED;
...
}


static inline bool userfaultfd_minor(struct vm_area_struct *vma)
{
	return vma_test_any_mask(vma, VMA_UFFD_MINOR);
}

static inline bool userfaultfd_protected(struct vm_area_struct *vma)
{
	return userfaultfd_wp(vma) || userfaultfd_rwp(vma);
}

Emm ... userfaultfd_protected() only covers WP and RWP. MADV_COLLAPSE
passes install_pmd=true, so the SCAN_NO_PTE_TABLE case can still reach
set_huge_pmd() after UFFDIO_REGISTER_MODE_MINOR has completed ...

Maybe:

---8<---
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 33c41bc32af8..0eada7265d59 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1893,6 +1893,8 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 	 */
 	if (userfaultfd_protected(vma))
 		return SCAN_PTE_UFFD;
+	if (userfaultfd_minor(vma))
+		return SCAN_PTE_UFFD;

 	folio = filemap_lock_folio(vma->vm_file->f_mapping,
 			       linear_page_index(vma, haddr));
--

With that, LGTM.

Tested-by: Lance Yang <lance.yang@linux.dev>

Cheers, Lance
