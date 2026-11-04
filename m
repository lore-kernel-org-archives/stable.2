Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779577;
	b=q9DmL0HJZcUwW2TvItl/EScBhBxNjqEC8wCBU7LHQaVLvwvkF7XrAcwR2Q+oJG7xI8YV
	 33SPXObj5Q/W81jlMsM4pL5e4SlanaUHfqatnaxwBMb6e+9j/Q/QzxZKrpN7X5gM0k7s6
	 X3YHu/xz1SdOroy0EzZ3euh87AxpB8S9tqlVMyjQB8TQzOjI77WZ7NXy4u5cMTIhxGLk8
	 TYVOdYmHGiBaqrpxXxcWf4IC5ui4R169eREeedx+EEWlUqckE0ePpeTlLIGo3w1ThFlhW
	 g/kxVVSGI6nTrugztuplrXkPIAZDo0CA9GDDtOxXnZYfqJAfMjhve3CZIulkf3NYuIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779577;
	h=DMARC-Filter:DKIM-Signature:Cc:Content-Transfer-Encoding:Message-Id:
	 Received:User-Agent:X-Original-From:References:In-Reply-To:To:Date:
	 Mime-Version:X-Lms-Return-Path:Content-Type:From:Subject:
	 Content-Language;
	bh=sduOP3VW/r6BpntDuFO0P9ijMJnVNglrHxEYHPAMFGs=;
	b=rYbvPnpbIpJ5MqB9vUDA1hL67U9pLmxKr2Wk6XGJtp4D/Tag1JTc5h1Qfsl6GxJljkPl
	 TA1zaEjav4EwWRePr2B2Zf1wheWES9IYY/YmCo91mm0MfvwSulXuEYJ2WKioIR8jumtG1
	 pMN44YG6vN1xpbqAKw73VkwlyrZS0GGAQVVhPfURI0tMfImDgtu59tztYWXpZv2dElbYC
	 5nYNdsm9MPaHVGgGblLYs4UICZIyLhfGL5sjc1rv6IATu4oFdwcTiSxgYjhJp/KH65qns
	 R7eNCqVHw+cmGT4LOaCJAW54c6tCUmCDwcynd7hsPQ1JHxHqMMOnYx1iroe11J+kILA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=picoheart.com;
	spf=pass smtp.mailfrom=picoheart.com;
	dkim=pass header.d=picoheart.com header.i=@picoheart.com header.a=rsa-sha256 header.s=feishu2604151535 header.b="W2/poyEC";
	arc=none smtp.remote-ip=209.127.231.48
Received: from va-2-48.ptr.blmpb.com (va-2-48.ptr.blmpb.com [209.127.231.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA15606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 08:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CA15606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=picoheart.com header.i=@picoheart.com header.a=rsa-sha256 header.s=feishu2604151535 header.b=W2/poyEC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1793779571; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=sduOP3VW/r6BpntDuFO0P9ijMJnVNglrHxEYHPAMFGs=;
 b=W2/poyECXARfu9is4ZU+Li4KeWeaPximlH2D+qD/TtRq5pFs1hXguohrDoTv1QWajIW5bE
 bWHGMG3A38jijTz83NfkZL3Pjn0ZD8cxzuwiLiXl2U0dFvlBU+XcHz8qkl32oAvv3HfK60
 FUJnM3Zs4xMx6vor1GOKrQq/BBEGresZkX5H1vS8bbQQlIPpX8d9EvgcntG2PJuU+ikNTM
 ybnyQIulSG7ks+IUOMg/UM5P007X1Io74MBRw9ASOO5CKOFRVHUZ5PblRJ/Axi66s+I3Re
 zEyGK/bX70o+82tz7jD0IzEl+XJqRybW6elVag0fk5w6JHlWlEbDNnJ0+RMQOg==
Cc: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, 
	<alex@ghiti.fr>, <zong.li@sifive.com>, <wangruikang@iscas.ac.cn>, 
	<debug@rivosinc.com>, <qirui.001@bytedance.com>, <guoziyi114@gmail.com>, 
	<samuel.holland@sifive.com>, <ben.dooks@codethink.co.uk>, 
	<cyrilbur@tenstorrent.com>, <linux-riscv@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, <yang.yicong@picoheart.com>, 
	<stable@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <b8f28bee-83d6-4566-889d-6119e2837ddb@picoheart.com>
Received: from [100.86.223.207] ([61.141.241.106]) by smtp.feishu.cn with ESMTPS; Wed, 04 Nov 2026 16:05:58 +0800
User-Agent: Mozilla Thunderbird
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
References: <20261022083212.84721-1-cuiyunhui@bytedance.com>
In-Reply-To: <20261022083212.84721-1-cuiyunhui@bytedance.com>
To: "Yunhui Cui" <cuiyunhui@bytedance.com>
Date: Wed, 4 Nov 2026 16:05:55 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26aeae767+147470+vger.kernel.org+yang.yicong@picoheart.com>
Content-Type: text/plain; charset=UTF-8
From: "Yicong Yang" <yang.yicong@picoheart.com>
Subject: Re: [PATCH] riscv: Fix SR_SUM leakage across context switches
Content-Language: en-US

On 10/22/26 4:32 PM, Yunhui Cui wrote:
> __switch_to() saves the sstatus value of prev and restores the SR_SUM bit
> of next with csrs. However, csrs only sets bits. If prev has SR_SUM set
> and next has SR_SUM clear in its saved state, the old SR_SUM bit remains
> set in sstatus.
> 
> This lets next run with user memory access enabled even though its saved
> SR_SUM state is clear.
> 
> Use csrrc to save the sstatus value of prev and clear SR_SUM from the
> live CSR before restoring the saved SR_SUM state of next. This keeps
> prev's SR_SUM state intact, while preventing it from leaking to next.
> 
> Fixes: 788aa64c01f1 ("riscv: save the SR_SUM status over switches")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

a straightforward fix :)

Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>

> ---
>  arch/riscv/kernel/entry.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 61b7a77166971..628b85e3915a7 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -443,15 +443,15 @@ SYM_FUNC_START(__switch_to)
>  	REG_S s10, TASK_THREAD_S10_RA(a3)
>  	REG_S s11, TASK_THREAD_S11_RA(a3)
>  
> -	/* save the user space access flag */
> -	csrr  s0, CSR_STATUS
> +	/* Save and clear the user space access flag. */
> +	li    s1, SR_SUM
> +	csrrc s0, CSR_STATUS, s1
>  	REG_S s0, TASK_THREAD_SUM_RA(a3)
>  
>  	/* Save the kernel shadow call stack pointer */
>  	scs_save_current
>  	/* Restore context from next->thread */
>  	REG_L s0,  TASK_THREAD_SUM_RA(a4)
> -	li    s1,  SR_SUM
>  	and   s0,  s0, s1
>  	csrs  CSR_STATUS, s0
>  	REG_L ra,  TASK_THREAD_RA_RA(a4)
