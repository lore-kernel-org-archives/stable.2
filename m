Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCC31F12F8
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343032; cv=none; b=YVump7l0KQ6r2HUDyIIOUBPbowat+reN7PgxJNQW7kvBiyiiCSZBfutCLop4flN/hqDmQ3KKkWwdVK30HKCSHvgVgakcPQ9uZyLAb912sw9oHad0gr+gMFI+TLLCpq4kQnllFlb6ov+68i/6l8gp/uB5V0yiw9SJZ1w9KoSieH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343032; c=relaxed/simple;
	bh=djlscI6Z+LF0NxjXAdGB78RNFzhAuQB+OJNtld4lLeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQSvL7uz+otH5CcsIkAq2Fn8+AbwTqhYP8ixfVyjagqA1PGYtnONotMowRjZqtOQeLQXWGel+NScSkhR5OGSd9IPshhAWkhzDCrgvW0KVwf1Bvi2XPhncS9JChPwo8cjIQ7eieU+ktpFicCOLTTc0ggIxkdUU/4nGqAe7lV70d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=PyjNmz4R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X7nFTDDq; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="PyjNmz4R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X7nFTDDq"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 05BDE1D00143;
	Fri, 21 Aug 2026 16:10:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 21 Aug 2026 16:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1787343027; x=
	1787429427; bh=wOJEIZey0XAYRKNTuh9QZxO5M2cSQKFK7Ri8O1Gr/Ck=; b=P
	yjNmz4RWrXyFl4XXHXFWPz6MKeyQhST1bAuDlDS9YwXEbtO37MIFmOibEeT/duSl
	3nSw6gdy+NAMF1y7GaBBZfn17qLnyB5GkpLqLkx322/1yKqSpPK6W5DNjImErCWK
	yBOu4LBGvpm7DE5g8Y24dZRaOly4xrOrl2zX2JmG9EL4BupQfdsfW1jQSMeEAUbn
	KVC/RsqCaz9ejdGr/Upl61Agh3a/T0GpFBYB3tPW3QOaMixQn/rLe1xLUPQANRm0
	yaFoxQ6+H8yJpTHWnmwNkcx718TmiuluyO4xnaSAPwNMsL6ypE+TQjMizTkDhS6U
	aoyxK+tzgvI9WUGfthTgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787343027; x=1787429427; bh=wOJEIZey0XAYRKNTuh9QZxO5M2cSQKFK7Ri
	8O1Gr/Ck=; b=X7nFTDDq49j5b1jVPly6mWIdgreVdkqd4qXOmKCj+RullKQ+OgU
	ZHgZ9+3cXH76wm/txmTsV83hKkEjFaTaT/mnnSsyd29QgqaSgaOtOuHheg7HgDK0
	tWWJ48wCErAzhqsiToPOqutKVBv5s3VrrBgenbHxuvfL+9SC0lnXFubkdmLzvVuY
	yuwy+nEwinZLWLYlXEFhzfZuL+gRR9HjZXYYsDK5RtgJEukIgBsdg7JkEXiMLhgY
	NYs6wjgCeDxNGOBqHaaSSxplZi/kCgAdXJaAChWXQNl/k+IY9keQbK+zhz2Ycfyf
	cCk7ePUnfR2Y0FDKATn+8X0sELM/FtSBs/w==
X-ME-Sender: <xms:s7CIald8RpWQZ3uJWu9ZMmv9LdxAstiTNY55lCKfugWZqMTRo7cKJg>
    <xme:s7CIaqoSv6aWBwF6eLTjIHcLjgplwgx6Q4vdxE6zkToMXuhE12Vne4Sxcn2LlHcfM
    _xq3h2lU3aN8MYIdvuUGL1kAJtTtfGwGMBGmOTA5ArkDZlwINVQXes>
