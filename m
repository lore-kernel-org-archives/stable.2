Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.119.170.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991990;
	b=L0nIgaNW6zYrcVx0awErO9QvGC2gDUujEi3N3Qx8g/qhZHKAOrZ1oIcrkbSMBwG/Z9zX
	 0dtpW32/zVj+QbfVDF8qUlHehtKNsVryEReN7KlzmYj4Hs46neBhEtiYhKvzD5NfHFpZ5
	 iWqvAUXM4CzEFZ078U3dx839o0n8UPgd3hpJPrG6MVX4WGPQJD6iUJttW5uj0781aFFMN
	 I28/QUeKBD6k7XKE5N1120h9TpFdH5RMdLE78JVkCgk6Vvh/lLn1zEdELLXHMP/WP7tFO
	 Y5azjaBsP18+FswRRPMZ0RSvpL6ZMYNzaKMfY8dBciqzLcetzo0Yd/5CnQxhsergFhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991990;
	h=DMARC-Filter:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=DDeh3o5XmR0pUM1ClrHDQ8J3K4y9T9DB7rNBDbxG6dI=;
	b=yBMXxHCdBJ3X+HvIpxaSOQhlTJBi8rZMf2q69HFCyTZD7yTGqu8Dt0aevMHIafTuFlwp
	 Y/wUVXg7ll2hEEYDYB3J6KINy15vVzbnaq/2ZKHhL0SSj+9mBAsrfrH0Z0uCY4OrOY0JU
	 vWI1WY3H0GGEBoJHpoMWS9E+TPnJ4/ScaVe+RwOmvez1Eq9RBD+P7EBvxpNxVn1ksKz5e
	 oLK7K6wZ8k9czPuKgnZCFdDfaQ/7Lj1o0TPFV8fpNZa44mvNj1Xry24OVLHQtAANp2BIg
	 j761sUSdnOXzbCHbiGWjEB38kkrpQNkgLaq9DYHbwksB/Ij0cuTjgsFLi4rWMERg/rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crapouillou.net;
	spf=pass smtp.mailfrom=crapouillou.net;
	arc=none smtp.remote-ip=185.119.170.32
Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DE8606A31C;
	Wed, 18 Nov 2026 08:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32DE8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Message-ID: <b6aaeb0077bb0238c74aed16adfd212fb2fcb0a4.camel@crapouillou.net>
Subject: Re: [PATCH v3 1/2] mtd: rawnand: ingenic: validate BCH error index
 in jz4725b_correct()
From: Paul Cercueil <paul@crapouillou.net>
To: Guanglei Zhu <zhugl3@xiaopeng.com>, harveyhuntnexus@gmail.com, 
	miquel.raynal@bootlin.com
Cc: richard@nod.at, vigneshr@ti.com, linux-mips@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 liuwb@xiaopeng.com, 	stable@vger.kernel.org
Date: Wed, 18 Nov 2026 09:53:03 +0100
In-Reply-To: <20261118020751.1833498-1-zhugl3@xiaopeng.com>
References: <80f1ef9dd605d16df2add0a9dbdcdd5f9f508174.camel@crapouillou.net>
	 <20261118020751.1833498-1-zhugl3@xiaopeng.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Zhu,

Le mercredi 18 novembre 2026 =C3=A0 10:07 +0800, Guanglei Zhu a =C3=A9crit=
=C2=A0:
> From: Weibin Liu <liuwb@xiaopeng.com>
>=20
> The JZ4725B BCH controller reports each corrected bit error as an
> index into the codeword it was asked to decode, in the INDEX0/INDEX1
> fields of the BCH_BHERR registers. These fields are 13 bits wide, but
> nothing in jz4725b_correct() checks the reported index against the
> size of the data buffer being corrected:
>=20
> =C2=A0=C2=A0=C2=A0 buf[(bit >> 3)] ^=3D BIT(bit & 0x7);
>=20
> With data or ECC coming from an untrusted flash, the decoder can
> report an index that points past the end of the data buffer, and the
> above statement then flips a bit outside the buffer.
>=20
> Skip the correction when the reported index does not point into
> the data area.=C2=A0 A bitflip in the parity bytes does not affect the
> data, so rejecting the page for it would fail reads that are
> perfectly correctable, and an index beyond the codeword has no
> buffer to update in the first place.
>=20
> Fixes: 3e6ac2ad90b3 ("mtd: rawnand: ingenic: Add support for the JZ4725B"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> v3: add Cc: stable and my Signed-off-by as the sender, matching
> =C2=A0=C2=A0=C2=A0 the review comments on 2/2.
>=20
> Changes in v2: skip the correction for an index that does not point
> into the data area instead of failing the page with -EBADMSG.=C2=A0 A
> correctable bitflip in the ECC bytes leaves the data valid, and the
> early exit also dropped the error entries that followed it.=C2=A0 This
> matches how jz4740_ecc_correct() treats its indexes.
>=20
> Verified with a userspace replica of the correction loop: with
> params->size =3D 512, an index of 4099 (parity area) followed by a
> data-area index of 100 in the same BHERR register is now corrected
> (v1 returned -EBADMSG and left the data error unfixed), the field
> maximum (0x1fff) produces no write outside the buffer, and in-range
> indexes keep correcting as before.
>=20
> =C2=A0drivers/mtd/nand/raw/ingenic/jz4725b_bch.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/ingenic/jz4725b_bch.c
> b/drivers/mtd/nand/raw/ingenic/jz4725b_bch.c
> index 2d0e0a2192ae..9b1c3d4e5f6a 100644
> --- a/drivers/mtd/nand/raw/ingenic/jz4725b_bch.c
> +++ b/drivers/mtd/nand/raw/ingenic/jz4725b_bch.c
> @@ -259,6 +259,10 @@ static int jz4725b_correct(struct ingenic_ecc *bch,
> =C2=A0			bit =3D (reg & BCH_BHERR_INDEX0_MASK) >>
> BCH_BHERR_INDEX0_SHIFT;
> =C2=A0		}
> =C2=A0
> +		/* Skip indexes outside the data area. */
> +		if (bit >=3D params->size * 8)
> +			continue;
> +
> =C2=A0		buf[(bit >> 3)] ^=3D BIT(bit & 0x7);
> =C2=A0	}
> =C2=A0
