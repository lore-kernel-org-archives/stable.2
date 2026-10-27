Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793093714;
	b=h6UJMK2cPqdXf8ByNak/jbR6WI4EugLaxqWzyr/SdqP3uZSsxh9Y6iLeabf0ZDUuXrWc
	 kzngXoHtp6GvfV3JAvfNSG0J4HHddeiMUm/vIZ8T3j0WDECZL5gWKDI4xmk7DFj+Mi/5j
	 V828LIMJ69GuT9wXzr4mWiPIbJjLDs1rcUGAnfF9Q0redEyinkF31v2bvJVBbeOrqJLb9
	 tldwHZ+HBDwdRG5+GvHppdKMgYpuuX/sKHg6qtdnh3b7WbknNFCBziSUsf/JSe3FMb0VQ
	 F4pJGvkz3feuqfhBjI+XHDeGqREHhITjwRZawqoZsSBAgUeSLmPcvX5y5ojmUARxU1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093714;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GyDf/T3A99e/UK5Tx0KKev7xPaxEfXMruyrCYj6de1U=;
	b=DTY4v1B4gKBqK+X/BbJSIXEcwwlGhifuZd4ef7t6WbM32oSsOcY6G/v0s9Qhh+f4D0Zn
	 0n7ZrkALb5hx4MPmoWq3uGQreSsmHQ8sd6gj+Tj2C8Pl1eFFsxakFAKzSGp5g4MgePnRD
	 5pl1gzRvuZUK9i8tmkukoN7Dk9Z/BiqUfrJ4vGU6CzGF3wZm0jz2TEl1yYo+7hg2rkHCv
	 K46e9JLB7HvlvRCHUImNBZ8KgfZbcLNKt/cO1CbqjNaPGLzyUDhgOAzw+Erva1QQsoL9m
	 DZ6iGPCEs9o2SXpm/ToSZHN1NpQc2dVpCjll5t04T6UqKO8x6CuB0nFTKqGJdX921pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3V2ir1f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08428606A322;
	Tue, 27 Oct 2026 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3V2ir1f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD641F01825;
	Tue, 27 Oct 2026 09:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793093713;
	bh=GyDf/T3A99e/UK5Tx0KKev7xPaxEfXMruyrCYj6de1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z3V2ir1fhLjLEOG38tPqPyKd7K/FHGfPC09OfR7eOlE/pdqk+8s3kVa1i4DQbH+Qx
	 MZ32NLc7julvf25Egjxt2K1dVEewhL3Of9L8IHSEkMikSMuPsfkdtPqT3BAFRQIx4l
	 I2aocqwSNzVOB8HXoD0iEYYGXcOv8ZXfRuVth/j1TS6G/Q38VWONKl+4C7n5MEPxNA
	 MdDQY8Y20j6O/Wno2AqROjn/Br7ZnF59rm1EwFzdyTg2TjL0F8dx2lgZTIglHC5tyA
	 DHYvTnMV0DHzDPWwpSElNE8EW4/oPBEyMA8Gm39jeV4/zgUOyB58UgoLt0XQBoz9Do
	 0CxG7SV58ggfg==
Date: Tue, 27 Oct 2026 09:34:57 +0000
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
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 22/46] mm/gup: check for overflow when converting
 nr_pages to bytes in GUP-fast
Message-ID: <auBwBYzcs-segDVk@gremlin>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-22-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-22-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:42AM +0100, David Hildenbrand (Arm) wrote:
> The overflow check in gup_fast_fallback() only covers the addition to
> start. The preceding nr_pages << PAGE_SHIFT can already have truncated
> the length on 32bit.

Insert rant about 32-bit kernels here :)

>
> Users such as RapidIO's rio_dma_transfer() can derive such page counts
> from a 64-bit userspace length.
>
> Let's just check_shl_overflow() to reject any such overflow with
> -EOVERFLOW early.
>
> Fixes: c28b1fc70390 ("mm/gup: reorganize internal_get_user_pages_fast()")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/gup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 9906965893431..48e1bfe5ab9a9 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -3214,8 +3214,8 @@ static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
>  		might_lock_read(&current->mm->mmap_lock);
>
>  	start = untagged_addr(start) & PAGE_MASK;
> -	len = nr_pages << PAGE_SHIFT;
> -	if (check_add_overflow(start, len, &end))
> +	if (check_shl_overflow(nr_pages, PAGE_SHIFT, &len) ||
> +	    check_add_overflow(start, len, &end))
>  		return -EOVERFLOW;
>  	if (end > TASK_SIZE_MAX)
>  		return -EFAULT;
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
