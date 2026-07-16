Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F69628852E;
	Thu, 16 Jul 2026 02:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784168037; cv=none; b=SPyJZxDOQUQlfbV+xJSEG/R13w3LPdQhN6cZTil5YUXDnoFirQzzJw+LPUAmluQmhh/Pk4ojC2z5NJveFc9/QUgHDv75FIyP9juIlrMae4zkSUi3O61Jd6knGMZe8Y7OmTgAalA2obVHKSrpxcZxLNFjvvkTFmDYU5jHYABwVfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784168037; c=relaxed/simple;
	bh=g5F3u5HpCIVAKXXlu6lQyVffkwzqzhRodbunphDG+08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bg4de/GbV1el+uorggOsxFxlJGnBcsKF48PSo8ghzWZPEYGs1wDTX/Q8XYmLDGOBDRj8w31rIOk59gghnMdLHPFJPA7TV/FFMLw8yWVKS3w1qVT00toXvUeiw8Y9aVbMzvuuCB9ZvrnLoVHHWAz3T8FZ7yXxQ7HBSDcBiradiWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBjsBetT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBjsBetT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC3E1F000E9;
	Thu, 16 Jul 2026 02:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784168036;
	bh=g5F3u5HpCIVAKXXlu6lQyVffkwzqzhRodbunphDG+08=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EBjsBetTSLJ/PVXVrqcQdqnyDxxVDV0X2i7wsl6PjjO7XwAqHXbYMpkxNNCLqM3Ag
	 Q7w8Gn4ODpy4hriDiT62lcx4Y99bE45MLrMFL4r2C7pyBxtEKWDVFhMbMABBPohN6x
	 A2KNevJdgn3xL3cHRiXO2U1YEbfY1VR8wr0VV8ejaH+AnymlWRJ2u5Z5+KHf9FqkeW
	 npmW+d2THetZb3DtPP4Kj7716QEjvgDOgqcbSpma/8XdRe/ZGz/9kAvwxx4QlQ6Nqd
	 75tFh5B6g0eWy6tbgLp4JBH6TSPkajTMH2Rdqzvalp8eACMSLnssTJOlfo3iNK5WGP
	 G8xcyb/3fqcGQ==
Message-ID: <7700e867-9fec-48d0-b9b4-d48632fc4808@kernel.org>
Date: Thu, 16 Jul 2026 11:13:46 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/page_alloc: don't spin_trylock() in NMI on UP
To: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Alexei Starovoitov <ast@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 sashiko-bot@kernel.org
References: <20260715-alloc-nolock-fixes-v1-0-fadc49952dda@google.com>
 <20260715-alloc-nolock-fixes-v1-1-fadc49952dda@google.com>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260715-alloc-nolock-fixes-v1-1-fadc49952dda@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Ii0HwgF0oUWLgy0EetAZXxlL"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Ii0HwgF0oUWLgy0EetAZXxlL
Content-Type: multipart/mixed; boundary="------------RMnVot6AwRKrwAyyoZv71EnF";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Alexei Starovoitov <ast@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 sashiko-bot@kernel.org
Message-ID: <7700e867-9fec-48d0-b9b4-d48632fc4808@kernel.org>
Subject: Re: [PATCH 1/2] mm/page_alloc: don't spin_trylock() in NMI on UP
References: <20260715-alloc-nolock-fixes-v1-0-fadc49952dda@google.com>
 <20260715-alloc-nolock-fixes-v1-1-fadc49952dda@google.com>
In-Reply-To: <20260715-alloc-nolock-fixes-v1-1-fadc49952dda@google.com>

--------------RMnVot6AwRKrwAyyoZv71EnF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/15/26 6:03 PM, Brendan Jackman wrote:
> As noted in can_spin_trylock(), using this is unsafe in this context.
> commit 620b46ed6ae17 ("mm/page_alloc: return NULL early from
> alloc_frozen_pages_nolock() in NMI on UP") fixed this on the alloc side=

> but missed the free side.
>=20
> Impact: If BPF programs using these features in NMI (probably tracing)
> are present on non-SMP builds this might crash the kernel and is
> probably exploitable by local attackers for privilege escalation.
>=20
> Reported-by: sashiko-bot@kernel.org
> Link: https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b71=
4e19d3%40google.com?part=3D18
> Cc: stable@vger.kernel.org
> Fixes: 8c57b687e8331 ("mm, bpf: Introduce free_pages_nolock()")
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

Looks good to me, so:
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

--=20
Cheers,
Harry / Hyeonggon

--------------RMnVot6AwRKrwAyyoZv71EnF--

--------------Ii0HwgF0oUWLgy0EetAZXxlL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCalg+WwAKCRCGXBN6rc5S
1tMvAPsExCAfy2YFybwbgzOaolJPi/PXxIAOia72JjLQ8MaGFQEA/ZhQrf9a7VOT
eyWvHkU7fjM2Gm70Z4h84mW204PjNA0=
=iCHD
-----END PGP SIGNATURE-----

--------------Ii0HwgF0oUWLgy0EetAZXxlL--
