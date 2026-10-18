Received: from mta1.migadu.com (out-14.mta1.migadu.com [95.215.58.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1123D265CB2
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 06:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792306438; cv=none; b=WXOY7WGseAqGPUGFARbmGgrKd7wcWWudawLFRp3niAqHgmI8fBJOd48RN5/G/McCzXMTDVZeDKdZ9OKqvxQFNkgiftY7t9EYQMQRY/3pxPALKz8XArsLpEgt0n9/qzvUpdzhGr2YP+P/XsCTAn5jbka2fQ82mUoSnTxeOC9/3q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792306438; c=relaxed/simple;
	bh=vwLPtYmKSLRm3Ywxe7ILm7ay94IJmx9l0s4awNjJZjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRG5dKmob2ggUsKE4HQGcViz0L0mg52RiN52lz8/1fWjOOhoIm+xA/Y5ocQciZNs0QxgSIXtKsWFGBoS8OIoqYR5m1bpy+9c9w2PXfSZ6PSuxpLH005x66tCjmtG+HfrI9bXahijoxTT2t1nIajHeSEehlGnm4hudH71eBsFOcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UvbPSOhA; arc=none smtp.client-ip=95.215.58.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UvbPSOhA"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vwLPtYmKSLRm3Ywxe7ILm7ay94IJmx9l0s4awNjJZjQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792306434; v=1; x=1792911234;
 b=UvbPSOhA6qn9W+7+DeyKPEq++igEA9eI7khdKL6e9i5aBUjqoxazOxLK+ViIgSTCMe7JQUgM
 Ddl2J02Dp8U76o0MatwQEJhWba4fsU8J2T5DRwUHcEZEo7Iu7Tae1rSh6EeZRkKRSzUbulKjQc4
 mOxH++6phaOuv/lHXey8thjg=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 123d8aeeb9113a82;
	Sun, 18 Oct 2026 06:53:53 +0000
X-Mizu-Trace-ID: 123d8aeeb9113a82
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
Subject: Re: [PATCH 05/10] mm/hugetlb: don't clear the resv_map of a VMA whose lock is held
Date: Sun, 18 Oct 2026 14:53:48 +0800
Message-ID: <20261018065348.18713-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261015-urgent_fixes-v1-5-42796911043b@kernel.org>
References: <20261015-urgent_fixes-v1-5-42796911043b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Oct 15, 2026 at 06:07:11PM +0200, David Hildenbrand (Arm) wrote:
>From: Josef Bacik <josef@toxicpanda.com>
>
>Since commit bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private
>VMAs") the lock of a private hugetlb VMA that owns a reservation is the
>rw_sema of its resv_map.  The hugetlb_vma_*lock*() helpers find it through
>vma->vm_private_data, anew for every lock and every unlock.
>
>At the end of mremap() the old VMA has to let go of the resv_map, which
>now belongs to the new VMA: clear_vma_resv_huge_pages() stores NULL into
>vm_private_data.  mremap() holds mmap_lock for writing and has write
>locked the VMA, which keeps away everybody who comes through the mm.  It
>does not keep away those who find the VMA through the file.  For hole
>punch and truncation hugetlb_vmdelete_list() does
>
>	hugetlb_vma_trylock_write(vma);		locks resv_map->rw_sema
>	unmap_hugepage_range(vma, ...);
>						vm_private_data = NULL
>	hugetlb_vma_unlock_write(vma);		no resv_map: does nothing
>
>and the rw_sema stays write locked for ever:
>
>  WARNING: lock held when returning to user space!
>  mremap_punch/116 is leaving the kernel with locks still held!
>  locks held by mremap_punch/116: 1, last CPU#1:
>   #0: (&resv_map->rw_sema){+.+.}-{4:4}, at:
>                                       hugetlb_vmdelete_list+0x46/0x160
>
>The next fault in the new VMA sleeps in hugetlb_vma_lock_read(),
>uninterruptibly, and it holds its entry of hugetlb_fault_mutex_table[].
>That table is global, so a fault of any other process on a page that
>hashes to the same entry sleeps uninterruptibly as well.
>
>All those who take the lock of a private VMA without taking the mmap/vma
>lock are affected: rmap walks. So hold i_mmap_rwsem around the clearing
>of the resv_map.
>
>No change of behaviour, other than that mremap() of a hugetlb VMA takes
>i_mmap_rwsem once more.
>
>Original fix generated by an LLM and sent in private by Josef.
>
>Fixes: bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private VMAs")
>Reported-by: Chris Mason <mason@kernel.org>
>Cc: stable@vger.kernel.org
>Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>[ david: avoid local variable, move and refine comment, description cleanups+simplifications ]
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nothing jumped out at me, so:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
