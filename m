Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09693302146;
	Thu, 16 Jul 2026 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784168170; cv=none; b=G8pyfKtckNYu72ssTdp5FrMgVtjCtxQN959ZgKTcz+cdoefOxE4qjFEksS44bCTb1BiKOOldrNlzSIuf+SFu6AsTYinx9xTAHVrNAGDuBvbNeDANkzKJm/bnyqOZNYvl4PZ5XNEKYORob0OvsFcQLRNPf73Mq5gSGY/+1kS9J7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784168170; c=relaxed/simple;
	bh=B+HFJyTCa3EVVXEcNuT1tILVYIilN6OkBTWg8sgH++M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kl8RiRPfhKlvfijHlaDTcQX4Kpn2Gq13gtWhokub3y70GhSQw4+tl4VDx5xBdtP4artS2ZfqCsHV8kutHtYYVnEVbQILwQNteTcpVHaGABvjXog0f2F/2C4ZEJn+enp4a7BEMfQC1EEefwT242GG1OfwmfRvpmiuHOtiqNJzaBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APzQsnpc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APzQsnpc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B85E1F000E9;
	Thu, 16 Jul 2026 02:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784168168;
	bh=B+HFJyTCa3EVVXEcNuT1tILVYIilN6OkBTWg8sgH++M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=APzQsnpc/h0TBf+axgiDQYvBy+wydioxquGex71GmFHrrUzUss9Jqe4R0nBNBFD57
	 IkCliixQ1AD0aHHxSi+oA8DYzXAoN8ZWonS0MKSDG5to2hI71SIAAv4rx85z8QO7fI
	 s4cbWijxgYqZJf0Z/cCzL0d3sHt8Ym/7IJNKBh/5uvcxtSGfX+2tT5UUfwpkyyDcia
	 DlQ6/CV9FPocX5l9sQieAvWX3wYAv7zy8g+gxoiu/uHrH/HaO+bjT1wdXClhMgjP76
	 pk9W36b3NDKzT4dqiFZrWCMKAEQAlcTrNv/vQfu2o9FSSG234j+mquLdOvVz0/YO0a
	 3JnOmwcx4/Gpw==
Message-ID: <aad6935c-b0b2-4442-8f1c-706aa4a77966@kernel.org>
Date: Thu, 16 Jul 2026 11:16:02 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/page_alloc: don't spin_trylock() when disallowed
 in free_one_page()
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
 <20260715-alloc-nolock-fixes-v1-2-fadc49952dda@google.com>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260715-alloc-nolock-fixes-v1-2-fadc49952dda@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wz9HOl6nPDiKXr07fOYppyiX"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------wz9HOl6nPDiKXr07fOYppyiX
Content-Type: multipart/mixed; boundary="------------dH64BqDFOVjTDMP3JqgnEybF";
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
Message-ID: <aad6935c-b0b2-4442-8f1c-706aa4a77966@kernel.org>
Subject: Re: [PATCH 2/2] mm/page_alloc: don't spin_trylock() when disallowed
 in free_one_page()
References: <20260715-alloc-nolock-fixes-v1-0-fadc49952dda@google.com>
 <20260715-alloc-nolock-fixes-v1-2-fadc49952dda@google.com>
In-Reply-To: <20260715-alloc-nolock-fixes-v1-2-fadc49952dda@google.com>

--------------dH64BqDFOVjTDMP3JqgnEybF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/15/26 6:03 PM, Brendan Jackman wrote:
> __free_frozen_pages() checks can_spin_trylock() before entering into th=
e
> main free_frozen_page_commit()/free_one_page() path, but before this it=

> can get to free_one_page() via the !pcp_allowed_order() and
> MIGRATE_ISOLATE paths.
>=20
> The !pcp_allowed_order() path depends on usage by callers so might not
> be possible in practice. The MIGRATE_ISOLATE path probably means kernel=

> crashes and privilege escalation if anyone ever did memory hotplug and
> BPF tracing on a PREEMPT_RT or !SMP build.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 8c57b687e8331 ("mm, bpf: Introduce free_pages_nolock()")
> Reported-by: sashiko-bot@kernel.org
> Link: https://sashiko.dev/#/patchset/20260710-spin-trylock-followup-v1-=
0-affb5fe5ed00%40google.com?part=3D2
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

Looks good to me, so:
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

--=20
Cheers,
Harry / Hyeonggon

--------------dH64BqDFOVjTDMP3JqgnEybF--

--------------wz9HOl6nPDiKXr07fOYppyiX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCalg+4gAKCRCGXBN6rc5S
1hTBAPsGl6Hne7o/jv65k9wae2cQ0p9eX3JNE4A50yekAYolMQEAgBTot7X6zAo6
KUsEjPVelda4zLtByH+fmyjeXZxYdgI=
=vued
-----END PGP SIGNATURE-----

--------------wz9HOl6nPDiKXr07fOYppyiX--
