Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793178599;
	b=Q9xxfsA1Usl4SCYIgqOfYA2Cfzf8NcNvq3Tczj48Vcq7xK0vKxi9OPPKPI8/9eTYmi/p
	 +kOkRWcJ9xprioMN4ULmhKn3LTMsmWGhaYdotwkpb3Y/jDQXOfT6Ti6uKonYbmejVsNkw
	 yuyQYOnM5MOKHEJLSs7H5QHcT2IRWqRprGIG+Wr9acNt9b3xmkXjXh1Q3rjo/YgmRoBUw
	 zSAQubc/DKr+caeaApJOtKpe0iTx4sIrq0W+7c5HaZDSoJnESeLcUmkZdFjL1iihrQ19E
	 njCjbte+iF5j8WlvPyJUQ1BM8k/5BXbhtgbfnT2oVNCr1M155hnUmLE1WWgyYOgwAMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178599;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bLZSl7G53VjRTMzaR+4ybREso2p4MLSxqwNzQhyf3As=;
	b=nuGYCQbCmQBoRwLptFc7Du8bvY1hngiyb5bOoNHOa1kWmqoi5kCxu31zJ1iYEeo+AjGQ
	 F6aSwAdJXcFyubpKDPX4kJePeW+Wys+k8FVCHUkRYKymOGZKekxHwzsmES2mCftKC4eBr
	 FHqcBKX0pDLgtcYPUOzjzVRhKjT5rsXzDHfq/ugtM9QyvlaF5+SdskZ/sQuRcxdA0Tomb
	 0be3+tuetWjeISKNbiv9AFUZF33MmmefmZS6xbf0vHZaw12XYFd025n/6i6B+8ZVqKxkt
	 TrGMR86Z3wJ9zq91qdNb3osj71cZQdQw8FlaWtcQ0/ZP7v2E4CLCrlm0o6nSfWwIj4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQLvv5Vy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E2606A31D;
	Wed, 28 Oct 2026 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQLvv5Vy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CEF1F01825;
	Wed, 28 Oct 2026 09:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793178598;
	bh=bLZSl7G53VjRTMzaR+4ybREso2p4MLSxqwNzQhyf3As=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IQLvv5VyEW9W822k4mht+xeLq3S4XizAu+yULPQZsw/IVShZGFw4v2DipYDdBsIDM
	 ZuO9nCZm9CpX8w5ml0a91JdjeCai4IiV9QbHxDf8RJ5flGZR1CGm3IoGtSym8UApk4
	 Csg/F36qW6LxKG3+BIRu5428gBcRYr7WkphITq9nSu15oEzQk7PBodVhHzdvwyKAsU
	 L0DDpJRkU7kCsCA8XIudNovrwViAworRTX8BBm8mzz3lW+kK0r+b10tnjOyJB2Z4jA
	 ml2WMykb/ecw+qvzqKMXuJLLemM/U4ijkpfsw/rwxPj03zXiSs2jn466I+8Fyr4hbl
	 WjWlEy8zwut6w==
Date: Wed, 28 Oct 2026 09:09:42 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 09/46] mm/rmap: handle device-exclusive entries in
 folio_referenced_one()
Message-ID: <auG7p94aT3SynuWy@gremlin>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-9-6f74bec9a5bb@kernel.org>
 <e32a19c4-76c4-40ba-83a4-781333af7b0a@arm.com>
 <f5b90920-5923-45a6-be2b-f558801781c5@kernel.org>
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
In-Reply-To: <f5b90920-5923-45a6-be2b-f558801781c5@kernel.org>

On Wed, Oct 28, 2026 at 09:08:04AM +0100, David Hildenbrand (Arm) wrote:
> >> -		if (lru_gen_enabled() && !lru_gen_switching() && pvmw.pte) {
> >> +		if (lru_gen_enabled() && !lru_gen_switching() && pvmw.pte &&
> >> +		    pte_present(pteval)) {
> >>  			if (lru_gen_look_around(&pvmw, nr))
> >>  				referenced++;
> >>  		} else if (pvmw.pte) {
> >> -			if (clear_flush_young_ptes_notify(vma, address, pvmw.pte, nr))
> >> +			bool young = false;
> >> +
> >> +			/*
> >> +			 * PFN swap PTEs, such as device-exclusive ones, that
> >
> > You mean "PFN softleaf PTEs"? Better expressed as "softleaf PTEs embedding a PFN" ...
>
> Lorenzo raised this off-list as well; I'm using the existing text we use
> elsewhere for consistency.
>
> This needs a cleanup that adjusts all of them :)

*like a proud dad of his softleaf name :P*

Yeah, agreed, not a big deal, and easier for me to just do a bigger pass
finishing off what I started :P

--
Cheers, Lorenzo
