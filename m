Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E7E3AF677
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482070; cv=none; b=bOvPAZIQzop7aA3QJ+H1Rm17mh0kGLb34SlEcP0tb71+7nXQWwtg+QB1ufmtyDMlbPWqnnzPSYQcaaFC9mDhBhZoTKvs6uyFu6mqPvFUkMa5aIs9ngaTAmhdocOIhSJVwvfvk83HXvcdQkmoZ08az5SGEeJ/sHufadYMf7lmuUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482070; c=relaxed/simple;
	bh=8kgnQwL/0VBtF0XCi65qh7izruKbtNAb+I2J2OSqPYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOahRTX2YGZ2Jj/zJuU82Wj1Hqcfv0VYjMKr1ZluV9V0toU8q5mdOdhg5MUSEPN/V6K2LpRvO46nX1DTQAxHYdTedIDkqT5j2e7y0uIDBVLZVtnOeo1TrLf7Z1mr7GTL9iVYFXhRiidDvWg3bobq5peLNcZG6g1n8O9yBi4zt84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=u2x7AyH3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="u2x7AyH3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 558261516;
	Tue, 15 Sep 2026 07:21:03 -0700 (PDT)
Received: from [10.0.152.207] (unknown [10.0.152.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7228C3F7B4;
	Tue, 15 Sep 2026 07:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789482066; bh=8kgnQwL/0VBtF0XCi65qh7izruKbtNAb+I2J2OSqPYs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u2x7AyH3rzvJaL/E5rRKKWZew33lKE9xTelpEjt5w8ejIjdXo5y568qfagnCugAVc
	 ml63aQPy1N9ysR2RDt3avZWoyfSvnEzRK/kpWHNnr53BvhHjh8CW+KbzR9s7gHSv3/
	 JTCydre/4J1Nh7vc/NhfjTYVB/DD3qsMUNxAJ/8c=
Message-ID: <b78df0e5-9375-47d6-a203-95b931c988d7@arm.com>
Date: Tue, 15 Sep 2026 15:21:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/21] arm64: percpu: Remove _pcp_protect*() wrappers
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com, ardb@kernel.org, catalin.marinas@arm.com,
 cl@gentwo.org, david@kernel.org, david.laight.linux@gmail.com,
 james.morse@arm.com, ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, ryan.roberts@arm.com, stable@vger.kernel.org,
 usama.anjum@arm.com, will@kernel.org, yang@os.amperecomputing.com
References: <20260908151741.394589-1-mark.rutland@arm.com>
 <20260908151741.394589-22-mark.rutland@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20260908151741.394589-22-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 16:17, Mark Rutland wrote:
> Now that all this_cpu_*() operations are preemptible, there are no users
> of _pcp_protect() or _pcp_protect_return().
> 
> Remove them both, along with the associated comment regarding
> preemption.
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
>  arch/arm64/include/asm/percpu.h | 27 ---------------------------
>  1 file changed, 27 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> index 5cd98e20e825d..6ec6e212932d3 100644
> --- a/arch/arm64/include/asm/percpu.h
> +++ b/arch/arm64/include/asm/percpu.h
> @@ -368,33 +368,6 @@ PERCPU_CMPXCHG_OP(x,  , 64)
>  #undef PERCPU_XCHG_OP
>  #undef PERCPU_CMPXCHG_OP
>  
> -/*
> - * It would be nice to avoid the conditional call into the scheduler when
> - * re-enabling preemption for preemptible kernels, but doing that in a way
> - * which builds inside a module would mean messing directly with the preempt
> - * count. If you do this, peterz and tglx will hunt you down.
> - *
> - * Not to mention it'll break the actual preemption model for missing a
> - * preemption point when TIF_NEED_RESCHED gets set while preemption is
> - * disabled.
> - */
> -
> -#define _pcp_protect(op, pcp, ...)					\
> -({									\
> -	preempt_disable_notrace();					\
> -	op(raw_cpu_ptr(&(pcp)), __VA_ARGS__);				\
> -	preempt_enable_notrace();					\
> -})
> -
> -#define _pcp_protect_return(op, pcp, args...)				\
> -({									\
> -	typeof(pcp) __retval;						\
> -	preempt_disable_notrace();					\
> -	__retval = (typeof(pcp))op(raw_cpu_ptr(&(pcp)), ##args);	\
> -	preempt_enable_notrace();					\
> -	__retval;							\
> -})
> -
>  #define _pcp_wrap(op, pcp, ...)						\
>  ({									\
>  	op(&(pcp), __VA_ARGS__);					\
> -- 2.30.2
> 

FWIW,

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

