Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763033B636A;
	Wed,  7 Oct 2026 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791367946; cv=none; b=Y3+4sRi1qqkv6FhiJtK7MNPj9dVJoHthYnuxTT9J7XAN7xtsrlucR16okAmMVPPYVU7W9XZ+nlJpQzARg35Xgyael++hwwP38wHhQv2821DuBwgADSqtgb/L9/skXwTYpo7K/Mc9T/iILl0XCftfOnWCWIrXs1hBQ0bIBEABi20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791367946; c=relaxed/simple;
	bh=i6WolQeDXnoDJrNQkDZLjMJndNYz2s5HKHwTnvAgcfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQRJ+ldRYZ/x47K1lTYDSfdbrLWiQe9AM4kRZ/+U1BOu1DxAwXpy97tKzZqPEJxg0Pwd5v86pL8dblOLg9AL123t04J0cjiySorOX8KEAWK4ehc3zbLhBIxUUPOyVP20qigWQMC7HpY099NkQATqolQpHUU3HjBlQRXfmNqHT1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ArFvmsAg; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ArFvmsAg"
Received: from [192.168.0.43] (chfd-03-b2-v4wan-176392-cust229.vm15.cable.virginm.net [82.19.20.230])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BA43612B2;
	Wed,  7 Oct 2026 12:10:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1791367815;
	bh=i6WolQeDXnoDJrNQkDZLjMJndNYz2s5HKHwTnvAgcfY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ArFvmsAgbFm25Xs9TpdAtQVombDKdBqC9Y2x+aIXd+fDB338IGBNTcjAO0yCyoSvT
	 fwBcBICzTyLygmDK/kv/ME+pYO6feBE/IYfwX3qNnkUwojP8BvnnMsHsgeKUO31rKB
	 3lHK4Og2S7V5wz6KPvJap2ZJhxID1+IePqcFAPrA=
Message-ID: <0a02d00c-e9d0-4373-9df5-65e3ad58d278@ideasonboard.com>
Date: Wed, 7 Oct 2026 11:12:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] media: mali-c55: Keep IRQ requested during suspend
To: Linus Walleij <linusw@kernel.org>, Li Youhong <dayou5941@163.com>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>,
 Nayden Kanchev <nayden.kanchev@arm.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260929-mali-c55-irq-supend-resume-v1-0-e3af34afff12@kernel.org>
 <20260929-mali-c55-irq-supend-resume-v1-2-e3af34afff12@kernel.org>
Content-Language: en-US
From: Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <20260929-mali-c55-irq-supend-resume-v1-2-e3af34afff12@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus

On 29/09/2026 13:02, Linus Walleij wrote:
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
> If firmware marks the ISP as a wakeup source, initialize device wakeup
> and enable IRQ wake during system suspend. Disable it again before
> resuming the device.

I think that adding this could be a separate commit to fixing the irq handling...and perhaps that 
should be the case given the Fixes tag?

