Received: from mta0.migadu.com (out-121.mta0.migadu.com [91.218.175.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC783BA244
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144199; cv=none; b=RpSVAHJH31D7NUHWAuENvOzLo1TKU0Op2qCEGhwhKa//bjOFg9bpDPxdaaQBLa+MlROyFDKgZVYqGo896GA+qK10gXPdaAPtZhVjrk1nWWh8PJ/T6tvJQZQBPDJR0+7o3QyG3F7w1WYZpeYRhbx+OkqNd807X03fz15eRhhx1gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144199; c=relaxed/simple;
	bh=W4HZiu6j/Fq+Mee4Nsti7eqNIF7myNqYt9HBvlfMVI8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=W5XD+TtPubGjkcNOO0p02qGOZsfUHi00wCcHRGVDkSKfZWPiTYCTRviVJm2qdh61iefhyTgEuRsOGBRGwdIqTb9piKdem3exIOllwuiYmrIkSBUoAAyS1AxbqWDKC5DDJQ2C6jSp4vnQzM6rVT0BobTVjJuRsQz49QqqU/mKdvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cP8evNw9; arc=none smtp.client-ip=91.218.175.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cP8evNw9"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=W4HZiu6j/Fq+Mee4Nsti7eqNIF7myNqYt9HBvlfMVI8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792144194; v=1; x=1792748994;
 b=cP8evNw9fEiqcVbs73gA+44NHIPMRHIyeMGW3C38L4FSGSudrXAt4RJMvXp0EQXO90oYRiSI
 xbHnooH2CtTT8XAF37T3cUkx5AbS0lDfrUvo4/MAa/eV5j4YnD4gKrlFHexDf/0U66HyWTvBiqc
 iRt17m0WsF6OQhU5k1CeAxgg=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id c8ab28ede6a5f938;
	Fri, 16 Oct 2026 09:49:54 +0000
X-Mizu-Trace-ID: c8ab28ede6a5f938
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 04/10] mm/hugetlb: unmap the page where the other VMA maps
 it
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261015-urgent_fixes-v1-4-42796911043b@kernel.org>
Date: Fri, 16 Oct 2026 17:49:37 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,
 Oscar Salvador <osalvador@suse.de>,
 Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Adam Litke <agl@us.ibm.com>,
 Mel Gorman <mel@csn.ul.ie>,
 Rik van Riel <riel@surriel.com>,
 Peter Xu <peterx@redhat.com>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Chris Mason <mason@kernel.org>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BAB2117B-1197-4D6C-953B-31F9C33BDD42@linux.dev>
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
 <20261015-urgent_fixes-v1-4-42796911043b@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 16, 2026, at 00:07, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> From: Josef Bacik <josef@toxicpanda.com>
>=20
> If the owner of a MAP_PRIVATE hugetlb mapping fails to allocate a page
> for CoW, unmap_ref_private() unmaps the old page from all other =
private
> VMAs that have no reservation of their own.  It finds them by the =
offset
> in the file, but then zaps each of them at the address of the faulting
> VMA.  Nothing says that another VMA maps the offset at that address: a
> child can have moved its copy of the VMA with mremap(), and a second
> mapping of the file is wherever mmap() has put it.
>=20
> So __unmap_hugepage_range() walks the page tables of the other mm at =
an
> address outside of iter_vma, where i_mmap_rwsem of this file protects
> nothing and where anything can be mapped, and the page stays mapped =
where
> it really is.
>=20
> All of the following was seen on v7.3-rc6+ (g6c377d19d4a5) in KVM =
guests,
> as a user without any privilege.  It takes a pool of 2 MiB pages with =
no
> free page that is not reserved, so that the allocation fails: the user
> can take or reserve what is free itself.
>=20
> - The child moves its VMA away.  The page is never unmapped, the
>   mapcount stays 2, and the owner goes round retry_avoidcopy in
>   hugetlb_wp() until the child is gone or a page becomes free.  =
SIGKILL
>   to the owner does not end it.  5 of 5 runs.
>=20
> - The owner's mm has a second private mapping of the offset, made with
>   MAP_NORESERVE.  The owner zaps its own entry and reads zeroes where
>   its data was.  5 of 5 runs.
>=20
> - The child moves its VMA away and maps a 1 GiB hugetlb page at the =
old
>   address, so this one takes a pool with a 1 GiB page as well.
>   huge_pte_offset() for the 2 MiB size steps through the PUD
>   leaf, so the "PMD table" is the 1 GiB page itself and its "page =
table
>   lock" is folio->private of that page, which holds 2.  Kernels with
>   lock debugging oops in __unmap_hugepage_range(), 7 of 7 runs.  =
Others
>   spin on that word for ever with preemption disabled, 5 of 5 runs:
>=20
>     watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [u_det3:130]
>     RIP: 0010:queued_spin_lock_slowpath+0x8a/0x290
>     RAX: 0000000000000002 RBX: ffffea0001000028
>     Call Trace:
>      __unmap_hugepage_range+0x154/0x6d0
>      unmap_hugepage_range+0xc1/0x140
>      hugetlb_wp+0x55c/0x700
>      hugetlb_fault+0x5f3/0x8f0
>=20
>   RCU stalls follow, and killing all tasks of the user changes =
nothing.
>   Four such owners, whose children share a single 1 GiB page, took =
down
>   the whole guest with its four CPUs, 2 of 2 runs: one reported soft
>   lockups on all four, the other gave no sign of life any more.
>=20
>   i_mmap_rwsem stays write locked.  With a MAP_PRIVATE mapping of a
>   hugetlbfs file that belongs to another user, and that the attacker
>   can only read, the next mmap() of that file by its owner sleeps
>   uninterruptibly in __mmap_region(), 4 of 4 runs.
>=20
> Compute the address from the offset for each VMA.  The tree walk =
returns
> only VMAs that cover pgoff, and vm_start, vm_end and vm_pgoff of a =
hugetlb
> VMA are aligned to the huge page size, as pgoff is, so the whole range
> lies inside iter_vma.  Its page tables can not go away there, since =
the
> VMA is unlinked from the file under i_mmap_rwsem first.
>=20
> With the right address the page is unmapped from all VMAs but the
> owner's, so the retry in hugetlb_wp() finds a mapcount of 1 and reuses =
the
> page.
>=20
> A child that has moved its copy of the VMA now loses the page, and =
gets
> SIGBUS when it faults on a missing page of that VMA.  That is what the
> comment above the function has always promised to those who do not own
> the reservation, and what already happens to a child that has left the
> VMA in place.
>=20
> The address has been wrong from the start, and the second case needs
> only mmap() and fork().  mremap() of hugetlb VMAs, which the other =
cases
> use, came with commit 550a7d60bd5e ("mm, hugepages: add mremap() =
support
> for hugepage backed vma") in v5.16.
>=20
> Original fix generated by an LLM and sent in private by Josef.
>=20
> Fixes: 04f2cbe35699 ("hugetlb: guarantee that COW faults for a process =
that called mmap(MAP_PRIVATE) on hugetlbfs will succeed")
> Reported-by: Chris Mason <mason@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: switch to vma_filebacked_address, add VM_WARN_ON_ONCE, refine =
comments]
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

