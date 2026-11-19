Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102192;
	b=Zoub1HkJPsceiX54tdB4BbBjF3P9HpTmSGqwp9Oe0gCzd/WGIoSUAJXP+8pvElDPyclv
	 9wujl7UHK9KKSG/Br3dP1Tw4x+vC/8YZLvDjIGnv8bwRy10Gl8/Ga1P1Cc5m7bETCzNIA
	 L/x8bPjN/SjBmwNkDqP2GI/DlCMHfL4lW1zGsWcJkGlRo/Znp8yhLioO/0/9cmlqomZQ9
	 eVFCNGpta+FvgwikdEUCJvxDpP82NkCB+Hqz/kNsVTTGBpZzowBQPvQAz9qGgvqUYe94A
	 BxQpqlwrB5BReLF7LVAnSgWg1eI2k0TzBHDJO2vMab6GIsK9xp/34kKOy17Of9nOcPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102192;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=KnbdfePd50cx23JvpChjt9LYDM6NifugSVoKNVLpHBY=;
	b=vAOUMo/uD2tiUbnCDFx9TpjvJVHWV6IOe3YoSuk80E8PPPQCm7RAtgEsfiSs8/bW/Yeu
	 N72ihX2sDiJg4ujrHOu/NV5ua0Uv5IQXqCMHEGblFvAbVr9WkxzGAt8UTx6rDAZudda7f
	 /jWxn7ACNoAoG8Vwps9Xl8EXuOMsUuFcxa0R8VCvqQEHiSsYp0LogYFZmoQXtVYC0y7uq
	 qi5EEmvdwli9AN/zZVEhLHdntHwuoI6aDfN33CL9HqIqRlEGYhW/8bXUuwamSxdH+/Ng8
	 2yoC98oV2Y+av50NVYb//HSjUpLVuDi7Y/gOpYlPstG/stD9c/jQ1pJTFljMO2/PyCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=pTLeWf2C;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5927606A320;
	Thu, 19 Nov 2026 15:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5927606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=pTLeWf2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795102189;
	bh=Y31Aqu/ldrVNOH8NWT+K15XwnhuT0aa2J5qcnZjNsQE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pTLeWf2CvggpnVn6mgPTtu2P5jyV8zAI42CrI5UNI+np2uaeGTE210VX3NcyYAPBf
	 j0cZWJWKPf9ytklQUgkU9dJA+MJryEXSZwOKWfjdGWM/+IlWTHNqic0aYE91nM75LZ
	 6p0LsNcqvQ6qI5PYa37igU29lzp8KNuq2uTAe3aTF3XlLSGQQLnqEONqUAA6Fr3iRz
	 anuFN+n0URkv2ho/ZsdlTqqWc/3nSTe7Kti1RhIlrgsJYgQ7MvIp7AXTtT0wlcNJdK
	 mf8s51IAGpzpFK7SWw3JYfTWd9V2QT6BsdnNJKTKjtfITMbMi1Pat2ChxyQDFZde1f
	 XcJ7GYTz+mRig==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 25DD317E0A27;
	Thu, 19 Nov 2026 16:29:48 +0100 (CET)
Message-ID: <b1aeedac26af03a4b1bd25d5f062f9efb7c04639.camel@collabora.com>
Subject: Re: [PATCH 2/2] media: verisilicon: Reset the VDPU2 decoder after
 an error
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: aiyengar1990@gmail.com, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>,  Philipp Zabel <p.zabel@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner	
 <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>, Boris Brezillon	
 <boris.brezillon@collabora.com>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 19 Nov 2026 10:29:46 -0500
In-Reply-To: <20261119-vdpu2-errreset-v1-2-f8fa403b6a3a@gmail.com>
References: <20261119-vdpu2-errreset-v1-0-f8fa403b6a3a@gmail.com>
	 <20261119-vdpu2-errreset-v1-2-f8fa403b6a3a@gmail.com>
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
	protocol="application/pgp-signature"; boundary="=-VNfhIxJwLPoRKtgwmuvP"
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

