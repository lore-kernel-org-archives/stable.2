Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794909067;
	b=MaWZYSOwROikQzxPh+Es+X49+m+nD1xUEDcG7uObDRKqjsiUaIh/l6yWdtXi5X4TyObe
	 +NeS3XXrWplmfN2V6dBnFmsMFi9zsg8DV5JvU9l33/HG5clL+Z1vrO8EdTUGoFnavNgm7
	 k0Az1Fg2e1xaOzWK7Iy4nOk2LV62jmC8d/mAI25QlDrl00EntTIVRD2R2xwpVbNoKSwmD
	 KYwsy7dsomYnTUqc5S8XDoL3dJwMDfGxFvvrVqOxHD1H6Zg5tSnS0BkQvva3Fb1E15xN9
	 U5yLorBmAuAf+ymOhfdTGu3vCXV0bsYvrDcbnMz8aItFVbfUgjpZ2fJLUbpVLo9Z8sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909067;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=4bnvV/rZOOVemDT1lJ51Ywsx5XqM+V1JviPyoiLh9SU=;
	b=yg50+OvXexaJZLGPcWc9FqpZkXPEfY7Qadifx8DyV0qWH4zY5V6HaX74nbBv83wWa22I
	 x9Ef+9Zuqjev8BtJYRsdcIX9mg+6IH/e9D2lsaJFWjVmcPwfJqtrDMlfIszlssCFMMICE
	 VV0cYvCTrd4GRSoe3vjSq+a5Hl3+axYH85biOiaE5BvDTvs+3VqVjNcg7ulNYsnM/5qyV
	 +rAhuHZ4l4fZSRGbN9u/Vgtp8eyEPn7lizzysyGqMApwHOVJ4UDo7w6Ghpd2mU3BcYmP9
	 bQjmdd2aAo/cVXnVFtL9ogeBljd8cLR5wfvtZA8pyJnPr+pPit6EaTlHg6OPpOv9Fjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDR6uB5I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8696606A32C;
	Tue, 17 Nov 2026 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDR6uB5I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7E31F000C6;
	Tue, 17 Nov 2026 09:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794909067;
	bh=4bnvV/rZOOVemDT1lJ51Ywsx5XqM+V1JviPyoiLh9SU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZDR6uB5IRhncOd0eEWhNfPwu/dfUeJOq/EMTmFTLrYpSAG/2nRkZ7wN7bIGFIb+uv
	 h2al1hZqRTZ1ZknB2rhHxDuIwYYy7ZVHBk4uoX6TCV7D9h79tiL60E9XAe0O0GWOy2
	 FRnHqh+M8L+k5y/ubGQWcOreFh/sYWjoZw/wyWYqih/NmubKDRkAUux9bOa7m+4Ugi
	 f5ZE+D3sxPc4/1qia22+B98S25i5U6GPRtAUwWv2hby+9KyWOKCOXyiFI/d5r/5H4i
	 3JHP2cHQeKu0ZjG7yosoxew6tDXK6+PuHyIYcMfVQn+ZXOv9ghCCm2J3/eA1SsevmC
	 ppDoCzwOue1DQ==
Message-ID: <e971c3f2-e8cf-4eb0-ae25-e7e4d9ea02ee@kernel.org>
Date: Tue, 17 Nov 2026 10:51:02 +0100
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
Subject: Re: [PATCH] mm/ksm: do not inherit ksm_zero_pages counter or PTE
 markers on fork
To: xu.xin@linux.dev
Cc: Donet Tom <donettom@linux.ibm.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261117081821.7211-1-xu.xin@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261117081821.7211-1-xu.xin@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 09:18, xu.xin@linux.dev wrote:
> From: "Xu Xin (vivo)" <xu.xin@linux.dev>

Hi,

thanks for the report.

> 
> As documented in Documentation/admin-guide/mm/ksm.rst, ksm_zero_pages
> accounts only for zero pages actually placed by KSM.  However, the
> current implementation wrongly accounts for forked zero-page PTEs as
> KSM's contribution, inflating both the child's per-mm counter and the
> global ksm_zero_pages counter.

But ... they were placed by KSM?

Just like any other KSM folios deduplicated before fork and then shared with the
child?

So won't there be an inconsistency when MADV_UNMERGEABLE?

> 
> Originally, commit e2942062e01d ("ksm: count all zero pages placed by
> KSM") marked KSM-placed zero-page PTEs with the dirty bit for unmap
> accounting, but forgot to clear this marker during fork().  Later, to
> prevent ksm_might_unmap_zero_page() from underflowing the counters on
> child exit[1], commit 4d6fc29f3634 ("mm/ksm: fix incorrect KSM counter
> handling in mm_struct during fork") kept the child's inherited per-mm
> counter and added it to the global counter.
> 
> Instead of inflating the counters, fix the root cause by resetting the
> child's mm->ksm_zero_pages to 0 in ksm_fork() and clearing the dirty
> bit marker via pte_mkclean() when copying a KSM zero PTE in
> __copy_present_ptes().  With the marker cleared,
> ksm_might_unmap_zero_page() will not decrement the counters on child
> exit, MADV_UNMERGEABLE in the child will not unnecessarily unshare
> inherited zero pages, and the global counter remains untouched.
> 
> [1] https://lore.kernel.org/all/53a7bf3d-843d-4e19-b0a3-cc6852fe72c1@redhat.com/
> 
> Fixes: 4d6fc29f3634 ("mm/ksm: fix incorrect KSM counter handling in mm_struct during fork")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Xin (vivo) <xu.xin@linux.dev>
> ---
>  include/linux/ksm.h | 8 +++++---
>  mm/memory.c         | 8 ++++++++
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index 93793ca6bcc4..3c6db19d825e 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -56,11 +56,13 @@ static inline void ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>  {
>  	/* Adding mm to ksm is best effort on fork. */
>  	if (mm_flags_test(MMF_VM_MERGEABLE, oldmm)) {
> -		long nr_ksm_zero_pages = atomic_long_read(&mm->ksm_zero_pages);
> -
> +		/*
> +		 * Child's inherited zero-page PTEs are unmarked on copy and
> +		 * were not placed by KSM in the child, so reset its counter.
> +		 */
>  		mm->ksm_merging_pages = 0;
>  		mm->ksm_rmap_items = 0;
> -		atomic_long_add(nr_ksm_zero_pages, &ksm_zero_pages);

So I think there is definitely a BUG int he existing code when we skip copying
some VMAs during fork. We should have instead adjusted the counter as we
duplicate them into the child process.

> +		atomic_long_set(&mm->ksm_zero_pages, 0);
>  		__ksm_enter(mm);
>  	}
>  }
> diff --git a/mm/memory.c b/mm/memory.c
> index cf075fcec3c5..7dce96af2a51 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1160,6 +1160,14 @@ static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
>  		pte = pte_mkclean(pte);
>  	pte = pte_mkold(pte);
>  
> +	/*
> +	 * Clear the dirty-bit marker on KSM-placed zero-page PTEs in the
> +	 * child so inherited mappings are not accounted against the child or
> +	 * unshared by MADV_UNMERGEABLE.  Special PTEs always have nr == 1.
> +	 */
> +	if (is_ksm_zero_pte(pte))
> +		pte = pte_mkclean(pte);
> +
>  	set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
>  }
>  


-- 
Cheers,

David
