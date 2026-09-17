Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F7C5038F8;
	Thu, 17 Sep 2026 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661420; cv=none; b=K35/HRTSjPZtIvUPfe3tGyXWOKyBTKOdJTdP+iLuY1ot6J3gmx6gjHFixLyaArHkE+fuB3izGN0/VTGXGNSrgfsmdlZwuA1ilUVkUN+sPN0EBzoieq4aYcdAf9SVm1TLSvd3NRdJjN7NNZkPD0/zQHDWeFveSBUcWbfZy5Q2plQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661420; c=relaxed/simple;
	bh=9abpfwFgHed+NOrL+Kh+fnU5217OgeqTfbggvcu/UZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0AOPcImV79XajLRS/OU+TS5ZJJvqOGnFvQjleIJb4MiRaoYqiRZP1jLxiAX8xgnTvuGDgKwZQyyz/4irOF2PDSzQ0f/YNFE4oeWHRnb9G7KMBuAhhlyxkH2/eZIAKIyu9246E+tVPXlDtrv6uAgEaZrHncrtC/fg0wG3IJAI20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T26Iq4Wv; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T26Iq4Wv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0E8F1C5CD7B;
	Thu, 17 Sep 2026 16:11:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 40EF860580;
	Thu, 17 Sep 2026 16:10:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC80311C7B08A;
	Thu, 17 Sep 2026 18:10:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789661414; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=QtQVsORJf5YjdUYVgRbJhrYEv0e/AxW5R9a9UzcxBDM=;
	b=T26Iq4WvCruybNm+wSX/tzwZbma+E3x4Jg56jQ4iraisLYBILjMUtiWjArN9vHkHzo1DIA
	j7j6zFrGJHWyKS42h5T0QcLE9RwJy0jAR8gxDJQzE9HGHTuCAUnUwOJjrzw0+JtTGV5nBm
	9fwbni0C6s8S1GX5cvZvM1czN7+EMxtBjXIgIQhKmlOACkkTINRUwUmps+yYEnuAmuWYXf
	gr+A+6KX95Q7eTAcnfzTOkmrtYAizPiNI/Sfh5fARcptQ6zVwM69vV5765bXi60Du8oUzV
	N3twDeAmWvvDu4aqAW1rlt0iUzRKBK1qvdwt8fQuib4IDUZtLc9PCkAiHAESIQ==
Message-ID: <ff811e9f-4d4b-4b26-a0b5-84cb2eb52618@bootlin.com>
Date: Thu, 17 Sep 2026 18:10:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: request the MDIO reset GPIO only once
To: Linkui Xiao <xiaolinkui@126.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
References: <20260917125457.1353718-1-xiaolinkui@126.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260917125457.1353718-1-xiaolinkui@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello,

> @@ -389,11 +389,21 @@ int stmmac_mdio_reset(struct mii_bus *bus)
>  		struct gpio_desc *reset_gpio;
>  		u32 delays[3] = { 0, 0, 0 };
>  
> -		reset_gpio = devm_gpiod_get_optional(priv->device,
> -						     "snps,reset",
> -						     GPIOD_OUT_LOW);
> -		if (IS_ERR(reset_gpio))
> -			return PTR_ERR(reset_gpio);
> +		/* Request the reset line only once and reuse the descriptor
> +		 * afterwards. A second request of the very same line makes
> +		 * gpiolib fail with -EBUSY, which devm_gpiod_get_optional()
> +		 * passes through because it only filters out -ENOENT. The
> +		 * reset would then abort early and leave the PHY un-reset.
> +		 */
> +		if (!priv->mdio_reset_gpio) {
> +			priv->mdio_reset_gpio =
> +				devm_gpiod_get_optional(priv->device,
> +							"snps,reset",
> +							GPIOD_OUT_LOW);
> +			if (IS_ERR(priv->mdio_reset_gpio))
> +				return PTR_ERR(priv->mdio_reset_gpio);
> +		}
> +		reset_gpio = priv->mdio_reset_gpio;

The problem is real, but this isn't the correct approach to solve that.

Instead of requesting the reset gpio on-the-fly at reset time (good example
of when not to use devm_xxx) , let's request the gpio at probe time.

I suggest you move the devm_gpiod_get_optional() in stmmac_mdio_register(),
which is called at probe time. Here, it makes sense to use devm_xxx.

Thanks :)

Maxime


