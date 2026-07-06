Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15C447DF91
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783373501; cv=none; b=SLiZe0nvv5iRNE7NEOkNmFRql7MwaCitl/IqHF6D7c293LAnGOW4cPWSHPBcIlPf9EVKcwPbjPv/5Vt0fOIazMFx8Ie+WdnW/U0dKnYAZLaZopkiGNx8ZevNufvP6mqT+NlDbB3stzYs/wylK0gzk/i7hg3p73b9fp867R5a5ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783373501; c=relaxed/simple;
	bh=gIEgmpBmmVS11WSNffYfGjf/wazL67qccBpRaTidqd0=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=GZ4RXWUUvVcXRpSXm0yc+a6fhTfOfFBk6/cNHYBuU+w/GSZL6dmeWU1uv4Lftyeg26RQCbUjk9ES57hzim48Q4Zzi6IZLUQO5hDlIp8IhAE2GknfEplykP1BFyODg0gFnO0lcBkoeWAncaOWMJOP52lYe51ajS0s10THZSX+uKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o4wVfLC/; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o4wVfLC/"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-495b8b30310so4057432b6e.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783373498; x=1783978298; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ztXhPiC5C0Bq1auzB2bcnsLF7iN1phawknwlOjPpe6k=;
        b=o4wVfLC/5/2uotZTDxoV7GZb9a3NrNyveHze2nsdvXnKiZwg1F+Xtop7qAhXyU0RU2
         1srmJipSMr2d0nPj+eUsgnkqAoCYYh+2TrWfDRf9ujA/1bl2AEs9lpzMb3f/4AbIsEfF
         4DGXM0pi0tbvAOURFDB3crO752HvVGKTBMb5r+TzPKhr4eXHe7L+9HTZZURRagFUACg4
         ohLDzDMGLnVgloUPg33j/p2BT47hvKxeYIOu0GM+VKtHrkqFovxnIHmBulLokTFxMzPw
         IKOc7RGJQmbWrlVeQbQtzz8kbaDxDEUKP3gKYDlenmbQVBQL7rUsjdv4RQGiNDGo94OB
         8GDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783373498; x=1783978298;
        h=content-type:cc:to:from:subject:message-id:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ztXhPiC5C0Bq1auzB2bcnsLF7iN1phawknwlOjPpe6k=;
        b=iWnIK9SBl85G4ocfPc4xtvokR588eaeRNdolwgIS4xcyCrlZnXkaCVGjoF8oiX/MmV
         Rfg/7XsZxpTqYtXuuxo1GEU2Y7PRWdd4cuOVkRLMytx2YO6CY2385LzgpOjR0gSlrQ0B
         +Fv534ag7AeIP0cyZ+ircPoy4bKdm4ozaImEDKtBTqO4gNxW/ZcnU3Pwj5itl7f8kxEx
         Q2aGXaWJAHhI2l82Ka8WTnPO2JopjewYvxcR8GgtcUXiHxDMK9vDUYDVKQZO6n4Cz9Eu
         1MDXwhA3mX47mJmsqibDWEXrxirr7l6eYcUVvg7czyKFp6IcWfWrFuffwsBasLcS66yf
         0rLg==
X-Gm-Message-State: AOJu0YyUu4QgbSjlNeveTz29AwUykt5lAUv330yga2w+KiV3cK70wOBS
	SFzOnoNnSB39+WkP9mQdJoiGV1qsKdcvRicyCAo28tKedkEZPghlpliFohJA3bgcnIXQbuyFXNd
	90/wjVs4RDkv8ScXORIBazcEKiA==
X-Received: from jaar22.prod.google.com ([2002:a05:6638:c096:b0:5e7:3ea0:602c])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:5383:b0:495:ff85:d33d with SMTP id 5614622812f47-49fdc55800amr2041656b6e.12.1783373497444;
 Mon, 06 Jul 2026 14:31:37 -0700 (PDT)
Date: Mon, 06 Jul 2026 21:31:36 +0000
In-Reply-To: <akWmqLQ31UvRLCxt@kernel.org> (message from Oliver Upton on Wed,
 1 Jul 2026 16:45:44 -0700)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntpl0z6c07.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 4/5] KVM: arm64: Initialize HCR_EL2.E2H early
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oupton@kernel.org>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, mizhang@google.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, mark.rutland@arm.com, ahmed.genidi@arm.com, 
	ben.horgan@arm.com, leo.yan@arm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Oliver Upton <oupton@kernel.org> writes:

