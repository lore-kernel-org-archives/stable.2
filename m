Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658747;
	b=HBK9YDFgkbX17lZu/hIIM/UopkmAtdianCoNU+CKShSOANKfJeJ8Z+rHM0Pe7vs5TSD+
	 UdmEieem5YgYmN3BlWrB4Ch9ffa1qD7mVvq8OEwf2nOddeQnAmxORyI3AEOR8jvsCuEND
	 Oxga/3qyOvChQCO1gTPXzL+NW0tB8a8Z3nHCTUwe/Uh4WyQfSdjgB+ll7wMLGz6WJ3Wc9
	 JJRER+WY1Ix2bkypgiLz0ikSwIfETst605i17Aoi/4yJy5OaHgpGP14yeekKOKIxJ1emu
	 c9mG3hRzVqdrr/6mrH3vjv1Ch5RUXowIEA1lCa73HtXD4vgG/0x8MdDNUMbct7uDLBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658747;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=WtwI+c9ObEOaIfdXp9STes6sTUCSWn6KexSqCuHMD30=;
	b=s153XKkdprPppYcjmiriFZVYDgEIhGqVrbyZIXSRtEuj1RC4K+t9uXF1sI0/wSIRBHss
	 sa7XuUiqdPAK+WIFKUWajCyKfPi0UanynHZUmElGAwNVydUSpXeta65sf1q81WkY0nPsD
	 8rju7umaIxYAYU1HAIhVQBs3pRnhke0a1r377qKhtPVvFLzEVP2JDVaGxci78RhNQ12IM
	 9yuN5zD/Ab6NRbNvO6KYXK1PlGHOlov98ylCS51hhJ4+MMo7B+fsLQuxq+N7O18udbEnS
	 LF1kfF8CZuEueLw9ep2e+Z6ptnIbdmIMV9Bu9d2FaceaJeiggDw4njYzdTkOtgjxXxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CVShjB8q;
	arc=none smtp.remote-ip=91.218.175.47
Received: from mta0.migadu.com (out-47.mta0.migadu.com [91.218.175.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B166606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B166606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CVShjB8q
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WtwI+c9ObEOaIfdXp9STes6sTUCSWn6KexSqCuHMD30=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795658745; v=1; x=1796263545;
 b=CVShjB8qQ7qAzh4mixJMxw40VAJKpj/4y1j0cDUIt5JjbLW+kd+JJpU2nVTYjJHjX733+0ip
 3kK9o+dOF/dvt+y9VU6UGV2PyBPNTgNBnCPqRVdtLtxnXM6/zgazAZfnIO3VzAMyFVJ5wB5Bx7s
 WTNj1msmqmOkk8SfzKfwyU/Q=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bcad4ddb13afde49;
	Thu, 26 Nov 2026 02:05:24 +0000
X-Mizu-Trace-ID: bcad4ddb13afde49
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 03/21] mm/hugetlb: always mark new page cache folios
 migratable
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261125-hugetlb_fixes_2-v1-3-db27fd2f71a8@kernel.org>
Date: Thu, 26 Nov 2026 10:04:25 +0800
Cc: Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jinmeng Zhou <jinmengzhou22@gmail.com>,
 Hongfu Li <lihongfu@kylinos.cn>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Dave Airlie <airlied@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mike Rapoport <rppt@kernel.org>,
 Mel Gorman <mel@csn.ul.ie>,
 Dave McCracken <dave.mccracken@oracle.com>,
 Andy Whitcroft <apw@shadowen.org>,
 Adam Litke <agl@us.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Rik van Riel <riel@surriel.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>,
 Lance Yang <lance.yang@linux.dev>,
 James Houghton <jthoughton@google.com>,
 Yang Shi <shy828301@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Pedro Falcato <pfalcato@suse.de>,
 Gregory Price <gourry@gourry.net>,
 Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Byungchul Park <byungchul@sk.com>,
 Alistair Popple <apopple@nvidia.com>,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>,
 Andi Kleen <ak@linux.intel.com>,
 Kenneth W Chen <kenneth.w.chen@intel.com>,
 Hugh Dickins <hugh@veritas.com>,
 Michal Hocko <mhocko@suse.com>,
 David Rientjes <rientjes@google.com>,
 Joern Engel <joern@logfs.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Michal Hocko <mhocko@suse.cz>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Sasha Levin <sasha.levin@oracle.com>,
 Guillaume Morin <guillaume@morinfr.org>,
 Wanpeng Li <liwp.linux@gmail.com>,
 linux-mm@kvack.org,
 Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@osdl.org>,
 linux-doc@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C615E9EC-BE52-4F33-86D4-4FE7F911EEAC@linux.dev>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
 <20261125-hugetlb_fixes_2-v1-3-db27fd2f71a8@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 26, 2026, at 06:33, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> hugetlb_no_page() and hugetlb_mfill_atomic_pte() only set
> hugetlb_migratable for a new folio once they installed the PTE.
>=20
> If they back out after adding the new folio to the page cache, for
> example because the PTE changed or is no longer empty, the folio will
> stay in the page cache without the migratable flag set.
>=20
> Later faults will find it as an existing folio and never reset the =
flag.
> Such a folio can never be isolated for migration, which breaks memory
> offlining, alloc_contig_range(), longterm pinning and memory failure
> handling.
>=20
> Worse, if the folio is not longterm pinnable, because it resides in
> ZONE_MOVABLE or CMA, memfd_pin_folios() and the longterm GUP path =
retry
> forever on -EAGAIN. memfd_pin_folios() cannot even be killed, which =
will
> be fixed independently.
>=20
> Let's fix it by setting hugetlb folios migratable whenever (1) a new
> anon folio gets mapped; or (2) a new folio was added to the page =
cache,
> like hugetlbfs_fallocate() already does.
>=20
> This has low urgency.
>=20
> Fixes: cb6acd01e2e4 ("hugetlbfs: fix races and page leaks during =
migration")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Muchun Song (ByteDance) <muchun.song@linux.dev>


