Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984912;
	b=ESqW1Nc21PCHJZoAG1AVEN3Tkx5vm3SEYMazGNclsWGMHOdHRHrFs4YzEb7tNt/3P1Md
	 /FRuygTYvKjaNthDE/QQP8uC9U0+WMr/mlkUGNZlTk4XWvxGLlp6w9GThS5j181Ru63Lt
	 lNhhQCbYUXeV5XdccZMbrZ/4fHtKBPaLy8TYEHiLIGQq5OcGxFTz7P7Z/C5e75x5oOFsZ
	 1HBJgLJvBn1f46xM1mga3qn2GHTYDmegndu1OjTzNM0oiC9X04YgM61L5qKJqfwlcvCJP
	 dv1KQwk/nTUGiHgUCLFNew61i4HhciNp+8Xiwv6Iy4McmJxYNJSn9XBa4TYs/FvE1qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984912;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=mMRnglkS/lID45CQcRtuTJexEbi3WggWqY33cUjMKuc=;
	b=I4SuT++q+hFpI/r0uAQkAmrrCB4dfRffxR/Ga1cfZoF3ojEtfdVEe93Ycqv9baKUN+w0
	 d7cElyXE09wC8BLfoJbBSJ3dNm7zjtgk3ZnitgfSwbKw9ImTs6Ns/mUl/fi3XXkVjpECA
	 MrW7rRaZgBFvnR22WQA6wTYwAEYOojWsXRy1fSKIx3OOQauznigsvWVxVY12rGCNvELav
	 8l6Tsh+Itm/qVBNNTll1E7XI0ThHkwJuP8X5T4JtsBC/umPTpFaHD/o0YxVs9IKcQPuOt
	 g3HrAAXqOyxYNy71fejr97YLArx6JmwQ+QjyD1b761GbUdbuDB9OiOrdlpgFripAQSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E209606A321;
	Mon, 26 Oct 2026 03:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E209606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8AxYdFFx95qSVoZAA--.8872S3;
	Mon, 26 Oct 2026 11:21:41 +0800 (CST)
Received: from [127.0.0.1] (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJCx9cxCx95qCzUwAA--.7917S2;
	Mon, 26 Oct 2026 11:21:39 +0800 (CST)
Message-ID: <427c1f75-3d52-49a6-9a2b-edd54dba3732@loongson.cn>
Date: Mon, 26 Oct 2026 11:21:38 +0800
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
Subject: Re: [PATCH 02/28] mfd: ls2kbmc: Unregister GPIO GSI via
 devm_add_action_or_reset()
To: Lee Jones <lee@kernel.org>, Chong Qiao <qiaochong@loongson.cn>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Corey Minyard <corey@minyard.net>, Huacai Chen <chenhuacai@kernel.org>,
 mfd@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261021121245.3111563-1-lee@kernel.org>
 <20261021121245.3111563-2-lee@kernel.org>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <20261021121245.3111563-2-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJCx9cxCx95qCzUwAA--.7917S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEMCGrexPwALAAAsn
X-Coremail-Antispam: 1Uk129KBj93XoW7WryDGr45JrWUtw1rZw4xGrX_yoW8tw18pF
	W5G3WYyrsYqrn7Za9rJry8uFy5Kr4xAayxCr1Igwn7ZrnIkws2vF1Iqa4UXFyrCrykGFWU
	Jr4fKayDuas09FcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17
	MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
	AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
	cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIF
	yTuYvjxU2MKZDUUUU



On 2026/10/21 20:09, Lee Jones wrote:
> ls2k_bmc_init() unconditionally calls acpi_unregister_gsi() immediately
> after requesting the GPIO interrupt via devm_request_irq().  This
> prematurely disposes of the active IRQ mapping while the interrupt
> handler remains registered, breaking the GPIO watchdog interrupt and
> causing a use-after-free when devres later frees the disposed IRQ
> descriptor on probe failure or device unbind.
> 
> Register a devm_add_action_or_reset() callback before devm_request_irq()
> so that acpi_unregister_gsi() is invoked only after devres has freed the
> interrupt.
> 
> Fixes: d952bba3fbb5 ("mfd: ls2kbmc: Add Loongson-2K BMC reset function support")
> Closes: https://sashiko.dev/#/bug/linux-cab8bfb6-4077-46f3-a173-ac2e2042cf66
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Acked-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>   drivers/mfd/ls2k-bmc-core.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
> index 408056bfb2fe..23c774a09842 100644
> --- a/drivers/mfd/ls2k-bmc-core.c
> +++ b/drivers/mfd/ls2k-bmc-core.c
> @@ -363,6 +363,11 @@ static void ls2k_bmc_save_pci_data(struct pci_dev *pdev, struct ls2k_bmc_ddata *
>   	pci_read_config_dword(pdev, PCI_INTERRUPT_LINE, &ddata->bmc_pci_data.interrupt_line);
>   }
>   
> +static void ls2k_bmc_unregister_gsi(void *data)
> +{
> +	acpi_unregister_gsi(LS2K_BMC_RESET_GPIO_GSI);
> +}
> +
>   static int ls2k_bmc_init(struct ls2k_bmc_ddata *ddata)
>   {
>   	struct pci_dev *pdev = to_pci_dev(ddata->dev);
> @@ -412,12 +417,15 @@ static int ls2k_bmc_init(struct ls2k_bmc_ddata *ddata)
>   	if (gpio_irq < 0)
>   		return gpio_irq;
>   
> +	ret = devm_add_action_or_reset(ddata->dev, ls2k_bmc_unregister_gsi, NULL);
> +	if (ret)
> +		return ret;
> +
>   	ret = devm_request_irq(ddata->dev, gpio_irq, ls2k_bmc_interrupt,
>   			       IRQF_SHARED | IRQF_TRIGGER_FALLING, "ls2kbmc gpio", ddata);
>   	if (ret)
>   		dev_err(ddata->dev, "Failed to request LS2KBMC GPIO IRQ %d.\n", gpio_irq);
>   
> -	acpi_unregister_gsi(LS2K_BMC_RESET_GPIO_GSI);
>   	return ret;
>   }
>   

-- 
Thanks.
Binbin