> 
> This configures the interrupt controller wake path.
> 
> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>   .../media/platform/arm/mali-c55/mali-c55-core.c    | 84 ++++++++++++++++------
>   1 file changed, 64 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-core.c b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> index f28e9f4354ac..07267b79801b 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> @@ -17,6 +17,8 @@
>   #include <linux/of_reserved_mem.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/pm_wakeup.h>
> +#include <linux/property.h>
>   #include <linux/reset.h>
>   #include <linux/slab.h>
>   #include <linux/string.h>
> @@ -675,8 +677,7 @@ static int __maybe_unused mali_c55_runtime_suspend(struct device *dev)
>   {
>   	struct mali_c55 *mali_c55 = dev_get_drvdata(dev);
>   
> -	if (irq_has_action(mali_c55->irqnum))
> -		free_irq(mali_c55->irqnum, dev);
> +	disable_irq(mali_c55->irqnum);
>   	__mali_c55_power_off(mali_c55);
>   
>   	return 0;
> @@ -745,25 +746,41 @@ static int __maybe_unused mali_c55_runtime_resume(struct device *dev)
>   	if (ret)
>   		return ret;
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
> +	enable_irq(mali_c55->irqnum);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused mali_c55_suspend(struct device *dev)
> +{
> +	struct mali_c55 *mali_c55 = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (device_may_wakeup(dev)) {
> +		ret = enable_irq_wake(mali_c55->irqnum);
> +		if (ret)
> +			return ret;
>   	}
>   
> +	ret = pm_runtime_force_suspend(dev);
> +	if (ret && device_may_wakeup(dev))
> +		disable_irq_wake(mali_c55->irqnum);
> +
>   	return ret;
>   }
>   
> +static int __maybe_unused mali_c55_resume(struct device *dev)
> +{
> +	struct mali_c55 *mali_c55 = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(mali_c55->irqnum);
> +
> +	return pm_runtime_force_resume(dev);
> +}
> +
>   static const struct dev_pm_ops mali_c55_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -				pm_runtime_force_resume)
> +	SET_SYSTEM_SLEEP_PM_OPS(mali_c55_suspend, mali_c55_resume)
>   	SET_RUNTIME_PM_OPS(mali_c55_runtime_suspend, mali_c55_runtime_resume,
>   			   NULL)
>   };
> @@ -825,27 +842,53 @@ static int mali_c55_probe(struct platform_device *pdev)
>   	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
>   	pm_runtime_use_autosuspend(&pdev->dev);
>   	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_get_noresume(dev);
>   	pm_runtime_enable(&pdev->dev);
>   
>   	ret = mali_c55_media_frameworks_init(mali_c55);
>   	if (ret)
>   		goto err_pm_runtime_disable;
>   
> -	pm_runtime_idle(&pdev->dev);
> -
>   	mali_c55->irqnum = platform_get_irq(pdev, 0);
>   	if (mali_c55->irqnum < 0) {
>   		ret = mali_c55->irqnum;
>   		goto err_deinit_media_frameworks;
>   	}
>   
> +	/*
> +	 * The driver needs to transfer large amounts of register settings to
> +	 * the ISP each frame, using either a DMA transfer or memcpy. We use a
> +	 * threaded IRQ to avoid disabling interrupts the entire time that's
> +	 * happening.
> +	 */
> +	ret = request_threaded_irq(mali_c55->irqnum, NULL, mali_c55_isr,
> +				   IRQF_ONESHOT, dev_driver_string(dev), dev);
> +	if (ret) {
> +		dev_err(dev, "failed to request irq\n");
> +		goto err_deinit_media_frameworks;
> +	}
> +
> +	if (device_property_read_bool(dev, "wakeup-source")) {
> +		ret = devm_device_init_wakeup(dev);
> +		if (ret) {
> +			ret = dev_err_probe(dev, ret,
> +					    "failed to initialize wakeup\n");
> +			goto err_free_irq;
> +		}
> +	}
> +
> +	pm_runtime_put_autosuspend(dev);
> +
>   	return 0;
>   
> +err_free_irq:
> +	free_irq(mali_c55->irqnum, dev);
>   err_deinit_media_frameworks:
>   	mali_c55_media_frameworks_deinit(mali_c55);
>   err_pm_runtime_disable:
> -	pm_runtime_set_suspended(&pdev->dev);
>   	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_set_suspended(&pdev->dev);

I would say that this re-ordering of the pm_runtime_set_suspended() and pm_runtime_disable() calls 
probably ought to be in a separate commit too, since it's a distinct change that should be 
backported to fix stable branches.

Thanks
Dan

>   	kfree(mali_c55->context.registers);
>   err_power_off:
>   	__mali_c55_power_off(mali_c55);
> @@ -859,12 +902,13 @@ static void mali_c55_remove(struct platform_device *pdev)
>   {
>   	struct mali_c55 *mali_c55 = platform_get_drvdata(pdev);
>   
> +	pm_runtime_disable(&pdev->dev);
> +	free_irq(mali_c55->irqnum, &pdev->dev);
>   	mali_c55_media_frameworks_deinit(mali_c55);
> -	if (!pm_runtime_suspended(&pdev->dev)) {
> +	if (!pm_runtime_status_suspended(&pdev->dev)) {
>   		__mali_c55_power_off(mali_c55);
>   		pm_runtime_set_suspended(&pdev->dev);
>   	}
> -	pm_runtime_disable(&pdev->dev);
>   	kfree(mali_c55->context.registers);
>   	of_reserved_mem_device_release(&pdev->dev);
>   }
> 

