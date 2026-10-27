Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089084;
	b=4R0dOycmzI3KY+wP61IjivM1NmBRs+k+3KFZxCR/BihGrtnTVsm9K3fOVtNgesFT6rhm
	 ti1lz9ZMz0p6OtcXc4vyKyF7UFxFzTusOfFbSqlVKIvoaAAVxBg7HeV1xIySqcxWCaa6k
	 vHyyxY3QAPGeW28O505joRGi40WjcGZUBmgcRlt1Dnp1PMpAlu40DPLPZBdbUCbqpPmEv
	 WPIzqt0lIOMqj8TvDnEP4I4alNVEDjeY0s2NF0DAY73D40TlxhQhcKEENlVbw7NTAwdSY
	 eIRzNTy1PD93b2YLz6LY4FlD0Gx5PFMQxxQmfwddClwbKYhk/hVOz/GWvgdrVUPtcRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089084;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=D64FFgpc7INZHjHGIMuz6fOYnjN+R/6alnjku+MmCwI=;
	b=5WYcosjOUjDp6i17GqjkRElD8kA/jnx9OgcWLJQxL9jq5yH8qP1Dk8oZEbCIer3mz2Lp
	 kAOgZn4Uefm1iOhO6p6WIjvH4GnYNNBGM1fzpGGUC6NQvR1GrFENPIT14kJIqHV1vcvcH
	 amT5oe3RpDBh8YRJ8frT4yjkCx5CeMicpvCDx9/vay1vbxcryYricw0X6gwuj054Z7VP1
	 v5XASiYuqGCoRhx0k6J62Ow3+H2V/IflrGtnX3DWNNE/u+e4MakvMr+eiyfuUU6E21NIm
	 4z5+tpuFIvepnS7Gjt135c3cghfnPnF6/1dR37NERlNfDzGJ5hM/w2k7amxhrHaawLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lrkj80Hq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D65606A320;
	Tue, 27 Oct 2026 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lrkj80Hq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8565F1F01825;
	Tue, 27 Oct 2026 08:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793089083;
	bh=D64FFgpc7INZHjHGIMuz6fOYnjN+R/6alnjku+MmCwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lrkj80HqsRK7SmEUA0UlfQ9awwfrnZbTGOTFJ38sN0K5sYRFKCiWceFy/zEcA5N7K
	 X/+Ja8dZnecwCLwqQW2Q53xYQZvfTTZvXc/UlZpQ3ww44q5sovpt7pTsmVFSsALwmW
	 con0FeRikx0qegOPeuI08/JqIvHO7h8RUPar2Oksdd8psB92RcYHO67CJO4Oifo4bl
	 4OdMIpYuvOM127oapLRHduPwvwZb4shBXArXcUwWQ3OGDl6t28H8bKbs77c3ilGNzD
	 RxpfugSOkHtwZ9bqmFJhB2XCngY1YfFKNWjupoESw2HcBJREXTXw0o5pJ9DqJ4U+FM
	 VgHlaWwITa29Q==
Date: Tue, 27 Oct 2026 10:17:41 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Alistair Popple <apopple@nvidia.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Youngjun Park <youngjun.park@lge.com>,
	Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 24/46] mm/userfaultfd: wake all waiters on unregister
Message-ID: <auBeJeLTUg4VlHjc@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-24-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-24-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:44AM +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> UFFDIO_UNREGISTER only wakes pending faults if VM_UFFD_MISSING is set.
> Threads waiting on write-protect, minor or RWP faults can therefore remain
> asleep after unregistering a range that does not track missing faults.
> 
> Wake pending faults regardless of the registration mode so they can retry
> without an explicit UFFDIO_WAKE or closing the userfaultfd. This matches
> the existing behavior for missing faults, including removing unread fault
> messages for the woken waiters.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: rebase; simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/userfaultfd.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 7e30b5ff17be1..2122676c4220f 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -3977,6 +3977,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  
>  	ret = 0;
>  	for_each_vma_range(vmi, vma, end) {
> +		struct userfaultfd_wake_range range;
> +
>  		cond_resched();
>  
>  		/* VMA not registered with userfaultfd. */
> @@ -3994,18 +3996,14 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  		/* Prevent new userfaults from being queued after the wakeup. */
>  		vma_start_write(vma);
>  
> -		if (userfaultfd_missing(vma)) {
> -			/*
> -			 * Wake any concurrent pending userfault while
> -			 * we unregister, so they will not hang
> -			 * permanently and it avoids userland to call
> -			 * UFFDIO_WAKE explicitly.
> -			 */
> -			struct userfaultfd_wake_range range;
> -			range.start = start;
> -			range.len = vma_end - start;
> -			wake_userfault(vma->vm_userfaultfd_ctx.ctx, &range);
> -		}
> +		/*
> +		 * Wake any concurrent pending userfault while we unregister,
> +		 * so they will not hang permanently and it avoids userland to
> +		 * call UFFDIO_WAKE explicitly.
> +		 */
> +		range.start = start;
> +		range.len = vma_end - start;
> +		wake_userfault(ctx, &range);
>  
>  		vma = userfaultfd_clear_vma(&vmi, prev, vma,
>  					    start, vma_end);
> 
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
