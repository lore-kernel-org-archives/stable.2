Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089112;
	b=1dnD2IDcgSPtHur0pXhMTY+fhcL6+PeaUqDZZxdiPzosZfm9vD0kRM7WE/0OlkzBDnJu
	 Dwm8WejD8SoY1zL5YjQBXjx6Ms9knA6s88yowgQ6+EkeMJIhhBc4rXgdRFDBiVg5WVVGo
	 lAZtFQKyHpYXh3K0h66pQi+eqC1SXliQFsMBh/IjzMNFmroSFyDY8sF8QBJz+YlLGbYoE
	 CChGRnUU2OwQ+TXSryUdkpCMXWB+L856DGGneViHjhCp6lUtk88L26aG9iKuCPdKwP9/l
	 CT+01fB5Ixu6qAaYmCsWLA7jz32UXoMA/JrqgES2Bw2KVhafyqNMUb/8ViX+Vl4Iy/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089112;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=nNaIZxw7IJwq2m4pWciWh2XxN6fAoF3MaHnk6xQdZpg=;
	b=bGIzd/qKJwFd0pFIkzZPDE2aU5r57tb9we0wgJk14p69+jsbTNkMabn6fakNbx4qh2gS
	 Ifu7u95qwXGS6pmjhhycdV9nrWW1Zw5PCAs9LMsaHzPnu9mWG+RwntYbz3M/q25hdAC/e
	 UYLcXIaAwvE+V0YYGkJTLzLObd0PDSIIv4eJsIk+dYpSKo1pPkT5MSeHkl6NLE3MEiNQH
	 L7qyRiKfOIdcGBguLH4OXh1bW7i+D/QEod8cHv5Dd3tVU7DkCHxJOIHgIf/p8q81BANNF
	 0DZlK/quL2ZP5+i8fMcvf3m/SbHRN/G5W53RL+ysHSjYkGZNj/oMvw0pTVSZWYpZBVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wv3U0m6b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8EA606A31A;
	Tue, 27 Oct 2026 08:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wv3U0m6b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B831F031E2;
	Tue, 27 Oct 2026 08:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793089111;
	bh=nNaIZxw7IJwq2m4pWciWh2XxN6fAoF3MaHnk6xQdZpg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Wv3U0m6bdgC/XJfyU+UtzFda0UzsHI2oo0g4dnEd+2qDka1hYTubK9xs0MQzM9/F0
	 opyHLijkCDkmc8Mh+eubcuUH5IIQw7FQ57YIeoVk2vtL2c8SLhkAM2sEN5RrIVG82g
	 vZFgBHOItm2xTVdpXD6UR0Y2J086AC2XOHEA4tb8/7+2E4YmocW8HQMv6IqKYrsRJ6
	 5a4wR9IokX1zaLZbOiosOyesIgcRW0AKO/LM9Pil1p7dFG/hxasDfp9LqVi1nNSOA2
	 rSW6MrTJlqnaDuJa1/fKNJL/ySGmhch0vv5ME7OJAcHm2qqoxgb0HnUXS2cIi9pWA7
	 rfVDzIU9g5xaA==
Message-ID: <d53e610e-83d5-4504-a9d2-358310f69b4a@kernel.org>
Date: Tue, 27 Oct 2026 09:18:18 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/46] fork: take mmap_lock before copying mm_struct
Content-Language: en-US
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>,
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-2-6f74bec9a5bb@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20261027-fixes_core-v1-2-6f74bec9a5bb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/26 00:17, David Hildenbrand (Arm) wrote:
> dup_mm() copies the parent's mm_struct before dup_mmap() takes the
> mmap_lock. A concurrent brk() can leave the child with a stale mm->brk
> and newer heap mappings, causing later brk() requests to fail.
> 
> Other operations (e.g., PR_SET_MM) on the parent's mm_struct can similarly
> cause inconsistencies.
> 
> As a simple and robust fix, grab the parent's mmap_lock earlier. This
> way we don't need to update individual mm fields in dup_mmap() and
> keep missing ones. Stop updating the 4 existing members (total_vm, data_vm,
> exec_vm, stack_vm), as that is now no longer required.
> 
> Keep releasing the parent's mmap_lock in dup_mmap(), before
> userfaultfd completion, to avoid moving the userfaultfd handling into the
> caller. This should get cleaned up later.
> 
> Move uprobe_start_dup_mmap() to preserve the lock ordering.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  kernel/fork.c | 20 ++++++++++++++------
>  mm/mmap.c     |  8 +-------
>  mm/nommu.c    |  2 +-
>  3 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 22eaf5fb844d0..c8948cadccf71 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1532,12 +1532,19 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
>  	if (!mm)
>  		goto fail_nomem;
>  
> +	uprobe_start_dup_mmap();
> +	if (mmap_write_lock_killable(oldmm)) {
> +		free_mm(mm);
> +		goto fail_uprobe;
> +	}
> +
>  	memcpy(mm, oldmm, sizeof(*mm));
>  
> -	if (!mm_init(mm, tsk))
> -		goto fail_nomem;
> +	if (!mm_init(mm, tsk)) {
> +		mmap_write_unlock(oldmm);
> +		goto fail_uprobe;
> +	}
>  
> -	uprobe_start_dup_mmap();
>  	err = dup_mmap(mm, oldmm);
>  	if (err)
>  		goto free_pt;
> @@ -1556,9 +1563,10 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
>  	mm->binfmt = NULL;
>  	mm_init_owner(mm, NULL);
>  	mmput(mm);
> -	if (err)
> -		uprobe_end_dup_mmap();
> -
> +	if (!err)
> +		return NULL;
> +fail_uprobe:
> +	uprobe_end_dup_mmap();
>  fail_nomem:
>  	return NULL;
>  }
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 148ba01c03739..7618e72766a52 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1713,8 +1713,7 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>  	LIST_HEAD(uf);
>  	VMA_ITERATOR(vmi, mm, 0);
>  
> -	if (mmap_write_lock_killable(oldmm))
> -		return -EINTR;
> +	mmap_assert_write_locked(oldmm);
>  	flush_cache_dup_mm(oldmm);
>  	uprobe_dup_mmap(oldmm, mm);
>  	/*
> @@ -1725,11 +1724,6 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>  	/* No ordering required: file already has been exposed. */
>  	dup_mm_exe_file(mm, oldmm);
>  
> -	mm->total_vm = oldmm->total_vm;
> -	mm->data_vm = oldmm->data_vm;
> -	mm->exec_vm = oldmm->exec_vm;
> -	mm->stack_vm = oldmm->stack_vm;
> -
>  	/* Use __mt_dup() to efficiently build an identical maple tree. */
>  	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
>  	if (unlikely(retval))
> diff --git a/mm/nommu.c b/mm/nommu.c
> index ed44510e37707..6e0f9c7da2364 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1926,7 +1926,7 @@ subsys_initcall(init_admin_reserve);
>  
>  int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>  {
> -	mmap_write_lock(oldmm);
> +	mmap_assert_write_locked(oldmm);
>  	dup_mm_exe_file(mm, oldmm);
>  	mmap_write_unlock(oldmm);
>  	return 0;
> 

