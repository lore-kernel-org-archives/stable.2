Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D14B23C4F3
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 04:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786075236; cv=none; b=TVwh4bg7bOgaUJu6RhZVZvrxTa2YVr4YdU+IGR5T2s7ybNKtioJzBYN2C8Q0KGQMDPyOG+wRtHol3uIiCQzxITsSQAFEyhPPHJgXpclsYmWxjzpHZFffQrEZym1nxQm/3B7FViJdAlhXQqQ5XWaXPmPbi01DtSokP4CwDQhXyK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786075236; c=relaxed/simple;
	bh=hmZuclTFZzpwPanYMBMzflpA2nQmvtKusjc96jxp2FE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fQq0r95jfzwo1/d6dfs2yMqxixaEte4ExPnBlYxQxiiOlqb02VdnifI5YNMg3qsVIvb1j0ljh3KjXfGFoRLfIYix2GSH6gpey2kJ39UmZkIHQl/o0b9asL24GHE8OUuQ+pk8yR3TUA/Db6cvxjI39t7blih7NSGrgViDXss25OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ri2HG5CG; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ri2HG5CG"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5R1g/lTULmE0cpizN2C7xpl0sqIGETJfyPJS85LVXWU=;
	b=ri2HG5CGFuk8tcKqZxbnIsBGwNt20PeeMCJijON/OfdinYe905qjRB0sO4Cy98idpAIDEziJ3
	e24qjH5bZG6rPeJWQUrHhKAzcqicTHkv79R+XE0f1dnir/ew7dfwwgmbH6PJl2JHZYDPgRmciG6
	dZTEGT/7G0nUwHRL9Wv3d8M=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hGVYH6cTNzpSvB;
	Fri,  7 Aug 2026 11:50:43 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id C03864057F;
	Fri,  7 Aug 2026 12:00:16 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Aug 2026 12:00:15 +0800
Message-ID: <2b96cf93-ddf2-4700-91d2-a0587343c3ff@huawei.com>
Date: Fri, 7 Aug 2026 12:00:14 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/20] arm64: percpu: Fix this_cpu_write() casting
To: Mark Rutland <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>
CC: <ada.coupriediaz@arm.com>, <ardb@kernel.org>, <catalin.marinas@arm.com>,
	<cl@gentwo.org>, <david@kernel.org>, <david.laight.linux@gmail.com>,
	<james.morse@arm.com>, <ljs@kernel.org>, <maz@kernel.org>,
	<peterz@infradead.org>, <ryan.roberts@arm.com>, <stable@vger.kernel.org>,
	<vladimir.murzin@arm.com>, <will@kernel.org>, <yang@os.amperecomputing.com>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
 <20260804170503.3513916-2-mark.rutland@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260804170503.3513916-2-mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)



在 2026/8/5 1:04, Mark Rutland 写道:
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

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

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

