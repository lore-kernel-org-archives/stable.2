Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7723FBB6D;
	Wed, 10 Jun 2026 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104970; cv=none; b=q+mwR6VJW+eHqzNJsHVipaAI0kG84tZ+C5WBPIrjxPXhlqw7TwP01uFrTB1n4CWJKj2GZsbGJtCHiL+RGlDwSQ2/CaQHUU41IIovBQtzZBsWMihyh12b+pdAt9a2tqa40F97g0sYlZJdgWAk3QuxOLdMJTUSms1qJerh7U9jPoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104970; c=relaxed/simple;
	bh=tjeHCcfcc1UY7v3arJIJVfF5rvyuVca9pf1d2snOYPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIydCQmTCkZZte+RLZTw2SOaA5Gh2uoyP2OJ3TApwoS8bJuStBoZ36HwHq9FPFEPx5FO5YuL4o37kOVheMO0f6W4G4AmngrcTZmfuWVDnGyVXa2FibhS1TWhseey5aGP62/farWbBCnLiHU6LgKFwdaJqZNDmniVYCncbvlBzMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfEIWx9Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfEIWx9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDEF1F00893;
	Wed, 10 Jun 2026 15:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781104969;
	bh=Ab5xwG2jSjoao/BonbPvT7rKuQKlAut599VCZh1ZndQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FfEIWx9ZOcWLA9wYrVyv49Qlw7gnxLC5gwHAla+CCS1T82yJVp4OnZO2jZaXfbYSM
	 pFmk1n6rESWI/3ldDs2X85kL+gvJLBp97smSVtyU+h/ERm9V+4DYKF5mTx6iVFqtSL
	 wc5xM64sEfG9eCv9q/FqRpqybHXXBIKL1ACh/TPnAoC+sNM9d8euIz6KZ0cL/PW1/o
	 yV9VMjGNQbjghO1Ij/tB3nF7KsJsj+x3rfuQ2Rn9jbG+nxk8XGN++cRFd96c+eojMP
	 835K+sG0PgKQUuIVRI28LkofwlBZdaHhXqnEhiF3ZKb3p9TVQN0NRtOZMdZtikBHjL
	 IVqA6l81p3XOg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 0A8FB1AC56C5; Wed, 10 Jun 2026 16:22:47 +0100 (BST)
Date: Wed, 10 Jun 2026 16:22:47 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?C=E1ssio?= Gabriel Monteiro Pires <cassiogabrielcontato@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
	sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, notify@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: SOF: topology: validate vendor array size before
 parsing
Message-ID: <aimBR9VyYnK8CpBD@sirena.co.uk>
References: <20260603-sof-topology-array-size-signed-v1-1-84f97879a4ef@gmail.com>
 <a14ebacf-2c2d-4de7-8404-05ae92d8ee83@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QxF6KMoWeVbyIr9v"
Content-Disposition: inline
In-Reply-To: <a14ebacf-2c2d-4de7-8404-05ae92d8ee83@gmail.com>
X-Cookie: Leave no stone unturned.


--QxF6KMoWeVbyIr9v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:27:25AM -0300, C=E1ssio Gabriel Monteiro Pires w=
rote:

> Gentle ping on that fix.
> Sorry for the noise.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--QxF6KMoWeVbyIr9v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmopgUYACgkQJNaLcl1U
h9B3UQf+KfaCYwYZ4YsgqMYqhUmQGFQv5AqYg1LzCxVg9+NsujKPWhEgRE+fFaU6
8ABO4xT9LATXR6wYuc0A9QzON0GkUht7UGOjEzdQFMvygT0ZLb+TSQqlpqVyqL1j
WwhkWSldc58ksDwUG7LbgWvRuz5AjeAzO32hXyxzOM07jvsDqfgHUsfQGJrGXxWi
l6pgoBpgIM9380XURCw/QOCe2DDegdq7qDrp+zgDAQfY6X5xRTLymQew6CLx0uw/
b2+r31e+CfIqskckhvw2nSyquuz0wrtSbHzdgfUklEVKoWsNkWxndZPgg5apv5Py
2aWpDOejAxvAqiF+9/dnN7GMZBg3bg==
=5Q9F
-----END PGP SIGNATURE-----

--QxF6KMoWeVbyIr9v--
