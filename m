Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795469010;
	b=Y7wN1AHU4b4G7SiRQ0Dn8FZvkDSK4UBwS/xgKy/Ya+Jg/32tJucmzuBPL0S9SVC8fK9+
	 boxk98NShVvSWSZOUOSAHzOm5Wt2eqztZc8E7ltt31wiQ+eCS1X4bsH+jzTw1Y9oLuWID
	 53N5fQlO6x/G9FirUitDq97HsEqmyhE5ZrTJHoUfoIdP2PGK4bnpUyBD9wZs+cRopd0Qj
	 rULOG21pIv+YbKbwdpeFAqDvsQxBzGFE7fTb2tkzW21n3oA/SqknCQkguO5TWjGZ53n0R
	 eg4+LzJLidF/GUWjcSSpCyDZTnARJHUCnYjHFB+mvUicKRbZu2tyvqWYOdgVTwt1HHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795469010;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=QVIPG461oIfrGlgT39BuSMqYwlesz2HjWtAEDH4eZM8=;
	b=O7e9alBqja+2XaAuFJT7i4T7JQrUOP7686cUx727o7LHeJhsvOWOj4aImXuI6woOP47r
	 mvN6Oq5F82CEjqrUtYpGKAoKSh+xHPbA/mIDEwdTImnLuAFp/3TJ0lirEWyg2OMFlJumT
	 D3ypD5gF4yEVrdM6koAn/3uZS3xTsg7EeTPjRIByk9wcq8gRBdLn5YqizTdup1eeK/f/o
	 D0yAxc5npjKTVmdEzC8tNv4nAxmH14QYK2XOdHrytOGRIYdeuMEdYYmy7ld3VduOOfm7I
	 ceC40li9j9Iu5kPq/pzRtVbe8tivbGA16CspKqVPSoos3/kdTgSoCC9ibet5P3aKcyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=AvzgeGpS;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2157606A31E;
	Mon, 23 Nov 2026 21:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2157606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=AvzgeGpS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795469008;
	bh=qXsWzwhK9zcOB2dUhIS8bc94DISbCNVtGQbuPkQF+Nk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AvzgeGpSfG57TZIkqGQiAm3tNLJj5Mf1vSRfrWQYE6gfwXCEPy8CDEnY2FZceYvtk
	 WNcYewCiwo+MFT422mNBjHwEv4sH1HeCoPruVNbBgLAoAnzNXX/pmzQ8rmFPeY9dkj
	 j/iG5sLeQ3TNYhnZ8Mtvz2FJUIjbPuhQYCsiJLv85bVMBAH4DDt+4pKChtsGdGB30h
	 lYA35h1a+ePcA5l8rpHSB4InCNXK7QyFwPK03oS3aaWm6ofQSdEGtP0bHT8ngIXEon
	 q/+MyFlsoxCAy2wOQiXJKz1On+ggrKJJfj5PCqveTxR8B7ZzwYvA+mbGYtnZixjA6e
	 aSDhhesUr2qUQ==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5E17F17E02F2;
	Mon, 23 Nov 2026 22:23:26 +0100 (CET)
Message-ID: <4fc740ba49bcd5880d13b627fc16a7b8f119e0a0.camel@collabora.com>
Subject: Re: [PATCH v2 3/3] media: verisilicon: leave room for the JPEG
 header and one stream burst
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: shomenkow@gmail.com, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>,  Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
	 <hverkuil@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Ezequiel Garcia
	 <ezequiel@vanguardiasur.com.ar>, Chen-Yu Tsai <wenst@chromium.org>, Hugues
 Fruchet <hugues.fruchet@foss.st.com>, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 23 Nov 2026 16:23:24 -0500
In-Reply-To: <20261110-hantro-buflimit-v2-3-ff7790def9fc@gmail.com>
References: <20261110-hantro-buflimit-v2-0-ff7790def9fc@gmail.com>
	 <20261110-hantro-buflimit-v2-3-ff7790def9fc@gmail.com>
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
	protocol="application/pgp-signature"; boundary="=-GXXpYju9zHAOXYjKgWjd"
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

--=-GXXpYju9zHAOXYjKgWjd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 10 novembre 2026 =C3=A0 15:41 +0300, Sergei Khomenkov via B4 Relay=
 a =C3=A9crit=C2=A0:
> From: Sergei Khomenkov <shomenkow@gmail.com>
>=20
> hantro_try_fmt() keeps any non-zero CAPTURE sizeimage of the JPEG
> encoder, however small. The CPU writes the 624-byte header into the
> plane, and on the RK3026 VEPU1 the encoder then writes at least one
> 64-byte burst even with a stream limit of 0, so a smaller plane is
> written past its end. A plane smaller than the header also makes the
> WARN_ON() in hantro_h1_jpeg_enc_set_buffers() fire on every job.
>=20
> Raise a smaller request to header_size + 64.
>=20
> Found with an LLM coding assistant while porting mainline Linux to a
> Rockchip RK3026 board; the assistant also drafted this change. Tested
> on that board: a sizeimage of 1 or 600 now reads back 688, and frames
> that do not fit a 688-byte plane stop exactly at its end. Not tested on
> other SoCs.

Move after --, and add Assisted-by: tag.

>=20
> Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sergei Khomenkov <shomenkow@gmail.com>
> ---
>  drivers/media/platform/verisilicon/hantro_v4l2.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/m=
edia/platform/verisilicon/hantro_v4l2.c
> index 83af9fa1ce94..6a6d27443a5e 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -394,6 +394,15 @@ static int hantro_try_fmt(const struct hantro_ctx *c=
tx,
>  =09=09 */
>  =09=09pix_mp->plane_fmt[0].sizeimage =3D fmt->header_size +
>  =09=09=09pix_mp->width * pix_mp->height * fmt->max_depth;
> +=09} else if (fmt->codec_mode =3D=3D HANTRO_MODE_JPEG_ENC) {
> +=09=09/*
> +=09=09 * Room for the header and one stream burst (64 bytes on the
> +=09=09 * RK3026 VEPU1), which the encoder writes even with a stream
> +=09=09 * limit of 0.
> +=09=09 */
> +=09=09pix_mp->plane_fmt[0].sizeimage =3D
> +=09=09=09max_t(u32, pix_mp->plane_fmt[0].sizeimage,
> +=09=09=09      fmt->header_size + 64);

hantro_v4l2 is generic, place the magic numbers in the variants.

>  =09}
> =20
>  =09return 0;

--=-GXXpYju9zHAOXYjKgWjd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCawSuzAAKCRDZQZRRKWBy
9DYBAQDCgXE5fTFdXAXHZOSEBSHB/laGe9BGvnk6D9+hz4Bi5AEA8+/dAfYesZCV
A/5MqFlc0hlRBS1kr1RJQjUjauLTjAw=
=IDgL
-----END PGP SIGNATURE-----

--=-GXXpYju9zHAOXYjKgWjd--
