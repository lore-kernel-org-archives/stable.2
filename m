Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859591;
	b=FHkmGIvt+Bo4Ww3zU2+XX+0TGnCGsfbKvk6RYzBCdA27m4DztVFVzbk2ECg+Lu8/k1oA
	 Nqfyq5kMq5iVJFsudNH4uDrNTBQyuBb5dnXLDp/oayYdj8f/UZkmqmUYc5DoU2kJGTpMd
	 ms8mZLAM1E9NptwXSclxU7pDgPnMj1eE76T3Fc/aZICKspS9Ak7FVfbklnFx+rJbN90j2
	 Zd/18e3Mtj9ybSfnXsbp9+4trioPtfIfO1vUG5TmzeU2XuS8eL5VX6O5YKGqbt/Y39muK
	 VWYWLWmDBFpqlO0PYgJ/5/yEiGgJUxJO+uO42OYD0UjLXmmOCADja8fN4DedzBsLZlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859591;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=X8UnW/+ryATRWv2jbp1Jmeefb/aGbvl2dgmvZUGeG9w=;
	b=sWxgAasjch73nDo70vEf7iQ7ikL3cc0MArG5eazvKAjAyvzlJx602RO0U3E4Qd4f1Gqt
	 M8vVTgqpw05Dn8j7vVxn4a9cTyQe4GiJXkUcJaaC+JHx1Y9sVftU6/o0qTTFVREY39GSA
	 rp+xT8J+6ilbR7LuzX2gr+VvR7NAtxwGCZpNwOypOJR+WSe1qwUuEwL0vvqT4pbdIUe9b
	 uSoyuCBfPaQLLy6PXwgxGzF8tOv1k6O1aVihczmT+ehGH5xgLn+Gu/fVPXLY60IliHr9x
	 kYKC0qIe1Znb3NcelA/GKWRVxOc+hVRWcXF66FtaqOzzwRfzfzGmHV/qigPV1jxnQ3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2plYUDt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391FE606A322;
	Mon, 16 Nov 2026 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2plYUDt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C6C1F000C4;
	Mon, 16 Nov 2026 20:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794859590;
	bh=X8UnW/+ryATRWv2jbp1Jmeefb/aGbvl2dgmvZUGeG9w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=T2plYUDtEMo5l8QnCju2iEMh29uWpUA4vTKV28s7z9pQZZILdhvhTjBmwGioCvaAa
	 c0AbD7dQwL5IDeHcoqLBdQqh/q617GeLKxvTf0rybyfhZ4hHppJryslcR1HwZ6bGOc
	 od2dXVEgk/IRiORWDup8I/9VbyUkFdCUFLbPvoWr3uwsJnbw9jIr3ZpffzgNLeCzhj
	 OpX14fkND2iscwB3DNdBecYGJerEVPi9xqltzZX8aMzc2B3AUib9qtm5liUsaMpllR
	 MQ8kvHrofTXmed6J3Fd0M0BlJyGiZuGjZgV/jPteRmO/pXfa8GFTjsewgmzMRA5Eh4
	 D/5zA8/omXfig==
Message-ID: <61d4f3ee-7a0b-4a8b-b5a2-35380dd46b4c@kernel.org>
Date: Mon, 16 Nov 2026 21:06:21 +0100
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
Subject: Re: [PATCH 1/3] mm/memory: remove racy huge PMD assertion from
 walk_to_pmd()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>,
 Roman Kisel <romank@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Eliav Farber <farbere@amazon.com>,
 stable@vger.kernel.org
References: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
 <20261115-huge-pfnmap-fault-races-v1-1-537605643f6f@kernel.org>
 <dccf94b3-b901-4311-a233-488c87195dc5@kernel.org> <avs1rOJQ1gV33z8w@gremlin>
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
In-Reply-To: <avs1rOJQ1gV33z8w@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/26 18:10, Lorenzo Stoakes (ARM) wrote:
> On Mon, Nov 16, 2026 at 04:56:25PM +0100, David Hildenbrand (Arm) wrote:
>> On 11/15/26 21:58, Lorenzo Stoakes (ARM) wrote:
>>> From: Eliav Farber <farbere@amazon.com>
>>>
>>> walk_to_pmd() asserts that the PMD entry it returns is not huge, but does
>>> so without holding the PMD lock, so the assertion is only valid if nothing
>>> can concurrently install a huge PMD entry in the range.
>>>
>>> This is not the case for a VMA whose driver implements both ->fault and
>>> ->huge_fault and which invokes vmf_insert_pfn() from the former.
>>>
>>> The existence of prctl(PR_SET_THP_DISABLE) is problematic here, as it only
>>> takes the mmap write lock and faults taken under the VMA lock are
>>> unaffected by this.
>>>
>>> This can result in two concurrent threads faulting the same thing
>>> disagreeing as to whether to attempt a huge fault and thus ->fault and
>>> ->huge_fault running at the same time and triggering this assertion.
>>>
>>> So just remove the assert.
>>>
>>> Target the commit which introduced the first driver able to do this for the
>>> fix - vfio-pci. DAX also mixes fault orders within a VMA, but serialises
>>> them using its own mapping entry lock.
>>>
>>> Link: https://lore.kernel.org/all/20261112051440.16140-2-farbere@amazon.com/
>>> Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>>> [ ljs: rewrote commit message ]
>>> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>>> ---
>>>  mm/memory.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 3a20d64fd276..e03110906aa8 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -2384,7 +2384,6 @@ static pmd_t *walk_to_pmd(struct mm_struct *mm, unsigned long addr)
>>>  	if (!pmd)
>>>  		return NULL;
>>>
>>> -	VM_BUG_ON(pmd_trans_huge(*pmd));
>>>  	return pmd;
>>>  }
>>>
>>>
>>
>> Could this also stumble over a huge PUD somehow? Should we just prepare it for
>> any leaves and bail out if we find some?
> 
> No, walk_to_pmd() can only come from the order-0 path right now and
> __handle_mm_fault() makes sure that can't happen in the fault path:

That implies that get_locked_pte() and all insert_pages interfaces can only be
called from that path in __handle_mm_fault().

x86 an s390x use get_locked_pte() for some other paths, so I wouldn't want to
trust on that :)

(did I say that I hate walk_to_pmd and get_locked_pte? But you likely guessed it
at this point lol)

> 
> 	vmf.pmd = pmd_alloc(mm, vmf.pud, address);
> 	if (!vmf.pmd)
> 		return VM_FAULT_OOM;
> 
> 	/* Huge pud page fault raced with pmd_alloc? */
> 	if (pud_trans_unstable(vmf.pud))
> 		goto retry_pud;
> 
> So by the time any ->fault path runs, the PUD is stable.
> 
> We don't have to worry about the mmap paths as at that point nothing has
> faulted in and it's all fresh.
> 
> So it's all safe as things stand.
> 
> But could update for future-proofing like:
> 
> 	/* PUD leaf might have been installed. */
> 	if (pud_trans_unstable(pud))
> 		return NULL;

Yeah, that makes sense. I was just wondering whether we'd actually want to
return a proper error then instead, because this would not be an -ENOMEM case.

-- 
Cheers,

David
