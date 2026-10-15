Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D805372DB;
	Thu, 15 Oct 2026 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080803; cv=none; b=GQMRcExOZLjFw92N0anJANVzqDCcb/38wV6M36DFLHemW+xJynA4NRz0IdMT5aqDtZJfNUedk9t+i9eFf0LBi9lhwqfmg1SohsaHx7cRzP0RkGEk+bZP2YH8WjAm3TcVu8JYAWVpme/Q9euhyQ6Z2ruMOWjW2rgdQ0MW+n1669Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080803; c=relaxed/simple;
	bh=pfaK1zV2C07VE8qNMoZWBUYJj9ZCIqgmwfGlQcOubWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngw0k21y59bc+jMg272eZRs+bzt/92t7HUtenibHPBs++NIIOVIqogg7APdVuHcMtxtdRgbe8i1+WdUeWT/1kwkHYehDpbqF4CLA0bj/qq69yHqibHfDyAszPF5PyAylxSdkyTMuBYh+kf+smfWn/iYLuHI5D79nm5SLFXAaX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwaqDlkV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwaqDlkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224CD1F000C5;
	Thu, 15 Oct 2026 16:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080791;
	bh=A1lWzMwbJEgcUx9os4ekav6RXpiDlYglRJy0W/gEY+0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cwaqDlkVtP6j6B1d84hufMyxHHSX37bQLnU9JpgpFIDZh8Yjviyu6OaVYeW0uXiHg
	 906RHmTeB5aaX8eReHi2v/EwJ9jHyvIm5TvJynkaJ6R2YdVOEvSSFFTKfdI46NhLh5
	 mc+YfFvIu4JJPfwrcd7MkcbY+X47OXQNmzEFprUN0tbqeRjcfOOB1c9XmDYVrDy8/j
	 GxiOj+uf8bywxPAE72RcpgqE5+Id3NH797ZNFSsOQKOL8JmkNovZfbhuv08Qz1x1dX
	 /UzMIcloJ7FYcTOqBYfSIvkqoOnQoievUr2x0Bx6qIM72asHfZaNuYpkEXiKuOG31J
	 j/wVkakPHykYQ==
Message-ID: <1a13467a-443b-4228-bca2-9cb8f4b53086@kernel.org>
Date: Thu, 15 Oct 2026 18:13:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/slab: sample slab_state once in
 kmem_cache_destroy()
