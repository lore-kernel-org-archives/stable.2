Received: from mta0.migadu.com (out-191.mta0.migadu.com [91.218.175.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F0C4B4871
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052196; cv=none; b=o4Lsw56dcIFOJmNqMvNrX3jvX73gnWQ69lF661dfnpeoEdi3VTzMGPLaoypq37fHrYCObhV8CuzANeF7rdNTrn+bz9zd0T+1RRs7UVo2PLRUFOZZ0NT/NDzmSYhKw6zrfMfyi18DkcWrOD2+4qI/OlT8m9H9AX/duxfmYfZlfOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052196; c=relaxed/simple;
	bh=5OCQHy6Vii8nQbNIXcF5hqJKTP56Pm4uayTxNm1ZzNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4J0s+4S2dyCp42c+lO/EUjL72qacGfHc8eF9JLp+hs7wPujHi0Ur+JNcUThc5ytZWolaAhnhoqHh2EMgTBnI4yFbGXEkasZY/JAQJ9w8zITVd9QeWgvTGD73m3Qs9cTaoFMLuf5jIgkZebCmgqmCev6TyrbNdgpi5zMCFC7Wx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WRZgdt90; arc=none smtp.client-ip=91.218.175.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WRZgdt90"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5OCQHy6Vii8nQbNIXcF5hqJKTP56Pm4uayTxNm1ZzNo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792052192; v=1; x=1792656992;
 b=WRZgdt90fDwpWyl7tmiVZ7rq5QxJxsurRK5MRaEXlJV4Mx9UXMnBHRDGtsA2Ncos5itOtc6y
 p1Dv7yOi7rEGEME67/T22v66GstJTQ77DAwJOx+sGFq7Na2JPlvsKDg0nxEQHAIEnZ+OlwfS+FM
 qheEXSHhVBPxveBH2gtBpb4I=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7213910b432bc55e;
	Thu, 15 Oct 2026 08:16:31 +0000
X-Mizu-Trace-ID: 7213910b432bc55e
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: muchun.song@linux.dev,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	peterx@redhat.com,
	linmiaohe@huawei.com,
	lokeshgidra@google.com,
	liam@infradead.org,
	kylebot@openai.com,
	ljs@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/userfaultfd: only allocate anon_vma in CoW mappings
Date: Thu, 15 Oct 2026 16:16:25 +0800
Message-ID: <20261015081625.4974-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261014-copy_hugetlb_page_range-v1-1-5b68e03fe7fe@kernel.org>
References: <20261014-copy_hugetlb_page_range-v1-1-5b68e03fe7fe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Wed, Oct 14, 2026 at 01:53:11PM +0200, David Hildenbrand (Arm) wrote:
>find_vma_and_prepare_anon() can end up allocating an anon_vma in VMAs that
>are not CoW mappings, which is wrong.
>
>If we have a MAP_SHARED R/O file mapped, we lack VM_SHARED (but do have
>VM_MAYSHARE) and lack VM_MAYWRITE.
>
>While uffd later rejects such mappings (uffd registration requires
>VM_MAYWRITE, see comment in validate_dst_vma) find_vma_and_prepare_anon()
>still wrongly allocates an anon vma before it validates the vma.
>
>This in turn later confuses copy_page_range()->vma_needs_copy() such
>that we end up calling copy_hugetlb_page_range() with ranges that
>actually do not contain *any* per-pagetable information that would
>require copying, which is the basis for PMD-table sharing in the first
>place.
>
>copy_hugetlb_page_range() should not have to worry about shared
>PMD tables at all: it doesn't make any sense to copy page tables that are
>shared, as they can be fully recreated later. Ending up in the function
>with shareable page tables is the real issue.
>
>If a destination PMD table is shared in copy_hugetlb_page_range(), it
>might get concurrently unshared as we are not holding relevant
>locks, resulting in us using a page table that is no longer mapped and
>possibly freed after calling:
>
>	dst_pte = huge_pte_alloc(dst, dst_vma, addr, sz);
>
>To fix it, do not allocate an anon_vma in non-CoW mappings and add a
>safety guard to copy_hugetlb_page_range(), making sure that we never
>end up messing with shared PMD tables in there.
>
>Before commit 867a43a34ff8a ("userfaultfd: use per-vma locks in userfaultfd
>operations") we would always validate the VMA before allocating an
>anon_vma, and consequently never wrongly allocate an anon_vma.
>
>As uffd_lock_vma() is part of the same lookup machinery and
>also contains a misleading VM_SHARED check, change that one as well
>directly for consistency.
>
>A follow-up cleanup will stop taking the hugetlb_vma_lock_read(src_vma)
>lock in copy_hugetlb_page_range() entirely. Further, the usage of
>VM_SHARED in userfaultfd code should be cleaned up later to focus on
>CoW vs. non-CoW mappings.
>
>Reported-by: Kyle Zeng <kylebot@openai.com>
>Fixes: 867a43a34ff8a ("userfaultfd: use per-vma locks in userfaultfd operations")
>Cc: stable@vger.kernel.org
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Tested-by: Lance Yang <lance.yang@linux.dev>
