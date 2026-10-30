Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793341405;
	b=2NI1+/3g4rCzKyusjyViP+v6YRYt3f7gB4GviV87aQ/k+U+f95cgdGTYm4JyD4/o6SWW
	 OiIpeJVMouRY4JQV/KdxjQWe2En3bRe8CKViJw2MJ0l7neZWKefqWrl/WJJTRPpBuKmAh
	 MjH302MJRKt3uMXysGlCgE+HhmjID7ix6nP5l1clxufmzimsEe2aSPt3jllymONI3T3FU
	 lZV12c8lr+UUQq9bNZjvbP/cEd7mBfyXjTTMsT1PiYV2Ynx4JlmAVu9JCda8h8WHdhv56
	 Ro+/4Wuoyz2UwDHserDjCBHBiTbyQM39qJeInWxa0mQ21jrZ24r9GzOvvpaJ+d8sjdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793341405;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=FR6kDtuhUl2pZ2hlAM7s92sn5MsoPj+x/vo721Jg2CE=;
	b=fm6wmfhdEy/n7Kn9TPrY3CXSFMfAKbC8AyXjwtRgWxsoZBM7A2r04IlJ7GIDlGSCAbci
	 2qs/tR/Wy7zDKdrwjRdjoXgl07gSZ8FTtIqnPb/2pacHmH74daVaNtSZ+N6FoJ3/uLA4T
	 WElC6/jLSqMSnDHJ/iojmdFmtTO0w2PN/wfp0a+7fo61xcLgc5/xgRAi1KbEqkNrunEm2
	 93KyGNb9tH7ozMo7ley1F2rpNax2j3vp3K9jm8ns5TwriBQmtkGHmUWOxZUxtG3FxcUcc
	 4r3xXoeKA61RZW8oBGum5e59Wx4eZjySUJtFISuREnB485DWEUsbei7Z2/6XJRgDP2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=o2R7dIvZ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A600606A31A;
	Fri, 30 Oct 2026 06:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A600606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=o2R7dIvZ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37F561E8D;
	Thu, 29 Oct 2026 23:23:19 -0700 (PDT)
Received: from [10.163.152.232] (unknown [10.163.152.232])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FDB13F673;
	Thu, 29 Oct 2026 23:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793341402; bh=P5Zy0xZQya3Jb54eLwCnE+O+Yw3rp01J117IsN1L6JQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o2R7dIvZvwWJxI4hKtEGR0Ax8UZ3wC+rA1T7+1AKR2QCQwRhZPUi5IS/R3uXlRd9W
	 8p1ZVKZzFAc5qfLKGHFQOHm1CZNm21azSP0HlBfV/2KkcmyyjvI1H3/tHM/wOuxsYM
	 I22XH1bYRCgfDCNJlnHPePjV82hwwO03z+iyqNfw=
Message-ID: <9ac25d32-4f2f-4e91-92e6-7ecea7a8ffb8@arm.com>
Date: Fri, 30 Oct 2026 11:53:15 +0530
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
Subject: Re: [PATCH v2] mm/vmalloc: reject overflowing vm_map_ram page counts
To: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Shubhang Kaushik <shubhang@os.amperecomputing.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261022-vmalloc-reject-overflow-v2-1-0db7a20c53f0@gentwo.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261022-vmalloc-reject-overflow-v2-1-0db7a20c53f0@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/10/26 12:13 pm, Shubhang Kaushik (Ampere) wrote:
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
> 
> Fixes: db64fe02258f ("mm: rewrite vmap layer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
> ---

I don't have much knowledge about 32-bit stuff but upon some discussion with LLM
the problem seems legit, maybe just hard to reproduce. Also there are sufficient
users of vm_map_ram() to care about this:

Reviewed-by: Dev Jain <dev.jain@arm.com>


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

