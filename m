Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A07738425D
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788619108; cv=none; b=M6q+/aK5oKWwgyGzrm56Ro+75ob+sn7m8PXNomqd5V7y1cwFmy4DxHOsT3wfi/PLzqWUQfOo0wPTqiwhX8UH2QkYdubw3ozjtcjoZ1iMfSiEd8RIYfo8TfoHDfl/9sqXlEzHMTfnMh9WkFPJxKa/BlEG4wxDz1KPrH+3hKDdRQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788619108; c=relaxed/simple;
	bh=oL+UpvR0Ws/4ztxx9Wj8ZW20LmfrIZGrNIZomqiGoRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eFbOCil3YTXN72GWvi7kJRKWFvtRQrY3TgOM2fvbI36iDJgNUZB7BUObAlbhDoacALrzyURppvnq81DsTglaKoYZSVI9mV1GSzNRXC1ScOtlR4JvT2jReAHwgiaOwXPx+WX3hgKq0/IalRQuq8Eomru4leOY9hLBjNMtKPWntpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rhr3im9k; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhr3im9k"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482e1b55da8so183043f8f.0
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 07:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788619104; x=1789223904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bgr3+khAnx0iVqd1Ke/nb0IvIRH5AlZC9ffEpGHjQjE=;
        b=rhr3im9kJNVVcRG357PUndhIHoMG5vyiith7aWZ0HdEgx6wL3JhPyVUvexh3mRxoyB
         Pzc14LOnwRWpLpqS8d0OFnKPRuqGHF8BS5iaXr7d5lva0n09xSEAFJdSZG24VNcHISow
         k6gOncmgB0+rzi2DQvcjLyGbUqRBbVOoYrbUv3Ar/F2qgY6ELP7vNeYDUIoTmNy9c2kL
         qYaZFA1V9cePLbdHes6LTxB5mColXjDKDHTjMoS/MUmbhMEDHFMNtASFyLYIEcXtYb+i
         FWwJ+2v76Jw3wybvZC4NLaq4kSQR2RXJloLt1D+ilW67OoZu3azyL6VS1nPxRbnH3ifR
         Wlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788619104; x=1789223904;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bgr3+khAnx0iVqd1Ke/nb0IvIRH5AlZC9ffEpGHjQjE=;
        b=ODMVNrOnOiPigZoAczmoqiZdlAf+mMJfSgrrxrVWzBHNDKfGIF+Uon+XMRqxNduwfv
         yE2FfAefd00hOsC/OrNS2gRnXOeajVzLpy/BaLTYIJ39frshgetZALsi46ZT7NUXYSJt
         Q0Whz+y/z8vJQLFRxA9oihfYv1/XLC/r7WzPEg9aLVAP57OGq7FZgx+cm2j9ChfBiiHq
         lCwi7rRVCfLwuhYKWdTrogtOilU1v12HTmheddGYSr5aLvwAzdz/3/iKxLH3Vjs07yAQ
         mQ55xoyuNVLOFWa2BWGnkCTU25LMPV/Dsoq58BZRqDy9w3Pb9ajliWJqLqldCDBgcO4s
         b0sQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPkD8u6AQUB9xqrn8MRlPYhJI9FlG5C2U+pJC1rKOJTrlQPVpwAhBrsezn9zOBt4s+cbbVdz0=@vger.kernel.org
X-Gm-Message-State: AFuF++mcCnIZhvCAqIQ7VIQbhOfWSCQXwc7TNEvqX02mnNZPA92VPTuh
	3bkLFup3MZxDaumUQoFFXBPNtfh+LXJPexwMkWgcBonBq+uy0JqzlamQLuTk4A==
