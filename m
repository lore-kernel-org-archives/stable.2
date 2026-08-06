Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD963B5E19;
	Thu,  6 Aug 2026 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027577; cv=none; b=HX//Jelqkcctf5G4XwMSyeSjQgAF1v/ti0au6/2x1qOySr++31w7Zmn9N5qQ/2ItDObjbU+95UV4Pe9yR26w5NLJ4cAYh7Bdjh9Y0oQM/PiWUXdExKmlkvwpJY0LZNdm1lx4z5bcqaULNmzj2WCh6dbgHekO0ZIebVtqrbXFrCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027577; c=relaxed/simple;
	bh=YiWRvriqBAwprbyF+M/bEP8YIJ201iH2QJ894+f3T5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNQH1Rv7j4nyuHLG+5YGN4DmlHh3d7R6D+ZRX2nhXpvY9o5fi0gq9B9kyGAxVnOgFDaCJsLPk+aVEnahdGuI9vCsb1AZsTxGe7jvcODVMTmSEPScpX6vD7mjGtrTe1RcszgPEv5uWl7VtugxXGXAjSlFgIgJcK3X8wLD9obzqXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fG40pG16; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fG40pG16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CFB1F000E9;
	Thu,  6 Aug 2026 14:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786027575;
	bh=zVVXlaTnBYF/ekwzgsDSJAn7TZ61QOuIyfdPBNwKdCI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fG40pG166OM8jzPPkb2ZK/w/cpvQptOPzm2T8h1CtxrBlwfy5njAlCU5Dvi8roCzc
	 a0sdv2cow5GvaZUpGBmg65PMv7QobLhKyo1wlkZj1HYVKdmhVKDSwPfa3TcDjBbMD3
	 62Ao1eNcbpP2K3Obd/1NQ6ZpskaeIeY1nl17fDpVBFJyMCdKjaBHQmJuQ8jpHgKCIk
	 j7jM4v5FAmpZ3Uu+b1SggTu/VIK0YmN4g9+4xYeOQE8Q2nZjXmpJtwbgcG2Bz8sVOr
	 zhKh72Gniu3K+OVNLbiGbOyRhy7zwB1tAhq9pifFtHR6DskP9c3lDY1UYvtuLyt7rT
	 X5lo+9FxqBNOw==
Message-ID: <a6a9e0cc-e6cf-4f83-b6be-7d64058b8fa6@kernel.org>
Date: Thu, 6 Aug 2026 16:46:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/madvise: avoid skipping pages after splitting large
 folios
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Yunhui Cui <cuiyunhui@bytedance.com>, akpm@linux-foundation.org,
 liam@infradead.org, vbabka@kernel.org, jannh@google.com,
 00moses.alexander00@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260806055501.56761-1-cuiyunhui@bytedance.com>
 <anQyoZgi5Urnvvjw@lucifer> <919b804b-6f1d-417e-9c0c-d06f50d765d8@kernel.org>
 <anSar_i8UjniSbML@lucifer>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <anSar_i8UjniSbML@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/26 16:34, Lorenzo Stoakes (ARM) wrote:
> On Thu, Aug 06, 2026 at 01:35:30PM +0200, David Hildenbrand (Arm) wrote:
>>>
>>> Let's at least split out the folio check into a helper to make things
>>> clearer:
>>>
>>> static bool poison_splits_folio(const struct folio *folio)
>>> {
>>> 	/* Hugetlb is, as always, a world unto itself. */
>>> 	if (folio_test_hugetlb(folio))
>>> 		return false;
>>> 	/* Soft-offline errors out, hwpoison traverse DAX intact. */
>>> 	if (folio_is_zone_device(folio))
>>> 		return false;
>>> 	return true;
>>> }
>>>
>>> Then for your patch:
>>>
>>> -		size = PAGE_SIZE;
>>> -		if (folio_test_hugetlb(folio) || folio_is_zone_device(folio))
>>> -			size = folio_size(folio);
>>> +		size = poison_splits_folio(folio) ? PAGE_SIZE : folio_size(folio);
>>>
>>> I tried writing something that was neater and nicer but AI kept pointing
>>> out how it was totally broken and I really really hate this code (not your
>>> fault :).
>>
>> No, I don't think any such special casing on folios is the right way to handle it.
> 
> I mean the issue here is the stride varies depending on whether the thing is
> hugetlb or not (and some weird DAX thing), and the poisoning causes a split
> otherwise so if you want to poison a range you have to account for that.

We GUP'ed a single page and now try to be smart about which other pages we'd GUP
next.

That's just wrong, and hugetlb special-casing is just ugly.

The problem here is that, if we GUP'ed a page and poisoned it, the GUP'ing the
next page might fail and we'd return an error.

But maybe that error can simply be handled? We have FOLL_HWPOISON.

So maybe we can just use FOLL_HWPOISON and skip over the entries that already
return -EHWPOISON?

-- 
Cheers,

David
