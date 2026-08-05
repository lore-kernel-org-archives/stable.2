Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899903E63A2
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919036; cv=none; b=kh3JM53snV9C9I5RcAM1dYca0JBEf6v4OKIhJvil8pp2Tc7KdMmlDO9MzldJlojVod1xa8NfZpnuGbsMYSNnrTZOG2C6Ge//rsf5c0c8ooVjxZTnEK2k0OrWCY4XhekjKaSDsbs3+ycwC1J3Lo8Weeqzhg5Nf6vN1FI9LiZ4xcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919036; c=relaxed/simple;
	bh=+MDtHi6dPC1QIQzo0Z88w/cZsFiMqPteqBivyJBKpj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IErBhNSF5AgG6zHm1n6KSAZr9fiLt2q3GboxFOeQOAENg/SydKFXiCOMacq3trx46iuF/Cd8IUeVMQf/9En8WZrqMPLfHIKaHj1q4/kntKcCNyh/+/FKAI85pwfAyaMJYo+XdMHBi57lijjQw/FZvouBK94Hn4T335R5gttx+o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQ4OPqTW; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ4OPqTW"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f7027ca11so432829f8f.3
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785919032; x=1786523832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o6L5hEIACrzWkfhK+g6IqcfRxL0gKu8KPahN+8ZtlEc=;
        b=lQ4OPqTWOGzA6nE29/Hb24sAAytpQUkAuHzeHOMAgBO9BKrtaftSv4i8k56pB46uYF
         oVQN4D1HG3GNRLQkq66PNJqlysCxHAzdRaJ70CAPl3gwtprw9SDwucHhhQ75pJMruPGU
         o3+jcsRfNHcSEAFQre1iH/FFJWIYgxPsoeGZnX04U+X1LCPcprb3PMGcoodeL7LKrz+A
         F+tJI9O7BFFXknTljpQU/tgDXc3CkXQS+eveAJiX8W/SoTvUTZpf8h4J7PC+Mn5YW0Dr
         ZgKz5ml7c7FbUX6Wri+i8wKKntKS2QGE8Eg2qYM8pLKdTasMFRWIG32wbcoGHONJb4CP
         TWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785919032; x=1786523832;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o6L5hEIACrzWkfhK+g6IqcfRxL0gKu8KPahN+8ZtlEc=;
        b=d4kdGHsSMEbgJQsjs7ZWLbD+0xXaijC5GmpfEW9y0p5IFQBu9LL4O11ntgW0YEwcC9
         5xMHmrgdx+l7hp0dKQSu0ht6x+MGTZa1qrujSWgiz7BKMMhIYr+TUogWM4AGiNUDEYlf
         2b56X+E6KO2U6tt383tVe7ee/wvmLElxPPbJwnEsnNJQ1FiJnzB/MdMUhr357OUAs5wd
         4HlhwWAlSHywCN2lRVqd8XvxBXpgjOakKRg+Zm+lKDdPYwYNMq5NDHoVIOnRCeJX60kJ
         3dMfB+jINptuqFG34HR2cPV/+3akzmDN8SbBlabc8dsTPUEO8Lv8tk18XXUMm4Y++WnJ
         9d1w==
X-Forwarded-Encrypted: i=1; AHgh+Rok8r28NwMdNZU7XtbwYHjzkrY9de5FOhSTvLw1F8gwR5dmpHUkys6+70nkBWWxFIq1lXBBK3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9sttj5Afi4hKqV9tQfBG92IZO59XZfeIFtJsKYmTzO5Ywi/zc
	djd5f0a659Y1KzV5wJFv4j9qjCvToufnR4j8IJ9K62d7JwB+QVFhhYD+
