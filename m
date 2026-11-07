Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794031277;
	b=BskajzNzYHAq44gBNVZ9cLzQNXmzdfIOZp2pBpIiVNbHrLVyITcjhI/BXeY4jLQMG9NR
	 t0iPqdV2j7cjAEXK8B4MZw2TFG4cRhpn57Lpqy2QwhjfaX1NqV2U1/4hUIakhst+Z5NiT
	 INm704oiWpY2yvMmXpQMo1slGRWGMsi5rFJOHUASip86FwEVEivW6phIm8iT1QRgOHiFn
	 oCy/8W0XtGaYP7jRRUd7XRslag8o5qgOQLvHZZmmOjIyzSJ8njbfB0M3B0D6TGFU8LWNV
	 aA5mjIMLoy1DMP+w9fmHelVI9bl9XNnL2TXuHT8iUFJit3G92Ys8gJOXNZFSu55BD5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794031277;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=VApiiAu4y4jzk0oNRwNpWoUyNlZ1jI1NbfuSJXJZy6I=;
	b=aOEx7H5iareX/3tzSS41sqYQS+QrvjpI9u3bdgesdxHyCcoWLlSEwLBXmCTCJ+Y8XMHh
	 zbMmPVA09VYN3ptL7SGCEt3LcWFm21uIa7LlRyWayzp07oVUw7uM7vexLayb1LrUt17bi
	 dWeGpTbiOq7U4UuZm82fnItRyXibC4kTEe9cP5jsZ2gZM8Fa7i1FkEwOC3oHIRHjxdiFy
	 JedZLTD8JQSgqAIjHdnPoLClNdSSaKbk3Ow4SjqvVjcRVFuEQRdc0BCheSKBrSboVlJS+
	 GQueh1JbHwH9N8W6Anz69nECLytUv6gTqUrHCkyib5BOVkKraXOqXGI/QSonqdNmyqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1B6606A32C;
	Sat,  7 Nov 2026 06:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F1B6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8DxD9Okvu5qf1QdAA--.19351S3;
	Sat, 07 Nov 2026 14:01:08 +0800 (CST)
Received: from [127.0.0.1] (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJCxNs2fvu5q3uQyAA--.24809S2;
	Sat, 07 Nov 2026 14:01:04 +0800 (CST)
Message-ID: <8ffdb96e-c082-42b6-b895-2badc12285ca@loongson.cn>
Date: Sat, 7 Nov 2026 14:01:02 +0800
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
Subject: Re: [PATCH] mfd: ls2kbmc: cancel the reset work before the driver
 data is freed
To: hyunjungg <hj351016@gmail.com>, Chong Qiao <qiaochong@loongson.cn>,
 Lee Jones <lee@kernel.org>
Cc: mfd@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261107053218.3326443-1-hj351016@gmail.com>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <20261107053218.3326443-1-hj351016@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJCxNs2fvu5q3uQyAA--.24809S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEECGrulv0ArQAAsN
X-Coremail-Antispam: 1Uk129KBj93XoW7ZrWfWryUWw17CFWkXry8CrX_yoW8Kw45pF
	Z8KFWYyrWDJr1Uta4DWr1I9FyYgr4rCr1xK348tw17W34aqr1qvr40vF90qF98CrWkGFWY
	grWSq34v9a45ZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXUUUUU=

Hi:

On 2026/11/7 13:32, hyunjungg wrote:
> From: Hyunjung Ko <hj351016@gmail.com>
> 
> ls2k_bmc_init() INIT_WORK()s ddata->bmc_reset_work (ls2k_bmc_events_fn)
> and requests two device-managed interrupts (ls2k_bmc_interrupt) that
> schedule_work(&ddata->bmc_reset_work).  The work handler dereferences
> ddata via container_of().
> 
> ddata is devm_kzalloc()'d, so devres frees it when the device is
> unbound.  Nothing cancels bmc_reset_work: free_irq() (run by devres)
> only waits for the interrupt handler to finish, not for a work item it
> has already queued.  If a BMC reset interrupt fires shortly before
> unbind, the queued ls2k_bmc_events_fn() can run after ddata has been
> freed -> use-after-free.
> 
> Register the work for device-managed cancellation with
> devm_work_autocancel(), before the devm_request_irq() calls that arm
> it, so devres (LIFO) frees the interrupts first, then cancels the work,
> and only then frees ddata.
> 
> Found by code review; not reproduced (needs Loongson-2K BMC hardware and
> a reset interrupt racing driver unbind).
> 
> Fixes: d952bba3fbb5 ("mfd: ls2kbmc: Add Loongson-2K BMC reset function support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> ---
>   drivers/mfd/ls2k-bmc-core.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
> index 408056b..c44291e 100644
> --- a/drivers/mfd/ls2k-bmc-core.c
> +++ b/drivers/mfd/ls2k-bmc-core.c
> @@ -12,6 +12,7 @@
>   #include <linux/aperture.h>
>   #include <linux/bitfield.h>
>   #include <linux/delay.h>
> +#include <linux/devm-helpers.h>
>   #include <linux/errno.h>
>   #include <linux/init.h>
>   #include <linux/iopoll.h>
> @@ -371,7 +372,10 @@ static int ls2k_bmc_init(struct ls2k_bmc_ddata *ddata)
>   
>   	ls2k_bmc_save_pci_data(pdev, ddata);
>   
> -	INIT_WORK(&ddata->bmc_reset_work, ls2k_bmc_events_fn);
> +	ret = devm_work_autocancel(ddata->dev, &ddata->bmc_reset_work,
> +				   ls2k_bmc_events_fn);
> +	if (ret)
> +		return ret;


Lee had already fixed this issue:

https://lore.kernel.org/all/20261027093306.2812695-4-lee@kernel.org/
>   
>   	ret = devm_request_irq(&pdev->dev, pdev->irq, ls2k_bmc_interrupt,
>   			       IRQF_SHARED | IRQF_TRIGGER_FALLING, "ls2kbmc pcie", ddata);

-- 
Thanks.
Binbin

