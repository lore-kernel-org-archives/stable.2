Received: from mta0.migadu.com (out-198.mta0.migadu.com [91.218.175.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F07C41D64E
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144346; cv=none; b=mrVM0IGyFsGz4eBMwPiK05jHzDalOw9HFn5TRe/jU1ur3r/DoGtB59Io573HqPaHPdzlPObba6rEKdD4taP/aAyFBhChvGXv6nU9hYWuDiFxdCXUSEjhCSRkBZLsaneU5qk2bOwpa9NO9rZimdXJGiPKdjVIzp5AzcVh2etkqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144346; c=relaxed/simple;
	bh=cYDQAo4y4RUVTtwoUXBAS+2ASZSDHzhPf6jkQnpyU60=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LR2U0GDnBNR0Jwzw6zsAfkeY7FabWB8QHzag7aEOuwQjbjbRGg4tBsoQeRr9RlDZPed/+Jf9nPBRf7e0JAwqn9l/B1SgyLuBnz1+I6VSK9HwdSqYzbdOKCNQPND3zFlDDYWmuEedVcLxEzKvre0yB6IZOQY4zq/srYIQifGNO3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xB1w8S3z; arc=none smtp.client-ip=91.218.175.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xB1w8S3z"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cYDQAo4y4RUVTtwoUXBAS+2ASZSDHzhPf6jkQnpyU60=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792144342; v=1; x=1792749142;
 b=xB1w8S3zBSgF2SQ7hQW2j9zrs6T4Rn9vpXhT5nPI1tgerR4OAToFbei3+msLxVTpPkaJTCTe
 iLeCfqpa9KihhS2EFrkV9JaPzMUsfpv5vkdntsCBTweJtnh3n9KEn6qUptxLwL447hv3Gfn4Bcs
 mpvSb0+3iWXmexUxpMphehC0=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id be15a02e218a3bac;
	Fri, 16 Oct 2026 09:52:22 +0000
X-Mizu-Trace-ID: be15a02e218a3bac
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 05/10] mm/hugetlb: don't clear the resv_map of a VMA whose
 lock is held
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261015-urgent_fixes-v1-5-42796911043b@kernel.org>
Date: Fri, 16 Oct 2026 17:52:04 +0800
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
Message-Id: <92E58ED4-A09C-41CB-A3B8-12F6F834FD87@linux.dev>
References: <20261015-urgent_fixes-v1-0-42796911043b@kernel.org>
 <20261015-urgent_fixes-v1-5-42796911043b@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 16, 2026, at 00:07, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> From: Josef Bacik <josef@toxicpanda.com>
>=20
> Since commit bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to =
private
> VMAs") the lock of a private hugetlb VMA that owns a reservation is =
the
> rw_sema of its resv_map.  The hugetlb_vma_*lock*() helpers find it =
through
> vma->vm_private_data, anew for every lock and every unlock.
>=20
> At the end of mremap() the old VMA has to let go of the resv_map, =
which
> now belongs to the new VMA: clear_vma_resv_huge_pages() stores NULL =
into
> vm_private_data.  mremap() holds mmap_lock for writing and has write
> locked the VMA, which keeps away everybody who comes through the mm.  =
It
> does not keep away those who find the VMA through the file.  For hole
> punch and truncation hugetlb_vmdelete_list() does
>=20
> hugetlb_vma_trylock_write(vma); locks resv_map->rw_sema
> unmap_hugepage_range(vma, ...);
> vm_private_data =3D NULL
> hugetlb_vma_unlock_write(vma); no resv_map: does nothing
>=20
> and the rw_sema stays write locked for ever:
>=20
>  WARNING: lock held when returning to user space!
>  mremap_punch/116 is leaving the kernel with locks still held!
>  locks held by mremap_punch/116: 1, last CPU#1:
>   #0: (&resv_map->rw_sema){+.+.}-{4:4}, at:
>                                       hugetlb_vmdelete_list+0x46/0x160
>=20
> The next fault in the new VMA sleeps in hugetlb_vma_lock_read(),
> uninterruptibly, and it holds its entry of =
hugetlb_fault_mutex_table[].
> That table is global, so a fault of any other process on a page that
> hashes to the same entry sleeps uninterruptibly as well.
>=20
> All those who take the lock of a private VMA without taking the =
mmap/vma
> lock are affected: rmap walks. So hold i_mmap_rwsem around the =
clearing
> of the resv_map.
>=20
> No change of behaviour, other than that mremap() of a hugetlb VMA =
takes
> i_mmap_rwsem once more.
>=20
> Original fix generated by an LLM and sent in private by Josef.
>=20
> Fixes: bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private =
VMAs")
> Reported-by: Chris Mason <mason@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> [ david: avoid local variable, move and refine comment, description =
cleanups+simplifications ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

