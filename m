Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5650237DE90
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524701; cv=none; b=RE0qVNBe3nk0nzhhm5wM0tvgieprhvKP4qhqXMw0GfTtN6SOkM0ae2JrF5xiGzzz/IBSa2t+V6ap65OqtnZMEBjUMi4Le+ZfTM6VMmp/oHLJ+Ie/VHd/jowrTLPEmmh8NivJoPV9jJkIq9laagtM6TWI/VPjeR+53NReYELDpec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524701; c=relaxed/simple;
	bh=L7fk/4qLaxRDYCD7ibe4niYeMQzHBYURzEMuLpzu9Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnDPAhR0h0hjI8XQwWRp8Ble2ha6tBIOv9MO+xaD97XYD7JaH9eYjSsWTmDKrvN/cVig3UZ0rJ93xc1BsbrQwoGn2nFqMfhbUS4g4kST5wYadZIcOLf0DsiJKsx80AD7B6PvcZiZJiKLkVONAgOveJEvDJ3Ws4IvB7nfNC9Obco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luqAq5Ws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luqAq5Ws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C3B1F000E9;
	Mon, 15 Jun 2026 11:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781524700;
	bh=nob7Ef0LhlOFzeo/NONUfcSw5/BZ0C2rsatl1k+CwG0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=luqAq5Ws195uyaNNIqx+TtXLqYwS693yXltM2TcKwMEPE9xcEJ9gXkebKd6da5RvT
	 aAetj7reft8CUSF4tJAD9LUsRfwVv1o2iMAeKI/D7fY+9cxkdZ8RXhupWE6A+X0sNy
	 70pSyWH+eg6GmOqPpzWKo59VOZ0tk8aIB7nMONpv10msu/A1w2CjvA7BTKHvlLk6N6
	 dnfzbUvRsGafRRh5PlQymk0GdV65M+uNECKCD6FD5LatW1RC9OMb1pD8sOcqeir4Tx
	 8O8slBqcLy7jGqX7aUP7Xe7pJfZyrQqbfh1MxNrMTin+UGI3DGmGdHLxFhBTsdAGKT
	 O/UMy/Lz0NpJw==
Message-ID: <2d48ef0d-1110-4a9d-adcb-f701a1ce2cfa@kernel.org>
Date: Mon, 15 Jun 2026 13:58:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check before
 return device-private pmd
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Balbir Singh <balbirs@nvidia.com>, akpm@linux-foundation.org,
 ljs@kernel.org, riel@surriel.com, liam@infradead.org, vbabka@kernel.org,
 harry@kernel.org, jannh@google.com, sj@kernel.org, ziy@nvidia.com,
 linux-mm@kvack.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 stable@vger.kernel.org
References: <20260508013728.21285-1-richard.weiyang@gmail.com>
 <5e9ee072-b927-41e0-ba98-c9fdf11eccbc@nvidia.com>
 <0aab59b8-71c5-4059-8281-5dd876946528@kernel.org>
 <20260512143542.izpp3gu4iqxttw3f@master>
 <113dddc5-27e3-4e9e-a90c-f076a4629f51@kernel.org>
 <20260612024840.qdw76serbgj67yrv@master>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260612024840.qdw76serbgj67yrv@master>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/26 04:48, Wei Yang wrote:
> On Tue, May 12, 2026 at 08:55:47PM +0200, David Hildenbrand (Arm) wrote:
>> On 5/12/26 16:35, Wei Yang wrote:
>>>
>>> I tried to compress above logic like this, hope it could look cleaner.
>>>
>>> 	if (pmd_trans_huge(pmde) || pmd_is_valid_softleaf(pmde)) {
>>> 		unsigned long pfn;
>>> 		bool is_migration = pmd_is_migration_entry(pmde);
>>> 		bool for_migration = !!(pvmw->flags & PVMW_MIGRATION);
>>>
>>> 		if (is_migration != for_migration)
>>> 			return not_found(pvmw);
>>>
>>> 		if (pmd_trans_huge(pmde))
>>> 			pfn = pmd_pfn(pmde);
>>> 		else
>>> 			pfn = softleaf_to_pfn(softleaf_from_pmd(pmde));
>>>
>>> 		if (!check_pmd(pfn, pvmw))
>>> 			return not_found(pvmw);
>>> 	} else if (!pmd_present(pmde)) {
>>
>> It's more compact, but not necessarily cleaner. In particular, I detest
>> pmd_trans_huge(), we should phase it out.
>>
>> if (pmd_present(pmde) && !pmd_leaf(pmde)) {
>> 	goto pte_table;
>> } else if (pmd_present(pmde) || pmd_is_valid_softleaf(pmde))
>>
>> ...
>>
>> Might work as well. But once we add support for other softleaf types, we'll have
>> to touch it again. So I'd rather just list what we actually expect.
>>
> 
> Hi, David

Hi,

> 
> I may not follow you. Just want to confirm whether you prefer this goes as a
> fix first, or you prefer it goes as what you suggested here as a cleanup?

I guess we should just do it properly when we're touching the code already.

Does that answer your question? Will you send a proper patch?

-- 
Cheers,

David