X-Gm-Gg: AR+sD11JAqFJeyb9+ER4e1g5qo73QhgusJUV5VRfoYntgljfwQWuyeB3OVhd6JFusD3
	jEWc189+P/BXKRBzYhPMieADFJtJcMMK5HbkwIvqOi/026Prtr8Mme2ujkUQEbmec5uQAslepm7
	7yxd7FkAP8TRcZtcHTn80QuZNEBWCWFGq4N7Tgoyvo6ZwXvfGXw0WGHMWkWO1P8dk/aQ0YXZQjn
	P3KKHBUUkx630aGmPzpqpkxwf5Zs1kU4ge6AG2pzTxudSMmwBgIRvhOFoWJpgMCcHUdWQ+kBt4A
	8N5Fy1UMtDUeSUcOIwgFHF850QxqVOMbCVvsN8Y8ziPhmH3Te/XaV6ZNMwgeQh+dbYJl33v2Q2b
	ZHTrEgEgZ4ovYgaTf1dckWUyXvsBCqcISA9ppCAkS6zcdlSNku/KhlgJDTOJgFZxtUmSP3QLDyx
	XLn5ytrcPhOrq9bfn/wiAY/cgIu2V6eV4gbhC+baW6CEyRpY7ZLX1VtyHtCWNhkk3O7r4AuejFQ
	lRSNVDLEzs/BqnRErWRl3Xntg==
X-Received: by 2002:a05:6000:29c2:b0:47f:cb30:8591 with SMTP id ffacd0b85a97d-47fec4e712dmr6453147f8f.6.1785919031999;
        Wed, 05 Aug 2026 01:37:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febfe5ecfsm6952226f8f.11.2026.08.05.01.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:37:11 -0700 (PDT)
Date: Wed, 5 Aug 2026 09:37:10 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, ada.coupriediaz@arm.com,
 ardb@kernel.org, catalin.marinas@arm.com, cl@gentwo.org, david@kernel.org,
 james.morse@arm.com, ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, ryan.roberts@arm.com, stable@vger.kernel.org,
 vladimir.murzin@arm.com, will@kernel.org, yang@os.amperecomputing.com
Subject: Re: [PATCH v2 01/20] arm64: percpu: Fix this_cpu_write() casting
Message-ID: <20260805093710.3c4baf6c@pumpkin>
In-Reply-To: <20260804170503.3513916-2-mark.rutland@arm.com>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
	<20260804170503.3513916-2-mark.rutland@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Aug 2026 18:04:44 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> The arm64 implementation of this_cpu_write() casts 'val' to unsigned
