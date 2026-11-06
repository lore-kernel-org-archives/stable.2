Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979980;
	b=mBhUOrvJJND6yZR/Dbiokf82N+g+E+qjT4VeOSd+hIKIuFuAHVoiiPSNtz2DI7kQnYIo
	 sVOJJlxg6ilNQzyOzrNEpGS0Kj0iFq0FwcU721GoB9CCJs5ZEndefi+3NdDDdzJhmHSkb
	 8kfllE7G0Tep8/D/LiWCTGn+xQ7VVZwA8T7qXl39AbpsOMbpz7Mm835xEMb/sbpoV2dsg
	 0s9yCyBRYihNOpPfwYyoeaRnbMsE3z6LCvMe7SnZyh7c/+mgB9FZyRSZLmOQdi85C85GR
	 n8jQ983E9EiE66o3MH2j6l67ZThdAO2a2TUDZytqZ0bk8HfIk945fJsuo3u/KuWGAnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979980;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=pql5uSvkXeVpmOTxFyX3IKXjR1NKu8eMj90jbya94rk=;
	b=vPGRwCM80tr6kEOhh/wrWlGGFYVouEsqBFmmIwYDfqIKKlZ9ftz5Wq/TeRY5t+2qvnSS
	 jP9BDciQvfkexZdfpuMfCrNreS8K68oGp4wD8h9jiQekJF/+SZNPk/eNCKYqLXwTOl6Gj
	 ICH8GaRxaxREFAWT4u9Q669LQ+ekOZpPvyy3Q0V9d4IfHThlrJI/Eyk8TpY7MBBL7n5zQ
	 QZ2XIt8bg5A1Y63pkz8zP/1NvOpdY69sao1ObGAFNwu08HvgoPrilFPYIHObAWKAEOsAR
	 Xd0Cx4F4mAeBGmUWv0GhSTUmHeWAEhbWmflJUgIgsXgI/2uuY2pUDoAMOmew9/+aJYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdAP8pj1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A1F606A329;
	Fri,  6 Nov 2026 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CdAP8pj1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1601F0089F;
	Fri,  6 Nov 2026 15:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793979979;
	bh=pql5uSvkXeVpmOTxFyX3IKXjR1NKu8eMj90jbya94rk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CdAP8pj1TvsbC0jiYKygjvShWGbeP60dBbynQPv0CzBEdUOciS4X4Ij8inX3Um8y/
	 espj/224ttGvPofC0sBpi2gTY05ds4L0Xtg+GOCODZFm5wIT2s6LFtKkodHfIiueP0
	 p3wS3nF9vAjEfaGVV3KnkhLJD71S/0GaNVln40XkZDxBAm1WxFbXe4mvx/NpE5pv3A
	 dGF8+qyD9lFLIXrOxCY0Pon+AaWQc3bowtqpHtpPjrkZEuRFnk6efHOTPDnBYOX+g2
	 0u4gwalaHyVh70hJrwd3k/0MUlD/M7t2/wMv4IDwcjROjO37bFd4KXnJcAgoS9dUK4
	 t1DXwQ8M7pwLA==
Message-ID: <318911bd-dc33-4399-987e-fc05e86d732b@kernel.org>
Date: Fri, 6 Nov 2026 16:46:15 +0100
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
Subject: Re: [PATCH 1/5] extcon: intel-int3496: drain ID work before its GPIOs
 and extcon device are freed
To: hyunjungg <hj351016@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-samsung-soc@vger.kernel.org, stable@vger.kernel.org
References: <20261106131730.2633139-1-hj351016@gmail.com>
 <20261106131730.2633139-2-hj351016@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20261106131730.2633139-2-hj351016@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6-Nov-26 14:17, hyunjungg wrote:
> From: Hyunjung Ko <hj351016@gmail.com>
> 
> int3496_probe() registers the debounce work for device-managed
> cancellation before it acquires any of the resources that the work
> handler dereferences:
> 
> 	devm_delayed_work_autocancel(dev, &data->work, int3496_do_usb_id);
> 	...
> 	data->gpio_usb_id  = devm_gpiod_get(dev, "id", ...);
> 	data->gpio_vbus_en = devm_gpiod_get(dev, "vbus", ...);
> 	data->gpio_usb_mux = devm_gpiod_get(dev, "mux", ...);
> 	data->edev = devm_extcon_dev_allocate(dev, int3496_cable);
> 	devm_extcon_dev_register(dev, data->edev);
> 	devm_request_threaded_irq(dev, data->usb_id_irq, ...);
> 
> devres releases resources in reverse registration order, so on unbind
> the extcon device and all three GPIO descriptors are released first and
> the work is cancelled last:
> 
> 	/* free_irq() */
> 	devm_extcon_dev_unregister() / extcon freed
> 	gpiod_put(mux) / gpiod_put(vbus_en) / gpiod_put(usb_id)
> 	...
> 	cancel_delayed_work_sync(&data->work);		/* too late */
> 
> int3496_thread_isr() arms the work with mod_delayed_work() on every ID
> pin edge, so a work instance can be pending or running at unbind. The
> handler int3496_do_usb_id() dereferences data->gpio_usb_id
> (gpiod_get_value_cansleep), data->gpio_usb_mux, data->gpio_vbus_en and
> data->edev (extcon_set_state_sync) with no guard. If it runs in the
> window after the GPIOs/extcon device have been released but before the
> work is cancelled, it operates on freed resources -> use-after-free.
> 
> Register the work for cancellation after the GPIOs and extcon device
> are acquired and registered (and before the IRQ, which arms it), so
> devres (LIFO) frees the IRQ first, then cancels the work, and only then
> releases the GPIOs and extcon device. devm_delayed_work_autocancel()
> still performs INIT_DELAYED_WORK() before the work is first queued
> (queue_delayed_work() below, and the IRQ handler, both run after it).
> 
> Found by static analysis / code review; compile-tested only, not
> reproduced on hardware (requires an INT3496 ACPI USB-ID mux device).
> 
> Fixes: f94a5becabf4 ("extconn: Clean-up few drivers by using managed work init")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
> diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
> index 7d16d5b..40774fb 100644
> --- a/drivers/extcon/extcon-intel-int3496.c
> +++ b/drivers/extcon/extcon-intel-int3496.c
> @@ -130,9 +130,6 @@ static int int3496_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	data->dev = dev;
> -	ret = devm_delayed_work_autocancel(dev, &data->work, int3496_do_usb_id);
> -	if (ret)
> -		return ret;
>  
>  	data->gpio_usb_id =
>  		devm_gpiod_get(dev, "id", GPIOD_IN | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
> @@ -169,6 +166,10 @@ static int int3496_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	ret = devm_delayed_work_autocancel(dev, &data->work, int3496_do_usb_id);
> +	if (ret)
> +		return ret;
> +
>  	ret = devm_request_threaded_irq(dev, data->usb_id_irq,
>  					NULL, int3496_thread_isr,
>  					IRQF_SHARED | IRQF_ONESHOT |

