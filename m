Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846682DEA95;
	Wed, 30 Sep 2026 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790749812; cv=none; b=dDgpaIqTJaiVpbS+ANyvHQEZgFd0ShWlO42xgUD2xja4tJloQFgXFopjkvc6lGIBa1Pbp0jPoGEXU5lPvs0qCM6En5c/JDermq6fCdUENb8ha57SLpu7PHQ7SoABjKgY6KrREdT200eS13UHFI8+N1e3FimCnaCPp+v9zZXogIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790749812; c=relaxed/simple;
	bh=7rNYBOqx3XnZb+WoYzEmnIy1vgKSnd8R8hItnEfyTNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5nfHAO27Zn5BB0aFIhg6So24D2n7Dj+AGbWctlzo52O9y9tGu6XBj+xGLaa6phrNNkEU7orxMmLVETxzZLEMuQCtCcik+jWz16DWIrCQ0G+yhnHbdZgQ0EAzOBAzq2fGq71rGQswoXnxFWwkMTggkHq03z7XZvdrT/2fSrEePs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kP3OCpXE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP3OCpXE"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7ABA11F00899;
	Wed, 30 Sep 2026 06:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790749795;
	bh=R7J3iwD6KWda/SQTfq8T8o3Q28veXm0eblal/QRczQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kP3OCpXEZ3jGpkmEjE3O0eb7aKLM+3eGWf8axUgul8aDL13FDUINSl5C/l9C7+Q7c
	 8dc0wHRRw5tAgQ96WGjn4plkyOBIlbbH/nQmX9ykb+gDLcIKz9MQtWMm0NxpoxYM3s
	 8CalTmAVyq/89vHFMS12V2DWRPi8kPya/OPu3J+QNf0MiFJz3atzBu4TZCbGc4/Ydd
	 C12yJ1m7h4dSNT4IkwY+qrObRxzKXJGpi4Fy4qx71rAxTG3J51UWX4+dcWvLw/OGt8
	 qGa4pvi0KSoD0cHo86K6b82dczt0KRC0HFTAlDOhVmwb5c344u4sWsOB0uow7syX+A
	 LAQKOsMtvcBKQ==
Date: Wed, 30 Sep 2026 08:29:52 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-pwm@vger.kernel.org, "Philip, Avinash" <avinashphilip@ti.com>, 
	Thierry Reding <thierry.reding@avionic-design.de>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pwm: tiehrpwm: Clear period on disable to allow
 reconfiguration
Message-ID: <aryop_9K29U4i5Sy@monoceros>
References: <20260929120806.2790355-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3hl5tnwt7bhfzvym"
Content-Disposition: inline
In-Reply-To: <20260929120806.2790355-1-alexander.sverdlin@siemens.com>


--3hl5tnwt7bhfzvym
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: tiehrpwm: Clear period on disable to allow
 reconfiguration
MIME-Version: 1.0

Hello Alexander,

On Tue, Sep 29, 2026 at 02:08:02PM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>=20
> Both channels share one period register, so ehrpwm_pwm_config() rejects a
> period differing from the sibling's period_cycles[]. That value was clear=
ed
> only in .free(), not in .disable(), so a stopped channel kept blocking the
> sibling from switching to a new frequency. Clear it in .disable() too.
>=20
> Testcase:
>=20
>   cd /sys/class/pwm/pwmchip0; echo 0 > export; echo 1 > export
>   for p in pwm0 pwm1; do
>     echo 1000000 > $p/period; echo 500000 > $p/duty_cycle
>     echo 1 > $p/enable; echo 0 > $p/enable; echo 2000000 > $p/period
>   done
>   echo 1 > pwm0/enable	# before: -EINVAL, after: succeeds
>=20
> Fixes: 01b2d4536f02 ("pwm: pwm-tiehrpwm: Fix conflicting channel period s=
etting")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  drivers/pwm/pwm-tiehrpwm.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 3a53489f0b982..e3407d0a1f7fe 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -358,6 +358,9 @@ static void ehrpwm_pwm_disable(struct pwm_chip *chip,=
 struct pwm_device *pwm)
> =20
>  	/* Disable clock on PWM disable */
>  	pm_runtime_put_sync(pwmchip_parent(chip));
> +
> +	/* A disabled channel must not constrain the sibling's period */
> +	pc->period_cycles[pwm->hwpwm] =3D 0;
>  }
> =20
>  static void ehrpwm_pwm_free(struct pwm_chip *chip, struct pwm_device *pw=
m)

That looks right, applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

as merge window material.

Looking at the driver, the check for the sibling running could be
weakend a bit. So if the restriction by the other channel only results
in a smaller period, configuration could continue.

(But if you're looking for something to do, better invest the time and
convert the driver to waveform.)

Thanks,
Uwe

--3hl5tnwt7bhfzvym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmq8rFwACgkQj4D7WH0S
/k4TTwgArv0NwKldoNs/hKXexuaaE1nM/Q7mPxOvflY0aQKuW6m11St5L1xr0edW
m1r4uJ6L0z0Cuu2MUBIvh9OLYL/SZIIM5xhp1hKkZyl3X67MHs0IPDZVGAxUG6ca
ZDWLM+7SBZF1jlDyx4jh0iMuppzNngR+D3l3kFaAzDmZNJAF+7nurzzhJ8oJHTKC
BQ20PODqQLnJDs8sd1lrYRFmolOWuHVTGFntM9BU6ZN4OBLPINPTcr6a79DBRTAm
PrpoPqVOz8fC8ublbp3nVoTL0aKl4bRYpGd0IbHHjpBCXM2ulEkuB8LsiKlntbfF
7Z57YejdNtzK708EXTxBo1OEWdLOcQ==
=4VKG
-----END PGP SIGNATURE-----

--3hl5tnwt7bhfzvym--
