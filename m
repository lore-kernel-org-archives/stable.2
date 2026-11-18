Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018219;
	b=X8g+BagRGUtR56a8I3f6Xm5vKikrq7c8q2GwEz9ulOA6Q3Mhys4FmbgmE38bUZs4sToN
	 ggBpSQQs5hcfVaxWI/aUjY7kLy0/66156NO/vD6hK3VbW7UDkHVHvhRr0/8LGwx7+v6XH
	 XOfEW7fLkMHF6mtV+SuSA8+DhR04dmAK8vKRGEnY7EpctVYVoyPSsVv0SgXc+o5NqCwLl
	 RN6gulVyINUf6VzKToKWypco8lyExhlgJXK9N03HIy8pvISTrMKo6O4xbr6FUwDnyUhdE
	 EJXn4Y9eqfJAEulFhkJ8SKvVUeed/qdwaT7dbaP3qZSOQxzizW4HRsK52QMLcSshqgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018219;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=OfBmMKlkmBzZs+0Sd10+8uWEyF/5b2rwRxFqeRYlL9I=;
	b=RxuKz7hLmIJXhWQ2A3KhFlskHmwR962TBKi0SrEzDiPDHvUghu+y4A3b5i7eV77p0mAI
	 oBDZnActHm91Jv84rVcrPdBpLbdx9wbTtwjXeKHqzy6qXvejNTpvDgCZiaw1BO13Ss9uN
	 bjBrpD/VxC7wHkIysAmXG6KyLs3FLB6+V330LJDlTVOEwMzUu6SfXPy/L6QbCqdZ6e7Y9
	 TEnU1p4zeltNR4cdDxOj/LkUElqu5WCPZFIpaleoj3+AwV7zOSO5MAieX3B8cXxEb43FR
	 FfMMQSK4KhaqQCQ6tW+M0xTq8JtyzfH28xee3zxNcaulqnt4ewChCluR6985ZQhbptQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jhs2c3G0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3A1606A325;
	Wed, 18 Nov 2026 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jhs2c3G0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58E91F000C4;
	Wed, 18 Nov 2026 16:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795018219;
	bh=OfBmMKlkmBzZs+0Sd10+8uWEyF/5b2rwRxFqeRYlL9I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Jhs2c3G0veAQ+V3ThkgTnWf9B6NtfD/6DrpHWp1fFlW5MjlkmALNxqmlg348Xf4z3
	 wFwqg5WmylsIRceLT3NGNZcf9EnzS/e95L51wFTKOslVvRcoSiPTwCK/S2JTNIMjxK
	 yry3In+VxhDEEOyJ58O4Y9nkHHPNodJG0Q8MV0aPTpm60SO/86SLaDb1Es3rpLN89Z
	 0pWBFonb7nUvssunjafgweIMBJ5mqTFI8+DwVkWEbsAb7jsaGnrpSI4086KTZFkWIm
	 sf8NXLgmSWMRx5G6kPW+71Njtjomt5mow19h8RzKStiAlqHGqL6rn3a5QM9+emptnl
	 p2hMq7Oy7wOIg==
Message-ID: <9cb574c7-aa23-442a-be12-49142f2ee6ed@kernel.org>
Date: Wed, 18 Nov 2026 17:10:16 +0100
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
Subject: Re: [PATCH] platform: arm64: lenovo-thinkpad-t14s: Keep the interrupt
 off while suspended
To: Abel Vesa <abel.vesa@oss.qualcomm.com>, Sebastian Reichel
 <sre@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
References: <20261118-platform-arm64-t14s-ec-irq-suspended-v1-1-635eb3e7325e@oss.qualcomm.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20261118-platform-arm64-t14s-ec-irq-suspended-v1-1-635eb3e7325e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18-Nov-26 16:39, Abel Vesa wrote:
> The interrupt handler reads the event from the EC over I2C. Nothing
> keeps it from running while the system is suspending or resuming, when
> the I2C controller cannot be used.
> 
> On resume the interrupts are enabled again after the noirq phase, while
> runtime PM of the I2C controller stays disabled until its early resume.
> An EC interrupt that is pending by then fails, and so does every further
> one until the controller is back. On the ThinkPad T14s Gen 7 that showed
> up as more than a thousand of these in a few milliseconds when resuming
> from hibernation:
> 
>   geni_i2c a84000.i2c: error turning SE resources:-13
>   thinkpad-t14s-ec 7-0028: Failed to read event
> 
> Disable the interrupt when suspending and enable it at the end of
> resume, once the EC can be talked to. An event that arrives in between
> is handled then.
> 
> Fixes: 60b7ab6ce030 ("platform: arm64: thinkpad-t14s-ec: new driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

Right, this is pretty standard for i2c drivers with a non wakeup-source
IRQ. IOW: Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
> The EC interrupt handler talks to the EC over I2C, and nothing stops it
> from running while the I2C controller is not usable during a system
> sleep transition.
> 
> This was found on the ThinkPad T14s Gen 7 while getting hibernation to
> work there. The support for the EC of that machine is not upstream yet,
> but the interrupt handler and the suspend and resume callbacks are the
> ones the X1E based ThinkPad T14s uses.
> 
> Resuming from hibernation failed the read of the EC event more than a
> thousand times in a few milliseconds there. That many, because the
> interrupt was level triggered in the GIC at that point, as the SPI
> configuration is not restored after hibernation [1]. With that fixed,
> the handler still runs once before the I2C controller is back.
> 
> With this patch there are no failed reads on the ThinkPad T14s Gen 7
> when resuming from hibernation. It was not tested on the X1E based
> ThinkPad T14s.
> 
> [1] https://lore.kernel.org/r/20261024144720.113165-2-zhuling2709@phytium.com.cn
> 
> Prepared with help from an LLM-based assistant.
> ---
>  drivers/platform/arm64/lenovo-thinkpad-t14s.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/platform/arm64/lenovo-thinkpad-t14s.c b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
> index 873747838a4f..a291daba0577 100644
> --- a/drivers/platform/arm64/lenovo-thinkpad-t14s.c
> +++ b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
> @@ -616,6 +616,12 @@ static int t14s_ec_suspend(struct device *dev)
>  {
>  	struct t14s_ec *ec = dev_get_drvdata(dev);
>  
> +	/*
> +	 * The handler needs the I2C controller, which is not available
> +	 * again until this device is resumed.
> +	 */
> +	disable_irq(to_i2c_client(dev)->irq);
> +
>  	led_classdev_suspend(&ec->kbd_backlight);
>  
>  	t14s_ec_write_sequence(ec, T14S_EC_REG_MODERN_STANDBY,
> @@ -633,6 +639,8 @@ static int t14s_ec_resume(struct device *dev)
>  
>  	led_classdev_resume(&ec->kbd_backlight);
>  
> +	enable_irq(to_i2c_client(dev)->irq);
> +
>  	return 0;
>  }
>  
> 
> ---
> base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
> change-id: 20261118-platform-arm64-t14s-ec-irq-suspended-5fd6892d7e26
> 
> Best regards,
> --  
> 
> Abel

