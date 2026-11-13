Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605977;
	b=wVJu4uciSNvLh/6OJPxy1ubrIGtbyjmrBJY99ArVQullAwGM8wft/Vgi1xV4cGg9hsFU
	 g4JFbc8sO9kWD9eA/s0bZTw2yJawfXGzlI3KOgfqmBaNxBkku5+TEm/DBz05xXvBvfWJ3
	 vWz664SJ+k4HKsZgpNLUkGUfIW+8pLg3qjvLxHqwynMPTw90vKJoA9ieNNrM3M10FY/38
	 vr2MDKxPN5sO7EEIorKRVeXSz7OV81nvI1BtToTS9a2Dn78JZ1VQQ01rVHh032UPVG0U1
	 eDeFcLU9jjmYGCoHQTiU8Mw6ES2PDVCL9eQ7XeGMcgE9u30oFlJ36HLLY69fIr2ynIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605977;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=HQYsjuLSgqmkYc+gxSurb8uN4B+g/9xyTOSp3ZLANuo=;
	b=VNhduAAquQ5JgpSniDYgACvQvJeKGTGw/RPzxdUFQs2JHS++VgI4KwWOV3D9e6MSq8My
	 GNjcH6vRuljq7cZdHSHCLTAZ1nuwUX8BreqBY3lZ+avG3fHRwIKC1g2i3F6gyoglUGZw/
	 tecErnFNr97LQoWoWWRUotXByD32wz6XyImEf+wcUVX1RhEvPgDki17NFnjdVcyY3iTzs
	 6nyH0NIAQffZOdograZkorFgfvwaCv0urd6IVoiO/Ld5djhIMTTgf5EI2kTexgQvEBKo1
	 tCcv106Iq144+fADX+RqkkS4gjz6uQcyQNujaYXtxnYKZ1CtHb9OjOkxiK675yBtSfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbvfpgu8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B17F606A32E;
	Fri, 13 Nov 2026 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbvfpgu8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B0C1F000C6;
	Fri, 13 Nov 2026 21:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794605977;
	bh=HQYsjuLSgqmkYc+gxSurb8uN4B+g/9xyTOSp3ZLANuo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cbvfpgu8tOow6Wv2h/7RSGys/vhrTWGQUnh4KqZ/MxLpfcdUf3D5uLQJDematIwO6
	 pF8ZFDoI5V9m6v0E2uv31piPTWg5RXcGhHOMnGB+I01f81xmVBupgzZAhOd1wnhrNW
	 S9hFDCZ8T/veXtk3HWrex1bO4RiSQWcnyZWnwvE2hEuQIiziMaZL8uAjJVaIED0+dX
	 8meuP51dZrUS3Vzh9kCgbv2SscDfUdKlnVIslfTnnyoRorO6NK6HfpIJ7CuQZO8P84
	 WPetnx9aM+9b3QGtptr+vAsx7A4FMTZfolDdiM/+o0o+7Pgeat5j7DADWq6BOdsgh0
	 uZwK1kSfZhR9w==
Message-ID: <a502f84a-b349-487d-94d9-aff7d9b95102@kernel.org>
Date: Fri, 13 Nov 2026 22:39:30 +0100
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
Subject: Re: [PATCH v2] mm/madvise: zap markers from guard regions
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Tal Zussman <tz2294@columbia.edu>, stable@vger.kernel.org
References: <20261113-disallow-uffd-guard-install-v2-1-9d0063c70542@kernel.org>
 <f8b0f20d-90dd-496d-97e9-9a232124e3e0@kernel.org> <avd8-uVPf6BSqwEQ@gremlin>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <avd8-uVPf6BSqwEQ@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>>>  mm/madvise.c | 28 +++++++++++++++++++---------
>>>  1 file changed, 19 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/mm/madvise.c b/mm/madvise.c
>>> index 0214efd2a014..4f7728583207 100644
>>> --- a/mm/madvise.c
>>> +++ b/mm/madvise.c
>>> @@ -850,6 +850,19 @@ static int madvise_free_single_vma(struct madvise_behavior *madv_behavior)
>>>  	return 0;
>>>  }
>>>
>>> +static void zap_range(struct madvise_behavior *madv_behavior,
>>> +		      zap_flags_t flags)
>>
>> Two ... ;) But maybe it's consistent like that in the file, didn't check.
> 
> I'm a bit exhausted, can you or Andrew just fix up whitespace like this on
> application?
> 
> It'll be easier when I have the VMA tree.

Yeah, absolutely. I'll let Andrew pick this one.

> 
>>
>>> +{
>>> +	const struct madvise_behavior_range *range = &madv_behavior->range;
>>> +	struct zap_details details = {
>>> +		.reclaim_pt = true,
>>> +		.zap_flags = flags,
>>> +	};
>>> +
>>> +	zap_vma_range_batched(madv_behavior->tlb, madv_behavior->vma,
>>> +			      range->start, range->end - range->start, &details);
>>> +}
>>> +
>>>  /*
>>>   * Application no longer needs these pages.  If the pages are dirty,
>>>   * it's OK to just throw them away.  The app will be more careful about
>>> @@ -872,13 +885,7 @@ static int madvise_free_single_vma(struct madvise_behavior *madv_behavior)
>>>  static long madvise_dontneed_single_vma(struct madvise_behavior *madv_behavior)
>>>
>>>  {
>>> -	struct madvise_behavior_range *range = &madv_behavior->range;
>>> -	struct zap_details details = {
>>> -		.reclaim_pt = true,
>>> -	};
>>> -
>>> -	zap_vma_range_batched(madv_behavior->tlb, madv_behavior->vma,
>>> -			      range->start, range->end - range->start, &details);
>>> +	zap_range(madv_behavior, 0);
>>>  	return 0;
>>>  }
>>>
>>> @@ -1217,9 +1224,11 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
>>>
>>>  		/*
>>>  		 * OK some of the range have non-guard pages mapped, zap
>>> -		 * them. This leaves existing guard pages in place.
>>> +		 * them. This also drops any PTE markers in the range,
>>> +		 * including existing guard markers, which we reinstall on
>>> +		 * the next attempt.
>>>  		 */
>>> -		zap_vma_range(vma, range->start, range->end - range->start);
>>> +		zap_range(madv_behavior, ZAP_FLAG_DROP_MARKER);
>>>  	}
>>>
>>>  	/*
>>> @@ -1845,6 +1854,7 @@ static bool madvise_batch_tlb_flush(int behavior)
>>>  	case MADV_DONTNEED:
>>>  	case MADV_DONTNEED_LOCKED:
>>>  	case MADV_FREE:
>>> +	case MADV_GUARD_INSTALL:
>>
>> Huh why that change? Not spelled out above.
> 
> It's just the established way madvise interacts with TLB maintenance.
> 
> Anything that uses madv_behaviour->tlb has to return true here so
> madvise_init_tlb() and madvise_finish_tlb() do the right thing.

Ohhh, I see now.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
