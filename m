Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256B01E51E0;
	Thu, 10 Sep 2026 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789007314; cv=none; b=JQEy+jmFdH12D294L3lU+02r5GrXfbsGTo02koTOxD3Q2zWgOu7iCa6g7zujW/2hMKRlxMoT2QuS9ckBU83AM5jm/ZrbacjrqvO7nJS6v+BpQB+SOcsz7IZ0IjmXFdAsHB3yfOI4hOjFnXl1Dc++x5sdcN/nm7UU5wvviY2pnlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789007314; c=relaxed/simple;
	bh=qEMmzoO+HC0iJ6rzMg9/5xEshklNUaRQFLrDToeQ0f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oxm1/Ianh5OdlV5KlqOKAIb5WmnW32LdnU+WmlbdsTRK6hC70bkWorR0OYjtpsqK4OtEEKy1LuSEAjfyslv9kjPHE0jAvTk4PhB7aGnIw1Pq3C9aik4TUmvRLUEpdRojf4F786VmRsAYyePD0UrOC5kO4MHFwW5qsOet2zvZ7iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1StZFcU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1StZFcU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688941F000FF;
	Thu, 10 Sep 2026 02:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789007312;
	bh=eUwQmgsQqzQQenhKvvPa+VT7E6BdXxWZIJScwCHFucI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V1StZFcUUowVRlS4Sr890zbyy5pvRsD/DGaXNYeYFGs/d2xSRMpXddcndg0EFedWo
	 wm4etMO7xJURU6fsT/AnnPFvAiUCX0HOld8UCgEvTxmTvLdTbt4qbUv10ieHIRBjlK
	 wPWnIc1a6eN+aRAj65gSciT5EacL2/dkOUNdhkmBcLK/7As+wVm0hEDANtMXjdZN7j
	 R746OKNZyhF9JJAj91YfETDUWsQRHNzmCVloaOmcnB5XRRvJnyuKZbmqK80cmrskeE
	 umvKEFsNWdvEPnsh2CWSoVqXG0plW5EuGQ1gZPO8rEJK6n8Eq/CsyW1Cs4FYYGorrV
	 uuosE6bhUdsPg==
Date: Wed, 9 Sep 2026 19:28:31 -0700
From: Peter Chen <peter.chen@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-usb@vger.kernel.org, Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Song Li <songl@zju.edu.cn>, Sicong Huang <congei42@163.com>
Subject: Re: [PATCH] usb: cdns3: fix use-after-free in cdns3_gadget_exit()
Message-ID: <aqIVzxZyRyx67GPX@hu-petche-lv.qualcomm.com>
References: <20260909095655.694527-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909095655.694527-1-fanwu01@zju.edu.cn>

On 26-09-09 09:56:55, Fan Wu wrote:
> cdns3_gadget_start() arms two works on system_freezable_wq:
> pending_status_wq for the deferred ep0 status stage and aligned_buf_wq
> for realigned request buffers. Both handlers use the cdns3_device the
> works are embedded in, and cdns3_pending_setup_status_handler() also
> calls the ep0 request completion.
> 
> cdns3_gadget_exit() does not wait for these works. It frees all
> endpoints and aligned buffers and drops the last reference to the
> gadget device, which frees priv_dev, so a work queued before the exit
> can run after the free.
> 
> Fix this by waiting for both works after the gadget driver is unbound
> and the IRQ is freed, when no new work can be queued, and before the
> endpoints and buffers are released.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Cc: stable@vger.kernel.org
> Reported-by: Sicong Huang <congei42@163.com>
> Closes: https://lore.kernel.org/linux-usb/7f5719b.8700.18f67b324d3.Coremail.congei42@163.com/
> Suggested-by: Sicong Huang <congei42@163.com>
> Assisted-by: Codex:gpt-5.6
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>  drivers/usb/cdns3/cdns3-gadget.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 42311c1bf..0d272e9c5 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -3269,6 +3269,10 @@ static void cdns3_gadget_exit(struct cdns *cdns)
>  	usb_del_gadget(&priv_dev->gadget);
>  	devm_free_irq(cdns->dev, cdns->dev_irq, priv_dev);
>  
> +	/* The works can still be queued until the IRQ is freed. */
> +	cancel_work_sync(&priv_dev->pending_status_wq);
> +	cancel_work_sync(&priv_dev->aligned_buf_wq);
> +

We may cancel work before going to de-init. How about move them before

	pm_runtime_put_autosuspend(cdns->dev);

-- 

Thanks,
Peter Chen
