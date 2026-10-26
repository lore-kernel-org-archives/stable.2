Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057110;
	b=ccwBMxIfAaneZNCs2fyKKq33b0DGhxv9AhL/GiWRPymeo7v3hRh1kCtllTuYaECED3iY
	 PTJ15p78fJCAZhgGUd4Ut366YH0RZj3c7inaZ20KJOBmgyNKVHDjBk6aQ6MHQUP1Ge+us
	 xAxKY6izmtryqpZRQ0r20FBTglFyPAWdqvUO2+XyTg7o9cLdmR9wT+7uFDUhf3ERQaEpT
	 mXtwcsIEr9MN3SmQjV4jAdgC7ZGhbzQYtbCDI+1mi+NdDxMNGooDEKlHb/F+wD0B7Sotf
	 95T9ddjCh+odg4oRJY5DBTaWUA/hK4z9A9X6VW8S9nEdLYmd9a7EIgi8xYy2XTwHFUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057110;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=k1Zlag/DNuh0RzHvANliw7JgpC1PTEsuWY1OUAoAx8Y=;
	b=bubcF0xYsaXWb3JZISz30+BIaBuhFaFtwrku5SaoLYv0pftCltNqipYtixiB4+KeaEE5
	 6wgoKRP5M4Q1Y/fCJ7nBHPrAjG+BIi24Hm1mia6fKNuZCouWQ/sLFVA3cyhJXiIF6MulP
	 JSv1VjWs1z7NP/o3w86O92HrnxBcP6+x/5ZQiPH97j1l6whtMRaCmTSGYQK+XSS7KbjD8
	 FI9W3W2nW/aPVZkC4D9C3WkRWGHyK1wcMbIYIYH6dWsP9wzwGSpiJrZc+aczfixwXNXp1
	 xrI6JO5S1BJZzhbhAuH8HAF0J3qKymlXAegoSOr2yrxAW6shHU3QWOSrOqbMTTq4dpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnLEbREK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF89606A321;
	Mon, 26 Oct 2026 23:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnLEbREK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE9C1F031E0;
	Mon, 26 Oct 2026 23:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057109;
	bh=k1Zlag/DNuh0RzHvANliw7JgpC1PTEsuWY1OUAoAx8Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fnLEbREKUCIw3x3D22mrcZnRxIlnJim3GobgkFHE+QN5rPvlAjVqot2WvzRAG1xKA
	 5H7kD8aq2n70G55NtkQDHhj7rYvSZefDvllEGiQIq5tVGRQZnpBGDZwlWt9kr9nXjD
	 KT9w8JmxAv+rDcqcSEaH42DuiiIcSduz+eeDMkp8Eb1qL9xHOOIwY9t463bHSIcHJa
	 qlO6fVGU43GVMPDuQtga3X8z75Z/YHhduXBbnXNHKzHp32YroM2VQCfMAvUvQqY/0h
	 5hSZkqRt/bf2hTQsQcrmxRUn1ge8dnuh0mYqMYmY13+1QLbdmwGOEsVckCCPrZ2ejt
	 y29huz6g4kJCw==
Message-ID: <f0029758-5f2e-4c26-9b25-dbc4b3f33701@kernel.org>
Date: Tue, 27 Oct 2026 00:24:46 +0100
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
Subject: Re: [PATCH 07/16] mm/shmem: avoid moving the truncation start
 backwards
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Lukas Czerner <lczerner@redhat.com>,
 Carlos Maiolino <cmaiolino@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Stevens <stevensd@chromium.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 William Kucharski <william.kucharski@oracle.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chris Mason <mason@kernel.org>,
 stable@vger.kernel.org
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-7-703206d5fa0c@kernel.org>
 <2E377C76-D62C-4A2A-94E3-ABC40C6FCDD2@nvidia.com>
 <583728ed-dc63-4685-9ac5-5a980db55973@kernel.org>
 <B1241F56-8000-411D-A137-24596E599C85@nvidia.com>
 <0D22B04E-5730-4D3A-ADA6-9F1AF94F06AA@nvidia.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <0D22B04E-5730-4D3A-ADA6-9F1AF94F06AA@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/27/26 00:16, Zi Yan wrote:
> On 26 Oct 2026, at 18:39, Zi Yan wrote:
> 
>> On 26 Oct 2026, at 17:13, David Hildenbrand (Arm) wrote:
>>
>>>
>>> How confident are we that it fixes the same issue?
>>
>> The issue here is that folio_next_index(folio) used in the mainline
>> code can be an index lower than lstart and the fix is use max()
>> to prevent start going backwards. (I wrote this to make sure
>> I understand the issue correctly)
>>
>> Zhang Yi’s patch passes start into truncate_inode_parital_folio(),
>> which has a new signature, and it is updated with the folio’s index
>> within the [lstart, lend] range at the beginning.
>>
>> So this patch fixes the issue at the caller and Zhang Yi’s patch
>> fixes the issue inside truncate_inode_partial_folio().
>>
>>>
>>> Does it also cover #8?
>>
>> No, patch 8 is still needed. I am checking it on how to rebase it
>> on mm-stable.
>>
>> Patch 9, 10, 11 might need rebase on mm-stable too.
>>
>> Since these patches are on top of mainline instead of mm-stable,
>> you will need to rebase them. IIRC, Zhang Yi’s patches are needed
>> for ext4 + iomap buffered I/O conversion. Hmm, but Zhang Yi’s
>> ext4 iomap patches has landed in mainline but its dependency
>> is not. So we cannot drop Zhang Yi’s patches and ask for a
>> resend. Adding Zhang Yi here.
> 
> To clarify the dependency, without Zhang Yi’s
> truncate_inode_partial_folio() patchset, the ext4 + iomap changes
> would cause data loss. We probably want to get Zhang Yi’s patches
> in first to avoid that.

Ugh, what a mess.

> 
> Patch 7 to 11 do not apply cleanly on top of mm-stable due to Zhang Yi’s
> truncate fix, where
> 
> 1. patch 7 can be dropped as I discussed above,
> 2. patch 8 needs a folio->mapping guard for the added statement,
> 3. patch 9-11 can be applied with fuzzy, but I need to look into
> them about functionalities before fully trust what LLM says.
Yeah, let me take a look tomorrow.

I cannot put into words how much this shmem + pagecache shite annoys me.

What a piece of crap people created here. And looking at the massive changes to
fix stuff, what a piece of crap people are creating.

I better go to sleep now :)

-- 
Cheers,

David
