Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794995920;
	b=q2TRzneMl/R+voqQa+yQKiGx333nLsUuep/XgSFOeuwiwNXXg6ysjUcRQ09VXggRFfHg
	 buJr2JsI7bWxXlQrw6jJQNRBrrz0T6Cebgwf9/wdDHEFfietJRmBZIbRWGEN/jSb9+ci0
	 oLo1KJwrgtLpClszasgSlheIKPw9eRlNsf6TntFQJgXXs1Fg5wHQrOLFIXlbenUU8zGz3
	 dT1bO8PDUdU4OK14aOMeYw+BtuKK/vSw+tB4qtg1Wrws6ajD5QVVmMeYxPzL54GUIwvmu
	 VDWwRzP7iF6SJ3FoNlM3bPRgAjcBPoLuNotb5Pm3qCRDHKTwPM4EtzC22ss4sU47U4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995920;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=fMIYl75aZu7vrGQvT2vVO2us1bwVx5ztzHE8ICinsSc=;
	b=sXtzRWOH3TKWh/tv/bxFfOvwZsbHX+Ttui/nzM58W/xtSSd/j9uhvGBrkMxx29QuF3YH
	 QD9Lf4d7BXGnR4gW9DFDBei3JMymTOkiYzLw018fAEhgOapY7z0ipAD5PdfB/OVa8cJje
	 64JzaGUEjSe6QJ3HVqWaWB861DVOsRkZESdAynhe+HE7b3bcjyW7jbD4Tnj1pGQgYT+jn
	 +u3QLf19fKzEpYw2hLL7yn6MqlqvgyNL2yyNqZ7t+CDxG/t1NCqYaxcumlAAysbpYVsEy
	 DAiXvF+5wHXLYA5kQZGsHzp8tXb+3JIvKFBKo3G83lkPPMerazv5JUuUv9rIIn7tZig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=u8C6HlpO;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF29606A31C;
	Wed, 18 Nov 2026 09:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFF29606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=u8C6HlpO
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 094991596;
	Wed, 18 Nov 2026 01:58:36 -0800 (PST)
Received: from [10.0.154.42] (e121487-lin.cambridge.arm.com [10.0.154.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3AB03F673;
	Wed, 18 Nov 2026 01:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794995918; bh=TABkyzRDh8je8alNY8PpqIpwdxSTGCUGrmil5Y9DvPY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u8C6HlpOlYHwe4Wb68OnPYyW96TJkAbEjRxjwxYwQMNdgxkF7Ilr+2RVrUoWUhRzv
	 JpqkgRZ1HYh0dsGylGeAzFWpHtxsM7nHut5EFSPjYRLFLqcFzXz1sOpC54b5czkDOZ
	 eUsNG3ydx9ZFkvt7zuWmkbTlV7G3KEUsA8A4FRKA=
Message-ID: <628b2774-30bc-4399-98c3-2d99ad5090b6@arm.com>
Date: Wed, 18 Nov 2026 09:58:34 +0000
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
Subject: Re: [PATCH 2/3] arm64: entry: sdei: save and restore PMR for
 pseudo-NMI
To: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Kiryl Shutsemau <kas@kernel.org>,
 Breno Leitao <leitao@debian.org>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Doug Anderson <dianders@chromium.org>, Linus Walleij <linusw@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Huth <thuth@redhat.com>,
 Dawei Li <dawei.li@linux.dev>, mrigendrachaubey
 <mrigendra.chaubey@gmail.com>, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261117174814.95936-1-ada.coupriediaz@arm.com>
 <20261117174814.95936-3-ada.coupriediaz@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20261117174814.95936-3-ada.coupriediaz@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ada,

On 11/17/26 17:48, Ada Couprie Diaz wrote:
> If using pseudo-NMI, PMR must be saved and restored on exception
> entry/exit. We do so, and set it to a known value reflecting that DAIF
> is masking all interrupts, in the regular entry path.
> 
> Do the same for SDEI, as it can interrupt the kernel at any point
> and does not mandate firmware to touch PMR, but does mandate masking DAIF.
> This avoids potentially returning with a different PMR than interrupted,
> and SDEI having the DAIF/PMR pair in a unexpected state compared to
> the rest of the kernel.
> 

I think we need to save/restore PMR into/from pt_regs similarly to regular
entry path, otherwise regs_irqs_disabled() is still broken, like it was
pointed in the thread [1] (and Sashiko has raised the same concern on
FEAT_NMI series)

Cheers
Vladimir

[1] https://lore.kernel.org/all/auzM-l40BLsT3clg@arm.com/

> Fixes: 133d05186325 ("arm64: Make PMR part of task context")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> ---
>  arch/arm64/kernel/entry-common.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index cb122163a68d..17a14c55532c 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -1041,7 +1041,7 @@ asmlinkage void noinstr __noreturn handle_bad_stack(struct pt_regs *regs)
>  asmlinkage noinstr unsigned long
>  __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
>  {
> -	unsigned long elr, spsr, esr, far, vbar;
> +	unsigned long pmr, elr, spsr, esr, far, vbar;
>  	irqentry_state_t state;
>  	unsigned long ret;
>  
> @@ -1067,6 +1067,16 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
>  	else if (cpu_has_pan())
>  		set_pstate_pan(0);
>  
> +	/*
> +	 * Regular kernel entry saves and resets the PMR to align with DAIF,
> +	 * but __sdei_asm_handler() does not ; do it now.
> +	 */
> +	if (system_uses_irq_prio_masking()) {
> +		pmr = read_sysreg_s(SYS_ICC_PMR_EL1);
> +		write_sysreg_s(GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET,
> +				SYS_ICC_PMR_EL1);
> +	}
> +
>  	/*
>  	 * Nothing saved the interrupted context's exception registers on the
>  	 * way in, and it may be in the middle of exception entry or return
> @@ -1110,6 +1120,9 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
>  	write_sysreg(far, far_el1);
>  	write_sysreg(vbar, vbar_el1);
>  
> +	if (system_uses_irq_prio_masking())
> +		write_sysreg_s(pmr, SYS_ICC_PMR_EL1);
> +
>  	return ret;
>  }
>  #endif /* CONFIG_ARM_SDE_INTERFACE */
> -- 2.43.0
> 

