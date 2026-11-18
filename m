Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.69.201.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003851;
	b=OOceNSxnuVLsed8TOJhkHGLsJs7OFX47AdOqspyKQ4aNe39MBoFtQut1oSo7O3ywAGMn
	 yB3YhD86B3wSieBdw7mF/DVGcVrJNN1zlN5JraKqRqYYk9IzilersBbtQ6+MyW5VSA5kk
	 nLeMS6gsAGhXgjScaRScBalmm8jZHlSHwIjlZP6nUCtLy62m4QecNOvjb/HRx7ww1+1jg
	 15hx3MfGM5noU7E7lCvv6vyUCydHV57AT/aFcqOklzzZCaLNxa9uhaPwxzcQ7FFNEEPs8
	 s5B+YB127Stq44ULdMjGqYKc0sxucGcp42AUdfSsYI9FTC9sWoMicxFQFk39ZxiGuZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003851;
	h=DMARC-Filter:Received:DKIM-Signature:Mime-Version:Content-Type:Date:
	 Message-Id:Subject:Cc:From:To:X-Mailer:References:In-Reply-To;
	bh=QCr7roC1+1Ps5FfmFeUaWZRyJXGQJS+ufHB6t/Qd++U=;
	b=vKuTga78fk32a+fd0YuOyKdoBjaySEJ4ulg7Y2H4qD2IrvJlFwsYRpYjMl4lxHH8aWrc
	 TUl3Y3UwubwM3c4eK0It3z7drbeXQPeQHn89hUm9dN9y3htRJnXry1yCAe3CrNs/HKbui
	 8gg8nuycjJa6s+K0J7X55BFqvtVl/k/K5xDiGk2c18y8HBIouC+FIr6pN/UfppiaqfJfp
	 NqI3Y9qLyctG8LRDC2xt2n8yGdMKENOR2w7jxg1/PPGazPP7r6lOh0c+AjGK70ozKvoTJ
	 FJsKWH7W/p3/GS1nX2G3iZxrE6sIF9LOX/zCHNG2vVOIj0n2iVXeyEtaFmFpe2K03yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=walle.cc;
	spf=pass smtp.mailfrom=walle.cc;
	dkim=pass header.d=walle.cc header.i=@walle.cc header.a=rsa-sha256 header.s=mail2022082101 header.b=GB3KloGp;
	arc=none smtp.remote-ip=159.69.201.130
Received: from 0001.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A626A606A31C;
	Wed, 18 Nov 2026 12:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A626A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.a=rsa-sha256 header.s=mail2022082101 header.b=GB3KloGp
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 0E1816BD;
	Wed, 18 Nov 2026 13:10:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1795003842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QCr7roC1+1Ps5FfmFeUaWZRyJXGQJS+ufHB6t/Qd++U=;
	b=GB3KloGpCL6gKdNXfaVO5H/7pKTb6SOZqITMvkZhuonLM+5k4kQAHfh5+x5gI2nhmB5pu0
	2SFTkXO65uncnVBEjkAoqU2zZ4W788f0fo4bjLBwBwBQriZ951Twy58+qxc7GAnAfw1OrE
	WSz582V1+fObbZD5SvF4djjElLfQuIQ0c5lDED7QiH+jus7nNYceuWqUhMNz8D7E9iUOMf
	vtaopJHbD6QkhBp5yaYrtWQfv6JJrJmba1NzL+eWzvO5SoB6SOW2LxI8Mn3iS/qIrKb1gs
	PdjbEvzwGEkz4mzsEDqQ3QhbjFPF/wcxVKP4H7t6FiB3Cvqc9AN5YfmgrFVOMA==
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
 boundary=eed9819ffa9d9d482d7f2e70e9c7fdf48b9e50eeb17e32951c98b41d269b;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 18 Nov 2026 13:10:38 +0100
Message-Id: <DMYBR7I0R1PK.25FUNB24SPCFS@walle.cc>
Subject: Re: [PATCH v5] mtd: spi-nor: clear the default read_sr2 opcode for
 Octal DTR flashes
Cc: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <imx@lists.linux.dev>, "Haibo Chen" <haibo.chen@nxp.com>,
 <stable@vger.kernel.org>
From: "Michael Walle" <michael@walle.cc>
To: <haibo.chen@oss.nxp.com>, "Pratyush Yadav" <pratyush@kernel.org>,
 "Michael Walle" <mwalle@kernel.org>, "Takahiro Kuwano"
 <takahiro.kuwano@infineon.com>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>
X-Mailer: aerc 0.20.0
References: <20261023-spi-nor-fix-v5-1-bb6e0ce21169@nxp.com>
In-Reply-To: <20261023-spi-nor-fix-v5-1-bb6e0ce21169@nxp.com>

--eed9819ffa9d9d482d7f2e70e9c7fdf48b9e50eeb17e32951c98b41d269b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Oct 23, 2026 at 9:11 AM CEST, haibo.chen wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>
> The core defaults opcodes.read_sr2 to the legacy RDCR opcode (0x35), and
> spi_nor_cache_sr_lock_bits() reads SR2 during spi_nor_init(), i.e. after
> the flash has been switched to its runtime protocol. On an octal flash
> running in 8D-8D-8D mode the opcode is extended per cmd_ext_type (e.g.
> 0x3535), but RDCR is not a valid register read there: these parts access
> their status/configuration registers through a vendor-specific indirect
> space, if at all. The flash does not answer, the register read times out
> and probe (or resume) fails (on i.MX FlexSPI: -ETIMEDOUT and a controller
> WARN(), seen with a Micron MT35XU01G and a Macronix MX25UW51345G).
>
> Clear read_sr2 on every path that enables 8D-8D-8D, so that
> spi_nor_read_sr1_and_sr2() degrades to an SR1-only read and no
> unsupported command is issued. A manufacturer driver that genuinely
> needs an SR2 read in this mode can still install its own opcode in a
> later fixup.
>
> - spi_nor_parse_profile1(): the common case. The xSPI Profile 1.0 table
>   does not describe any SR2/RDCR read, and it runs before the
>   manufacturer late_init.
> - mt35xu512aba_post_sfdp_fixup(): some mt35xu512aba batches lack the
>   Profile 1.0 table and enable 8D here instead, with the BFPT QER field
>   left at a reserved value so read_sr2 keeps its RDCR default.
> - spi_nor_no_sfdp_init_params(): non-SFDP parts that enable 8D via
>   SPI_NOR_OCTAL_DTR_READ keep the RDCR default too.
>
> CMP (the only user of SR2 beyond quad-enable in the locking code) is
> Winbond-specific and is not placed in SR2 on their 8D-capable parts, so
> no octal flash loses a usable SR2 read because of this change.
>
> Fixes: 63489002d397 ("mtd: spi-nor: Refactor Read Status/Write Status sup=
port")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Miquel, if you want to pick it yourself for fixes, otherwise I can
also push it there.

In any case,

Acked-by: Michael Walle <mwalle@kernel.org>

--eed9819ffa9d9d482d7f2e70e9c7fdf48b9e50eeb17e32951c98b41d269b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCav2VvhEcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+CFJAYDxLl7cPQOrF+auKE+a+zNjZULEGQOubSo+
GmacBs7M11Hw9NG1fXImSX6CntrT/sUBf2mG9P1sp3kZlSnIJ6WhAcGkF/PYoWJf
B8J2UevRceBo1KsBCHjfDS4iMQ7AqQhkig==
=Mg6W
-----END PGP SIGNATURE-----

--eed9819ffa9d9d482d7f2e70e9c7fdf48b9e50eeb17e32951c98b41d269b--
