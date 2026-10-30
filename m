Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793332548;
	b=p9QauEEbfvRad45FgwFlWkRsG/r13jZL6V3I2XujhLV13TWJxACZ8YHVVF/Z44/4OKpc
	 e8UcxHPQeQLDJLQUV/Lzz5+vQJ21km3Jtv6q0cheXDGZps1Uy+1pT0rxdZrY/138/3PKj
	 0eZE7JKZyEnK+7Xg/nXbR0cvmJjtJEmgODkTAR9TXeKT0OZ0wsny7QHXuzptJZUIlvK1I
	 qyU28qMJwWIccUv/JRG8tqsTbEZ62nnow0ql2HK3Mje5VWR8PrJLGrRkTcTRh1TRbhoU2
	 MQTGJWbk8INCHqwjm0tls3v3Ngo4137gEwMgzcRHJc2jYqqKgJrGTCF9TMKXtDjMHdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793332548;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZkxPW2ruqc0Icv4y+99LJtMWacocG51kIhVn5Ect5og=;
	b=jQ2LmCYYWJdu1m9yxBsZ1s+hU12zcFxfOrhs6P6IK6NV/29rjfKsBju4DtB2bAJL2IgZ
	 bHydfBBpzfJ+VvkMpDSNgNsN7KzzCCMUhL0Vj0l6qncVcHgaTQsZH3uqDqC8T2vbKo/LR
	 dBUpNADfB0md08Wx0mO+QZBrDi9AjIL4u0ZsQliB1dsfVZgu1SXZ38rMraVjlYyNxMAKU
	 MnvstV+G7Ania9j5wGkd+rKVK4SDYxmbtYjyCXb/JHmuapdFox4G0BzztRHMr7Cs1iDVt
	 KvUfh3QC3z148+m63jCIpW73rCcLuoN97J+ksd9VoOP3wxWGmRP6uuHiGhv7yoSoEzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=SUUc4n8Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AFF606A31C;
	Fri, 30 Oct 2026 03:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=SUUc4n8Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086BE1F000C1;
	Fri, 30 Oct 2026 03:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793332543;
	bh=ZkxPW2ruqc0Icv4y+99LJtMWacocG51kIhVn5Ect5og=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SUUc4n8Y9twmxefBBWPSiCCNBbkgwNw0CVmf2ItyOZEJv/Y4ha7kDBDwxKdnsbO6J
	 x1mVLqVUUk290osQYZrec+8tVOIwha/pI8nYNLtqj2PfxUsi1D06/Kx82fUHwiaCFw
	 9vxMZCneEVL2rlsuJSF/dRDkhIdigfovQ/L2GNrU=
Date: Thu, 29 Oct 2026 20:55:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Shubhang Kaushik <shubhang@os.amperecomputing.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Dev Jain
 <dev.jain@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2] mm/vmalloc: reject overflowing vm_map_ram page
 counts
Message-Id: <20261029205542.1fdef1d121d9eb720950b67d@linux-foundation.org>
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

Thanks.  Let's cc the developers who commented on the v1 patch.

> Fixes: db64fe02258f ("mm: rewrite vmap layer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
> ---
> Changes in v2:
>   - Use check_mul_overflow() to validate the page-count-to-byte conversion.
>   - Describe the short-mapping failure mode and its worst-case effects.
> 
> Link to v1: https://lore.kernel.org/r/20261022-vmalloc-reject-overflow-v1-1-5fde0042ffb9@gentwo.org
> ---
>  mm/vmalloc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index bea9f76ed7e74247d4ce919250c2f02dd5c36483..8a056e424a4f2c037c10f736002839014f1f57dc 100644
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
> ---
> base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
> change-id: 20261022-vmalloc-reject-overflow-e532c556f3fa
> 
> Best regards,
> -- 
> Shubhang Kaushik (Ampere) <sh@gentwo.org>
