Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795687103;
	b=2e9aDtfOgMHMHmmFuNUFiXONZZrg7PeF72rIs6nvR+PRMnTi5F0vrHAuXDqmEHxrTzUr
	 xNrXZ9skHpN0fRgXlWb8tmYkjVo332o/s6UiukOsHy5ZDNJbc3j7pFqe+co4CvBX+e4QW
	 qCyT0kvYMsJ+UFtdyUa92kfsIA+UWhVlf2xaO05rVEQtojj2Rqu7vK5GyQfDswhwpfWQG
	 l+4oIr/11fK4Wk2jjQ2cY7wfnaivB3D6FYeKTYYHpuehAPelbp3TXoxtxeqJrhHang0p9
	 Wf/MbL/Xlzlcxp1cqEtalz4PDDNY8BQDI/QFCz375796+nwLvEFgxXG+WC/91L/kl0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795687103;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CMPzilywSB0BY9L2Teq2vIgsxnr+wRA47wTymsp256M=;
	b=sdN/hfbP+TRE9prAMETHHqsYERCN7v4vjnTRkYUa9nmVaqU7tlSNvqGKEEGWPTUz1ccv
	 S5hk1oev+qmtzYmgOwR+uhkPNAqQxX4AVjYW2iz52qxa6vdUrxqFTT9f/ck8PbOHyZbFz
	 EXXHGKrOgYyhDl4qdzh2UNXv4+Vl4kzCLBAOIRoSLbzAn2AS4Bbil/P76T26d9FdvNmKl
	 2+De4hYAYT6GjxNle+pRS3y5fXBbq0V8s2ZxqVkdqjOueCBxnfOYnQTU8urVwn//B+I40
	 e8faGFgO4jLXhRd7FT+bD5r5vAUmYBnFs7Q6Fm3FbcsZFa4QblBeHiZjjf4fcCeGI5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKagZpBn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752A7606A31E;
	Thu, 26 Nov 2026 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKagZpBn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DFF1F000C6;
	Thu, 26 Nov 2026 09:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795687102;
	bh=CMPzilywSB0BY9L2Teq2vIgsxnr+wRA47wTymsp256M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AKagZpBn09AMbaWKLVVyKAJAUx9rdzxn5/4X2BaEMhVscDXISnhAXMP+67fB0+NLE
	 +L1iyYQ+PzRxiOnq7Z7lckWKWYA0MJ4zn0Ndo31NuPvyNz/U9QzPl/RtMc9nRy2IVu
	 /u8KqcUDY2UH3cJqKTjjnxzun6NlSMQetsy0RPceCAw0QLpfvat8hr4q/jK6YG/Fu2
	 Vt6L+bsyDNM4fGCvaYAckuNqXVjtavc5m9alq5R79ljduTjslbQGsxMWtVAxfEqOis
	 GlH5d/P2EV4eiLuLnTHtvUXPD9PQWhUsmk1VVUDOfZaSvct0VtCmL7/0NqlT7s84Sn
	 n2ZwN/mGR+2Mg==
Date: Thu, 26 Nov 2026 10:58:06 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
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
	Gerd Hoffmann <kraxel@redhat.com>, Mike Rapoport <rppt@kernel.org>,
	Mel Gorman <mel@csn.ul.ie>,
	Dave McCracken <dave.mccracken@oracle.com>,
	Andy Whitcroft <apw@shadowen.org>, Adam Litke <agl@us.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>,
	James Houghton <jthoughton@google.com>,
	Yang Shi <shy828301@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Pedro Falcato <pfalcato@suse.de>, Gregory Price <gourry@gourry.net>,
	Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Byungchul Park <byungchul@sk.com>,
	Alistair Popple <apopple@nvidia.com>,
	Wanpeng Li <liwanp@linux.vnet.ibm.com>,
	Andi Kleen <ak@linux.intel.com>,
	Kenneth W Chen <kenneth.w.chen@intel.com>,
	Hugh Dickins <hugh@veritas.com>, Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>, Joern Engel <joern@logfs.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Michal Hocko <mhocko@suse.cz>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	Sasha Levin <sasha.levin@oracle.com>,
	Guillaume Morin <guillaume@morinfr.org>,
	Wanpeng Li <liwp.linux@gmail.com>, linux-mm@kvack.org,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-doc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 03/21] mm/hugetlb: always mark new page cache folios
 migratable
Message-ID: <awgCro3ymVNkIykq@localhost.localdomain>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
 <20261125-hugetlb_fixes_2-v1-3-db27fd2f71a8@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125-hugetlb_fixes_2-v1-3-db27fd2f71a8@kernel.org>

On Wed, Nov 25, 2026 at 11:33:01PM +0100, David Hildenbrand (Arm) wrote:
> hugetlb_no_page() and hugetlb_mfill_atomic_pte() only set
> hugetlb_migratable for a new folio once they installed the PTE.
> 
> If they back out after adding the new folio to the page cache, for
> example because the PTE changed or is no longer empty, the folio will
> stay in the page cache without the migratable flag set.
> 
> Later faults will find it as an existing folio and never reset the flag.
> Such a folio can never be isolated for migration, which breaks memory
> offlining, alloc_contig_range(), longterm pinning and memory failure
> handling.
> 
> Worse, if the folio is not longterm pinnable, because it resides in
> ZONE_MOVABLE or CMA, memfd_pin_folios() and the longterm GUP path retry
> forever on -EAGAIN. memfd_pin_folios() cannot even be killed, which will
> be fixed independently.
> 
> Let's fix it by setting hugetlb folios migratable whenever (1) a new
> anon folio gets mapped; or (2) a new folio was added to the page cache,
> like hugetlbfs_fallocate() already does.
> 
> This has low urgency.
> 
> Fixes: cb6acd01e2e4 ("hugetlbfs: fix races and page leaks during migration")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
