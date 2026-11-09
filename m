Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794255150;
	b=qxgP6DsUM64w1jr0vPhyVzNk+rjLqmcNVLjyr2pgFMNWIA0zNvPMQJU/eoK9x3DK7T2m
	 rFJHjtGevbeMKWQIH14ShKZwhfXIuzqQ14CmHAWYPfZzscsgAXKvaIZdW33xs+9b2Oqin
	 jZLBaeCa0theOvbQM2U8xrtiBJGYR1GNqlzwMaFph5YigUHFMzcrMdvs+chAxLocCzXzz
	 tvbDZlFQ2xVgIMp8CW3c0Ka3VAGm4TiUtCmKDmbddOvsv+PmWeH1fsMUhhFTQ+/jb2+XW
	 BctgFgjPGUzKHnRPxxJWTi585ZtJ2MiuQLHVsDDIFxjOFd880q9EZzpHdoPHNmw6C0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255150;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=wlTGvH0QUOsr+i6QSOF/pBnjZSuTmqvqtfQVED5Nrp4=;
	b=EKWxP+Y6ooGQKx5DSB342927J62ayd/sgLoXkND1EinxFVUm9cAAturEkg/Wgp73J00G
	 BbhUO38AoKOWjxJfFtWDIHPOn/ZrB+Nh4qfnGKsrI99E/4ANQw7zLbH5JnphgL3v+FZGd
	 q1msD5yz54Ss0Jk8vTN5QqBSoa5j3+ClJguMdF4r8/pPEasnh7XNzxIIMLRAcH7bN8imj
	 FRG8kWib93HV1wh5f1XucN3fXJTQG+1gCpYcQ4g7k++F6TzHpfyqY3raw0QKXULNPyTs1
	 sIhEdnVhlUPUBEa1xXvDP4Wwovys72cM9qvXasHX9JA3FpPoqy4A/AvcEASy+UjiY9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=AE9EP2U3;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28B606A321;
	Mon,  9 Nov 2026 20:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB28B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=AE9EP2U3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794255147;
	bh=NUdD8rmrEWF0Gtvg3tI1P9FxbEJolb3CZKqT5DxBjJU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AE9EP2U3ZdwEKiCK6ShpVS/2z04RaqxFkbEk4mRkQjQqB8IoFXvNQcvnehXBS+YDi
	 9DxXzBHGM2Gxpxu5tm5uR0VTZeHz15vyqXiYyRr/TWC8sEgDIloTrdCVwRK/W1KNCJ
	 /A+dWhrF9SR6JHOPiAqmwhM/QCyZ2jjJ3cyVsO6jaZS2rgC9YoD8HIEv38XMa0Lr+/
	 e+WHydNGnr96Qr6AwPcGYOsmZbshtBKArLAFY6sgxfaFKVt0ifmzdpmyP9OlmHEocS
	 kSJ3yBlu9bWKCcMonqZqSCgoW04vpX3diPdQthJ8k1lHrDjfwug9wMbUj5xM9vIYRL
	 wZM8ZPGkb9E8A==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DDDDB17E0269;
	Mon, 09 Nov 2026 21:12:25 +0100 (CET)
Message-ID: <a605ddd72e629ac677c7b45d940fa7e7f7412ebd.camel@collabora.com>
Subject: Re: [PATCH 1/3] media: verisilicon: stop the VEPU1 JPEG encoder
 after an unfinished frame
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
Date: Mon, 09 Nov 2026 15:12:23 -0500
In-Reply-To: <20261109-hantro-buflimit-v1-1-f0b86ce61e66@gmail.com>
References: <20261109-hantro-buflimit-v1-0-f0b86ce61e66@gmail.com>
	 <20261109-hantro-buflimit-v1-1-f0b86ce61e66@gmail.com>
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
	protocol="application/pgp-signature"; boundary="=-qVlDHU493oj7uu3cN6Fe"
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

--=-qVlDHU493oj7uu3cN6Fe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 09 novembre 2026 =C3=A0 16:43 +0300, Sergei Khomenkov via B4 Relay=
 a =C3=A9crit=C2=A0:
