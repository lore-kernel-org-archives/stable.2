Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D483033DE
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722902; cv=none; b=tQcYUTquopGmFj0noYVQnfDZl/E2zZm+/8FyXVPUJPeMjTE0k2vhoNFKaZCLQXSrOqyd4+QP994ddWlfDFzI2MO1hcbs9lPK62ppXvb3GHpXUD6IJxoTvyKfaJx2CgQpoXXKLFKkY/j9Nc8DuAM3bvisydGq7xeM8Ktlw3C/3mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722902; c=relaxed/simple;
	bh=qjBuJ33yZlfHL1S9SrLYPjB31Lz1hU3VJgkUNM2s+hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbLSEjzhYFOZWLFqsfy9oS+uJzTtKoDhsPKFU06c+ILDoItPHKcC+ishgXVZXpw8pF25N0eBr40OEg2xJ2kYE57wb3WOJT80PaOnMF5sjh34tnv2DU7ekDgu5sTBQH38PaAjHcngbxSmoaARSEJE33NtcIsk/tQo+G2aAKxF18Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bnbvm6Iz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bnbvm6Iz"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c81db32393so66295ad.0
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 01:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782722900; x=1783327700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2CYHaiLd9ywNSZ9pftV2yPbkytXEfUK5AIl8p5DJYxA=;
        b=Bnbvm6Iz421a3hEiQdhKX59PJBYRZq3a5gyeppw1b3Me17EAdpDZtsAW7bARBJqPfa
         9c45MOz5otxVxuD2jl4jD1zvsnUOlJ13CiaYPRH2+4X0SptD9CjVR44+PWT6qmYME5uI
         +PTCnkJWX1dOIF/AxmXkbEhnZbpBmaTAuviS9Y3sOYCOUmpK5K65SAqfHVGegxZmGPH4
         UDUl3WBaYtCIS/Rn5DKoz+zdguMfmIAwmYWYhs2bxDO9+XdLgkoIHERDytpxivsJ4wSa
         TEzT3VTNCUhicZJTU2CMaiJl5AKKK2Tse50DJFoxB/s0G6wm84Bq/GC7xlhRq6zbLXul
         TeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782722900; x=1783327700;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2CYHaiLd9ywNSZ9pftV2yPbkytXEfUK5AIl8p5DJYxA=;
        b=E4bcUe++XZiS3GTSm7ThkFm7kWAPz4EU1yz35eo8ezFq5+YgPh+D2AaWOktdRtAq7K
         qkPMA98lvuamtbNzAuJ+1VwoWwfExoG0/kWY3NR3JLKZqfwvgJ+NkhDlG/K9w+D4pJth
         8BgUcik6AZRrDgVQ3VGmbDtZROFof31WCnhrFyjT09GDpo9sgeVu3vEvZMzAzfWGo2+R
         ScO2BSvGghfTBYvEoUYcMD5bC97SkujNQaN6EyB2HTJPS6hvftViuV70F4Msw5PXAohu
         A0pe5hZbgA5mdz85aTZ+xuERnl7ydvM4zSLL6gnWKecWWN1yYmp+QTTpUfR5bA/raRJz
         zPzw==
X-Forwarded-Encrypted: i=1; AHgh+RoI99PEVRVHTJqO+XTQTBKDWOMoRKd4PudNvwriAUd9smM9L+LQcRia2pESDBK8EaPZuxUlGKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Lfsy/RROiVgou3uULdtMa4pySZjM8uskAUygyHg1GRJnHiiS
	KlkPKuzxs/lN6SPOrUIAxgwHv371mlki2g8cefc4JaaVmhzwM4AgJiX8OQ07QJt1+Q==