Content-Language: en-US
To: Harry Yoo <harry@kernel.org>
Cc: Imre Kaloz <kaloz@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "Jose A . Perez de Azpillaga" <azpijr@gmail.com>
References: <20261014150844.8536-1-kaloz@kernel.org>
 <d966f16a-a2be-48c7-b31a-a2c7d3ef6d5c@kernel.org>
 <atDCYwNfKW3m6YXh@thinkstation>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSNWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBrZXJuZWwub3JnPsLBsAQTAQoAWhYhBKlA1DSZLC6OmRA9UCJPp+fM
 gqZkBQJqFFy6GxSAAAAAAAQADm1hbnUyLDIuNSsxLjEyLDIsMgIbAwUJGtCBUAULCQgHAwUV
 CgkICwUWAgMBAAIeBQIXgAAKCRAiT6fnzIKmZJIUEADFx/tREzUImHrEwVHeSvDFmA7tJysI
 UVrlvrM09E7GIuzphzv7jYmo8n3ANpCczLEVr4G0syYQdTigaZgv3+FQDIIzhKih1IHhu1Ei
 XHlywNWKnQxxQEUNi5Mwx43wQz5XVw9F1A7gtKBKNtfogO511hAbrzagrYajyQacEJ/+sfhZ
 9Da8ltHIXD8pcYaHUfQgEusCgmEd9+KrUwrTbckFKmYq5chuE6yJ4J0EmWknL096jIE6CnzF
 FRslQ3B1UKDjxVsm1ZHfir5NeWszLkTvGFsddFaWTgh8UycESG6VQzKXjjewXu2pG7YQYRpj
 QKm1W5X2TkwWkXRBZTmfmbhxIUMh3+zf5wQ463rSmDN/8v81tdqBtAW6rH/kzg1GvkaTHXn0
 507yEHFzBksk2viAuIxxr7km8+/KARYLIdGtx30EG8cKzAUZOK6WqxtNCsXUJNrVE8CWrCaD
 icoNu7Fs1c5hmPHdSTnU48ce67449DdnO4neLSNhRiGlMHJgfJUmgrxu/hcYeOZ3haWmEQ2w
 uW1Mh01OHi8QZHCEyAbABrPs9GUgccc/4eYXX9hIgxfSkYzn8f+8NuIFPWl/0uTvjgqU29FQ
 SbzOLxHq9439Ox40G5mS5eZXRGxITYR+6TXvRGI6P/264jvflnr/pDGUttaikU+0W+1uxgKH
 cmYbEc7ATQRbGTU1AQgAn0H6UrFiWcovkh6EXVcl+SeqyO6JHOPm+e9Wu0Vw+VIUvXZVUVVQ
 La1PQDUi6j00ChlcR66g9/V0sPIcSutacPKfdKYOBvzd4rlhL8rfrdEsQw5ApZxrA8kYZVMh
 FmBRKAa6wos25moTlMKpCWzTH84+WO5+ziCTsTUZASAToz3RdunTD+vQcHj0GqNTPAHK63sf
 bAB2I0BslZkXkY1RLb/YhuA6E7JyEd2pilZOrIuBGl/5q2qSakgnAVFWFBR/DO27JuAksYnq
 +aH8vI0xGvwn75KqSk4UzAkDzWSmO4ZHuahKtQgZNsMYV+PGayRBX9b9zbldzopoLBdqHc4n
 jQARAQABwsF8BBgBCgAmAhsMFiEEqUDUNJksLo6ZED1QIk+n58yCpmQFAmfIHFQFCRYU6J8A
 CgkQIk+n58yCpmS2PA//bqN1LfcotmArgElsa+0EGZSQlYgK48pm8WAeTXTngudP9IJ4SuKY
 HR5RNjHcBeqN+Me0zxRqYzRb8nGanHEkDyf4Im8DQM8d6vbyU+FcPmG4skud4kgS1zMHnlVd
 SXfSIwKC/hKgdHG8aBV7545Lz9X6Iohea+94wneD0aw/hqF+QWewGZhWJriWAZtvEkzNjQOi
 4U9F/trLten/x7bpphDSnDMKJtITbtzATT1Dq7o7VpIUK1nCTQALMuMjKCdi8OdU/+V+R3O4
 0PXWvX8qrvqYapVbZ+9KqT74FsuB0Ya9uXwgBF2Q6cRuETZk5vqaqKxzqoQZCO8AOz/58j6O
 2RHNy/mZEN+7tJ5Tsq42zVJ4jxsT8b9YplavCMsnBgDeRWhcbYhCyttoL7nYISyWg4kQYZ/P
 wIV3OuNv2f8iKYsxNsRuClOAF82+gvqOy1/1pprFjy8uo2pkoOrb63aOP3vO5VHnRKgra6dq
 NcaZ+c6J4H+nEJGi2SkHAUJz5oBzuThvPudLvPA/SK8sKoM01IRxSihev/S/5WLazXB1PGem
 OCbvzC1IjWJJraxiDJ5IygokapUa2RP7+WBR22skQ3SSl6G107QgWKSyTOGWEaRmV53vxQLV
 jXuCmzSSasTL60zq5yGrT4/DYQVSNEUiUbG4pYekxJujNeEDkUlky0Y=
In-Reply-To: <atDCYwNfKW3m6YXh@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/26 16:48, Harry Yoo wrote:
> On Thu, Oct 15, 2026 at 09:21:43AM +0200, Vlastimil Babka (SUSE) wrote:
>> On 10/14/26 17:08, Imre Kaloz wrote:
>> > kmem_cache_release() tests slab_state >= FULL after kmem_cache_destroy()
>> > has dropped slab_mutex and unlinked the cache, and for a
>> > SLAB_TYPESAFE_BY_RCU cache after rcu_barrier(). If slab_late_init() runs
>> > before that test it sets slab_state to FULL but skips the unlinked cache,
>> > which never got a sysfs entry, so sysfs_slab_release() calls kobject_put()
>> > on a kobject that was never initialized:
>> > 
>> >   WARNING: lib/kobject.c:734 at kobject_put+0x64/0x2c0, CPU#1: kworker/u8:3/55
>> >   kobject: '(null)' ((____ptrval____)): is not initialized, yet kobject_put() is being called.
>> >   refcount_t: underflow; use-after-free.
>> >   kobject_put+0x64/0x2c0
>> >   sysfs_slab_release+0xc/0x20
>> >   kmem_cache_destroy+0x104/0x1e0
>> >   bioset_exit+0x13c/0x1e0
>> >   disk_release+0x54/0x140
>> >   put_disk+0x18/0x40
>> >   floppy_async_init+0xbec/0xd10
>> > 
>> > The release-time test has run outside slab_mutex since at least v4.4 for
>> > SLAB_TYPESAFE_BY_RCU caches, and since v6.0 for the others. Since v6.12
>> > the unlink-time test in kmem_cache_destroy() is a separate read of its
>> > own, also after mutex_unlock(), so the two can disagree. Both tests ask
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
>> > the unlink-time test in kmem_cache_destroy() is a separate read of its
>> > own, also after mutex_unlock(), so the two can disagree.
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

