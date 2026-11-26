Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795687194;
	b=V+cu3T238PeNyBZFHJ7pkpSQfsECPSo6xIAkrAPvJALq/welPIRxV3oJX97leqFBATrs
	 fcpkZfacwY5AYW040jLnxBiKPb/ps/v1JWXGd1SBOnC5rJivCY+0uVNAbXoFSQNUSNecA
	 QlQouYfOHT3z8lLBVDjXHNVC/NlItxFmh/17pDatTg9fs5+inEuyrNNXoVCOdPsNZCtgj
	 a5hGEGAmTtVU7ABRHc+/3nXAYVHM++RmUyy47+3e7ER5PK+Tz8tSjJwy0bNgwG+ewXIo7
	 IN8QeKkccGwq9CstRNJe/mUjXhItBKw2H9w9sygwvdwiykIADwVKKCZGFnmXFbr+03w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795687194;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HqYzO/eSRDch7jJCLzvTRvERSohL54BCcWWSz/h0074=;
	b=IvR00uColyKHLFJAznXJhv9UXkstPbxdvumb+SRX7/rIDza4yKxTuWASi0cXK4ppzP9X
	 mfzlzSPkQGkn7xgsZ5tSW6B/QtlrCy4Lnj54Ul7ncGTnqW35auT67y5lqpHgfiGwN/+oN
	 QwN29NoGlz3uVkpcb6jTQfL69+nP9cb4N/Lu8sb5aHZqb1fXzBJWJNm11V33HoAGOnlIt
	 Ms1glTYg3ZfaPacy+HeMo+CeezRLm4t1JVqlZUXzXJtCtv7UO7K+HIFbR2cAW3O7zs+TA
	 LEhbBwh/aFEgsXn6dx3gulJL9+C1AcMHoGyMGNmVaZr2/cfU3sx4DrbfK7wrW1Uz1vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSbQknkw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA591606A31C;
	Thu, 26 Nov 2026 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSbQknkw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E63D1F000CA;
	Thu, 26 Nov 2026 09:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795687194;
	bh=HqYzO/eSRDch7jJCLzvTRvERSohL54BCcWWSz/h0074=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FSbQknkw38FgllhfssHvNv0MbT1LPViaDlO7msWVDVWlr2dZ+tvZyZXD8lGkrbJHH
	 NYatujlK5nSOyXTq1MoXkh0Ui/+V7dJ8bsSqbCC5hfjdzSqaLiy1W1VSJM+Ub8JZZC
	 lNor7sv13clqY8nIKxzJ22Azl6QAVaWLfd1Q5ifVI2zTt5NOl5GRASRx7HsTxWVb5k
	 MnVw07RlfYCdZaTyLQqUZz2O5dJkLKr2JUWexPW3r+RU1oQ17f+b0gGD1n/UEvUF1R
	 4qTCsiY1jEyd6gzvvS/oBdhWhfjw4dE/SZ314lf43F1Y/r0j7juM4+ZoAaYeFow7mR
	 aI+WWCfDP7aiA==
Date: Thu, 26 Nov 2026 10:59:35 +0100
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
Subject: Re: [PATCH 04/21] mm/memfd: mark new hugetlb folios migratable
Message-ID: <awgDB3ocsRhKH4dw@localhost.localdomain>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
 <20261125-hugetlb_fixes_2-v1-4-db27fd2f71a8@kernel.org>
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
In-Reply-To: <20261125-hugetlb_fixes_2-v1-4-db27fd2f71a8@kernel.org>

On Wed, Nov 25, 2026 at 11:33:02PM +0100, David Hildenbrand (Arm) wrote:
> memfd_alloc_folio() adds a new hugetlb folio to the page cache, but
> never sets it migratable, unlike hugetlb_no_page() and
> hugetlbfs_fallocate().
> 
> Later faults will find it as an existing folio and never set the
> migratable flag.
> 
> Such a folio can never be isolated for migration, even once it is no
> longer pinned, which breaks memory offlining, alloc_contig_range() and
> memory failure handling.
> 
> Let's fix it by setting the new folio migratable after adding it to the
> page cache, like hugetlbfs_fallocate() already does.
> 
> This has low urgency.
> 
> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
