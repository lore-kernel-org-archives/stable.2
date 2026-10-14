Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF22E3DB641;
	Wed, 14 Oct 2026 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792002585; cv=none; b=AiJuqMBFgzN9mMV28FM1A6hHG4ywOF6Ty2WJrcEhzNsngSqjmSTvOk187pXxWyLkfx8d+vD1IepbDOhLTK0s/tZrgCdNYtYi+RfjX4jPZbu2Bk1iqdJyB9UC9i8zYHuus/AgVG1JnTLzDB7ocekNiatoL8vIWZUXdQZUS5DCw/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792002585; c=relaxed/simple;
	bh=IEpek5EVQJlUi70tJL7kLqJX+LTvl3pbxUeeMBzLQ7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BjNffRDAgP4cMTqL1or4E1drN5A/tTS1rSeVIi/1Zc8uyMLW84Or5zCKOk8k+KCKlIHfis+YR5tahYVSfkj0hiBE7RNeFi6ThIGWoFUEmASxdtHAQ3N7CQldkyc8asRnlgY4TkMfZvSQvO6buD5Xc02oNfOwvQrKmHZw1V1KMMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUh51J//; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUh51J//"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4BB1F000C4;
	Wed, 14 Oct 2026 18:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792002583;
	bh=OTQB0TUAXUD3vxID5BdQah95iIYmmihnkyQRPpRL68Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lUh51J//ZpG1LvBeZMWXi9C2zDPmftO2Z9kWvh+UGMBT0fEhZz8eLiUf6Fj4NXtSk
	 /zCbkpzo1Edcb+oUVOKw+ZcVasSMAADZ7N6FMj8MIMcK5j2YWXAPdTmgOuaZoOLH3q
	 CCkoio3TrMQuGevPK0CN6yUnk2fMdZw4myNBFpZdZf3H1Eq4eUL6em0pn8vH8Ktt/G
	 MAI9aU4JrPDAwXnJv4JLohBdnPzdUPcpNurDlVmXPCdUR+UJ2TuGRzYungwqomF5oU
	 JlFVawmL65Sb6ivYBQCWZ5F76JGcz7jbmZ0kQuPI+SLNkkA0aiCxkAsQh/dlRPfNUg
	 tlyGqGkPKN3xg==
Message-ID: <a5c6edb4-9e8d-47f1-a316-6627e518fa7a@kernel.org>
Date: Wed, 14 Oct 2026 20:29:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/userfaultfd: only allocate anon_vma in CoW mappings
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Peter Xu <peterx@redhat.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Lokesh Gidra <lokeshgidra@google.com>, "Liam R. Howlett"
 <liam@infradead.org>, Kyle Zeng <kylebot@openai.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261014-copy_hugetlb_page_range-v1-1-5b68e03fe7fe@kernel.org>
 <as99gyi-NUprRK6e@gremlin>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <as99gyi-NUprRK6e@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/26 16:51, Lorenzo Stoakes (ARM) wrote:
> On Wed, Oct 14, 2026 at 01:53:11PM +0200, David Hildenbrand (Arm) wrote:
>> As uffd_lock_vma() is part of the same lookup machinery and
>> also contains a misleading VM_SHARED check, change that one as well
>> directly for consistency.
> 
> OK, I think that one isn't _strictly necessary_, but while we're there,
> worth doing too, clearly.
> 
> We should also go through and convert the remaining !VM_SHARED checks ->
> vma_is_cow_mapping() too if possible, but that's a follow up, obviously!
> 
>>
>> A follow-up cleanup will stop taking the hugetlb_vma_lock_read(src_vma)
>> lock in copy_hugetlb_page_range() entirely. Further, the usage of
> 
> Hmm really? Is it possible to do that without the hugetlb lock?
> 

Yes, we don't have to sync against PMD sharing if PMD sharing is impossible.
This is what I have laying around:

