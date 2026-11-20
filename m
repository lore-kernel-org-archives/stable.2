Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795175844;
	b=3MNKX5Fc9q8olRo5jg2X8eunpc9EDarydH/4olOJDyn/dzuiwx9sZ0txN1UW/Rj9pAbL
	 JR2MoBnAMZ2WdIIYggh7W5lMsSvRQlpyHgYw+DeUORbq3No+voAcy1YX5Obm7H2bnGaIh
	 +9ZJKGaEI+n7GdhPu6pg95WjjlpCBGp18liy/gR7XP3dysTXno9HBdjxh+yw4xQnHsiIP
	 i+W7l35sQh/Ol60mIpnONHqaBbNdNL80LyEmZ+suHcCSHEjftBdCqNAv1yTIDgVjd8nXs
	 Iy3oz7C4ycyRJAmlU4DRAqQwVxuwmi6u9O8DhAiwFNiyHSKpzuP5vRDtIcrrsIFTuXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795175844;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pdNBt5/QsljbHatJBoM3WFB43io1ZCGsN7cIkFS28SQ=;
	b=Z72zW8RtHW6oeeSD0oHHdTswVFIjlyKl8zXKSespd3ccx2C3UpnMdG0dy5scNQygYbez
	 BrNkRhDgJoVzk+l/8OjTkL4mznOKSneEoOshbPzb+oVopaVRnSlB1Ijq2qKUhDijoR8iZ
	 /TEmIxqKTFXcAZ8aIRV+Gc3+ZhyKTc2vEnnzP3cT0Sh8NqyVOEk+mGLbz5NFe9Ur6CHfn
	 rdHmYo3DvA6DAf9cWbZHikY+RP7nJ/DBUzKCmOGFKXe1/0XasDzBR+qwC55bNW067b1BD
	 GVDg9d53Eb18hDoJjdo/9T313PTbhhccO68BbbpF1x0vvVFaAg5Fx3DNhgMUHFslirw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jDEv/F7E";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 59D7560A2600;
	Fri, 20 Nov 2026 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDEv/F7E
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DFCA51F000D4;
	Fri, 20 Nov 2026 11:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795175843;
	bh=pdNBt5/QsljbHatJBoM3WFB43io1ZCGsN7cIkFS28SQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jDEv/F7Erv/9NUIF3nkQHQwvKPaklxbGgg059lQ41YKZOGB7i1a3rDgnHKll39x6q
	 qh9r/2SHlq5DR6p0TQKK9E+G1Pji+0SrRqIGJF4Gb11J1KRJOJ81HkgZBLg59j8ptA
	 p8QxCfpCUfZX/ooIbsMN6j8xDu15pOsYAJSE5KDN/xh8kaY8H/g3vpeIN8yE804kS7
	 3+MjnbuVhCjrVarGiWGocP9ktpo7jS6Q33uvSohgm6hljwYQnfm3nMxxNQkbRQif22
	 S4V3pzIxbLNwh2Van/ULeMg/3JCBREi8m0L4eFAaowpzuYpHR50AlSuRd1BsVXDZ23
	 +F+Q0grLtEm3Q==
Date: Fri, 20 Nov 2026 12:57:20 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Joachim Eastwood <manabian@gmail.com>, NeilBrown <neil@brown.name>, 
	Grant Erickson <marathon96@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Lokesh Vutla <lokeshvutla@ti.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 6/8] pwm: omap-dmtimer: Handle negative error codes from
 get_pwm_status()
Message-ID: <awA06PJuX4-Imck4@monoceros>
References: <20261105143847.2559586-1-lee@kernel.org>
 <20261105143847.2559586-7-lee@kernel.org>
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
	protocol="application/pgp-signature"; boundary="646ge4fg3vjxp6bk"
Content-Disposition: inline
In-Reply-To: <20261105143847.2559586-7-lee@kernel.org>


