Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792435610;
	b=gdoHH1PKqA83xCDVT08ww9LlsiSsjiqzSpFyZ2PRt7Pg2hYAd6QSPT00xWLT7kb5kR5s
	 ZjnRkh+PjbzCxJMQ5+4dTO1ZT1Mz2juOOX69TrmBb0Np0NP38X7kNiFlP62zPdBbltTxv
	 bYasEcavVVq+G4ybc2/5Gby7ansHLxsJpSBP/M0B8yysaIdVfsh0PfWFnpsVSr0MT8qw3
	 j8lnNqzB4gYNQKADvAzB+aAi68zalwp5oMrhCznMnFTqrdpjaNUWYB0ZcsaiC6zsk7VdL
	 PsdcJVE89WXX2bZTZ3M31DCKIVrmZyOTbT8c0i9B7ih2j3msgKmlSnObvWAMRI5W5Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792435610;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=JlVIuNAvJb8BGxks+PwmXWerlM3I1JQR3FPq2M7uegA=;
	b=EhvJoObobz7Em9+rtb6W7UWomg//ervOLxWN+K0WVzUqrSLZnjc2hkD8xuF3RrE38DNp
	 cxkzP8tgzZQUc5f4aisk75I4iBIks0HxBfHZNNjbnhStJfpU6El2xyu+FsQy2XDCEMJub
	 FszJYiYpzbyIsPD5xV3RovH4m/mVvCYNUaFZA7pP3Q1WPBnelG7os5g3yRMD8B/KQfl9S
	 AuGkye455ePIgETyifHLzDtDO1s7duhEzqdRCFJ6/bMAp8Ivm1upRbhAyGWxEafbo036+
	 nypc8dxxhjYkTbdO22lJtO2jVELEfddCnFNtphRR4sZinKyoFZTbhRq6r+NPpg50VuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=m2TZ2Ye7;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C76606A31C;
	Mon, 19 Oct 2026 18:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21C76606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=m2TZ2Ye7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1792435608;
	bh=CvGsFWoLph0v+hKiQvOUscsSmU0yUXST+5yRJ1mIOi0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=m2TZ2Ye7AiHEN44px2Vuf6F6ZnMo1fQQD5US1cC8KUGTyrqAsLXAPwLbrhwsyIn2c
	 7jHe+rYm8fut1HwLETzeD8fqOD+2Dn+wA9TqAhNV2Htlzq/OLYLZPu98/ykj1mcBJ1
	 3QmKQ+0VzZs0EhiqPL7wZR30qtwbkrV5Jiy2y/0GbXwlgvtohF2hMYEACkf7IQgeop
	 ypcOC5lwrc8+I5Uj6+NTeWHxDYNW27wTXZu2CEFZ4G9DeIlrIwD3Ex4WNCh9+AsD7G
	 wRi1VY1mdYqtzdPgVXOV7MiMAhZkaF7oRJunkxduileB181wC94/OOe/vHstJvbRol
	 av620AHk0u+Hg==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 06A5017E006F;
	Mon, 19 Oct 2026 20:46:46 +0200 (CEST)
Message-ID: <6242e4c3ecdc7e55a0e32a6cd73b776a0e86f4bd.camel@collabora.com>
Subject: Re: [PATCH] media: chips-media: wave5: Account for sizeimage 0 case
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Brandon Brnich <b-brnich@ti.com>, nas.chung@chipsnmedia.com, 
	jackson.lee@chipsnmedia.com, mchehab@kernel.org, hverkuil@kernel.org, 
	heiko@sntech.de, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 	linux-arm-kernel@lists.infradead.org
Cc: devarsht@ti.com, stable@vger.kernel.org
Date: Mon, 19 Oct 2026 14:46:45 -0400
In-Reply-To: <20261019160003.2375198-1-b-brnich@ti.com>
References: <20261019160003.2375198-1-b-brnich@ti.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Organization: Collabora Canada
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-fR05QOiHm7Ab/PiRZ46L"
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


