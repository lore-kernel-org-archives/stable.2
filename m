Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794255302;
	b=GJroU0+0w4uPYyheOBFumhLPUT7ewphX5ZSLopLFAUEWbPCA491pIfLv1rrY49bPswYs
	 UDiMEHJmPxCEw2r3kx3ahLvj5fi4fbSCJu4tMiXn3zFAPLOwutzefxjT/T4M40vX67aqd
	 fU8XhNLEe56ws04ZJkcXrN84g4Srm09cAFMFb69WQBAzRPnHSXbgioL/QElKxHQMAqrIl
	 xNY/3+/t1mmQONiYnoJJIOPPs1kbhg07kg3esEnx3QCWe5lXEUOk9gozw++ZO+q1swlqb
	 Xg9pICZ1VH0cr4i70ElyM1DxTalubOkXVbBnCWf9WsZvYukiMpTUcND+2AkmNSfMO4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255302;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=FoxVs0lzm+EWWwB8m+Smx/prpVCN9fk/Ey2Oni4TNLc=;
	b=2JdtPPaW/Qhhdro1L4mfQt67jjIMMNo2HJeejJg4iMHCkDMoZRQ0larA8ig4BNQ+wW/F
	 gaFt7P/P65Y0tAfXN52v4pgIBZ+RoRg2cc8Ylm1OaXlGGLluJ8xVzPGHK6Oh8VgCSEpaK
	 4H7Ed6zjJHDPLsFEz2BYZjwk+ik7bSOEi/PT7jj5VV0Cb5dpOm3kN6ZloGEIIzRJoTiR3
	 lAXDDQt4s5bwtB19UKnxMt2HUE7GrwE5qmMj1tHHnSk5a34ru7/jIJh4cOXj+WrGO8F9M
	 ZPvzbDgst44cI2QcNQQwJAT0sv+3UFwXX4Q+pKVQTy07YGOIlYJMklfCMR+EMhPUm0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=o3HD5sT1;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39493606A325;
	Mon,  9 Nov 2026 20:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39493606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=o3HD5sT1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794255300;
	bh=N1uMDEJ15LlMOkMdvFMaUU6VCm39ARI9V8pnLrmhems=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=o3HD5sT1HbBcSDCC7dDr/wyQeOlGdIsY9qO7fZBschoxDabUzbDyIE/Mz2aW8Ty/l
	 B8UlO1MHkhY2gZuyzL4q0L6nSlGEJwBOeijJEtR4zC2fx2VH8QQdxkG8TquuEXcP07
	 5NIjidMFYeNmA5YLmvrgNZwjL3y8onM6nkHVQctISrNmMEUXcF3HI8l0wxETfb9I2y
	 Mp5dpB8aMmeKiGzf+Ppk58bnqTL2aSYvanOh/mgotbxvyNcAFM7izQUMSVAZYCjlGa
	 FcCmMPQQDtYkOLQoU0A7/xLFq+CO3SvWz+GrkcfpyfjqtBNrKJE63ZN18JhAocYjkf
	 l0BTkFB2p099w==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7B5DE17E0269;
	Mon, 09 Nov 2026 21:14:58 +0100 (CET)
Message-ID: <d8ba9d67a9452bc44be219d5327aa9d7ad83275f.camel@collabora.com>
Subject: Re: [PATCH 3/3] media: verisilicon: leave room for the JPEG header
 and one stream burst
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
Date: Mon, 09 Nov 2026 15:14:57 -0500
In-Reply-To: <20261109-hantro-buflimit-v1-3-f0b86ce61e66@gmail.com>
References: <20261109-hantro-buflimit-v1-0-f0b86ce61e66@gmail.com>
	 <20261109-hantro-buflimit-v1-3-f0b86ce61e66@gmail.com>
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
	protocol="application/pgp-signature"; boundary="=-OjhiqkHAYs9mqbhDUydw"
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