> On Wed, Jul 01, 2026 at 08:43:41PM +0000, Colton Lewis wrote:
>> From: Mark Rutland <mark.rutland@arm.com>

>> [ Upstream commit 7a68b55ff39b0d2dcd92ee241b12b23a7e03c621 ]

>> On CPUs without FEAT_E2H0, HCR_EL2.E2H is RES1, but may reset to an
>> UNKNOWN value out of reset and consequently may not read as 1 unless it
>> has been explicitly initialized.

>> We handled this for the head.S boot code in commits:

>>    3944382fa6f22b54 ("arm64: Treat HCR_EL2.E2H as RES1 when  
>> ID_AA64MMFR4_EL1.E2H0 is negative")
>>    b3320142f3db9b3f ("arm64: Fix early handling of FEAT_E2H0 not being  
>> implemented")

>> Unfortunately, we forgot to apply a similar fix to the KVM PSCI entry
>> points used when relaying CPU_ON, CPU_SUSPEND, and SYSTEM SUSPEND. When
>> KVM is entered via these entry points, the value of HCR_EL2.E2H may be
>> consumed before it has been initialized (e.g. by the 'init_el2_state'
>> macro).

>> Initialize HCR_EL2.E2H early in these paths such that it can be consumed
>> reliably. The existing code in head.S is factored out into a new
>> 'init_el2_hcr' macro, and this is used in the __kvm_hyp_init_cpu()
>> function common to all the relevant PSCI entry points.

>> For clarity, I've tweaked the assembly used to check whether
>> ID_AA64MMFR4_EL1.E2H0 is negative. The bitfield is extracted as a signed
>> value, and this is checked with a signed-greater-or-equal (GE)  
>> comparison.

>> As the hyp code will reconfigure HCR_EL2 later in ___kvm_hyp_init(), all
>> bits other than E2H are initialized to zero in __kvm_hyp_init_cpu().

>> Fixes: 3944382fa6f22b54 ("arm64: Treat HCR_EL2.E2H as RES1 when  
>> ID_AA64MMFR4_EL1.E2H0 is negative")
>> Fixes: b3320142f3db9b3f ("arm64: Fix early handling of FEAT_E2H0 not  
>> being implemented")
>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> Cc: Ahmed Genidi <ahmed.genidi@arm.com>
>> Cc: Ben Horgan <ben.horgan@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Leo Yan <leo.yan@arm.com>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Oliver Upton <oliver.upton@linux.dev>
>> Cc: Will Deacon <will@kernel.org>
>> Link:  
>> https://lore.kernel.org/r/20250227180526.1204723-2-mark.rutland@arm.com
>> [maz: fixed LT->GE thinko]
>> Signed-off-by: Marc Zyngier <maz@kernel.org>

>> [ Backport: Resolved conflict in arch/arm64/kvm/hyp/nvhe/hyp-init.S
>>    by extracting EL2 state initialization into __kvm_init_el2_state
>>    and calling it after HCR setup. ]
>> ---
>>   arch/arm64/include/asm/el2_setup.h | 26 ++++++++++++++++++++++++++
>>   arch/arm64/kernel/head.S           | 19 +------------------
>>   arch/arm64/kvm/hyp/nvhe/hyp-init.S | 16 +++++++++++++---
>>   3 files changed, 40 insertions(+), 21 deletions(-)

>> diff --git a/arch/arm64/include/asm/el2_setup.h  
>> b/arch/arm64/include/asm/el2_setup.h
>> index b7afaa026842b..3498dc5d02c18 100644
>> --- a/arch/arm64/include/asm/el2_setup.h
>> +++ b/arch/arm64/include/asm/el2_setup.h
>> @@ -16,6 +16,32 @@
>>   #include <asm/sysreg.h>
>>   #include <linux/irqchip/arm-gic-v3.h>

>> +.macro init_el2_hcr	val
>> +	mov_q	x0, \val
>> +
>> +	/*
>> +	 * Compliant CPUs advertise their VHE-onlyness with
>> +	 * ID_AA64MMFR4_EL1.E2H0 < 0. On such CPUs HCR_EL2.E2H is RES1, but it
>> +	 * can reset into an UNKNOWN state and might not read as 1 until it has
>> +	 * been initialized explicitly.
>> +	 *
>> +	 * Fruity CPUs seem to have HCR_EL2.E2H set to RAO/WI, but
>> +	 * don't advertise it (they predate this relaxation).
>> +	 *
>> +	 * Initalize HCR_EL2.E2H so that later code can rely upon HCR_EL2.E2H
>> +	 * indicating whether the CPU is running in E2H mode.
>> +	 */
>> +	mrs_s	x1, SYS_ID_AA64MMFR4_EL1
>> +	sbfx	x1, x1, #ID_AA64MMFR4_EL1_E2H0_SHIFT, #ID_AA64MMFR4_EL1_E2H0_WIDTH
>> +	cmp	x1, #0
>> +	b.ge	.LnVHE_\@
>> +
>> +	orr	x0, x0, #HCR_E2H
>> +.LnVHE_\@:
>> +	msr	hcr_el2, x0
>> +	isb
>> +.endm
>> +
>>   .macro __init_el2_sctlr
>>   	mov_q	x0, INIT_SCTLR_EL2_MMU_OFF
>>   	msr	sctlr_el2, x0
>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>> index e0e710b36da37..ff7769821166a 100644
>> --- a/arch/arm64/kernel/head.S
>> +++ b/arch/arm64/kernel/head.S
>> @@ -575,25 +575,8 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
>>   	msr	sctlr_el2, x0
>>   	isb
>>   0:
>> -	mov_q	x0, HCR_HOST_NVHE_FLAGS
>> -
>> -	/*
>> -	 * Compliant CPUs advertise their VHE-onlyness with
>> -	 * ID_AA64MMFR4_EL1.E2H0 < 0. HCR_EL2.E2H can be
>> -	 * RES1 in that case. Publish the E2H bit early so that
>> -	 * it can be picked up by the init_el2_state macro.
>> -	 *
>> -	 * Fruity CPUs seem to have HCR_EL2.E2H set to RAO/WI, but
>> -	 * don't advertise it (they predate this relaxation).
>> -	 */
>> -	mrs_s	x1, SYS_ID_AA64MMFR4_EL1
>> -	tbz	x1, #(ID_AA64MMFR4_EL1_E2H0_SHIFT + ID_AA64MMFR4_EL1_E2H0_WIDTH -  
>> 1), 1f
>> -
>> -	orr	x0, x0, #HCR_E2H
>> -1:
>> -	msr	hcr_el2, x0
>> -	isb

>> +	init_el2_hcr	HCR_HOST_NVHE_FLAGS
>>   	init_el2_state

>>   	/* Hypervisor stub */
>> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S  
>> b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
>> index 1cc06e6797bda..a08363b9b10fd 100644
>> --- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
>> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
>> @@ -75,6 +75,16 @@ __do_hyp_init:
>>   	eret
>>   SYM_CODE_END(__kvm_hyp_init)

>> +/*
>> + * Initialize EL2 CPU state to sane values.
>> + *
>> + * HCR_EL2.E2H must have been initialized already.
>> + */
>> +SYM_CODE_START_LOCAL(__kvm_init_el2_state)
>> +	init_el2_state				// Clobbers x0..x2
>> +	finalise_el2_state
>> +	ret
>> +SYM_CODE_END(__kvm_init_el2_state)
>>   /*
>>    * Initialize the hypervisor in EL2.
>>    *
>> @@ -202,9 +212,9 @@ SYM_CODE_START_LOCAL(__kvm_hyp_init_cpu)

>>   2:	msr	SPsel, #1			// We want to use SP_EL{1,2}

>> -	/* Initialize EL2 CPU state to sane values. */
>> -	init_el2_state				// Clobbers x0..x2
>> -	finalise_el2_state
>> +	init_el2_hcr	0
>> +
>> +	bl	__kvm_init_el2_state

> Please don't churn unrelated code. Leave everything where it is and make
> sure init_el2_hcr is done before the others.

Understood.


> Thanks,
> Oliver
