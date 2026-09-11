Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A643AEF24
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122023; cv=none; b=i1/imj4+uvfltFm7eKpR8zcIPJGbhq1+ALkQol8dN+YOch8QvtmR/1BpyrmvEAVOZYl6N/oQPQffwhDPX9Hg0LInnGvKCGK5/TtMw7zW9StiI9ceyOi/IJTWDoVoy0luOlWDu8Oar1GY0+9I+4LbBlb8Z9IxOdJFZsvev8037Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122023; c=relaxed/simple;
	bh=53Dh5QE6fSgJ74oMfOx/5be01PBtu9656F9us9fFU+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CAAcYHzMCFy2SX7nYgG3vY+gQWdRLIEOSUkMXMylr6SYi6MNz7XzuYgZsHXvTRZjJkrHqwFhV/O/P4a9ezZLHI/xvT9uSAnYk/gtPEfzL5RZ4rQEbaQnvzhtfFoZdF9M07P8VNz91Osdddi/r+f/8c582CktVG1PuGZmT3X5eRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mP6HeeHX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mP6HeeHX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14485153B;
	Fri, 11 Sep 2026 03:20:15 -0700 (PDT)
Received: from [10.0.152.207] (unknown [10.0.152.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4514A3F7B4;
	Fri, 11 Sep 2026 03:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789122018; bh=53Dh5QE6fSgJ74oMfOx/5be01PBtu9656F9us9fFU+8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mP6HeeHXPRZxEdHjOO8oTs+q6Smeu/t8MWvXsEgXSu3DgtgMx9L9ycv4wANLZlF5V
	 X7/U8jsObc/Im0hX6R4xmKeZ2Smvj9439ipAFwyFg4PNH+bV8pTpxA6Dg+MJFnoICr
	 JkHIYGnpxaazF5Qa5pHZ6gY9Bl/2EaLMR6x2MhtE=
Message-ID: <182bd070-d987-45f5-9dca-1a85b07abf2b@arm.com>
Date: Fri, 11 Sep 2026 11:20:13 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/21] arm64: ptrace: Always inline
 pt_regs_[read,write}_reg()
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com, ardb@kernel.org, catalin.marinas@arm.com,
 cl@gentwo.org, david@kernel.org, david.laight.linux@gmail.com,
 james.morse@arm.com, ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, ryan.roberts@arm.com, stable@vger.kernel.org,
 usama.anjum@arm.com, will@kernel.org, yang@os.amperecomputing.com
References: <20260908151741.394589-1-mark.rutland@arm.com>
 <20260908151741.394589-9-mark.rutland@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20260908151741.394589-9-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 16:17, Mark Rutland wrote:
> In subsequent patches we'll want to use pt_regs_read_reg() and
> pt_regs_write_reg() in noinstr code.
> 
> To ensure noinstr safety, both functions must be inlined into their
> caller. As both functions are marked as 'inline' rather than
> '__always_inline', that's not strictly guaranteed, and the compiler is
> permitted to generate out-of-line copies.
> 
> Mark both functions as '__always_inline' to ensure this.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vladimir Murzin <vladimir.murzin@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> ---
>  arch/arm64/include/asm/ptrace.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index f7dc5fb9427d6..f635c3453a858 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -266,7 +266,8 @@ static inline u64 regs_get_register(struct pt_regs *regs, unsigned int offset)
>   * Read a register given an architectural register index r.
>   * This handles the common case where 31 means XZR, not SP.
>   */
> -static inline unsigned long pt_regs_read_reg(const struct pt_regs *regs, int r)
> +static __always_inline unsigned long
> +pt_regs_read_reg(const struct pt_regs *regs, int r)
>  {
>  	return (r == 31) ? 0 : regs->regs[r];
>  }
> @@ -275,8 +276,8 @@ static inline unsigned long pt_regs_read_reg(const struct pt_regs *regs, int r)
>   * Write a register given an architectural register index r.
>   * This handles the common case where 31 means XZR, not SP.
>   */
> -static inline void pt_regs_write_reg(struct pt_regs *regs, int r,
> -				     unsigned long val)
> +static __always_inline void
> +pt_regs_write_reg(struct pt_regs *regs, int r, unsigned long val)
>  {
>  	if (r != 31)
>  		regs->regs[r] = val;
> -- 2.30.2
> 

FWIW,

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

