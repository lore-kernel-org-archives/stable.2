Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091064;
	b=yDi1ojsMeFKHPkdBRhTsUTGjCrSwVSW1CjUBCH/EAFrMKFsmRxFDqdXuCVov/6M+rJLA
	 avfbu8C/Nd58Ra+vu0DE+VA32mlWbPksRjnfh3m4wgRDVw/S2CthtTrq4Y7UEwqdOQ0hA
	 8GxGDrOQ0yOkwREC8SQvfCG9ytxBSpexhdH3M9zkXKO8h5GCHVHuw8aUzRJQ4AvTMxBf1
	 Cm9RmwHYH8HTt61FIyfnAM8RFICOvu/MygRueHxx8I2jGSPTsVsuweRJW545eGva63fb6
	 VgCAoi/J9KovmI7tdgC358ur+GQD/R4tvms2B2Y8t/K3vPBr/Vo4fGc/F3Al9Qg6dLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091064;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lc0U5Ze+hBCT9T6cAf8QTcqfqTu5UwDLhLRH+Lp9NjM=;
	b=Wv7VLU0jsU37N1Ad0nMmAe33BnXlftjEV6ZHJMHZiaWG3cfFut2wIRXG822YFUBOhyZu
	 t84DMwvaQPbZZ2VhjNJUzyvVfLEIcVofcOPAdPCJ96oOKrSXMDZkV+pfL4585NHkT0P/O
	 UjYUUyhEaQziwlPYuORgcrP91qLXsXrYmEssU034zGR6p+ZcPKb2jXCeQLoFhLjX/QOCm
	 YD2US+zOGjmI9J/jIV+nbvUtxlYG7x5EyHY4+UIokkKGF5ogGdcux5FhN7wAJ7Lw9MaHF
	 4bEHHJaVQk4oVBPQAdV47XcMfPnL7ZECRmtRrcI6Kv+cJbQdlZKDDibDmydXga9l2fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cLX5cty9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FC3606A327;
	Tue, 27 Oct 2026 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cLX5cty9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370ED1F01825;
	Tue, 27 Oct 2026 08:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793091064;
	bh=lc0U5Ze+hBCT9T6cAf8QTcqfqTu5UwDLhLRH+Lp9NjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cLX5cty9Fes4nyGOhdTXTwUi4CjHh2d6Exjv+rOUNmJ1hOpq301ah/59VYJa3KAfa
	 0JAFnIYv5q6uCZJiWZ7/JnzC3pOPhPL5VdEq05fzYEQAfU8x5PjoaLGCbo4oJkSshy
	 aEyuswfa3kOJCEFW345rfcWjsyhvaijqqaHgik6uB7QOrxdB7sJV1oJ6I3Q0c1V+Ry
	 Cf3Ekq4j3MW2BWPpctWVOXD4r4MRy4tI0wpG7A71nGLVk4q5d74j9EcT8h6eyujZ5T
	 xnvfCFG95f/Qz4H2P0ATu2ppTZylFpdC3r3f636dunxIG7AvtZ7dC6rCzDfglAN4g9
	 pK7u8ZerdMAkQ==
Date: Tue, 27 Oct 2026 08:50:46 +0000
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
Subject: Re: [PATCH 28/46] mm/mmu_notifier: set ->mm only after mmgrab()
Message-ID: <auBl3iJyp0RQ-tEA@gremlin>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-28-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-28-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:48AM +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
>
> Radeon uses a non-NULL notifier->mm to decide whether to call
> mmu_interval_notifier_remove() when freeing a buffer object.
> __mmu_interval_notifier_insert() sets ->mm before validating the range,
> so a wrapping userptr range can leave ->mm set after insertion fails.
> Cleanup then tries to remove an unregistered notifier for which no mm
> reference was acquired.
>
> Set ->mm only after mmgrab(), once insertion can no longer fail. While
> we could fix radeon's code instead, setting ->mm on success only makes
> the code more robust.
>
> Fix generated by an LLM and sent by Chris Mason in private.
>
> Fixes: 3506ff69c3ec ("drm/radeon: use mmu_interval_notifier_insert")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/mmu_notifier.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 2e20f88e162d7..a7bae5de5fedc 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -947,7 +947,6 @@ static int __mmu_interval_notifier_insert(
>  	struct mmu_notifier_subscriptions *subscriptions, unsigned long start,
>  	unsigned long length, const struct mmu_interval_notifier_ops *ops)
>  {
> -	interval_sub->mm = mm;
>  	interval_sub->ops = ops;
>  	RB_CLEAR_NODE(&interval_sub->interval_tree.rb);
>  	interval_sub->interval_tree.start = start;
> @@ -964,8 +963,12 @@ static int __mmu_interval_notifier_insert(
>  	if (WARN_ON(atomic_read(&mm->mm_users) <= 0))
>  		return -EINVAL;
>
> -	/* pairs with mmdrop in mmu_interval_notifier_remove() */
> +	/*
> +	 * Pairs with mmdrop in mmu_interval_notifier_remove(). Drivers take a
> +	 * non-NULL ->mm for "registered", so set it only with the reference.
> +	 */
>  	mmgrab(mm);
> +	interval_sub->mm = mm;
>
>  	/*
>  	 * If some invalidate_range_start/end region is going on in parallel
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
