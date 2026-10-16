Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D269A447237;
	Fri, 16 Oct 2026 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792191341; cv=none; b=WPmzArc/hMVRXtPC6cmIHBvzUaroV+RIcQo1Hz5NsMJuqEKS4Z0PFBL+e0bNvRf0GuF1YLvzKMGYRfURBOd+D6xlJGdRp8bylBSi7RXEQz8E52H6u5TYpdfP5vo4SVTzIiH2rDh9FNg1WJ6agJ3chQP9JD/kZGlKeZ/SjVWVK10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792191341; c=relaxed/simple;
	bh=WUe4HY0OVlgw7iQWm1lGNiuW3oIyFgu21q3Aoas0C+k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OpYOcm6haIx1WFe/bNvlOH3/tLBETmZmnPaRAE+hNnLaBwkrg4TkraPmXQm03HIGnjxulHeCZgKY0P95fjza30ZP4jT3RwM5wc8tv/xNxp72F4oJc+fOc4n8dFHIXdgiJ4+7dv72MI0KGcXA8LVFFcNw79ROcnWWvoD+cIkhB9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drmmTrUJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drmmTrUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D411F000C4;
	Fri, 16 Oct 2026 22:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792191340;
	bh=r+fjZAA8UGKYXICmEmHMmO2IajMcg2qwTMJzf+lYDvo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=drmmTrUJ8iWi865TABSjtQJ9sJU0X1ucWOZmcbbFlVromL4oRSkfQnK+vqE2SGeHU
	 ANYRmOXzK0XCc74VOaBQOj0uYXzU2MWSShhuzhgDcUNw3lobZ15xl0SPVG7K5OhHVh
	 DOiS+M8n01gTzcOAo7DNt7Tm6P70gsnjwF/zdnPm1VMzTqcDBCneVdwYKPF6I7bZ/G
	 9QHUCYt41VoxCuQABUNzjja3lz9arKIVLgLNd6AimShaLvDw4Due7NWo+Xoy8niIjL
	 12McuF8dO36y2gwjxSja1Nt1AM8ih46v+w7JplqmyiGmb4HC89Q7YUukk8D51P6hWU
	 4YdShyNew+6Zg==
Date: Sat, 17 Oct 2026 00:54:33 +0200 (CEST)
From: Imre Kaloz <kaloz@kernel.org>
To: Harry Yoo <harry@kernel.org>
cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
    Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, Jann Horn <jannh@google.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
    "Jose A . Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH v2] mm/slab: sample slab_state once in
 kmem_cache_destroy()
In-Reply-To: <atDCYwNfKW3m6YXh@thinkstation>
Message-ID: <ff8d44d0-d27f-2766-85e9-ce91b8e8e944@kernel.org>
References: <20261014150844.8536-1-kaloz@kernel.org> <d966f16a-a2be-48c7-b31a-a2c7d3ef6d5c@kernel.org> <atDCYwNfKW3m6YXh@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Harry,

On Thu, 15 Oct 2026, Harry Yoo wrote:

> On Thu, Oct 15, 2026 at 09:21:43AM +0200, Vlastimil Babka (SUSE) wrote:
>> On 10/14/26 17:08, Imre Kaloz wrote:
>>> kmem_cache_release() tests slab_state >= FULL after kmem_cache_destroy()
>>> has dropped slab_mutex and unlinked the cache, and for a
>>> SLAB_TYPESAFE_BY_RCU cache after rcu_barrier(). If slab_late_init() runs
>>> before that test it sets slab_state to FULL but skips the unlinked cache,
>>> which never got a sysfs entry, so sysfs_slab_release() calls kobject_put()
>>> on a kobject that was never initialized:
>>>
>>>   WARNING: lib/kobject.c:734 at kobject_put+0x64/0x2c0, CPU#1: kworker/u8:3/55
>>>   kobject: '(null)' ((____ptrval____)): is not initialized, yet kobject_put() is being called.
>>>   refcount_t: underflow; use-after-free.
>>>   kobject_put+0x64/0x2c0
>>>   sysfs_slab_release+0xc/0x20
>>>   kmem_cache_destroy+0x104/0x1e0
>>>   bioset_exit+0x13c/0x1e0
>>>   disk_release+0x54/0x140
>>>   put_disk+0x18/0x40
>>>   floppy_async_init+0xbec/0xd10
>>>
>>> The release-time test has run outside slab_mutex since at least v4.4 for
>>> SLAB_TYPESAFE_BY_RCU caches, and since v6.0 for the others. Since v6.12
>>> the unlink-time test in kmem_cache_destroy() is a separate read of its
>>> own, also after mutex_unlock(), so the two can disagree. Both tests ask
>>
>> It would be useful to mention the commits here along with the versions. Also
>> this suggests 3 commits but there's only 2 in Fixes.
>
> Agreed.
>
> At second look I think we should improve the changelog a bit....
> And the history of this race is really... messy.
>
> I'll just rewrite this part a little bit with specific commits and
> add Fixes: tags for each commit that introduced for re-introduced
> the commit, along with some history so that people* can decide whether
> they* should pick this up.
>
> *who may maintain downstream stable Linux kernels
>
>>> the unlink-time test in kmem_cache_destroy() is a separate read of its
>>> own, also after mutex_unlock(), so the two can disagree.
>
> This part is unnecessary because reading slab_state outside
> slab_mutex is what we should fix. As long as it's read under
> slab_mutex, reading it once or twice doesn't really matter.
>
> (See full changelog at the end of this email)
>
>> I would guess the 6.0 change is not a crucial one?
>
> Uh, I thought the Fixes: was 6.0 one, not 6.12 one :/
>
>> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>
> Thanks!
>
> So... below is my suggestion. What do you think?

<snip>

Looks good to me, thanks for untangling all of that history.


Best,
Imre

