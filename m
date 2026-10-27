Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793093873;
	b=aeHOkC/Yfe64jx/ScyQz2PfyXpM248QI9grfdHytW89ZVDadGSwt4Jecsin3WfJbzFkK
	 ENbhKvEJyfCnaenYHAapJ5ALB2iTYRnNk+srHd2IBkq/BR/40R782dmc/qIHEKz8XVSl3
	 JZyyK48sVLoX29oLhXVY6ixipjQEToLNf7OCoTRdj+q1L/r16/3oYYcvGXsWqIPQSHSYt
	 1zdz4UHGm9cfkanQSYmXNDKPcNKo6loJJnAnTdLW0Keg6vuE3Bu+9xOiF/XIZp1WwblS6
	 QVstsT2vlwH0MhKnNiGrTKMFphVgK2wcax96gjWhhjAY9BZlKLaDBMqSy+3jcU/IhEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093873;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+rNSdhvOTHmuEN3Ml/bfsrTqF8UwvJdcqDi4DNQ6sTg=;
	b=BNoowM04eRTfOb4kDWjStN1Nj+6UGSUi+P6MjFiL0K9185ewYg+VJIXR0tSg0mEgPXnH
	 vKVkKXMOkgCHkP+T5v2zoHstMUm2BLVakzktGRDpg9vZlAn0frXbv9UkIIWlV/B14ttwz
	 wDsUXca9zHJ4Rwc36S4ci2FEhwVVYj4iXvgzcVkGBAaF+fY66SIipZHQI3gsJ4h0j8y/4
	 GloN0f3T1gMCtwTB629hgrrTOFuBSyP7wV1erZZKHynXza5TUr+yWtMQdgDS9JuzaVRjb
	 0jqDia9C6mmHjqpAYdtdOky+Y/JDw+l87lQuc27vOXS7Xp0ZRNXn6kppVwqItRDKjAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7+fBT3l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781F606A31A;
	Tue, 27 Oct 2026 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7+fBT3l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490C11F01825;
	Tue, 27 Oct 2026 09:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793093872;
	bh=+rNSdhvOTHmuEN3Ml/bfsrTqF8UwvJdcqDi4DNQ6sTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U7+fBT3lehpQpFc3uJKZHtVpRgi1GtGHT6z3b8kE2S6FeF6bFDBDYsG/DhyOz1wlU
	 gkZvgV/b8GwC5hBF2vuMNqTpih+mBOGm/magVJ+5tlmYMUc8rC0HgDbxkq4C2ZdX7/
	 ykFSl8AC+Hlev3LyWJ5Ey8IgtYvUDz6NSxnqxhKKoOE4gmRJYKRD4ktRxpkFHa/N0B
	 GZx6g/C9Es4dpnIsGGa84PHZ4w1B6j/LHsH9niHHf9ry4zHK8ev9PN5ziVl0zIXEG7
	 p4yl/pvZrQHfp2KrQDErkAMPWJNescqIgRyziMHz4MrRviwMpP912C23Dpz/85S7eu
	 i5GpXe5pXwalg==
Date: Tue, 27 Oct 2026 09:37:34 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
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
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
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
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 21/46] mm/gup: fix out-of-bounds write for nr_pages == 0
 in GUP-fast
Message-ID: <auBwudfT22AZ82GB@gremlin>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-21-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-21-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:41AM +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
>
> With nr_pages == 0, GUP-fast still enters its page table walk and can
> write past the caller's page array. The old end <= start check caught
> empty ranges, but was replaced with an overflow check.
>
> Users such as OrangeFS can pass a zero page count derived from a
> userspace-supplied length. So let's return zero for nr_pages == 0 before
> starting the walk, just like GUP-slow.
>
> Fix generated by an LLM and sent by Chris Mason in private.
>
> Fixes: c28b1fc70390 ("mm/gup: reorganize internal_get_user_pages_fast()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/gup.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 47e7ae152cdf1..9906965893431 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -3204,6 +3204,9 @@ static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
>  				       FOLL_PCI_P2PDMA | FOLL_HONOR_NUMA_FAULT)))
>  		return -EINVAL;
>
> +	if (unlikely(!nr_pages))
> +		return 0;
> +
>  	if (gup_flags & FOLL_PIN)
>  		mm_set_has_pinned_flag(current->mm);
>
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
