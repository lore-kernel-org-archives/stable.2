Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795467652;
	b=gtgbuwK6G1gH7U0Vcl778TXdHgQxrPjTnYAVFEBkGai3Sjzuu8vy1kemjg4pNLnktqfS
	 zcM9sIF1fwf+EEqoz4SQ4m8UcvtrE4Oku7xsI5X9EtGbStNXR9cfO7CcIyV1RDmKpZm/P
	 IeyR1PeuQkIJti+MSjGlC9BOjwO/vPb/lJKwpsnAerbUVqOe1nD+494tKm8+RbdmRjCtY
	 f4x3IJpfjV9rpVUERUJwyHCYZ6+bzVWQPQXYGli1ITtWAaqgTK6bVBMZFO8lHM3nEJ6SV
	 hZ+0Azf3frZhSlQWQi2134sfTa6lwaEk9HRhf+/fkOYvE/FchKtpmK9daCQmJ4T2yGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467652;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=Mh4ScxtQECCT949jebGxf3rSb7AyqZ70JiHFshhq54c=;
	b=bQnkc5cPNXl/XsMV3EO9M7Y1HZpPVUTD8u6LsgahojYEidvADl+8LNnP0Mog6xQFJOe1
	 MzwCbTC3VzoEOsas9NXcQlMi7ZDufLNOuOJ2nAFaVQfPQOnbtMDFCcQUYcmfNbU2W7OHK
	 aMZkFkqmsHw3m78JxYQxXzbZBCN2O6m3FYwDTPVj1hsDsYmcrBRn6x9sPfmBPq3o0o9er
	 3PMsrcIUHGXzIMZUHf1lteUMS8xoeft5EyXxPug/WJma+naRMQrojCsR9JWDzJMy5d00x
	 KtI8fYe/u/zsj2c+SSZ9YEaB2iVC8K6SqCtOZ5eX50cV09802ql7lR09vapS68eAAWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Z1uGPCbV;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC88606A31E;
	Mon, 23 Nov 2026 21:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAC88606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Z1uGPCbV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795467650;
	bh=rxwZ8xnQVcV8fFd+YcHOcqVoBr8GDgKmqzGHhvx3CZo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Z1uGPCbVLLv8Z1Af1t/4L+/E2FKSLCn3QqtfI/yfMHTyKfGrWfjORetd/7DZ+tLUC
	 3rw1UOxw+ADuA4SUuY3UoNy8ywW/k9iLJ4Ur/qiQK4snRwHRrUm31pfzuHJVsw45qe
	 or9x/bU6nohvkxjKpTLLtjgV6zESC2CPRLSPlu8w7WXMWEnwivM9ldoZvot3nxYoJe
	 SYPNeD+rKjRUFkUcXWVDzzHyBTgOMVywN8X8NkgOvu/Y/FF6vPBRHJlnR1/PX0ZIT/
	 DQ6NgcqzJ93qfWNgGrt84P4QUcauPKIGs0eFcdD1+ycob/2QLI6ES1+UwBUFyVzcWv
	 KBqx2TUEwQvdA==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5F05617E00C4;
	Mon, 23 Nov 2026 22:00:48 +0100 (CET)
Message-ID: <855103db6f4103f30c57af2f8d3fb03818c3d8b3.camel@collabora.com>
Subject: Re: [PATCH v2 1/3] media: verisilicon: stop the VEPU1 JPEG encoder
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
Date: Mon, 23 Nov 2026 16:00:47 -0500
In-Reply-To: <20261110-hantro-buflimit-v2-1-ff7790def9fc@gmail.com>
References: <20261110-hantro-buflimit-v2-0-ff7790def9fc@gmail.com>
	 <20261110-hantro-buflimit-v2-1-ff7790def9fc@gmail.com>
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
	protocol="application/pgp-signature"; boundary="=-vtIt28Q+Zkk3sX+hpprP"
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

--=-vtIt28Q+Zkk3sX+hpprP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 10 novembre 2026 =C3=A0 15:41 +0300, Sergei Khomenkov via B4 Relay=
 a =C3=A9crit=C2=A0:
