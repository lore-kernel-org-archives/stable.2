Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=140.211.166.183
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562747;
	b=ZnsP2IkawBkxNFVbnE0Fjvm8Qel/69erkff6fTWlKHVp4K/RueuHgniDyaHU94KYfsew
	 VysyPH2cILPL5VAkz9jA5AadDATU4Y/X7uG4QMTk3FKkkR1qcI7ZddEjf5YxgIbz00kAO
	 GxKtee6DXY+/7ABNoaUgQHAqPT0hOyD3qD+D1umiN+WNH0R5gWePWvS5qlRlJAz+bOjKi
	 QfqvqUjELT6y0BRrHqzf6ApXkd3EOvWhglrhAJecqAeD0x3c8mvoFz4KrrIaeSHGrn9pX
	 s3Br9rKG2VDc8arRs+DtwfORDoz+jPhBwsMWBPD1oq9NaYDcdQXNXbq0W+TaOuh+hZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562747;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:User-Agent:MIME-Version;
	bh=FJ16bXZFcdXtHsxZY9v7xo6tcK8QhcjGNUaSnANHJx0=;
	b=Mv2UEkHsudSsrUsccqh/I1GXxtqs64znEZuIsc3M9r1zTBv6/BwTqVO64DQREDcYhKAl
	 vw4Mi40IcKP9a7uraUcvnaez55lcRf+rJLBK7C8L1xPp8FZCjQPHGaYGtzELHsYYimhx/
	 k/izlwNAEseuCpNCDv6gCCW1Wr+cHm21zWD8nMTBGePKajUNGPXORuvKtfUmR2oP7sJ+I
	 eYnxdPgreRvH4nd6f9V2iqZPQQtNbB9RNmYYJ0cENY4K2iK3RWClsacM7kJ3g6Zuuj/J3
	 XcNJijaIt+ttDWflpF1LbvenomC+83BzR5EEQOwPT19lPYvP6xjgdgN3/Sd+sRlgxgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentoo.org;
	spf=pass smtp.mailfrom=gentoo.org;
	arc=none smtp.remote-ip=140.211.166.183
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF56D606A690;
	Tue, 24 Nov 2026 23:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF56D606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from 8.2.7.0.b.1.5.7.a.9.4.1.f.a.c.8.c.6.e.0.c.6.2.0.0.b.8.0.1.0.0.2.ip6.arpa (unknown [IPv6:2001:8b0:26c:e6c:8caf:149a:751b:728])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: chewi)
	by smtp.gentoo.org (Postfix) with ESMTPSA id CA44E34245A;
	Tue, 24 Nov 2026 23:25:43 +0000 (UTC)
Message-ID: <3d7bac3c74eec1015e17954e461fc5c4c41e6a72.camel@gentoo.org>
Subject: Re: [PATCH] PCI: dw-rockchip: Clear stale link down interrupt
 before unmasking it
From: James Le Cuirot <chewi@gentoo.org>
To: Niklas Cassel <cassel@kernel.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>,  Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	
 <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob
 Herring	 <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko
 Stuebner	 <heiko@sntech.de>, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, Shawn Lin
	 <shawn.lin@rock-chips.com>, stable@vger.kernel.org, Manivannan Sadhasivam
	 <manivannan.sadhasivam@oss.qualcomm.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Date: Tue, 24 Nov 2026 23:25:38 +0000
In-Reply-To: <20261123121217.1107902-2-cassel@kernel.org>
References: <20261123121217.1107902-2-cassel@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-qi+2NtxgvrcQ9iOuxkU9"
User-Agent: Evolution 3.60.2 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


--=-qi+2NtxgvrcQ9iOuxkU9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-11-23 at 13:12 +0100, Niklas Cassel wrote:
> PCIE_LINK_REQ_RST_NOT_INT is set by smlh_req_rst_not, which according to
> the RK3568 TRM "is asserted after power-on reset until first link up".
> The bit is thus already pending when the driver unmasks the interrupt
> after resetting the controller, both in probe and in .reset_root_port(),
> so the interrupt fires as soon as it is unmasked, even though the link
> is up. Since each recovery resets the controller again, this results in
> an endless loop, as seen on a Quartz64 Model B (RK3566):
>=20
> =C2=A0 pcieport 0000:00:00.0: Recovering Root Port due to Link Down
> =C2=A0 pcieport 0000:00:00.0: Root Port has been reset
> =C2=A0 pcieport 0000:00:00.0: AER: device recovery successful
> =C2=A0 pcieport 0000:00:00.0: Recovering Root Port due to Link Down
>=20
> Clear the bit before unmasking the interrupt, and in .reset_root_port()
> only unmask it once the link is back up, like in probe. Also keep the
> interrupt masked while .reset_root_port() resets the controller, so the
> link down caused by the reset itself is not reported.
>=20
> Fixes: b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port() and =
use for link down")
> Reported-by: James Le Cuirot <chewi@gentoo.org>
> Closes: https://lore.kernel.org/linux-pci/08cc96c5171fc969b074371692e6d95=
d46eba60b.camel@gentoo.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

I can confirm that this fixes the issue I reported. Thank you. :)

Tested-by: James Le Cuirot <chewi@gentoo.org>

--=-qi+2NtxgvrcQ9iOuxkU9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEDBAAWCgCrFiEE6qETVs4yu3Lfuc3XsNCJZ6jP87QFAmsGHPIbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRFQUExMTM1NkNFMzJCQjcyREZCOUNE
RDdCMEQwODk2N0E4Q0ZGM0I0ERxjaGV3aUBnZW50b28ub3JnAAoJELDQiWeoz/O0
yP8BAPdopBp92UiyxdZ+jUx1aLnzOP2TATZVOBOtL27OYcZ1AP9p8sIx9Hk+iRsu
qeK2k/0h9IIIwLieulOsh/hlJkdDAw==
=jlB3
-----END PGP SIGNATURE-----

--=-qi+2NtxgvrcQ9iOuxkU9--
