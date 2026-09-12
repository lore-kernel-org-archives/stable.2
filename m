Received: from sonic316-54.consmr.mail.gq1.yahoo.com (sonic316-54.consmr.mail.gq1.yahoo.com [98.137.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2698821883E
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789218256; cv=none; b=uekR2awEeS0l9kCvuGi1PqvMWjRJOpgVFFFRw0vy2NyfPBYkip+P9p5Kn3+bxjLqH6ocpXkIHmqNX0Tj7tPt7Y9A7SPzX4q9tjDwynY0r66mc0t7V11id8bzULWY4LNJxRRLv7ZMTzKAQhRKahAOEOXUMLs1mQewTQLseWRBx2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789218256; c=relaxed/simple;
	bh=SjA0jc2SLZdh0OPVpQ/ElXDHsS8LCY1t92NoZa0vxQo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fLHFuXkSPysUw2tdKtVrbfa4t/sWUfQ6rD3SfPp/BTn5Q5P0ArkBd6M+4mesNXoQUEup1vVOaF5e0D7toaZG7uWhByIH3Ebk2bRxwQcqarfg2gVvm1EfDzIQlPn3I0b5iDfdLFHG+NGLyPrPPmHtDGSpAETTrz2lu7dtrYcRwfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=XKW4v7rI; arc=none smtp.client-ip=98.137.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="XKW4v7rI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1789218254; bh=mg2Q9VGYNNS1T1ETSsx12afkhk81fjoCeS1dAy1Aa0c=; h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To; b=XKW4v7rICqwCYcfdqTzhnzRfvQtIteS6hv4KBpcOExrXpEATVzpzBx8lBC6AaFT8tn6S10SJRWoE8YLyHWjD1BY2yL0SwbWz4fGNQnU3wHjHCY85QZHDH46cufzYgusDvoGIHZwggxlLNDe1tw4zJHzdG6aKLigx0iQ8AjFgEJjKdGa9VeN+D+W2xVRllnlXNoTeDhZQz71G8ob/lWg+nLrLIB07LkKMr3EHmOyUxxQT6PLERzaX7fY6p0PGrjqZ3yO/oHhoocWpl6d9KAJaTtm7611i4uVqzmo+XPTawlACBrBZfEhbNsAiZqOHd6w/op+RkRXf7OBN1WKK5WwomA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1789218254; bh=/0ek4uteEz4lo3Icz1rcnj2a/q3VZYNgOXYKujCm6Ih=; h=X-Sonic-MF:Subject:From:To:Date:From:Subject; b=Sa3YmPFz2EWaPhb+PdMu8DM8U2pJebikmtf11OHPi/jeBuGzqPbe+5pyjtL+8aYvk4mgi6BYU1rwPFt7+k4QS6QZ2eKutLruh2ilBdhI0GEM8ZslqyMGLb4dwxJK0YSaBFK89NaNwb7JR78Xhw1chJcJGNwo3HBeuymZ9pDj+CM2/5jlbBoZxRyLAFQGvPirunPl97SCyv7/epAFMqXyoytmpfMNFNNYoVVhPREYqiCdi2QaEM+s72YmnxjO1+8/SWXYJm0mCUaIqiIxZOJHJvYa1cReGTmrnnZU8GW66jIY/775u5p0ruai7HxUBoCN0xwy3Jr6sHGM24QQwVZ/Hw==
X-YMail-OSG: AN2gwBMVM1l8x6S2jBHtUKNc3K64lc84afsy._nfiU9IH7ovA.LgvjYtT9K30wn
 gVL2mDFoUhkvYkv4kh5QfZjnqHTh6VqAJ8zfHwbzGwPlNoJd6N60pUVwDmJEfE1DWEejC4c_4xss
 vsPCUPj9xt8IBTnJOiAKb1R7u1df3v4Xtr.RZ622eHtTvWmd2RVyDl6cVI_2PpCxnFZKWaeHAy8S
 BsnxRQZhSuznxSKpM5ywZm9xvpBJNRj9xFfG0S8MA8cE7wrEvMuPIrHzaSaQV2mU_a6AYF5nsaHU
 NTUwFdooBjKNWLbg2FbVF.Y.Wx8Nn6zEjM.kNtzgquW0C_QvDiWSWeWsSo7apvIQSQnWFtmnVwe4
 KyA6NRnO9pxGJQJNXOY1WMGZfR7m.e.6E6J94novdMERF_zm2SsFSRIob7jrQRyU74LzfxQRmfVR
 lhwsvAyl0aUWmIkNM.Xg53SmSAYwfbEUCe.jzYi_cj3uV_q0a2GP8a52pHvGNF7I.J0pdrZMoC7q
 Tjk8CAbkLF.fSPzRtmPc0O.rtq64eTDxSa3e6KuJAFVuiLuWcbuMD4LrbJsb7rIDwOA7GBjyB4Xn
 sdc5PvHYeEbd26CArnwRUFiMZTbHh4RaTNj50.RChdbEkWBsC7kQtWSYytjwfUymJs7_NFofr2Hq
 12l3kO.uRON3YtK4Z3XJPB_VjdDNHrhSBRnrKXjX6Nr858zqRNe.v.LgkVigld5yQq7zGdpoFD0c
 LtIPed20CjkHC0yP_eu1SoE8GxAQ23oyNzaEmnRITZGgEN39u1kP6IPEGBB11LaJmzM4EDMRJzHo
 6OOWQEkqvuHNgHgOibaj2VImZjYOwFnvd4onJk_yWtTVl9bDTK1pl.DsENAvg9FJXFbTQhWcuVZQ
 f4ROljAMj9RbxBDHmNaq1q5UGF.0Ncp5lYHVIRdE2GdkIecUZSs.WPbio9_oeDMNDPM3jVTh2PvK
 84_R59jlO6jDOWIYGRseQbYkk3nj2TqHUGff4R6tbUAFrc0H4uuPwlAkvunWa5gUmjuOYIDKMWnd
 3pGW6vKY3kVh9dk2xW.8_mJSjbPxOX_xpcnZ36Kt1xZrmUcXmjRHHOSilFwPEt0izxOmAZ.twvRu
 pD6UQ3xp6lQzDDm1AGVk2Gm9fcUz.d7v9UbiV6Kj7e6w..lWGFL3IuU3MhNIrFztQaqWlaqLwhZr
 8X.rHFSSV77_t4hoFf8HEWz.iGGXz3b0A7wDIPvzlh7cYCzpDzvQZASKvsgxP43JGQI.V1A3XF26
 m9EdaGXZYfr5B6XaU6qCI_iArPP6sFixV6MfjqqLU8yiXImVXzzc18CXvcgU_TxyppFOwQZmFm23
 OSuafwq3wFkgujBiYBUzZpoQ5N0unG.jlSkwPBicaHxCMlYStZBcW6w7brt20JxrPrfnC0grE_17
 82kemNmWpdodoWlHPRkwKaK9oIhxzRIO.rFdPPvTdevoSo2OidslO9jgOwYM_C5gquhUtUgjuKw6
 mmDzFpAJCAxsVg581ysrI9OTi1t5IgCJBBEm0TCQ27v_0IRqUG4xzZLaux7765z9Tb9KnEFGkXtL
 i.gFvreGHUa28eCyO8pbHi5DDax0SG4SnbrkoIUpkmlt3uxYWsI80k5Ymh4w2cwckhnKg7LXDK81
 UzG.J.8S0RDM9zcISAfU0tUAzLBBB0ynSaA0PJYnEAn4pIjg0MCXxA..GyN9uoE9RhVoGqp45dAC
 twPPLpBv9QsSrg.yuo1dYKYI6amb3uobCHggI2.g4Gzx0T981vHNTG0D9d6gwUPnJZhy8HG0lL2M
 rWzZi_hkj0OFKx2KBBwXhbs8WLlggMfZuu8fIFdvzD3OVz4OuZVbUTXLB1F2dXApoPoVY29r5sHC
 EJ1NdrS9Ty53VszixYnG4alBhcHsSv92m56YLSjctIvupC0D_rXifOBS8L6icfw6T5uL0tuXbtGV
 qmQqyNDYzlJDwT9BoMrrN_sJX5rxj2PlNe_NGpnRnwZfrcbHIQHofLZI1L13orXaGVUViQLE4Bio
 7w0TdPaXL9WAF9xcBsaUy8Z09Nbv2PzO99JXANhBklOBKda5fCnfYMNnhUafLoQwIF5nyh_Iwf7Y
 93lkbAcJ45X_8_rpEObHBEcjqDrUG0nGlt7iBaM7wLLtEULFgJaWFNsJCDIPejct9Z.0HOQRmTN.
 ugqL.1SJ19Wry53gNbA97Kwe6ZQkFqDKwD5GuyQWTJ_jxy8SwyXuTivRo1w11CbaDkpGUcEdb.d_
 JUezZAKvxGg8B7zsOzd74te..IMfQsVjmJCo3oVxt16o_rSUB2IxE45lMRyfXsTZpgiA-
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: afea841f-9bac-4d95-b009-7abad01194da
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Sat, 12 Sep 2026 13:04:14 +0000
Received: by hermes--production-ir2-cddf86dcf-rk2hx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ad020d9ddc611d3e97ccf8da6953ec88;
          Sat, 12 Sep 2026 12:21:43 +0000 (UTC)
Message-ID: <bd5c58d759ab5808d0729f01d590e63a8841765e.camel@aol.com>
Subject: Re: [PATCH v2] drm/gud: Ignore damage clips in full update mode
From: Ruben Wauters <rubenru09@aol.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Sophie D <patches@scd31.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
	 <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 12 Sep 2026 13:21:38 +0100
In-Reply-To: <987a45d3-2765-4583-b417-6aae5d350c45@suse.de>
References: <20260907230849.31032-1-patches@scd31.com>
	 <20260910014910.8564-1-patches@scd31.com>
	 <987a45d3-2765-4583-b417-6aae5d350c45@suse.de>
Autocrypt: addr=rubenru09@aol.com; prefer-encrypt=mutual;
 keydata=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
 eIvzsqg==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-Qe+c8yf0zQd8vC/Yhz74"
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: WebService/1.1.26525 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol


--=-Qe+c8yf0zQd8vC/Yhz74
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-09-10 at 08:17 +0200, Thomas Zimmermann wrote:
>=20
> Am 10.09.26 um 03:49 schrieb Sophie D:
> > When running in full update mode, previously small updates (such as
> > moving the mouse across the screen) would cause many full frames to be
> > generated. This would bog down the bus and lower the effective framerat=
e
> > significantly - I was seeing a drop from 60 FPS to 2 FPS.
> >=20
> > Set ignore_damage_clips in full update mode so the damage iterator
> > yields a single full-plane rectangle instead of one per clip.
> >=20
> > Fixes: 73cfd166e045 ("drm/gud: Replace simple display pipe with DRM ato=
mic helpers")
> > Cc: <stable@vger.kernel.org> # 6.18.x
> > Signed-off-by: Sophie D <patches@scd31.com>
>=20
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Ruben Wauters <rubenru09@aol.com>
>=20
> Thanks for the fix.
>=20
> > ---
> > v2: set ignore_damage_clips in atomic_check instead of merging clips in
> >      atomic_update (Thomas Zimmermann)
> >=20
> >   drivers/gpu/drm/gud/gud_pipe.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_p=
ipe.c
> > index 5ef887d84..3388fdc8e 100644
> > --- a/drivers/gpu/drm/gud/gud_pipe.c
> > +++ b/drivers/gpu/drm/gud/gud_pipe.c
> > @@ -482,6 +482,9 @@ int gud_plane_atomic_check(struct drm_plane *plane,
> >   	if (!new_plane_state->visible)
> >   		return 0;
> >  =20
> > +	if (gdrm->flags & GUD_DISPLAY_FLAG_FULL_UPDATE)
> > +		new_plane_state->ignore_damage_clips =3D true;
> > +
> >   	if (old_plane_state->rotation !=3D new_plane_state->rotation)
> >   		crtc_state->mode_changed =3D true;
> >  =20

--=-Qe+c8yf0zQd8vC/Yhz74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEE3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmqlQ9IbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJENJ+UMBQrgzhct4QAJtGidtCxZfJ8nQ/bMTM
lX7ySDGrPMq50AUQKmh8qJ+xK3hy7Xic7oWDGln485cS9PqWX+BK/jvJkfu2VK+y
SfpNiyPqzZDLq94JnzJiniEOi/q0xGmX5EMqj1i+TY/A9uhPMm9jy83qXtGMpgr8
WqsDl443A7vdsxlJXL/XXi1Ffx4npekqQM+KCtFi76H1N6ew0BZESnUyUl4eBdfC
slVyKZOxG/vU+4fE1GJGoKAmKiWzAC7nh2cmd48pIp5y0TTqjlAiRMoL+DqFF5OY
DC9+tXm525QZr6v5yUMoVjFFkIqZ5QOK5TNj/Wlh6Gqw4VaFu17j5yYQNGE2Cfh+
10Kz49g0SuQtyrQdaFC9kfH7JwqtzgwgHSR8tcLffg+rg4yHkOoNh6UxoQn0vaO7
aX8LVeS5jij6UBegsF6UnJ3DEC3LQVZHQLl0Ib36kC0yWTM+IZzmYdS9xHi8W7df
Kr3hiJigoJlPmarL1rclDC6MY8iRi7S4d/6CrfeAv0Cb5GKc/Q5LpHbRJGN/ptq0
KawRXG+EfLFKh0grPdfeSJ1heaULaZGvjKKBuhVaePi8/u4GlE0fC2j8uO9TQDGC
ty5m6lXf/KebY1l9ypoPVZWKRKNse/e8U2K+WoAn9uuVOHpCqELh2FOCL1Rode4X
MYX8725iVGE3Cs2LcKPx61oq
=Zks8
-----END PGP SIGNATURE-----

--=-Qe+c8yf0zQd8vC/Yhz74--
