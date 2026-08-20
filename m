Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9B73D9DC9;
	Thu, 20 Aug 2026 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219891; cv=none; b=ZBVENDo3uaqFYlHziqg0fXsi1K7De+DFQTyy9tllic7OplPaTEyb782+RwfvZaZ3k2lEx0IhD0xNvfeyizIUSre0rtfuFdL+wt/quH4N6ih/ceTakfL6ZPLr+BFxURoTvxfj0GEZWye2BwE7Oy00dGa1bpVxWu6JgOjothJh9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219891; c=relaxed/simple;
	bh=hZCBSCVqYSqJjG/RYe4s9Chfzr/JZMEG/Narie0NAv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2HTugRJzRToTutbBTLvEmos2kp8yN5lYjxvurBIiRw+/T434FUTq/vu1hMO+tb1lGuvAu7PNEanWkyf+JVA7TVd7y/4MxRJZww0PjiZg3GfsXH2nTXlRrzxqOUZEVExP3WcsKgtZ/Vy+IUAWuvDd7rppY7xTC+GNM6dVqlfP5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Krd+q4og; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Krd+q4og"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C001F000E9;
	Thu, 20 Aug 2026 09:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787219889;
	bh=iT4z9T84RIeL6znb2/fBeakb7emJXAOiqhHr7wV3+08=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Krd+q4og/0fB1kW3rdAds+20Ego7Xb5YM5StBDwPpduUeo9LwpUy/cJFL5V/aWuZx
	 p4f3Puwj+qIiRnE4TyEDdp0Ie696AYRcmtGrWgN+waGe2iptja5P1lfVc+v0mVVQj7
	 HwZVv0bfz0mPqZqwN/G0o48G7FX/6CIgwpFnuMKPBXPEfKYB3mqLVuCaeolwj8hvEy
	 iv3F3JqXatm6RYexRHTvpH9+BmPTrGRVpbOmP7bnMfROXAbAKeDk2qLOJcUfv2pDyj
	 sxjRfry++bNCbT7ngzeMQuNBe6OFDSCX4YloKFYtsSrBugOopjLrAT3p3dik8wz+3o
	 m/sMbaN0iGeag==
Message-ID: <23e039b9-2c7a-440c-b3dc-3274788d18b2@kernel.org>
Date: Thu, 20 Aug 2026 11:58:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] extcon: lc824206xa: Use devm_work_autocancel() for detect
 work
To: Fan Wu <fanwu01@zju.edu.cn>, myungjoo.ham@samsung.com,
 cw00.choi@samsung.com
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260805050841.7990-1-fanwu01@zju.edu.cn>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260805050841.7990-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5-Aug-26 07:08, Fan Wu wrote:
> The detect work is re-armed by the threaded IRQ handler but nothing drains
> it on detach: devm frees the IRQ before kfree(data) without flushing the
> workqueue, so a pending work item can run after data is freed, leading to a
> use-after-free.
> 
> Use devm_work_autocancel() so devm LIFO order frees the IRQ before the work
> is cancelled. Register it after the regulator, extcon and power_supply
> the work callback dereferences, so those are not freed before the cancel
> either.
> 
> This issue was found by an in-house static analysis tool.
> Compile-tested only; runtime testing is appreciated.
> 
> Fixes: 9e1897cb9568 ("extcon: Add LC824206XA microUSB switch driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
>  drivers/extcon/extcon-lc824206xa.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-lc824206xa.c b/drivers/extcon/extcon-lc824206xa.c
> index 56938748aea8..adcea69ac221 100644
> --- a/drivers/extcon/extcon-lc824206xa.c
> +++ b/drivers/extcon/extcon-lc824206xa.c
> @@ -19,6 +19,7 @@
>  #include <linux/bits.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/devm-helpers.h>
>  #include <linux/extcon-provider.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> @@ -424,7 +425,6 @@ static int lc824206xa_probe(struct i2c_client *client)
>  		return -ENOMEM;
>  
>  	data->client = client;
> -	INIT_WORK(&data->work, lc824206xa_work);
>  	data->cable = EXTCON_NONE;
>  	data->previous_cable = EXTCON_NONE;
>  	data->usb_type = POWER_SUPPLY_USB_TYPE_UNKNOWN;
> @@ -463,6 +463,11 @@ static int lc824206xa_probe(struct i2c_client *client)
>  	if (IS_ERR(data->psy))
>  		return dev_err_probe(dev, PTR_ERR(data->psy), "registering power supply\n");
>  
> +	/* After all resources lc824206xa_work() derefs; before the IRQ producer. */
> +	ret = devm_work_autocancel(dev, &data->work, lc824206xa_work);
> +	if (ret)
> +		return ret;
> +
>  	ret = devm_request_threaded_irq(dev, client->irq, NULL, lc824206xa_irq,
>  					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>  					KBUILD_MODNAME, data);

