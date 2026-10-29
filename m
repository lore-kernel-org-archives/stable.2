Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793307738;
	b=TXg2XFt8jfi34OmmDs7Dn8yVUNtA86xIuIbhqT2qqNfu1EP2DkS89OpnfIAtOUZm/mMB
	 eau7KCh/hkIw9ZswgoluRoxl7Mcu3JmgL9HJnbaWMggvkTv+b3Kc3D7DftJtcxBVaRPS3
	 EfBuWOXxOC0KjcKRX52ZeLyDhGj/ZFTfUkCKSoav59OZAIT2KpT3lCgdrsVFFoPzQxytF
	 VMO87Fzfe4qVXpwPUtkI+K9/xkl54/015szeBDPE56ZFmgiJ1tLSMvWOBOKJgoTKBd818
	 oQNt+xvGWfHqbc6rWTouSOzfRNU17SVEoxEn+LmVxwfbMmJ/59ucwIBgj30P2ZTtGAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307738;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=VQcEJLQXJIuyQP3EY6HM4/0GGnBX9p5roig7lUfJ3jk=;
	b=Gxj8tKL9yk0gFQ4yUrV4hKQVgYQ1gE+W75Ybnqlz5vWNk1y1C5+NvHYqxccYTgAQWBuc
	 DlANHzHIFSN2XTEBUjbISctWk4HILbWkc1SR1pCpBa+KCyhoLkfG0lxRa4wN+Z66fJgC4
	 W41XuSzxLQ4OMZVAw/z8ZYcfkwYSUPuioFKk3HYAGQ3ESgl8IWJKUiE5DGj+1hWbVQcPz
	 P/lZ6NSYIPlza7/Cq/OVO72rkeM3AFo0MwwRdekVYdL3kYIa7v12bEj16gAE30WATplq0
	 9W4suZQoFO7fjzCuUN4F04VHqkc74mBgLaIKN+R5o5lOvi16ozlclPCEgQxucloQydQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=mrKWSUnf;
	arc=none smtp.remote-ip=35.89.44.33
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F0606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A60F0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=mrKWSUnf
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id MMFDxzeuWaC0UMXGLx4wQE; Thu, 29 Oct 2026 21:02:17 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id MXGKx0ZA2bxHHMXGKxVLfB; Thu, 29 Oct 2026 21:02:16 +0000
X-Authority-Analysis: v=2.4 cv=QK5oRhLL c=1 sm=1 tr=0 ts=6ae3b458
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=_jlGtV7tAAAA:8 a=pGLkceISAAAA:8 a=13cl543gbcbPMrBg_SMA:9 a=QEXdDO2ut3YA:10
 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=VQcEJLQXJIuyQP3EY6HM4/0GGnBX9p5roig7lUfJ3jk=; b=mrKWSUnf9UfZ
	x3SYt1ns2FqVkOyRnHHOb966nCmeYI0l4pH9Xpy03bVknw+PQSjw4modrufXUaIXhe1MkmReB8Cj7
	j0rpqSXrfrH4wV5p99fBdWKvh63EPDz1fX4Stl2Kp27zUB9HQMJurXIvBZFg8pjXBrJd9ghdqoFsN
	m7DQSHl98TU5QYqEy0Uc6usnHMuaG/Q7nnWq5+F7wrnyzweV35wYmglgWIRwaYcy6yAb7C4wiZOD9
	NU2K2DXhgW0nz+JH5OjJ44qYrAHd+XgymBdXIXb7PaptrvBd+Yo4y3myBxW7ozvTUUa9UIWl/Lcov
	bU9dZWk2iisBFAeHSY46Pw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:53448)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xMXGJ-000000004Rf-40B3;
	Fri, 30 Oct 2026 02:32:16 +0530
Message-ID: <5a38e9d0-e50e-437c-a480-77429c59be70@roeck-us.net>
Date: Thu, 29 Oct 2026 14:02:14 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: sa1100: defer GPIO chip registration to
 postcore_initcall
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261029-sa1100-swnode-fix-v1-1-112f4d83d191@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20261029-sa1100-swnode-fix-v1-1-112f4d83d191@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xMXGJ-000000004Rf-40B3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:53448
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 1
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDRz1R2j2QfLZES0TsS0/t16RkmYXpoLRj6jIJq85I+7gPztp4TNJmtuCpsjnJIBVVwDE5W+0GnabXuI1UseT9Iw1z0G8eRWTqFY44OmgxUrUQ4w1DHt
 9sHPWJBK/RYT3Pne3WcjhOHkeTO6Z1VpyjXum76dWKRK2R2ujvJgpLwhboEX1vA2e5uKJ7uXG/mSQlKMUCycwD/6ovwYOYZeHAH7AL+HWwEVDHv7qDHKe+B4

