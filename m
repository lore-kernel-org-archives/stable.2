Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793933046;
	b=BPODcicL3r1Z7wPohtr2dqMpSwu2PXPpSdc3xVwijtpA/PHOqQAME6W6vHjh5o7qdKWw
	 U+9zlANLyvONFqQBl8Lc5d/vDyLPXBTcMU8YrvJQ+ZOwX5t+YtKGsRZNdygEg7jbpoYwv
	 6QuLf/TlWz9IEVcVWpQxZY0hxCPQmmv6nrl2/gITTrqfNpS7tcMPy3aa1dacxWqumuQ+5
	 lnffP/PxQQnsAqZt88xcQtlerLvwj24ookCUcScSbuNpUrthuIuzUF7wlwKmwEhqfJGAV
	 jZTQU+8LGEvKdtGonZYJiza+lY5SXvw3Rjbwlvx+rYiYKdKePooL5zxp3ye8sstN6tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793933046;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=zSAnlbuhwhmUG9bBEmOB7UE9ygtoZLL5whU9bUfyqnc=;
	b=GV55R1hdi1jlKPy8lMyouvgQhN1Z4MHXv7CPxQy1sElYnT/3AfQDahQky6a9+nSecV6w
	 2M8im3kE0IMJMw68EufLErCNPF25tAXVp+3L73yUPoQOXvG8lyYh8MeFtI3NrzzzE8E0x
	 sTqM1xzo5L/DrKuS3T7j279/NO/Hnz7FL1m8Yi/x3r3jfg3UDyRuNtAT50L+hm5EIlRLp
	 vjZ2aRmu+0Q60Ww3NUyQ9/oT3wjdJwK8uPMNiFcBeXnsDTgYgPa/ep7eTcPxLoOBg0Uzj
	 XspA3I+hsp4+1UlCMP4ATMt9xb1xwkzEyjG8dSB8XomzhMgG3xhIqlPLVFWNogCaP4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=p4hIGK3F;
	arc=none smtp.remote-ip=91.218.175.223
Received: from mta0.migadu.com (out-223.mta0.migadu.com [91.218.175.223])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E88606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36E88606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=p4hIGK3F
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BV4jydBngbK5OT+ZHvts5CVNgLwnfznFuT39h8Pecis=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793933041; v=1; x=1794537841;
 b=p4hIGK3FvTBncEACzoquuYTKUahICVVjb+yGf0kJM0hCa8vbXeIeqBgaM5JLMbHZmxt6o5/W
 64Xh/rztiH19Yyid8rqfxTMTeIrFpa6d20K3WGt17QdWQhU8O3lmgNECf403fraDz70m9uVegTe
 x5p01mJXm2W82ZxyKfNpk+Cs=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f76348987678bbc6;
	Fri, 06 Nov 2026 02:44:01 +0000
X-Mizu-Trace-ID: f76348987678bbc6
X-Migadu-Flow: FLOW_OUT
Message-ID: <1535887c-6be2-4415-b54e-2008e6e7a35c@linux.dev>
Date: Fri, 6 Nov 2026 10:43:53 +0800
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
Subject: Re: [PATCH v2 3/4] mm: hugetlb: fix GFP mask propagation to CMA
To: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
Cc: muchun.song@linux.dev, osalvador@suse.de, david@kernel.org,
 akpm@linux-foundation.org, azpijr@gmail.com, lance.yang@linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1793850539.git.zhengqi.arch@bytedance.com>
 <ac2de9b321f68c1025333e92e3ce94beadcb0b6c.1793850539.git.zhengqi.arch@bytedance.com>
 <auxTwrKCeg7a3hfY@localhost.localdomain>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <auxTwrKCeg7a3hfY@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Oscar,

On 11/5/26 6:00 PM, Oscar Salvador (SUSE) wrote:
> On Thu, Nov 05, 2026 at 12:07:45PM +0800, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> cma_alloc_frozen_compound() uses GFP_KERNEL, allowing direct reclaim
>> during the first MPOL_PREFERRED_MANY allocation attempt even though
>> the caller clears __GFP_DIRECT_RECLAIM.
>>
>> Pass the caller's GFP mask through the helper so CMA respects its
>> reclaim constraints when trying the preferred nodes.
>>
>> Fixes: 9bda131c6093 ("mm: cma: add cma_alloc_frozen{_compound}()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ...
>> --- a/mm/cma.c
>> +++ b/mm/cma.c
>> @@ -933,9 +933,9 @@ struct page *cma_alloc_frozen(struct cma *cma, unsigned long count,
>>   	return __cma_alloc_frozen(cma, count, align, gfp);
>>   }
>>   
>> -struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order)
>> +struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order, gfp_t gfp)
>>   {
>> -	gfp_t gfp = GFP_KERNEL | __GFP_COMP | __GFP_NOWARN;
>> +	gfp |= __GFP_COMP | __GFP_NOWARN;
> 
> Do we really need __GFP_COMP | __GFP_NOWARN here?
> It is my understanding that all allocations coming from hugetlb are
> handled with htlb_alloc_mask(), and that should already provide
> __GFP_COMP | __GFP_NOWARN.

Right. All current callers already supply both flags through
htlb_alloc_mask().

> We might have needed it when cma_alloc_frozen_compound() constructed its
> own mask, but not it gets it from the caller, and that should have been
> done via htlb_alloc_mask() up the chain.

Right. Now that we restore GFP propagation, setting __GFP_NOWARN here is
redundant. I'll remove it.

I'd still prefer to keep __GFP_COMP so that
cma_alloc_frozen_compound() itself guarantees compound allocation,
without requiring callers to supply the flag.

What do you think?

Thanks,
Qi

> 
> So, any reason to have it here now?
> 
>   
> 