--=-VNfhIxJwLPoRKtgwmuvP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 19 novembre 2026 =C3=A0 06:20 +0000, Arun Iyengar via B4 Relay a =
=C3=A9crit=C2=A0:
> From: Arun Iyengar <aiyengar1990@gmail.com>
>=20
> After a stream or bus error the decoder can still access the buffers of
> the failed picture. On RK3588 these accesses hit buffers userspace had
> already freed: IOMMU page faults, an IOMMU that can no longer stall and
> corrupted output for the next job.
>=20
> Soft-reset the decoder on every error interrupt, as the vendor driver
> does, and wait for the reset to complete.

Its not because the vendor use a big hammer that we should use it upstream.=
 We
fixed a lot of these driver bugs by handling specific error correctly. When=
 the
TRM says the IP will self reset, it does, and you should not add extra over=
head
there unless you can prove something is broken.

Please check G2 IRQ handler, its more aligned to were we want to bring all =
the
IRQ handlers in this driver.

Nicolas

>=20
> Fixes: 879dee56a40c ("media: rockchip/vpu: Add MPEG2 decoding support to =
RK3399")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>  .../media/platform/verisilicon/rockchip_vpu_hw.c    | 21 +++++++++++++++=
++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drive=
rs/media/platform/verisilicon/rockchip_vpu_hw.c
> index 4bc1bdb41c70..01cd449f3ab2 100644
> --- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
> +++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
> @@ -7,6 +7,7 @@
>   */
> =20
>  #include <linux/clk.h>
> +#include <linux/iopoll.h>
> =20
>  #include "hantro.h"
>  #include "hantro_jpeg.h"
> @@ -384,6 +385,21 @@ static irqreturn_t rockchip_vpu1_vepu_irq(int irq, v=
oid *dev_id)
>  =09return IRQ_HANDLED;
>  }
> =20
> +/*
> + * After an error the decoder can still have bus accesses of the failed
> + * picture in flight; reset it before its buffers go back to userspace.
> + */
> +static void rockchip_vpu2_dec_soft_reset(struct hantro_dev *vpu)
> +{
> +=09u32 val;
> +
> +=09vdpu_write(vpu, 0, VDPU_REG_EN_FLAGS);
> +=09vdpu_write(vpu, 1, VDPU_REG_SOFT_RESET);
> +=09if (read_poll_timeout_atomic(vdpu_read, val, !val, 0, 5, false, vpu,
> +=09=09=09=09     VDPU_REG_SOFT_RESET))
> +=09=09dev_warn_ratelimited(vpu->dev, "decoder soft reset timed out\n");
> +}
> +
>  static irqreturn_t rockchip_vpu2_vdpu_irq(int irq, void *dev_id)
>  {
>  =09struct hantro_dev *vpu =3D dev_id;
> @@ -396,6 +412,8 @@ static irqreturn_t rockchip_vpu2_vdpu_irq(int irq, vo=
id *dev_id)
> =20
>  =09vdpu_write(vpu, 0, VDPU_REG_INTERRUPT);
>  =09vdpu_write(vpu, 0, VDPU_REG_AXI_CTRL);
> +=09if (state !=3D VB2_BUF_STATE_DONE)
> +=09=09rockchip_vpu2_dec_soft_reset(vpu);
> =20
>  =09hantro_irq_done(vpu, state);
> =20
> @@ -482,8 +500,7 @@ static void rockchip_vpu2_dec_reset(struct hantro_ctx=
 *ctx)
>  =09struct hantro_dev *vpu =3D ctx->dev;
> =20
>  =09vdpu_write(vpu, VDPU_REG_INTERRUPT_DEC_IRQ_DIS, VDPU_REG_INTERRUPT);
> -=09vdpu_write(vpu, 0, VDPU_REG_EN_FLAGS);
> -=09vdpu_write(vpu, 1, VDPU_REG_SOFT_RESET);
> +=09rockchip_vpu2_dec_soft_reset(vpu);
>  }
> =20
>  static void rockchip_vpu2_enc_reset(struct hantro_ctx *ctx)

--=-VNfhIxJwLPoRKtgwmuvP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCav8V6gAKCRDZQZRRKWBy
9E1/AQCQ/OEC7goF6NstMHroyb/dSBFTJpopbeXazJtj+GWl+QD+PV71UkvRHlSI
DHHIB57bxeLUtYz/8hJRQEs2dAGUmAw=
=zEAS
-----END PGP SIGNATURE-----

--=-VNfhIxJwLPoRKtgwmuvP--