On 10/29/26 11:58, Dmitry Torokhov wrote:
> Registering the software node and the GPIO chip for the SA-1100 GPIO
> controller during early IRQ initialization causes boot hangs on
> SA-1100 platforms because the software node subsystem has not yet
> been initialized. At that early boot stage, attempting to register
> software nodes dereferences a NULL kset pointer before console or
> driver model initialization.
> 
> Nothing on SA-1100 platforms requests GPIO lines via gpiolib during
> early boot before initcalls run; only the GPIO IRQ controller and
> domain must be initialized during init_IRQ(). Defer registering the
> software node, assigning its firmware node, and registering the GPIO
> chip with gpiolib to postcore_initcall, running after driver and
> gpiolib device initialization and before board consumers register.
> 
> Fixes: e4671f292ebb ("gpio: sa1100: register software node for GPIO controller")
> Cc: stable@vger.kernel.org
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/r/2a561a27-a3bf-4cac-a4dc-bfbc5c859f45@roeck-us.net
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/gpio/gpio-sa1100.c | 32 +++++++++++++++++++++++++++-----
>   1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
> index e4f3bf949b87..1916200ebbd5 100644
> --- a/drivers/gpio/gpio-sa1100.c
> +++ b/drivers/gpio/gpio-sa1100.c
> @@ -8,6 +8,7 @@
>   #include <linux/init.h>
>   #include <linux/module.h>
>   #include <linux/io.h>
> +#include <linux/printk.h>
>   #include <linux/syscore_ops.h>
>   #include <soc/sa1100/pwer.h>
>   #include <mach/hardware.h>
> @@ -322,7 +323,6 @@ static const int sa1100_gpio_irqs[] __initconst = {
>   void __init sa1100_init_gpio(void)
>   {
>   	struct sa1100_gpio_chip *sgc = &sa1100_gpio_chip;
> -	struct gpio_chip *gc = &sgc->chip;
>   	int i;
>   
>   	/* clear all GPIO edge detects */
> @@ -330,10 +330,6 @@ void __init sa1100_init_gpio(void)
>   	writel_relaxed(0, sgc->membase + R_GRER);
>   	writel_relaxed(-1, sgc->membase + R_GEDR);
>   
> -	software_node_register(&sa1100_gpiochip_node);
> -	gc->fwnode = software_node_fwnode(&sa1100_gpiochip_node);
> -	gpiochip_add_data(gc, NULL);
> -
>   	sa1100_gpio_irqdomain = irq_domain_create_simple(NULL,
>   			28, IRQ_GPIO0,
>   			&sa1100_gpio_irqdomain_ops, sgc);
> @@ -342,3 +338,29 @@ void __init sa1100_init_gpio(void)
>   		irq_set_chained_handler_and_data(sa1100_gpio_irqs[i],
>   						 sa1100_gpio_handler, sgc);
>   }
> +
> +static int __init sa1100_gpio_init_chip(void)
> +{
> +	struct gpio_chip *gc = &sa1100_gpio_chip.chip;
> +	int error;
> +
> +	error = software_node_register(&sa1100_gpiochip_node);
> +	if (error) {
> +		pr_err("failed to register sa1100 gpiochip software node: %d\n",
> +		       error);
> +		return error;
> +	}
> +
> +	gc->fwnode = software_node_fwnode(&sa1100_gpiochip_node);
> +
> +	error = gpiochip_add_data(gc, NULL);
> +	if (error) {
> +		pr_err("failed to add sa1100 gpiochip: %d\n", error);
> +		gc->fwnode = NULL;
> +		software_node_unregister(&sa1100_gpiochip_node);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +postcore_initcall(sa1100_gpio_init_chip);
> 
> ---
> base-commit: 6d0933ae9d46674a6ea63a87e9e9ab4e662670c9
> change-id: 20261029-sa1100-swnode-fix-11499713eb7a
> 
> Thanks.
> 

