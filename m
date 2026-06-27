Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AAE15B998
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 00:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782520699; cv=none; b=PKIKH4WZg+IlQHgOWOCEGXm481nIS9j2Ruyb9v2nr6cXdR9FVmISksESd3gw9bbik0z9UHBE8qHZrwBl1oD8mdEP+ddwqjANxHOQI3yCBUK5UybKLvypebQXkA477a910u65T+Clz+2/wD1pgnfyhvFXk4w6Uqdis9aEezNT9R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782520699; c=relaxed/simple;
	bh=Bdin/OsaGJEAFj/seR3xSdkX5Xb5CHgs5hKFno3kVuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVvAYgb2YCVJO8rIMBzEbsn88hZ9mXPZOrGTr+ktq03ZcUcD8aNNhj5NROUL7M2lGHKGXyqWCj5mvvbkgjvE4SZckbyajcoZ5ycqG++PNVc69so6RIlEaiWtmFLuvOWPR+hgGnomAOb8QQWy2j8Oylo7yvdTMVuqpbK29cX6Xwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7KlcGU5; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7KlcGU5"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso748436a12.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782520696; x=1783125496; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPFVIV5ffTTrKYQTZc202v1RiHOXGlAXpe39g4o238E=;
        b=B7KlcGU5wZ0VEPZjGkqxt6MPAmbiCu5VRjzfQvYuFyXDdPQqSn9gPGO9YNy2iDnylF
         RzG0DvDmhbtv5IgizIVo+hCH+DK8j0/2pr1/Uj4VBDrzaCKWp27uv67Df4Pw8WCOIFzr
         ozyOTLD9z0wHdy8vacff5moGdtNzRB04rYu0x4mey9Jpi20lXi8CmmFS+BDx4GffLbjf
         vP08hacypFJvLNsjbgZxTC59w3HJMsWBe2+9QOx5+5xR48bbz+uiB1iZYR0SfggGuE9y
         AhrUHnHjNmXDPxM5lRbT43Cw+VAG5CfQQJ5rHEYC8/0HB2K2wEYOhJ5IuLGOOwbYdoJ0
         mwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782520696; x=1783125496;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPFVIV5ffTTrKYQTZc202v1RiHOXGlAXpe39g4o238E=;
        b=fCgEkGEiQ59t6Xyjo24HGG4La7xSwb/fqg66GIP/K0oa88HyugiQdtgaR2fABO/0IS
         C/TaV5e2Ws1Dt5SZIBcpSv7Owv9k4fY4DlC3xB9DVF4rISiPGvKd+XeIaymii+57Khov
         x9Vn5bS4BH1scvELd8WdcNc4QyiYQz+VbIo4Mk31HBXOaFHvFk4wMvAimXjo+waIxL5m
         wDzD0Q7laiRn1OfkfTdKLo/hJixqYLbGLDgojrnVL800JhS1/W62KD3dUrqDcmjO3Wid
         8CpAk3grUQVE0zn7HDdDBM33Lqq2bIZUxTbVqWp8Ed6hZ8/RY5ifrDkjeJdYBwAU3Y7g
         Je7w==
X-Forwarded-Encrypted: i=1; AHgh+RrcESai6cAqe9ajWKU2mVj1WsPTfgnqsj8kWiwHJdm5xx0pJo4CIIyKPaaWB1uksCBajo/1cMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkvAoMTR+z5ID6RGrM80DrRsAXuNIIBuRR96009EGzAH0+YQSZ
	HqyGx6+1tsc85spG/hXcAK4D2EmQQb+g1Wifh7dHurFfCasWvAGlhJTp
X-Gm-Gg: AfdE7ck1Q0CWF7o514sXut0ItgQvEjrocagDqMf3HU/JljeRZgvXpBtVgpmaV6WXy/Q
	P3s3yT2N6KuxBHl1T1HJx4SfyTFU3qDkrKR8zlIj01lJOj0TT/fPFQtJmFKkqQfMM3K1Qc61WAF
	jVBrZR+Vq3s9qtvte2U5MDlTLF8R8Bb0eAg0d0aWTKBcvqnJfq2zAmjS1M/KTSEdZy/vkTa6yYg
	FmemooKAv7/XgCHYtCeRxWHJoxJwUu36eTTLiW7rWDdcsBaAK76ddCngN20yZUlOYV7cWWmxTsI
	YL6TLuS6O6wkhRs2fEYomGGduLlDoC6DJwtWkeyE84J9bCo0rT5fg4qmPHXZL5+UBe2p4oa1dUF
	qiz/m6S/bBhP8w2k7f4xNHvcbLYfhw5fxQdKC3M2k9UvIA0IjcEuVEmVzZZuZMYlBzBGF8vadZ3
	KlXN8m3l9cAro=
