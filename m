Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315115;
	b=gwXTaTq/xqg9uRiTDQJDgnYGwY/MGmXE57X3l6/BxeVKfPJNDZ+N2gy04Krw/T3TwVt1
	 e5W9FFCwX/nxc5zH7RFRqalCWkzJuaaBspf/dT3FuwF3lzNpLijKlxSJQmW4Co04dAvYI
	 cUKfKMnBaKc5ht7Sfx6W0bYiKxnBtqV1HslSNxEHe/EfEyK/ypyOnRRFrjavXa9W+GDy4
	 ZGNcq47aMP0d5NHr9lOI21DFWkpZZGyfj5LNAV4uSESZfmS2iEBhKJO1X76Tn4C0xrty/
	 JXId8238yWMPGpA4o3e2JR2wsgYVsPI12J/7vN1Y32mrBc8fLolESb0++DCSBmU8aQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315115;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=o6ZRq948QsADnFAUQY5GoxSIt3X/NH3XtT3nDaQJYOU=;
	b=D9/ITU8zEEZGbOoEojA78r7y9bRMFcVVxPRyq4Gr2vMw5IHyhV8cA6CMixb2fiy7ATKi
	 HtiAjJ/8PUTW/ExJDEKSpiszREHbSLSQTIXIR0lqr91UqWq5ClMY8NK2c0dWQunuyEa2r
	 wTaAhBejgXmjPPvS2hOd+VRmHKOro9czC0qr3t97mf+LyoCs5ANu68ryzkmGIM7Uow9Xc
	 VgB9cmQ8zTXFnS/7iV66GJLoQfKn+V7Wp99rC7I7ElP7EPWExRvrQ73Hl2k/Jm2jaPGJS
	 j4tEZVQNY8prA6EZCp9/Bd1OKR+bFJeS3m5pR3djilFqSG9D+Y9Ql3+K4pyGgL2pl9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=v+hAuVRO;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B770660A2619;
	Tue, 10 Nov 2026 12:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B770660A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=v+hAuVRO
Received: from ideasonboard.com (unknown [93.65.100.155])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1C7D5C14;
	Tue, 10 Nov 2026 13:49:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794314970;
	bh=tZg6m4kE4VjEb+t/13S1aUCh2EFh1x/sQctG+yZyfRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v+hAuVROC3MtMAaS+SJi2ko2AxdzxXDBQER/0lEIUTU3qBsYzKKsDZBnaDfS3NBVZ
	 LNkoHyk49m27qj+DUCtiRSekFS7Ib7FmriHSxLJKXaSS9uhQqAZmRyGkeagahUxsMN
	 +4jz6j1PtYvdxRvENK+gNldaKBkEgWA+4s1MrLCQ=
Date: Tue, 10 Nov 2026 13:51:49 +0100
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Li Youhong <dayou5941@163.com>, 
	Daniel Scally <dan.scally@ideasonboard.com>, Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	Nayden Kanchev <nayden.kanchev@arm.com>, linux-media@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] media: mali-c55: Keep IRQ requested during suspend
Message-ID: <avMP-y1B9K0cp4M8@zed>
References: <20261027-mali-c55-irq-supend-resume-v2-1-759b3f5b2cfd@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261027-mali-c55-irq-supend-resume-v2-1-759b3f5b2cfd@kernel.org>

Hi Linus