X-Gm-Gg: AfdE7ck/DqxCUGG2EKhAFuiRQvyJWGBXm69trSqcvx5hJUB8CytQBCk80kJulqeDRCk
	Vg7dILf6T8/qfQ2hDVbsUFXSNvUhipiOY+/+OhBA6FtRXEVObGlgFe6oGPJlXWuIw3M/QGIWwFH
	KE0vZpc5vzLNllOLE7ufRCk9ybLha93e0Wll20iVyZvr94/NRsbB7yCh37gpIdKwOoTQSw1NlZw
	ozEszi3QzKL8yWEirCqnkOyCeqiy2oaMvqvE/y3CuIvDW2e5QnBJWyTRmCZ8VSM/bZ00K7Vs03V
	+qR1HGucqwEsQyZCInYw7Lo9wZVgGsqRYI63XLtH0RhWfU/KEQMFzMbHi/5HxSqmedNnbsyvDM7
	Djmchhr9FRNUjRgAJWNn+rZ+9m2TLbRTgJZ8r/gwkO4lU5ZbRqnNS10MiQG+U/jw0EvdjIdDo9H
	bfN+hKrqDEOFkJPplyc95rgZs4fVDLpsiLJGuLgQGBsh9sTl8=
X-Received: by 2002:a17:902:f612:b0:2c7:9e6a:1a8d with SMTP id d9443c01a7336-2c9a24512fcmr3816645ad.12.1782722899601;
        Mon, 29 Jun 2026 01:48:19 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-846de12ed24sm2482229b3a.8.2026.06.29.01.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:48:18 -0700 (PDT)
Date: Mon, 29 Jun 2026 08:48:11 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v6 3/7] iommu/arm-smmu-v3: Do not enable EVTQ/PRIQ
 interrupts in kdump kernel
Message-ID: <akIxS7kuhuLRHAMg@google.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <e643786d849d274c1d8dcfc03795f572aef812bd.1779265413.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e643786d849d274c1d8dcfc03795f572aef812bd.1779265413.git.nicolinc@nvidia.com>

