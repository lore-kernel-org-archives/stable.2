Received: from mta0.migadu.com (out-62.mta0.migadu.com [91.218.175.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8DD3B100A
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792304202; cv=none; b=S39qTYaN7fLoG7A8m7wtrt6VQWeFGJLc0mHif/fZlItJ4EjoWpQ9yiFDwjmlbz61FwVtF5PZOLL5Eo2QQ/7zIHE+7pGcqwHZZDIGMF2oGeoLD48IWsmaex3Gyy45zx/+P3X8kNEz4/fUUJmUccgPh2tQjk4lhMUVf1Og9Vhncfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792304202; c=relaxed/simple;
	bh=B7Gw/wiYK21i/cMa7GU1UmN3hJqv1WC6YvEMSTJM0Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YerY5AX1hRgMnCt83cOYtzMmHeGNBwsarGju9OlCOoyYsSt/ZWp2aZEzaVkrjWZvEz4j9t0aq2WaAmcbWx19DkykmCMQdOxwRw8/TOJs3fNKXglroCk96i6XJ7TU6/ZJIOaP1vXQHw99mN/qlBwSn7Qisfy3aY9CIlk4m/Lik6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=svOFuxEq; arc=none smtp.client-ip=91.218.175.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="svOFuxEq"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=B7Gw/wiYK21i/cMa7GU1UmN3hJqv1WC6YvEMSTJM0Ps=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792304197; v=1; x=1792908997;
 b=svOFuxEqWf6TmVMdnsN1mZk98lR9tnesVti+KOrfgctxjpv8rBn12cxqNLDbHUyl+Rttw4Uy
 YA4lWw/9Qjlf9VWwziulrNT54f2eRyGnVA5cK41UhvKt5+6gNMuOUrAYCEmwdCUj8EoAzdj5nSU
 kH4lQrOX8B0Qk2jckfVlZGRU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8a974899a536c980;
	Sun, 18 Oct 2026 06:16:37 +0000
X-Mizu-Trace-ID: 8a974899a536c980
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
	stable@vger.kernel.org
Subject: Re: [PATCH 02/10] mm/hugetlb: fix use-after-free of a new anon folio
Date: Sun, 18 Oct 2026 14:16:32 +0800
Message-ID: <20261018061632.14622-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261015-urgent_fixes-v1-2-42796911043b@kernel.org>
References: <20261015-urgent_fixes-v1-2-42796911043b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Oct 15, 2026 at 06:07:08PM +0200, David Hildenbrand (Arm) wrote:
>From: Josef Bacik <josef@toxicpanda.com>
>
>For a fault in a private mapping with nothing in the page cache,
>hugetlb_no_page() allocates a folio, locks it and maps it.  The folio has
>one reference, which belongs to the page table entry from then on.  After
>dropping the page table lock the function still sets the migratable flag
>of the folio and unlocks it.
>
>Whoever zaps the entry in between frees the folio.  The fault holds the
>fault mutex and the lock of the vma.  MADV_DONTNEED and the first unmap of
>a hole punch, hugetlb_vmdelete_list(), do not take the fault mutex, and a
>private vma only has a lock if it owns a reservation map: not with
>MAP_NORESERVE, and not in the child after fork().
>
>Then the flag is set in, and folio_unlock() is called on, a folio that is
>free or has a new owner.  A surplus page goes back to the page allocator
>while it is locked:
>
>  BUG: Bad page state in process init  pfn:108e00
>  flags: 0x200000000000059(locked|uptodate|dirty|head|node=0|zone=2)
>  page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>
>A page of the pool can be given to the next user, of any file, who locks
>it and loses the lock to the late folio_unlock():
>
>  kernel BUG at mm/filemap.c:1532!
>   hugetlb_no_page+0x111b/0x23e0
>   hugetlb_fault+0x3a9/0x14a0
>
>An unprivileged process is enough: threads that write to a MAP_PRIVATE |
>MAP_NORESERVE hugetlb mapping, threads that call MADV_DONTNEED on it, and
>one that takes the freed pages for another file.
>
>Until commit 3a47c54f09c4 ("hugetlbfs: revert use i_mmap_rwsem for more
>pmd sharing synchronization") the fault held i_mmap_rwsem for reading,
>which everybody who zaps takes for writing.  The lock that commit
>bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private VMAs") gave
>to private vmas closed the window again, but only for those with a
>reservation map.
>
>Be done with the folio before the page table lock is dropped, as
>hugetlb_wp() is with its copy.  The function already unlocks page cache
>folios under that lock.
>
>Original fix generated by an LLM and sent in private by Josef.
>
>Fixes: 3a47c54f09c4 ("hugetlbfs: revert use i_mmap_rwsem for more pmd sharing synchronization")
>Cc: stable@vger.kernel.org
>Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>[ david: simplify+move comment ]
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nice work! Nothing jumped out at me, so:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
