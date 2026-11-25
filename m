Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624162;
	b=h6d3/Jg2DEg+t7G47QyNOJ5pGiik/SDqobTnCG3daeVb6DqwjbtOveHLo3KCT9ih7ZrN
	 Y1hL7K7rY5OIiFvFBABpQbNTBjtZohO1pqa5SKSw0wa/L2iRRJvACinNk4sQLwm9IAp7d
	 oDM0915tmPAyTXBF5VkaBg0zcfFtBFARTIoyE8Zv9JsNwMFlX5qNiNSOiKEpOYcas3El6
	 +MTa3O+VKN9cWgQmJo4ujyDEsT2OOeCWYR4HLVAV56eLqE+AGqDGxMsBpY5zc+u3EVKfL
	 9F3uURXzmOOTt0bqWw4ix8N9gj9B6oW9D6dDBXSxUYwUYNY4IBZynPzIC4DXwszzZRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624162;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=ZrosOMGIOcHHN3BqdFDa4C8cbxplNSyD3akiBcmH7gY=;
	b=z3faQrsvWOJuopY6+otFc/LrzwkBqetnx7MPQSAF79ueiQofkhV57t/qyTQezxmH1c3/
	 1U+a6GLkf6UKTG/S+n1vfL9KwwgQ6MYM+Ap1MAHWF1Qzkp6CTDKYSFAl5so6zIVq2zDqL
	 f5fRqwkrX+odddWbi2gg1bpHTwtpketk+RvqO8yMXoD0MEcuyAd75LKwKFQa3jAh8hsJD
	 gG1IIsSEEZzruGLOIQfMEdUJmXndpK9w0OFRk0AFI7/Joa4MsbhWT56STmD/THpCPMxiK
	 cEHS3Q5j+27CgygWXSviojSixGHZAJPSbMEp0DNhZFxSeOHodi7QP1dliBzi0aLqcjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MFVW7YqN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46067606A321;
	Wed, 25 Nov 2026 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MFVW7YqN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBCA1F000F2;
	Wed, 25 Nov 2026 16:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795624161;
	bh=ZrosOMGIOcHHN3BqdFDa4C8cbxplNSyD3akiBcmH7gY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MFVW7YqNlbU9Exr6tC9CWOwHhJ/X1XuwjGHUaFTmtLBLQs/aLGIznC1lpbaJr51lB
	 OrVjW15pnRmqnVSe6gGEtv/D2wPnWLuyun9cgt9xpJiY4wf7Zja+/UfaxDWfHvQ1wx
	 xwCi5hhZAENQP9854cDHA8vvs+oGaQkpuLNRpRNRGCqSuVcN9HXPHRB8fz3U95xvV7
	 PAMGe+AIHWY+c8xZp6OFFyi1yt+I/bTOohayY+wQc5798C0amqAvHLH3KE7vepSTtY
	 S6dEgyD7uCLyAZqmKTfSbMJPY16EsH7pHf9Xo7Wfih70qH1f56gXM6L0X/hHQFC9da
	 nP8nvZqw2aIUw==
Date: Wed, 25 Nov 2026 16:29:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Bradley Morgan <bradley.morgan@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64/fpsimd: signal: Require ZA context when
 restoring ZT context
Message-ID: <63d23d7a-da2f-431c-81cb-1509670fa8ab@sirena.org.uk>
References: <20261110221836.3265929-1-bradley.morgan@linux.dev>
 <20261110221836.3265929-2-bradley.morgan@linux.dev>
 <ee1998f2-69dc-419a-b388-dd4e08cc68d6@sirena.org.uk>
 <a5b278b7-9e9e-43d0-9fcb-a937d3e2a0b5@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rqQd8qHAhqzWc2jc"
Content-Disposition: inline
In-Reply-To: <a5b278b7-9e9e-43d0-9fcb-a937d3e2a0b5@linux.dev>
X-Cookie: -- Owen Meredith


--rqQd8qHAhqzWc2jc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 16, 2026 at 11:07:13PM +0000, Bradley Morgan wrote:
> On 11/16/26 10:48 PM, Mark Brown wrote:

> > though as the Sashiko report identifies we still leave ZA untouched if
> > both ZA and ZT are omitted from the signal frame.  I'm not sure if it's
> > safer to reject any attempt to return from a signal with PSTATE.ZA set
> > but no ZA signal frame or if we should restore PSTATE.ZA to 0, the
> > former is safer but the latter is more in line with the handling here.

> Thx, do you suggest any remedies, id say sashiko is correct, but id hate for
> code

Probably the safest thing is to add something that disables PSTATE.ZA
during signal return if we're missing a ZA record in the signal frame,
that's less likely to break a userspace that's doing something like
fully synthesizing a signal frame to return to.  We should be able to
implement that by just disabling PSTATE.ZA before restoring the state I
think, I'm struggling to see a use case for sigreturn with PSTATE.ZA set
anyway so in practical use it'd just be enforcing the already current
state.

--rqQd8qHAhqzWc2jc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsHDN0ACgkQJNaLcl1U
h9C4fgf/Z07pvMy1eTwb7q1NrkNWarLQ7ksHbK4sfw59+1CXhNUbtkmmram95Cun
MPEWgl0j4Md/tbrZFEjCinWrE7UdyPVGogICUwV1+tbRHIvW98m5iIs8mGeo3yTq
1asbqdUq2qO2oYEXNLGZHoNJKihxSnsLQYPR3XyH7Zjom2YckpseTCsFhPjwCTEj
m1C45teGThtBJv4qlk36Y3yteHpBBZW/Eji8aHAiU/4JA5ddiat9VhkBvOJUBANy
jYklGetr4TYi2btZIXVkIK9ICj/sPwu894gMbNkzGsQuWVBaNsFqn2ojr8wlTyGr
3NxTIYtdgw6bwUg3HDAVIEAkUwNr4Q==
=5saD
-----END PGP SIGNATURE-----

--rqQd8qHAhqzWc2jc--
