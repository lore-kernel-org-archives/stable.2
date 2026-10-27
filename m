Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109816;
	b=zOmvQyIT4adBHDGZcQuoTwHE8nkKceEaWN4gY2VKeNh+yxs7grIRDuIocLOy7r5+D4kq
	 OiSovS3OKx9TPUpOZx3mMBtDrDZ3+ZI3z5wHqWcuha56qsYiAPzsum17VkQsHJvcDUHI5
	 ejJw1gFpeZzvD1IaedLkNhW4gb/EQteNTE4MbvZzqQ4PDyLeZDhv3uC79PkslYaJo9NMI
	 6Rw3xS+JX4TKBJe54tOuAN9o0tHzYs0K8lqsWVPoPnsumIIOIGBJUVBzuBhNwgiSGIi1k
	 qME7lXlj1pAkDVeu2cMKy2T8GTY6mjbfK9crxP30mgrFW3O2kqyPPt08JAHGgIyL9EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109816;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=H7+62nSvr3logypM0kC8CKxhrNR+3HtbHXcVAr7jUl8=;
	b=rc3rxC3dS+nQ/z9m8Z5O8SQZr+3lc4of62A3yJ6pukpLSJCjR/nc2e8DyB1UnzVl5W9d
	 USQYd+9gG3tQjLTzHerwRMBQ+vjSKblJSr7Y0JqfoXrkpWZJmC0w620D/ZD1CMAHMNDoP
	 dGBM1h/DwBA0GkIpJqK5qu8fNNENLaupEAnxNyobYtI1wt1zKCKQ+IyMygwgqOIsMn+6g
	 MLw+4XXLCrdebAPv2lqgI9i46tlIx6a8X6tKKDB5H91p0bQV7k3za7+q28OQ7l9FMyWko
	 NKvde1o1bOBSh6gVBaBxN3gVKwobfxHaeN6qnoeiLYYOT4F3pMoA52pdoLkodxj91LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o3eDX4T0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11829606A329
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o3eDX4T0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778201F01825;
	Tue, 27 Oct 2026 14:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793109815;
	bh=H7+62nSvr3logypM0kC8CKxhrNR+3HtbHXcVAr7jUl8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=o3eDX4T0rpxCCMFsMX5Uwkd50yBNb9chbe0AZx1MED/SRMSafPsJIkc8Zm8hPSFnn
	 OcVKFE0h/qu7zcraWe2Fc2dBEWYSGeL9fH1q0VpuW7MEWuu9qzkqOin0xdLQv0yO66
	 j9gOtm5KoTZuNqOorCM1af4Bc8bIXRviypIpGKZKgzQcdcnVvG6lFksAYi1TAJZcr5
	 4T+rrW7kaMs+gPGXWVetjVPmrcXdDiuPdtyZdB+ShAy5Ng5dQqpuwBFTVRcOFwX8H9
	 MwP/Tp0iarGtbGhGBZCDFOlN7fIo5a8iQDnSW9lWitM4M4CrEHoezzZ54YSbpUTyhk
	 TXGGHrXO6DGDQ==
Message-ID: <752bd947-78ae-463f-8d3a-ec4ed35cd9e8@kernel.org>
Date: Tue, 27 Oct 2026 15:03:30 +0100
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
Subject: Re: [PATCH] fs/proc/task_mmu: pin the mm during PAGEMAP_SCAN
To: Kyle Zeng <kylebot@openai.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, stable@vger.kernel.org
References: <20261024035646.68348-1-kylebot@openai.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261024035646.68348-1-kylebot@openai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/26 05:56, Kyle Zeng wrote:
> A pagemap file holds an mm_count reference, not an mm_users reference.
> Unlike pagemap_read(), do_pagemap_scan() does not acquire a live-MM
> reference before walking the page tables. Its mmap read lock does not
> exclude the first phase of exit_mmap(), which also unmaps VMAs under the
> read lock.
> 
> A process retaining a pagemap descriptor can therefore race the final
> mmput() and access resources that have already been released. In
> particular, a concurrent last userfaultfd close can free a context still
> reachable through a dying MM's VMAs, and unmap_vmas() can free a shared
> HugeTLB VMA's lock while the page walker is entering down_read(). KASAN
> reports both a userfaultfd context read-after-free and a HugeTLB rwsem
> write-after-free with unprivileged, read-only PAGEMAP_SCAN requests.
> 
> Acquire mmget_not_zero() after validating the ioctl arguments and keep
> the reference for the entire scan, including across mmap lock drops and
> MMU-notifier operations. Return -ESRCH if the MM is already dead, as
> PROCMAP_QUERY does. Balance the reference on the bounce-buffer allocation
> failure path and at the common exit. The pagemap file continues to hold
> only its existing mm_count reference between operations.
> 
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
> I have a reproducer for this issue.
> 
>  fs/proc/task_mmu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 5c54aebe2118..d2cee8dcba58 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -3235,11 +3235,14 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
>  	if (ret)
>  		return ret;
>  
> +	if (!mmget_not_zero(mm))
> +		return -ESRCH;
> +
>  	p.masks_of_interest = p.arg.category_mask | p.arg.category_anyof_mask |
>  			      p.arg.return_mask;
>  	ret = pagemap_scan_init_bounce_buffer(&p);
>  	if (ret)
> -		return ret;
> +		goto out_mm;
>  
>  	for (walk_start = p.arg.start; walk_start < p.arg.end;
>  			walk_start = p.arg.walk_end) {
> @@ -3294,6 +3297,8 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
>  		ret = -EFAULT;
>  
>  	kfree(p.vec_buf);
> +out_mm:
> +	mmput(mm);
>  	return ret;
>  }
>  
> 

Please take a look at the list before posting.

https://lore.kernel.org/r/20261014095540.3261469-1-ngocquy0700@gmail.com

-- 
Cheers,

David
