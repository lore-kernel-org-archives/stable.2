Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16465425CC6
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746130; cv=none; b=IZwR7icbWbD8ZRjuyHNN/rH3J81snGV7vQ02QYd47W/NzA7czfAfdHEb6maeapQs/v5FdZ1QIiH/eEwb79uBPu2pCKhVrZeThmLp4nda8IGyRvNOxz573KEgMHjom47nswkeuNZUt5Rm8xoP/9un2D+uwOG14ohy3e4b2T9n1+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746130; c=relaxed/simple;
	bh=af20jhog62oBC86VKU1xoF2h/kpAYcLB6qGZDThBzQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V213nU6K8n4JFe6Kxq01IozVvjCe4dv3ZefmpYlE8wLz7oXuFQ2YisSPm7D2vJnbnCgBH6p8ZFOUb+R0YjrH2yX9HpaTwLp4NZFeUqE5HcyeDqAJ3L37OxAzRSHdvZhH66YPxlPd3EziOSpGTag7um72tAKPCqjqWUMbTA0+EZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X56qzsVR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X56qzsVR"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c81db32393so96055ad.0
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 08:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782746128; x=1783350928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UPSjr9JU+pCYrEmDJ7OVpfKAUb1nOpu7R28XymotIVY=;
        b=X56qzsVR/oOIdXUx9ePC4tXSB88Jr2QwO5TQ3emsT4XLGnw0aA+/xIQCBY38if4QrE
         uw/juGKNm1Jj9zKjaQvWaXtzzFy8RyqxGEJg1SYbYPVrS3HqRWayIFhKhsX3qE0TUOOy
         QvF5IVv1ebb9X98wMmi9Raado0nBM4MRi30lOkEJcCkzPpeoh02N+dp7gjMYo4QNynge
         97kQeKRbsgiNdcthNXzNrEz8yT2JAfjktUs5I96N7kOSeHQYoBGMdLUHxOLSMkxn7hkX
         Vm3sVsd4UXS4/OnFKUTW6DKmWI2WMMrUoc1zjiuTk9bfWhC85QKb4jwH+qG5wrjr/R6o
         wbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782746128; x=1783350928;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UPSjr9JU+pCYrEmDJ7OVpfKAUb1nOpu7R28XymotIVY=;
        b=FsZxUzwPi6WeCAU+zYn4k6jS8u9sdGDRFMHQrIUxQFa9wmqABl6lTRTIVRSC3GYFQL
         +mBLLLPxohBzoiSBKx3wnPp45NghKXtMpQ2XA34SvRJws3lebscxP42kK2LvN1zSu4oG
         6Fmr7Sbge4SXqoQwXHKRqiXglcbDgybXOPOVIJWzfxF8RS0e4bRrFXn4gKf8rcK8kmDu
         55pVBwMaEu2iIHzSP/ftsQj6cNf2WN4PTEh9TVv+Lep7OyWTWbj3ppbd3Xm226NwR/wS
         GM8ahudv2kH8QJ63vh7S+bwZ6ZgKVOICzfQ7B5x8frP0eV8FISy1Vg0S1SETYKFIn7Uv
         HgYQ==
X-Forwarded-Encrypted: i=1; AHgh+RrjcBV/+F/QHwBwWjokEvSlEk858J+nfkljc4XCrCmNClNvWLZn8rkfdehkh79wOmszYZiBFF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxepc2I5sL+C2hekt7Dg8K03fK2rR1xaXMUP9HMAwE6BvyMP3ur
	TlGtEyZZux8G3QUY4e6TDwGomqDSWvCHZjmYmpYomV6PeE0KLAIzRwTyVmwO3raBfQ==
X-Gm-Gg: AfdE7cl7H8O0SeR5M9liGFgJbKyIFhFXElIUvw7Yic0KMrqkCCFTlifcQJSuuf8RNyo
	WS48anGOo4XOn5J8ANqgnb2RRrqvkeOJVF/TlGSzcZPHK5a4UBO9gQJIhKCwTTQ1KxnkgQpw831
	l7J0DIMuEcSzBDIyR38A/vXUohzJL1LDJyjq0vjt7OVDtqeTCNHdd55oD209tjRfNZISY+v1+lG
	dpSsjQk9bKknmwTjz0F4A3hxG2Ux1HUIfz3OKzLb/1CI4JAODK5h+eysM0+SmfSQiFzwBcC14Lj
	a8LT77O+9pF4SbVors8RNRdoZvx4zD9XsNUo3SLVj9MFMSS7RF9jraG2BLWoS3q5L6RnacszEJQ
	Kbj8qliKiNwrmZKeir91K3PZpJRbqeH6/ArHntjKen8SlhIZ5uvVezMc2NHOZ/f15LIAB6/uRTL
	qZERlHTijuFvQP7hs07i0AM9rN+WtqXznYapMTiJC198PNsIk=
