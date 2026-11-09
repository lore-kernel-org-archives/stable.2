Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794255223;
	b=aQ1MJcrk9J2dvFuILrlW6/VncsJ+BAfg8ZRFNXoxeQH4F4F64AGOZY12GW9J1Ncx4c3D
	 s8ByWcfqPgcjUbjcM/+qc9Y7P/3dE7lXrzvO8CWGjJTwSaM0aYYlipj/gD1Hi/fSH+GNn
	 4vtmcCaOPlu4rwxwanZ5JWpgB5E+j1AD4fUCQ6dD4ZXtf/e6mIP6E6BuJNXks+6K2hz3v
	 Ogt5jJzrI9U+rejfbzdYQVTGQctToIf0VvHQ9HsWhtdHbRSa8GaNq8welAFbKgSHdv4GU
	 BbexgUMxD+s84oxNdWLUvBdviYf4etZQqEPU5NdGYMIm4ZHRNgQ8LIgaLHaOnKQRFRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255223;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=YSCGEzeWWAPqh/ksAtltPnsmySA1/jcrf4RHYCNZRdg=;
	b=FV1Ppbz8gVw8oVL4P//AFceNWlmlOUZgMxWZscPwSGTM8HCTl57fbcC/4jOL726C7WGI
	 DFEH2llFVCOGMlRUSv4y58nl9fVV5NDRTyBKQh5p6gtEEeDqF4IjefDa9XkKJ4WZe+HzG
	 3yAn0Gxj9VVn0Cc2kV4xx4wy1XfkTpE6tLkdvh7EITDuMgWSvNNkYtSsCfO9kXsAH5otM
	 uXLnqv5Tquj7osub0PNgDk+BHX7ho3tEAkPaZ249hqmhRkWaTC5FgxuxQpu/NPHTcLubb
	 y3X3DbsJfyW9dfSwBIyYl91FH7QGWJKbIwYpWzLSbqKch8Wg6K8f0zNTvH0FM150i+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=fYbpZIgn;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51456606A325;
	Mon,  9 Nov 2026 20:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51456606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=fYbpZIgn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794255221;
	bh=O0vRUmNb98jIjHzllNWMnc9SLyEM2EEnJum+aKO5URQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fYbpZIgn5AbtaF5p0rOtPf2qh+psn0+RGOuZ4DbeFDe5EsyRjTpQ7vj19UuUHRh4t
	 kO/RNsD6cc90lW/1uX4l9KPFul06G0klv1QYFbu3k3ObTLLYy1WphR/0BBmXTmK2uJ
	 kMXIBwm41ibEfZDCvtxuSHfCDUVdpoxanys0h67Jpefoi+84u0moDg66hOvttg1AT+
	 g0MOCbF4LCMz6YSafbQ+Dpvj4Z9MjmSqcG9v/mQXKl4jT6/bleBYkUkzs8anVkU5BL
	 cSDdO7C6AUPH1rPUy5ddiyt16koYvhJKz0eJUgt9mI9W64iUb7oTZ7pZRyu+v5vB3Y
	 umcbzMcx3SdJQ==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9C1D017E0269;
	Mon, 09 Nov 2026 21:13:39 +0100 (CET)
Message-ID: <46826fd8fb3f346de07d63568a789840613d37cf.camel@collabora.com>
Subject: Re: [PATCH 2/3] media: verisilicon: program the H1 JPEG stream
 limit in 64-bit words
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
Date: Mon, 09 Nov 2026 15:13:38 -0500
In-Reply-To: <20261109-hantro-buflimit-v1-2-f0b86ce61e66@gmail.com>
References: <20261109-hantro-buflimit-v1-0-f0b86ce61e66@gmail.com>
	 <20261109-hantro-buflimit-v1-2-f0b86ce61e66@gmail.com>
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
	protocol="application/pgp-signature"; boundary="=-o9hkqN2/RSZzwbWE3DSQ"
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

--=-o9hkqN2/RSZzwbWE3DSQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 09 novembre 2026 =C3=A0 16:43 +0300, Sergei Khomenkov via B4 Relay=
 a =C3=A9crit=C2=A0:
