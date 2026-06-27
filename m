Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E94800
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 00:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782518662; cv=none; b=ZxnfSlOBWIO/hAcAmLiEumOc+LI+ehe+ot2XOd250toLpgzxZ4aDZosxDtQbfwMlTZHxYIadpETKB2q9xK5sqmiGpWOf2jLTMx50NQt5/bsg361V38jzErfYpQEJ67GgBUgHoZtjtSkme0dTJ90M934tkvumxP3PXuNMjqF3ONM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782518662; c=relaxed/simple;
	bh=kBfVJBlGGav0N2qGfFmCpE2tT1PkIQpIN7BLDxSy1Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vz9Em+qT8XSX2Q41NuWMXAYR7+TrNTw1+OHu2q55BFS5iTnGLQTF5OaTG7/SXymwVmVzvrG7NJwxzkg04vLNkrRkSZTfGY1cjzYsmwrboZT+ZYcb/Poxm/fKY0xpdXgfpRMxB+Boc3dTOupzjn5QeJrK92legVN/j/Ls+WYWv/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALcTkGY7; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALcTkGY7"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6984111d35bso304127a12.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782518660; x=1783123460; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aBtjyBhRXO4wcOB3SrA5AZCE73f5ZU7Ka9JtMA+a/E=;
        b=ALcTkGY7zpI24ke2ZfG+50z/VV2eo2b+v3hzreBwS/PXX+J0Y+j/D/qQCza0lEmh5Q
         +3vCYCIgpOd4Bum5P4Bl3zOwCqSaHj/MkNn42QFtk4h1E+Fa3ajwKt4bjkmAL9xY6W9U
         i/mD2pzIHxVhbE36tXtUzrigpTmu3St7Z1L3uPs56kGVFB/cdej/BZk1f5bD142HEs3u
         SsHqmSmcdD4C/k+13peTqz5y9JyjRiUCHQqZVYoAT9JgLdlGfqi6w9JNfjbZtKZuaMdU
         noN4FZKOY5Nj4GMI39Av27buImsCrZJzJogDi1O9wyX1r86mYGWnaBE+8nhClLNhfw0X
         i+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782518660; x=1783123460;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aBtjyBhRXO4wcOB3SrA5AZCE73f5ZU7Ka9JtMA+a/E=;
        b=Tm3oQpJMt2r0Wrf9jRlxBXZSybx4dskGfVxsuwt+UMt90JGYJOhIDu9PQVrOfgTMOf
         6PbrbQiYMxQcxltqRa228kuPUAFhBUbyPuFOnDsArtqQ+5mXAQy8Y2zsvuz2wqzdAIVt
         p0Nv4PDYf9B1uaI0HAEcv2nv1nsh958uyYhgAvIh27Ms5lCseFFDwCorj1sUKg4Yqh/h
         nRQoxaR9izLJ3PYpa50efTKh5FpI7mqIjsBP5K5i7UmyMTq9nNDjtOHGu12f+qkH+GSC
         qeZHpXZCiBegXTtt5KMcM487yNvs+YX15D0ff+8mISRhbF+4vulrNiADup/n/DNpAP3t
         gW2g==
X-Forwarded-Encrypted: i=1; AHgh+Rrl9ankl4P57xqc7zIdm59yaIfnB4jeNqkvXUcR6i+zJpDQhvfXJjxLmoY7pLH7wawypX9zw0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpIOA0UOZyap90+EUzt/7eeuL1yKGS/O9pz2p+6aKcl6ZeJar9
	IdXeoIn3/t1kaL++rI2/8WTh2iEDSclJRgkavXDiJ9osBHLtsbkHtEvg
X-Gm-Gg: AfdE7cka3WVkFlM/yf5ppWwKt6ATjG9C03WjWrEVW8ocNPBZkqwxU9it/asnL3TaGpU
	TnQvMcbEhuX73Sy7gob63TIi5LlqZp5Qdrjky+w2hj7q5LDd7Hq53lrTI/o4G+yV89Lryz/9tHQ
	hhU8NAl1/7KXirxHRtT+A7ey5H7jnKoiC1eWi1GMbRkKVVxSCLnNFHZ7HPFsrfyfnt3BbN+aYL8
	o1fS/BR8BenKDuhFY82Tlm6NYz5HSta3tpcZBUXhHp2QcNXcm9ZtSBsV2lL1aPdtbGyAVaycxyS
	2A3kw49q57AdCJBXsXEj8F9wKkNgfY38hpfdfx0y7u1NLpJD+wUsg/40oexl/dyt3HwHek8xAMV
	RqJzDzwSMkYJBwxWQHbUyDjivlq3oUcI5EzNhSM73Q1TxrMzpu7dPoYKhH04aY9CpuLjh9Kwrf2
	OGIBDmy5ZCgjs=