X-Received: by 2002:a17:907:a2cd:b0:c12:c69:ba0 with SMTP id a640c23a62f3a-c120c691824mr448756566b.20.1782520695919;
        Fri, 26 Jun 2026 17:38:15 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05ed6sm394276766b.30.2026.06.26.17.38.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jun 2026 17:38:14 -0700 (PDT)
Date: Sat, 27 Jun 2026 00:38:13 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: david@kernel.org, richard.weiyang@gmail.com, akpm@linux-foundation.org,
	ljs@kernel.org, riel@surriel.com, liam@infradead.org,
	vbabka@kernel.org, harry@kernel.org, jannh@google.com,
	ziy@nvidia.com, sj@kernel.org, balbirs@nvidia.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private
 PMD handling
Message-ID: <20260627003813.ktpya35fx5doaz36@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <d060cadd-34f8-42da-b7f7-c8d295050436@kernel.org>
 <20260626132728.77436-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626132728.77436-1-lance.yang@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Jun 26, 2026 at 09:27:28PM +0800, Lance Yang wrote:
>
>On Fri, Jun 26, 2026 at 12:07:56PM +0200, David Hildenbrand (Arm) wrote:
>>On 6/24/26 08:53, Wei Yang wrote:
>>> Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
>>> device-private entries") introduced the concept of device-private
>>> PMD entries, but did not correctly update the rmap walk code to
>>> account for them.
>>> 
>>> As a result, when page_vma_mapped_walk() encounters device-private
>>> PMD entries, it takes no action other than to acquire the PMD lock
>>> and exit.
>>> 
>>> However this is highly problematic for two reasons - firstly,
>>> device private entries possess a PFN so check_pmd() needs to be
>>> called to ensure an overlapping PFN range.
>>> 
>>> Secondly, and more importantly, if PVMW_MIGRATION is set the
>>> caller assumes the returned entry is a migration entry, resulting
>>> in memory corruption when the caller tries to interpret the device
>>> private entry as such.
>>> 
>>> In addition, commit 146287290023 ("mm/huge_memory: implement
>>> device-private THP splitting") allowed device private PMDs to be
>>> split like THP mappings, but again did not update this code path.
>>> 
>>> As a result, we might race a PMD split prior to acquiring the PMD
>>> lock.
>>> 
>>> This patch addresses all of these issues by invoking check_pmd(),
>>> ensuring PMVW_MIGRATION is not set and checks whether a split raced
>>> us we do for PMD THP and migration entries.
>>> 
>>> Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>> Suggested-by: David Hildenbrand <david@kernel.org>
>>> Cc: David Hildenbrand <david@kernel.org>
>>> Cc: Balbir Singh <balbirs@nvidia.com>
>>> Cc: SeongJae Park <sj@kernel.org>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: Lorenzo Stoakes <ljs@kernel.org>
>>> Cc: Lance Yang <lance.yang@linux.dev>
>>> 
>>> ---
>>> v4:
>>>   * refine subject and commit log based on Lorenzo's suggestion
>>>   * put pmd device-private entry handling in its own if branch,
>>>     suggested by Lorenzo
>>> 
>>> v3:
>>>   * remove cleanup part, only fix the issue for device-private entry
>>>   * refine user effect description based on Lorenzo's suggestion
>>> 
>>> v2: https://lore.kernel.org/all/20260616063436.20455-1-richard.weiyang@gmail.com/T/#u
>>>   * specify the possible error case of current code and user visible effect
>>>   * besides fix, cleanup the pmd entry handling based on David's suggestion
>>> 
>>> v1: https://lore.kernel.org/linux-mm/20260508013728.21285-1-richard.weiyang@gmail.com/
>>> ---
>>>  mm/page_vma_mapped.c | 20 +++++++++++++++-----
>>>  1 file changed, 15 insertions(+), 5 deletions(-)
>>> 
>>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>> index 2ccbabfb2cc1..17dff8aab9f9 100644
>>> --- a/mm/page_vma_mapped.c
>>> +++ b/mm/page_vma_mapped.c
>>> @@ -269,14 +269,24 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>>  			/* THP pmd was split under us: handle on pte level */
>>>  			spin_unlock(pvmw->ptl);
>>>  			pvmw->ptl = NULL;
>>> -		} else if (!pmd_present(pmde)) {
>>> -			const softleaf_t entry = softleaf_from_pmd(pmde);
>>> +		} else if (pmd_is_device_private_entry(pmde)) {
>>> +			softleaf_t entry;
>>> +
>>> +			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>> +			pmde = *pvmw->pmd;
>>> +			entry = softleaf_from_pmd(pmde);
>>>  
>>> -			if (softleaf_is_device_private(entry)) {
>>> -				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>> +			if (likely(softleaf_is_device_private(entry))) {
>>> +				if (pvmw->flags & PVMW_MIGRATION)
>>> +					return not_found(pvmw);
>>> +				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>>> +					return not_found(pvmw);
>>>  				return true;
>>>  			}
>>> -
>>> +			/* device-private pmd was split under us: handle on pte level */
>>> +			spin_unlock(pvmw->ptl);
>>> +			pvmw->ptl = NULL;
>>> +		} else if (!pmd_present(pmde)) {
>>>  			if ((pvmw->flags & PVMW_SYNC) &&
>>>  			    thp_vma_suitable_order(vma, pvmw->address,
>>>  						   PMD_ORDER) &&
>>
>>This is extremely hard to review given the existing crap handling here. I'm
>>really sorry, but it makes my head hurt (I'm not kidding :) ).
>>
>>It's completely unclear why we only have to check for a subset of the cases
>>after taking the lock.
>>
>>Could we simply extend the existing migration pmd handling and leave the
>>!pmd_present() case for pmd_none()?
>>
>>That leaves no question to "which transitions are actually allowed", including
>>"could we accidentally assume something is a page table when really it isn't".
>>
>>
>>So what about something like the following?
>>
>>The "thp_migration_supported()" is not required when checking for
>>pmd_is_migration_entry(), as that defaults to "false" when not compiled in.
>>
>>Untested:
>>
>>
>>>From 048ecd33673ec649e168fbbb97749a7c0e344fcd Mon Sep 17 00:00:00 2001
>>From: "David Hildenbrand (Arm)" <david@kernel.org>
>>Date: Fri, 26 Jun 2026 12:03:40 +0200
>>Subject: [PATCH] tmp
>>
>>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>>---
>> mm/page_vma_mapped.c | 29 +++++++++++++++++------------
>> 1 file changed, 17 insertions(+), 12 deletions(-)
>>
>>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>index 2ccbabfb2cc17..ed2a23a90e8dd 100644
>>--- a/mm/page_vma_mapped.c
>>+++ b/mm/page_vma_mapped.c
>>@@ -243,21 +243,31 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>> 		 */
>> 		pmde = pmdp_get_lockless(pvmw->pmd);
>>
>>-		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>>+		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
>>+		    pmd_is_device_private_entry(pmde)) {
>> 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>> 			pmde = *pvmw->pmd;
>>-			if (!pmd_present(pmde)) {
>>+			if (pmd_is_migration_entry(pmde)) {
>> 				softleaf_t entry;
>>
>>-				if (!thp_migration_supported() ||
>>-				    !(pvmw->flags & PVMW_MIGRATION))
>>+				if (!(pvmw->flags & PVMW_MIGRATION))
>> 					return not_found(pvmw);
>> 				entry = softleaf_from_pmd(pmde);
>>+				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>>+					return not_found(pvmw);
>>+				return true;
>>+			} else if (pmd_is_device_private_entry(pmde)) {
>>+				softleaf_t entry;
>>
>>-				if (!softleaf_is_migration(entry) ||
>>-				    !check_pmd(softleaf_to_pfn(entry), pvmw))
>>+				if (pvmw->flags & PVMW_MIGRATION)
>>+					return not_found(pvmw);
>>+				entry = softleaf_from_pmd(pmde);
>>+				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>> 					return not_found(pvmw);
>> 				return true;
>>+			} else if (!pmd_present(pmde) ){
>>+				return not_found(pvmw);
>> 			}
>> 			if (likely(pmd_trans_huge(pmde))) {
>> 				if (pvmw->flags & PVMW_MIGRATION)
>>@@ -270,12 +280,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>> 			spin_unlock(pvmw->ptl);
>> 			pvmw->ptl = NULL;
>> 		} else if (!pmd_present(pmde)) {
>>-			const softleaf_t entry = softleaf_from_pmd(pmde);
>>-
>>-			if (softleaf_is_device_private(entry)) {
>>-				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>>-				return true;
>>-			}
>>
>> 			if ((pvmw->flags & PVMW_SYNC) &&
>> 			    thp_vma_suitable_order(vma, pvmw->address,
>>-- 
>
>Might be good with this on top:
>
>---8<---
>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>index cfa1230c87bb..8b7c062bd81d 100644
>--- a/mm/page_vma_mapped.c
>+++ b/mm/page_vma_mapped.c
>@@ -281,7 +281,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> 					return not_found(pvmw);
> 				return true;
> 			}
>-			/* THP pmd was split under us: handle on pte level */
>+			/* THP/device-private pmd was split under us: handle on pte level */

As the comment in commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration
support device-private entries") says:

  Add device-private THP support...

Per my understanding, we first already setup mapping and "migrate" to device
memory. This looks a kind of place holder.

Not familiar with this. Just want to clarify, we want to treat device-private
pmd as some sort of THP or not?

> 			spin_unlock(pvmw->ptl);
> 			pvmw->ptl = NULL;
> 		} else if (!pmd_present(pmde)) {
>--
>
>Looks good to me as well, thanks!

-- 
Wei Yang
Help you, Help me