--646ge4fg3vjxp6bk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6/8] pwm: omap-dmtimer: Handle negative error codes from
 get_pwm_status()
MIME-Version: 1.0

On Thu, Nov 05, 2026 at 02:38:08PM +0000, Lee Jones wrote:
> omap->pdata->get_pwm_status() returns a signed int that can be a
> negative error code on runtime PM failure or invalid timer cookie.
> pwm_omap_dmtimer_is_enabled() and pwm_omap_dmtimer_polarity() store the
> return value in an unsigned u32 and test OMAP_TIMER_CTRL_ST (BIT(0)) and
> OMAP_TIMER_CTRL_SCPWM (BIT(7)), misinterpreting negative error codes
> (such as -EINVAL or -EACCES) as an enabled or inverted timer.
>=20
> Store the return value in a signed int and check for negative error
> codes before testing register bits.
>=20
> Fixes: 6b28fb6f3ca3 ("pwm: omap-dmtimer: Implement .apply callback")
> Closes: https://sashiko.dev/#/bug/linux-f4782faa-466d-43a8-85d8-6d6181ee2=
243
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/pwm/pwm-omap-dmtimer.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtime=
r.c
> index 51830a87275c..1e4d8b9e224f 100644
> --- a/drivers/pwm/pwm-omap-dmtimer.c
> +++ b/drivers/pwm/pwm-omap-dmtimer.c
> @@ -111,9 +111,11 @@ static void pwm_omap_dmtimer_start(struct pwm_omap_d=
mtimer_chip *omap)
>   */
>  static bool pwm_omap_dmtimer_is_enabled(struct pwm_omap_dmtimer_chip *om=
ap)
>  {
> -	u32 status;
> +	int status;
> =20
>  	status =3D omap->pdata->get_pwm_status(omap->dm_timer);
> +	if (status < 0)
> +		return false;
> =20
>  	return !!(status & OMAP_TIMER_CTRL_ST);
>  }
> @@ -126,9 +128,11 @@ static bool pwm_omap_dmtimer_is_enabled(struct pwm_o=
map_dmtimer_chip *omap)
>   */
>  static int pwm_omap_dmtimer_polarity(struct pwm_omap_dmtimer_chip *omap)
>  {
> -	u32 status;
> +	int status;
> =20
>  	status =3D omap->pdata->get_pwm_status(omap->dm_timer);
> +	if (status < 0)
> +		return PWM_POLARITY_NORMAL;

This looks incomplete. The function is used in pwm_omap_dmtimer_apply()
as follows:

        if (pwm_omap_dmtimer_polarity(omap) !=3D state->polarity)
                pwm_omap_dmtimer_set_polarity(chip, pwm, state->polarity);

IMHO if there is a problem with reading out the current polarity apply
should fail. With the current approach the polarity setting might just
be ignored. The case above is a bit similar, but I think there it's less
likely that strange things happen.

Best regards
Uwe

--646ge4fg3vjxp6bk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsANZ4ACgkQj4D7WH0S
/k4fvgf+MIJ3RQlG1TtJ0GRLrZOom3yqWdtSbejqqIJCdEnVPbBuOlP3TmlRDeGb
I1ReH1oOC6/LFAZJUiN+SCcZnYkmqLZ6Mix6yAHVbmfW60g/UwVGjXKwKpqB8bL9
O/SbTs9FT/SJGHooRdYXqs0JGn9scvTN46BOiCbcP99/VjGOi3YcLehKCl49lK3j
mX2eiCSPS2TxBAjCkG6rsGfUiAyOhFF7UVyj2tgwuUUTlZnnKDCpOQQ/mTxs5C2N
I9bkg1iUVKQ6zZKQFtKGR7Grvl2AbD3OJsNDzfFDf5gIXOJCKgtBgTOBz/UVQrKx
XppD/Ya9nS/coiK/1sIpP5NNLZDoTQ==
=gRY8
-----END PGP SIGNATURE-----

--646ge4fg3vjxp6bk--
