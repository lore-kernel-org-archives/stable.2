Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF5B337BAB;
	Mon, 13 Jul 2026 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959323; cv=none; b=Vv5wd5SjsBTkVPMoAt97DMIGCnG3fD5Ye4/F9s+VAMMQPBiD/B9dBUqw35+ftZ9JsOF/oxBZg7M2z8R6jBq3m3A0sGqx1/mzekxtLzH/cS8b1cMBh6uEox2x01Sd3wTiLfomA01yEVt8yCe0zL8fcgITWDWBGrJUVmqvs/JCBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959323; c=relaxed/simple;
	bh=5a7bPiRMs7Qwq8lEoorWWCh7/0KOYMbTvIMeVOGwL58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7X1H5jIJPiPB0V/Ny4fHvKtsSBXtPXMaWKCrhfLlKPhHTiqugWPpMSEI/xfQ+/mWNK9uWifxm5Q9fXf6YUyG2CMa3agJxajK2Yy5PHjmRjJBh1NAtKACs3lnC7EpyF8IS3ETjho/8uWFY9VTLEAo6JgyDbwey++F6mY1GfPVic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOMPvtSa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOMPvtSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3321F000E9;
	Mon, 13 Jul 2026 16:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783959317;
	bh=oNIWkoRxlut88jezsElvPH1wV8FkiiBk36IvzZ2BAwo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QOMPvtSaMxX9MpsXzTtiH2pWD1W/+0iiLAHU0QOSAyGHZ3amnA/Bu1/A4lKY5tOYJ
	 Wtiz3ty98R2Fbype7p9a0rxYruVz2pXVagCTCyzX3AKW1F6GKtZhPrOvL4r2TuMu2Y
	 j/JKvmod6ihm10/0FqARNrS4oLdcQDC2tnMtCiDvjkCaz0pFmRo0GezGCV9mVXbq3N
	 J2OgXqfodG4emrSkrdUAAiKr0PmbekyjmeRf42NigHAQlyqR6YaLXkU44ql4Hm8tI/
	 KNUF1VCvsufqBvwNlfGGx7EXWov7p6L/NJ+6NVThcRcO2nSWwZDmQ56sFSRI/2Lu42
	 XNYFs3mM9vTew==
Message-ID: <4c969202-a8ed-41a8-9e9a-281a12f6dde3@kernel.org>
Date: Tue, 14 Jul 2026 01:15:08 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/page_alloc: don't spin_trylock() in NMI on UP
To: Brendan Jackman <brendan.jackman@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, sashiko-bot@kernel.org,
 stable@vger.kernel.org
References: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
 <20260710-spin-trylock-followup-v1-1-affb5fe5ed00@google.com>
 <20260710170311.e22bfd21c658e8357ceddeec@linux-foundation.org>
 <DJXILB94G82L.37YBL62YO9XBK@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <DJXILB94G82L.37YBL62YO9XBK@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wjfaJTQWd3NhLTT80YxRJH5m"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------wjfaJTQWd3NhLTT80YxRJH5m
Content-Type: multipart/mixed; boundary="------------nxjIPOFNtOXUEKiJUGKT1hb6";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Brendan Jackman <brendan.jackman@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, sashiko-bot@kernel.org,
 stable@vger.kernel.org
Message-ID: <4c969202-a8ed-41a8-9e9a-281a12f6dde3@kernel.org>
Subject: Re: [PATCH 1/2] mm/page_alloc: don't spin_trylock() in NMI on UP
References: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
 <20260710-spin-trylock-followup-v1-1-affb5fe5ed00@google.com>
 <20260710170311.e22bfd21c658e8357ceddeec@linux-foundation.org>
 <DJXILB94G82L.37YBL62YO9XBK@linux.dev>
In-Reply-To: <DJXILB94G82L.37YBL62YO9XBK@linux.dev>

