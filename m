Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714197;
	b=X79ObV2qnfjNq4Wsu/aXd09m+4a/5zBSLUE/SR/Q+RGJDiANn7J9DT2DcZBPXP4v/Kme
	 IvO9cGz5Qf7RQSPkku8rSOSYufD2DXdVBqVFBetb3IYMoyNWV0baII4LpizqOpgIOyG6z
	 aCNHGS5vL9wASKUPK5Bm2dzknPmFDUgv8s+iMFZOJlMfRWJHT8IdjYLWNimSwQFIsP8pd
	 frSQf+Xq2iUDge2VuJ8V+ylw8yLQEghjC17O9++6FAg/EXaQsV9ewdawRzaFfGAdJPPmK
	 Z05K4v43qxHcHn+7qbZDGxAvOV3jn68p4HVTdeAKTP71IcGilR5B6FNG2tdtRaaZpxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714197;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=R+Lz59YAmE39OMTr2JsinbD50rhC0BRWVoCOCQ0iRIk=;
	b=RTNxwS9lyoOCfwlmmV9J/L5K1zl6DrsTA7+qYLOg5eP2FoaMC9BDHl2/1iAuqS98WaxF
	 1K37ly5FW5N7q6UmvaL491Y8vJNaJO9UGNuDg8OhNAieB9aV+nI90PqmlLiFyDAJElsBR
	 115YHlPfJpg2tcEMtHZC3VzqboxR9wr/gx0kGcovTd/XK2p6zHkd+NPV96cPSGbUfP5IZ
	 yP7pe111LOKnjnBIMHikDMUxWgxE+ovVTYl9tc4M4j6ag5EKdakrSgHMnkxo1M7x7KR3G
	 kypoxuHUYB/pJcw6YmKLI1xa9ArFXCj3HoWdLUZs4DLE1+6FNG6ayRiKBfIKmM1/WNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRGVRqwi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EB5606D834;
	Tue,  3 Nov 2026 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRGVRqwi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2751F00919;
	Tue,  3 Nov 2026 13:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793714196;
	bh=R+Lz59YAmE39OMTr2JsinbD50rhC0BRWVoCOCQ0iRIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PRGVRqwiv6MTZLxMLY48nxHMWgsFAcHVQqSjW+03fKfFTsD8J7XY+8asguReA4+9l
	 snQCwXIRcT2lHftHDW+j+YdpQHpcc5srRgKCGzH6x7BSYlcdDB49Kos+3hHbpdzNHk
	 ASQNL0hGSSQY8OOqCvRS9PE4W/Hqayx/NDf8tVmYbRwktPhqDcX3R1fu7bbqxvp0xj
	 31mVkymrskroU2Jha52BCjuf0QoIlRgezvjuUqnDqHgkLwSsHxQpe7qjkntoITzsP/
	 MEwiv1hroVCqQKqyz0xcFcAdk1qJYylCzNHzOedSkkEI8WnvGjfAuAD3gXRsrICO/K
	 YxYPo/kMew9lw==
Date: Tue, 3 Nov 2026 13:56:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Wei Wang <wvw@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	wei.vince.wang@gmail.com
Subject: Re: [PATCH] arm64: suspend: Save and restore TPIDR2_EL0 across CPU
 suspend
Message-ID: <8f1ccb65-e4a2-450b-944c-9883ff12bc37@sirena.org.uk>
References: <20261102234813.1069156-1-wvw@google.com>
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
	protocol="application/pgp-signature"; boundary="6IYMj8soJ5dhvHDN"
Content-Disposition: inline
In-Reply-To: <20261102234813.1069156-1-wvw@google.com>
X-Cookie: Small is beautiful.


--6IYMj8soJ5dhvHDN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 02, 2026 at 11:48:13PM +0000, Wei Wang wrote:

> On systems with FEAT_SME, TPIDR2_EL0 is part of userspace thread state:
> the AAPCS64 SME ABI uses it as the ZA lazy-save pointer, and the kernel
> context-switches it eagerly in tls_thread_switch(). While a task is
> running, the live register is the only copy of its value.

Thanks for catching this:

Reviewed-by: Mark Brown <broonie@kernel.org>

but I think we're missing some other registers, I made the same mistake
for GCS with GCSPR_EL0 and GCSCRE0_EL1 and I'm not seeing where POR_EL0
is handled either but possibly it's somewhere I didn't spot.  I can look
into those incrementally once this gets applied (or if you do a v2 and
roll them in that'd also be great!).

--6IYMj8soJ5dhvHDN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrp6A8ACgkQJNaLcl1U
h9Djkwf8CKSaRV2sUPe1CvYTnDySz0g3vSKK7JXAzIRm7/VW/CeVsU7qAR2VxvOQ
os/IemWfB91LhdGiI+0r7iVCLjU8tgnMmj6w5Yj+KZU15W7QeRxeYYC7orlzQbgK
Uy/pLapQrvXwIu7ZxyE9BlPAvKyqTe3uHhJVZHyl8sGZ0vTs4+5osA94wsUG+ouk
Ab9Qa8ycZf10jI8DUDVsWpZyXn704V81m+PfUziecTQp1FRQad8pDLcPcLk1oYf2
9Bk4ysiIbRYzVzi+5EFH2n6BTpKkw0nsUS6SZv2dxzX/dlmSb20Rd9kyId4WTWYS
cmkbN8UklQLpeHEZFnpKhyVgOAtQcA==
=zl37
-----END PGP SIGNATURE-----

--6IYMj8soJ5dhvHDN--
