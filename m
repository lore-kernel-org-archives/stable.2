Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CC53921E7;
	Tue, 14 Jul 2026 11:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030007; cv=none; b=oN2IfrsUL8qArdqMnU0wZlAxZkEzqzWIrcnmhKEH3XH3r2K+KhZiAENmbDyA7Wzmd/cMoWIekKJzhR+Stbc37XjrdkGV/Eo5ZRL/hIrRq2ynxdJFrji39REYHmFHzjH8LOYpcCPlE25cJ1DDlyfJlJWVVhQ3kfJ0pff+7jBGwic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030007; c=relaxed/simple;
	bh=2Nf0pzzNTeJOpKeQGGtmDhdnC8W2GgOPVML5TCxAQKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1jSEjR9hyg7MbKTxUUDw1pQMWzOQ53nj0vQCTpKYAve4wmjN9h8m+8Q408/YyGmQSauITgPdjRcnSt5Kw0GHQ+4yQtoagfNhzdiHn+pctYTmpFuIfIvroPw3iRMDWy7IRcgKnAOintYw819NW5A8f9SqXum/HbqGU3JtuSUdoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUG61eQr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUG61eQr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4375B1F00A3A;
	Tue, 14 Jul 2026 11:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784030006;
	bh=2Nf0pzzNTeJOpKeQGGtmDhdnC8W2GgOPVML5TCxAQKQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HUG61eQr+qwcx4Kq4681RkPJCJLDTNpPf4qw0k95lvgmE6lqKcMDXgaVntE9jLqLd
	 MsT/5cMj0tdbasDEma3t28y9h5wLSoG5fMXfGniSmj682PlBXb6WlE9qq4LWXspiFM
	 CxQ1C+vistKAF2WILYIfoxuA7dm9uuPDFKKxYO4yoXmGqnylYtKXZNXyOsE2F13+w+
	 5JZSD/J0TPhTgIrsO/ZPxX3oaQbEcwwdTS5iZ2Tn2jNmLJMXzXuL3E8+VxVKNcDXZD
	 gZz/o+sDq8I10tXaIv0mNVqnDmokH8GR0hZA+pMbq/PPLtpQYFoBXgVAh5EVc2mLZy
	 bER0gxU5+g+2w==
Message-ID: <67930986-152e-483e-a00d-210fe5769a10@kernel.org>
Date: Tue, 14 Jul 2026 20:53:16 +0900
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
 <4c969202-a8ed-41a8-9e9a-281a12f6dde3@kernel.org>
 <DJY7A190TSH2.B1XHHIACRSYW@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <DJY7A190TSH2.B1XHHIACRSYW@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ku0sMi9hUnR02QaV2h2WUqQg"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ku0sMi9hUnR02QaV2h2WUqQg
Content-Type: multipart/mixed; boundary="------------4kdqt064WgNYuyI40EikPph1";
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
Message-ID: <67930986-152e-483e-a00d-210fe5769a10@kernel.org>
Subject: Re: [PATCH 1/2] mm/page_alloc: don't spin_trylock() in NMI on UP
References: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
 <20260710-spin-trylock-followup-v1-1-affb5fe5ed00@google.com>
 <20260710170311.e22bfd21c658e8357ceddeec@linux-foundation.org>
 <DJXILB94G82L.37YBL62YO9XBK@linux.dev>
 <4c969202-a8ed-41a8-9e9a-281a12f6dde3@kernel.org>
 <DJY7A190TSH2.B1XHHIACRSYW@linux.dev>
In-Reply-To: <DJY7A190TSH2.B1XHHIACRSYW@linux.dev>

--------------4kdqt064WgNYuyI40EikPph1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/14/26 6:52 PM, Brendan Jackman wrote:
> On Mon Jul 13, 2026 at 4:15 PM UTC, Harry Yoo wrote:
>> On 7/13/26 11:31 PM, Brendan Jackman wrote:
>>> On Sat Jul 11, 2026 at 12:03 AM UTC, Andrew Morton wrote:
>>>> On Fri, 10 Jul 2026 10:42:20 +0000 Brendan Jackman <jackmanb@google.=
com> wrote:
>>>>> As noted in can_spin_trylock(), using this is unsafe in this contex=
t.
>>>>> commit 620b46ed6ae17 ("mm/page_alloc: return NULL early from
>>>>> alloc_frozen_pages_nolock() in NMI on UP") fixed this on the alloc =
side
>>>>> but missed the free side.
>>
>> Ouch, do we allow alloc_pages() -> free_pages_nolock()?
>> Didn't notice.
>=20
> We don't explicitly disallow that but I'd say it's "forbidden by
> default"...
>=20
> But I think that's unrelated? It doesn't mean you can't use
> free_pages_nolock() from NMI, right? (Would be weird to alloc from
> another context and then free in NMI, but I don't think it's "forbidden=

> by default" in the way that using unmatched APIs is).

If you can't free pages that are not allocated via alloc_pages_nolock(),
and if alloc_pages_nolock() always fails, you can't really use
free_pages_nolock().

But yeah BPF seems to do that and also the comment says:

/*
 * Can be called while holding raw_spin_lock or from IRQ and NMI for any
 * page type (not only those that came from alloc_pages_nolock)
 */

--=20
Cheers,
Harry / Hyeonggon


--------------4kdqt064WgNYuyI40EikPph1--

--------------ku0sMi9hUnR02QaV2h2WUqQg
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCalYjLAAKCRCGXBN6rc5S
1onsAP9oH3K4pQoIax+qSGFDjZf1pwd025OJ8HYNXHVk+I8vEwEAiu05mhpZJWF4
zStwwbYgpqkkPFWKzpHYUtNrcO/tdwU=
=BfyU
-----END PGP SIGNATURE-----

--------------ku0sMi9hUnR02QaV2h2WUqQg--
