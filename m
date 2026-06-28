Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A882834C141;
	Sun, 28 Jun 2026 04:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619379; cv=none; b=XiyfV9dUANE7jJ3xgsStSI2DqzqZaDhr5zvAA+TKkA7LhJL76MwfBnS07r5NCQayYic4S6Bm2xMLHTxbDFcA+O2MNVvYloBmaqnnm6pvi3XH/QdzcDVcxV6YmD9hBywAWE4hJ1lmRdEwOCosS8fknSBj5/XjxKhwLKXNwOFw98w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619379; c=relaxed/simple;
	bh=W0X4REEsCMOa9N5LgJWHLJjqghfFaeXgh5qVdFJ+Xjs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hgo3f1a70DCdJZs+a1tPQrpME+eJi9NkrWjLwfHRcMZ5lQEZOzjGY2dsfzse8m+d8OpPNE+SJ5JzJp4yOvCUBsDiuIrrUsPJCGLz9GJyZ72fQfBaF4sObNgLipJCmKoC4N1wZsCODtuWxEHDYW+mgTN+VuR24Uk0TQ6qc+BYhxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAD3j8h4nEBq+V6qAw--.55335S10;
	Sun, 28 Jun 2026 12:02:46 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: net: marvell: orion_mdio_probe: fix clock reference
 leak on extra   clock detection
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626151926.51342-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 12:02:36 +0800
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5A62826-E67D-4A29-A0A2-4FAF8D388946@iscas.ac.cn>
References: <20260626151926.51342-1-vulab@iscas.ac.cn>
To: Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAD3j8h4nEBq+V6qAw--.55335S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1ftFyrZF1DWry5uw45KFg_yoW8Zr4Upa
	y8KFyYyrWfAr17G3WxXa10qFyFgw4fta48GryavwsYvwnxAF18Zr1DWry0qrW8JrWkuw47
	tr1UAan7u3Z0vrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBEb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIx
	AIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5zVbUUUUU
	=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMMA2pAioodmQABsv



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 23:19=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> The code calls of_clk_get(pdev->dev.of_node, ARRAY_SIZE(dev->clk)) to
>  detect unsupported extra clocks. If an extra clock exists, the =
function
>  prints a warning but discards the returned clk pointer without =
calling
>  clk_put, leaking a clock reference on every probe.
>=20
> Store the returned clock and call clk_put after the warning to =
properly
>  release the acquired reference.
>=20
> Cc: stable@vger.kernel.org
> Fixes: ea664b1bdc19 ("net: mvmdio: print warning when orion-mdio has =
too many clocks")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/net/ethernet/marvell/mvmdio.c | 17 ++++++++++++-----
> 1 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/mvmdio.c =
b/drivers/net/ethernet/marvell/mvmdio.c
> index 3f4447e68888..4e5b5c5f7301 100644
> --- a/drivers/net/ethernet/marvell/mvmdio.c
> +++ b/drivers/net/ethernet/marvell/mvmdio.c
> @@ -339,11 +339,18 @@ static int orion_mdio_probe(struct =
platform_device *pdev)
> 			clk_prepare_enable(dev->clk[i]);
> 		}
>=20
> -		if (!IS_ERR(of_clk_get(pdev->dev.of_node,
> -				       ARRAY_SIZE(dev->clk))))
> -			dev_warn(&pdev->dev,
> -				 "unsupported number of clocks, limiting =
to the first "
> -				 __stringify(ARRAY_SIZE(dev->clk)) =
"\n");
> +		{
> +			struct clk *extra_clk;
> +
> +			extra_clk =3D of_clk_get(pdev->dev.of_node,
> +					       ARRAY_SIZE(dev->clk));
> +			if (!IS_ERR(extra_clk)) {
> +				dev_warn(&pdev->dev,
> +					 "unsupported number of clocks, =
limiting to the first "
> +					 =
__stringify(ARRAY_SIZE(dev->clk)) "\n");
> +				clk_put(extra_clk);
> +			}
> +		}
>=20
> 		if (type =3D=3D BUS_TYPE_XSMI)
> 			orion_mdio_xsmi_set_mdc_freq(bus);
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang

