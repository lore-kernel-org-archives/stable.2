Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A87E387378
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 04:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787891143; cv=none; b=aQC9bdo8wUTmraT9Tm206aZgGiz3zsreU40UbEV2Hepvkj1fevRFvSSeGXYHknsOmE8oJaROVSu2tcAZFjuWh7FYKX2+U8az31esLc41tUqS0P4R/3DEK9DfvPqzsCILN3WwOVFhII2qXxEqKGn0QVKRVhhiXnOf0exCY1AFTS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787891143; c=relaxed/simple;
	bh=cRpGeWrUAthIO+j+Pbfd+uhCuhiMAW/Ve2veefEkteI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVI7Vc4nmc2Q5vIPTYb6vno27NVIY4wUL3tL5DcAGxfhLkhgDsApWb2asl5gEmdlS4/lH2Lmh3W8T+IaaKsprb1X9ZXfbW0L5x/fic0UrvQJDeD8Dg/ajf1O3eA64F1QHxBBSJFHQz2eYaQGWmTiDz8mBxUgSDfC+Uoexw6HNqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j71GabcP; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j71GabcP"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so742896a91.2
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 21:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787891139; x=1788495939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2iLLyWC6nrOMFW7D3x/zOmB5QAqAJCqqQG7pB75N2Jc=;
        b=j71GabcPJ7dQiThPs+ZizLB4eKtJzLcZYw6jVYBYYMNyo3s6sgpKaf5kKOrKgZ6t1W
         +h4kfjpB7vipq/u50FUNbNsD4E61xgLTkMZOWIv1ZBB2CQaVbGWRlxNTcbTlBI090jwo
         CsEXf4ktqo3NJ8V+EPWI1wEM6F7V31E2Bk8hPCqZwlBI0FGXkZCTmGqvppGxLShTRXQ1
         ey/1jeuD2x+fAXd2p1TFpNk0JdnNbgceEsh6XOETP6av30JH77CD7XTuq/eMB7BDqkXX
         UzaHHxXH/7mA9G7gNlHdYMP+ykK8+ENsZ2s7EDI6/hWgFWsbXdkSXj0310hcRk/qJEBk
         9pDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787891139; x=1788495939;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2iLLyWC6nrOMFW7D3x/zOmB5QAqAJCqqQG7pB75N2Jc=;
        b=E9vDOwL2Q1/dFPQMzyPbL8ZNO3oR0D7VwG9n7SDJsSs60C80Pd9Pvdk4UbQy5ZxSki
         nzqA1qOAm2ULWZb3p5l6J1DxN480OHcWuJ1ZE8UipqV32hnNODHwE9VQaLM+nd4TKp2E
         w2lJDcPacQZfcD2l9WVgaFz7tJwvzNxVa4bUkfD0n/qkpX366Jmt9fbQV2UnUv2pXysV
         Be1sRAOWq7p5PUm81hEwAhN2H1Xc3drIONhtekdPuYmbjrZ5P262CdtGbJGdS2rGtud1
         bbHMNgSPquv7Rru5TuviHeYe14UwbGDRDfYCtESGtYb9vBY+uvLM8wOD+5B1ll3n7ZaJ
         191g==
X-Forwarded-Encrypted: i=1; AHgh+RoP73Y8Vam5k4+JPKZZ2cmRJ2I8jT5D3+gY2/wmBZzh1SBgEuQxE/deJ1Sf3xmEYNZN9liS/OA=@vger.kernel.org
X-Gm-Message-State: AFuF++n2UZ//QYrgIN0EvpbORK6BeH9pfN/YoAzVRnphbO9U/a7pfvib
	sk+eHGqWeVr2nEEKOq8JuzDd9gbe49FbBM7/IM1HFP/clt00v8IJm1nm
X-Gm-Gg: AR+sD13XM4nPZyMacVS9PPtXvkL6e5l+K/cX6zWltNON8W3AlnKxMHLjd0botp7wtlI
	i7mBR9+qQQ/JjUzC5BzfR6fHUNgAYZH8yBcC66f8DDfq7rHVxjfkcz6Bd9yUKxEL6qGyxbfUMOz
	n/0B9qhisQDlIKe831rzFCZ6+VI542SvohYskNU5e8d02vCoz4onmffy1DR0aoGg+NS9LklEUQj
	VWMQjGFfL7VL+cQsJ8ISDKLaITT6hyUAMAZcm8xxjdDEt8DZkBnt4WVXtRRredrxDcSWJiWvAbG
	R2shJyhoIgG7fKnvNKXLWtGDfDZrmPImSNBw+225jT5WVN/giUVXWnzHtdyz01b8BR2/VEbe+Fw
	VuVGSt9ivHLjB67NLKKD4epJ7WvW8St6lk+fDTp72DfTG7+bCWoexe8IxN+G5lbbvqhasIqOBYZ
	vleHM3gzJyFlmQ/i+7ZgalWeHIBENzIkXDLVBa1sV31Wc8we5gRTWy536Nh222K9RhI3GavOeZt
	G4/pGeM33QEUqKSExWMssX6TEz2Cy5qvRYtwQ==
