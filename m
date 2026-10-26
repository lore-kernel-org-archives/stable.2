Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984933;
	b=nbRtLTmj8y6Gnh3cn+As0JGFdTnGqIXfduQ5ewopoG5mzfg6Ub+xg1PxKqdWBtnyHYeL
	 +UTeKKNGWn73zNdUhRU1gH9ZpllK1Vgoq00XGqqnO1r36vbPkV1OX5otCiIJJxX9ICZOG
	 Z+JW5F6EDrRxYI9owHljsEpU6L884MguGJPEFzmyWBGJuv0/9wxIRNLZ61lI6dSEjBTQY
	 exxGlwJVt7T91fokEDOaDePkWhRuLFBWbpvKW0GvldhE6R9rcv9BZRGrpHVZQGVSbPZAb
	 zKEQTYbzvHHl62DAFRwT20+FLJY0eKbBuJB+lOmUV2+QWWnc8+bdJQMLMQDbe/Co6Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984933;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=uAVUMEmtFiZlBzh2Kd9CRP7rcnQ+Nf7H4f2OSYsP6pc=;
	b=SHbISLDSVg8LXhQZytfr6cgBuqdGM7vCa/vom/myYr3sTM4itZfXOKZq6a9Mf3yp63U8
	 z4iNt/WxLJmw24XyYD2QGHc6DYbyW7BT7QuFDRGAUe6/3bunLW5dO1T4gGVNIIxqp1bCO
	 dnG+ZuSxY+wrNOIoPNMRwC1279s4O6iGAKu/sS0kBfpuezk35wonaV8OdWy0mFHqoUT83
	 ezFNJ9MTPG2BLaxYDerORZbyFY4lXUWnyfQzeacE4ZuEBpAwomU1rY+wXYeoNrJluiMei
	 zknNgI2IT/s9hWHE3kmcWKbitR87f5KQbOUm3oqK64BZrUX0+Qh0Y/tMq31E4FIIYjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F87A606A327;
	Mon, 26 Oct 2026 03:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F87A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8Bx69Fix95qWVoZAA--.7842S3;
	Mon, 26 Oct 2026 11:22:10 +0800 (CST)
Received: from [127.0.0.1] (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJDxRs1hx95qDzUwAA--.22181S2;
	Mon, 26 Oct 2026 11:22:09 +0800 (CST)
Message-ID: <22766db4-fc47-47bd-8062-239f3873fc84@loongson.cn>
Date: Mon, 26 Oct 2026 11:22:09 +0800
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
Subject: Re: [PATCH 03/28] mfd: ls2kbmc: Cancel reset work on teardown via
 devm_work_autocancel()
To: Lee Jones <lee@kernel.org>, Chong Qiao <qiaochong@loongson.cn>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Huacai Chen <chenhuacai@kernel.org>, Corey Minyard <corey@minyard.net>,
 mfd@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261021121245.3111563-1-lee@kernel.org>
 <20261021121245.3111563-3-lee@kernel.org>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <20261021121245.3111563-3-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJDxRs1hx95qDzUwAA--.22181S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEMCGretPgBWQABsl
X-Coremail-Antispam: 1Uk129KBj93XoW7uw1fXw1fCw1xtw4DWryUArc_yoW8ZF4UpF
	Z0kFWjyrs5Ja4UJa4DCryI9FyYgr4YyFW8KryIq3W7Xr13Kwn2vF1FvF9IqFn8ArWkJayY
	grW3Xayxua45ZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j2MKZUUUUU=



On 2026/10/21 20:09, Lee Jones wrote:
> ls2k_bmc_init() initialises bmc_reset_work with INIT_WORK() and
> immediately requests the PCIe and GPIO interrupts via devm_request_irq().
> If an interrupt fires and schedules bmc_reset_work before a subsequent
> step in ls2k_bmc_probe() fails, or when the device is unbound, devres
> frees ddata whilst bmc_reset_work remains queued, leading to a
> use-after-free in ls2k_bmc_events_fn().
> 
> Initialise bmc_reset_work with devm_work_autocancel() before requesting
> the interrupts so that devres cancels any pending work after the
> interrupts are freed and before ddata is released.
> 
> Fixes: d952bba3fbb5 ("mfd: ls2kbmc: Add Loongson-2K BMC reset function support")
> Closes: https://sashiko.dev/#/bug/linux-3089d131-9fcf-4753-b183-eebe0a6e020e
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
Acked-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>   drivers/mfd/ls2k-bmc-core.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
> index 23c774a09842..e245bdee8226 100644
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
> @@ -376,7 +377,9 @@ static int ls2k_bmc_init(struct ls2k_bmc_ddata *ddata)
>   
>   	ls2k_bmc_save_pci_data(pdev, ddata);
>   
> -	INIT_WORK(&ddata->bmc_reset_work, ls2k_bmc_events_fn);
> +	ret = devm_work_autocancel(ddata->dev, &ddata->bmc_reset_work, ls2k_bmc_events_fn);
> +	if (ret)
> +		return ret;
>   
>   	ret = devm_request_irq(&pdev->dev, pdev->irq, ls2k_bmc_interrupt,
>   			       IRQF_SHARED | IRQF_TRIGGER_FALLING, "ls2kbmc pcie", ddata);

-- 
Thanks.
Binbin

