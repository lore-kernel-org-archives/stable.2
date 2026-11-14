Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794621893;
	b=WcVqFxVS+NceoFDK4Qdo04e5f9cZuGg17ewmLfdsK4apgMMOFKuYSW9k3GLr50pNvpdw
	 PaQvZfCfl7dsNuplfwv6EDqR3hW8sCq6Cl6lbTkl2gMl61IXtC1ESww84An7XJ6KsiIsK
	 BOvlXCDK30pxdo2VqbB9ZU209n6HmdhQuyjilezR+sTArxfGN/RY8hJSx8EPLMLUEBPM0
	 zj1rPrJf6ARmvIntf2F3uuHbpE5HvmVxpomT7JZhFrp61V89q/GkD5sA+Rk0pY8UTS1RV
	 +7kLRKZUwtXfo9yYDaoslYkqfkuQuLF1DEqWQbELcukaBL/84xIQPWrXAHdH0A2Z/DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794621893;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=c3TMKQvGudvZgsPILw4nmz5grw8WhZuLvbEH6M2mYGQ=;
	b=GulsV7vxXVaq0uWVEGixWyYcQHuSgBXhOIIBLuINJacMhjcYMQJ0jFKP/FFJR74UEpHQ
	 UMH3BAPXOfXbNvRG7zDqdYuhWzOTkdD27LhXbiQaoM0nzDA09kdXKift5Y7i37BYyja3c
	 XxzLgiGy8c/FktCfqIFP2Q9/diKHs6peRrPdgp62RpS91973scKC29UKRStQvYoW0uiQH
	 qC76dKISEcxc/XntPcaOm7mfly7E8TYrrUml2mLtopYAikmfG+awZwDGsPwZdlfxVK5h2
	 HSSqV82YhZHf4NJKCjiYgpi2OvgsA2GKDJ6E2DixBS2hQukZLkMIhfBsXSbwTUGFZXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dunwn7t6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1547B606A331;
	Sat, 14 Nov 2026 02:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dunwn7t6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00941F000C4;
	Sat, 14 Nov 2026 02:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794621892;
	bh=c3TMKQvGudvZgsPILw4nmz5grw8WhZuLvbEH6M2mYGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dunwn7t6OF5BWqY7ESWPFycpyqyP3T4yNXkPQgI5zCq85NoZuGdkl8K+OQLpGxuhj
	 aZfyQ79ujvGmg9XYCmqWqZaQGfYNLFp7ruAlDNqV5Cm84fRiv5Zj5BB6jzXZ7+d0uI
	 E5CFDFO/nY3T2vMUt2LkZzsiR/qMv7L3XrbwhTppxrYcIOsJ51a42VEvNPt6M6b1iS
	 zgHMQ8RmmYwmwXYf8pCs/68KriYAqBdX6VrBWHV53KWxWIBbyrJAKitQ2fHtAXhS2f
	 Tjc5ss42PvCwwAS82P9ZNhUaTuE2XZ3zC6zjf+Z9hQ73oOOWa9PNQIMftV9LkSwYsm
	 prwrUht0iB9gQ==
Date: Sat, 14 Nov 2026 02:04:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: lee@kernel.org, maz@kernel.org, andy@kernel.org,
 dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 mfd@lists.linux.dev, linux-iio@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mfd: mxs-lradc: Pass parent IRQs to child
 drivers
Message-ID: <20261114020447.7a0b71d5@jic23-hlaptop>
In-Reply-To: <20261113013212.470981-2-festevam@gmail.com>
References: <20261113013212.470981-1-festevam@gmail.com>
	<20261113013212.470981-2-festevam@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 22:32:12 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> The MFD driver stores raw DT interrupt indices in IRQ resources but
> registers its child devices without an IRQ domain or IRQ base. The child
> drivers consequently receive the indices as if they were mapped Linux
> IRQ numbers. IRQ index 0 triggers the platform_get_irq_byname() warning:
> 
>   0 is an invalid IRQ number
> 
> The children then try to recover the indices from their resources and
> map them against the parent OF node. Besides duplicating IRQ names in
> the parent and children, this relies on invalid platform IRQ resources
> and fails when IRQ 0 is rejected.
> 
> Resolve the interrupts with platform_get_irq() in the MFD parent and
> store the mapped IRQs in the shared LRADC data. Drop the child IRQ
> resources and duplicated name arrays, and have both child drivers
> request the mapped IRQs directly. Use the MFD memory base support to
> translate a single relative memory resource shared by both cells.
> 
> Tested on an i.MX28 EVK. The mxs-lradc-ts driver probes successfully,
> touch events are reported, and the touch-detect and LRADC channel 7
> interrupt counters increase as expected.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Lee Jones <lee@kernel.org>
> Closes: https://lore.kernel.org/linux-input/CAOMZO5CgTzo6GuXptD4mFTN=UsJJqpkixDW1Q64gqZGrij8+uQ@mail.gmail.com/
> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
For this change
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
With assumption it'll go through mfd.

However, one of those, whilst you are here comments below....

> diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
> index 30a66e268169..d16dfea89207 100644
> --- a/drivers/mfd/mxs-lradc.c
> +++ b/drivers/mfd/mxs-lradc.c

>  static int mxs_lradc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *node = dev->of_node;
> +	const struct mxs_lradc_soc_data *data;
>  	struct mxs_lradc *lradc;
> -	struct mfd_cell *cells = NULL;
>  	struct resource *res;
> +	unsigned int num_cells;
>  	int ret = 0;
>  	u32 ts_wires = 0;
>  
> @@ -137,7 +161,11 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>  	if (!lradc)
>  		return -ENOMEM;
>  
> -	lradc->soc = (kernel_ulong_t)device_get_match_data(&pdev->dev);
> +	data = device_get_match_data(dev);
> +	if (!data)
> +		return -ENODATA;
> +
> +	lradc->soc = data->soc;
>  
>  	lradc->clk = devm_clk_get(&pdev->dev, NULL);

This is what would need changing to fix potential ordering issues with devm / non devm
mixing.

>  	if (IS_ERR(lradc->clk)) {
> @@ -187,38 +215,15 @@ static int mxs_lradc_probe(struct platform_device *pdev)

>  
> -	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
> -				   &cells[TSC_CELL], 1, NULL, 0, NULL);
> +	num_cells = lradc->touchscreen_wire ? ARRAY_SIZE(mxs_lradc_cells) : 1;
> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> +				   mxs_lradc_cells, num_cells, res, 0, NULL);
>  	if (ret) {
> -		dev_err(&pdev->dev,
> -			"Failed to add the touchscreen subdevice\n");
> +		dev_err(dev, "Failed to add subdevices\n");

Not related to what you are changing here, but a devm call with a goto that
follows it is usually an alarm bell...

Can we fix that with a change to devm_clk_get_enabled()?

Jonathan


>  		goto err_clk;
>  	}


