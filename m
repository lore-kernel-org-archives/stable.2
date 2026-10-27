Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089008;
	b=zJXEvYE49edRoCeY+vK+7Z1UYwy000o7pT3McSnROEEYs0BjU4IpZwydEpirvGeheMbd
	 xpfi8fgu9FqrbizWa/QgHzanigfQ0o6ZmII2SqFv+oHgfxrOdQQzQTkUchFhFRxBEXTa6
	 kJnGtmClCDmJT9h3LmgMdIqF1UzmcesYOLxemk36U1pf47l5TMdSZ3gpL5MJ/9q7NdNQS
	 0ui1ZkkfvaBwKQAY9HcTeGlAUvwvFy3S6Qtg6yB/rJhRBBT3v4qT71msOcyQ2245Ov4v1
	 TeWJi5IBiqb8+VlTFWLucn8nvQL837EViQTIUC6QjUSjjXXAp2rhRMnmhzS3QHYpI9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089008;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=25JoUd0Ca4DSucyqp8VdpaHvYyD4L6ugc8HcJwXmagI=;
	b=TsqjEmTxTtNdn9KrUJ34+Dk3iynC1OCRoK54pI/OoWcFY6UUF0MxnMsCfplIFkwzCOo3
	 t4cLNFuRj/UAhGnBb+6CXlI+IOakgvcQierxhybUCizN4BsyZYb6siI0hCsEAVIcOxXNP
	 A6jeOwnVYhdSbJ5zbZviZqf+3enz58VuZk6yKn7L7cYQHuBStGd71R5QxwEcGTHY6rMrc
	 yxPJvzpwKq3AdSsAEGRX7vQ5vxuTdfk7/6/HBYc+cmBEPC56DHMqn5WKgj9Gv5JI97A+H
	 Q4yc4ApVhflwIn6rKU7nM/Aui6GDBvw+YSJV4WoO/oomtpcsI07byCHDHao/i/o4Txg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DqgW1ogH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52733606A31A;
	Tue, 27 Oct 2026 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DqgW1ogH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6EE1F01825;
	Tue, 27 Oct 2026 08:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793089008;
	bh=25JoUd0Ca4DSucyqp8VdpaHvYyD4L6ugc8HcJwXmagI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DqgW1ogHskC3KjpnvkmfF/B2DYXhDZoPDNeziDRz5NYseOTPq/Bt3d/gR2uwOi5tt
	 l0FKm0+vSEXyriWPhPAPthXH1Up+UF+85+8a4DRAWSbZRYMnvjqZUBuxtSS9VhexcH
	 QjEToIVl39sflEhmYe9ziXX5NCu06RELjf5E7IRB4kHtHZXSvXfgKEoP26dOW1+9IE
	 ffVmPh+WFa/36AqcOLOz1lEuekRW0rjPES5+SXPWLU9gfjD0+35/LrvlH8duWv+GbJ
	 RuWAou4+YDgaZUIhlBwjRnVkYYWwTrj2jlqPucPxJ4gaehaWDjNNziTUjRRUgWOZSb
	 cgzDt4LnM1kJg==
Date: Tue, 27 Oct 2026 10:16:25 +0200
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
	linux-cxl@vger.kernel.org, stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 23/46] mm/userfaultfd: write-lock the VMA before waking
 waiters when unregistering
Message-ID: <auBd2RS7buo-Aa5I@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-23-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-23-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:43AM +0100, David Hildenbrand (Arm) wrote:
> userfaultfd_unregister() wakes pending missing faults before clearing the
> VMA's userfaultfd registration. With per-VMA fault locking, holding
> mmap_lock for write does not prevent another fault from queuing after
> the wakeup but before userfaultfd_clear_vma() write-locks the VMA. That
> waiter can then remain asleep indefinitely.
> 
> Call vma_start_write() before waking waiters. Existing fault handlers
> queue themselves before dropping the VMA read lock, and new readers are
> excluded until mmap_write_unlock().
> 
> Fixes: 29a22b9e08d7 ("mm: handle userfaults under VMA lock")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/userfaultfd.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 669f71d485d02..7e30b5ff17be1 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -3991,6 +3991,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  			start = vma->vm_start;
>  		vma_end = min(end, vma->vm_end);
>  
> +		/* Prevent new userfaults from being queued after the wakeup. */
> +		vma_start_write(vma);
> +
>  		if (userfaultfd_missing(vma)) {
>  			/*
>  			 * Wake any concurrent pending userfault while
> 
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
