Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC216346A02;
	Thu, 27 Aug 2026 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813328; cv=none; b=Bwk8isbYhQm8sLhf6Xi1P/yBgwnkGIl4N5JBEu0haihtfgOH8p4L+fTSIg7j4JwSdSRHYxbQZ+TQxIdaB0JnI4cCRCc5T1P8QJ2QdT73/5ewoEAs7xotWuw3zzTmlkUeYqEljH1HCqUkzCrRaGyKhj6G03jTx2gSq+KMHEefT9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813328; c=relaxed/simple;
	bh=lxtegW1qzmevjd5YiA7LnGqwliByfWbOi3aQSke7MeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtPE7j1x6970DaJADvz//pINgOjAys/J/wiKJigH1t/0kMPOINWXXI1bAKfuJQIYVvjHaMRBN09c/FmmLoSkM/q4UGSQgmzx2hojIXOvC5NVDkttlspKOwz3/R4VvVKifioF1579vDGnij80qYkPzv7F6yEuZVuMy54euROHfIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVKphDsO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVKphDsO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FF51F000E9;
	Thu, 27 Aug 2026 06:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787813326;
	bh=iMNt0AVCewUERSb+p9NmHv26TiVtqST6ZuHMj83wVuA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dVKphDsORl3kuz+m4nACZb+swsFLK9cXwGF9597IehzzfLjaMhpwrK34q6qtOf74v
	 ybsVMQ6cH35dkNe3vpAqRD/ey4vZ6aQ5PmoMFc1IXq5LrABJK2HLoZ/Y2xr9boS2Bs
	 5xNnb3Zt93dXfJegXTfU8qshxJlId2SWm0pRLr0RW48ZENIKuH7UBAC54TJy9LCmLA
	 moA8kIAMu2o/HyoENO5544Aoe9iviXrtjB/BUlZI+MammDdNYNjs8BomS3KRuqHYrc
	 jrrTB8D7gHztwDmAGQs+DE2SlhbUzDma/zKXTfsP18LP5t8epudXEggZrVxFHxdV5H
	 Kv1Q+FEZUG1IQ==
Message-ID: <067b7e2e-f2b2-4462-96f1-3a1e35bd25e8@kernel.org>
Date: Thu, 27 Aug 2026 08:48:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] memory: brcmstb_dpfe: Fix out-of-bounds access due to
 DCPU offset
To: Danesh Petigara <danesh.petigara@broadcom.com>, mmayer@broadcom.com,
 florian.fainelli@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Justin Chen <justin.chen@broadcom.com>, stable@vger.kernel.org
References: <20260826201500.3000125-1-danesh.petigara@broadcom.com>
 <20260826201500.3000125-2-danesh.petigara@broadcom.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260826201500.3000125-2-danesh.petigara@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/08/2026 22:14, Danesh Petigara wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> On API v1/v2 boards, the DCPU coprocessor can steer kernel readl_relaxed()
> and writel_relaxed() to any address within 256 MB of the ioremapped DPFE
> dmem or regs base. The DCPU firmware provides a 28-bit offset which the
> driver adds to the ioremap base without any bounds checking in
> get_msg_ptr().
> 
> This allows a compromised DCPU firmware to trick the host kernel into
> reading or writing arbitrary memory-mapped I/O registers in vmalloc
> space. When combined with a root-writable sysfs file like dpfe_refresh,
> it provides an arbitrary MMIO write primitive. Similarly, world-readable
> sysfs files can be used to leak other devices' register contents.

If someone can compromise firmware to provide different addresses, then
what stops this person to change DTB with completely different MMIO
ranges for this device?

Isn't better just to drop root-writeable sysfs interfaces, since they
are the insecure parts?

> 
> Fix this by recording the resource_size() of the dmem and regs ioremaps
> at probe time, and rejecting any offset that, along with the largest
> field accessed (DRAM_VENDOR_ERROR + sizeof(u32)), exceeds the recorded
> mapping size.
> 
> Fixes: fee5f1ef6cf7 ("memory: brcmstb: dpfe: support new way of passing data from the DCPU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> Assisted-by: Gemini:gemini-3.1-pro-preview cursor
> Signed-off-by: Danesh Petigara <danesh.petigara@broadcom.com>
> ---
>  drivers/memory/brcmstb_dpfe.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
> index 08d9e05b1b33..66343205f585 100644
> --- a/drivers/memory/brcmstb_dpfe.c
> +++ b/drivers/memory/brcmstb_dpfe.c
> @@ -182,6 +182,8 @@ struct brcmstb_dpfe_priv {
>  	void __iomem *regs;
>  	void __iomem *dmem;
>  	void __iomem *imem;
> +	resource_size_t regs_size;
> +	resource_size_t dmem_size;
>  	struct device *dev;
>  	const struct dpfe_api *dpfe_api;
>  	struct mutex lock;
> @@ -401,9 +403,14 @@ static void __iomem *get_msg_ptr(struct brcmstb_dpfe_priv *priv, u32 response,
>  	 */
>  	switch (msg_type) {
>  	case 1:
> +		if (DCPU_MSG_RAM_START + offset + DRAM_VENDOR_ERROR +
> +		    sizeof(u32) > priv->regs_size)
> +			goto bad_offset;
>  		ptr = priv->regs + DCPU_MSG_RAM_START + offset;
>  		break;
>  	case 0:
> +		if (offset + DRAM_VENDOR_ERROR + sizeof(u32) > priv->dmem_size)
> +			goto bad_offset;
>  		ptr = priv->dmem + offset;
>  		break;
>  	default:
> @@ -415,6 +422,12 @@ static void __iomem *get_msg_ptr(struct brcmstb_dpfe_priv *priv, u32 response,
>  	}
>  
>  	return ptr;
> +
> +bad_offset:
> +	dev_err(priv->dev, "DCPU returned out-of-range offset %#x\n", offset);
> +	if (buf && size)
> +		*size = sprintf(buf, "ERROR: DCPU offset out of range\n");
> +	return NULL;
>  }
>  
>  static void __finalize_command(struct brcmstb_dpfe_priv *priv)
> @@ -858,6 +871,7 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct brcmstb_dpfe_priv *priv;
> +	struct resource *res;
>  	int ret;
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> @@ -869,17 +883,21 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
>  	mutex_init(&priv->lock);
>  	platform_set_drvdata(pdev, priv);
>  
> -	priv->regs = devm_platform_ioremap_resource_byname(pdev, "dpfe-cpu");
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dpfe-cpu");

You cannot use devm_platform_get_and_ioremap_resource()? Are the 'reg'
entries flexible/random?


Best regards,
Krzysztof
