Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E413A7F72;
	Mon, 29 Jun 2026 06:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715747; cv=none; b=upVzfdGCguB878UYpHOpnSkaKgqkXtLtZCyQT6R3lQOIK2/e7YL3hTUtTJXIrshJyrS84HK1mPH0OUbpExolvX3LafVD0cSlW0XA0iclpMoeqkeZgU/EAZQw4WgMDObfUWypIH8+gQ7lR93mX1HjHpWDBo7uQUnqd4kTgoKKug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715747; c=relaxed/simple;
	bh=WWesDXMaxpr9v0pxKfGfA5W4afJMug2+aRszzj4Irak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFJOJuxIFraXA9BiDp/sLwRoArJO0vXnA0pfdYjNKUYCDhGBs0L8qg57RsJX5coTBgusAhkiKMJf9GmRlsdOqG2JTvDXziF1i9c3ipGy3adRBZXvagGsoZBCDyIFWLZdW97SHWVUBXLUgF2+eFvmPjL8KUrzF+MszViUsDXFmz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qir4B0AP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qir4B0AP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B142F176B;
	Sun, 28 Jun 2026 23:49:00 -0700 (PDT)
Received: from [10.164.19.15] (unknown [10.164.19.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 720CE3F85F;
	Sun, 28 Jun 2026 23:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782715745; bh=WWesDXMaxpr9v0pxKfGfA5W4afJMug2+aRszzj4Irak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qir4B0APt+liPIhMhV/X6VjodvpmrcL2dgZo8y3s/326ijhOw00p77WP5smmRoG6V
	 hHZ+WfMYnb38XwkL6UB2PFIIjGGWwUVgVzDUp3C2tW4fUEj5cGTXjksQ3LQGTiUljO
	 16d5GBzKOj3sW0EgqUgbb11lIqBZzsh8R3C+5lqU=
Message-ID: <1d6d699e-62e5-424f-a147-b7a75b966957@arm.com>
Date: Mon, 29 Jun 2026 12:18:53 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] mm/page_vma_mapped: use huge_ptep_get() for hugetlb
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lance Yang <lance.yang@linux.dev>
Cc: linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de,
 akpm@linux-foundation.org, ljs@kernel.org, liam@infradead.org,
 riel@surriel.com, vbabka@kernel.org, harry@kernel.org, jannh@google.com,
 kas@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 rcampbell@nvidia.com, apopple@nvidia.com, ziy@nvidia.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 mel@csn.ul.ie, nao.horiguchi@gmail.com, ak@linux.intel.com,
 j-nomura@ce.jp.nec.com, pfalcato@suse.de, dave.hansen@intel.com,
 tglx@kernel.org, jpoimboe@kernel.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, stable@vger.kernel.org
References: <82395f5a-31d4-406b-b7ec-10d1a9d067d4@arm.com>
 <20260628054402.76978-1-lance.yang@linux.dev>
 <98f3aedd-de11-4a83-81b8-f3e3c9380e49@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <98f3aedd-de11-4a83-81b8-f3e3c9380e49@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/06/26 12:09 pm, David Hildenbrand (Arm) wrote:
> On 6/28/26 07:44, Lance Yang wrote:
>>
>> On Sat, Jun 27, 2026 at 12:43:31PM +0530, Dev Jain wrote:
>>>
>>>
>>> On 26/06/26 10:16 pm, Lance Yang wrote:
>> [...]
>>>>
>>>> Just thinking out loud: given that huge_ptep_get() already assumes that
>>>> addr matches the huge pte, at least on arm64, would it make sense to
>>>> have a small hugetlb wrapper around it that takes hstate and aligns
>>>> the address before calling the arch helper?
>>>>
>>>> Might make the rule clearer, and a bit harder to get wrong again :)
>>>
>>> Are you suggesting something like:
>>
>> Yes, that's what I had in mind :) thanks!
>>
>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>> index fdb7bdf7645c..xxxxxxxxxxxx 100644
>>> --- a/include/linux/hugetlb.h
>>> +++ b/include/linux/hugetlb.h
>>> @@ -825,6 +825,15 @@ static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,
>>>
>>> #include <asm/hugetlb.h>
>>
>> Maybe worth spelling out the rule as well: 
>>
>> For arch helpers that use addr, huge_ptep_get() assumes addr is the
>> address for the hugetlb entry ptep points to. arm64 already makes that
>> assumption.
>>
>> Callers where addr may not be hugepage-aligned should use
>> hugetlb_ptep_get() instead.
> 
> Do we have any examples where code would do that? I would think that all code
> must properly align addr ahead of times.

Sashiko notes other places:

https://sashiko.dev/#/patchset/20260625112955.3254283-1-dev.jain%40arm.com

> 

