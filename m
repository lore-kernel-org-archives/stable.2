Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76E13264C8;
	Sun, 28 Jun 2026 04:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619241; cv=none; b=TrgDLuxJX1pzHrI7+piKrl1Aj9DeFs1PzhDe0H5IbKFxoDtlFmtkSerBnaK7D71fefH2kCjRgP/nirHBQwnf8G/gBNNsqr196QK/58OaTr0k6RwUJwFc5ytgpdfQoB/ubTt/mJLsD9xtYCa1/aKkI8sqmf5r373gAsvkCIhedF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619241; c=relaxed/simple;
	bh=XB5RieHfp3RbGKs43shx49zHI8ThUDFvXuVU8ivWlOk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ozgTQH8fzIkty6zwQBRW/z4QeXKySX6MeStDEhF21GoTR6temTc1OfQPfx2qwdaqPVZknH0IGPaZT/b5+UWHVmlkhVKhAQsZ7VB9efN28agYJ3NDGHm2wXbGWbugQocoPkQ42jdiFMZfKEXAlV2yFfPPMmQbZStLWRStUIeh7cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAB3HNVYnEBqCluqAw--.53240S2;
	Sun, 28 Jun 2026 12:00:25 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: net: mediatek: mtk_star_mdio_init: fix double
 of_node_put after   devm_of_mdiobus_register
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626152009.51599-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 12:00:14 +0800
Cc: "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <533F8AAC-3167-48E0-87B9-4F4F4B38D184@iscas.ac.cn>
References: <20260626152009.51599-1-vulab@iscas.ac.cn>
To: Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAB3HNVYnEBqCluqAw--.53240S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1xKF43Cr1fur1rWrW3KFg_yoW8WrW7pr
	WUGayavrn7Xr4Igw48uF4UuFyYga93KrWrWr1avwsa93Wqy34UJrWjgayYqr1FyrW8C3Za
	qr48A3Zruan8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkCb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU2PEfUU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwEMA2pAixEbZgABsF



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 23:20=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> After devm_of_mdiobus_register succeeds, the mdio_node reference
>  ownership is transferred to the mii_bus device (released via
>  mdiobus_release on device teardown). However, the function
>  unconditionally calls of_node_put(mdio_node) after registration, =
causing
>  a double put.
>=20
> Only call of_node_put when devm_of_mdiobus_register fails (i.e., when
>  ownership was not transferred). On success, the bus driver manages =
the
>  reference lifecycle.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 9ed0a3fac08b ("net: ethernet: mtk-star-emac: use =
devm_of_mdiobus_register()")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/net/ethernet/mediatek/mtk_star_emac.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c =
b/drivers/net/ethernet/mediatek/mtk_star_emac.c
> index b83886a41121..b949dd240e6b 100644
> --- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
> +++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
> @@ -1446,7 +1446,10 @@ static int mtk_star_mdio_init(struct net_device =
*ndev)
> 	priv->mii->priv =3D priv;
>=20
> 	ret =3D devm_of_mdiobus_register(dev, priv->mii, mdio_node);
> +	if (ret)
> +		of_node_put(mdio_node);
>=20
> +	return ret;
> out_put_node:
> 	of_node_put(mdio_node);
> 	return ret;
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

