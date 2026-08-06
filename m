Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8452F3A7F41;
	Thu,  6 Aug 2026 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030404; cv=none; b=hfMnjCixab4KAMjKx2kTpbk7qxEJIlzvsvcp4rUHvTUgy0nIUcRDvq2GEG4gNAidWxz0ELm6gRg9WhXHGsnGMIV+6tZJlZic95fn7oCLzpWtY1toePpGdtIvp+JBO+gWf8FEerXwOtVt/9JNafwU+hheoGfM/MTyQW6qW6S1cJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030404; c=relaxed/simple;
	bh=ybhIDxJwnl1eWkpS8aUt4d4Tid6c2d9yzLlRryWdoEM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=tkpFKOtUsaY2uUX+Eh8bD/TJu3XJAWy2hQvXonhmB2F6gvQMwLqmJwkiE6WjH1RsRzHzyiK4eecmpSlaGvvhb/KUJBmtaUVQOYsZYtzp+gjBiFhQMbU95qKgxux3pcSOE0Jis0U4Sn5Zd+tScN8GhpLIQhpTd8kntXNpTkFYAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=bFsE/AuT; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="bFsE/AuT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=Ewq999Y1Vo51a9AeffXD/hQsMW2lBYayQnR5pdj6Mdo=; b=bFsE/AuTCciNxzRGXzZQmOZphx
	dK2ypIenWLTMWkfSSDG+o97AK9HNSTOYDY6dHG/0jcO2xRDxdSNcsWDgltdKlXGG7u0o8zqp43rC0
	dmZS26tmzVwBl+zoZLFOkkTcK8y+SNNOpskD3eb8dopaNwvjxgjcWGXjGDSCYD14ekzG71gFlk9E9
	mxMtEoJuOFx2dgJ1ZTYQBvtjug/8eC02/KenGatEqloKgwh86ThLjENMKgCCzpdcMDg91NmyLe35d
	rus9StsgagEljr+MfSUhY3nB02++5ndUwQPt8XeWugYz5mVYzLX0/5/Okj4nsVMkNZTjrrQ73cpx/
	POwCwdeg==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([96.51.150.74] helo=[10.0.33.8])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1ws05x-00000001Yim-0aQB;
	Thu, 06 Aug 2026 09:33:21 -0600
Message-ID: <5ce42824-488e-4040-8531-0acc8b01b13a@deltatee.com>
Date: Thu, 6 Aug 2026 09:32:09 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pei Xiao <xiaopei01@kylinos.cn>, kurt.schwemmer@microsemi.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <1f52d931ec7a7f5b36837cabf07b36e0463bf182.1785982054.git.xiaopei01@kylinos.cn>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <1f52d931ec7a7f5b36837cabf07b36e0463bf182.1785982054.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 96.51.150.74
X-SA-Exim-Rcpt-To: xiaopei01@kylinos.cn, kurt.schwemmer@microsemi.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2] PCI: switchtec: Fix use-after-free in
 switchtec_pci_remove due to race condition
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-05 8:12 p.m., Pei Xiao wrote:
> In stdev_create, &stdev->mrpc_work is bound with mrpc_event_work, and
> &stdev->link_event_work is bound with link_event_work. The IRQ handlers
> switchtec_event_isr and switchtec_dma_mrpc_isr can schedule these works
> on system_wq (via schedule_work() in the ISRs and via
> check_link_state_events()).
> 
> If we remove the device, switchtec_pci_remove makes cleanup and the
> memory allocated for stdev is released by put_device() ->
> stdev_release() -> kfree(stdev), while the works mentioned above may
> still be pending or running. The sequence of operations that may lead
> to a UAF bug is as follows:
> 
> CPU0                                      CPU1
> 
>                                           | switchtec_event_isr
>                                           | schedule_work(&stdev->mrpc_work)
> switchtec_pci_remove                      |
> cdev_device_del(&stdev->cdev,             |
>                 &stdev->dev)              |
> stdev_kill(stdev)                         |
> switchtec_exit_pci(stdev)                 |
> pci_dev_put(stdev->pdev)                  |
> put_device(&stdev->dev)                   |
> // stdev_release -> kfree(stdev)          |
>                                           | mrpc_event_work
>                                           | // use stdev (use-after-free)
> 
> Fix it by quiescing the interrupt sources before canceling the works:
> stdev_kill() first clears PCI bus mastering, then explicitly frees both
> IRQs, so no handler can be running and scheduling new work while the works
> are canceled.
> 
> Fixes: 080b47def5e5 ("MicroSemi Switchtec management interface driver")
> Fixes: 48c302dc8f3a ("NTB: switchtec: Add link event notifier callback")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:deepseek-v4-flash
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
> changes in v2:
> 1.Add explicitly devm_free_irq
> 2.cacel mrpc_work and link_event_work move to before mrpc_timeout
> 3.Add event_irq and dma_mrpc_irq in struct stdev
> 4.Add Cc: stable@vger.kernel.org
> ---
>  drivers/pci/switch/switchtec.c | 16 +++++++++++++++-
>  include/linux/switchtec.h      |  2 ++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 5711aaa5df11..235ca1877b6c 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1318,6 +1318,13 @@ static void stdev_kill(struct switchtec_dev *stdev)
>  
>  	pci_clear_master(stdev->pdev);
>  
> +	if (stdev->event_irq >= 0)
> +		devm_free_irq(&stdev->pdev->dev, stdev->event_irq, stdev);
> +	if (stdev->dma_mrpc_irq >= 0)
> +		devm_free_irq(&stdev->pdev->dev, stdev->dma_mrpc_irq, stdev);
> +
> +	cancel_work_sync(&stdev->mrpc_work);
> +	cancel_work_sync(&stdev->link_event_work);
>  	cancel_delayed_work_sync(&stdev->mrpc_timeout);
>  
>  	/* Mark the hardware as unavailable and complete all completions */
> @@ -1356,6 +1363,8 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
>  	INIT_LIST_HEAD(&stdev->mrpc_queue);
>  	mutex_init(&stdev->mrpc_mutex);
>  	stdev->mrpc_busy = 0;
> +	stdev->event_irq = -1;
> +	stdev->dma_mrpc_irq = -1;

I think the patch as a whole is correct. But one minor nit that could
maybe clean it up slightly. pci_irq_vector() cannot return 0. So I think
it would be fine to just leave these explictily initialized to zero and
check for non-zero in the tests above.

Other than that minor point:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks!

Logan
