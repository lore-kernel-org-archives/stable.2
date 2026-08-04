Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9219440801B
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868491; cv=none; b=l+16N6U+1JCJb9n/y8lN+40QAyhilwr/pQ7KZPLAo7GIG6CP/RC32BeppZLHkpJoegrEbGzGjEKCeuy+xMuTAhgq8bhf+TYE6LVn61UglAQtKBC/a5oV9AXJpdXxaXuMJxjm6kaWN6y4gDsMUOZYGJMw1amRJCPO3vNf25NYt2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868491; c=relaxed/simple;
	bh=rzhnKaUHdb+lLLyNXKnYQwipFbr2XVXfEsMCSLRAQgE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HgQyNeP23ouYlK3dru1f8GgsvGuCk1spzwJhOCMLRclTjb34r4gyj0zEZJBTfKBee1yRy7cG4zjPQRKrAyY191KfwFfqkSr5+oIu40wRVa68ZcRIhEN25Nqml9nl6s844OF4ZBMrZoDU1XyL6nYY9jpXxJfZhKJqt71LE+7rDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQIS2QV1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQIS2QV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B51E1F00A3A;
	Tue,  4 Aug 2026 18:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785868490;
	bh=RRSfK5m/T7kI64bC9s4UhoodIuX08J4agh+bHzWFkuU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=mQIS2QV1bPwjZk0hf8iL5T1QRYtqruXH8dUTmESiRvvZFkgk1bY3YPXdULUbPjGi/
	 o6uLXrjU1xnKp8U630fiEHJZimm+hFOIXFfdj2Ahf5plOsLCuQGutIxR20QXO2zQoi
	 9j8/rQM8IkAYoRL0fpumj5VBxqa+ihnC9XoBLhWIpk/riTQT9ZNn9QVF8NZGPLZlnl
	 Ihmjya9O7FNRYUGNbqf20PCo/+VCMG6b13/+x2xC9W4sEQIlFtaE+qxaVyruLh6h93
	 cbCv/H95k5JissU3vM4hrBlTz5Qx7lVpC1RPhV6QkuTFRVsglrerUFDkhzZ1MpRu8v
	 MI+IAc7Rzs0ww==
Message-ID: <afc99d21-1069-428e-af55-9d1d45b0b590@kernel.org>
Date: Tue, 4 Aug 2026 20:34:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix incorrect flush address in direct page table reclaim
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: Qi Zheng <qi.zheng@linux.dev>, luto@kernel.org, linux-mm@kvack.org
Cc: luto@amacapital.net, Liam Howlett <liam.howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
References: <20260804003708.49830-1-luto@kernel.org>
 <313133db-3b94-4a63-8bcd-21952ff77e41@kernel.org>
 <8cf8eaca-fc04-4a68-bbc8-50ecdbf96382@linux.dev>
 <3d3aa670-76bc-4df3-9c36-609c14354e9e@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <3d3aa670-76bc-4df3-9c36-609c14354e9e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/26 11:34, David Hildenbrand (Arm) wrote:
> On 8/4/26 11:25, Qi Zheng wrote:
>>
>>
>> On 8/4/26 5:05 PM, David Hildenbrand (Arm) wrote:
>>>
>>> Note that this only triggers when someone does e.g., a MADV_DONTNEED over
>>> a large enough range (covering at least a full PTE table).
>>>
>>> So this isn't the ordinary munmap()/exit() page table reclaim code.
>>>
>>> I'm still surprised that it took so long to show up; likely we need more
>>> targeted tests for PT_RECLAIM that
>>
>> We backported the PT_RECLAIM to our internal tree a while ago (excluding
>> the rework patch being fixed here), and it has been running stably ever
>> since.
> 
> I'm wondering whether we should have a selftest that triggers this exact scenario:
> 
> (a) Populate page table(s)
> (b) MADV_DONTNEED to reclaim the page table(s)
> (c) Allocate plenty of pages for another purpose (draining PCP where the page
>     table likely ended up) and fill them with some data that looks like present page
>     table entries.
> (d) Re-access the reclaimed VA space, expecting re-population of anonymous
>     pages.

FWIW, I tried to reproduce above and on x86 it's really not able to trigger
easily (as you say, might require some prefetching tricks).

I was able to trigger "something" on arm64, which is just an endless loop
between HW saying "translation exception" and the MM logic saying "looks good
me, continue".

As soon as the walk cache gets flushed (due to some concurrent activity in the
system), the reproducer continues.

-- 
Cheers,

David