--=-OjhiqkHAYs9mqbhDUydw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 09 novembre 2026 =C3=A0 16:43 +0300, Sergei Khomenkov via B4 Relay=
 a =C3=A9crit=C2=A0:
> From: Sergei Khomenkov <shomenkow@gmail.com>
>=20
> hantro_try_fmt() keeps any non-zero sizeimage on the JPEG encoder's
> CAPTURE queue, however small, and hantro_buf_prepare() then accepts a
> plane of that size. hantro_jpeg_header_assemble() writes the 624-byte
> header into the plane with the CPU before the hardware starts, and a
> plane smaller than the header also makes the WARN_ON() in
> hantro_h1_jpeg_enc_set_buffers() and
> rockchip_vpu2_jpeg_enc_set_buffers() fire on every job, which userspace
> can trigger at will. After the header the encoder writes its stream in
> bursts, one of them even when the stream limit is 0; on the RK3026
> VEPU1 a burst is 64 bytes. A plane smaller than the header plus 64 bytes
> is therefore written past its end.
>=20
> Raise a smaller request to header_size + 64, so that every plane the
> driver accepts holds the header and at least one such burst.
>=20
> Found with an LLM coding assistant while porting mainline Linux to a
> Rockchip RK3026 board (VEPU1); the assistant also drafted the code and
> this message. Tested on that board: a 640x480 CAPTURE format set with
> sizeimage 1, 600, 656 and 689 reads back 688, 688, 688 and 689, a
> 656-byte DMABUF plane is then refused with EINVAL, and frames that do
> not fit a 688-byte plane stop exactly at its end and come back with the
> ERROR flag. A request of 600, now raised to 688, encodes with no
> warning; before this change it was kept, and the encode hit the
> WARN_ON() at hantro_h1_jpeg_enc.c:50 (hantro_h1_jpeg_enc_set_buffers(),
> reported in hantro_h1_jpeg_enc_run()). Also before it, with 32 and 8
> bytes after the header (a stream limit of 0), the encoder wrote one
> burst, 32 and 56 bytes past the plane. The burst size is measured there
> only; not tested on other SoCs.

Trim this.

>=20
> Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sergei Khomenkov <shomenkow@gmail.com>
> ---
>  drivers/media/platform/verisilicon/hantro_v4l2.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/m=
edia/platform/verisilicon/hantro_v4l2.c
> index 83af9fa1ce94..cc35beac8338 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -394,6 +394,16 @@ static int hantro_try_fmt(const struct hantro_ctx *c=
tx,
>  =09=09 */
>  =09=09pix_mp->plane_fmt[0].sizeimage =3D fmt->header_size +
>  =09=09=09pix_mp->width * pix_mp->height * fmt->max_depth;
> +=09} else if (fmt->codec_mode =3D=3D HANTRO_MODE_JPEG_ENC) {
> +=09=09/*
> +=09=09 * The JPEG encoder writes the header with the CPU, then the
> +=09=09 * stream in bursts, one of them even when the stream limit
> +=09=09 * is 0. Leave room for both; a burst is 64 bytes on the
> +=09=09 * RK3026 VEPU1.
> +=09=09 */
> +=09=09pix_mp->plane_fmt[0].sizeimage =3D
> +=09=09=09max_t(u32, pix_mp->plane_fmt[0].sizeimage,
> +=09=09=09      fmt->header_size + 64);

Did you mean to align to 64 instead ?

>  =09}
> =20
>  =09return 0;

--=-OjhiqkHAYs9mqbhDUydw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCavIpwQAKCRDZQZRRKWBy
9JhRAP0Uyg+Q//c+hMJ7bQhqP6NRUPies38ldLRzcUIRtFGSFgEA8yxBDE2ptokv
twYKX3KCvRjzKE802b1cKw7220Hddgg=
=AjfV
-----END PGP SIGNATURE-----

--=-OjhiqkHAYs9mqbhDUydw--
