Received: from mta0.migadu.com (out-249.mta0.migadu.com [91.218.175.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA4E41D208
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135036; cv=none; b=C4UxTeZladkDgrnfiIS6wp6popRBzK4AFtfL3GdNmNt/+/sAu9GEXz2E/8luOZeNfkmOIvby5dfiqcF1sAenyoOdDqpi3QV84Xhwu359NWz9IPA153lgcVvdYMKT6fEqAeuVguLt0/Kn+GMJDnFnoKh1ZbPoS3aWTH5R1QqJqYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135036; c=relaxed/simple;
	bh=fGHOWXbRTwGx7Yxv23lsiLlvnmkHusi5Yy0Lxv5YfdA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uZRai3DyrUi4Uw92JreYVIv/43MSKjfjVfLVDaALXc4kbhZMDyP7fgfD7yJuImqlmD64JUFHxLA96uwbY8V81ReVNz30nhE0GpHpFM5mHC01vWLTeuIchSLR3O+awrDRX+IK1AwUH5DcrIl3Fb/nSTRCERERNcauGgPCKkf76Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uDmM0CGp; arc=none smtp.client-ip=91.218.175.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uDmM0CGp"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fGHOWXbRTwGx7Yxv23lsiLlvnmkHusi5Yy0Lxv5YfdA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792135032; v=1; x=1792739832;
 b=uDmM0CGpVpoUfiHpJnARnrntdDQdeGzhLbYbIe+gvvE7Nj0TqOkNOe9fk9AjsZl+09VXbc3e
 VIUFeVkqHNFMxOY/1NginI4otivraK4Ox3AVpkWeeFs0ng5vREno/QlMxJ7bxfI94yiJRblTyDq
 /lYlwN2s5O7Vyaic3HDQczcA=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id b663a7f23a3f7381;
	Fri, 16 Oct 2026 07:17:11 +0000
X-Mizu-Trace-ID: b663a7f23a3f7381
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 02/10] mm/hugetlb: fix use-after-free of a new anon folio
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261015-urgent_fixes-v1-2-42796911043b@kernel.org>
Date: Fri, 16 Oct 2026 15:16:54 +0800
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
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <370ADC80-F15F-40FA-A71E-8D641D060138@linux.dev>
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
 <20261015-urgent_fixes-v1-2-42796911043b@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 16, 2026, at 00:07, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> From: Josef Bacik <josef@toxicpanda.com>
>=20
> For a fault in a private mapping with nothing in the page cache,
> hugetlb_no_page() allocates a folio, locks it and maps it.  The folio =
has
> one reference, which belongs to the page table entry from then on.  =
After
> dropping the page table lock the function still sets the migratable =
flag
> of the folio and unlocks it.
>=20
> Whoever zaps the entry in between frees the folio.  The fault holds =
the
> fault mutex and the lock of the vma.  MADV_DONTNEED and the first =
unmap of
> a hole punch, hugetlb_vmdelete_list(), do not take the fault mutex, =
and a
> private vma only has a lock if it owns a reservation map: not with
> MAP_NORESERVE, and not in the child after fork().
>=20
> Then the flag is set in, and folio_unlock() is called on, a folio that =
is
> free or has a new owner.  A surplus page goes back to the page =
allocator
> while it is locked:
>=20
>  BUG: Bad page state in process init  pfn:108e00
>  flags: 0x200000000000059(locked|uptodate|dirty|head|node=3D0|zone=3D2)
>  page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>=20
> A page of the pool can be given to the next user, of any file, who =
locks
> it and loses the lock to the late folio_unlock():
>=20
>  kernel BUG at mm/filemap.c:1532!
>   hugetlb_no_page+0x111b/0x23e0
>   hugetlb_fault+0x3a9/0x14a0
>=20
> An unprivileged process is enough: threads that write to a MAP_PRIVATE =
|
> MAP_NORESERVE hugetlb mapping, threads that call MADV_DONTNEED on it, =
and
> one that takes the freed pages for another file.
>=20
> Until commit 3a47c54f09c4 ("hugetlbfs: revert use i_mmap_rwsem for =
more
> pmd sharing synchronization") the fault held i_mmap_rwsem for reading,
> which everybody who zaps takes for writing.  The lock that commit
> bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private VMAs") =
gave
> to private vmas closed the window again, but only for those with a
> reservation map.
>=20
> Be done with the folio before the page table lock is dropped, as
> hugetlb_wp() is with its copy.  The function already unlocks page =
cache
> folios under that lock.
>=20
> Original fix generated by an LLM and sent in private by Josef.
>=20
> Fixes: 3a47c54f09c4 ("hugetlbfs: revert use i_mmap_rwsem for more pmd =
sharing synchronization")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> [ david: simplify+move comment ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