On Tue, Oct 27, 2026 at 03:08:05PM +0100, Linus Walleij wrote:
> The interrupt is currently freed on every runtime suspend and requested
> again on runtime resume. Apart from tying interrupt ownership to the
> power state rather than to the driver lifetime, this leaves remove to
> guess whether an action is installed for the IRQ.
>
> Request the interrupt once during probe and free it during remove.
>
> Disable and synchronize the IRQ before powering the ISP off, and enable
> it only after a successful power-on.
>
> Hold a runtime PM reference during probe until the IRQ is installed,
> and stop runtime PM and drain the IRQ before unregistering the media
> entities during remove.
>
> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> This is essentially my reply with the "proper fix" for:
> https://lore.kernel.org/linux-media/20260903025526.2657105-1-dayou5941@163.com/
>
> Keep the Mali-C55 interrupt requested for the driver's lifetime instead
> of changing interrupt ownership along with the runtime power state.
> Synchronize and disable the IRQ before power-off, and enable it after
> power-on. Hold a PM reference until probe installs the IRQ, and stop
> runtime PM and drain the IRQ before removing the media entities.
>
> Tested on the Renesas RZ/V2H board with the other in-flight patches
> (DTS changes and the TPG enablement) doing full suspend/resume cycles
> with wakeup from RTC and NMI and capturing images before and after
> the test.
>
> This patch was authored with the assistance of an LLM.
> ---
> Changes in v2:
> - Drop the wakeup-source binding patch and all ISP wakeup handling.
> - Drop the patch retaining ISP power for wakeup; keep the IRQ lifetime fix.
> - Link to v1: https://patch.msgid.link/20260929-mali-c55-irq-supend-resume-v1-0-e3af34afff12@kernel.org
> ---
>  .../media/platform/arm/mali-c55/mali-c55-core.c    | 44 ++++++++++++----------
>  1 file changed, 24 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-core.c b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> index f28e9f4354ac..3c2816b6a96b 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> @@ -675,8 +675,7 @@ static int __maybe_unused mali_c55_runtime_suspend(struct device *dev)
>  {
>  	struct mali_c55 *mali_c55 = dev_get_drvdata(dev);
>
> -	if (irq_has_action(mali_c55->irqnum))
> -		free_irq(mali_c55->irqnum, dev);
> +	disable_irq(mali_c55->irqnum);
>  	__mali_c55_power_off(mali_c55);
>
>  	return 0;
> @@ -745,20 +744,9 @@ static int __maybe_unused mali_c55_runtime_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>
> -	/*
> -	 * The driver needs to transfer large amounts of register settings to
> -	 * the ISP each frame, using either a DMA transfer or memcpy. We use a
> -	 * threaded IRQ to avoid disabling interrupts the entire time that's
> -	 * happening.
> -	 */
> -	ret = request_threaded_irq(mali_c55->irqnum, NULL, mali_c55_isr,
> -				   IRQF_ONESHOT, dev_driver_string(dev), dev);
> -	if (ret) {
> -		__mali_c55_power_off(mali_c55);
> -		dev_err(dev, "failed to request irq\n");
> -	}
> +	enable_irq(mali_c55->irqnum);
>
> -	return ret;
> +	return 0;
>  }
>
>  static const struct dev_pm_ops mali_c55_pm_ops = {
> @@ -825,27 +813,42 @@ static int mali_c55_probe(struct platform_device *pdev)
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_get_noresume(dev);

Why is it relevant to hold a PM reference during the installation of
the IRQ handler ?

>  	pm_runtime_enable(&pdev->dev);
>
>  	ret = mali_c55_media_frameworks_init(mali_c55);
>  	if (ret)
>  		goto err_pm_runtime_disable;
>
> -	pm_runtime_idle(&pdev->dev);
> -
>  	mali_c55->irqnum = platform_get_irq(pdev, 0);
>  	if (mali_c55->irqnum < 0) {
>  		ret = mali_c55->irqnum;
>  		goto err_deinit_media_frameworks;
>  	}
>
> +	/*
> +	 * The driver needs to transfer large amounts of register settings to
> +	 * the ISP each frame, using either a DMA transfer or memcpy. We use a
> +	 * threaded IRQ to avoid disabling interrupts the entire time that's
> +	 * happening.

Does this comment still apply in your opinion ? I mean, thread_irq are
pretty regular stuff, do we need to justify its usage ?

> +	 */
> +	ret = request_threaded_irq(mali_c55->irqnum, NULL, mali_c55_isr,
> +				   IRQF_ONESHOT, dev_driver_string(dev), dev);
> +	if (ret) {
> +		dev_err(dev, "failed to request irq\n");
> +		goto err_deinit_media_frameworks;
> +	}
> +
> +	pm_runtime_put_autosuspend(dev);
> +
>  	return 0;
>
>  err_deinit_media_frameworks:
>  	mali_c55_media_frameworks_deinit(mali_c55);
>  err_pm_runtime_disable:
> -	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_set_suspended(&pdev->dev);
>  	kfree(mali_c55->context.registers);
>  err_power_off:
>  	__mali_c55_power_off(mali_c55);
> @@ -859,12 +862,13 @@ static void mali_c55_remove(struct platform_device *pdev)
>  {
>  	struct mali_c55 *mali_c55 = platform_get_drvdata(pdev);
>
> +	pm_runtime_disable(&pdev->dev);

It amazes me how, after so many years, I still can't find a clear, firm
indication of what is the intended call order for pm_runtime_disable()
and the other pm_runtime calls is during a driver's remove.

Media drivers seem to do different things with some disabling pm
before setting the state to suspended, other doing the other way
around.

In the end, I think this doesn't make any difference, but in this
specific occurance:

1) Is this re-ordering required to support the new interrupt handling?
or
2) Is it a change that is worth doing anyway ? (and I should say "should
go in a different patch on its own")

> +	free_irq(mali_c55->irqnum, &pdev->dev);
>  	mali_c55_media_frameworks_deinit(mali_c55);
> -	if (!pm_runtime_suspended(&pdev->dev)) {
> +	if (!pm_runtime_status_suspended(&pdev->dev)) {

I guess this is required because you moved pm_runtime_disable() up

Thanks
  j

>  		__mali_c55_power_off(mali_c55);
>  		pm_runtime_set_suspended(&pdev->dev);
>  	}
> -	pm_runtime_disable(&pdev->dev);
>  	kfree(mali_c55->context.registers);
>  	of_reserved_mem_device_release(&pdev->dev);
>  }
>
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260918-mali-c55-irq-supend-resume-30b507a20011
>
> Best regards,
> --
> Linus Walleij <linusw@kernel.org>
>
