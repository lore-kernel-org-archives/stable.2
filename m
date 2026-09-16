Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE734F7990;
	Wed, 16 Sep 2026 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.86.107.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566319; cv=none; b=PwNkz1Qxo4jXBRrb+XVDqivv/QYoJJR8BQ8jrdjEhUxB95NIuk+AAp52Ju2zPgiNTCT5O/nlG6U0+mFIT9Q7B+2jsOArdWF2OoEDXHVmslS5QAbQeErpT1cc6u0zlTJID9hk+63HQpqPKA9GmLFzFpfaRg1IRZrIag9SX6n0eWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566319; c=relaxed/simple;
	bh=aDL43qhYHXCklvE9pktkxbZ0PKQ6z0erH/TaeHTJJak=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=naURPU/aCHbpB0wJ7hmJxAgQAcsKeT3teiGUUmrI+AYIy6zxG6IaCQ7HIaeshy9JmMZx722uiVZro/Dx4QQiYWz0B4oOBP6YCnvt0PEHqpQQ8CyWP7y7psarJHA2/4q02d1IeORyS+92q7NR7Yxak+R1WNbOPGlBelE7ExTHHcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; spf=pass smtp.mailfrom=rendec.net; dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b=BLQLurJY; arc=none smtp.client-ip=80.86.107.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rendec.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b="BLQLurJY"
Received: from dog.kanata.rendec.net (pool-174-112-193-187.cpe.net.cable.rogers.com [174.112.193.187])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 6B1CCCCDB9;
	Wed, 16 Sep 2026 16:45:03 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 6B1CCCCDB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1789566305;
	bh=Rz4lcGVbF1yUlfwUYSE8Dhf9yMKHKYOJ0oKPXz0YBxA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BLQLurJYU6bQtoY9c8Hxq0VK8XTcKwNPQ9tskS7tPRl1NghzP/keeLoV5Uwyxl858
	 33AJXv/Ocly7tN1PpVOMkRtOrHMCUvjjXo6UvjkHyr1RNo2pQ2b+xiI3fDCgrG8Ohm
	 mcxDrKFuUvrkTKvL3UHaszy2sIdrk7sLHuQJK7k9YsHJ6xJRLq5RDfEaZzixRcfvUa
	 dOk1jL584saJZk+5ajlwQwF2ddCBDIH/qucPWdOjLbqOakqDg9RvFXHyou6bOnLrsi
	 lMOQ3gs/WaQUG7a7zM5nm4LTIDQrehzIdS6eFCqL25kyy7DC7vGeOLknKpPFlugRLh
	 7S+UPUZnrdV6w==
Message-ID: <73bdecf75ba186db00e559f5ff508790ca6e2362.camel@rendec.net>
Subject: Re: [PATCH] irqchip/imx-intmux: fix runtime PM teardown on remove
From: Radu Rendec <radu@rendec.net>
To: Guangshuo Li <lgs201920130244@gmail.com>, Thomas Gleixner
 <tglx@kernel.org>,  Frank Li <Frank.Li@nxp.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team	 <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Joakim Zhang	
 <qiangqing.zhang@nxp.com>, Marc Zyngier <maz@kernel.org>, Zhipeng Wang	
 <zhipeng.wang_1@nxp.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, 	linux-arm-kernel@lists.infradead.org
Date: Wed, 16 Sep 2026 09:45:01 -0400
In-Reply-To: <20260914134211.1734163-1-lgs201920130244@gmail.com>
References: <20260914134211.1734163-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-14 at 21:42 +0800, Guangshuo Li wrote:
> imx_intmux_probe() enables the IPG clock and then drops its runtime PM
> reference with pm_runtime_put(). With CONFIG_PM enabled, the runtime
> suspend callback disables the IPG clock. With CONFIG_PM disabled, the
> clock remains enabled after probe.
>=20
> imx_intmux_remove() accesses the CHANIER registers without first making
> sure that the device is runtime active. The device may therefore be
> runtime suspended with the IPG clock disabled when these registers are
> accessed. In addition, the remove path only calls pm_runtime_disable()
> and does not balance the clock enable when CONFIG_PM is disabled.
>=20
> Resume the device and acquire a runtime PM reference before accessing
> the registers. If resume fails, skip the register accesses but still
> tear down the chained handlers and IRQ domains. Disable runtime PM
> afterwards, drop the acquired reference without triggering another
> runtime suspend, and explicitly disable the IPG clock.
>=20
> This keeps the clock enabled while the hardware registers are accessed
> and balances the clk_prepare_enable() performed during probe for both
> CONFIG_PM configurations.
>=20
> This issue was found by manual code inspection.
>=20
> Fixes: bb403111e017 ("irqchip/imx-intmux: Implement intmux runtime power =
management")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> =C2=A0drivers/irqchip/irq-imx-intmux.c | 15 ++++++++++++---
> =C2=A01 file changed, 12 insertions(+), 3 deletions(-)
>=20

+ Zhipeng

The patch looks good to me but I'm wondering if it's not a better idea
to fix it in a similar manner to the imx-irqsteer driver. Please see
https://lore.kernel.org/all/20260821101039.4037925-7-Zhipeng.wang_1@oss.nxp=
.com/

The two drivers are already similar, so I think it makes sense to keep
them aligned. It would also address some of the issues that sashiko
flagged (probably, I haven't looked very closely).

> diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-i=
ntmux.c
> index 47c2681d138a..de2a8f98f625 100644
> --- a/drivers/irqchip/irq-imx-intmux.c
> +++ b/drivers/irqchip/irq-imx-intmux.c
> @@ -288,12 +288,16 @@ static int imx_intmux_probe(struct platform_device =
*pdev)
> =C2=A0static void imx_intmux_remove(struct platform_device *pdev)
> =C2=A0{
> =C2=A0	struct intmux_data *data =3D platform_get_drvdata(pdev);
> -	int i;
> +	int i, ret;
> +
> +	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret < 0)
> +		dev_warn(&pdev->dev, "failed to resume device: %d\n", ret);
> =C2=A0
> =C2=A0	for (i =3D 0; i < data->channum; i++) {
> =C2=A0		/* disable all interrupt sources of this channel */
> -		writel_relaxed(0, data->regs + CHANIER(i));
> -
> +		if (ret >=3D 0)
> +			writel_relaxed(0, data->regs + CHANIER(i));
> =C2=A0		irq_set_chained_handler_and_data(data->irqchip_data[i].irq,
> =C2=A0						 NULL, NULL);
> =C2=A0
> @@ -301,6 +305,11 @@ static void imx_intmux_remove(struct platform_device=
 *pdev)
> =C2=A0	}
> =C2=A0
> =C2=A0	pm_runtime_disable(&pdev->dev);
> +	if (ret >=3D 0) {
> +		pm_runtime_put_noidle(&pdev->dev);
> +		clk_disable_unprepare(data->ipg_clk);
> +		pm_runtime_set_suspended(&pdev->dev);
> +	}
> =C2=A0}
> =C2=A0
> =C2=A0#ifdef CONFIG_PM

--=20
Regards,
Radu
