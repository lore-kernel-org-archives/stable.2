Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600218;
	b=okpMw/t33Lczcp+aberhgfqKSPGRUbQhq8xgbgodFvMJnqi5/5BGJeVb1L8tdpryPMQ8
	 Zy66XS90cGjUzBoPPZO+EA5Dkdem/4kcBMGFtmO5N/GNhrlZP4liCM/+ixg+P/hpLeiau
	 pAScF2F5VDaK2TDtk9DyNDwNAc+IF1YYd6YEZNq8c0mh79ZfcGbSXIaXqk+nP2EQcLDQz
	 Yu7dfQE/BR21VoB56rxNvyBdxV2Gl2wmmquNA+twzNtVaEwsRMGTrEzgPepIuVwokSnUf
	 DxTwnRuQKx0uPFXL2cmFrpr9B3cdwGepkAtvwCnS0iiuLHRy4IdmSjVyGsEqJDsnOEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600218;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=+GyNRtfZ/Gg5nfOosKfBbKBMYuMaQdy/cTWEDlpckSg=;
	b=PuremZpvPjQ9Am3K8nLlWoQMVjFDxOPG3zHrybpDP2aP9T0iW6MhR+Yl7S/k54RsxtnH
	 BGAox0NZZ8RclISSZnQqHv73ErKTj1n3uBS11uesYvsSBlGpxeNTASHVc6i3dJj8ATXCh
	 8kswQxyWtump0HN/wwgnH25ghOKL9R1Fu2j7Hwi6fBPIfGvmRgBM+e9ONyGdEpCkoI34S
	 mF4US+bJkAFOl3+SQPwK5XUOqZXs342VRw8p+ZGf2Kkp9CR7KfEfVI2nUGqp4WEaXVmhe
	 fmhJJVUCRVB2bWfo52HMgPStlDlwlQKwHVq7t24BZmQh8fVZCqZzcVz63c4xnbSqr9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Y6deO8Fg;
	arc=none smtp.remote-ip=115.124.30.97
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE403606A32A;
	Wed, 25 Nov 2026 09:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE403606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Y6deO8Fg
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795600213; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=+GyNRtfZ/Gg5nfOosKfBbKBMYuMaQdy/cTWEDlpckSg=;
	b=Y6deO8FgNllLxoFH3+M27EDXm1UclgpprBtkzeh5Uspf0m75FWhZe4I/Ch15MxInvQSsVMS0WTLPRyGVV5qwOp8zIAo1+792tP+z3aM9Pq7fzNSAwFHBt8zmfuoNIznHltQF/nIO5X01wfIYIAWcCzMtc3680mtXazPgY5hBYuM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=fengwei_yin@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0XFRAeUe_1795600210;
Received: from U-V2QX163P-2032.local(mailfrom:fengwei_yin@linux.alibaba.com fp:SMTPD_---0XFRAeUe_1795600210 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 17:50:12 +0800
Date: Wed, 25 Nov 2026 17:50:10 +0800
From: YinFengwei <fengwei_yin@linux.alibaba.com>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Liao Chang <liaochang1@huawei.com>,
	Ashok Raj <ashok.raj@oss.qualcomm.com>,
	Doug Anderson <dianders@chromium.org>,
	Pengjie Zhang <zhangpengjie2@huawei.com>,
	Cong Wang <cwang@multikernel.io>, kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] firmware: arm_sdei: Do not signal event 0 to a
 masked PE
Message-ID: <awavUsKX4XLRMbUq@U-V2QX163P-2032.local>
References: <20261124194707.1030653-1-kas@kernel.org>
 <20261124194707.1030653-2-kas@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124194707.1030653-2-kas@kernel.org>

Hi Kirill,

On Tue, Nov 24, 2026 at 07:47:04PM +0000, Kiryl Shutsemau (Meta) wrote:
> The SDEI NMI backtrace signals event 0 to every other CPU, idle ones
<snip>
> +static void sdei_block_signal(void)
> +{
> +	struct sdei_pe *pe = this_cpu_ptr(&sdei_pe);
> +	unsigned long flags;
> +
> +	/*
> +	 * A panic from an SDEI event or a pseudo-NMI may have left the lock
> +	 * held by this CPU. The CPUs that could signal it are stopped by now.
> +	 */
> +	if (panic_on_this_cpu()) {
> +		WRITE_ONCE(pe->unmasked, false);
If the panic didn't take the lock, should lock be taken
just like "else" path?

> +	} else {
> +		raw_spin_lock_irqsave(&pe->lock, flags);
> +		WRITE_ONCE(pe->unmasked, false);
> +		raw_spin_unlock_irqrestore(&pe->lock, flags);
> +	}
> +
> +	sdei_wait_in_flight(pe);
> +}
> +
>  static int sdei_pm_notifier(struct notifier_block *nb, unsigned long action,
>  			    void *data)
>  {
> +	struct sdei_pe *pe = this_cpu_ptr(&sdei_pe);
>  	int rv;
>  
>  	WARN_ON_ONCE(preemptible());
>  
>  	switch (action) {
>  	case CPU_PM_ENTER:
> +		/*
> +		 * Leave alone a PE that is masked already: before
> +		 * sdei_cpuhp_up(), or after sdei_cpuhp_down(), as cpuidle runs
> +		 * until CPU_OFF. CPU_PM_EXIT must not unmask it.
> +		 */
> +		if (!pe->unmasked)
I am wondering whether READ_ONCE() should be used here?


Regards
Yin, Fengwei

