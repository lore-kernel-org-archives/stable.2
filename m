Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588BE5464D;
	Tue, 23 Jun 2026 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782200290; cv=none; b=Um5J3HlTqZEylClmnbsYf0ksxrAuWw+PvYKL9AH777CAU8d87uZdouskYHyrRzblTgqU449aojXA0bVwq6TXP8xJjQUlUSWBamdwXWJtdiDPs0rYMqiPNSgK8MYNOvSxp7dmgJtvqbSJE4WXTsKE7DqmCOT+zRWNsctaQmzK3m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782200290; c=relaxed/simple;
	bh=M1bRSkmXt9UgZuCL+nFWg/p6E+DbwAAD9mJUpjz2bvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltp1t260CE+LIm8ow42O8uA2xen4U8Wvw4rvZVVUcXfzJEo5C6nnzrOAeFiDv5nsNSoJzAowsl6dluR/jD/DJe4hZRL6r5Xnkanrt6GDMgWuXdpnODKfH9D3zWcEvEBIwPjK1jwVBezC9RlaS92UjlVM1sliudurT+wC1kwvv6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4Z0q+Kl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4Z0q+Kl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77B61F000E9;
	Tue, 23 Jun 2026 07:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782200289;
	bh=FHfEFJ7PVtVF/XkhuqXOqUMkLOWdHxknOWZpt4309kQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=e4Z0q+Kl8uXqinwgS2MCvdOrSUQfobEN+dGQ0VwVEJRqwENqRMRNSxIK0z4aLduwW
	 O1nvP3uPRGlhsTZpyVnC3iIDyL5BxOUojz+dnCLmgTg1LVWD90CXtdpkFLbcjAhmaF
	 Ja1QMODqgelgU6rd++EwGOT3cx0CoKsMrEBEIenycDvwepB0mrUmx0/CwkeJoJVHjK
	 yqyl4dbTo+LzHcwXzeF8qxIQYG0TLtxiJcz08MUwRf6kBtBPVMKilB4AOe3ZK5Qdzh
	 BvOr0LZpyFqD4K5qmFCQFotkkT/q5pF3F3ZfbxEaZOM6nkvZ+gxvgNWpP/gkOHxzBP
	 tXLfBtqq9Syfw==
Message-ID: <f63df082-914c-4317-be08-e0455d1943a9@kernel.org>
Date: Tue, 23 Jun 2026 09:38:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: page_ext: add count limit to page_ext_iter_next to
 prevent invalid PFN access
To: Zi Yan <ziy@nvidia.com>, Ketan <ketan.kishore@oss.qualcomm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Luiz Capitulino <luizcap@redhat.com>
Cc: kernel@oss.qualcomm.com, stable@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 syzbot@syzkaller.appspotmail.com, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>
References: <20260623-page_ext-v3-1-a89799a5367c@oss.qualcomm.com>
 <DJFYU5ZU3S15.2TM0XSBEOB2EM@nvidia.com>
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
In-Reply-To: <DJFYU5ZU3S15.2TM0XSBEOB2EM@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/26 01:27, Zi Yan wrote:
> On Mon Jun 22, 2026 at 5:18 PM EDT, Ketan wrote:
>> The page_ext iteration API does not validate if the PFN still
>> belongs to a valid section while advancing the iterator. When
>> dynamically adding memory in the hotplug path, it can lead to a
>> NULL pointer dereference during page_ext_lookup at the boundary
>> of the last valid section when iterator count equals __pgcount.
>>
>> The for_each_page_ext() macro calls page_ext_iter_next() as its
>> loop increment. for_each_page_ext() does a
>> "__page_ext = page_ext_iter_next(&__iter)" at the end. This
>> causes page_ext_iter_next() to increment iter->index past
>> __pgcount and call page_ext_lookup(start_pfn + __pgcount).
>> During memory hotplug (online), the PFN at start_pfn + __pgcount
>> may belong to a section that has not yet been initialized,
>> causing page_ext_lookup() to trigger a NULL pointer dereference.
>>
>> [   14.555124][  T846] Call trace:
>> [   14.555125][  T846]  lookup_page_ext+0x6c/0x108 (P)
>> [   14.555127][  T846]  page_ext_lookup+0x30/0x3c
>> [   14.555129][  T846]  __reset_page_owner+0x11c/0x260
>> [   14.571201][  T846]  __free_pages_ok+0x5e8/0x8e0
>> [   14.571204][  T846]  __free_pages_core+0x78/0xf0
>> [   14.571206][  T846]  generic_online_page+0x14/0x24
>> [   14.597782][  T846]  online_pages+0x178/0x30c
>> [   14.597784][  T846]  memory_block_change_state+0x284/0x32c
>> [   14.597787][  T846]  memory_subsys_online+0x4c/0x64
>> [   14.597789][  T846]  device_online+0x88/0xb0
>> [   14.597791][  T846]  online_memory_block+0x30/0x40
>> [   14.597793][  T846]  walk_memory_blocks+0xac/0xe8
>> [   14.597794][  T846]  add_memory_resource+0x280/0x298
>> [   14.656161][  T846]  add_memory+0x60/0x98
>>
>> Move the iteration boundary enforcement inside the iterator
>> functions, so callers cannot inadvertently access beyond the
>> requested range.
>>
>> Fixes: 9039b9096ea2 ("mm: page_owner: use new iteration API")
>> Cc: stable@vger.kernel.org
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>> Signed-off-by: Ketan Kishore <ketan.kishore@oss.qualcomm.com>
>> Tested-by: syzbot@syzkaller.appspotmail.com
> This is probably not needed.

Agreed, we usually don't include this.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
