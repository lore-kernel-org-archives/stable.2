Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EF2486B88
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826705; cv=none; b=Kp0Sh4sP72F2GI9tNInalg3tnzB+qwsiV9FwnetjAIzuWzVT6TEVXk8xvjXoLlFqT4fkAQTzFgkCrE9E6rW8zDeejyC5pa3FyYOjL6m4w55x2apzKsnpmw2qX5kJeboK1rVgsC6B2iPddL1BJGSN8yWC0Elbk4bg/sF1fpbsiQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826705; c=relaxed/simple;
	bh=+n5na8LDo+sd4EuQWxfmEcNxJa7h+vmDd0fVSmtcHVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ej3XjY6TJDlKkkcjTf+YM2xfQHa5KFcvxrqSep2uTb3rfXf72KE+xiLrOwDm2wacE/nLrHK/ACvNqVt5EXlu3IRddsFVwMR3U5KohJbunkCOM5E6E7M3JykoHWlbFMxlaPFrEsrGgSMnbGOgkGucm4ooCGtaSkI7PTkwiGYntMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=eMqRcX0p; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="eMqRcX0p"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso5223075e9.3
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 10:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1784826695; x=1785431495; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vVCNrNhDnF6NVyRdEJkJESi77InGDYF+aNlCW0LpUZQ=;
        b=eMqRcX0pGbrBEhTJmXe/QZIBeoxrMG8s2TDKziUL6Tc5DcS3EKkxkHcVDjuWwwDzZA
         qTJHcIcy+fCnK2cKX/u3wzP9t3+pn8/CQk0Kgrd/SeKDwSO5gzC3PNcmlfgf/PQZtacv
         BiKNoLExeftB+xoCSa37R5gObReBrTtCSY+DLYEUtKbNu/YzisU0vszYH/Buu827iOxz
         TLWNP9Xva5THjOdXNBJl0ccfA5ktryQOjj1BopEI/dHsYPn+qWyvZFhBizS/mP4ukkaC
         it4NreXjSUfZP1Mpwf7g2zAKSG3yD0MZiHFcb6LHFFxYe/NFaHrPnES4jlCAJardyQLW
         9+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784826695; x=1785431495;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vVCNrNhDnF6NVyRdEJkJESi77InGDYF+aNlCW0LpUZQ=;
        b=IxWAonvS+EnqOKd4ZUGi5K6FAExkWbnRoS4+I+xxFIgUf7fQ0uVYPoex/RmZ2MBSlP
         NR0PTlr54y08wHGecCV6Bh373bijTXdCcbIvjNbQzvErcrR459XKzewSqElrgv4cTw8h
         fdi9E6fp8Z6Z3/FPcfISpELVT5w9jHtNzZ7RkJRXzl0jbD5IqWTptynoL7HhSMWfUbnx
         FTCHaAbYbzleftLPPAPpVSpv8poLqfyFXqV47RCO4+lHDwp7L+xe0tksPdFS+Fd6QHmO
         G6tbbTt1Ad4YEEJDuqBL7NTP+2Mnb9qlp9tnALj/nVlWkGR7CNBx9ps97MLpdFGJKkXP
         eaNQ==
X-Forwarded-Encrypted: i=1; AHgh+RrxI7+cXeRnaoQ5xQEQ5iH5GjzdPXfoh7oxJEm/8c9O4DchEtkvyBJXlvmcOadL7W1IytfCvp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMuVRQ25JJHBpXWobT4jQQlhZQrfZI0rBTc4Z2d3sFjC2Solbe
	yr6AWoyOts7F6hfVt/xNPRdS4Yqzp+0gwlw59Y64A2s5LovTmXji8FwkzQ767ny6CDU=
X-Gm-Gg: AR+sD136z3ZODAy6lBhm7WPQtSwX6PgGyycd4Yr7rIIVr/0g+ONASC6je6Znsqnjiif
	zlStU0VBOuD49SRpis9JIenQP6BW4wySTby7Ne19JGHlxy9xelQ1jLoxuRSLiL/iV6WUPrrgSBO
	NQLQsSpPWedC5zDyV+kTFHixFm8g6vrjX4U0+0ry8ROuhdOS6aWpsLnfwrPDEa6pfoB6kV+r51o
	EyfVsJBsnSfMXT3Yy97MOGQQTl9xHPtez4npf/RE8hdcGIezPaWMJwAudVahSpd5KTkP0sOKV6C
	XUp3z6ez0GSQxlFvn7JdiINOAkznCuHTUrQ9sTJk5W3LiCR6KSmH1qgb34s72db79Zu84EUA2Bn
	iF4dC6YG5yvN9ewNyMQZNsaoTyreHID/jTSN0KVHPfSrqeP9Ts5xShB7e4DjyQFNrS12aGkbfip
	P2fbi4nx2s1sqFqHBmyEe3Iz86Y/IZPeiLmhvY0sCSlECVbmOpo4yJrbp3jQ==
