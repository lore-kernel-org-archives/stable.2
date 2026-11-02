Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793593021;
	b=Ij1KheT7LlAEGpKzViI+QYKaUFyUTKPOOlCcNGIueXRkXMgmY7hBhfOj3Y/ijGjv2sxb
	 Mjtlgw0EvQ5FqHDO9lpDd3tlSUTbEhS70ppPoh5cKGDtfxI1fl9B1ZR0Xk5yDnzey0je+
	 4yXZjOCrmLyW7diaT/UB1y4+1WZgucISdJzR01TFkr0csFSUEA+dbC5Zs5wihYf2za9MO
	 w/YePCOB3cg9jHYHal55lqOvqBA+XFbjjnTRaX4oKENi5DhQ/EyR3aqTQaZvCAoPL7GGz
	 w8kqeUeNDcYq5mubW6uFqvd0Pa+ZAwIq4EAjQbndCNBglKeSbRcvm17BOwTpm2RRJkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793593021;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qOu9Fz9Gkmb2JiqjJVcPJoJv0zAbcsEJa7ZIZ1WjgX0=;
	b=zPHixhx1jd5rnWnRMmL0ES6ks2LxGZI+HIaW/7BIPZytdJiH0Iv60abvMLfg8AQmzf2l
	 skDUSevdRfnaJDXZzFWHbigjZGylgT4F8BLl8usqPUwhy/3XTfLaUyF2r/C/CuIdnz24H
	 BhTpSui6CH7wVRER4Wg5s48DvK1ZU9xjxf9L59yqSBZEFEOTC0ekDw6CFX4JavEkSWiw3
	 w9p15vDD0vvRBGeiPMmpoguDJzbwjMSMKRrWitG0xSvidEf/13axyRLYgn+Sz+3qaONYP
	 aueLj1XATVid9DDmbhUDouC2udUCBgTBKDohz3JfZlHWhbUyimiHSJclplpcpi+XuyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=paCSqT1f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E895606A324;
	Mon,  2 Nov 2026 04:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=paCSqT1f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBBA1F000C1;
	Mon,  2 Nov 2026 04:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793593020;
	bh=qOu9Fz9Gkmb2JiqjJVcPJoJv0zAbcsEJa7ZIZ1WjgX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=paCSqT1fgOnLEfJUGav25R0/AtwIZs9BYBXFB5RJU8b8grNZosAb9BQ6xq77QJlna
	 uJUIAEHdWv7y7E1C90pAD07AcMsPBf+hbdyGV+nKkXn6bWw9BBolMehYZCY0SBKdFR
	 J/Lv3+8dkfSSRfw/KoM0+AKZS6oWOP2axTr9Z7ZQ=
Date: Sun, 1 Nov 2026 20:16:59 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Shubhang Kaushik <shubhang@os.amperecomputing.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/vmalloc: reject overflowing vm_map_ram page
 counts
Message-Id: <20261101201659.c6c07375429df81081ce8b0f@linux-foundation.org>
In-Reply-To: <20261022-vmalloc-reject-overflow-v2-1-0db7a20c53f0@gentwo.org>
References: <20261022-vmalloc-reject-overflow-v2-1-0db7a20c53f0@gentwo.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 23:43:47 -0700 "Shubhang Kaushik (Ampere)" <sh@gentwo.org> wrote:

> vm_map_ram() accepts a page count and must either map that many pages or
> fail. It currently converts the count to a byte size with:
> 
>         (unsigned long)count << PAGE_SHIFT
> 
> On 32-bit kernels, this conversion overflows when count is greater than
> ULONG_MAX >> PAGE_SHIFT. vm_map_ram() then allocates and maps only the
> wrapped byte size, but returns a non-NULL address to its caller.
> 
> For example, with 4 KiB pages, a count of 1048577 wraps to PAGE_SIZE.
> vm_map_ram() therefore returns a mapping containing one page instead of
> the requested 1048577 pages.
> 
> If a caller uses the successful result as a mapping of all requested
> pages, it can access beyond the allocated mapping. Such an access can
> fault. If the accessed virtual address is occupied by another vmalloc
> mapping, it can instead access and corrupt unrelated kernel memory. In a
> userspace-reachable call path, this can result in a failed operation, a
> kernel oops or panic, or the effects of corrupted kernel data.
> 
> Return NULL before allocating or mapping anything when count * PAGE_SIZE
> cannot be represented in an unsigned long.

Thanks.

Is there a case where userspace can actually hit this, or is it a
theoretical case which can't actually be encountered, or something else?

> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3083,10 +3083,13 @@ EXPORT_SYMBOL(vm_unmap_ram);
>   */
>  void *vm_map_ram(struct page **pages, unsigned int count, int node)
>  {
> -	unsigned long size = (unsigned long)count << PAGE_SHIFT;
> +	unsigned long size;
>  	unsigned long addr;
>  	void *mem;
>  
> +	if (check_mul_overflow((unsigned long)count, PAGE_SIZE, &size))
> +		return NULL;
> +
>  	if (likely(count <= VMAP_MAX_ALLOC)) {
>  		mem = vb_alloc(size, GFP_KERNEL);
>  		if (IS_ERR(mem))
> 

