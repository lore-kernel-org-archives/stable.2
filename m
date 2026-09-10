Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE3A49B1F9
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050289; cv=none; b=s8u7N8J2WDPw3tJF9JFyF55RJ1v8HdM+wQ/Dt5h0arVRSKhykpZbKIHA1ATUc0QsXKcfy3YZtYKUAX9GUBk1qvPs7sqiMRFBwcoCwVWEZV8NLdf0qqfyaypoFIqXVzOM9+unBz9IgiW9uS93S49zC8z9RY2a/lOVQ4C2L/C7ns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050289; c=relaxed/simple;
	bh=HEfL7d3n00h3U3+XJykgzKwhbH5YqtSSnRGlr/lRfNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nto8mzTSL+YinbHNA5XNmk2vISKXP54ezJAvLxTOb9SNIeypfdCDcjzyDbjFJeOMJ4pSyZiUDIHJKKL5U/rG+k8Epl7aAiV2d1hvWkO5n9dF3HEtYYDMojMEDs6R4jdmHQLariq7MKVMbSlBXyXI2ewE2XxHBicsdMcTzooxN10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a07ChFdO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a07ChFdO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE08F153B;
	Thu, 10 Sep 2026 07:24:43 -0700 (PDT)
Received: from [10.0.152.207] (unknown [10.0.152.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B38EB3F7B4;
	Thu, 10 Sep 2026 07:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789050287; bh=HEfL7d3n00h3U3+XJykgzKwhbH5YqtSSnRGlr/lRfNc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a07ChFdOX0Dv7XSDDls5zde/APBZPGr1SXf2UvW0eJ7Axf8f41/BJmoBknxkaS9/6
	 P2hLKXuEpBSmBkRaRT6qmUw6BwqbVbBv6kI7te5/xgTMKrKh+EAYaYoT8xr8CrzLSa
	 whCEMaMyBbMn5PRxuXBklaVkMI1DlDsLSowmFxs4=
Message-ID: <1066c195-fde7-4bfc-850f-189936c29c96@arm.com>
Date: Thu, 10 Sep 2026 15:24:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/21] arm64: gpr-num: add __GPR_NUM() helper
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com, ardb@kernel.org, catalin.marinas@arm.com,
 cl@gentwo.org, david@kernel.org, david.laight.linux@gmail.com,
 james.morse@arm.com, ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, ryan.roberts@arm.com, stable@vger.kernel.org,
 usama.anjum@arm.com, will@kernel.org, yang@os.amperecomputing.com
References: <20260908151741.394589-1-mark.rutland@arm.com>
 <20260908151741.394589-12-mark.rutland@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20260908151741.394589-12-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 16:17, Mark Rutland wrote:
> The gpr-num infrastructure requires users to concatenate the register
> name with a long prefix in order to get a symbol that evaluates to a
> compile-time constant. Doing this manually is error-prone and painful to
> read.
> 
> Add a new __GPR_NUM() helper which wraps the concatenation.
> 
> For the moment I've left existing open-coded concatenation as-is. In
> particular, the DEFINE_MRS_S() and DEFINE_MSR_S() macros have awkward
> stringification requirements and would require invasive changes that
> outweigh the benefit. I have plans to rework those in the near future to
> remove the need to use gpr-num values.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Jinjie Ruan <ruanjinjie@huawei.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vladimir Murzin <vladimir.murzin@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> ---
>  arch/arm64/include/asm/gpr-num.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/gpr-num.h b/arch/arm64/include/asm/gpr-num.h
> index 240cd25d55c5a..30fb8a67b19f0 100644
> --- a/arch/arm64/include/asm/gpr-num.h
> +++ b/arch/arm64/include/asm/gpr-num.h
> @@ -11,6 +11,8 @@
>  	.equ	.L__gpr_num_xzr, 31
>  	.equ	.L__gpr_num_wzr, 31
>  
> +#define __GPR_NUM(gpr)		(.L__gpr_num_##gpr)
> +
>  #else /* __ASSEMBLER__ */
>  
>  #define __DEFINE_ASM_GPR_NUMS					\
> @@ -26,6 +28,8 @@
>  "	wx\\n	.req	w\\n\n"										\
>  "	.endr\n"
>  
> +#define __GPR_NUM(gpr)		"(.L__gpr_num_" gpr ")"
> +
>  #endif /* __ASSEMBLER__ */
>  
>  #endif /* __ASM_GPR_NUM_H */
> -- 2.30.2
> 

Brilliant!

FWIW,

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
