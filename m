Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3787122097
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 03:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654858; cv=none; b=eRxV1Wc1ODzmrdUpo3/St/S5VLksB5mt36XaWuku+SHGk+RJb47qowx9QTVLsKryUArASc8QcWawXYovEL1A2iTfz03agKxRPTWeU5JIKUsVMj8MWHiG7pagvZRF7YEeY1u5YcJLXZ3T+YYWxKCRgOxnmDWvZOnD/WNI838f6xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654858; c=relaxed/simple;
	bh=N8Ql/R2KyV13fTGjhJAlvYvaMr0kaRtJZ+kgkyK80QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sx8enNsn6KDbgu7HLe0iaKtpP9oOeKJxG7bxb+FAwFpIj/3tP7hI+SYzoBlEr01uP8sYeaSLDwx0BWnDB4vBK2KuuhsmBfipfF2LLIfaa7WEH+3eOzUs9H4xI1WEdpf41/ABjCL58kSbOjwigwyLPUdayj0SDdRNZ29UArNYPQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=glSw8Dx9; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=glSw8Dx9; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="glSw8Dx9";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="glSw8Dx9"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iTljOFKYJBI33ZEI0JX671u45JXFShPIM4aeNDpDwv0=;
	b=glSw8Dx9Mzy1CL32Fk+FBH40Il6zPAuD1Q137P883L3KsqBedtUB5HPKpNDKcuua5jfShM1jF
	Ncgz0lq6wkOMr2Ez7I/Mgtx0Q6ZrVMvw47Hh/GkzSvfcmTHTHMM+wW2xeKuBzUrO/8lBvYVhEkX
	BvFMKYabhqI25nUDMEp6TI4=
Received: from canpmsgout04.his.huawei.com (unknown [172.19.92.133])
	by szxga04-in.huawei.com (SkyGuard) with ESMTPS id 4gxHfC696dz126Lt5
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 11:40:19 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iTljOFKYJBI33ZEI0JX671u45JXFShPIM4aeNDpDwv0=;
	b=glSw8Dx9Mzy1CL32Fk+FBH40Il6zPAuD1Q137P883L3KsqBedtUB5HPKpNDKcuua5jfShM1jF
	Ncgz0lq6wkOMr2Ez7I/Mgtx0Q6ZrVMvw47Hh/GkzSvfcmTHTHMM+wW2xeKuBzUrO/8lBvYVhEkX
	BvFMKYabhqI25nUDMEp6TI4=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gxHRx09Gpz1prKZ;
	Fri, 10 Jul 2026 11:31:25 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 2532340537;
	Fri, 10 Jul 2026 11:40:42 +0800 (CST)
Received: from kwepemq200011.china.huawei.com (7.202.195.155) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Jul 2026 11:40:41 +0800
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemq200011.china.huawei.com (7.202.195.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 10 Jul 2026 11:40:41 +0800
Message-ID: <2410686c-bc58-44a0-9f71-ec79791daaa6@huawei.com>
Date: Fri, 10 Jul 2026 11:40:40 +0800
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
CC: <mark.rutland@arm.com>, <maz@kernel.org>, <ruanjinjie@huawei.com>,
	<stable@vger.kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>
References: <20260709121333.23507-1-vladimir.murzin@arm.com>
 <20260709121333.23507-4-vladimir.murzin@arm.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20260709121333.23507-4-vladimir.murzin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq200011.china.huawei.com (7.202.195.155)

在 2026/7/9 20:13, Vladimir Murzin 写道:
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

As Jinjie said, the resumed kernel never return from hibernate_exit(). If that's
the case, it seems better to place unreachable() rather than local_daif_restore(),
would you agree?

>  
>  	return 0;
>  }


-- 
BR
Liao, Chang