X-Gm-Gg: AYBFou34BTzv1Y2D5eoQHuFVAE8hZt49anEqgjCgedby0D16JCYlBOgh7nuuSSa5Sce
	PnfqyrFZwa7C0Wec1B3IJINbGqfOrHbVPmr3RGhnNrWCWXwqGF1Gj+JY5ZPyCDfgdh19c3jBNPZ
	1HvZWJPCyNHgWpqqJx/8aEAnlK5H50urAZx+M+HGy4a39Fr5bfdMuQmFCV0x/2EfK474t7OLHPT
	iIfHjts7ifL/qcGtapjDijCNQvwYMb5NZFlefeDoTapyHEHxh+EyoG2tQS6+ZvlxfOtHr1BgpXj
	nlo77exETt/DQINluNi3VENqeyVb3eYDa+Zm62qCbrYvUqPoPJNy82odP/T2EN60yZ8sxMAkIab
	cPj51WgKyQSkSXkIdY3XoChUe9xEq8DKm/RYkj3Q+zUWuC+pqwxyb0Gjw+8meTKb1yxxmfJTxYQ
	eU0YUrQVkwmS0S0IKKdpEZwMadug7URQ85Ma0Ygov2/BvGECaL+sGsfC9NflEirSY6NJeYW2y2j
	HZloYBaddZKHOOqTN45tgHId4rAHDxs7K0Y14hW+J5xMB1KEMTgflS05MBsFI/U1QMZK581CUVl
	25d+EhEUr5ZX9GvPtwe6HfUnOEF2M+uQTGV8AvzfX4BiVidQE6f8zYMc9TqrqNL1WtwNfpjDf7p
	SaSY2Yz5BuZFSbgkuzyzEMPjPKdJ3/tqzaA8fW3kGiiGj1q7qNKiZjFmQOTcIDw==
X-Received: by 2002:a05:600c:34c5:b0:499:cef6:104c with SMTP id 5b1f17b1804b1-49cf823c012mr100916335e9.1.1788619103371;
        Sat, 05 Sep 2026 07:38:23 -0700 (PDT)
Received: from ?IPV6:2a02:1813:4880:5700:9afc:84ff:fee0:5961? (2a02-1813-4880-5700-9afc-84ff-fee0-5961.ip6.access.telenet.be. [2a02:1813:4880:5700:9afc:84ff:fee0:5961])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d00a5b19dsm72767055e9.2.2026.09.05.07.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 07:38:22 -0700 (PDT)
Message-ID: <e3626c4c-e717-4ce9-b7ba-b22f20ad80c8@gmail.com>
Date: Sat, 5 Sep 2026 16:38:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 038/552] mm/page_vma_mapped: use huge_ptep_get() for
 hugetlb
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20260904045747.813364717@linuxfoundation.org>
 <20260904045748.693901462@linuxfoundation.org>
 <d61b56b5-d874-4e50-a83f-8714da4641e9@gmail.com>
 <2026090537-postnasal-flip-f547@gregkh>
Content-Language: fr-FR
From: =?UTF-8?Q?Fran=C3=A7ois_Valenduc?= <francoisvalenduc@gmail.com>
Autocrypt: addr=francoisvalenduc@gmail.com; keydata=
 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
