Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599124;
	b=ebnAEsAZzK+sPOv2uDxc7MObjpYTldThPk7Bm7UHh+i6XZQECYasY9bTw+EE5AGAPBQ8
	 hkUp/iTaLtQCkwd+QckdNJNkDJMiAkOBhpymX//Ykwa1bVd7nR0xCQfaD9I7GYhRjyeHc
	 hz1x9fzIbOs0UKhHiKIYm3QUoMati013qW9BSwUIBmf2TPVjAhmdZd02mRAcNA8jEHFtZ
	 HJuuzM7BEEVUiTEfUEWT80huWCw0n7rYp0/6GhtSJB/4X0q00l+S1sGn+XM3GeCoZViEH
	 jq1lAGTeqEEy023TivSaTsVCSuWOeEStypcjPLWoBp949Ar5joF0ipxtUPft7fyO4/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599124;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=gjLy+MNfOWSbu5NtI+C6mzKEH0S8YN5kvQWQs6kfrkc=;
	b=Q1ikH+MyIv5OpbgTihzexTLtIop8JJEkJOF5LEk9mAuhKmnz7U+tf1/U+eTBrmBEMCXF
	 5o294EckSPJ9NoeV1BO+MC4zUXrkDemxZqJUZljb2cErlOEVvaGxq8Qjcu9nzx284Xkgq
	 6hspP1UkZQSz/CGLZaYYjdsCZQG4SiLsc7QsAxTUYiK/TbbpoieGIoLgL397x6borPRWI
	 bFO51AF2ZmtwqqSYHGw6nRZsQR2RGf2bPQsC7ENk6VFtMynt/Ehkbupa9NW7zl908cSlz
	 k51WuHqO1WNSvlPF0rCJpuOIeRljPYJBqByuoOOqKuR5XKHdDhiUC/8ehcbS/eKkXhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=YzISiqkl;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CCC606A330;
	Fri, 13 Nov 2026 19:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5CCC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=YzISiqkl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gjLy+MNfOWSbu5NtI+C6mzKEH0S8YN5kvQWQs6kfrkc=; b=YzISiqklc3XmZrEQ4ktPVVJEkp
	Cs6TrBIfJSI5GVzQaJ/BxOH7V9mOe6ECuhT9tR991M71QRZmMQbRkr3h5jYRETRQ1/NqAtljElDZy
	ZK3Yn97v5vfAfW8turrQxs3YL0t2dKfAcAxEDEFgaQqKOpnyfIK+wlJltQMRvfKjQct8kqa5cBPSu
	3/qdKKUa6v4PQrDIpsV+MzoTrOqFsqMwJwWHol9uio29w4LKmd2+5PbypGIl0kWmmAJ8SlOjzRxrL
	nO+exbnLtFOurhTYJxZVDL2lXdeoETe9g1o7Kvf6PjbPLnlZ8Mhcx7fBSgFEk5Yi5tP+rgZ+DQEj2
	Z9VNHkUw==;
Received: from willy by casper.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRxCo-000000052Uc-0jPI;
	Fri, 13 Nov 2026 19:45:02 +0000
Date: Fri, 13 Nov 2026 19:45:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-arch@vger.kernel.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org,
	Chris Mason <mason@kernel.org>, stable@vger.kernel.org,
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v4 1/9] mm: limit pagecache folio refcount when mapping
 pages
Message-ID: <avdovRTVITLwuit_@casper.infradead.org>
References: <20261112-refcount_overflow_stable-v4-0-ad3deef0bd23@kernel.org>
 <20261112-refcount_overflow_stable-v4-1-ad3deef0bd23@kernel.org>
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
In-Reply-To: <20261112-refcount_overflow_stable-v4-1-ad3deef0bd23@kernel.org>

On Thu, Nov 12, 2026 at 11:53:20PM +0100, David Hildenbrand (Arm) wrote:
> Being able to overflow the refcount is not really big news, but it's about
> time that we do something about it because some modern technology might
> find ways to abuse it :)

Yes.  My primary worry is actually it finding a path where we forget to
put the refcount on a folio and that gets exploited into a UAF.  I'm not
sure the "reserve for root" aspect really helps recover from that, but
I'm not too opposed to it.

> As a short-term solution, let's introduce two folio refcount limits:
> one for ordinary consumers and one for admins. Leave some headroom
> before the refcount goes negative, which we really don't want (having
> the mapcount go negative is also not expected).

I don't think a negative refcount or mapcount is really a problem.  What
matters is that we don't get to zero from below (for the refcount)
or that we don't get to 0xf000'0000 (for mapcount).

> +/* Leave separate reserves for administrators and concurrent reference gains. */
> +#define FOLIO_REF_COUNT_LIMIT		(INT_MAX - (1U << 26))
> +#define FOLIO_REF_COUNT_ADMIN_LIMIT	(INT_MAX - (1U << 25))

I think these specific values will generate bad code.

> +static inline bool folio_ref_count_over_limit(const struct folio *folio)
> +{
> +	const unsigned int ref_count = folio_ref_count(folio);
> +
> +	if (likely(ref_count < FOLIO_REF_COUNT_LIMIT))
> +		return false;

I would replace this with a simple signed comparison against 0.

>  static inline void folio_get(struct folio *folio)
>  {
> -	VM_BUG_ON_FOLIO(folio_ref_zero_or_close_to_overflow(folio), folio);
> +	VM_WARN_ON_FOLIO(folio_ref_count(folio) <= 0, folio);
>  	folio_ref_inc(folio);
>  }

And I would drop this hunk.

> diff --git a/mm/util.c b/mm/util.c
> index 80f6c714844f2..c9c3dc4b490fa 100644
> --- a/mm/util.c
> +++ b/mm/util.c

Now we have mm/folio.c, I think it should live in there.

> @@ -791,6 +791,32 @@ int folio_mc_copy(struct folio *dst, struct folio *src)
>  }
>  EXPORT_SYMBOL(folio_mc_copy);
>  
> +bool folio_ref_count_over_limit_slowpath(const struct folio *folio,
> +		unsigned int ref_count)
> +{
> +	if (ref_count >= FOLIO_REF_COUNT_ADMIN_LIMIT)
> +		goto over_limit;

Maybe let this go up to 0x8100'0000?

> +	/* Background threads must not consume admin reserves. */
> +	if (current->flags & PF_KTHREAD)
> +		goto over_limit;
> +	/* Neither must interrupt contexts on behalf of the interrupted task. */
> +	if (!in_task())
> +		goto over_limit;
> +	/* Capability checks are not safe with IRQs disabled. */
> +	if (irqs_disabled())
> +		goto over_limit;
> +	/* Use the task's credentials, which filesystem overrides cannot change. */
> +	if (has_capability_noaudit(current, CAP_SYS_RESOURCE))
> +		return false;
> +
> +over_limit:
> +	pr_warn_ratelimited("folio:%p refcount:%d mapcount:%d mapping:%p reached refcount limit\n",
> +			    folio, (int)ref_count, folio_mapcount(folio),
> +			    folio_mapping(folio));

If it's worth doing folio->mapping, maybe also print folio->index?
In fact,

        pr_warn("page: refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
                        folio_ref_count(folio), mapcount, mapping,
                        folio->index + idx, pfn);

might be worth pulling out into a mini helper from __dump_folio()?