> From: Sergei Khomenkov <shomenkow@gmail.com>
>=20
> When the JPEG stream reaches the stream buffer limit, the H1 raises a
> buffer-full interrupt and pauses with the enable bit of H1_REG_ENC_CTRL
> still set. rockchip_vpu1_vepu_irq() does not stop it, so the next job is
> programmed into the paused encoder and times out.
>=20
> Clear only the enable bit when an interrupt does not report a finished
> frame, and warn (rate limited) about each fault bit that is set, as
> hantro_g2_irq() does.
>=20
> Found with an LLM coding assistant while porting mainline Linux to a
> Rockchip RK3026 board; the assistant also drafted this change. Tested
> on that board, with the next patch applied: a frame that does not fit
> now ends with the ERROR flag and one interrupt, and the following jobs
> complete. Not tested on other SoCs.
>=20
> Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sergei Khomenkov <shomenkow@gmail.com>
> ---
>  drivers/media/platform/verisilicon/hantro_h1_regs.h  |  4 ++++
>  drivers/media/platform/verisilicon/rockchip_vpu_hw.c | 18 ++++++++++++++=
++++
>  2 files changed, 22 insertions(+)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro_h1_regs.h b/driver=
s/media/platform/verisilicon/hantro_h1_regs.h
> index 8650cc489392..a7f18683dac1 100644
> --- a/drivers/media/platform/verisilicon/hantro_h1_regs.h
> +++ b/drivers/media/platform/verisilicon/hantro_h1_regs.h
> @@ -11,6 +11,10 @@
> =20
>  /* Encoder registers. */
>  #define H1_REG_INTERRUPT=09=09=09=090x004
> +#define     H1_REG_INTERRUPT_TIMEOUT=09=09=09BIT(6)
> +#define     H1_REG_INTERRUPT_BUFFER_FULL=09=09BIT(5)
> +#define     H1_REG_INTERRUPT_RESET=09=09=09BIT(4)
> +#define     H1_REG_INTERRUPT_BUS_ERROR=09=09=09BIT(3)
>  #define     H1_REG_INTERRUPT_FRAME_RDY=09=09=09BIT(2)
>  #define     H1_REG_INTERRUPT_DIS_BIT=09=09=09BIT(1)
>  #define     H1_REG_INTERRUPT_BIT=09=09=09BIT(0)
> diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drive=
rs/media/platform/verisilicon/rockchip_vpu_hw.c
> index 02673be9878e..d201b058e5e8 100644
> --- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
> +++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
> @@ -376,6 +376,24 @@ static irqreturn_t rockchip_vpu1_vepu_irq(int irq, v=
oid *dev_id)
>  =09state =3D (status & H1_REG_INTERRUPT_FRAME_RDY) ?
>  =09=09VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
> =20
> +=09if (status & H1_REG_INTERRUPT_BUFFER_FULL)
> +=09=09dev_warn_ratelimited(vpu->dev, "stream buffer full\n");
> +=09if (status & H1_REG_INTERRUPT_BUS_ERROR)
> +=09=09dev_warn_ratelimited(vpu->dev, "bus error detected\n");
> +=09if (status & H1_REG_INTERRUPT_TIMEOUT)
> +=09=09dev_warn_ratelimited(vpu->dev, "frame encode timed out\n");
> +=09if (status & H1_REG_INTERRUPT_RESET)
> +=09=09dev_warn_ratelimited(vpu->dev, "encoder reset\n");
> +
> +=09/* After a buffer full the encoder pauses, still enabled: stop it. */
> +=09if (!(status & H1_REG_INTERRUPT_FRAME_RDY)) {
> +=09=09u32 ctrl =3D vepu_read(vpu, H1_REG_ENC_CTRL);
> +
> +=09=09if (ctrl & H1_REG_ENC_CTRL_EN_BIT)
> +=09=09=09vepu_write(vpu, ctrl & ~H1_REG_ENC_CTRL_EN_BIT,
> +=09=09=09=09   H1_REG_ENC_CTRL);
> +=09}
> +

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

>  =09vepu_write(vpu, 0, H1_REG_INTERRUPT);
>  =09vepu_write(vpu, 0, H1_REG_AXI_CTRL);
> =20

--=-vtIt28Q+Zkk3sX+hpprP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCawSpfwAKCRDZQZRRKWBy
9A8UAP0UvBlBF4AVvJxBf8F0/qG7WhetKMXmVNr9eOsYgUV6JgEA8Q+Du3Q723Nr
gd9jJjAz9JO7HsTVsj1SE4sAmvIilwA=
=c0o/
-----END PGP SIGNATURE-----

--=-vtIt28Q+Zkk3sX+hpprP--
