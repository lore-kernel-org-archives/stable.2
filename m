Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792463151;
	b=mG6pGsGLFQQucFgnz6fcLCmzWIv2+a4qCEuhjksNCuyIYyJOEUfRE+P0ua1e0GDO40X1
	 UGUbkqUivnGuMoONnF2CVUCDZ8sdU2c6FFAQ4OLmF8op6heZIw5RbJe+C0P6jmoENMXWH
	 /ld3XrFrxwLPgoGBq6xnu1mYGWLmtygPZCYEGI7xQ1DADmFILQrh557lqNBfpQaUg7KtD
	 +eIxetIu+Q3ZnIXfUmssrJrKkRSbJdUI99I+fjYMTbOqR2gzgO+horY3IyE2CVwkvG1D4
	 izBT5KRSeGGeepqXA6P1N3eqXGjwLZU+wZ/wmK7mx+4sB1VKnJybBqI5A9FfiwhGKqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792463151;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=qkEnDwBugjwZfgs/RO2JOZXA4QXBERjlTcHQBq6IyoM=;
	b=IGYJhQhwCmj40qTT5ZonIFmsDkwbx8Pnd0eUEmm+Z4twUjB/fmaiWAHd2jsArQap1lpy
	 T/oUCD4/yUHV2sVYEehdWMMpC2lSdTZIRX5W2PoExm4spOm03/DMG+sy67EziQgHzNgtI
	 L7vCk8y0GNuxmSbttYQJNixmcX0L2cKdZPe0cc2lzO3OrjAp8kPQ99h/PpXgagL8n1IvG
	 E/duN2YgCq+ds7bgzL/haNkEU43sqVr6GwvV5UYGBBgiBBluPhhSgSQqrF/ZcclM0moiK
	 TAX0pXtnPnZl9X5cfw0i9VM2dCmzUIVRjAVKVmCYVVHDNO7adOG4YYVcMSdfzHPs3XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Eu5CzCZv;
	arc=none smtp.remote-ip=95.215.58.87
Received: from mta1.migadu.com (out-87.mta1.migadu.com [95.215.58.87])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD0E606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 02:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BD0E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Eu5CzCZv
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ntRwUSpnw+xfJNy+369eirj2tCJL/FP5kPFnotn1kaE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792463147; v=1; x=1793067947;
 b=Eu5CzCZvzQRuuCA4jfdags9tIDsCpkho05xTr2bk25NTRylCoWFFZqCdb74tCez1dfqXk84q
 tgTmzMKC43zv9NP6sLhL3AIRUHbkLEMLC3urYJ0LR4W7AArVMfTJYhRpYT2Ptn9m09VoCsXi1f9
 3Ya8E92vFRKlQukG0nRQFpiQ=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5b8ad6c55f67365a;
	Tue, 20 Oct 2026 02:25:47 +0000
X-Mizu-Trace-ID: 5b8ad6c55f67365a
X-Migadu-Flow: FLOW_OUT
Message-ID: <b0d303c5-4ca5-4ccf-9e24-499a9719a50e@linux.dev>
Date: Tue, 20 Oct 2026 10:26:55 +0800
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
Subject: Re: [PATCH v2 2/5] mm/kmsan: skip vunmap_range_noflush when KMSAN is
 disabled
To: Dev Jain <dev.jain@arm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
 Suren Baghdasaryan <surenb@google.com>, Uladzislau Rezki <urezki@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
References: <20261019054531.87652-1-hao.ge@linux.dev>
 <20261019054531.87652-3-hao.ge@linux.dev>
 <3cbb17e3-e201-4138-a070-0c64289a12bb@arm.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <3cbb17e3-e201-4138-a070-0c64289a12bb@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dev

On 2026/10/19 23:22, Dev Jain wrote:
> 
> 
> On 19/10/26 11:15 am, Hao Ge wrote:
>> kmsan_vmap_pages_range_noflush() returns 0 when kmsan_enabled is
>> false.  The unmap side does not, so it still walks the shadow and
>> origin page tables even though KMSAN never installed any metadata
>> there.
>>
>> Add the matching early return.
>>
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Cc: stable@vger.kernel.org
> 
> Cc stable without fixes?

Oops, my bad. The Cc stable was added mistakenly.

> 
> I guess without the fix nothing is actually wrong, except doing
> wasteful work?
> 
>
That was true before, but not anymore after Patch 3
(mm/vmalloc: undo partial mappings inside the mapping functions).
vmap_pages_range_noflush() now does:

int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
                pgprot_t prot, struct page **pages, unsigned int page_shift,
                gfp_t gfp_mask)
{
        int ret = kmsan_vmap_pages_range_noflush(addr, end, prot, pages,
                                                page_shift, gfp_mask);

        if (ret)
                return ret;

        ret = __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
        /*
         * The page tables undo themselves on failure. Tear down the
         * metadata that was fully set up before the mapping failed.
         */
        if (ret)
                kmsan_vunmap_range_noflush(addr, end);

        return ret;
}

Sashiko report: with !kmsan_enabled and a caller passing an empty range
(addr >= end) the flow is:

1. kmsan_vmap_pages_range_noflush() returns 0 at its first check, it
   never looks at the range.

2. __vmap_pages_range_noflush() hits the new WARN_ON_ONCE(addr >= end)
   and returns -EINVAL.   

3. ret is non-zero now, so the rollback calls kmsan_vunmap_range_noflush(addr, end),
   which unconditionally does

	__vunmap_range_noflush(vmalloc_shadow(start),vmalloc_shadow(end));

   vmalloc_shadow() is a fixed offset, so the shadow range is empty too, and
   __vunmap_range_noflush() starts with BUG_ON(addr >= end). Panic. 

So the guard is not about the empty range itself: a caller passing an
empty range is buggy, and on today's kernels it already BUG_ON() in
vmap_small_pages_range_noflush() on the small-page path. Patch 3                                                                     
deliberately turns that into WARN_ON_ONCE() + -EINVAL, and this patch                                                                
makes sure the new metadata rollback does not turn that recoverable                                                                  
error back into a panic when KMSAN is disabled.     

But it's only theoretical. We haven't hit this case in real usage.
We add this guard merely to reduce unnecessary work, and incidentally
harden Patch 3.

Thanks for pointing this out.

Best Regards
Hao

>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  mm/kmsan/hooks.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
>> index a706666db097..107f66841274 100644
>> --- a/mm/kmsan/hooks.c
>> +++ b/mm/kmsan/hooks.c
>> @@ -138,6 +138,9 @@ static unsigned long vmalloc_origin(unsigned long addr)
>>  
>>  void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end)
>>  {
>> +	if (!kmsan_enabled)
>> +		return;
>> +
>>  	__vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end));
>>  	__vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end));
>>  	flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
> 
