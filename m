Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879183672AA;
	Wed,  9 Sep 2026 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973943; cv=none; b=KzV4SSAi5/oIYHsvBXFh4JbUX3f63g95agsUYPK2zQr1iRTyofZIwgBPAG9BWV7kigC5INAdZGyvXq+BuZX4HJ9sQkt68lOys30tU8XiuqIOvQl9gjqDJx84DZE+hNI49h6PYsStuVGBpwEjGDLE2RqVLlUz1nylhGgV90bG2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973943; c=relaxed/simple;
	bh=JGVzLJ1XZNN56fG5XtMrF5nUv1HMoUf2IXmD2NjsYt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+Lr9EGsrzDSSpqqNTaIc+Eir/x24wNbjyQs2a/Xz1UuomgSAqT+5iTxU7w5VTVQIquXndOY+wa87QY/vDJ0k7rIScYHZ4oJOSt5ilzE6FEe0OEXf8Imx9kUqz8PAdl7UXhngcSG1vEDU5gj7SzWbHpJnU/7qx8QqS9c9IZPo8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMMIaCcS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMMIaCcS"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B8B0D1F00898;
	Wed,  9 Sep 2026 17:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973939;
	bh=JGVzLJ1XZNN56fG5XtMrF5nUv1HMoUf2IXmD2NjsYt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cMMIaCcSWStEtmZJVSd8nnQnmwk91XM+NyRIm3q2wfWm1O+ee2eY60Am2XqUqRjGJ
	 mtMtvCtGYqGIsjX+q2q4zNr0aEoh+dPEqoXCysxjPbn+Hv9eWx/F9dUiganl64VpdS
	 iQAx0XQNbXlXbQOPuePnmlrZfdG+01zIk8vxQ9x7QxL95/EohJGVZRVRDghoGsUEEG
	 flG1BWArL56Df7Y0cKbq0yOAmzL6mggDexmBhUqoSTc8EmEAzo7te5/9xySilUwbXT
	 G91Se9QdYGN6d276lRny1t0krMaq5fFl60NKXaBFyju2ftEKfsnV7KXKsaUAE7pX8S
	 aI8U69zwtShCA==
Date: Wed, 9 Sep 2026 19:12:16 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Ernest Van Hoecke <ernestvanhoecke@gmail.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	"Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, Frank Li <Frank.li@oss.nxp.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Linus Walleij <linusw@kernel.org>, Herve Codina <herve.codina@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Leonardo Costa <leonardo.costa@toradex.com>, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, stable@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] of: property: fw_devlink: Follow GPIO nexus maps
Message-ID: <aqGS1_ndxJa3ifkS@monoceros>
References: <20260902-fw-devlink-nexus-ready-v1-0-68fe1996e78a@toradex.com>
 <20260902-fw-devlink-nexus-ready-v1-1-68fe1996e78a@toradex.com>
 <CAMRc=MfN73=K1nZrqUbhrMSijjpzhF_z_U9JU4_H163W0vRpqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eybq5ldbvfmww6sh"
Content-Disposition: inline
In-Reply-To: <CAMRc=MfN73=K1nZrqUbhrMSijjpzhF_z_U9JU4_H163W0vRpqA@mail.gmail.com>


--eybq5ldbvfmww6sh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH RFC 1/2] of: property: fw_devlink: Follow GPIO nexus maps
MIME-Version: 1.0

On Wed, Sep 02, 2026 at 05:30:19AM -0700, Bartosz Golaszewski wrote:
> Since this is a fix that we may want to backport, the unit tests should go in
> a separate, follow-up commit.

So while splitting the tests to a separate commit is a good concept, I
think the stable guys would be positive to take both, the fix and the
unit-test for their backporting.

Best regards
Uwe

--eybq5ldbvfmww6sh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqhk20ACgkQj4D7WH0S
/k6V5Qf7BUZkOTIPufVrU/X+2bwv6luB5duM0jFEQrKRCOt0WzCV5xnCwuHqimke
/K3ALrWyRTmcJVDG5FmQKHmGeOo0W1fb2Q/1ldTKdr94WsRJuxI3+PKX5D3Y57bK
h0AD6lJZgGCTWTqQFnyeg35HXxSL7O8YbCz7Q5A6KIeCHt/AhlxFjxAgqutcy8d8
o52B1F2Hrj/cXM2SRXqDevx/t/JxialX6GsVubIjfuN5C/VHB5AMS5bH7zVLGlFc
97QPuRP98UkrMLJ25+Lva5E80a6osc18RIVPgA0DXveYAyB+TIqm/9GtQAAZI/+s
NiZmf2cyJXWfBaPVfFhNPYrqiRb8zg==
=XMfs
-----END PGP SIGNATURE-----

--eybq5ldbvfmww6sh--