X-Received: by 2002:a17:907:94c1:b0:c12:2ce7:a5a8 with SMTP id a640c23a62f3a-c122ce7fcf6mr214659666b.25.1782518659316;
        Fri, 26 Jun 2026 17:04:19 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbba8b61sm387627266b.4.2026.06.26.17.04.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jun 2026 17:04:17 -0700 (PDT)
Date: Sat, 27 Jun 2026 00:04:15 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	ljs@kernel.org, riel@surriel.com, liam@infradead.org,
	vbabka@kernel.org, harry@kernel.org, jannh@google.com,
	ziy@nvidia.com, sj@kernel.org, balbirs@nvidia.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Lance Yang <lance.yang@linux.dev>
Subject: Re: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private
 PMD handling
Message-ID: <20260627000415.xm4w3zzpithptv4i@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260624065353.1622-1-richard.weiyang@gmail.com>
 <d060cadd-34f8-42da-b7f7-c8d295050436@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d060cadd-34f8-42da-b7f7-c8d295050436@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Jun 26, 2026 at 12:07:56PM +0200, David Hildenbrand (Arm) wrote:
>On 6/24/26 08:53, Wei Yang wrote:
>> Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
>> device-private entries") introduced the concept of device-private
>> PMD entries, but did not correctly update the rmap walk code to
>> account for them.
>> 
>> As a result, when page_vma_mapped_walk() encounters device-private
>> PMD entries, it takes no action other than to acquire the PMD lock
>> and exit.
>> 
>> However this is highly problematic for two reasons - firstly,
>> device private entries possess a PFN so check_pmd() needs to be
>> called to ensure an overlapping PFN range.
>> 
>> Secondly, and more importantly, if PVMW_MIGRATION is set the
>> caller assumes the returned entry is a migration entry, resulting
>> in memory corruption when the caller tries to interpret the device
>> private entry as such.
>> 
>> In addition, commit 146287290023 ("mm/huge_memory: implement
>> device-private THP splitting") allowed device private PMDs to be
>> split like THP mappings, but again did not update this code path.
>> 
>> As a result, we might race a PMD split prior to acquiring the PMD
>> lock.
>> 
>> This patch addresses all of these issues by invoking check_pmd(),
>> ensuring PMVW_MIGRATION is not set and checks whether a split raced
>> us we do for PMD THP and migration entries.
>> 
>> Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Suggested-by: David Hildenbrand <david@kernel.org>
>> Cc: David Hildenbrand <david@kernel.org>
>> Cc: Balbir Singh <balbirs@nvidia.com>
>> Cc: SeongJae Park <sj@kernel.org>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Lorenzo Stoakes <ljs@kernel.org>
>> Cc: Lance Yang <lance.yang@linux.dev>
>> 
>> ---
>> v4:
>>   * refine subject and commit log based on Lorenzo's suggestion
>>   * put pmd device-private entry handling in its own if branch,
>>     suggested by Lorenzo
>> 
>> v3:
>>   * remove cleanup part, only fix the issue for device-private entry
>>   * refine user effect description based on Lorenzo's suggestion
>> 
>> v2: https://lore.kernel.org/all/20260616063436.20455-1-richard.weiyang@gmail.com/T/#u
>>   * specify the possible error case of current code and user visible effect
>>   * besides fix, cleanup the pmd entry handling based on David's suggestion
>> 
>> v1: https://lore.kernel.org/linux-mm/20260508013728.21285-1-richard.weiyang@gmail.com/
>> ---
>>  mm/page_vma_mapped.c | 20 +++++++++++++++-----
>>  1 file changed, 15 insertions(+), 5 deletions(-)
>> 
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index 2ccbabfb2cc1..17dff8aab9f9 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -269,14 +269,24 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>  			/* THP pmd was split under us: handle on pte level */
>>  			spin_unlock(pvmw->ptl);
>>  			pvmw->ptl = NULL;
>> -		} else if (!pmd_present(pmde)) {
>> -			const softleaf_t entry = softleaf_from_pmd(pmde);
>> +		} else if (pmd_is_device_private_entry(pmde)) {
>> +			softleaf_t entry;
>> +
>> +			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>> +			pmde = *pvmw->pmd;
>> +			entry = softleaf_from_pmd(pmde);
>>  
>> -			if (softleaf_is_device_private(entry)) {
>> -				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>> +			if (likely(softleaf_is_device_private(entry))) {
>> +				if (pvmw->flags & PVMW_MIGRATION)
>> +					return not_found(pvmw);
>> +				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>> +					return not_found(pvmw);
>>  				return true;
>>  			}
>> -
>> +			/* device-private pmd was split under us: handle on pte level */
>> +			spin_unlock(pvmw->ptl);
>> +			pvmw->ptl = NULL;
>> +		} else if (!pmd_present(pmde)) {
>>  			if ((pvmw->flags & PVMW_SYNC) &&
>>  			    thp_vma_suitable_order(vma, pvmw->address,
>>  						   PMD_ORDER) &&
>
>This is extremely hard to review given the existing crap handling here. I'm
>really sorry, but it makes my head hurt (I'm not kidding :) ).
>
>It's completely unclear why we only have to check for a subset of the cases
>after taking the lock.
>
>Could we simply extend the existing migration pmd handling and leave the
>!pmd_present() case for pmd_none()?
>
>That leaves no question to "which transitions are actually allowed", including
>"could we accidentally assume something is a page table when really it isn't".
>

Consolidate all the cases in one place looks reasonable.

And make the logic clearer.

>
>So what about something like the following?
>
>The "thp_migration_supported()" is not required when checking for
>pmd_is_migration_entry(), as that defaults to "false" when not compiled in.
>
>Untested:
>
>
>>From 048ecd33673ec649e168fbbb97749a7c0e344fcd Mon Sep 17 00:00:00 2001
>From: "David Hildenbrand (Arm)" <david@kernel.org>
>Date: Fri, 26 Jun 2026 12:03:40 +0200
>Subject: [PATCH] tmp
>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/page_vma_mapped.c | 29 +++++++++++++++++------------
> 1 file changed, 17 insertions(+), 12 deletions(-)
>
>diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>index 2ccbabfb2cc17..ed2a23a90e8dd 100644
>--- a/mm/page_vma_mapped.c
>+++ b/mm/page_vma_mapped.c
>@@ -243,21 +243,31 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> 		 */
> 		pmde = pmdp_get_lockless(pvmw->pmd);
>
>-		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
>+		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
>+		    pmd_is_device_private_entry(pmde)) {
> 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> 			pmde = *pvmw->pmd;
>-			if (!pmd_present(pmde)) {
>+			if (pmd_is_migration_entry(pmde)) {
> 				softleaf_t entry;
>
>-				if (!thp_migration_supported() ||
>-				    !(pvmw->flags & PVMW_MIGRATION))
>+				if (!(pvmw->flags & PVMW_MIGRATION))
> 					return not_found(pvmw);
> 				entry = softleaf_from_pmd(pmde);
>+				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
>+					return not_found(pvmw);
>+				return true;
>+			} else if (pmd_is_device_private_entry(pmde)) {
>+				softleaf_t entry;
>
>-				if (!softleaf_is_migration(entry) ||
>-				    !check_pmd(softleaf_to_pfn(entry), pvmw))
>+				if (pvmw->flags & PVMW_MIGRATION)
>+					return not_found(pvmw);
>+				entry = softleaf_from_pmd(pmde);
>+				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
> 					return not_found(pvmw);
> 				return true;
>+			} else if (!pmd_present(pmde) ){
>+				return not_found(pvmw);
> 			}
> 			if (likely(pmd_trans_huge(pmde))) {
> 				if (pvmw->flags & PVMW_MIGRATION)
>@@ -270,12 +280,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> 			spin_unlock(pvmw->ptl);
> 			pvmw->ptl = NULL;
> 		} else if (!pmd_present(pmde)) {
>-			const softleaf_t entry = softleaf_from_pmd(pmde);
>-
>-			if (softleaf_is_device_private(entry)) {
>-				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>-				return true;
>-			}
>
> 			if ((pvmw->flags & PVMW_SYNC) &&
> 			    thp_vma_suitable_order(vma, pvmw->address,
>-- 
>2.43.0
>

Will prepare v5 based one this.

Thanks.

>
>-- 
>Cheers,
>
>David

-- 
Wei Yang
Help you, Help me
