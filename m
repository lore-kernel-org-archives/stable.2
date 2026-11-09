Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214299;
	b=q/XQlMXBUfQ4DdXdj7JwdrS7FcVh3vJrWXVdFLFQ+hbpNcKqgiIL06IWxiCcWkNB7kev
	 XiRrtN2W0EExjYynE7iLHJ7/4EXp34ZiIpK6iwPswIx+PcabPyQaaIoFKN5TV+uDnKqxi
	 Ptl2lEuan6nKxWjxnjg5Kr9V2+Z90d+tNDz99bKk/uwcNcb6f2n9AWx7WowQKFa3tfl76
	 YdmfdsLJ3O0EApof5NAZTphfvKyZx9OSQYk/NyyP3AnIjW9/WstVma5U7ZSDO83J74zTB
	 vQZjYDyLY4u78XSdsaWUqbwsJJ+vI3+CiY2rFNR+92iTLqFj8nGna2lz96yfvCrYrDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214299;
	h=Received:DKIM-Signature:Mime-Version:Content-Type:Date:Message-Id:
	 Subject:Cc:From:To:X-Mailer:References:In-Reply-To;
	bh=9N499Ob7uCXTQeit1tcbXdiS0x8hkEdAz+plrn1iml4=;
	b=o6xYahJjCLs5TCkwK/G9To8QZz38NQcYycU6eljFoTyTvfuSHoHRdEz35k6A2aZYYcmb
	 wKgx7pg2jMHjs7QKCVeb3M0S1grreA3oufZKGHQiAy1AjEyxxGfZrqNjg1EFneQbfoN8V
	 IqPcIkNpc2zwuNYNioaobVuVsU47f/NRKV34m0Tiwpe4NibZwLVGh1r3t4J1s2wTdutFT
	 GFA7NQdtpwxj2qLx17UaVxhAeek3Q5LKvuU2B5iX5SpgYXfJPcF7RCC5l6K2cy0GHeyRa
	 I9+GRAKJovpH5FeB1Y+UyrR8wZZQBf8lIAhTvjJp8lKjkgZB3v6MG2gi917FLnOwrrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O3v3idTh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D8608606A325;
	Mon,  9 Nov 2026 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O3v3idTh
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C845C1F0089F;
	Mon,  9 Nov 2026 08:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794214298;
	bh=9N499Ob7uCXTQeit1tcbXdiS0x8hkEdAz+plrn1iml4=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=O3v3idThEM4V5gHX3fry8tzWZHqk+mjUtvHCqv9QoPe3U7/1BtL/5mbMCmDa2ri5Y
	 lzg9rNfXtlYdh5QF0T5n50CkQ78M0QdRejumr8jZK/46cra00FOPsIo/OdFzOMGMQO
	 MxF+2mgZNDYgLUQ3NeKgZFJ71G/i3Qqr9qgK6AzWReJV75ugbAgUSeoxACaWhu25XR
	 LuDjUKdLBGs93HfkNWJ+OGCTo1/NaatjxsrpxfHl7rlu4InRKei34gFU54YzUI9xmH
	 t/QMUVuJxhwE3xFwmg2qmjuQsch9+QGSSv1RUvPBKrOZc/cISRtk8wjSvD02Hva12H
	 ScvnRz6sarI/Q==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=2959569091a881720d3f0e7e7081a33726b4f4f00782f60b01c059725bad;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 09 Nov 2026 09:51:34 +0100
Message-Id: <DMQJVVTSK5MO.2VQC80RTHL9LN@kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: gigadevice: Add support for GigaDevice
 GD25B512
Cc: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Adam Calabrigo" <adamc@arista.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Matthew Parker" <mparker@arista.com>, <pratyush@kernel.org>,
 <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
X-Mailer: aerc 0.20.0
References: <20261108022011.898185-1-mparker@arista.com>
In-Reply-To: <20261108022011.898185-1-mparker@arista.com>

--2959569091a881720d3f0e7e7081a33726b4f4f00782f60b01c059725bad
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Matthew,

On Sun Nov 8, 2026 at 3:20 AM CET, Matthew Parker wrote:
> Add support for the GigaDevice GD25B512 512Mbit (64 MiB) SPI NOR flash.
>
> The chip exposes valid JESD216B SFDP tables including 4-byte address
> instruction tables, from which geometry and opcodes are discovered.
> Stateless 4-byte opcodes and status register locking are enabled. Read,
> write, and erase functionality across the full memory array have been
> tested on hardware.
>
> Cc: stable@vger.kernel.org # v6.1+
> Co-developed-by: Adam Calabrigo <adamc@arista.com>

Co-developed-by for just adding an id?

Please note that we have some requirements for new flashes, see [1].
Same for the your other patch.

-michael

[1] https://docs.kernel.org/driver-api/mtd/spi-nor.html

> Signed-off-by: Adam Calabrigo <adamc@arista.com>
> Signed-off-by: Matthew Parker <mparker@arista.com>
> ---
>  drivers/mtd/spi-nor/gigadevice.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigad=
evice.c
> index 6a2e6ebda148..de96cefde516 100644
> --- a/drivers/mtd/spi-nor/gigadevice.c
> +++ b/drivers/mtd/spi-nor/gigadevice.c
> @@ -64,6 +64,10 @@ static const struct flash_info gigadevice_nor_parts[] =
=3D {
>  		.id =3D SNOR_ID(0xc8, 0x40, 0x19),
>  		.name =3D "gd25q256",
>  		.flags =3D SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6,
> +	}, {
> +		.id =3D SNOR_ID(0xc8, 0x47, 0x1a),
> +		.flags =3D SPI_NOR_HAS_LOCK,
> +		.fixup_flags =3D SPI_NOR_4B_OPCODES,
>  	}, {
>  		.id =3D SNOR_ID(0xc8, 0x60, 0x16),
>  		.name =3D "gd25lq32",


--2959569091a881720d3f0e7e7081a33726b4f4f00782f60b01c059725bad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCavGJlhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/iKtwF/XafQtXrjmkWVp7htuglmkvXC5qEsgkhq
+aM4igg92sBank0syXm1X1BDBT1ZKGb2AX9DEZp5Vh0mDuxMgyOXr6DsTvfM79Dr
F1FXIheSWeOe0eF8EmH4AP7TEJI787tHRpo=
=ZdXO
-----END PGP SIGNATURE-----

--2959569091a881720d3f0e7e7081a33726b4f4f00782f60b01c059725bad--
