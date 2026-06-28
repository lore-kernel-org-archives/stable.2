Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC0833067F;
	Sun, 28 Jun 2026 04:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619295; cv=none; b=Pr65VMQcFDHk/Or5SzhLTTHR3Ddyt33ey4hikCKguBm+rXKhJV2stu2RDNftILgEfTaHx34+8lto3Q5RCOKhSKo4VeKN46f+JUaL1wpdDFqe2qBvxnurVFX2t/Ji1+Jrmp31WkTsl4iR4deHQ2DbH4rQpa0MOPsdGOnOaaBK3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619295; c=relaxed/simple;
	bh=0hSWwwU7896uCKq42XMvHcBnnldX5Bss2t2pSy2dW0A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NxxsM+GPAzrp/QO8i3OVJm+pApmHiUH7P1XunLURC2WWquOaG0/MSAEpF8HbGowiCh2S6UIzvdRDIgamLSEM4Q77/NjYnwfwNvRhVLPiFK7zQ8m/fsDCN9edpDZIaLux3DDlPUWxKsWkIO0kT4zYfjzepe/BkOqrXYWCeK1RhII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAD3j8h4nEBq+V6qAw--.55335S3;
	Sun, 28 Jun 2026 12:01:22 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: PCI: dra7xx: dra7xx_pcie_probe: fix missing
 device_link_del on phy   error paths
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626154809.53770-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 12:01:12 +0800
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D288966D-480E-40E3-BC87-7DFFE0CAE53F@iscas.ac.cn>
References: <20260626154809.53770-1-vulab@iscas.ac.cn>
To: Kishon Vijay Abraham I <kishon@kernel.org>,
 linux-pci@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAD3j8h4nEBq+V6qAw--.55335S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1DuFyxuw4ftF4rJw18Zrb_yoW8tFy8pr
	W7tFW0yFyfJF42gay3u3Wru3WYvrs0k34UKws7Cw1fur9rZrWUArWrWryIqa1ftFZ8uF13
	tan8tFn7Ga90v3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280
	aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
	CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4U
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07b5iihUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMMA2pAioodHwAAso



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 23:48=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> In dra7xx_pcie_probe(), when devm_phy_get() fails for a later phy =
device
>  (i > 0), the function directly returns PTR_ERR(phy[i]) without =
calling
>  device_link_del() on previously added device links. Similarly, when
>  dra7xx_pcie_enable_phy() fails, all phy_count device links are leaked =
as
>  the function returns directly without cleanup.
>=20
> Change the error paths to jump to the existing err_link label which
>  properly iterates through link[0..i) and calls device_link_del() for
>  each.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/pci/controller/dwc/pci-dra7xx.c | 12 ++++++++----
> 1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c =
b/drivers/pci/controller/dwc/pci-dra7xx.c
> index cd904659c321..153ee6f7dbfc 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -743,8 +743,10 @@ static int dra7xx_pcie_probe(struct =
platform_device *pdev)
> 	for (i =3D 0; i < phy_count; i++) {
> 		snprintf(name, sizeof(name), "pcie-phy%d", i);
> 		phy[i] =3D devm_phy_get(dev, name);
> -		if (IS_ERR(phy[i]))
> -			return PTR_ERR(phy[i]);
> +		if (IS_ERR(phy[i])) {
> +			ret =3D PTR_ERR(phy[i]);
> +			goto err_link;
> +		}
>=20
> 		link[i] =3D device_link_add(dev, &phy[i]->dev, =
DL_FLAG_STATELESS);
> 		if (!link[i]) {
> @@ -767,7 +769,8 @@ static int dra7xx_pcie_probe(struct =
platform_device *pdev)
> 	ret =3D dra7xx_pcie_enable_phy(dra7xx);
> 	if (ret) {
> 		dev_err(dev, "failed to enable phy\n");
> -		return ret;
> +		dra7xx_pcie_disable_phy(dra7xx);
> +		goto err_link;
> 	}
>=20
> 	platform_set_drvdata(pdev, dra7xx);
> @@ -910,7 +913,8 @@ static int dra7xx_pcie_resume_noirq(struct device =
*dev)
> 	ret =3D dra7xx_pcie_enable_phy(dra7xx);
> 	if (ret) {
> 		dev_err(dev, "failed to enable phy\n");
> -		return ret;
> +		dra7xx_pcie_disable_phy(dra7xx);
> +		goto err_link;
> 	}
>=20
> 	return 0;
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang

