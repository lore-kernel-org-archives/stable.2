Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3822472AF;
	Sat,  5 Sep 2026 03:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788577704; cv=none; b=d3uRokIbyhXiwuWfyaMOjJH2GcHHdENufdvPhYdxXhrvOd1VVj7nbZgD8OrAjEhbqO8Nl5MZhXm+Angw8o901RnV/L+x0BpV/r7zvIz38A0TN5+F68g16FXCk1dQGRgQ1ffWEtIykmx9YspWCbRr+4Vv8XGD5f8ITurID5I5d4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788577704; c=relaxed/simple;
	bh=aAn6XXVpZxkC4xYEu2hExGNPc3HYP0pNew+8EKplVpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L9dgpaVI4aitVXT9N5EEvhwtV6ylBdlsBuxz2YfntlHG5LxS3WiVj2yL6bz2GPJMGQ22j2L34p5RkNJ+JfH+bmzJ/Ri1ZO4N/XUemRoI9fjzuO2yab1XgpoW35L2mYsdWbyJQLolqQpzkLdtat5B42t1rjBgBvgKxo0TWn+7MHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6XxG4jvV; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6XxG4jvV"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Rau380fv/C3PIMO8upUmN2ndspPXutqa2G+T2w4vG2g=;
	b=6XxG4jvVSS2yP6Twqz++PqKHMDiJ+xiJaTnRUXE78I1KRddCIO/l3t/PVROSi3vqBhDcqvNBg
	VH80GddnFqp8jbISNmo1hRfzgljAx81PxpoS6zKcY9grHjWlBZvaEeeXrhQwRmKAsbXe389JuT9
	gCkFoSX+kvTN1iDo/uk6uI0=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hcJ0B121DzLlXB;
	Sat,  5 Sep 2026 10:57:14 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id CE5C74056C;
	Sat,  5 Sep 2026 11:08:05 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 5 Sep
 2026 11:08:04 +0800
Message-ID: <3e7fb313-021a-49d0-9def-fd9f03e3c2bb@huawei.com>
Date: Sat, 5 Sep 2026 11:08:04 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] bpf, riscv: Make arena support depend on ZACAS
Content-Language: en-US
To: Chen Pei <cp0613@linux.alibaba.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <memxor@gmail.com>,
	<bjorn@kernel.org>, <puranjay@kernel.org>
CC: <ihor.solodrai@linux.dev>, <eddyz87@gmail.com>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
	<emil@etsalapatis.com>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<guoren@kernel.org>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260902061451.1416-1-cp0613@linux.alibaba.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260902061451.1416-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100007.china.huawei.com (7.202.181.221)

Hi Pei,

On 2026/9/2 14:14, Chen Pei wrote:
> The arena range tree allocates its nodes with kmalloc_nolock() since
> commit f8c67d8550ee ("bpf: Use kmalloc_nolock() in range tree").
> kmalloc_nolock() requires slab caches with cmpxchg128 support
> (__CMPXCHG_DOUBLE); on riscv cmpxchg128 is provided by the ZACAS
> extension. On systems without ZACAS every arena map creation fails

This limitation has a significant impact, as much of the hardware on the 
market lacks ZACAS support given that it is not mandatory in RVA23.

> with a misleading -ENOMEM.
> 
> Report the missing support instead: make bpf_jit_supports_arena()
> return system_has_cmpxchg128() where it is defined, so arena map

Originally, I thought rv_ext_enabled(ZACAS) && 
IS_ENABLED(CONFIG_TOOLCHAIN_HAS_ZACAS) would make it more explicit, but 
system_has_cmpxchg128() seems to better capture what we were missing.


Acked-by: Pu Lehui <pulehui@huawei.com>

> creation fails with -EOPNOTSUPP on systems without ZACAS. The macro
> is only defined when both CONFIG_RISCV_ISA_ZACAS and
> CONFIG_TOOLCHAIN_HAS_ZACAS are enabled, so guard it with #ifdef the
> same way mm/slab.h consumes it, and reject arena otherwise. This
> matches how arena BPF_CMPXCHG instructions are already gated on ZACAS
> in bpf_jit_supports_insn().
> 
> Fixes: f8c67d8550ee ("bpf: Use kmalloc_nolock() in range tree")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
> Changes since v1:
> - Guard system_has_cmpxchg128() with #ifdef instead of calling it
>    unconditionally: the macro is only defined when both
>    CONFIG_RISCV_ISA_ZACAS and CONFIG_TOOLCHAIN_HAS_ZACAS are enabled
>    (as reported by sashiko-bot), so v1 broke the build when either
>    was disabled. This mirrors how mm/slab.h consumes the macro.
> 
> Why #ifdef rather than rv_ext_enabled(ZACAS)? The predicates differ
> exactly in the configurations that matter:
> 
>    scenario (ISA_ZACAS/TOOLCHAIN/hw)  v1           rv_ext_enabled  #ifdef
>    ISA=n or TOOLCHAIN=n               build fails  rejects         rejects
>    ISA=y TOOLCHAIN=n hw has ZACAS     build fails  accepts, then   rejects
>                                                    -ENOMEM again
>    ISA=y TOOLCHAIN=y hw has ZACAS     exact        exact           exact
> 
> rv_ext_enabled(ZACAS) does not check CONFIG_TOOLCHAIN_HAS_ZACAS, but
> slab's cmpxchg128 - and thus kmalloc_nolock() - does require it, so
> on an old toolchain with ZACAS hardware it would accept arena maps
> and bring back the very -ENOMEM failure this patch fixes. The #ifdef
> form builds in every configuration and matches exactly the
> kmalloc_nolock() availability gate in mm/slab.h.
> 
> This issue was reported by sashiko-bot:
> https://sashiko.dev/#/patchset/20260901120013.16104-1-cp0613@linux.alibaba.com?part=1
> 
> Question for reviewers: should the arena selftests gate on ZACAS,
> e.g. probing it via riscv_hwprobe() (RISCV_ISA_EXT_ZACAS) and
> SKIPping cleanly on systems without the extension?

riscv isn't currently integrated into the BPF CI, and handling this 
locally via qemu is fairly straightforward, so I'm not entirely sure 
this is strictly necessary.

> 
>   arch/riscv/net/bpf_jit_comp64.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 74efe4b138d2..151031e97a24 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -2128,7 +2128,15 @@ bool bpf_jit_supports_ptr_xchg(void)
>   
>   bool bpf_jit_supports_arena(void)
>   {
> -	return true;
> +	/*
> +	 * The arena range tree uses kmalloc_nolock(), which needs
> +	 * cmpxchg128, provided by ZACAS on riscv.
> +	 */
> +#ifdef system_has_cmpxchg128
> +	return system_has_cmpxchg128();
> +#else
> +	return false;
> +#endif
>   }
>   
>   bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
