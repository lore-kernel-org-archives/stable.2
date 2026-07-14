Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005D0430785
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022764; cv=none; b=Wt1Y1Ahgk57oLQKsihbPrxg8JdVvwl0lHgELg1P9aYk47MAOLDL2SI24L6nn3WSg5SUmHYGcxd3xrtEzvo4dBP/FgGLaUOikLqIG5OBkgQC17FWIyFF8Id4Iqed6QCcVPR5vq1HHtH0+sTa5GvxMnAft9ON36Q+f2xO6lLyRtX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022764; c=relaxed/simple;
	bh=MzO2Rxdvl9SZanpazWTuXe0NLgSvD3nHYaHTHxt9JfU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=W7mwxYaLoEsOYSAXo/W31WM7dQKz76pPALwuBY+D6aVIK1X4Km12S/3MCvbmoG6upotKox8fyIHqbZCLHIwf4aolDzrF3J9+voPjx1VbDyBgl8mjNm76KtV1C33r2nwnWWvijtdzPaEMWz/+otlKjXKPLRbWuXd6d9llLpHKmTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QC/nN3ic; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QC/nN3ic"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784022749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3zdQsCZaeg9r4pCa6BdAIjCC8ytsze0HKxR9F1SBpI=;
	b=QC/nN3icWHmag6UJtqg2N4KQzscCFcQB7nlwAt+o5I5fXa2cZ5qZoeDepf/8E+iOG91z7y
	bMSoa929x18iPeIt3YIWNGzy55z1kb8yd//PZAPapzJoedeJ+/mLkVCzRmoTakv71qiQ4G
	kcZ5BMeEHTubiMsxntmNtQQiAVyNav0=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 09:52:12 +0000
Message-Id: <DJY7A190TSH2.B1XHHIACRSYW@linux.dev>
Cc: "Vlastimil Babka" <vbabka@kernel.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Zi Yan" <ziy@nvidia.com>, "Sebastian Andrzej
 Siewior" <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Shakeel Butt"
 <shakeel.butt@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <sashiko-bot@kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm/page_alloc: don't spin_trylock() in NMI on UP
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Harry Yoo" <harry@kernel.org>, "Brendan Jackman"
 <brendan.jackman@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Brendan Jackman" <jackmanb@google.com>
References: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
 <20260710-spin-trylock-followup-v1-1-affb5fe5ed00@google.com>
 <20260710170311.e22bfd21c658e8357ceddeec@linux-foundation.org>
 <DJXILB94G82L.37YBL62YO9XBK@linux.dev>
 <4c969202-a8ed-41a8-9e9a-281a12f6dde3@kernel.org>
In-Reply-To: <4c969202-a8ed-41a8-9e9a-281a12f6dde3@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon Jul 13, 2026 at 4:15 PM UTC, Harry Yoo wrote:
>
>
> On 7/13/26 11:31 PM, Brendan Jackman wrote:
>> On Sat Jul 11, 2026 at 12:03 AM UTC, Andrew Morton wrote:
>>> On Fri, 10 Jul 2026 10:42:20 +0000 Brendan Jackman <jackmanb@google.com=
> wrote:
>>>
>>>> As noted in can_spin_trylock(), using this is unsafe in this context.
>>>> commit 620b46ed6ae17 ("mm/page_alloc: return NULL early from
>>>> alloc_frozen_pages_nolock() in NMI on UP") fixed this on the alloc sid=
e
>>>> but missed the free side.
>
> Ouch, do we allow alloc_pages() -> free_pages_nolock()?
> Didn't notice.

We don't explicitly disallow that but I'd say it's "forbidden by
default"...

But I think that's unrelated? It doesn't mean you can't use
free_pages_nolock() from NMI, right? (Would be weird to alloc from
another context and then free in NMI, but I don't think it's "forbidden
by default" in the way that using unmatched APIs is).

>>>> Reported-by: sashiko-bot@kernel.org
>>>> Link: https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b7=
14e19d3@google.com
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: d7242af86434 ("mm: Introduce alloc_frozen_pages_nolock()")
>>>
>>> Is this correct?  I'm not seeing anything in that commit which could
>>> have caused this?
>>=20
>> Oh yeah I guess it should be:
>>=20
>> Fixes: 8c57b687e8331 ("mm, bpf: Introduce free_pages_nolock()")
>>=20
>> This is confusing coz we have:
>>=20
>> A: commit d7242af86434 ("mm: Introduce alloc_frozen_pages_nolock()")
>> B: commit 8c57b687e8331 ("mm, bpf: Introduce free_pages_nolock()")
>> ...
>> X: commit 620b46ed6ae17 ("mm/page_alloc: return NULL early from alloc_fr=
ozen_pages_nolock() in NMI on UP")=20
>>=20
>> X is marked as Fixing A, but it was an incomplete fix. I just copy
>> pasted the Fixes tag. But actually I'm now changing the free path that
>> was only introduced in B.=20
>>=20
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -2979,8 +2979,7 @@ static void __free_frozen_pages(struct page *pag=
e, unsigned int order,
>>>>  		migratetype =3D MIGRATE_MOVABLE;
>>>>  	}
>>>> =20
>>>> -	if (unlikely((fpi_flags & FPI_TRYLOCK) && IS_ENABLED(CONFIG_PREEMPT_=
RT)
>>>> -		     && (in_nmi() || in_hardirq()))) {
>>>> +	if (unlikely((fpi_flags & FPI_TRYLOCK) && !can_spin_trylock())) {
>>>>  		add_page_to_zone_llist(zone, page, order);
>>>>  		return;
>>>>  	}
>>>
>>> It would be nice to include a description of the userspace impact.  I'm
>>> suspecting that's "none known", but some speculation on what might
>>> happen to someone is appropriate.
>>=20
>> Ack. I think if you trigger this bug by accident it will probably crash
>> your machine in extremely confusing ways. If you can trigger it
>> deliberately from unpriv (depends on the rest of the host setup, e.g.
>> what tracing is being used) you can probably use it to get root/ring0.
>> Can mention this in the commit message.
>
> Just noting, it is quite niche because it requires UP, and tracing
> something that can be called in NMI on UP is even nicher.
>
>>> Also, Sashiko might have found yet more pre-existing issues:
>>> 	https://sashiko.dev/#/patchset/20260710-spin-trylock-followup-v1-0-aff=
b5fe5ed00@google.com
>>=20
>> There are 2 cases here:
>>=20
>> 1: !pcp_allowed_order() -> This is forbidden by alloc_order_allowed(),
>>    quite a bad miss from Sashiko IMO.
>
> Hmm but alloc_order_allowed() would return true for !pcp_allowed_order()
> when spinning is allowed, then pages can be freed via
> free_pages_nolock()?

As noted above I think that's forbidden. Now I think about it, I'll
include a patch to document this.