X-Received: by 2002:a17:90a:e7cd:b0:395:f0e8:9e13 with SMTP id 98e67ed59e1d1-396d0e71ad7mr7322515a91.7.1787891139532;
        Thu, 27 Aug 2026 21:25:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7bc825sm1604156eec.9.2026.08.27.21.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 21:25:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1f04a4bc-f43d-4a97-9703-29cd254ff322@roeck-us.net>
Date: Thu, 27 Aug 2026 21:25:37 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: sunxi_wdt: preserve boot-enabled watchdog
To: James Hilliard <james.hilliard1@gmail.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Carlo Caione <carlo.caione@gmail.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260827-submit-sunxi-wdt-boot-enabled-v1-v1-1-d16f934cc809@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260827-submit-sunxi-wdt-boot-enabled-v1-v1-1-d16f934cc809@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/26 16:42, James Hilliard wrote:
> sunxi_wdt_probe() unconditionally stops the watchdog even when firmware
> left it running. This opens an unprotected interval during boot and
> prevents CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED from taking over the active
> watchdog.
> 
> Detect an enabled watchdog and decode its programmed interval. Preserve
> that timeout while setting the Linux reset mode and pinging the watchdog;
> use the configured timeout only when the hardware interval cannot be
> represented. The enable bit remains set throughout. Mark it as
> hardware-running before registration so the watchdog core services it
> until userspace takes control. Keep the existing stop operation when the
> watchdog was disabled.
> 
> Fixes: d00680ed0026 ("watchdog: sunxi: New watchdog driver for Allwinner A10/A13")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   drivers/watchdog/sunxi_wdt.c | 47 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
> index b6c761acc3de..1f3da1d47fa5 100644
> --- a/drivers/watchdog/sunxi_wdt.c
> +++ b/drivers/watchdog/sunxi_wdt.c
> @@ -128,6 +128,38 @@ static int sunxi_wdt_ping(struct watchdog_device *wdt_dev)
>   	return 0;
>   }
>   
> +static bool sunxi_wdt_is_running(struct watchdog_device *wdt_dev)
> +{
> +	struct sunxi_wdt_dev *sunxi_wdt = watchdog_get_drvdata(wdt_dev);
> +	const struct sunxi_wdt_reg *regs = sunxi_wdt->wdt_regs;
> +
> +	return readl(sunxi_wdt->wdt_base + regs->wdt_mode) & WDT_MODE_EN;
> +}
> +
> +static unsigned int sunxi_wdt_get_timeout(struct watchdog_device *wdt_dev)
> +{
> +	struct sunxi_wdt_dev *sunxi_wdt = watchdog_get_drvdata(wdt_dev);
> +	const struct sunxi_wdt_reg *regs = sunxi_wdt->wdt_regs;
> +	unsigned int timeout;
> +	u32 interval;
> +
> +	interval = readl(sunxi_wdt->wdt_base + regs->wdt_mode);
> +	interval >>= regs->wdt_timeout_shift;
> +	interval &= WDT_TIMEOUT_MASK;
> +	/* The 0.5-second interval cannot be represented by wdt_dev->timeout. */
> +	if (!interval)
> +		return 0;
> +

Why 0 and not 1 ? If I understand correctly, this sets the timeout
to  WDT_MAX_TIMEOUT or 16 seconds. It is not immediately obvious why
that would be desirable.

> +	for (timeout = WDT_MIN_TIMEOUT;
> +	     timeout < ARRAY_SIZE(wdt_timeout_map); timeout++) {
> +		if (wdt_timeout_map[timeout] == interval)
> +			return timeout;
> +	}
> +
> +	/* Reserved interval encoding. */
> +	return 0;
> +}
> +
>   static int sunxi_wdt_set_timeout(struct watchdog_device *wdt_dev,
>   		unsigned int timeout)
>   {
> @@ -259,6 +291,7 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct sunxi_wdt_dev *sunxi_wdt;
> +	unsigned int running_timeout;
>   	int err;
>   
>   	sunxi_wdt = devm_kzalloc(dev, sizeof(*sunxi_wdt), GFP_KERNEL);
> @@ -286,7 +319,19 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
>   
>   	watchdog_set_drvdata(&sunxi_wdt->wdt_dev, sunxi_wdt);
>   
> -	sunxi_wdt_stop(&sunxi_wdt->wdt_dev);
> +	if (sunxi_wdt_is_running(&sunxi_wdt->wdt_dev)) {
> +		running_timeout = sunxi_wdt_get_timeout(&sunxi_wdt->wdt_dev);
> +		if (running_timeout)
> +			sunxi_wdt->wdt_dev.timeout = running_timeout;
> +
> +		err = sunxi_wdt_start(&sunxi_wdt->wdt_dev);
> +		if (err)
> +			return err;
> +
> +		set_bit(WDOG_HW_RUNNING, &sunxi_wdt->wdt_dev.status);
> +	} else {
> +		sunxi_wdt_stop(&sunxi_wdt->wdt_dev);

Why is this necessary ? The watchdog is known to be stopped, why
stop it again ?

Thanks,
Guenter

> +	}
>   
>   	watchdog_stop_on_reboot(&sunxi_wdt->wdt_dev);
>   	err = devm_watchdog_register_device(dev, &sunxi_wdt->wdt_dev);
> 
> ---
> base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
> change-id: 20260827-submit-sunxi-wdt-boot-enabled-v1-94cd6be885d2
> 
> Best regards,
> --
> James Hilliard <james.hilliard1@gmail.com>

