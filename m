Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794762171;
	b=z014z28CDlBHQLy1K/5S+CabUR7igH/1+Y3eGXmalq1kvDtCgipz9lAD7fla8z58p2Im
	 rKe3C3eQngV4yQ5XWGAWWtHSwvsF1144/0MQAT+AUmYSOPz3rzO8Hwhfjx0i4T1Ahy51h
	 q7wuiVh5mLvnrdd6ris4v4Q4acuC9+XwC1mlybuhaIBc+R4952dTzRQo6GrSOs0bCVWwI
	 IuULvwMupcf35x6Ne2YagUeL8wsc2KuOgQTvdhXFbak8qAf+ubXvrNtVMoKzDLTXeQvbe
	 ou5BNpEHCU4DkoY38b7gS+yqDKGdwVkRXwVfltOU3X1tVvMWIzRC3xNq/Of65Tdhb6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794762171;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=I3vtfw0RI6Ep+3XSrc0wOBp9qL/MEbbkq/yZxZxS4Ds=;
	b=Fj2wt6awqL9NkuTbChep5oaUce8mW0Jik+bwvwgB2uMY8HtbKzEXtE9kDocWYYBFhgmN
	 SuRfb5OeouuvL28BararFKv4XnI6h/KXDSPJaLxO7vEhaBa8wK0wPMp5gD6467S8PAvEo
	 qTo9FTrTaON35caxEJ/149X5Gs4797sATRd2RyjIYJUm9Zdw2EyP6RwBe06nGXuhJcXil
	 hfBCGZ41nkgnp/BGx7qfa+w4SgIvj/x4ZJwxJ5Za16k+bhExS1fQKY1PugBIGuXxjSY5w
	 FxYzSvBjnCsvrpJoRZRsRnLCQ3YeYrVDXR3zjXJIYRPzZWTjc28PAYvrYpUKG4jYXBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oTh44agS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB52606A329;
	Sun, 15 Nov 2026 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oTh44agS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B2A1F000C4;
	Sun, 15 Nov 2026 17:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794762170;
	bh=I3vtfw0RI6Ep+3XSrc0wOBp9qL/MEbbkq/yZxZxS4Ds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oTh44agS28ZzPC+AZG4D2eL6DNI3RajCXSDsoZdnIhCHAGqed/SaLbbnQBP/Sb2jM
	 Zl5qNiEsl6TKrlsusUln6q9k+DSHwYM3zYFHP/aAW50BQxx012X/mgHYRKTXfOI9/J
	 dvWOgKbEkslIHzWjgc0d/Z7ap66RefwrgTEa+44ZLNeKH0Lp7hoMT6IAZ/gbG3nNKG
	 PX3TjuqWS2YWV3X9tOJ8YYPfQRHDO9wY9HECJyf61KDzVtCLnECzQAdi5R9tvJl1Ob
	 yDjwMfIz2OVhb7+cFTPXyuWNMb3Qz7V8cWOfwRnv5ddwlfz8YHw4k/tSH7gsaLM0Jk
	 C56SXx0tcsLMg==
Message-ID: <4295559c-90ac-4ad0-981e-a14a886be6d9@kernel.org>
Date: Sun, 15 Nov 2026 18:02:41 +0100
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
Subject: Re: [PATCH v2] mm/migrate: fix softlockup in do_pages_move() with
 huge page arrays
To: "Gregory Price (Meta)" <gourry@gourry.net>,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: shao.mingyin@zte.com.cn, akpm@linux-foundation.org, linux-mm@kvack.org,
 ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261108142831046W_fbNCAFfuY0BjHPCCHgi@zte.com.cn>
 <avifKRgR0Q4WPUNR@gremlin>
 <179468842502.482102.17860580592179578567.b4-reply@b4>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <179468842502.482102.17860580592179578567.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/26 21:33, Gregory Price (Meta) wrote:
> On 2026-11-14 17:51 +0000, Lorenzo Stoakes (ARM) wrote:
>> On Sun, Nov 08, 2026 at 02:28:31PM +0800, shao.mingyin@zte.com.cn wrote:
>>> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>>>
>>> do_pages_stat() had the same problem; it was fixed by 8e934ab44389.  In
>>> current mainline only alpha, hexagon and classic m68k can select
>>> PREEMPT_NONE and they cannot enable CONFIG_NUMA, so this mainly targets
>>> pre-v7.0 stable kernels.
>>>
>>> Fixes: a49bd4d71637 ("mm, numa: rework do_pages_move")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
>>
>> NAK.
> ...
>> And absolutely not to this person/script doing backports, thanks.
> 
> Have to agree here.  This is just creating backport busywork.
> 
> This might matter if we intended to do automated cross-arch testing
> on QEMU TCG on these platforms... on those LTS kernels... but also
> mehhhhhh
> 
> Yeah we shouldn't encourage this kind of patch spew.
> 

More than happy to drop this and wait for an actual user report --  and likely
find a different way to fix this stuff in stable without involving upstream that
doesn't need these changes.

-- 
Cheers,

David