--------------nxjIPOFNtOXUEKiJUGKT1hb6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/13/26 11:31 PM, Brendan Jackman wrote:
> On Sat Jul 11, 2026 at 12:03 AM UTC, Andrew Morton wrote:
>> On Fri, 10 Jul 2026 10:42:20 +0000 Brendan Jackman <jackmanb@google.co=
m> wrote:
>>
>>> As noted in can_spin_trylock(), using this is unsafe in this context.=

>>> commit 620b46ed6ae17 ("mm/page_alloc: return NULL early from
>>> alloc_frozen_pages_nolock() in NMI on UP") fixed this on the alloc si=
de
>>> but missed the free side.

Ouch, do we allow alloc_pages() -> free_pages_nolock()?
Didn't notice.

>>> Reported-by: sashiko-bot@kernel.org
>>> Link: https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b=
714e19d3@google.com
>>> Cc: stable@vger.kernel.org
>>> Fixes: d7242af86434 ("mm: Introduce alloc_frozen_pages_nolock()")
>>
>> Is this correct?  I'm not seeing anything in that commit which could
>> have caused this?
>=20
> Oh yeah I guess it should be:
>=20
> Fixes: 8c57b687e8331 ("mm, bpf: Introduce free_pages_nolock()")
>=20
> This is confusing coz we have:
>=20
> A: commit d7242af86434 ("mm: Introduce alloc_frozen_pages_nolock()")
> B: commit 8c57b687e8331 ("mm, bpf: Introduce free_pages_nolock()")
> ...
> X: commit 620b46ed6ae17 ("mm/page_alloc: return NULL early from alloc_f=
rozen_pages_nolock() in NMI on UP")=20
>=20
> X is marked as Fixing A, but it was an incomplete fix. I just copy
> pasted the Fixes tag. But actually I'm now changing the free path that
> was only introduced in B.=20
>=20
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -2979,8 +2979,7 @@ static void __free_frozen_pages(struct page *pa=
ge, unsigned int order,
>>>  		migratetype =3D MIGRATE_MOVABLE;
>>>  	}
>>> =20
>>> -	if (unlikely((fpi_flags & FPI_TRYLOCK) && IS_ENABLED(CONFIG_PREEMPT=
_RT)
>>> -		     && (in_nmi() || in_hardirq()))) {
>>> +	if (unlikely((fpi_flags & FPI_TRYLOCK) && !can_spin_trylock())) {
>>>  		add_page_to_zone_llist(zone, page, order);
>>>  		return;
>>>  	}
>>
>> It would be nice to include a description of the userspace impact.  I'=
m
>> suspecting that's "none known", but some speculation on what might
>> happen to someone is appropriate.
>=20
> Ack. I think if you trigger this bug by accident it will probably crash=

> your machine in extremely confusing ways. If you can trigger it
> deliberately from unpriv (depends on the rest of the host setup, e.g.
> what tracing is being used) you can probably use it to get root/ring0.
> Can mention this in the commit message.

Just noting, it is quite niche because it requires UP, and tracing
something that can be called in NMI on UP is even nicher.

>> Also, Sashiko might have found yet more pre-existing issues:
>> 	https://sashiko.dev/#/patchset/20260710-spin-trylock-followup-v1-0-af=
fb5fe5ed00@google.com
>=20
> There are 2 cases here:
>=20
> 1: !pcp_allowed_order() -> This is forbidden by alloc_order_allowed(),
>    quite a bad miss from Sashiko IMO.

Hmm but alloc_order_allowed() would return true for !pcp_allowed_order()
when spinning is allowed, then pages can be freed via
free_pages_nolock()?

--=20
Cheers,
Harry / Hyeonggon

--------------nxjIPOFNtOXUEKiJUGKT1hb6--

--------------wjfaJTQWd3NhLTT80YxRJH5m
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCalUPDQAKCRCGXBN6rc5S
1uORAP95b6ffqA3hjbQbhh4fTA8JO2q/aCxMraAwrw3m7JnqIwEAhA/YJsuRldNh
eHZVy6QNewHI+2W+paQ1iqEOvb1FuAs=
=UlbM
-----END PGP SIGNATURE-----

--------------wjfaJTQWd3NhLTT80YxRJH5m--
