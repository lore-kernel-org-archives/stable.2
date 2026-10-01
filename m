Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E500547074;
	Thu,  1 Oct 2026 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790885456; cv=none; b=A8edQCEaOr3LP1J+80ZsY7q6AV7Cn/iwfcTxphbmIe7YmeABQpNuNDbBFHNrIERLChvFvdUQ39I7KeKiY8Kpa+dqnUWI+AlWb3sNuwKKajzBWophIZfP3cltDgJPHbavTqdmGJ0NtOVjLu+mVn42ymrS4qD/NHLi5M2ZgCQ25Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790885456; c=relaxed/simple;
	bh=eqlalWEACgHVJxaJJINEXXgUmnExZVGD96ZPJQYAGoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhSc1cIqvJLCYEw/0d9xMUcHAoGgWjE1ErYp7poIYmVA4tj6mMsJM4NwaObTSrx87bg4JVc6thyCr7OOJ9CiNZW3wQ7suRwOLj3+v5Z70AOb3TZNxAbYKfCezQhuU+AWp9PU+2ow7ASvvZ4h6YJnP89TgMeTp/UWNT0lkqCv5/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiljaSLz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiljaSLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC80C1F00893;
	Thu,  1 Oct 2026 20:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790885454;
	bh=Emgg1hEsTegrNFwf0i6etQNx21yoM37aHkx9/z0TU/4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RiljaSLzEKKK1iEQRgaD2Fo2dglKP531VxzLAsUCwsQStAN3k/HIV6t9iwxZn/83/
	 0kB+HM0mjBZ0tDc85eKU+LClNqWPODUs+Bgc5a0zH/2COGIRm85Rfs81wfDilzqMRc
	 U+kYzgePDFfIWtFZIUKzkOfDVbCrrJ1lEqGwVOnaY3T7yF24kzCjmyMeAXe3L6AOaU
	 6vIUxIT93w5V7c3jWl0ZTB5LY6Q28MoCZOEOhBvNpjG5DFpOEJiXt16GPYaNw0KnU7
	 LAgAXJptB73isAB84zsuarhmHKrt11GD4YCAdu4qa9SR+OthcxJYbVvVmGaetK+Tox
	 aMOhMfqWeBcxw==
Message-ID: <74c10fee-bfb1-4225-af5b-fc2b3ce664a9@kernel.org>
Date: Thu, 1 Oct 2026 21:10:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] media: venus: disable recovery work before HFI
 teardown
To: Myeonghun Pak <mhun512@gmail.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
References: <20260925191653.3144006-1-mhun512@gmail.com>
 <20261001175502.4045853-1-mhun512@gmail.com>
 <IUKxO70u7tuzfobwy7veeNHbvyK5WtlYFOliAToGsdPncgmwXfbd95-SoyBBUj0AUENfcYLnsh4qaFj4AEkeKA==@protonmail.internalid>
 <20261001175502.4045853-3-mhun512@gmail.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-GB
Autocrypt: addr=bod@kernel.org; keydata=
 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
In-Reply-To: <20261001175502.4045853-3-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/10/2026 18:55, Myeonghun Pak wrote:
> venus_remove() cancels core->work before the IRQ is disabled. An IRQ
> thread can queue the work again after cancellation. The work can then
> access HFI state after venus_hfi_destroy() frees it. The work also
> requeues itself when recovery fails, so cancelling an already running
> instance alone does not close the race.
> 
> Disable and drain the work at the start of remove, before other resources
> are dismantled. Do the same in venus_hfi_destroy() for paths that bypass
> remove, including probe unwind. Disabling the work prevents both IRQ
> handlers and the work itself from requeuing it. Drain the work before
> disabling the IRQ so an active recovery can finish any IRQ based
> completion waits. Then synchronize the IRQ before freeing HFI state.
> 
> Fixes: af2c3834c8ca ("[media] media: venus: adding core part and helper functions")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/20260730153912.BAC5E1F00A3D@smtp.kernel.org/
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>   drivers/media/platform/qcom/venus/core.c      | 2 +-
>   drivers/media/platform/qcom/venus/hfi_venus.c | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 7087af32060f..6e495bc04691 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -596,7 +596,7 @@ static void venus_remove(struct platform_device *pdev)
>   	struct device *dev = core->dev;
>   	int ret;
> 
> -	cancel_delayed_work_sync(&core->work);
> +	disable_delayed_work_sync(&core->work);
>   	ret = pm_runtime_get_sync(dev);
>   	WARN_ON(ret < 0);
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index e7e4e78a186a..20b8ba1e62f1 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -1689,6 +1689,7 @@ void venus_hfi_destroy(struct venus_core *core)
>   {
>   	struct venus_hfi_device *hdev = to_hfi_priv(core);
> 
> +	disable_delayed_work_sync(&core->work);
>   	disable_irq(core->irq);
>   	core->priv = NULL;
>   	venus_interface_queues_release(hdev);
> --
> 2.53.0
> 

You shouldn't have to disable the work queue twice.

Does a path actually exist where hfi_destroy() runs but venus_remove() 
does not ?

The commit text is vague about that - sure hfi_destroy() may be callable 
from the error path of probe() but is any work scheduled in that case ?

I mean lets just look at venus_hfi_destroy()


static void venus_remove(struct platform_device *pdev)
{
         struct venus_core *core = platform_get_drvdata(pdev);
         const struct venus_pm_ops *pm_ops = core->pm_ops;
         struct device *dev = core->dev;
         int ret;

         cancel_delayed_work_sync(&core->work);
         ret = pm_runtime_get_sync(dev);
         WARN_ON(ret < 0);

         ret = hfi_core_deinit(core, true);
         WARN_ON(ret);

         venus_shutdown(core);
         of_platform_depopulate(dev);

         venus_firmware_deinit(core);

         venus_remove_dynamic_nodes(core);

         pm_runtime_put_sync(dev);
         pm_runtime_disable(dev);

         if (pm_ops->core_put)
                 pm_ops->core_put(core);

         v4l2_device_unregister(&core->v4l2_dev);

         hfi_destroy(core);

         mutex_destroy(&core->pm_lock);
         mutex_destroy(&core->lock);
         venus_dbgfs_deinit(core);
}

Your patch will call disable_delayed_work_sync() twice on this path once 
in venus_remove() per your patch and then again in hfi_destroy()...

NAK - can't be right.

---
bod
