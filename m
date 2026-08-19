Received: from mta0.migadu.com (out-91.mta0.migadu.com [91.218.175.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0C1476CFB
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152251; cv=none; b=Wa++ojKfG7DUY6mTF0OR7BbV43lNTiifM+gWhFZHaZ/jR19yPBWle9uUUiqOw4/3Elr2oSmJgjCJsGGG3F5I5tCn8RUMlDDYDuowy6BXWxEvWHaLWR4heMRBdjj+ZBus8QN4Xa6CH8JnkzOtpujdcO+NplMB6ZSg/VjzEgy1aRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152251; c=relaxed/simple;
	bh=woV3sD+KTiQrdkyYXaaM7Lt9p8FafyPCmggpFU9FmrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Udvsv0k51JyFHy3K9GEYfkYVu+e0+eKJuIAuxfsqxn1pMlLC4i0PEizfFULRn8E+fVQGdGVFTWs+G5rAqM5PeCmsrTt9tIj/l0Xo+2MmyPhGvFgjseCqh2a4EQhxnci0U+gB+a/a//GbpxrJDwv0hLaDqqWORSAn3tX9jfJ8zLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jiVSUy82; arc=none smtp.client-ip=91.218.175.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jiVSUy82"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=woV3sD+KTiQrdkyYXaaM7Lt9p8FafyPCmggpFU9FmrM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787152244; v=1; x=1787757044;
 b=jiVSUy82q+P4mWKsHlfbZOlNPeI6pf/zHXJn9OZqDxaKNec4yWtb3wVbTrux44w6tyd1znHD
 pOSLSaZT7GSA20S9asfn+BuO61uEOq/h6gQiRTofv7jSkJhGFkfxz2z89CMVAoao0JVr0fHx/2Z
 UJDKO1nSS8N1rnZ+0aLt+cZ0=
X-Envelope-To: stable@vger.kernel.org
Received: from localhost (2602:fce1:44f:115e::)
	by smtp.migadu.com with ESMTPS id e4f920fde1b953f9;
	Wed, 19 Aug 2026 15:10:43 +0000
X-Mizu-Trace-ID: e4f920fde1b953f9
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: usama.arif@linux.dev
Cc: akpm@linux-foundation.org,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	david@kernel.org,
	dev.jain@arm.com,
	liam@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	kas@kernel.org,
	nphamcs@gmail.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH] mm/huge_memory: transfer the pmd dirty bit to the folio on zap
Date: Wed, 19 Aug 2026 23:10:34 +0800
Message-Id: <20260819151034.62640-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260819101222.3732660-1-usama.arif@linux.dev>
References: <20260819101222.3732660-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Wed, Aug 19, 2026 at 03:12:22AM -0700, Usama Arif wrote:
>zap_huge_pmd_folio() propagates the pmd young bit to the folio for the
>file case, but not the dirty bit.  The pte path does propagate it, in
>zap_present_folio_ptes() and so does the pmd split path, in
>__split_huge_pmd_locked().
>
>For most file mappings the omission is harmless, because writing to a
>shared file mapping goes through page_mkwrite(), which dirties the
>folio.  tmpfs is different: it has no page_mkwrite(), and
>vma_wants_writenotify() is false for it, so a *read* fault on a
>MAP_SHARED tmpfs mapping installs a writable pmd via do_read_fault().
>do_read_fault() does not call fault_dirty_shared_page(), so subsequent
>stores through that mapping set only the hardware dirty bit in the pmd
>and never call folio_mark_dirty().  A shmem folio allocated by a fault
>is marked uptodate but not dirty (see the clear: block in
>shmem_get_folio_gfp()), so PG_dirty is never set at all.
>
>Unmapping such a folio - munmap(), or exit_mmap() when the process dies
>- then loses the only record that it was written, because zap_huge_pmd()
>drops the pmd without transferring the dirty bit.  Reclaim afterwards
>sees a clean shmem folio: the whole swap-out block in
>shrink_folio_list() is inside "if (folio_test_dirty(folio))", so
>pageout() is skipped and the folio falls into __remove_mapping().
>There, folio_is_file_lru() is false for a swapbacked folio, so no shadow
>entry is created and __filemap_remove_folio(folio, NULL) simply empties
>the i_pages slot.  The data is freed without ever being written to swap,
>and the next fault on that index returns a freshly zeroed folio.
>
>This is silent data loss for any process that keeps state in a
>MAP_SHARED tmpfs segment across an unmap - for example a cache handed
>from one process generation to the next through /dev/shm.  It requires
>the folio to be PMD-mapped, so it only shows up once shmem THP is
>enabled (which is what we did in Meta fleet and started noticing crashes);
>with THP off the pte path transfers the dirty bit correctly.
>It also only becomes visible when swap is enabled, because with no swap
>device shmem folios (which are on the anon LRU) are not scanned by
>reclaim at all, so the clean folio is never dropped.
>
>Reproduced on x86_64 with a tmpfs mounted huge=within_size: read-fault a
>2MB-backed region, write a known pattern through the resulting mapping,
>munmap, force reclaim of the cgroup, then re-map and read back.  Without
>this patch the region reads back as zeros and vmstat shows zswpout 0 -
>the data was discarded rather than swapped.  With this patch the region
>reads back correctly and the pages are swapped out as expected.  With
>huge=never, or when the first touch is a write, the test passes either
>way.
>
>Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>Cc: <stable@vger.kernel.org>
>Signed-off-by: Usama Arif <usama.arif@linux.dev>
>---

Good catch!

Tested-by: Lance Yang <lance.yang@linux.dev>
