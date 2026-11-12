Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472624;
	b=HrO2mxzG66rFoRzt8ON3480rAlfaoanHWl6MgbGyQXQrSIyKCoVSjP1bVTYUQLvAglIX
	 pds/U6NtTv1wrlYllMwtLP5GDNp5CRo5xbmJiBaCI93q4uTE4oIOak2zLnaphTeZBmks0
	 LY4auvqRAyNvqR+3KJzCIQojxLvYc8ykwcV8Ez+mSAb+pssO8wQjsqXg0nu5+NvA8Lrir
	 PBBa9FStrMewe56J5XrdN96TGHRPS3ghjwPLfa2lcB4u+OfkB1M5VBEvv5DM/zwDHTGg0
	 ycfPdss8P+7SCPrkybg5OlMvnsP+Xl5gVowsrcdSJTcRaM1mVaF6qhdOHioGlUuTHLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472624;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=/yEdPtHpJ1NtcQC60gYn0MUtGO5PcvthVLd0v02et/I=;
	b=VZFq4p5oZiseCIxRMBT51vaDRp9/JxgvJz+3tJ65o+9zVQ7VD3MtR1wi9PzPn26cbp2p
	 J1eXLQpzkt8RrITAKw4fcRNlLTeCmaMxUZ9KTHT2/Fw2GWe/qF3dxLIDkE9mORA8hP1my
	 vTeZK9mckEzfEe99l1CL8bUA+66RFGLFoCRmo1wJXr1pxth+xn+ZUu1V4vldAaHxI3Jo7
	 38TGlDCZwSMSNYH+FbtxDbI1+c6q45nGoBvigqM/qlN7ntBdHJx1loAr5Z9eBT5SOngWV
	 GWKz4APjsuSlva+CZGiEsR4PlsfyKXSAGGfuAcG2gT4MMMmysw40xBQVauO8euFnsbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jqYvau3y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C877606A335;
	Thu, 12 Nov 2026 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jqYvau3y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40DE1F00A13;
	Thu, 12 Nov 2026 08:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472624;
	bh=/yEdPtHpJ1NtcQC60gYn0MUtGO5PcvthVLd0v02et/I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jqYvau3yOeSxB1kD7U3L2EBRpoOqvpE7k1VJV+6JuPIQNEtd9OKlj0k96CfLYRUmw
	 k975HhQUdKJzCdMO/SYXH4ORvvUC7VKbCqcZlbKFVngVPOjniEojfCvoswjg2X1f4W
	 AkWZsppHZgrlkxPj0Kkv2cEHcejVuJic610j9dC1GvTynDFVs3YGuqQ9pBMcWRBQID
	 J9dtYWYeCi5vTSp+FKk5fEFFxs3T+WPl/iHlti8oBLV/UWpzvy3B9KXgYxZevgQ52X
	 CalQuYCSTcxyR0EOiUzmQ/G2zhpd5OstOQgaL5U9Z5j5Dsr313YLlfpPJ3IFF/Kw6I
	 ig5dG3E0hkQsQ==
Message-ID: <a2ddd71c-7796-40a8-93df-f0c51aa65ca4@kernel.org>
Date: Thu, 12 Nov 2026 09:36:57 +0100
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
Subject: Re: [PATCH v3 2/3] mm: gup: allow long-term pins of CMA-allocated
 HugeTLB folios
To: Frank van der Linden <fvdl@google.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
Cc: muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org,
 azpijr@gmail.com, lance.yang@linux.dev, Qi Zheng <qi.zheng@linux.dev>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
References: <cover.1794046188.git.zhengqi.arch@bytedance.com>
 <586d6c53ab7e4c64d6e89ad3cf0cf7e07dabbfaf.1794046188.git.zhengqi.arch@bytedance.com>
 <7abb3aa1-385a-422f-86bd-7aac9661c4d8@kernel.org>
 <423c9b28-ecf2-4fab-817d-2fb326690c73@linux.dev>
 <3a1a3bb5-0b01-4f20-aa0e-74a952544b8c@kernel.org>
 <5f68ffba-9f56-4e31-9e7c-9d110f552efc@bytedance.com>
 <CAPTztWb0XbjCxtihyp=Tx16Z_kjF+M8sa7YcUjvFv0WcS83MAg@mail.gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <CAPTztWb0XbjCxtihyp=Tx16Z_kjF+M8sa7YcUjvFv0WcS83MAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/11/26 23:26, Frank van der Linden wrote:
> On Wed, Nov 11, 2026 at 2:27 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>> Hi David,
>>
>> On 11/11/26 3:43 PM, David Hildenbrand (Arm) wrote:
>>>
>>> You resent your series way too fast.
>>
>> Got it.
>>
>>>
>>> Now we have discussions in to threads, congratulations ;)
>>>
>>>
>>> Why can't that be resolved differently? What is the dependency?
>>
>> The dependency is that the new check wants to use
>> `folio_test_hugetlb_cma()`, which is a HugeTLB-specific inline helper
>> from `include/linux/hugetlb.h`.
>>
>> `folio_is_longterm_pinnable()` currently lives in `include/linux/mm.h`,
>> while `include/linux/hugetlb.h` already includes `linux/mm.h`. So I
>> can't simply use `folio_test_hugetlb_cma()` from `mm.h`
>>
>>>
>>
>> The more accurate code path is as follows.
>>
>> Assuming the 2M buddy allocation is successful, page P is borrowed from
>> the 1G CMA area.
>>
>> Now, proceed to request a new 1G huge page:
>>
>> only_alloc_fresh_hugetlb_folio
>> --> alloc_gigantic_frozen_folio
>>      --> hugetlb_cma_alloc_frozen_folio
>>          --> cma_range_alloc
>>                  /* set bitmap!! */
>>              --> bitmap_set(cmr->bitmap, bitmap_no, bitmap_count);
>>
>>                  <time A>
>>
>>                  /* may fail */
>>                  alloc_contig_frozen_range
>>
>>          /* set HPG_cma!! */
>>          folio_set_hugetlb_cma(folio);
>>
>> At time A, for page P, a bitmap was set, but HPG_cma was not set.
>>
>> If a concurrent FOLL_LONGTERM pin uses the bitmap alone to determine
>> ownership, it could incorrectly allow P to remain pinned. If
>> alloc_contig_frozen_range() fails, cma_range_alloc() clears the bitmap
>> bits, while the long-term pin on P remains.
>>
>> HPG_cma is set only after explicit CMA allocation succeeds. It records
>> the folio's own CMA ownership, whereas a set bitmap bit can represent
>> another allocation's in-flight reservation. Therefore, the bitmap
>> alone cannot replace HPG_cma in this check.
>>
>>>
>>> Or simply two bitmaps? "trying allocation - allocated"
>>
>> As a fix, perhaps this is a bit too complex? :(
>>
>> Alternatively, we could adjust the timing for setting the bitmap, though
>> this might introduce new concurrency issues.
>>
>> Thanks,
>> Qi
> 
> Yeah, ideally there would be a way to identify folios allocated
> through cma_alloc. But that would probably require.. dare I say.. a
> page flag. Trying to check bitmaps does seem too complex.

Why?

You know it's a CMA region. And CMA regions are limited and static. Bitmap check
is cheap.

Pageflag likely won't happen ...

In general, please, it's ok to send some hugetlb hacks (that make me angry) as a
quick fix, but please do think about a proper way of handling that.

-- 
Cheers,

David