> From: Sergei Khomenkov <shomenkow@gmail.com>
>=20
> The H1 JPEG encoder takes the stream buffer limit in 64-bit words. The
> same register reads back the stream size in bits when the frame is
> done, which hantro_h1_jpeg_enc_done() already divides by 8. The driver
> writes the room left in the CAPTURE plane in bytes, so the hardware may
> write up to eight times the buffer size, and a stream that does not fit
> runs past the end of the plane into whatever memory follows it.
>=20
> Userspace can get there. hantro_try_fmt() keeps any non-zero CAPTURE
> sizeimage, and even the default of header_size + width * height * 2 is
> not a bound: at quality 100 a high-entropy frame takes up to about 2.75
> bytes per pixel. On a 640x480 frame the encoder wrote 230 KB past the
> end of a default-sized buffer, on a 1920x1088 frame 1.6 MB. Without an
> IOMMU in front of the encoder that is memory owned by someone else.
>=20
> Write the limit in 64-bit words, rounded down to whole 64-byte bursts:
> on the RK3026 the encoder writes the stream in 64-byte bursts and
> finishes a burst it has started, so a limit that is not a multiple of 8
> words lets it write up to 56 bytes past it. Rockchip's MPP library
> programs this register the same way for H.264, in 64-bit words rounded
> down to a multiple of 8 (mpp/hal/vpu/h264e/hal_h264e_vepu1_v2.c). The
> stream starts header_size (624) bytes into the plane, so its address
> stays 8-byte aligned. A stream that does not fit now stops at the limit
> with a buffer-full interrupt, and the frame comes back with the ERROR
> flag. A plane with less than one burst after the header is left to the
> next patch.
>=20
> The STM32MP25 VENC uses the same code, so it gets this change too. I
> cannot test it there, and its interrupt handler does not get the stop
> of the previous patch. rockchip_vpu2_jpeg_enc_set_buffers() writes
> VEPU_REG_STR_BUF_LIMIT in bytes the same way, and
> rockchip_vpu2_jpeg_enc_done() divides the read-back by 8 as well; I
> cannot test the VEPU2 either, so this patch leaves it alone.
>=20
> Found with an LLM coding assistant while porting mainline Linux to a
> Rockchip RK3026 board (VEPU1); the assistant also drafted the code and
> this message. Tested on that board, with CAPTURE buffers imported
> through DMABUF from a larger buffer filled with a pattern: without this
> change the encoder wrote the rest of the stream past the end of the
> plane in each of 16 overflowing frames (640x480 to 1920x1088, quality
> 100, 12 of them in default-sized planes). With this and the previous
> patch, 14 overflowing frames (640x480 and 1920x1088, four of them queued
> back to back) stopped exactly at the limit with BUFFER_FULL in the
> status, nothing past the plane changed, and frames that fit are byte for
> byte the same as before. With the limit in words but not rounded down to
> a burst, the encoder wrote up to 56 bytes past it. Not tested on other
> SoCs.

Trim this down, simple patch, simple explanation please.

Nicolas

>=20
> Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sergei Khomenkov <shomenkow@gmail.com>
> ---
>  drivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c b/dr=
ivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c
> index 86cc1a07026f..1e548e91612b 100644
> --- a/drivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c
> +++ b/drivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c
> @@ -55,7 +55,15 @@ static void hantro_h1_jpeg_enc_set_buffers(struct hant=
ro_dev *vpu,
>  =09vepu_write_relaxed(vpu, vb2_dma_contig_plane_dma_addr(dst_buf, 0) +
>  =09=09=09=09ctx->vpu_dst_fmt->header_size,
>  =09=09=09   H1_REG_ADDR_OUTPUT_STREAM);
> -=09vepu_write_relaxed(vpu, size_left, H1_REG_STR_BUF_LIMIT);
> +=09/*
> +=09 * The stream buffer limit is counted in 64-bit words, not in bytes
> +=09 * (the register reads back the stream size in bits once the frame is
> +=09 * done). On the RK3026 the encoder writes the stream in 64-byte
> +=09 * bursts and finishes a burst it has started, so give it whole
> +=09 * bursts only.
> +=09 */
> +=09vepu_write_relaxed(vpu, round_down(size_left, 64) / 8,
> +=09=09=09   H1_REG_STR_BUF_LIMIT);
> =20
>  =09if (pix_fmt->num_planes =3D=3D 1) {
>  =09=09src[0] =3D vb2_dma_contig_plane_dma_addr(src_buf, 0);

--=-o9hkqN2/RSZzwbWE3DSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCavIpcgAKCRDZQZRRKWBy
9JuFAQCBSHD0DnlJcOBDiXGPg/dhjcYXwTNNZWmP3OEtJlmkTgEAyssYRGYjNnfH
wU1G2QrfY/efG4Vnk4Um81kMeQFSkQI=
=DqXL
-----END PGP SIGNATURE-----

--=-o9hkqN2/RSZzwbWE3DSQ--
