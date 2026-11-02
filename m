Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.129.254.86
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793586897;
	b=oZlYOJuz0eRpDd3jUps3FIm0PJrIe6yxmESPe6ljVaFNuz4fr/Ivfk0c8jQIS3kgOpWi
	 0o1OqPblXG3HkE5ZQHqdlZr0uVDzehKQLEz1SxbCbRTS6GgTEsC8gEp6OHAsoSSDVm+mz
	 /OnPlJB7gichp37TaKffzAkTsg6JwQ6wjxEnAtMFplG7Mo0aCHYuB0/aaDU5yWFA52yku
	 O+9KNI1GxGBYBqkLtfpAlgNtZxOJ3ggcLNe84Yu3SPGrxcOR+gUXpTtunRC7Vl8EB6D7X
	 dq/Bar0y8l3kuonNu3Zsjic6O3JO8RvihsGoTfHhrSdFyCG02k22LhOyULRch1oXduA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793586897;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=Ozi2LOrnfMzfr2XgM6WUa40W6bNP+UNS1xcJtLzM+XY=;
	b=XTihuserL1eQyFRE5JbVBn5tM0dImdGud6ZTB6ANxWfGcGgyxQ11RU2CpRUNgb07hP8t
	 /pKaicKgHO4yDbia64M1CjiQJ0tYCnHZxhYe/o5WoIMmdXTq/dmLPJOBfDdI2S8EcQfVh
	 1Te1Qbb3vZ8Db5vUUT3RjXISk9hW5OV95CLuMAUK103CKGLGyzy1T11s3kcSeyxit/ybH
	 xtI6Ylb7CylFRIu+hQFPZ1upXMAq09WTGp5lVEmpspGxChy5tJOK7n1lpAEAvdKrWQPFI
	 LbF1L2QdGdEeoRXRjvv8DbkslmOL7qm7cKH3HfMNybdruhxBPgEbNFekpQbEJU5wj8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=iYBDJmdI;
	arc=none smtp.remote-ip=103.129.254.86
Received: from mail-m25486.xmail.ntesmail.com (mail-m25486.xmail.ntesmail.com [103.129.254.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3679E606A324;
	Mon,  2 Nov 2026 02:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3679E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=iYBDJmdI
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 531ca0e2e;
	Mon, 2 Nov 2026 10:34:46 +0800 (GMT+08:00)
Message-ID: <245f5261-6795-430f-820c-015a6f4eaa6c@rock-chips.com>
Date: Mon, 2 Nov 2026 10:34:45 +0800
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
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] mmc: dw_mmc: drain bh_work on host removal
To: BeaCox <0xbeac@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Ulf Hansson <ulfh@kernel.org>
References: <20261101063719.88570-1-0xbeac@gmail.com>
 <20261102022924.51343-1-0xbeac@gmail.com>
 <20261102022924.51343-2-0xbeac@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261102022924.51343-2-0xbeac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa19a1bf77b03a4kunmbb2aee643af948
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGktKVhlDTBkfHh9CSx1PS1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=iYBDJmdIBQzR4bXq7jox4SoklcoR0hlj6GL3jYBWh1wk+oRLlpmsleSdoBOR7T9XXGh1u7fOBd13YOGPJyuDws9jYHywI8crdHH4OauTBIfTp2voiKdxIcymXFUpn3CkjYD4+EIdfgfmIrGg8sE8PdxfDL5LmEF/vPQLmPnR0Jo=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Ozi2LOrnfMzfr2XgM6WUa40W6bNP+UNS1xcJtLzM+XY=;
	h=date:mime-version:subject:message-id:from;

在 2026/11/02 星期一 10:29, BeaCox 写道:
> dw_mci_remove() does not drain bh_work before the driver core releases
> the devm-managed host.  The interrupt handler, the fault-injection timer
> and the DMA completion path can queue that work, and its callback
> accesses the host and MMC request state.  A work item that is still
> pending or running after remove returns dereferences freed memory.
> 
> This is not a regression from the tasklet-to-BH-workqueue conversion.
> The tasklet that bh_work replaced was never killed in dw_mci_remove()
> either, going back to the original driver.  Commit 921c87ba3893
> ("mmc: Convert from tasklet to BH workqueue") only replaced
> tasklet_schedule() with queue_work().
> 
> After removing the MMC host and masking controller interrupts, drain
> the interrupt handler and disable the work synchronously.  Disabling
> the work also rejects later queue attempts, unlike cancellation alone.
> Stop the fault-injection timer after the work callback has finished so
> that it cannot rearm the timer after teardown has cancelled it.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Fixes: f95f3850f7a9 ("mmc: dw_mmc: Add Synopsys DesignWare mmc host driver")
> Cc: stable@vger.kernel.org # 6.11+
> Signed-off-by: BeaCox <0xbeac@gmail.com>
> ---
>   drivers/mmc/host/dw_mmc.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ff0b25d..5b47643 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3406,6 +3406,11 @@ void dw_mci_remove(struct dw_mci *host)
>   	mci_writel(host, RINTSTS, 0xFFFFFFFF);
>   	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
>   
> +	synchronize_irq(host->irq);
> +	/* Stop the work before the timer that it can rearm. */
> +	disable_work_sync(&host->bh_work);
> +	dw_mci_stop_fault_timer(host);
> +
>   	/* disable clock to CIU */
>   	mci_writel(host, CLKENA, 0);
>   	mci_writel(host, CLKSRC, 0);

