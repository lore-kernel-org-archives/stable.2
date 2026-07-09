Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B062673AA
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603151; cv=none; b=s3lr07rTOqp0rYSs51JOIYxEe4xfzRihI1Wc4zYZ5YFssto9/NOaGOd10CSJjuZz6REDI22kHtcDgFxWxyU8esqJO8yzTtZlbwqDFabTycyPUrnQYia1r0RqEZIv5ix5QxaD4jc1fYD8ernRGg9hoJzIFjaasN6viu0YtsSdXJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603151; c=relaxed/simple;
	bh=pyU260pXhJJC8YkHlsSC0yA64y49tWjKJthbuClAm64=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ByCgPwkVcwV/Gx02zhWhIZ4heK8PumRKU2K+B1pFSvqGDiUt1hNTc20jqsM3nwSMti11v8Reb6TN2qkTLmQ7VCdGtPSPRxq3ueimIhPgQ7ijC799CMxFfbj8MLRSwl+inYp0GL74xjTDDgo3gdx+dnkhj4DOPeRFEbcKjiSWABc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5O5fmDEa; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5O5fmDEa"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=01sbm6fVaYiiHHkJ7k1n3+ePoevqsPaJoT53HbHV54E=;
	b=5O5fmDEaomiQ+EJyla6QRBz082huhFYV38AWcOlauQHnWVZ38T+ZKsG6w2AGgt351KjsgboqZ
	rmGqSNFzo/mdm+rEeQ2TFQsNyyKQj+o5ClBb8Ndrk0lKbWo3MP0yFZjdnHRRLfKq9cJaIbpwt12
	Ixu2nf+1848XJ4bO1htVDD4=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gwwKm6L2kz1prLD;
	Thu,  9 Jul 2026 21:09:48 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 9AF3240561;
	Thu,  9 Jul 2026 21:19:05 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jul 2026 21:19:04 +0800
Message-ID: <cd801ce1-7326-49c2-a6d2-218f9e3bd670@huawei.com>
Date: Thu, 9 Jul 2026 21:19:03 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/36] arm64: hibernate: mask DAIF before restoring
 hibernated kernel
To: Vladimir Murzin <vladimir.murzin@arm.com>,
	<linux-arm-kernel@lists.infradead.org>
CC: <mark.rutland@arm.com>, <maz@kernel.org>, <will@kernel.org>,
	<catalin.marinas@arm.com>, Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	<stable@vger.kernel.org>
References: <20260709121333.23507-1-vladimir.murzin@arm.com>
 <20260709121333.23507-4-vladimir.murzin@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260709121333.23507-4-vladimir.murzin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 7/9/2026 8:13 PM, Vladimir Murzin wrote:
> From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> 
> The arm64 hibernate code manages the exception masking in an unsound
> way, leading to potential crashes and/or warnings during resume.
> 
> When a hibernation image is saved in `swsusp_arch_suspend()`, all DAIF
> exceptions are masked (by virtue of `local_daif_save()`), and the
> suspended image is saved assuming that all DAIF exceptions will remain
> masked when the image is restored.
> 
> When a hibernation image is resumed by `swsusp_arch_resume()`, only
> interrupts are masked (by virtue of `local_irq_save()` in

local_irq_disable()?

> `resume_target_kernel()`). When pseudo-NMI is enabled the DAIF.IF bits
> will be clear, and regardless of pseudo-NMI the DAIF.DA bits will be
> clear.
> 
> This means that there are two problems:
> 
> (1) It is possible to take Debug, SError, or pseudo-NMI exceptions
>     during the resume process. This is unsafe, as during the resume
>     process both the old ane new kernels will tranisently be in an
>     inconsistent state, and swsusp_arch_suspend_exit() won't retain
>     an executable mapping of any exception vectors.
> 
>     Any exception taken here will be fatal and silent.
> 
> (2) When re-entering the resumed kernel, some DAIF bits will be clear
>     unexpectedly. This permits Debug, SError, or pseudo-NMI exceptions
>     to be taken for a short period while the resumed kernel is not yet
>     in a consistent state.
> 
>     This is detected by CONFIG_ARM64_DEBUG_PRIORITY_MASKING.
> 
> Avoid these issues by masking all DAIF exceptions during resume.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm64/kernel/hibernate.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 9717568518ba..d0d9bd91e639 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -405,6 +405,7 @@ int swsusp_arch_suspend(void)
>  int __nocfi swsusp_arch_resume(void)
>  {
>  	int rc;
> +	unsigned long flags;
>  	void *zero_page;
>  	size_t exit_size;
>  	pgd_t *tmp_pg_dir;
> @@ -465,9 +466,21 @@ int __nocfi swsusp_arch_resume(void)
>  	if (el2_reset_needed())
>  		__hyp_set_vectors(el2_vectors);
>  
> +	/*
> +	 * It is necessary to mask all DAIF exceptions here as:
> +	 *
> +	 * - The copy of swsusp_arch_suspend_exit() in the hibernation
> +	 *   text cannot handle taking any exceptions.
> +	 *
> +	 * - The suspended kernel masked all DAIF exceptions in
> +	 *   swsusp_arch_resume(), and expects to be re-entered in the
> +	 *   same state : with all DAIF exceptions masked.
> +	 */
> +	flags = local_daif_save();
>  	hibernate_exit(virt_to_phys(tmp_pg_dir), resume_hdr.ttbr1_el1,
>  		       resume_hdr.reenter_kernel, restore_pblist,
>  		       resume_hdr.__hyp_stub_vectors, virt_to_phys(zero_page));
> +	local_daif_restore(flags);
>  
>  	return 0;
>  }