On Wed, May 20, 2026 at 10:03:20AM -0700, Nicolin Chen wrote:
> In kdump cases, the crashed kernel's CDs and page tables can be corrupted,
> which could trigger event spamming. Also, we cannot serve page requests.
> 
> Skip the IRQ setup for EVTQ/PRIQ in arm_smmu_setup_irqs().
> 
> Skip their IRQ handler registration in unique-IRQ and combined-IRQ cases.
> 
> Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
> Cc: stable@vger.kernel.org # v6.12+
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 58 ++++++++++++++-------
>  1 file changed, 39 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 2d7eb42449eaf..e00b28e36f9c4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2464,7 +2464,11 @@ static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
>  
>  static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
>  {
> -	arm_smmu_gerror_handler(irq, dev);
> +	irqreturn_t ret = arm_smmu_gerror_handler(irq, dev);
> +
> +	/* In kdump, EVTQ/PRIQ are disabled and there is no thread to wake */
> +	if (is_kdump_kernel())
> +		return ret;
>  	return IRQ_WAKE_THREAD;
>  }
>  
> @@ -4963,6 +4967,21 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
>  	arm_smmu_setup_msis(smmu);
>  
>  	/* Request interrupt lines */
> +	irq = smmu->gerr_irq;
> +	if (irq) {
> +		ret = devm_request_irq(smmu->dev, irq, arm_smmu_gerror_handler,
> +				       0, "arm-smmu-v3-gerror", smmu);
> +		if (ret < 0)
> +			dev_warn(smmu->dev, "failed to enable gerror irq\n");
> +	} else {
> +		dev_warn(smmu->dev,
> +			 "no gerr irq - errors will not be reported!\n");
> +	}
> +
> +	/* No EVTQ/PRIQ interrupts in kdump -- queues are disabled */
> +	if (is_kdump_kernel())
> +		return;
> +
>  	irq = smmu->evtq.q.irq;
>  	if (irq) {
>  		ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
> @@ -4975,16 +4994,6 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
>  		dev_warn(smmu->dev, "no evtq irq - events will not be reported!\n");
>  	}
>  
> -	irq = smmu->gerr_irq;
> -	if (irq) {
> -		ret = devm_request_irq(smmu->dev, irq, arm_smmu_gerror_handler,
> -				       0, "arm-smmu-v3-gerror", smmu);
> -		if (ret < 0)
> -			dev_warn(smmu->dev, "failed to enable gerror irq\n");
> -	} else {
> -		dev_warn(smmu->dev, "no gerr irq - errors will not be reported!\n");
> -	}
> -
>  	if (smmu->features & ARM_SMMU_FEAT_PRI) {
>  		irq = smmu->priq.q.irq;
>  		if (irq) {
> @@ -5005,7 +5014,7 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
>  static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>  {
>  	int ret, irq;
> -	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
> +	u32 irqen_flags = IRQ_CTRL_GERROR_IRQEN;
>  
>  	/* Disable IRQs first */
>  	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
> @@ -5020,19 +5029,30 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>  		/*
>  		 * Cavium ThunderX2 implementation doesn't support unique irq
>  		 * lines. Use a single irq line for all the SMMUv3 interrupts.
> +		 *
> +		 * In kdump, EVTQ/PRIQ are disabled, so no threaded handling.
>  		 */
> -		ret = devm_request_threaded_irq(smmu->dev, irq,
> -					arm_smmu_combined_irq_handler,
> -					arm_smmu_combined_irq_thread,
> -					IRQF_ONESHOT,
> -					"arm-smmu-v3-combined-irq", smmu);
> +		if (is_kdump_kernel())
> +			ret = devm_request_irq(smmu->dev, irq,
> +					       arm_smmu_combined_irq_handler, 0,
> +					       "arm-smmu-v3-combined-irq",
> +					       smmu);

This `if` isn't needed, we can continue using devm_request_threaded_irq,
if you look at the doc for devm_request_threaded_irq [1] it says:

/**
 * devm_request_threaded_irq - allocate an interrupt line for a managed device with error logging
 * @dev:	Device to request interrupt for
 * @irq:	Interrupt line to allocate
 * @handler:	Function to be called when the interrupt occurs
 * @thread_fn:	Function to be called in a threaded interrupt context. NULL
 *		for devices which handle everything in @handler
 * @irqflags:	Interrupt type flags
 * @devname:	An ascii name for the claiming device, dev_name(dev) if NULL
 * @dev_id:	A cookie passed back to the handler function
[...]
*/

So, we can pass handler() here while leaving the thread_fn == NULL:

ret = devm_request_threaded_irq(smmu->dev, irq,
         arm_smmu_combined_irq_handler,
         is_kdump_kernel() ? NULL : arm_smmu_combined_irq_thread,
         IRQF_ONESHOT,
         "arm-smmu-v3-combined-irq", smmu);

(In fact that's exactly what devm_request_irq does under the hood [2])

Additionally, the arm_smmu_combined_irq_handler() returns 
IRQ_WAKE_THREAD unconditionally, which causes us to hit the warn_on[3] in
__handle_irq_event_percpu.

Hence, we'd need to refactor the arm_smmu_combined_irq_handler() to
return IRQ_HANDLED / _NONE if is_kdump_kernel().

> +		else
> +			ret = devm_request_threaded_irq(
> +				smmu->dev, irq, arm_smmu_combined_irq_handler,
> +				arm_smmu_combined_irq_thread, IRQF_ONESHOT,
> +				"arm-smmu-v3-combined-irq", smmu);
>  		if (ret < 0)
>  			dev_warn(smmu->dev, "failed to enable combined irq\n");
>  	} else
>  		arm_smmu_setup_unique_irqs(smmu);
>  
> -	if (smmu->features & ARM_SMMU_FEAT_PRI)
> -		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
> +	/* No EVTQ/PRIQ IRQ generation in kdump -- queues are disabled */
> +	if (!is_kdump_kernel()) {
> +		irqen_flags |= IRQ_CTRL_EVTQ_IRQEN;
> +		if (smmu->features & ARM_SMMU_FEAT_PRI)
> +			irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
> +	}
>  
>  	/* Enable interrupt generation on the SMMU */
>  	ret = arm_smmu_write_reg_sync(smmu, irqen_flags,
> -- 
> 2.43.0
> 

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.1.1/source/kernel/irq/devres.c#L75
[2] https://elixir.bootlin.com/linux/v7.1.1/source/include/linux/interrupt.h#L218
[3] https://elixir.bootlin.com/linux/v7.1.1/source/kernel/irq/handle.c#L225