X-ME-Received: <xmr:s7CIar62VX_AdXos_IkWNZjGD2_S8XCl6IK5ftAlZXSFzlHmDnTUxbDbpKM>
X-ME-Proxy-Cause: dmFkZTFMXdD8pPxOO+OgipmaLQB0QqO2bRxUCbwo0tA6AaZ0A/jpc64I78R6vhMH07Vkm/
    UJaI8VGmbMOk+EYO35MT/YRbLbgEHySU9zdAcaGf77o4+Ruunk05aquNKm7uBWSIRLosfR
    iPGAg/dhDUUO2r7uKw/R/ah7QK38ymu6RQtWPCmQbNma3Ttn+6YjtXFXGQkpYY8N+QIkyw
    H167RWh6/7WKF/coInQF3U6SlltnLe+ecP8kWIHYZLCComCDGOKy4qjjcfIaV4DhhBACnD
    696QT6G+x/cLGEIavBViC0cq30jS+IB7J1thzxVJAM413bFJCWuQEpggPIwYrJGObVb3Bu
    OlEB1pl50A7cFQFgJGDdL3mFbbGy9JmHAzd5MdgOQRb4nMrk2j001qm22giN+ynSZGOpxM
    XXtk6xhBsJMdmLcys4NFr4oipI2J1lEhRDVPgVe7U2vOxGIN/eYSdDev8aP9O4BU/CdjMU
    STfpKaL84SQTW6ZY0izUK8bjwfTQ43t1Vid8a5KSTFYkKBX6DsftfgBnTRmW5YSc1mW45K
    tn6dfXuIFJQBkKirfzNHwLhmaWMTjA3wDeTyvBSOU2X6byjbtPC4cTWPoCoxpDBzqEMpdk
    k0l6zeZTOT3J7fiyHtl2Xrv+MF+8pbWPniE/gXlG37ucybD8Hurk8uwYac/w
X-ME-Proxy: <xmx:s7CIaooGoF1Um2Gm4sw1Tzct8YQG0yxXcdcLi_iJOUIq4PionfSUKg>
    <xmx:s7CIalhAnMDAfU_pSHp36LRNk6BeZokRQh-zPFxtUGV7s0JZL2cKrw>
    <xmx:s7CIaqL2BxAsXcSVQKhu5HF4PfWg_8Onl-VZ5VmazXDUBMb4Bgrnxg>
    <xmx:s7CIatCYJELtUKCPBkQiPGzGk3Elr1Oge0piCOGeGaLblGtLtZcNEg>
    <xmx:s7CIan7SN6cwujcVFv0wrVy5dnEnFn5LSGLvjRM_PPXhdvxhQo3Vw30b>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 16:10:26 -0400 (EDT)
Date: Fri, 21 Aug 2026 22:10:25 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 6.12.y 1/2] selftests: tls: add rekey tests
Message-ID: <aoiwsTDosFh5fe2N@krikkit>
References: <2026081717-verbalize-stylist-2627@gregkh>
 <20260819113944.3620902-1-sashal@kernel.org>
 <aoXJfMDP52O9vZVY@krikkit>
 <20260821152000.rc-tls-rekey@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260821152000.rc-tls-rekey@kernel.org>

2026-08-21, 12:51:30 -0400, Sasha Levin wrote:
> On Wed, Aug 19, 2026 at 05:19:24PM +0200, Sabrina Dubroca wrote:
> > All of those rekey tests are going to fail if you don't take the rekey
> > implementation as well (which I hope isn't getting backported to any
> > stable kernels). You probably don't want that.
> 
> You're right, and thanks for catching it.
> 
> To be unambiguous about what this actually affected: the 6.12.y series
> you're replying to here was never queued, so there was nothing to drop
> on 6.12. The same selftest had, however, already been queued for 6.6
> from a separate 6.6.y posting, and that is what I've now dropped. Three

Right. I saw something for 6.6 and kind of assumed that replying to
6.12 would be enough since it should be the exact same situation
there. I won't assume next time.

> patches came out of the 6.6 queue:
> 
>   - selftests: tls: add rekey tests (555f0edb9ff0)
>   - selftests: tls: add test with a partially invalid iov (dc54b813df63)
>   - tls: rx: restore msg_iter before TLS 1.3 optimistic retry (1c8629651cb5)

Sounds ok. I guess you could still backport the retry fix, you would
just get a trivial conflict on the selftest because the context
changed, but it's a minor behavioral bug.

> On 6.6 it's worse than the tests failing - the selftest doesn't even
> build. tls_crypto_info_init() only grew its key_generation argument in
> b2e584aa3c71, which isn't in 6.6, so the ~20 four-argument call sites

Yes, that was also part of the rekey series.

> the rekey patch adds fail to compile, and __test_passed() (69fe8ec4f673,
> v6.9) is missing from 6.6's kselftest_harness.h. And of course the rekey
> implementation itself (0471b1093e3a, 47069594e67e, 510128b30f2d) isn't
> there, so tls_main.c still returns -EBUSY on the second setsockopt()
> that every rekey test expects to succeed.

Thanks.

-- 
Sabrina
