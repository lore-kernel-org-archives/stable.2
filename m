Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB733DB62D;
	Thu, 30 Jul 2026 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402357; cv=none; b=jaXJ+UavdChIZtWhGbfxJP4ResyJzTDZQUYmuoJubvQ1P6Vabmpnnc7GN4i+R+CcbCxKob4i1KXuCLPVhVGfY8umIIq0dZZtaYM6IBrUBpUA++Bdq3VoJANRWmneJ9g576Byw5JJDjNHWs6payqO4Rd3x5kAeixW7kHPoAptNMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402357; c=relaxed/simple;
	bh=Pi4kHzREh4/JC49v0qZ4m0CZbIPP2BZ0qolHzb1sGuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTjtmAr7kQCDrEot9zlXvN8RrboWtu+69pY4LPh2FbskwE5i1pPdX8TuX1R/ovNsCLpzduvuCGBASc7IPH/GutrTdemJIld6xOOpwj0aWY+d6iTc6sVpRw2O5T/9M7oONv47VdUhG5BDlLgmTE524ZiOBw8nCy334nCpZc9G7p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuqII84O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuqII84O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9768F1F000E9;
	Thu, 30 Jul 2026 09:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785402356;
	bh=CJMscz0eavBVOdfValmTNV3+OuMVqWvQZLftxghzJLY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AuqII84OYz/5m+JdsEXoOkH/HrTmljMuQUCLn3nbGpIgIW2xp/ak3YGxeoUUGWRUh
	 4flmrNcUiHQO3x1anAfULqNMnGYTyFxGjuqhjM+3IY/eqkJN0H6H+QCj37eHsB/pHn
	 9GL91iGQDsUSU5qY4BtXGcoyq8z/27ifj8AmYQ2Q8WX5UuMAk87hhiPrHaEwcTnMT8
	 fkXRN33Ao3Ar1MxwdLfcm92OnQytDDvDu6wcOsZarOs+NuTs6JWnXB/3IgqPrRL1Xe
	 tfbH2ggbzMue/EwURhOArQAbITj9C+xa2Gg+IWTg/cmxcUT/2bvorgNXFd0DQcPAfr
	 OS8A28DWUev3Q==
Message-ID: <773a043f-e135-4050-9ca1-0b5190f03ec4@kernel.org>
Date: Thu, 30 Jul 2026 11:05:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-hotfixes 0/2] mm/huge_memory: fix huge_zero_pfn race
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Pankaj Raghav <p.raghav@samsung.com>,
 Hannes Reinecke <hare@suse.de>, Hugh Dickins <hughd@google.com>,
 Yang Shi <shy828301@gmail.com>, Kiryl Shutsemau <kas@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Hengbin Zhang <uqbarz@gmail.com>, stable@vger.kernel.org
References: <20260728-fix-refcounted-huge-zero-v1-0-3f261f5447b4@kernel.org>
 <f0e39f91-8dd1-4d9d-8d4e-da5d608a7148@kernel.org> <amm2GOFablLbBC4H@lucifer>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <amm2GOFablLbBC4H@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 10:15, Lorenzo Stoakes (ARM) wrote:
> On Tue, Jul 28, 2026 at 09:02:57PM +0200, David Hildenbrand (Arm) wrote:
>> On 7/28/26 14:05, Lorenzo Stoakes (ARM) wrote:
>>> There is a subtle race in the reference-counted huge_zero_folio
>>> implementation.
>>>
>>> The fast path atomic logic fails to account for the fact that the
>>> shrinker (which drops the final huge_zero_refcount pin) can overwrite
>>> huge_zero_pfn with the ~0UL sentinel value in shrink_huge_zero_folio_scan()
>>> after a racing get_huge_zero_folio() installed a valid value there.
>>>
>>> This results in huge_zero_folio being correctly set but huge_zero_pfn being
>>> set incorrectly and thus is_huge_zero_pfn() and consequently
>>> is_huge_zero_pmd() will misidentify the huge zero folio as being an
>>> ordinary THP folio.
>>>
>>> This can result in the huge zero folio being split and otherwise treated
>>> incorrectly.
>>>
>>> The solution to this is very subtle as there is an atomic fast path, and
>>> thus ordering in weakly ordered architectures has to be treated very
>>> carefully.
>>>
>>> As a result, this series first reworks the
>>> CONFIG_PERSISTENT_HUGE_ZERO_FOLIO logic so it is separated from the
>>> refcounted code in order to make the subsequent fix reasonably
>>> understandable.
>>
>> For at least somewhat easier backports, can we reverse the order?
> 
> Since I'm going to be doing the backports can we keep it the same? :)

I enjoy reviewing small targeted fixes (also for backports), so I want to
understand why patch #1 is required at this point.

>> The spinlock+proper ordering should be possible without #1, or am I missing
>> something important?
> 
> It's possible but this way it's a lot easier to deal with and I'd rather keep
> things consistent for stable kernels.

"A lot easier to deal with", can you elaborate?

The shrinker code never runs with the persistent huge zero folio. So that is not
a concern.

So it's about get_huge_zero_folio().

But there, it's simply that concurrent races are impossible.

Please enlighten me.

> 
> I can figure things out for < persistent huge stable kernels. It'll be manual
> work either way.
> 
> (It'd be good to get some review on the actual changes also :)
Sure, will get to it, but I have limited capacity.

And I have more capacity for small targeted fixes :P

-- 
Cheers,

David
