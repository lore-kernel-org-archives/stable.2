Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFAD3932E1;
	Thu, 17 Sep 2026 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641548; cv=none; b=H9mE0dWBKCDkkIxGbLDcPZT7U5Yni1Oi2NTmqp5vhuqvt4dwNjg2TriKNX8Xmw8syEOEe4aO8SbhaNlWKacep8Bmro/qXnSOrxyLxMTAQ93rAgoMAmMWx06JYgS8Q5U39MJKR3F3tq1FoxXxEmcPXam8yWGCp16fuNAZdKNC0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641548; c=relaxed/simple;
	bh=nNGBLN9InMInAhMCp13ZLvpkgwwdLaE5j8uM4BpUHHE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kBuU5+RRNPv4tpUTNu+kUfjtbAweSQ6W5cf54cm58PkrCyfJgvh3ZaANK+F+2FcmrqtJFmBaPe/oMKF12zWLf4k96yWmURlfEnCpya0y8m4UcTBAuisYfVn7fUHuzrYLEMal0wheEYw6KtT4DUSaTa2Co59+uydLfNQ+PPnMsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZZOmYDH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZZOmYDH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934A81F000FF;
	Thu, 17 Sep 2026 10:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789641536;
	bh=GgiouULxaavrRvEyeFGZnpHW8o/taKt6WxSeZJbXgG0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WZZOmYDHsEtXapaWj6BjVYo0Egq6UJf0CFI9XwUTH/0eYaTz4mTdcF2MbSXQGd35U
	 os/YSIJxati+HoBjFScUoJWKlIIxg62pWo1ux3sIdGM9TGBeZfAk9XUSop0SjFmMj8
	 HZqMSbAXCdDy5rCvHnJxyFpHEk1xVMKfU55F7chtZ35w0jjJFIYgwEHb/jQ7/EP7n5
	 obNutBYZxKY7GJG11PIC7YaEHuvjjyIflrt8nrHxQ/OQH14964wmRYaCbFgEckUnWl
	 GBzHV6xw+JI5nrWC5vVf1U91z7fqSPN1np3uwU6z5QUXiq6AEUaiVqO9ZBvAgP4JnF
	 MvwXFE+Ha9CFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mtd: rawnand: atmel: Fix HSMC clock leak in legacy
 controller init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>, alexandre.belloni@bootlin.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, vigneshr@ti.com, claudiu.beznea@tuxon.dev, stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com, bbrezillon@kernel.org, miquel.raynal@bootlin.com, richard@nod.at
In-Reply-To: <20260917102804.2146887-1-vulab@iscas.ac.cn>
References: <20260917102804.2146887-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 10:38:55 +0000
Message-Id: <20260917103855.934A81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mtd: backward goto in error handling path violates kernel style
--

commit aad96ec48f9b270598811f4065826c70f378687c
Author: Wentao Liang <vulab@iscas.ac.cn>

mtd: rawnand: atmel: Fix HSMC clock leak in legacy controller init

atmel_hsmc_nand_controller_legacy_init() takes a reference to the
HSMC clock with of_clk_get() and enables it, but the error paths
that follow only release the device node, so both the reference and
the enable are leaked whenever the controller cannot be fully
initialized. Add an err_disable_clk path that disables and releases
the clock before jumping to the existing out path.

> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/n=
and/raw/atmel/nand-controller.c
> index 8a19408abb635..bafc8c995e376 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
[ ... ]
> @@ -2260,6 +2261,12 @@ atmel_hsmc_nand_controller_legacy_init(struct atme=
l_hsmc_nand_controller *nc)
>  	of_node_put(nfc_np);
> =20
>  	return ret;
> +
> +err_disable_clk:
> +	clk_disable_unprepare(nc->clk);
> +	clk_put(nc->clk);
> +
> +	goto out;

[Severity: Low]
Does this backward jump to the out label introduce a regression in standard
kernel conventions for error handling?

While functionally correct, jumping backwards instead of structuring cascad=
ing
error labels so that the success path exits or jumps forward over the error
handling blocks introduces non-standard control flow in this function.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917102804.2146=
887-1-vulab@iscas.ac.cn?part=3D1
