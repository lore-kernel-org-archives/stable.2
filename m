Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234442;
	b=RgDAtg5RQxpg4dwZZDpUZ3GL7wBmo+futaYb0cob0FSe5Ym17oTPmgQdzQZOi1mR6+9I
	 3ZFnsLc1VSzvbPT+fOaDiD0BvLg0EoMIcBk7kCZHnOREO1wlz2vSh00D3bHn4vzTFtZ4O
	 GsSnrt3P61lxbWceSbBauxVzxaOVfxJ1IPMvvS9Ebmmj8EsmiNRBvNh+3lykhUXRtf4HN
	 5bZYbkMpOwKVTKqNrj6CLJv52sBxq3yvYwGfIx/bepB0EZFHSeaVn8V8qJWODMcHct0ln
	 99qMun3UswMuOPMKo/5iS94oexfTgqms1UY7NNqgGXQPqcieQAeIE3wY5G23jg4hAgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234442;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=DQBR/dBCMcYTXkdOeOOog1rJR98U8AmPJCb23jPzIvA=;
	b=AlhI2kHAc6NsWIVR1SBbOjwINFc7aAOgIExbhqyW5yXqyOPgpz/jPWZgx0YLPpLHoMEx
	 0nzJycpMcavClExChuOar+PWUjvaWh9fF5qhgC7koH2KBKH9Cu92m0GZQ7jDL8+wNetrW
	 RWV3QuZLagM3VRb0/BO2jx41Y609gyDHdGdvhBk9+90VXQwTzDijHatjZQFu1Li4cuagZ
	 rcnzn1xTABDlQ3zfcPeDz+zBja6aioPDzO1RQRJKxtgtkbqsD1zTQvfU0VzhkkKOR02AA
	 OcZiBQ0cuSNmA8I83auyKoQii4/m5sDNG9GuY3xOJb3U2yMYnI8ax+kQMMiZLJMdGIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C3H8wQYE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4763606A326;
	Mon,  9 Nov 2026 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C3H8wQYE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83B31F0089F;
	Mon,  9 Nov 2026 14:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794234441;
	bh=DQBR/dBCMcYTXkdOeOOog1rJR98U8AmPJCb23jPzIvA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=C3H8wQYEaereW5Y+ykz1l50Et0cRmZvNz5OyubO8k6Mzm3JRcJ8ZwAzbIpn1O0VnW
	 WoQZamewYE3OxZzQIlKv3AdsQpU4iqUvDUDOUFFBxGhaas9ujo4Rviw5CnK1wasFNZ
	 BUbvNzWWpx8nshdFgRq/q4q6yeNnrkSKKxHXxuWA1lNtb1Qdi219igtdjcLi+Ld4bM
	 PZPeinVRzFXxJ1Ls9Oa8cCwUWPLcmMFskJLS5DmV9kGsMA4Qcpf6ev0HbUWLZBFjBw
	 eLU5zsQLYsYo7mXGzMGvrSGOBEjSMBn1GmAXyNmOInW70mml0WujDbfWK6rByi2MN5
	 ZGKuwK5yM2DAw==
Message-ID: <07b298ca-d258-4cda-b5ae-0231ec39e033@kernel.org>
Date: Mon, 9 Nov 2026 15:27:15 +0100
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
Subject: Re: [PATCH v2 2/2] mm: don't allocate a page table under RCU in
 do_set_pmd()
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
 Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261106155604.3999641-1-usama.arif@linux.dev>
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
In-Reply-To: <20261106155604.3999641-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/26 16:56, Usama Arif wrote:
> On Fri, 06 Nov 2026 13:36:13 +0100 "David Hildenbrand (Arm)" <david@kernel.org> wrote:
> 
>> do_fault_around() skips PTE table preallocation when the PMD already points
>> to a PTE table. A concurrent collapse can then retract that table and
>> clear the PMD before filemap_map_pages() locks the new PMD-sized folio.
>>
>> filemap_map_pmd() can then call do_set_pmd() with an empty PMD and no
>> preallocated table. On PowerPC hash MMU, do_set_pmd() then tries
>> allocating a PTE table to deposit. But filemap_map_pmd() calls
>> do_set_pmd() under RCU, so allocating from that context is not good.
>>
>> This race became possible when retract_page_tables() stopped taking the
>> mmap and VMA locks. Previously, those locks excluded retraction while
>> the fault was in progress.
>>
>> Add a may_alloc argument to do_set_pmd() and pass false from
>> filemap_map_pmd(), so we can fail with VM_FAULT_FALLBACK instead of
>> trying to allocate.
>>
>> This issue should be fairly hard to hit in practice.
>>
> 
> Yes, I imagine it was very difficult to reproduce, doing a sleeping
> pte_alloc_one() inside filemap_map_pmd()'s RCU read-side section
> when a concurrent retract_page_tables() empties the PMD. Only
> possible on PowerPC.

Yes. Did I express how much I hate us having to support this ppc handling?

I'll buy you a double digit number of beers if you manage to rip that out ;)

-- 
Cheers,

David
