Received: from mta1.migadu.com (out-75.mta1.migadu.com [95.215.58.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4881648987C
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053478; cv=none; b=A0+XSEbk4dmkF2sc8DlcM08Zze8z07f0MpubDLl5Vfaxwx2ksMynD9uslda9visgAPqHMyL3294M2xMVHKWxPYPeuvYyuYp6t0fAgINTM1KilqAzj6PrgEudKUCdiartIBiE5TSNiAe2otjuvBwENIt0tmAHZ8G81Uis0rQZa4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053478; c=relaxed/simple;
	bh=J8/WPUKZgvpFon73tY8pEvuDWGuU6a6DVXGoFvHaRSA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KyOJDCzGfdnlgAVXex5kiX/lgRAMReWcj8JVhfcljdsnc9aT9I944UNszXknBPOJRJ5Wr/CehoXsV1YdujgF5mK54OOScAP52EHLJu8GACVvZLqThozUmJv+PhrvgC0/Gx/QcqfnaWkS3j7rblCmqngfz7LEJDGaSP7mifU+tso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cprc7Jne; arc=none smtp.client-ip=95.215.58.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cprc7Jne"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=J8/WPUKZgvpFon73tY8pEvuDWGuU6a6DVXGoFvHaRSA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792053474; v=1; x=1792658274;
 b=Cprc7JneowWM/4GOXkbzF+0Sbbc7i0Zu8iF5EdKQs6uRWI6H6Qac89fH4ZMifndex0qaMIqh
 1dtvl3G/1cjl3HEoYiMHtbl5PCsfLgSAC81tr3r7E4ST43qLiZZDSTd2fcgJXhEYEbcnCEgFrkP
 ndB/vfnT7av2kthqfpClU0rA=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 9f4aca14d8d7e350;
	Thu, 15 Oct 2026 08:37:54 +0000
X-Mizu-Trace-ID: 9f4aca14d8d7e350
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH] mm/userfaultfd: only allocate anon_vma in CoW mappings
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261014-copy_hugetlb_page_range-v1-1-5b68e03fe7fe@kernel.org>
Date: Thu, 15 Oct 2026 16:37:39 +0800
Cc: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>,
 Peter Xu <peterx@redhat.com>,
 Miaohe Lin <linmiaohe@huawei.com>,
 Lokesh Gidra <lokeshgidra@google.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 Kyle Zeng <kylebot@openai.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <89E8831F-8877-48ED-A2DF-5128DEEF8C43@linux.dev>
References: <20261014-copy_hugetlb_page_range-v1-1-5b68e03fe7fe@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 14, 2026, at 19:53, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> find_vma_and_prepare_anon() can end up allocating an anon_vma in VMAs =
that
> are not CoW mappings, which is wrong.
>=20
> If we have a MAP_SHARED R/O file mapped, we lack VM_SHARED (but do =
have
> VM_MAYSHARE) and lack VM_MAYWRITE.
>=20
> While uffd later rejects such mappings (uffd registration requires
> VM_MAYWRITE, see comment in validate_dst_vma) =
find_vma_and_prepare_anon()
> still wrongly allocates an anon vma before it validates the vma.
>=20
> This in turn later confuses copy_page_range()->vma_needs_copy() such
> that we end up calling copy_hugetlb_page_range() with ranges that
> actually do not contain *any* per-pagetable information that would
> require copying, which is the basis for PMD-table sharing in the first
> place.
>=20
> copy_hugetlb_page_range() should not have to worry about shared
> PMD tables at all: it doesn't make any sense to copy page tables that =
are
> shared, as they can be fully recreated later. Ending up in the =
function
> with shareable page tables is the real issue.
>=20
> If a destination PMD table is shared in copy_hugetlb_page_range(), it
> might get concurrently unshared as we are not holding relevant
> locks, resulting in us using a page table that is no longer mapped and
> possibly freed after calling:
>=20
> dst_pte =3D huge_pte_alloc(dst, dst_vma, addr, sz);
>=20
> To fix it, do not allocate an anon_vma in non-CoW mappings and add a
> safety guard to copy_hugetlb_page_range(), making sure that we never
> end up messing with shared PMD tables in there.
>=20
> Before commit 867a43a34ff8a ("userfaultfd: use per-vma locks in =
userfaultfd
> operations") we would always validate the VMA before allocating an
> anon_vma, and consequently never wrongly allocate an anon_vma.
>=20
> As uffd_lock_vma() is part of the same lookup machinery and
> also contains a misleading VM_SHARED check, change that one as well
> directly for consistency.
>=20
> A follow-up cleanup will stop taking the =
hugetlb_vma_lock_read(src_vma)
> lock in copy_hugetlb_page_range() entirely. Further, the usage of
> VM_SHARED in userfaultfd code should be cleaned up later to focus on
> CoW vs. non-CoW mappings.
>=20
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Fixes: 867a43a34ff8a ("userfaultfd: use per-vma locks in userfaultfd =
operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