--=-fR05QOiHm7Ab/PiRZ46L
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le lundi 19 octobre 2026 =C3=A0 11:00 -0500, Brandon Brnich a =C3=A9crit=C2=
=A0:
> V4L2 uAPI states that sizeimage can be set to 0 in struct
> v4l2_pix_format_mplane if client wants the driver to configure a proper
> sizeimage. If client leaves this field unset and configures an encode wit=
h
> high bitrate, low QP, or any other parameters resulting in high quality
> encode, then the driver-calculated bitstream buffer size (MIN_BS_SIZE) wi=
ll
> be too small resulting in undetermined behavior.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 88ff31fd0181 ("media: chips-media: wave5: Use helpers to calculate=
 bytesperline and sizeimage.")
> Signed-off-by: Brandon Brnich <b-brnich@ti.com>
> ---
>=20
> Current DEFAULT_BS_SIZE is just a placeholder value - I can lower if
> required so memory consumption doesn't go up drastically if sizeimage is
> set 0 by user. I saw this was the common equation in rockchip and hantro
> driver.
>=20
> Link to uAPI requirement: https://docs.kernel.org/userspace-api/media/v4l=
/pixfmt-v4l2-mplane.html
>=20
>  .../media/platform/chips-media/wave5/wave5-helper.c  | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.c b/dr=
ivers/media/platform/chips-media/wave5/wave5-helper.c
> index c3d34be833ff0..384a0a9aac3ae 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-helper.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-helper.c
> @@ -7,7 +7,10 @@
> =20
>  #include "wave5-helper.h"
> =20
> -#define DEFAULT_BS_SIZE(width, height) ((width) * (height) / 8 * 3)
> +/* Smallest bitstream buffer accepted when the client provides a sizeima=
ge */
> +#define MIN_BS_SIZE(width, height) ((width) * (height) * 3 / 8)

Does that change put us at risk of integer overflow ? I just don't remember=
 the
max width/height, but please do that math to be sure.

> +/* Worst case: Allocate bitstream buffer size based on resolution and ma=
x depth */
> +#define DEFAULT_BS_SIZE(width, height) ((width) * (height) * 2)

Should be adjust based on the sub-sampling and depth? We could use 12 and 1=
5 bit
for YUV420, and then 16 (what you do now) and 20 for YUV422. Though, as far=
 I
remember, 10bit has not been included as the TI hardware it was tested on d=
idn't
have it.

> =20
>  const char *state_to_str(enum vpu_instance_state state)
>  {
> @@ -261,8 +264,11 @@ void wave5_update_pix_fmt(struct v4l2_pix_format_mpl=
ane *pix_mp,
>  		pix_mp->height =3D height;
>  		pix_mp->num_planes =3D 1;
>  		pix_mp->plane_fmt[0].bytesperline =3D 0;
> -		pix_mp->plane_fmt[0].sizeimage =3D max(DEFAULT_BS_SIZE(width, height),
> -						     pix_mp->plane_fmt[0].sizeimage);
> +		if (!pix_mp->plane_fmt[0].sizeimage)
> +			pix_mp->plane_fmt[0].sizeimage =3D DEFAULT_BS_SIZE(width, height);
> +		else
> +			pix_mp->plane_fmt[0].sizeimage =3D max(MIN_BS_SIZE(width, height),
> +							     pix_mp->plane_fmt[0].sizeimage);
>  	} else {
>  		v4l2_fill_pixfmt_mp(pix_mp, pix_mp->pixelformat, width, height);
>  	}

This is overall an improvement for userspace that is not picking a size, so=
 in
any case:

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

regards,
Nicolas

--=-fR05QOiHm7Ab/PiRZ46L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCatZllQAKCRDZQZRRKWBy
9PuQAP4u43q21p62RL/xpnhjv3g+Yw7nND0OOmWXaxG8okzuYwD/YLIymZqG+bTn
4x0mw6ZS3kdg5E3571Hr+MlXFSvsLQQ=
=r/WP
-----END PGP SIGNATURE-----

--=-fR05QOiHm7Ab/PiRZ46L--