> From: Sergei Khomenkov <shomenkow@gmail.com>
>=20
> When a JPEG stream does not fit the CAPTURE buffer, the H1 raises an
> interrupt with BUFFER_FULL set and FRAME_RDY clear, and pauses with the
> enable bit of H1_REG_ENC_CTRL still set, waiting for more output space.
> rockchip_vpu1_vepu_irq() returns the buffer with the ERROR flag but
> clears only the interrupt and AXI registers, so the next job is
> programmed into the paused encoder: its ENC_CTRL write aborts the paused
> frame, which raises a reset interrupt while the new job is being set up,
> and that job times out. The watchdog then calls
> rockchip_vpu1_enc_reset(), which sets H1_REG_INTERRUPT_DIS_BIT, and the
> JPEG encoder path never clears that bit again, so every later job times
> out as well. That second problem is not addressed here.
>=20
> Write 0 to the enable register when an interrupt does not report a
> finished frame. The write comes before the interrupt and AXI registers
> are cleared, and before the next job is scheduled. On the RK3026 it
> raises no interrupt of its own: in the test below the encoder raised one
> interrupt per frame and no job timed out.
>=20
> The encoder rarely gets there today, because the stream limit it is
> given is eight times too large; the next patch fixes that, and then
> every frame that does not fit ends this way.
>=20
> rockchip_vpu2_vepu_irq() and stm32mp25_venc_irq() do not stop the
> encoder either. I cannot test the VEPU2 or the STM32MP25, so this patch
> leaves them alone.
>=20
> Found with an LLM coding assistant while porting mainline Linux to a
> Rockchip RK3026 board (VEPU1); the assistant also drafted the code and
> this message. Tested on that board with the stream limit fixed: without
> this change the job after a buffer-full interrupt gets a reset interrupt
> and every later job times out; with it the frame that does not fit comes
> back with the ERROR flag and the following jobs, overflowing or not,
> complete as before (10 alternating jobs, and four overflowing frames
> queued back to back followed by fitting ones). Counted in
> /proc/interrupts over 24 runs of the series (48 frames, 16 of them
> ending in a buffer full), every frame raised exactly one interrupt, so
> the stop write raises none. Only buffer full was exercised, not bus
> errors or the hardware timeout. Not tested on other SoCs.

Please trim this down to what is really needed.

>=20
> Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sergei Khomenkov <shomenkow@gmail.com>
> ---
>  drivers/media/platform/verisilicon/rockchip_vpu_hw.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drive=
rs/media/platform/verisilicon/rockchip_vpu_hw.c
> index 02673be9878e..144d320302a1 100644
> --- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
> +++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
> @@ -376,6 +376,15 @@ static irqreturn_t rockchip_vpu1_vepu_irq(int irq, v=
oid *dev_id)
>  =09state =3D (status & H1_REG_INTERRUPT_FRAME_RDY) ?
>  =09=09VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
> =20
> +=09/*
> +=09 * An interrupt without FRAME_RDY does not end the frame: after a
> +=09 * buffer full the encoder pauses with its enable bit still set,
> +=09 * waiting for more output space. Stop it, so that the next job is
> +=09 * not programmed into a paused encoder.
> +=09 */
> +=09if (!(status & H1_REG_INTERRUPT_FRAME_RDY))
> +=09=09vepu_write(vpu, 0, H1_REG_ENC_CTRL);

Can you follow other similar patches (G2), and add some rate limited debug =
so we
are ware when a fault occured, and what fault it is. Its also best practice=
 to
only reset the bit you care about, Hantro IPs have all sort of side effect =
per
bits.

Nicolas

> +
>  =09vepu_write(vpu, 0, H1_REG_INTERRUPT);
>  =09vepu_write(vpu, 0, H1_REG_AXI_CTRL);
> =20

--=-qVlDHU493oj7uu3cN6Fe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCavIpJwAKCRDZQZRRKWBy
9Hk8AQDqkecJtNqrHJyWzsY47xf1Moj1ivtzo5zq3R0hSA87BwEA+RZEhGQ70w8c
tLls+tZpnQtJ+rZDYw40pV7vcBIn/Qs=
=nT8W
-----END PGP SIGNATURE-----

--=-qVlDHU493oj7uu3cN6Fe--