Oh wow, what a complicated history :)

LGTM, thanks!

> commit 13564e1cfc847aa540019b55a1f8e588670892fe
> Author: Imre Kaloz <kaloz@kernel.org>
> Date:   Wed Oct 14 17:08:43 2026 +0200
> 
>     mm/slab: sample slab_state once in kmem_cache_destroy()
>     
>     kmem_cache_release() tests slab_state >= FULL after kmem_cache_destroy()
>     has dropped slab_mutex and unlinked the cache, and for a
>     SLAB_TYPESAFE_BY_RCU cache after rcu_barrier(). If slab_late_init() runs
>     before that test it sets slab_state to FULL but skips the unlinked cache,
>     which never got a sysfs entry, so sysfs_slab_release() calls kobject_put()
>     on a kobject that was never initialized:
>     
>       WARNING: lib/kobject.c:734 at kobject_put+0x64/0x2c0, CPU#1: kworker/u8:3/55
>       kobject: '(null)' ((____ptrval____)): is not initialized, yet kobject_put() is being called.
>       refcount_t: underflow; use-after-free.
>       kobject_put+0x64/0x2c0
>       sysfs_slab_release+0xc/0x20
>       kmem_cache_destroy+0x104/0x1e0
>       bioset_exit+0x13c/0x1e0
>       disk_release+0x54/0x140
>       put_disk+0x18/0x40
>       floppy_async_init+0xbec/0xd10
>     
>     slab_state >= FULL asks whether the cache has a kobject, which cache
>     creation skips while slab_state <= UP. UP is the state just below FULL,
>     so a false sample cannot skip a kobject_put() that was owed.
>     
>     Seen on sparc64 at boot, where the asynchronous floppy init tears down
>     its bio slab while the late initcalls are running.
>     
>     Sample slab_state once, under slab_mutex which slab_late_init() holds
>     when it sets FULL, and use the result for both the unlink and the
>     release.
>     
>     The history of this problem dates back to v3.2:
>     
>       Commit 69cb8e6b7c29 ("slub: free slabs without holding locks") in
>       v3.2 moved sysfs_slab_remove() outside slub_lock and introduced
>       a race condition between kmem_cache_destroy() and slab_sysfs_init().
>     
>       Commit 945cf2b6199be ("mm/sl[aou]b: Extract a common function for
>       kmem_cache_destroy") in v3.7 accidentally closed the race while
>       extracting a common implementation for kmem_cache_destroy().
>     
>       Commit 5413dfba88d6 ("slub: drop mutex before deleting sysfs entry")
>       in v3.8 re-opened the race by dropping slab_mutex around
>       sysfs_slab_remove() in __kmem_cache_shutdown(), to avoid a lockdep
>       splat between slab_mutex and the sysfs lock.
>     
>       Commit 657dc2f97220 ("slab: remove synchronous rcu_barrier() call in
>       memcg cache release path") in v4.11 shifted from synchronous
>       rcu_barrier() to asynchronous RCU work for SLAB_TYPESAFE_BY_RCU caches.
>       That commit, again, accidentally closed the race by moving
>       sysfs_slab_release() to shutdown_cache(), but only for
>       !SLAB_TYPESAFE_BY_RCU caches because destruction of
>       SLAB_TYPESAFE_BY_RCU caches is done in an RCU work.
>     
>       Commit 0495e337b703 ("mm/slab_common: Deleting kobject in
>       kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock") in
>       v6.0 re-introduced the race for !SLAB_TYPESAFE_BY_RCU caches.
>     
>     Fixes: 69cb8e6b7c29 ("slub: free slabs without holding locks")
>     Fixes: 5413dfba88d6 ("slub: drop mutex before deleting sysfs entry")
>     Fixes: 0495e337b703 ("mm/slab_common: Deleting kobject in kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock")
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Imre Kaloz <kaloz@kernel.org>
>     Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
>     Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
>     Link: https://patch.msgid.link/20261014150844.8536-1-kaloz@kernel.org
>     Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>     Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
> 

