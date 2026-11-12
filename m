Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472864;
	b=wcdOyzkBs4rDuIqzDWqe4r9Bl1SRHv9EIf8gcj6C/3GR5n9jW2gpEFs+Fg3+dEwRDJxi
	 zpQLQDlTc8413aphQeAxhJrcPsdMvXiLHsq+UiBo04qn4You5lr38ImgMPzzuJ7vNA1aB
	 FIAiLuE1ZfJdsOu39fJJb+myNEpB/ZUAElwfwYm0XFJ59ce+jRnZrAHXCUQqIQFWSTneq
	 q2FlK5rC9FTXtZlF0+ti/n9rII+wxKP0+HL3fRxbsbSNQOtr+zPYDJFbh7Wkk54AQgQBc
	 9U8K8sOZJyRS38Ic1ODATS3h9JZLgTHdLe3RWuUeZiHjA2IeJSFnxyecwzCJM3SAlbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472864;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=fthYHrOF+5dGTgn8Y4kE22m9q7Cd14oHg/PsNYTRC5E=;
	b=ksbhyyIVb9ojeb9jnGppCToD6tahNFpgqS9DND8Gsubk2JDNbTTn06fY4Io+99R0vxm2
	 qcoPtX0bcIrYaFS5xZ8M1X/jqrZQNHZE/juBG2XTwmmlSk7UNsmtvTANekL8HRaAdpD5u
	 WTkRWRnYlp2bqzchBNZt+AgSaMlX4eArq982Dq66P/LcCPk93nwcgOvX1XSqWnGr942gQ
	 YjJlhKhGQruk3NiMdPFffpH35L1FHYN5PArKtIkuLwJphxjvgfeOW+s6EhUy62fW84NXA
	 MQvV0KLUCQolcV+yzpmixfmHrraO6jIYvSCLGrQh3uo5OFbGggLnWzuFqDhfz51v+TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PsJ8kMUS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87020606A31C;
	Thu, 12 Nov 2026 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PsJ8kMUS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB6A1F00A05;
	Thu, 12 Nov 2026 08:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472864;
	bh=fthYHrOF+5dGTgn8Y4kE22m9q7Cd14oHg/PsNYTRC5E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PsJ8kMUSB3EGJHW5qVwks6Qbwv20bXjnqIFTIR1/ceR+LGf0okaQt5ej3o6UnAG9b
	 NgCUKP1pJLcvkSnD6BTPbnRvYTZ6/dU4ahXisnoyn+tMutkCXjlfuWiil8rMgs30tE
	 XdrjWQQgBiuz56RgSslBx2lTpeu0Z/yvVpB7hAJu67AyrU6+0bPx986QjCpCaY4lmS
	 I8XJG8lbO5ethYZ4njetFgkB1YksOYlFQMwHOTo/Gxi1cvuS38g4iPYz+DJurvIy/D
	 63hkpRkD9PzX8UJ+4XXJk9KARRtMb3MnFtGpt/bBkqjViDzamXuN+9TuRQnl9HuflR
	 AHJnt9MR5zn8w==
Message-ID: <8712ee27-85b0-4342-a3f5-7e9b4425b804@kernel.org>
Date: Thu, 12 Nov 2026 09:40:57 +0100
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
Subject: Re: [PATCH v3 2/3] mm: gup: allow long-term pins of CMA-allocated
 HugeTLB folios
To: Qi Zheng <zhengqi.arch@bytedance.com>, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, azpijr@gmail.com,
 lance.yang@linux.dev, Qi Zheng <qi.zheng@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
References: <cover.1794046188.git.zhengqi.arch@bytedance.com>
 <586d6c53ab7e4c64d6e89ad3cf0cf7e07dabbfaf.1794046188.git.zhengqi.arch@bytedance.com>
 <7abb3aa1-385a-422f-86bd-7aac9661c4d8@kernel.org>
 <423c9b28-ecf2-4fab-817d-2fb326690c73@linux.dev>
 <3a1a3bb5-0b01-4f20-aa0e-74a952544b8c@kernel.org>
 <5f68ffba-9f56-4e31-9e7c-9d110f552efc@bytedance.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <5f68ffba-9f56-4e31-9e7c-9d110f552efc@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/26 11:26, Qi Zheng wrote:
> Hi David,
> 
> On 11/11/26 3:43 PM, David Hildenbrand (Arm) wrote:
>> On 11/9/26 04:10, Qi Zheng wrote:
>>>
>>>
>>>
>>
>> You resent your series way too fast.
> 
> Got it.
> 
>>
>> Now we have discussions in to threads, congratulations ;)
>>
>>> ;), got it.
>>>
>>> I moved the code to resolve a build dependency.
>>>
>>
>> Why can't that be resolved differently? What is the dependency?
> 
> The dependency is that the new check wants to use
> `folio_test_hugetlb_cma()`, which is a HugeTLB-specific inline helper
> from `include/linux/hugetlb.h`.
> 
> `folio_is_longterm_pinnable()` currently lives in `include/linux/mm.h`,
> while `include/linux/hugetlb.h` already includes `linux/mm.h`. So I
> can't simply use `folio_test_hugetlb_cma()` from `mm.h`

It's all so hacky. :)

core-mm shouldn't have to worry about hugetlb internals like
folio_test_hugetlb_cma().

>>>
>>> A generic query may need separate ownership tracking, such as an
>>> owned_bitmap recording successfully allocated pages. Its updates and
>>> lookups would also need to handle concurrency with fast GUP.
>>
>> Or simply two bitmaps? "trying allocation - allocated"
> 
> As a fix, perhaps this is a bit too complex? :(
> 
> Alternatively, we could adjust the timing for setting the bitmap, though
> this might introduce new concurrency issues.

I think we had that order reversed in the past. Likely a second bitmap would
allow us to fix it fairly easily.


-- 
Cheers,

David
