Received: from mta1.migadu.com (out-77.mta1.migadu.com [95.215.58.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3507A2EBDE9
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 06:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792305796; cv=none; b=HyW+Aj373DW6dalIxwC3Bvb9fZrOidUVjTVtcqQP/1YFH+A8z35JYLCljewDfOAE28KaWl0vikl6XDQ1RqiXSf6FuOszEL+SeTL38arv4KIj1AdBYx/vYjJMqdTK2X/y61ksK6qhPcU8E3fXAUXm4Eq71NHfN4tt2WEWP5aoOi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792305796; c=relaxed/simple;
	bh=Uw0YIVaZtfH6o8cYYNicP3BPPfnY5BFJtNnGIlhTWb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RwoHGEKmlsqA+SijuQ7bSknaR3dUON68jWu9MaljiK8oH4NNy49qnAix3d2K/yVb3+BzbbxmHk2NII7QSFASDCUzUPrqWKXNCnc4AGN33OgFI4QRZ/4RDAyr9IeoYm4y7ok4NqqkYnd63Pta32YsfpWkZvQX1sJ36v2HsCpvzW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wzQtTrpD; arc=none smtp.client-ip=95.215.58.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wzQtTrpD"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Uw0YIVaZtfH6o8cYYNicP3BPPfnY5BFJtNnGIlhTWb4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792305791; v=1; x=1792910591;
 b=wzQtTrpDmaMrrqBaJyyLJamCuw7QHX2tgQT3VnVCIYmoDpc8KhryI/vrM+dr4djjC7+qDXLu
 4QPBmwW5RFy2jMn+4Z9tGAN9OlHmRPTzGY/1HmxfkQvHzSo+vCADmFthl0XkHPjEkWK8cprJG6W
 IfPw3eZuxm5jhw8R6ApeP3sU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0bd3a34f4381111f;
	Sun, 18 Oct 2026 06:43:10 +0000
X-Mizu-Trace-ID: 0bd3a34f4381111f
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	muchun.song@linux.dev,
	osalvador@suse.de,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	agl@us.ibm.com,
	mel@csn.ul.ie,
	riel@surriel.com,
	peterx@redhat.com,
	kas@kernel.org,
	rppt@kernel.org,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	mason@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 04/10] mm/hugetlb: unmap the page where the other VMA maps it
Date: Sun, 18 Oct 2026 14:43:04 +0800
Message-ID: <20261018064304.17357-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261015-urgent_fixes-v1-4-42796911043b@kernel.org>
References: <20261015-urgent_fixes-v1-4-42796911043b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Oct 15, 2026 at 06:07:10PM +0200, David Hildenbrand (Arm) wrote:
>From: Josef Bacik <josef@toxicpanda.com>
>
>If the owner of a MAP_PRIVATE hugetlb mapping fails to allocate a page
>for CoW, unmap_ref_private() unmaps the old page from all other private
>VMAs that have no reservation of their own.  It finds them by the offset
>in the file, but then zaps each of them at the address of the faulting
>VMA.  Nothing says that another VMA maps the offset at that address: a
>child can have moved its copy of the VMA with mremap(), and a second
>mapping of the file is wherever mmap() has put it.
>
>So __unmap_hugepage_range() walks the page tables of the other mm at an
>address outside of iter_vma, where i_mmap_rwsem of this file protects
>nothing and where anything can be mapped, and the page stays mapped where
>it really is.
>
>All of the following was seen on v7.3-rc6+ (g6c377d19d4a5) in KVM guests,
>as a user without any privilege.  It takes a pool of 2 MiB pages with no
>free page that is not reserved, so that the allocation fails: the user
>can take or reserve what is free itself.
>
> - The child moves its VMA away.  The page is never unmapped, the
>   mapcount stays 2, and the owner goes round retry_avoidcopy in
>   hugetlb_wp() until the child is gone or a page becomes free.  SIGKILL
>   to the owner does not end it.  5 of 5 runs.
>
> - The owner's mm has a second private mapping of the offset, made with
>   MAP_NORESERVE.  The owner zaps its own entry and reads zeroes where
>   its data was.  5 of 5 runs.
>
> - The child moves its VMA away and maps a 1 GiB hugetlb page at the old
>   address, so this one takes a pool with a 1 GiB page as well.
>   huge_pte_offset() for the 2 MiB size steps through the PUD
>   leaf, so the "PMD table" is the 1 GiB page itself and its "page table
>   lock" is folio->private of that page, which holds 2.  Kernels with
>   lock debugging oops in __unmap_hugepage_range(), 7 of 7 runs.  Others
>   spin on that word for ever with preemption disabled, 5 of 5 runs:
>
>     watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [u_det3:130]
>     RIP: 0010:queued_spin_lock_slowpath+0x8a/0x290
>     RAX: 0000000000000002 RBX: ffffea0001000028
>     Call Trace:
>      __unmap_hugepage_range+0x154/0x6d0
>      unmap_hugepage_range+0xc1/0x140
>      hugetlb_wp+0x55c/0x700
>      hugetlb_fault+0x5f3/0x8f0
>
>   RCU stalls follow, and killing all tasks of the user changes nothing.
>   Four such owners, whose children share a single 1 GiB page, took down
>   the whole guest with its four CPUs, 2 of 2 runs: one reported soft
>   lockups on all four, the other gave no sign of life any more.
>
>   i_mmap_rwsem stays write locked.  With a MAP_PRIVATE mapping of a
>   hugetlbfs file that belongs to another user, and that the attacker
>   can only read, the next mmap() of that file by its owner sleeps
>   uninterruptibly in __mmap_region(), 4 of 4 runs.
>
>Compute the address from the offset for each VMA.  The tree walk returns
>only VMAs that cover pgoff, and vm_start, vm_end and vm_pgoff of a hugetlb
>VMA are aligned to the huge page size, as pgoff is, so the whole range
>lies inside iter_vma.  Its page tables can not go away there, since the
>VMA is unlinked from the file under i_mmap_rwsem first.
>
>With the right address the page is unmapped from all VMAs but the
>owner's, so the retry in hugetlb_wp() finds a mapcount of 1 and reuses the
>page.
>
>A child that has moved its copy of the VMA now loses the page, and gets
>SIGBUS when it faults on a missing page of that VMA.  That is what the
>comment above the function has always promised to those who do not own
>the reservation, and what already happens to a child that has left the
>VMA in place.
>
>The address has been wrong from the start, and the second case needs
>only mmap() and fork().  mremap() of hugetlb VMAs, which the other cases
>use, came with commit 550a7d60bd5e ("mm, hugepages: add mremap() support
>for hugepage backed vma") in v5.16.
>
>Original fix generated by an LLM and sent in private by Josef.
>
>Fixes: 04f2cbe35699 ("hugetlb: guarantee that COW faults for a process that called mmap(MAP_PRIVATE) on hugetlbfs will succeed")
>Reported-by: Chris Mason <mason@kernel.org>
>Cc: stable@vger.kernel.org
>Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>[ david: switch to vma_filebacked_address, add VM_WARN_ON_ONCE, refine comments]
>Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Good catch1

Reviewed-by: Lance Yang <lance.yang@linux.dev>
