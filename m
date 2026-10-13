Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119773E49DD;
	Tue, 13 Oct 2026 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909212; cv=none; b=ou2GXV1vtb6M0zH5vO6e48oEUX9SKXc0vyNbV3prCOulPUsc2aizndutJgKNWeeVEu2DSZL7wufVSOCEqUdryT6WAoRmnYBosu4lnJzkChI3OfkMy3q0FegJUFyIYcs63JRWE2ktSSlnUuvhQdDtpJVpyaGjN1r9k2p5nwXWhgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909212; c=relaxed/simple;
	bh=r6w4NhKAxrSM4e/Gue+k2qcYUxQHhjAVDn1gfJyJIG4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tsO/6PsJGuOKF52NqFByGBu13xKUSscxZCtFOv8WLkNMUxqKndv31o6fLMs575oLYt5sMDuZJn//e6ZGJHUm6U5NLHlQIIfQ4mRGSk+J1/XX94P/g7gCfaytB5/vTmrKgWng8YPrnRpY5KK7FMUWTPPy1ThrVo6xTYTadetkpvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vcz4Mnl7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vcz4Mnl7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4D51F000FF;
	Tue, 13 Oct 2026 16:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909210;
	bh=6T2EyX04RGGoQAm4CXmcxngdnZP3I2uya54Wk47L/0Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Vcz4Mnl7SMcC5EofSiSNhkawGfHClWTALjiOo4bER3V4Z0amj7+3YO26sm20FniHx
	 S6Z1wIpgHT+QqLyz5khvTt4j2b5dCgs32N0hAPzfBUyf4YIiSF9Mls15T2xzzqSVuK
	 iFJ4qGpJK0J/7Hao1ozrXxNme8Uw6CLt4bMRmfHPifSg8qXZWTUcFcTrTHcOmtAEVV
	 CZT17t3CpuMVDPcBcUPMrNWpSSwq8pIUnVLDI30ax4iaoWy6eWqvtXvW4JcXq+jESj
	 HYxsbgl/gcyeCjNbw11aa4jo4BN/s4GEwp9mfWD/jMel0RYFlZEvHWhnEjz8MdweiL
	 xvMxsgLunmnZA==
Date: Tue, 13 Oct 2026 18:32:26 +0200 (CEST)
From: Imre Kaloz <kaloz@kernel.org>
To: Harry Yoo <harry@kernel.org>
cc: Vlastimil Babka <vbabka@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
    Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, Jann Horn <jannh@google.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: sample slab_state once in
 kmem_cache_destroy()
In-Reply-To: <as4q2WlR7mLhMBpG@thinkstation>
Message-ID: <e4184209-75ee-929d-0103-ca15d5886000@kernel.org>
References: <20260930195110.13296-1-kaloz@kernel.org> <ar5pESlkEMqNsgxv@thinkstation> <aef97b97-0bd7-d720-7f59-8c0078747370@kernel.org> <as4QhUscRVtBzYpm@thinkstation> <481e9a16-cd30-d463-14ee-b5602bcd5a21@kernel.org> <as4q2WlR7mLhMBpG@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Harry,

On Tue, 13 Oct 2026, Harry Yoo wrote:

<snip>

>>>> There is a related older window: after list_del() and before that
>>>> single read, slab_sysfs_init() could set FULL, skip this cache, and
>>>> the single read would then call both unlink and release on an
>>>> uninitialized kobject.
>>>
>>> No, with this patch slab_sysfs_init() cannot set the state to FULL
>>> because the slab_caches list and slab_state are protected by slab_mutex.
>>>
>>>> I have not hit that, and this patch does not close it.
>>>
>>> I think the patch does close two bugs.
>>>
>>> One introduced by 4ec10268ed98 (reading slab_state twice),
>>> another (reading slab_state outside slab_mutex) introduced by, hmm,
>>> not sure which commit introduced it :) should be very old.
>>
>> You're right, I got that one wrong. Sampling under slab_mutex in the
>> same section as the list_del() means slab_late_init() either sees the
>> cache on the list or we see slab_state < FULL, so the older window is
>> closed too.
>>
>> As for where the outside-mutex read came from, as far as I can tell it's
>> 0495e337b703 ("mm/slab_common: Deleting kobject in kmem_cache_destroy()
>> without holding slab_mutex/cpu_hotplug_lock"). Before that, the unlink
>> and release and their slab_state checks ran in shutdown_cache() under
>> slab_mutex.
>
> 0495e337b703 Probably yes. Not 100% sure.
>
> It's quite messy, reading slab_state has been done inside, switched
> to outside, and back to inside, and so on.
>
> But should be fine as long as we can find the first commit that
> affects -stable kernels (>= 5.10.y)
>
>> SLAB_TYPESAFE_BY_RCU caches were already released from the
>> workfn outside the mutex since 657dc2f97220.
>>
>> Want me to send a v2 with a second Fixes: for 0495e337b703, or is it
>> fine to add it when applying?
>
> Could you please verify fixing which bugs resolves the issue on sparc64
> described in the changelog? Reading it twice, or outside slab_mutex, or
> both?

I tested it. I built five variants of rc7 with a small test that
destroys a SLAB_TYPESAFE_BY_RCU cache while slab_late_init() runs
(same path the floppy bio slab takes), and booted each 10 times on
x86 and 8 times on sparc64. Boots that hit the WARN:

                                              x86     sparc64
   mainline                                   9/10    8/8
   one read, in kmem_cache_release()          9/10    8/8
   unlink check under slab_mutex,
     release still re-reads                   10/10   8/8
   one read under slab_mutex (this patch)     0/10    0/8
   one read right after mutex_unlock()        0/10    0/8

So it takes both. The read that hurts is the one at release time,
after rcu_barrier(); fixing only the double read keeps it, and so
does moving only the unlink check under the mutex. Reading once
right after the unlock didn't trigger it, but that is still racy,
just a much smaller window.

For stable, as far as I can tell the release-side read has been
outside slab_mutex since d50d82faa0c9 ("slub: fix failure when we
delete and create a slab cache") in v4.18, so that would cover
5.10.y. The patch doesn't apply before 6.12, so the older branches
need their own backports.


Best,
Imre
