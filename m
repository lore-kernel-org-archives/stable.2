Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C892938E8A6;
	Mon, 17 Aug 2026 05:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786945448; cv=none; b=Cmox7gKfwioTY9NRrAFOLWevH7VtgUDGg8njk5jrqXIMYNBxVykO32n4GKzDwy77peE3Ku3QUYvk0+PMQQ6p9Na8wCw0u1VqIjX7Eyo5Vm6fmAUU7+uGU94Zqp0p8WwFJm3SA7ad8JfUlZQBBHFWgym3EYSwTnvJ0um3gmzBYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786945448; c=relaxed/simple;
	bh=3Z8NTkcSmZNROq0mS1Vhz+9XRt27zbRimxsI9FDbXiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FzSV5FMjG8BPdc9wxcYYhiGHUEP+wc0FtdVB1H+x/20CrAXgaah9ye7C7MSmxObDJk/82zARRiYdGA3f9t5jUf+iuq5wuB1K28se6BIPUNLff61rNa3I/1QwlER6UUmKw3+/jZVp/LLu2yR9RxC/A3nwZhhZI/62u0LpWPEteJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a5ca836299fe11f19a56ed5b684f684d-20260817
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5dfe335c-43bf-4de8-b1c0-2c85e7cd72ec,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:13613173f22392b68b36f7cadba80485,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52,EDM
	:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a5ca836299fe11f19a56ed5b684f684d-20260817
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1197100874; Mon, 17 Aug 2026 13:44:00 +0800
Message-ID: <d6674b24-1a9e-487d-9add-416ee00e6e0d@kylinos.cn>
Date: Mon, 17 Aug 2026 13:43:58 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: switchtec: Fix use-after-free in
 switchtec_pci_remove due to race condition
To: Logan Gunthorpe <logang@deltatee.com>, kurt.schwemmer@microsemi.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <1f52d931ec7a7f5b36837cabf07b36e0463bf182.1785982054.git.xiaopei01@kylinos.cn>
 <5ce42824-488e-4040-8531-0acc8b01b13a@deltatee.com>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <5ce42824-488e-4040-8531-0acc8b01b13a@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/8/6 23:32, Logan Gunthorpe 写道:
> 
> 
> On 2026-08-05 8:12 p.m., Pei Xiao wrote:
>> In stdev_create, &stdev->mrpc_work is bound with mrpc_event_work, and
>> &stdev->link_event_work is bound with link_event_work. The IRQ handlers
>> switchtec_event_isr and switchtec_dma_mrpc_isr can schedule these works
>> on system_wq (via schedule_work() in the ISRs and via
>> check_link_state_events()).
>>
>> If we remove the device, switchtec_pci_remove makes cleanup and the
>> memory allocated for stdev is released by put_device() ->
>> stdev_release() -> kfree(stdev), while the works mentioned above may
>> still be pending or running. The sequence of operations that may lead
>> to a UAF bug is as follows:
>>
>> CPU0                                      CPU1
>>
>>                                           | switchtec_event_isr
>>                                           | schedule_work(&stdev->mrpc_work)
>> switchtec_pci_remove                      |
>> cdev_device_del(&stdev->cdev,             |
>>                 &stdev->dev)              |
>> stdev_kill(stdev)                         |
>> switchtec_exit_pci(stdev)                 |
>> pci_dev_put(stdev->pdev)                  |
>> put_device(&stdev->dev)                   |
>> // stdev_release -> kfree(stdev)          |
>>                                           | mrpc_event_work
>>                                           | // use stdev (use-after-free)
>>
>> Fix it by quiescing the interrupt sources before canceling the works:
>> stdev_kill() first clears PCI bus mastering, then explicitly frees both
>> IRQs, so no handler can be running and scheduling new work while the works
>> are canceled.
>>
>> Fixes: 080b47def5e5 ("MicroSemi Switchtec management interface driver")
>> Fixes: 48c302dc8f3a ("NTB: switchtec: Add link event notifier callback")
>> Cc: stable@vger.kernel.org
>> Assisted-by: Codex:deepseek-v4-flash
>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>> ---
>> changes in v2:
>> 1.Add explicitly devm_free_irq
>> 2.cacel mrpc_work and link_event_work move to before mrpc_timeout
>> 3.Add event_irq and dma_mrpc_irq in struct stdev
>> 4.Add Cc: stable@vger.kernel.org
>> ---
>>  drivers/pci/switch/switchtec.c | 16 +++++++++++++++-
>>  include/linux/switchtec.h      |  2 ++
>>  2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
>> index 5711aaa5df11..235ca1877b6c 100644
>> --- a/drivers/pci/switch/switchtec.c
>> +++ b/drivers/pci/switch/switchtec.c
>> @@ -1318,6 +1318,13 @@ static void stdev_kill(struct switchtec_dev *stdev)
>>  
>>  	pci_clear_master(stdev->pdev);
>>  
>> +	if (stdev->event_irq >= 0)
>> +		devm_free_irq(&stdev->pdev->dev, stdev->event_irq, stdev);
>> +	if (stdev->dma_mrpc_irq >= 0)
>> +		devm_free_irq(&stdev->pdev->dev, stdev->dma_mrpc_irq, stdev);
>> +
>> +	cancel_work_sync(&stdev->mrpc_work);
>> +	cancel_work_sync(&stdev->link_event_work);
>>  	cancel_delayed_work_sync(&stdev->mrpc_timeout);
>>  
>>  	/* Mark the hardware as unavailable and complete all completions */
>> @@ -1356,6 +1363,8 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
>>  	INIT_LIST_HEAD(&stdev->mrpc_queue);
>>  	mutex_init(&stdev->mrpc_mutex);
>>  	stdev->mrpc_busy = 0;
>> +	stdev->event_irq = -1;
>> +	stdev->dma_mrpc_irq = -1;
> 
> I think the patch as a whole is correct. But one minor nit that could
> maybe clean it up slightly. pci_irq_vector() cannot return 0. So I think
> it would be fine to just leave these explictily initialized to zero and
> check for non-zero in the tests above.
Hi Maintainer,
  I apologize for my delay, and I have already sent the third version.

https://lore.kernel.org/lkml/4cebfe41ee3985bc4f38beb42d44147a34637971.1786944920.git.xiaopei01@kylinos.cn/

Pei.
Thanks.
> 
> Other than that minor point:
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> Thanks!
> 
> Logan

