Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B63DB652;
	Fri, 12 Jun 2026 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267863; cv=none; b=GWT64iAIHCj3wkRerWoCWEIHw2Y6sexXRHZ9Pjlu7RkXvk1F1+HqXTmG0+7wadcnSQTXTNMlBBomII0QQ6H64BZokldJm9iQwBQkVpAsD2WUIFdIwsUU5suGt+TV5vSdyste4RQFeFH0BDo7TQOjJ0D8vkzJmeMnFBgKs/2iZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267863; c=relaxed/simple;
	bh=MLaoj618ugGUnLY1sDpNI/JIio/w6trq+CPhGyjXJsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLky6EMLDkqf+iHLhasFwI6zJsQSeRruedjvQebtRHx6mguPz+LSF4cuhsoMFGddnETc+kGQngK9+ULwlhUbTNMDONRFPFR76Tfz/qvpa+nYSaWewToUxhEcqX8VGhMoHCHeHKFXf/8Q8H54qzPCpz/m8rxxZ98CfKE7I9tq/Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhPFpNLC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhPFpNLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CEA1F00A3D;
	Fri, 12 Jun 2026 12:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781267862;
	bh=MLaoj618ugGUnLY1sDpNI/JIio/w6trq+CPhGyjXJsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OhPFpNLCMu6p3UVIv+GrZxDel5NM2zrkmRC32ICYU5eowxNFB8RcZVGwyCSZRyLZM
	 /uqWj9kwoBQEiVxC8Ip0zG/nN/arIoRZEw/bEpjw89sgxT8xBoKPhlr/jnYTKxsuq/
	 lKeNMQbw56u7gyR+vkDEA00yjnEBCgpYTc5A+abyyiw64m8i596EIWBI2u2dVQyaV2
	 cbWziNSzRsgaXBTOFTxv5HXBpT7DBAy7NCjsV3EiDlBmX/Q/04E5sjZvvZs5kasdBa
	 bSk/H2PMIT26qFCFyW6ySdgODFgJRVVFjRBO5M81vhnJKz8KLVQilFGSUH7gO7NIeM
	 +Lv0MC4rja6lQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id D74E81AC58C5; Fri, 12 Jun 2026 13:37:35 +0100 (BST)
Date: Fri, 12 Jun 2026 13:37:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>, stable@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] spi: uniphier: Fix completion initialization order
 before devm_request_irq()
Message-ID: <aiv9j5CInFE3twZX@sirena.co.uk>
References: <20260611113137.139673-1-hayashi.kunihiko@socionext.com>
 <airBmzYhnxuK_xdh@sirena.co.uk>
 <cd454dac-868d-43b9-9b50-9ba9f3f370a9@socionext.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y/POWcu9qVi0j0d+"
Content-Disposition: inline
In-Reply-To: <cd454dac-868d-43b9-9b50-9ba9f3f370a9@socionext.com>
X-Cookie: Nice guys get sick.


--y/POWcu9qVi0j0d+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2026 at 05:17:49PM +0900, Kunihiko Hayashi wrote:
> On 2026/06/11 23:09, Mark Brown wrote:

> > This doesn't apply against current code, please check and resend.

> That seems a bit strange. I applied this patch to v7.0 and linux-next successfully.
> Which tree did you apply to and fail?

It applies to none of spi/for-7.1, spi/for-7.2 nor spi/for-next.

--y/POWcu9qVi0j0d+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmor/YoACgkQJNaLcl1U
h9CSZAf+KZm3kSUqca9u97nHbQlwVjEXYEInZhJlUX0dECsMhLw97D1TU+Cj42+o
z6NIQNWrzvpywu3pRAlOgVSoxaqiusjIx6gD0jAvdM/OaCAdEKJTEJD2qSfqn9h6
++pfqfBtoM0Q+0yfEk/eVnaGFqBmk3977DpPNZkp+L8FkeLhQlKCajr+P5IFu1Bl
ly1uWFl8LSQUw1WJ6TXd/kiC5PMZYAAiewnm3PucfTRIl/21oz80u6KgIF8FO4w/
U9ryt6a1AMS+G1NiHPyI3QAipxLoolDVSq3Y4Gj01SBD9f7UMdWDeEq1XNT+1UPs
i0M07bDkqvtIFZyEI4kraBfL5ynkwg==
=P7CQ
-----END PGP SIGNATURE-----

--y/POWcu9qVi0j0d+--