X-Received: by 2002:a05:600c:4652:b0:495:4056:9473 with SMTP id 5b1f17b1804b1-49573d08826mr27213645e9.28.1784826694960;
        Thu, 23 Jul 2026 10:11:34 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:6302:7700:4510:8c44:3b9e:61ae? ([2a02:2f04:6302:7700:4510:8c44:3b9e:61ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a5a2sm18531060f8f.7.2026.07.23.10.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 10:11:34 -0700 (PDT)
Message-ID: <97f207cb-4ae5-4a48-a5da-fb4167f8d0d4@tuxon.dev>
Date: Thu, 23 Jul 2026 20:11:30 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] PCI: rzg3s: Fix IRQ domain initialization error
 handling
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Prabhakar
 <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 stable@vger.kernel.org
References: <20260715223019.3002237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260715223019.3002237-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260715223019.3002237-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Prabhakar,

On 7/16/26 01:30, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> rzg3s_pcie_init_irqdomain() installs chained handlers for the INTx
> parent interrupts before creating the INTx irqdomain and initializing
> MSI support.
> 
> If any subsequent step fails, such as obtaining an INTx IRQ,
> creating the irqdomain, or initializing MSI, the error path returns
> without removing any chained handlers that were already installed.
> This leaves stale handler and data pointers attached to the parent
> interrupts.
> 
> Fix the error path by unwinding the chained handler registration before
> returning. Also clear the chained handlers during
> rzg3s_pcie_teardown_irqdomain() so that teardown fully mirrors the
> initialization sequence.
> 
> Fixes: 7ef502fb35b28 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>   drivers/pci/controller/pcie-rzg3s-host.c | 37 +++++++++++++++++-------
>   1 file changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index f51b5d7c1998..5aeb030d43c8 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1006,22 +1006,30 @@ static const struct irq_domain_ops rzg3s_pcie_intx_domain_ops = {
>   	.xlate = irq_domain_xlate_onetwocell,
>   };
>   
> +static void rzg3s_pcie_clear_intx_handlers(struct rzg3s_pcie_host *host, int count)
> +{
> +	while (--count >= 0)
> +		irq_set_chained_handler_and_data(host->intx_irqs[count], NULL, NULL);
> +}

On PCI subsystem lines are still wrapped at 80 chars length. Could you please 
update it, adding also {} around multi-line blocks as the rest of the code in 
this file is doing, e.g.:

static void rzg3s_pcie_clear_intx_handlers(struct rzg3s_pcie_host *host,
					   int count)
{
	while (--count >= 0) {
		irq_set_chained_handler_and_data(host->intx_irqs[count], NULL,
						 NULL);
	}
}

> +
>   static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
>   {
>   	struct device *dev = host->dev;
>   	struct platform_device *pdev = to_platform_device(dev);
> +	int i, ret;
>   
> -	for (int i = 0; i < PCI_NUM_INTX; i++) {
> +	for (i = 0; i < PCI_NUM_INTX; i++) {
>   		char irq_name[5] = {0};
>   		int irq;
>   
>   		scnprintf(irq_name, ARRAY_SIZE(irq_name), "int%c", 'a' + i);
>   
>   		irq = platform_get_irq_byname(pdev, irq_name);
> -		if (irq < 0)
> -			return dev_err_probe(dev, irq,
> -					     "Failed to parse and map INT%c IRQ\n",
> -					     'A' + i);
> +		if (irq < 0) {
> +			ret = irq;
> +			dev_err_probe(dev, ret, "Failed to parse and map INT%c IRQ\n", 'A' + i);
> +			goto err_cleanup_intx;
> +		}
>   
>   		host->intx_irqs[i] = irq;
>   		irq_set_chained_handler_and_data(irq,
> @@ -1033,21 +1041,28 @@ static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
>   						     PCI_NUM_INTX,
>   						     &rzg3s_pcie_intx_domain_ops,
>   						     host);
> -	if (!host->intx_domain)
> -		return dev_err_probe(dev, -EINVAL,
> -				     "Failed to add irq domain for INTx IRQs\n");
> +	if (!host->intx_domain) {
> +		ret = -EINVAL;
> +		dev_err_probe(dev, ret, "Failed to add irq domain for INTx IRQs\n");
> +		goto err_cleanup_intx;
> +	}
>   	irq_domain_update_bus_token(host->intx_domain, DOMAIN_BUS_WIRED);
>   
>   	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		int ret = rzg3s_pcie_init_msi(host);
> +		ret = rzg3s_pcie_init_msi(host);
>   
>   		if (ret) {
>   			irq_domain_remove(host->intx_domain);

Could you please drop this ^ from here and (see below)...

> -			return ret;
> +			goto err_cleanup_intx;
>   		}
>   	}
>   
>   	return 0;
> +
> +err_cleanup_intx:

Add it here? To have everything grouped together. I am also working on fixing 
the hotplug support and having it like this would be useful. I can do it myself 
in a separate patch, but I think, logically, it belongs to this patch.

Thank you,
Claudiu

> +	rzg3s_pcie_clear_intx_handlers(host, i);
> +
> +	return ret;
>   }
>   
>   static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
> @@ -1055,6 +1070,8 @@ static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
>   	if (IS_ENABLED(CONFIG_PCI_MSI))
>   		rzg3s_pcie_teardown_msi(host);
>   
> +	rzg3s_pcie_clear_intx_handlers(host, PCI_NUM_INTX);
> +
>   	irq_domain_remove(host->intx_domain);
>   }
>   

