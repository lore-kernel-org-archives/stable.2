Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A9641166A;
	Fri, 10 Jul 2026 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694741; cv=none; b=qCvTNzurskqzFlhhVsxba+GufxLMC/uIdqcTrLG38Yu4+jwdM0W6CZ+bmBQ4vthwm0oC6EAefu4l0Y7WcnV6+iQVAqZxWYRazLKXethwV1mrT+AJsdmkOMZKx69UNI/lzjgt8HQR9CjfuQwC/a0zNl8j3wLUNApOiFs7UOVD2OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694741; c=relaxed/simple;
	bh=eiruJzr0E7dZ+OagJBxWcBWe0Ui7jZpsysBb0NApfew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PORLNPlhS87XGQbF8Jwu4aFF0eTPn/KpkkHTpPM1tPHWAZc321crAahqVkpJ/aOGFgXBLK9+zWpWg6LY+i6ZL4YjpJR1nbCnEOdHIw0hWKELNJecBXfzbTS5mTcapwyJFNmDT50K5fTesSmhuXOsn3SDzS4laYbtTvn44rVfAGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfJIw52t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfJIw52t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F861F000E9;
	Fri, 10 Jul 2026 14:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783694736;
	bh=MUJmReX//1mrcIJ16GPEOQBodF0W4wFoWOp7JURewLU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZfJIw52t0KXkXY5nQiQeJDMPiHsL8aO0tbO+K2a5PaiTIYOJIGawQwSus9MWR+8mo
	 zcyoSr54fcF8jv4K25j4hGXzgzmbKnB1Xa46w220/9AcvjrnYfZ2VPHm3ah9Zj716r
	 7Cq9KsvPMa/sXXzzGJ8UFLY9eWCwy0c0Yofke7snybalqA0a+qa0K/hMIkWEv9U/Vn
	 rceJVoqsjvM5KF+ipsVzMx1VW2LbhY6m+mI99T8UeKD+6vFBifiIOXN5kgnlfcZ+e+
	 HdpeFTOB1QqjzJR/SpKi/YRTneJ7akJ1fcTMtxLDa65G6n8pmmFrBJaNJSrN8XWEfg
	 CeRwUPZOw/Yug==
Message-ID: <9210ef86-3131-464b-93e7-336420d894d9@kernel.org>
Date: Fri, 10 Jul 2026 16:45:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: free allocated PFNs if the range does not
 match
To: Zi Yan <ziy@nvidia.com>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, Yu Zhao <yuzhao@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260629-free-pfn-on-alloc-contig-range-error-path-v1-1-496ff9ca22db@nvidia.com>
 <4549ad0e-abb1-4156-95c6-5e3c1319dffe@kernel.org>
 <d44ae8a5-ec70-456b-92a0-ce7ccabf6917@kernel.org>
 <DJMH7EKQ3SBB.2REYPX4LVFFTF@nvidia.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <DJMH7EKQ3SBB.2REYPX4LVFFTF@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 17:06, Zi Yan wrote:
> On Tue Jun 30, 2026 at 9:39 AM EDT, David Hildenbrand (Arm) wrote:
>> On 6/30/26 09:44, Vlastimil Babka (SUSE) wrote:
>>>
>>> So this?
>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>
>>>
>>> Hm well, it's a path that warns, can only happen due to a development error?
>>> Not sure we care about stable then. Anyway.
>>>
>>
>> If someone would run into the WARN we would already be in Fixes: territory.
>>
>> it's a path that should never be executed. If it does, the real issue must be fixed.
>>
>> So (a) I don't think this is stable material (b) I am skeptical that this is
>> even a Fixes and (c) I am wondering whether we should touch this *at all*.
>>
>> :)
> 
> I looked at the code again and agree with you that the code is not
> reachable and the fix should not be in the WARN path. Theoretically, if
> order = ilog2(end - start) is smaller than MAX_PAGE_ORDER,
> find_large_buddy() can return an outer_start smaller than start, leading
> to this WARN path. But currently alloc_contig_frozen_range() with
> __GFP_COMP is used by gigantic hugetlb, thus that is not possible.
> 
> How about
> 1. making sure order is bigger or equal to MAX_PAGE_ORDER,

Makes sense. As you say, hugetlb doesn't need something smaller.

> 2. adding a comment in the WARN path to prevent someone else trying to
> fix WARN path if Sashiko reports this again


Agreed.


-- 
Cheers,

David