> long. This is necessary to handle cases where 'val' is a pointer type,
> and to avoid spurious compiler warnings for the (unreachable!) cases
> where the pointer type would be cast to a smaller integer type.
> 
> Unfortunately, the cast is applied to 'val' rather than '(val)', which
> won't always generate the expected value when 'val' is an expression.
> 
> For example, for this_cpu_write(pcp, zero - 1), where 'pcp' is a u64 and
> 'zero' is a u32:
> 
> * 'zero'                      ===> (u32) 0x00000000
> * 'zero - 1'                  ===> (u32) 0xffffffff
> * '(unsigned long)zero - 1'   ===> (u64) 0xffffffffffffffff
> * '(unsigned long)(zero - 1)' ===> (u64) 0x00000000ffffffff
> 
> Fix this by adding brackets around 'val'
> 
> The bug described above can be seen from the disassembly of the
> following test code:
> 
> | void this_cpu_write_zero_minus_1(u64 __percpu *pcp)
> | {
> | 	u32 zero = 0;
> | 	this_cpu_write(*pcp, zero - 1);
> | }
> |
> | void this_cpu_write_zero_minus_1_brackets(u64 __percpu *pcp)
> | {
> | 	u32 zero = 0;
> | 	this_cpu_write(*pcp, (zero - 1));
> | }
> 
> Generated code before this patch:
> 
> | <this_cpu_write_zero_minus_1>:
> |        paciasp
> |        stp     x29, x30, [sp, #-16]!
> |        mrs     x1, sp_el0
> |        mov     x29, sp
> |        ldr     w2, [x1, #8]
> |        add     w2, w2, #0x1
> |        str     w2, [x1, #8]
> |        mov     x3, #0xffffffffffffffff
> |        mrs     x2, tpidr_el1
> |        str     x3, [x0, x2]
> |        ldr     x0, [x1, #8]
> |        add     x0, x0, x3
> |        str     w0, [x1, #8]
> |        cbz     x0, 1f
> |        ldr     x0, [x1, #8]
> |        cbnz    x0, 2f
> | 1:     bl      preempt_schedule_notrace
> | 2:     ldp     x29, x30, [sp], #16
> |        autiasp
> |        ret
> |
> | <this_cpu_write_zero_minus_1_brackets>:
> |        paciasp
> |        stp     x29, x30, [sp, #-16]!
> |        mrs     x1, sp_el0
> |        mov     x29, sp
> |        ldr     w2, [x1, #8]
> |        add     w2, w2, #0x1
> |        str     w2, [x1, #8]
> |        mov     x3, #0xffffffff
> |        mrs     x2, tpidr_el1
> |        str     x3, [x0, x2]
> |        ldr     x0, [x1, #8]
> |        sub     x0, x0, #0x1
> |        str     w0, [x1, #8]
> |        cbz     x0, 1f
> |        ldr     x0, [x1, #8]
> |        cbnz    x0, 2f
> | 1:     bl      preempt_schedule_notrace
> | 2:     ldp     x29, x30, [sp], #16
> |        autiasp
> |        ret
> 
> Generated code after this patch:
> 
> | <this_cpu_write_zero_minus_1>:
> |        paciasp
> |        stp     x29, x30, [sp, #-16]!
> |        mrs     x1, sp_el0
> |        mov     x29, sp
> |        ldr     w2, [x1, #8]
> |        add     w2, w2, #0x1
> |        str     w2, [x1, #8]
> |        mov     x3, #0xffffffff
> |        mrs     x2, tpidr_el1
> |        str     x3, [x0, x2]
> |        ldr     x0, [x1, #8]
> |        sub     x0, x0, #0x1
> |        str     w0, [x1, #8]
> |        cbz     x0, 1f
> |        ldr     x0, [x1, #8]
> |        cbnz    x0, 2f
> | 1:     bl      preempt_schedule_notrace
> | 2:     ldp     x29, x30, [sp], #16
> |        autiasp
> |        ret
> |
> | <this_cpu_write_zero_minus_1_brackets>:
> |        b       this_cpu_write_zero_minus_1
> 
> Fixes: 959bf2fd03b5 ("arm64: percpu: Rewrite per-cpu ops to allow use of LSE atomics")
> Reported-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
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
> Cc: stable@vger.kernel.org

I suspect there is no affected code - largely testable by comparing the
output of two arm64 allmodconfig builds.

Reviewed-by: David Laight <david.laight.linux@gmail.com>

> ---
>  arch/arm64/include/asm/percpu.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> index b57b2bb009677..63bbfd4944a37 100644
> --- a/arch/arm64/include/asm/percpu.h
> +++ b/arch/arm64/include/asm/percpu.h
> @@ -179,13 +179,13 @@ PERCPU_RET_OP(add, add, ldadd)
>  	_pcp_protect_return(__percpu_read_64, pcp)
>  
>  #define this_cpu_write_1(pcp, val)	\
> -	_pcp_protect(__percpu_write_8, pcp, (unsigned long)val)
> +	_pcp_protect(__percpu_write_8, pcp, (unsigned long)(val))
>  #define this_cpu_write_2(pcp, val)	\
> -	_pcp_protect(__percpu_write_16, pcp, (unsigned long)val)
> +	_pcp_protect(__percpu_write_16, pcp, (unsigned long)(val))
>  #define this_cpu_write_4(pcp, val)	\
> -	_pcp_protect(__percpu_write_32, pcp, (unsigned long)val)
> +	_pcp_protect(__percpu_write_32, pcp, (unsigned long)(val))
>  #define this_cpu_write_8(pcp, val)	\
> -	_pcp_protect(__percpu_write_64, pcp, (unsigned long)val)
> +	_pcp_protect(__percpu_write_64, pcp, (unsigned long)(val))
>  
>  #define this_cpu_add_1(pcp, val)	\
>  	_pcp_protect(__percpu_add_case_8, pcp, val)