X-Received: by 2002:a17:902:e5c1:b0:2c7:b1e7:501e with SMTP id d9443c01a7336-2ca2ce7f8b4mr86255ad.3.1782746127572;
        Mon, 29 Jun 2026 08:15:27 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c9b0992227sm50676885ad.37.2026.06.29.08.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:15:26 -0700 (PDT)
Date: Mon, 29 Jun 2026 15:15:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v6 4/7] iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in
 kdump kernel
Message-ID: <akKMCYsdH4lVSyf7@google.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <1280ac4fdb37f998fd6dcb2bf8f4437283279395.1779265413.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1280ac4fdb37f998fd6dcb2bf8f4437283279395.1779265413.git.nicolinc@nvidia.com>

On Wed, May 20, 2026 at 10:03:21AM -0700, Nicolin Chen wrote:
> In kdump cases, the crashed kernel's CDs and page tables can be corrupted,
> which could trigger event spamming. Also, we cannot serve page requests.
> 
> Skip the EVTQ/PRIQ setup entirely rather than enabling then disabling them.
> 
> Also add some inline comments explaining that.
> 
> Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
> Cc: stable@vger.kernel.org # v6.12+
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 43 +++++++++++++--------
>  1 file changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index e00b28e36f9c4..3f22949391c82 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -5161,21 +5161,35 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  	cmd.opcode = CMDQ_OP_TLBI_NSNH_ALL;
>  	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
>  
> -	/* Event queue */
> -	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
> -	writel_relaxed(smmu->evtq.q.llq.prod, smmu->page1 + ARM_SMMU_EVTQ_PROD);
> -	writel_relaxed(smmu->evtq.q.llq.cons, smmu->page1 + ARM_SMMU_EVTQ_CONS);
> -
> -	enables |= CR0_EVTQEN;
> -	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> -				      ARM_SMMU_CR0ACK);
> -	if (ret) {
> -		dev_err(smmu->dev, "failed to enable event queue\n");
> -		return ret;
> +	/*
> +	 * Event queue
> +	 *
> +	 * Do not enable in a kdump case, as the crashed kernel's CDs and page
> +	 * tables might be corrupted, triggering event spamming.
> +	 */
> +	if (!is_kdump_kernel()) {
> +		writeq_relaxed(smmu->evtq.q.q_base,
> +			       smmu->base + ARM_SMMU_EVTQ_BASE);
> +		writel_relaxed(smmu->evtq.q.llq.prod,
> +			       smmu->page1 + ARM_SMMU_EVTQ_PROD);
> +		writel_relaxed(smmu->evtq.q.llq.cons,
> +			       smmu->page1 + ARM_SMMU_EVTQ_CONS);
> +
> +		enables |= CR0_EVTQEN;
> +		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> +					      ARM_SMMU_CR0ACK);

Nit:
I believe only the write_reg_sync(CR0) should be under this if condition
do we see any weird behavior if we perform the reg writes in
kdump_kernel?

> +		if (ret) {
> +			dev_err(smmu->dev, "failed to enable event queue\n");
> +			return ret;
> +		}
>  	}
>  
> -	/* PRI queue */
> -	if (smmu->features & ARM_SMMU_FEAT_PRI) {
> +	/*
> +	 * PRI queue
> +	 *
> +	 * Do not enable in a kdump case, as we cannot serve page requests.
> +	 */
> +	if (!is_kdump_kernel() && (smmu->features & ARM_SMMU_FEAT_PRI)) {
>  		writeq_relaxed(smmu->priq.q.q_base,
>  			       smmu->base + ARM_SMMU_PRIQ_BASE);
>  		writel_relaxed(smmu->priq.q.llq.prod,
> @@ -5208,9 +5222,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  		return ret;
>  	}
>  
> -	if (is_kdump_kernel())
> -		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
> -
>  	/* Enable the SMMU interface */
>  	enables |= CR0_SMMUEN;
>  	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> -- 
> 2.43.0
> 

Apart from that nit, 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
