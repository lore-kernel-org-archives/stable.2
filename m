Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C864E80D2;
	Fri, 25 Sep 2026 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790365363; cv=none; b=VM2ldgTXI+G01DKcWK6TSBu1Jd/5wnX71//Udx7UYW1GZeZM4cYKHwZiIU1Q6rBBtXYtRjZ/O/qJiVOTX6HzhNPfda7r+6Io5M7+IBuJZPFbN7L8Rzerd7jzkG5jWhYIz9AL5M8zF4bhrYXa2EIwVYg2AEEEWl15o91+uQPz6vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790365363; c=relaxed/simple;
	bh=aMNWTWyCqUsOG4orvXSkh6kcO43dY8xamvLY6SlMSqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M49BeitjYXAteAvczAli7MMehxH/tn0T7o08L7cylR5hbKjnwl14rJkKUVATHQJSt2zvrffpjdITfHsO7lMIWKEiSMGdST0SxBEK+b0/odkSatWJ1/tGdC4zKbIIVceDpOmFxGmiQZLSz7vbfTmXsUPHOb0n1K4ymFu4RWg7rcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/8huc7l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/8huc7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6063A1F000FF;
	Fri, 25 Sep 2026 19:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790365358;
	bh=aMNWTWyCqUsOG4orvXSkh6kcO43dY8xamvLY6SlMSqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B/8huc7lVai+g37VoD897gWW6n7zUWJIrF/g478Lqoqss0UMsjQ+ljSqgoCTaNcaJ
	 d48fZqp/wcrzoQB04i7zGsRRJV63M9+P3IWL3ZzpsW0aWz9Hp3SE3yBlyBpgbnJh2a
	 aAkHmDIuShZGMWFCxNaxarm4h6zPPfXAqmLbd+0ILF3PrMJrUgV051omcUSeWREIGR
	 7vRDPIB2YYgttssXvWe13/8npFrqKx9HbSN4VfXc+2gvnvn4eeftxXZ0/EkYOvPU5a
	 E2FYZJVL1UQnBh1MX8RzQj+bFI3xQKn3tMYg7eM8Bgme0zsEadW8dZbKSRa7caiOX/
	 Bvwwd43ywlc+A==
Date: Fri, 25 Sep 2026 20:42:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Lucas Costa <2000.costalucas@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-spi@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] spi: bcm2835: fix device_node reference leak in
 bcm2835_spi_setup()
Message-ID: <ce711fbc-71a1-460f-bde7-9e2cefd96db4@sirena.org.uk>
References: <20260923184450.135601-1-2000.costalucas@gmail.com>
 <20260925193008.127314-1-2000.costalucas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/SVPUL7HbZZHdKNN"
Content-Disposition: inline
In-Reply-To: <20260925193008.127314-1-2000.costalucas@gmail.com>
X-Cookie: Love America -- or give it back.


--/SVPUL7HbZZHdKNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 25, 2026 at 04:30:08PM -0300, Lucas Costa wrote:
> of_find_compatible_node() returns a device_node with its reference count
> incremented, but bcm2835_spi_setup() only uses the return value to test
> for a matching node in the loop and never releases it.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--/SVPUL7HbZZHdKNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq2zqkACgkQJNaLcl1U
h9CRqwf+Ik/gAzOMcIALAuD9d3R0DPLClvHRDU3PpVBp13v3tTe9cBHSY1Xm9It2
weYQOM7tmlg9uWyXweim8tkdgUGWnfn5IoPHFk8uBCIxuJUmd3maBfkOAaVe17Bi
2QRsjVNvKL4c7S7YBmmPWLI0ojlxgQaL/Rh05I4T78VGlz1zTDsWiDDLtx6BimsE
hziLeR53ycJqjI+PsDSkcbEwx0uAipzmDhs+klidb6mGuV9KRsnFlnr3DkOSheqV
pSWU6uNS5C13gCzgsklJDctcRyLJZCg3osEQhNVLH+XbasmzsbyckYhqVsDTvr7k
+/FKmYJ+J+FaazSQSwJjlf3CFXUOrg==
=hogG
-----END PGP SIGNATURE-----

--/SVPUL7HbZZHdKNN--
