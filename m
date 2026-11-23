Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466605;
	b=QClRiadT6bn28vrVz5gXCDtx/aEL9mTycoHCEgAtbVOWpZBGZN672kiV3k9B0OqpsaPi
	 MBSYQWHRRBM23mX19c9J/25GZLZ8rURQwqBxzsnJO1gz2hgcsiCBviQqNBo2pmnylqy7e
	 674IUQNhTPlQ33IbHoustaQJ025pogdd/gN3/M4OrLRiVBysF/OfCfiaXsqD/t2Jy+YyP
	 ZLyEZP/uHEFvxdbENzZDRyxOld9Tii6hcV96MFG+5nD/XIv7Xaf3btx8pva5fkaF1b1fi
	 FVmA2cL5c41yNnkLqX3A9ktO/C1GWdj1yTZeK/Mu37OprtlV8RSSOveEqzPFgN86qRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466605;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/TmfSRvQs92+En4CcUj3ANYb7BeNMTx4Bhef9f2Zzmk=;
	b=QSvi6xTQhRXxGUqnFW+btspj+kbbevcYa5PCymywvq8obFYiQYwHS/rGCLlvXSh29AeE
	 wyej4G27rAlrTxZVbcRGG8oVYTPhw7bmYe3zOqjGZcNEjYq+66yZZTkRAB+pMZLKlveMh
	 P+l9rp9dKvf9DP9pAgW1fRQnAHxXDl2sapBod/mJF4hgRBYVmnW88Flocnz/4sw4S+iB+
	 M04SaCXhju2WRKimhJLcpehFcRzEMH4yW/4Ks5yXmhA4kvX59WFNddICkK4ljJEku0ekE
	 x4abfR8Z0kmYysqw3djxiGjn0m7vzObcqEQV4FCC+e0aGjfrO4XAbKzRT8RmSU+RZeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WV4lF+Ey;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id AD96D606A31E;
	Mon, 23 Nov 2026 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WV4lF+Ey
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A8EB41F000C4;
	Mon, 23 Nov 2026 20:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795466604;
	bh=/TmfSRvQs92+En4CcUj3ANYb7BeNMTx4Bhef9f2Zzmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WV4lF+Ey/CFRVruXVfDEkjRivWdkQ0Nfz736kBjo26N25LBm4TwzwCl/W4/cGIsDr
	 snZmULjzLNUcVtBllZCmK1F80dsM8TK8aOEWETV6enxLCG0/lfIoJeiwq5rlXxSTi1
	 aPuWyH4P0RzcchHMRQzCgHgSJzf4spe5vY13fNG/AvPEsUACf2Yai/fhLt3quWzH3J
	 M2qsjuqhV+zc/gvW0ZkQc+OTY79WNBZBxlgkUfSHSxEcYnMb/wOjlJ4Ss6rkkkJpNw
	 aN0k1eXd5TgJPosbwqPBlgXtGumdhAtQbF6E6K/BTzSsEmjC8W7xdr8u99mn5dCTSz
	 Kebt8kqNilOAw==
Date: Mon, 23 Nov 2026 21:43:20 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Lee Jones <lee@kernel.org>, Gokul Praveen <g-praveen@ti.com>, 
	"Philip, Avinash" <avinashphilip@ti.com>, Thierry Reding <thierry.reding@kernel.org>, 
	Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 4/5] pwm: tiehrpwm: Enable runtime PM before
 registering PWM chip
Message-ID: <awSFqWsxExNtTyjf@monoceros>
References: <20261123075320.379664-1-lee@kernel.org>
 <20261123075320.379664-5-lee@kernel.org>
 <f9218622-c265-4302-997c-e60985201de6@ti.com>
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
	protocol="application/pgp-signature"; boundary="qaa57322c23jinfn"
Content-Disposition: inline
In-Reply-To: <f9218622-c265-4302-997c-e60985201de6@ti.com>


--qaa57322c23jinfn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/5] pwm: tiehrpwm: Enable runtime PM before
 registering PWM chip
MIME-Version: 1.0

[Fixed Thierry's email address, I suspect two of the three @ti addresses
also don't work, but I don't know a better one for those.]

Hello,

On Mon, Nov 23, 2026 at 11:49:27AM -0600, Andrew Davis wrote:
> On 11/23/26 1:52 AM, Lee Jones wrote:
> > ehrpwm_pwm_probe() calls pwmchip_add() before setting driver data and
> > enabling runtime PM.  Because pwmchip_add() immediately exposes the PWM
> > channels to consumers while runtime PM is still disabled on the
> > initially RPM_SUSPENDED device, a consumer invoking ehrpwm_pwm_apply()
> > before pm_runtime_enable() runs causes guard(pm_runtime_active) to fail
> > with -EACCES without resuming the device and accesses unclocked MMIO
> > registers.
> >=20
> > Set driver data and enable runtime PM before calling pwmchip_add(),
> > disable runtime PM on the error path, and disable runtime PM before
> > unpreparing tbclk in ehrpwm_pwm_remove() to match.
>=20
> To match what?

To match reverse probe order. Pretty common and IMHO the description is
good enough.

> The core of this change is moving pwmchip_add() after
> pm_runtime_enable(), but in remove you switch clk and PM unwinding,
> not pwm and PM unwinding. Both changes here are correct, but the
> second is not explained in the commit message.

The commit log says about remove "disable runtime PM before unpreparing
tbclk" that pretty well mentions switch clk and PM unwinding?!

> Would be better to have a patch before this one that switches clk_prepare=
(),
> pm_runtime_enable(), and pwmchip_add() over to their DEVM equivalents. Th=
at
> fixes the remove order issue, and removes the remove() function too.
> Then this patch can simply move the pwmchip_add to after PM enable without
> any other actions.

For me the patch is fine, if someone invests the effort to convert to
devm_* that can be done on top of this change.

Best regards
Uwe

--qaa57322c23jinfn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsEpWUACgkQj4D7WH0S
/k5qeAf/V6PoQlGHU6qeUYyzKDvUYLAh0oaNseaZnUw82icW/b2yomWpMEh+wxUK
QuiBd+irE+kEOPuJ0xU2Jbsc4iJ48Wfva6w4mB54GUQiVaRw0RoNy+0MkuwjCfph
Bj4WMEP4uvImWGVmiPdLmWx9IEqYWN6dc2erMIYAm8B+8KNYkfilfVl88RsIrmGJ
fTkUB/xzX143mwBIA+HVHP2dNulv3RnDztYScCp4lKNiBTV2zPwtGVyHlpIYCNBz
l9u5ncLMA6ku/l2T1ZGNdg728W4xGbpunwsn4fFvh/qR4mlVZgPtBs+H2duIy3dr
Gf012nIuHopvpUjNKBXiy/bsIdgNiw==
=cnPO
-----END PGP SIGNATURE-----

--qaa57322c23jinfn--