In-Reply-To: <2026090537-postnasal-flip-f547@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 5/09/26 à 13:54, Greg Kroah-Hartman a écrit :
> On Fri, Sep 04, 2026 at 11:19:06AM +0200, François Valenduc wrote:
>> Le 4/09/26 à 06:53, Greg Kroah-Hartman a écrit :
>>> 6.18-stable review patch.  If anyone has any objections, please let me know.
>>>
>>> ------------------
>>>
>>> From: Dev Jain <dev.jain@arm.com>
>>>
>>> commit e87df0d5d6962bde50f55f6d02b779daa394f894 upstream.
>>>
>>> check_pte() is the final validation step in page_vma_mapped_walk().  It
>>> reads pvmw->pte with ptep_get() to decide whether the entry maps the PFN
>>> range being walked.  For hugetlb VMAs, that pointer refers to a hugetlb
>>> entry.
>>>
>>> On arches which provide their own huge_ptep_get() to dereference a huge
>>> pte pointer, accessing via ptep_get() would cause pte_pfn(), pte_present()
>>> etc to misbehave.
>>>
>>> It is not clear whether this has a trivially visible effect to userspace.
>>>
>>> Use huge_ptep_get() to dereference a huge pte pointer.
>>>
>>> Link: https://lore.kernel.org/20260703114202.365553-6-dev.jain@arm.com
>>> Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>>> Reviewed-by: Muchun Song <muchun.song@linux.dev>
>>> Cc: Alistair Popple <apopple@nvidia.com>
>>> Cc: Andi Kleen <ak@linux.intel.com>
>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>> Cc: Byungchul Park <byungchul@sk.com>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Dave Hansen <dave.hansen@intel.com>
>>> Cc: Gregory Price <gourry@gourry.net>
>>> Cc: Harry Yoo <harry@kernel.org>
>>> Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
>>> Cc: Jann Horn <jannh@google.com>
>>> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
>>> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
>>> Cc: Jun'ichi "Nick" Nomura <j-nomura@ce.jp.nec.com>
>>> Cc: Kiryl Shutsemau <kas@kernel.org>
>>> Cc: Lance Yang <lance.yang@linux.dev>
>>> Cc: Liam R. Howlett <liam@infradead.org>
>>> Cc: Lorenzo Stoakes <ljs@kernel.org>
>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>> Cc: Mel Gorman <mel@csn.ul.ie>
>>> Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
>>> Cc: Oscar Salvador <osalvador@suse.de>
>>> Cc: Pedro Falcato <pfalcato@suse.de>
>>> Cc: Rakie Kim <rakie.kim@sk.com>
>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>> Cc: Rik van Riel <riel@surriel.com>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Cc: Vlastimil Babka <vbabka@kernel.org>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> ---
>>>    mm/page_vma_mapped.c |    8 +++++++-
>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> --- a/mm/page_vma_mapped.c
>>> +++ b/mm/page_vma_mapped.c
>>> @@ -104,7 +104,13 @@ again:
>>>    static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
>>>    {
>>>    	unsigned long pfn;
>>> -	pte_t ptent = ptep_get(pvmw->pte);
>>> +	pte_t ptent;
>>> +
>>> +	if (is_vm_hugetlb_page(pvmw->vma))
>>> +		ptent = huge_ptep_get(pvmw->vma->vm_mm, pvmw->address,
>>> +				      pvmw->pte);
>>> +	else
>>> +		ptent = ptep_get(pvmw->pte);
>>>    	if (pvmw->flags & PVMW_MIGRATION) {
>>>    		swp_entry_t entry;
>> This patch causes this build error:
>> mm/page_vma_mapped.o
>> mm/page_vma_mapped.c: In function 'check_pte':
>> mm/page_vma_mapped.c:110:25: error: implicit declaration of function
>> 'huge_ptep_get' [-Wimplicit-function-declaration]
>>    110 |                 ptent = huge_ptep_get(pvmw->vma->vm_mm,
>> pvmw->address,
>>        |                         ^~~~~~~~~~~~~
>> mm/page_vma_mapped.c:110:25: error: incompatible types when assigning to
>> type 'pte_t' from type 'int'
>> make[3]: *** [scripts/Makefile.build:287: mm/page_vma_mapped.o] Error 1
>> make[2]: *** [scripts/Makefile.build:544: mm] Error 2
>> make[1]: *** [/usr/src/linux-6.18/Makefile:2051: .] Error 2
>> make: *** [Makefile:248: __sub-make] Error 2
>>
>> commit 70010ab9a9eb7aee65f42ddc20835806759b4336 ("mm/migrate: use
>> huge_ptep_get() in remove_migration_pte()") gives the same kind error.
>>
>> If I revert those 2 commits, compilation work fine.
> Thanks, I should have this fixed up now in the queue.
>
> greg k-h

Indeed, it works correctly now.

François Valenduc

