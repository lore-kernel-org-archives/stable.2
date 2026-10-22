Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668527;
	b=maX/QQL57fFAwJonwFysGUzON7ymv9fx7TZAY5W/4j/+hK5tRlDzGMlAr56C0cs0hccD
	 Adxve5PSZb5St1xkIR7c1rLi5dKvRVlQEbmv0HE8PO3JpYA6UskxW+aU2FhfUShkJIh2X
	 6Cl3YF3+aWjQc3qLc6U/M7K6i2Y1aF3gIRmLEi+81QAWtZvyTCvsVGsUk5lIr2RQrs8tM
	 M+5oKJmZa/s7JVg7HRkSbKDh/CrqrHnYn0xths80ZcoGrndIemITSWfcHKyB9WnLELEUV
	 4wSEJJunJB4h959S6O7sK1Wt+7WBfs9vMovHIr0YTDHllToHOm3vSwSidwLbPX3H1iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668527;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=X+uTy5UwL80tB9FDgwbsYL1qPK+BRoTAXASC5ApenoE=;
	b=t8weAWO6lrTQEA+gkRGNsKx+R1AZSTUl7LzbntP+nL+yqPCYOeGDbbjt9Q5FN6cpbEhv
	 Qb80vw31C1Sdthp6YkkrbITGKuN3bj34Z3GazqV6dJ0GZqEa04sG537x/qweODRDtw7i0
	 Sp/xK6h+jwgKMHSuE9jMI5BMXzhNGO7h4BbTBhpCWX9vk1KjfEEoNB1pGolYShcV63OyF
	 lmBICzseCzepQXTXV2hx+qbIzcCVCbvvhT27HlNQ9UZrarQQQXifreNE/18NyMDkLNVO5
	 6XRlbURj6nOlPqClfsSV5p6mNg9xQTn3Y2VcmwelGxIiS9+fWTfuj4Mt/72XTgJA9SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S38n80tY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF536606A319;
	Thu, 22 Oct 2026 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S38n80tY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47EC1F000C1;
	Thu, 22 Oct 2026 11:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792668526;
	bh=X+uTy5UwL80tB9FDgwbsYL1qPK+BRoTAXASC5ApenoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S38n80tY6Zrqc+C9bHVJ6Ov279IARItkHIQj/Zk/GYPSvNq5C8kw4gabZ4bOZEdv7
	 eKEHVedT5vIAGy8q6jBPXZDXjHu7D/pWSEP4sFSOTiLb0tXHnufGwiR2iFKsVe+7UE
	 CaH9fdTd9FFx/rwsyxBB1vvVB11mUbka2K3KOapYFWycnBrmlKV4bNr4OA0zA1d7gU
	 ohZgRH0M54Uf6pTWwtRZIMYxbZdzKWrUz71GQlPjTDGaRXM4LzhTk4aucyAtgbgDqM
	 6kF0y9A3vdY8raLvFPKJ+aZ4thNMglMmo4yt94EkSSwwnJ/EVE1z66y1M9cbKgiM1c
	 g6p8725Z/ZMmQ==
Date: Thu, 22 Oct 2026 19:08:39 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, zong.li@sifive.com, wangruikang@iscas.ac.cn,
	debug@rivosinc.com, qirui.001@bytedance.com, guoziyi114@gmail.com,
	samuel.holland@sifive.com, ben.dooks@codethink.co.uk,
	cyrilbur@tenstorrent.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix SR_SUM leakage across context switches
Message-ID: <atnut7gKRKzDoqBf@xhacker>
References: <20261022083212.84721-1-cuiyunhui@bytedance.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261022083212.84721-1-cuiyunhui@bytedance.com>

On Thu, Oct 22, 2026 at 04:32:12PM +0800, Yunhui Cui wrote:
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

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
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
> -- 
> 2.39.5
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
