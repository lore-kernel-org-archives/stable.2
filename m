Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADB83A0E97;
	Tue, 15 Sep 2026 07:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457599; cv=none; b=DePEgKLAWQyv6AtF7GRxFk7NmQPEyq9i9EmrGAlBvLC+g7UZIOvG9hkTyFH4ADVr197OO0DwHgIc7JLvBSoj72enyvq7QhzMPyVywLOwcWI3i0jcBtIkO6cVm4AXPsoyFidE2QktxQBDKxmwo9DGZzrfdkVE1gh+fC0fYZXJht4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457599; c=relaxed/simple;
	bh=r055o+FfsZ3xHfcMEOuOjB/f/0ziDpTdjz00V+zKe+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUaB0dZB8X9DapvNuXRz+bVAlSLhgoggLMq9M2mwPM+WjLC90ifRPvn0TbNpf4KXdGmyM8mH298rTtlUrHDiiFfZ7NHz0aVBHcaUtUPSEZCtBul563FQICxE81iTxhuXEedE4lDT4PqQ/5E0abMkx+SUW7Bh9ygKPPKeFh6WGx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7S7YDYZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7S7YDYZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA471F000FF;
	Tue, 15 Sep 2026 07:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789457597;
	bh=7t/ZedGRRRAhyLC410A4Ar3dEgSIVzE6A3QzUCUweeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j7S7YDYZzae8V6MVndX/UQiN4kwHP+9vtME4s6ZxjTY69FqHp2tWqpsl3WKV8vbkN
	 4Tj7CyqdD/8dQcAkRr8HmphD/O8h3ii9myYMasQsRizKEW/2Gk8tJkx/0gYS9r9Jon
	 MrBfZ8DQ2Fx/l/tB7u953HkVawmdxTv2ZxwJL3YJvB7ANAaSKNJvhw/EVaYgKIch5o
	 t6xzwtH+/V4EZg27e3G2+3j/G8OCgST5w11h5GxOmVY7ytDG5/sCNCiLmx4OZ8SHhA
	 7P77EsjBj8VqwaWS+0lzsJWZpUa36JlLMgnAegIGq4HmZE9ReWxGWJe9jOEiAz47gj
	 vJu/9cBqM7KkA==
Date: Tue, 15 Sep 2026 00:33:15 -0700
From: Peter Chen <peter.chen@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-usb@vger.kernel.org, Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Song Li <songl@zju.edu.cn>, Sicong Huang <congei42@163.com>
Subject: Re: [PATCH] usb: cdns3: fix use-after-free in cdns3_gadget_exit()
Message-ID: <aqj0u7Kg65x8FZmj@hu-petche-lv.qualcomm.com>
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

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
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
>  	cdns3_free_all_eps(priv_dev);
>  
>  	while (!list_empty(&priv_dev->aligned_buf_list)) {
> 

-- 

Thanks,
Peter Chen
