Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C582F7445
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013429; cv=none; b=Lryb28L48D6tvCiNvwN2P/NceC56ICS3RFRr/HNc3tU4MEjBuHMUmRSQ2FZAkNhEWmZz89kQBBSZRbQpKFplvU3gsjtDy7f+jUqsGFhpZaZBTGtiaZfMsiBprQxOErri75wahIw9HnrCZWT8u9BbPB8mc8A+XUeHZQo5gWjRtfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013429; c=relaxed/simple;
	bh=p7WAeC4YhHm17ywsWSph2lKY957RJVCFqP0L0cnHaBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKa+lUCAsrEh8e4x2UI7iR3awmps3rWH16doIV3+mOfdSmv0CmvnZYpcedFvadotxsyQb/+FmcWGK/zIKt9fY0Ap719SlebGbMuOEvsBbIEkxHG9hvWkIHKorvM43MAkMqyJ8Sa9a6IwLMty4hA3ufuloYuIorjD8LOJ8Dn3byA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPZtuL5j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPZtuL5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29C61F000E9;
	Thu,  6 Aug 2026 10:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786013428;
	bh=N6aH3IWhBuvYtU3jyYyQ38Aa7k9zKxtJGVyR123XyKk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VPZtuL5j3tQOtekLQ7kOVDseIfHGH5e5b4IjDJWQWyfGuDyEHmFasxyAg4Znie6lF
	 Cs5dkDB0jrbs5MFYwQbm3F0UpK684wLeGJ7s5CBFVSq1wSeXFnA6k+Gl+G7xtVmHun
	 2nxsLiVNyOsVv6jTwOohQOSd93cii87KioJLnuYwBjdKmHrHNj2AxORBcj0LwPbJsm
	 cVmcA+2urdOJJjPIRDLgo5mMvdKgnkUy9gsWSXaNXDRIzBytPEeDhllvcYEjBy611V
	 4q+gzfRRr48ZCgjM3YHpKL8eEX43RKoz0P7AIhh5YOvIiXN531OhTGkvlkcG2aABiv
	 QVLJhIVXZdzow==
Message-ID: <0726ba54-a500-46a4-b42f-3e581da0f070@kernel.org>
Date: Thu, 6 Aug 2026 12:50:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm/memory-failure: fix folio refcount leak and locking
 in soft/hard offline
To: Andrew Morton <akpm@linux-foundation.org>, dayou5941@163.com
Cc: linmiaohe@huawei.com, ljs@kernel.org, nao.horiguchi@gmail.com,
 linux-mm@kvack.org, ziy@nvidia.com, Li Youhong <liyouhong@kylinos.cn>,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20260806031958.677935-1-dayou5941@163.com>
 <20260805213415.002dc67766271d21c232910b@linux-foundation.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260805213415.002dc67766271d21c232910b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/6/26 06:34, Andrew Morton wrote:
> On Thu,  6 Aug 2026 11:19:58 +0800 dayou5941@163.com wrote:
> 
>> From: Li Youhong <liyouhong@kylinos.cn>
>>
>> The min_order_for_split() function accesses folio->mapping without proper
>> synchronization. In memory_failure(), the folio lock is dropped before the
>> call, and in soft_offline_in_use_page(), the lock is not held at all. This
>> means that while min_order_for_split() is executing, the value of
>> folio->mapping may be modified by a truncate or invalidate operation,
>> leading to a torn read or use of a stale mapping value.
>>
>> Additionally, the soft_offline_in_use_page() path fails to release the
>> folio reference taken by get_hwpoison_page() when new_order != 0, causing a
>> reference leak.
>>
>> Fix these issues by:
>> - Moving the split operation logic into the callers and holding the folio
>>   lock around min_order_for_split() and split_huge_page_to_order().
>> - Removing the try_to_split_thp_page() helper to simplify refcount
>>   handling.
>> - Ensuring the folio reference is always dropped before returning on the
>>   soft-offline error path.
>>
>> This refactors the code to be more maintainable, fixes the locking issue
>> reported by Sashiko, and also addresses the folio reference leak on the
>> soft-offline error path.
>>
>> ...
>>
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>>  static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
>>  		struct address_space *mapping, pgoff_t index, int flags)
>>  {
>> @@ -2440,7 +2420,6 @@ int memory_failure(unsigned long pfn, int flags)
>>  	folio_unlock(folio);
>>  
>>  	if (folio_test_large(folio)) {
>> -		const int new_order = min_order_for_split(folio);
>>  		int err;
>>  
>>  		/*
>> @@ -2457,24 +2436,24 @@ int memory_failure(unsigned long pfn, int flags)
>>  		 * page is a valid handlable page.
>>  		 */
>>  		folio_set_has_hwpoisoned(folio);
>> -		err = try_to_split_thp_page(p, new_order, /* release= */ false);
> 
> AI review asks (effectively) why the try_to_split_thp_page() return value
> never gets used
> 
> 	https://sashiko.dev/#/patchset/20260806031958.677935-1-dayou5941@163.com
> 

No need for AI. Just from compiling:

  └ mm/memory-failure.c: In function ‘memory_failure’:
    mm/memory-failure.c:2492:21: warning: variable ‘err’ set but not used
[-Wunused-but-set-variable]
     2492 |                 int err;


I'll send out a patch myself that already addresses everything raised in here
without even me reading any of it.

-- 
Cheers,

David
