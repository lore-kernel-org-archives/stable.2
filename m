Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4B7429CF6
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015981; cv=none; b=BUIdJl9UgJq+AJl/GbJP/+fgxXUy0Eg67SdEV+bkuM9HaL0ybMgc7tjuqL3rX5LRQ538oPaRGsJoSkqMstsMz4bSOwz5cojtJVMGdQprVOLvrhnCJLTkYKgKXcT/n0Zl0bR1UXd9msm2JZesdUq0gloBQRkVMw3/OsuqjcZO70I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015981; c=relaxed/simple;
	bh=+8us7sxC13SZweCihr3mLJ/i3HYER+faVnuVHFxKTtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmu0faaIDvX2dyJqwNVSG98TGKeamvwd1QEBYSrE0nqOey94f+juFLfeZPZiNjBvv2b9YDiRbCT4eIEA9k0rkwqlZaHJJTCfMws3Amev54fHNJYEw+ZGc2LL8wA25795aMzyB5yOBeCO37W6pOwIvqptuMJy7PfcTAgNWr8ZPlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f49lgbja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f49lgbja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AB31F000E9;
	Thu,  6 Aug 2026 11:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786015979;
	bh=+S0bDK+HE9AO9ibYQli3H7LOxEbXjfqhKnBpSyOmk/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=f49lgbjapFRD5GZZMPWTnzs8d3DMejNvT97gj5JUnHRi52bp/NbdDMX6dZaNiS4yX
	 LQiVL6smmaYTSk7EDK64BiPr/HVUQJVU7pi/Zf61w2BMY8MgUGDwI2KotpFtYrCZVL
	 Co1H9/ptgiVOuwCEeOxssl0b4IY84Wmgb0hmmWWYHWqO7u7twyhhzepWdm1hSFaWw5
	 HRGQwh8/hrcNrGPc1/BVFYvmRLqmeeEfezsaDJxMpWuQz8MDVjFotjYU7w4EeLx9gF
	 QGVqKRYMJKjq5KUUHRTVB5YWwViu2YFFX6QAPG8CsEiOvXw+tHLLrjsgJ90VSX8U8L
	 mRL/CSZbxmu7A==
Message-ID: <9c3feb9d-3111-4f37-90f7-3ad3c2e094c7@kernel.org>
Date: Thu, 6 Aug 2026 13:32:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/20] arm64: percpu: Add infrastructure for
 preemptible this_cpu_*() ops
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, ada.coupriediaz@arm.com,
 ardb@kernel.org, catalin.marinas@arm.com, cl@gentwo.org,
 david.laight.linux@gmail.com, james.morse@arm.com, ljs@kernel.org,
 maz@kernel.org, peterz@infradead.org, ruanjinjie@huawei.com,
 ryan.roberts@arm.com, stable@vger.kernel.org, vladimir.murzin@arm.com,
 will@kernel.org, yang@os.amperecomputing.com
References: <20260804170503.3513916-1-mark.rutland@arm.com>
 <20260804170503.3513916-14-mark.rutland@arm.com>
 <7df18d5e-886e-43d1-b53d-52a1d08aba49@kernel.org>
 <d600d0db-5109-4386-9a49-955be74cc432@kernel.org>
 <anRuT1Psmar9mW5L@J2N7QTR9R3>
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
In-Reply-To: <anRuT1Psmar9mW5L@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/26 13:21, Mark Rutland wrote:
> On Wed, Aug 05, 2026 at 08:47:08AM +0200, David Hildenbrand (Arm) wrote:
>> On 8/5/26 08:45, David Hildenbrand (Arm) wrote:
>>>
>>> FWIW, in a recent discussion on some prototype hacking [1] we saw some overhead
>>> in micro-benchmarks that would really hammer on a path that would now do a
>>> preempt_disable()+preempt_enable().
>>>
>>> Switching from preempt_disable() to preempt_enable_no_resched() made it turn to
>>> noise. Of course, that has other undesirable impacts, and I am not sure if we
>>> are in the territory of code layout changes affecting the numbers.
>>>
>>> Just mentioning it as some data point.
>>
>> [1] https://lore.kernel.org/linux-mm/20260630174852-mutt-send-email-mst@kernel.org/
> 
> Thanks for the pointer.
> 
> IIUC in those cases you're using preempt_disable() .. preempt_enable()
> directly, not this_cpu_*(), right?

It was purely preempt_disable/preempt_enable experiments without any percpu stuff.

> 
> If so, patches 5 and 6 of this series [2,3] might have an impact, but I
> wouldn't expect a significant change unless you're calling
> preempt_enable a lot.
> 
> Please beware that it's not safe to use preempt_enable_no_resched()
> UNLESS it is immediately followed by a call to schedule(). That's not
> documented today (and I couldn't find a good reference), so more folk
> are likely to be tempted to use it...
Yes, that's also why we abandoned that (including for various other reasons :) ).

preempt_enable_no_resched() helped to identify that the preempt_enable() was
really causing the noticeable overhead, not the other minor stuff we added on
some hot paths.

-- 
Cheers,

David
