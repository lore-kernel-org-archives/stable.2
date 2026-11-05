Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907909;
	b=w69RBcixzLnsMyomrcMAAw4e/yJ6ABL0p5XMdw/D8w0+mnbsKEEh5ZEh/o0b8YRr0JHT
	 XYgquNcogMvl6TBYX3i6UpBJcp9yA/kgOsrQBSXbw+560C8KPmCKvMHuO2mYg/TYHwyfL
	 qZ91zslXOkUITw7mYxjmu75GPqjez+QwWesKBkNhnjWkheOpkymDhgi9UHZ3saOKYVW+8
	 n44FZUkZ6MuDKhZlF353Otu9Maez/309lLb2WZkZOzSb9PAcO6VyHU4e+HWb6N86GNm0M
	 VLwTdI/Zo++rfDNYtd2U6Hm6wc2f7QOJADd6a1/NMrLfMJjTZtQEGhRZYJ94wZYvouw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907909;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=SwwRFdOw4oikJB0l/UHgh6k09vdq8uhcaONY4VtARHI=;
	b=gki25+JrvQiO7v+vPPbg2tTTae4TlINP/daQUjqVbKcQCil1V6eIYfEVCKu7jUUNvkS2
	 tJ4P1Od9U8i45g4jTZIaGJu8TGvGtTgNH9T27JH1dPNfaxyBKAipwIsd8HtQ5SnXqSCwk
	 Hr4tXlw1Ej9hXawWPz54q/or6hFImL0SjdfclkWyVtbU1zbs80R5YPg5z20hptdI3ZB4N
	 0Bgl/llKWFI8vnJrCuXdd2qLuJ4afSDNG5qQsqexB1b/8TkEH5KPZ2f988UbDdPyln6o2
	 p9OGsbOGCI1IB9kbeE3DKHcp9jGN0+DtNJSilzrG5tJEDEndUKMlgn4RAoGpfut3TVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aFwEUG2M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545506077B6B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aFwEUG2M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873C91F0089F;
	Thu,  5 Nov 2026 19:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907908;
	bh=SwwRFdOw4oikJB0l/UHgh6k09vdq8uhcaONY4VtARHI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aFwEUG2MRn1cnJpuFDp/RuKE9w9V7lQIsGOnP+6tTnyE/o+7hi44rof4K7A+A3/Me
	 LmB3NQaaHG6Fw2IrsEZpWvYrsQBeciPKqPKDDvMLdqAHh9VXKDxH+XfG1LPLQmeRmj
	 no7/Zzpy/GXlRZUJlEW5ZkBLjhGd8f06ItJIzyvVBwK6w95Dz84AIIc1C8XuceM6qX
	 rTKNcm1C+hQTK/1QoRjbmbi6KHnumMPsIKiRb3/lONH2lBIXPu+3e6QCMoERTTzkyW
	 B8zlJp5LEpjW8FeIL8f6UVFUDO84dKju21/n+JzAdWWTt6R/kgW6epXpVOpCWcJ5vi
	 1n+OA1XrQzQEg==
Message-ID: <ac54a9f6-e21d-4f03-88dc-6562afd59cf6@kernel.org>
Date: Thu, 5 Nov 2026 20:45:04 +0100
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
Subject: Re: [PATCH 5.10] mm: replace free hugepage folios after migration
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: linux-mm@kvack.org, yangge <yangge1116@126.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <21cnbao@gmail.com>,
 SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mark Bundschuh <mkbund@amazon.com>
References: <20261105070150.3093908-1-mkbund@amazon.com>
 <2026-11-05-1-daily-reply-0010-mm-hugepage-folios@kernel.org>
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
In-Reply-To: <2026-11-05-1-daily-reply-0010-mm-hugepage-folios@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 19:39, Sasha Levin wrote:
>> [ Upstream commit 04f13d241b8b146b23038bffd907cb8278391d07 ]
> 
> These carry only the is_migrate_isolate_page() hunk of 04f13d241b8b ("mm:
> replace free hugepage folios after migration"), which has no Cc: stable or
> Fixes: tag upstream.
> 
> I need an ack from an mm maintainer (David or Andrew) on the reduced backport
> before queueing it for 5.10, 5.15, 6.1, 6.6 and 6.12.
> 

Looks alright, the other hunks are only relevant for migration support of
hugetlb folios in alloc_contig_range(), which we didn't have in 5.10 IIUC.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
