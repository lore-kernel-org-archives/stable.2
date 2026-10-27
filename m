Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089505;
	b=0b1HXaMBriwo2LqKjYTHvGs/IycxWvMLmrehZvU8ONHPoysVqhgj/FkdO2itB7n7wNep
	 RBZqEGy6BQpWmyg7ZR6VshLj6bsvrPxO7Fi8fQjmDaF2zzZArYOngLDUkNFS18Zuh54Qi
	 KOZGmYN3DW/AAuJlY4VomyqfCu6qGVcR6MCjSV2oYxXfsKVsQijrxJCEVomcCLmUnM67e
	 zpCGQBuxVvaa4tiJvjej+EChkQ2agY8Iptu8k/8Lf8IJH6jnEeX/w7fc7S8MiMhsM7vw/
	 Z+JYoW+GDQy51HkoS+ysIYtowSRaXA5Od09W/wZp2bpK5aIpWP9iY3zAUllZbfrMfkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089505;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2R51g1GKhJVpEHSsNmeCyBNO0baPm+a+p1RPH1MDDNw=;
	b=GheZHTl+MUGDBR2sZ5rORd2M34a8RYUWOViqAIVaTEAT/c0a66WzCmKGtsgE+zbtHErf
	 EJGtjEte7Bip6d2N55xkSTyq6yCvYKava/OAk+v/wcBuwBIjoWdCpaxgJt+WrA+33k15/
	 M29XHMWfh/gXLlCycVKPReDE9rnJM0LAn3xqLhbmijsoILlUQo2iIaVzw6bZggjlh47AK
	 kH9DwX/9g4qxj5vr1aPpuJApAGO/4BebsU+iPfSA+4L7wA7OuTWTtWQaqZ4qKqR6E7d48
	 B4irYuri+E2Nsdp0RuxSdM45fHXt7Apk0sZfbCK+VAx8TrlQcOB3GiWmbxNrl/mWwyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMCJcnkQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD142606A31A;
	Tue, 27 Oct 2026 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMCJcnkQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4511F01825;
	Tue, 27 Oct 2026 08:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793089504;
	bh=2R51g1GKhJVpEHSsNmeCyBNO0baPm+a+p1RPH1MDDNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oMCJcnkQ2ugmQRTH47VuoA3lVoRzsl34BDT2jKNZ7RUkFZzWRMbYSzo8WR8dK47mW
	 pqOc0eK72lDgDWD3QdHT/pBPnXi7ryj0yWTtmxBWUn+p5DRaD+1S+/Zz1qFJPw0jDt
	 lyPXK9okKJapfC2UEO49ON8OIAwvxBsXfw7kAXbJ0jwSXdgh4Nb8U2On849jV//cVT
	 XlO3MbW2lEPG9jGdLQoIYuXn+vfpx2LaaFHDs6IoRpEheK1ZpsFb3+BVmLglbhci3D
	 +YInIICeV3inpT7BSAzD/puAVkPVByrS2yMaytLjeB9oAMCCDWzd0u2d/tbYp4aR5g
	 N0rWUbD2viZ0Q==
Date: Tue, 27 Oct 2026 08:24:47 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
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
	Youngjun Park <youngjun.park@lge.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 25/46] mm/userfaultfd: wake waiters when registration
 modes are removed
Message-ID: <auBcES74Q5M3MWCW@gremlin>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-25-6f74bec9a5bb@kernel.org>
 <179307782442.2301705.17273288326330283268.b4-reply@b4>
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
In-Reply-To: <179307782442.2301705.17273288326330283268.b4-reply@b4>

On Mon, Oct 26, 2026 at 10:10:24PM -0700, Gregory Price wrote:
> From: Gregory Price <gourry@gourry.net>
> Subject: [PATCH] mm/userfaultfd: compare exact registration modes before skipping
>
> Changing registration from MISSING|WP to WP returns success but leaves
> MISSING enabled. The no-op check sees that WP is already set and skips
> the update, so later accesses to missing pages still wait for userspace.
>
> Skip the update only when the current and requested UFFD modes match
> exactly.
>
> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  mm/userfaultfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 669f71d485d02..0a28130cebc99 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -2299,7 +2299,7 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
>  		 * userfaultfd and with the right tracking mode too.
>  		 */
>  		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
> -		    vma_test_all_mask(vma, vma_flags))
> +		    (vma->vm_flags & __VM_UFFD_FLAGS) == vm_flags)

Would be better not to regress to the legacy API. I realise we don't use it for
backported fixes in general, but this patch obviously won't apply to older
versions anyway, so we should use the correct API now, and this for older
versions.

I'll add a better predicate probably to do this in one go, but for the fix,
I put the correct patch below.


>  			goto skip;
>
>  		/*
>
> --
> Gregory Price <gourry@gourry.net>

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 777bf122d32a..c71cb9179913 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2288,6 +2288,9 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		prev = vma;

 	for_each_vma_range(vmi, vma, end) {
+		const vma_flags_t curr_vma_flags =
+			vma_flags_and_mask(&vma->flags, __VMA_UFFD_FLAGS);
+
 		cond_resched();

 		VM_WARN_ON_ONCE(!vma_can_userfault(vma, vm_flags, wp_async));
@@ -2300,7 +2303,7 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		 * userfaultfd and with the right tracking mode too.
 		 */
 		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
-		    vma_test_all_mask(vma, vma_flags))
+		    vma_flags_same_pair(&curr_vma_flags, &vma_flags))
 			goto skip;

 		/*

--
Cheers, Lorenzo