commit ad6a5c65bd5fa31d93a2de2d2e5e473b26ad6a3d
Author: David Hildenbrand (Arm) <david@kernel.org>
Date:   Sat Oct 10 13:00:13 2026 +0200

    mm/hugetlb: stop syncing against PMD table sharing in copy_hugetlb_page_range()
    
    We must never end up in copy_hugetlb_page_range() when PMD sharing
    applies, yet we still have to perform the hugetlb_vma_lock_read() so
    hugetlb_walk() is happy.
    
    Let's introduce a new vma_supports_pmd_sharing() and use that instead
    in hugetlb_walk(). Also convert want_pmd_share(), which now looks a lot
    cleaner, and document why the uffd checks cannot go into
    __vma_shareable_lock().
    
    We can now relocate our safety checks in copy_hugetlb_page_range() to
    the beginning of the function.
    
    No functional change intended.
    
    Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 5029c72418631..b2da5d5816944 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1389,6 +1389,20 @@ static inline bool __vma_shareable_lock(struct vm_area_struct *vma)
 
 bool __vma_private_lock(struct vm_area_struct *vma);
 
+static inline bool vma_supports_pmd_sharing(struct vm_area_struct *vma)
+{
+#ifdef CONFIG_USERFAULTFD
+	/*
+	 * Keep the UFFD checks out of __vma_shareable_lock(): UFFD flags can
+	 * change at runtime while the hugetlb VMA lock is held. They must not
+	 * cause unlocking or freeing an existing lock to be skipped.
+	 */
+	if (uffd_disable_huge_pmd_share(vma))
+		return false;
+#endif
+	return __vma_shareable_lock(vma);
+}
+
 /*
  * Safe version of huge_pte_offset() to check the locks.  See comments
  * above huge_pte_offset().
@@ -1406,7 +1420,7 @@ hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
 	 *
 	 * NOTE: lockdep_is_held() is only defined with CONFIG_LOCKDEP.
 	 */
-	if (__vma_shareable_lock(vma))
+	if (vma_supports_pmd_sharing(vma))
 		WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
 			     !lockdep_is_held(
 				 &vma->vm_file->f_mapping->i_mmap_rwsem));
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 60f9b209c8db1..606e93e32eefb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4987,22 +4987,16 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		 * Shared mappings only need copying when we could have
 		 * information stored in page tables (e.g., userfaultfd PTE
 		 * bits or markers), which is incompatible with PMD sharing.
-		 * Still take the hugetlb VMA lock for now to satisfy
-		 * hugetlb_walk()'s locking requirements.
 		 */
-		hugetlb_vma_lock_read(src_vma);
+		if (WARN_ON_ONCE(vma_supports_pmd_sharing(src_vma) ||
+				 vma_supports_pmd_sharing(dst_vma)))
+			return -EINVAL;
 	}
 
 	last_addr_mask = hugetlb_mask_last_page(h);
 	for (addr = src_vma->vm_start; addr < src_vma->vm_end; addr += sz) {
 		spinlock_t *src_ptl, *dst_ptl;
 
-		if (WARN_ON_ONCE(want_pmd_share(src_vma, addr) ||
-				 want_pmd_share(dst_vma, addr))) {
-			ret = -EINVAL;
-			break;
-		}
-
 		src_pte = hugetlb_walk(src_vma, addr, sz);
 		if (!src_pte) {
 			addr |= last_addr_mask;
@@ -5147,8 +5141,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	if (cow) {
 		raw_write_seqcount_end(&src->write_protect_seq);
 		mmu_notifier_invalidate_range_end(&range);
-	} else {
-		hugetlb_vma_unlock_read(src_vma);
 	}
 
 	return ret;
@@ -7005,17 +6997,9 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
 	unsigned long start = addr & PUD_MASK;
 	unsigned long end = start + PUD_SIZE;
 
-#ifdef CONFIG_USERFAULTFD
-	if (uffd_disable_huge_pmd_share(vma))
-		return false;
-#endif
-	/*
-	 * check on proper vm_flags and page table alignment
-	 */
-	if (!(vma->vm_flags & VM_MAYSHARE))
-		return false;
-	if (!vma->vm_private_data)	/* vma lock required for sharing */
+	if (!vma_supports_pmd_sharing(vma))
 		return false;
+
 	if (!range_in_vma(vma, start, end))
 		return false;
 	return true;


Will send that out for the next cycle.

> It'd be good in general if we could get rid of that lock as a whole :) but maybe
> dreaming.

Yeah :)

Thanks!

-- 
Cheers,

David
