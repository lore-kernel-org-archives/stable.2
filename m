Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB14569F2E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966189; cv=none; b=K8qZS/ZEFJPCsenpBGUtBCqz7I+tgGg1k872JDCG/C621aF/aNcVr8P7CrRWTucgbIiIS0MBfWZEmw4JIp2MZO6Xv8nOkVGf/EmmoAfUZhQwFoROaoLzA/K0RltzNBxBIpvKSN9BZFv2ssyuiUSKyIqXcOAFh1mvKwdhRP2Tfic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966189; c=relaxed/simple;
	bh=vg5wLuB4etETWKLml46RDi0Srj8Dfg2y4E8bi7SKsf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZ6v/1LHHIEue5UEBMQwhM201NbH2uILDNEfkUKn5UKbbrnmny89k8fKZJMFcZ0zJNLlgGDWWWHUzkEXcKbNuFJSoPpptBDC6Dy6H7Oo16EV8tMX2/ey8DPy3O0r/Ch4oeappGpAOwnc7D3bX1dyyPTl7FD8kYnYbBzWAFEDXE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=dGYoOzDY; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="dGYoOzDY"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81ecf499af9so82218247b3.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 08:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1788966185; x=1789570985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rRcHj/Y7sCFM6BIjv/vAHj4iQa4l8MfJuugG+12Z+qU=;
        b=dGYoOzDYjNUA665jd/1/qmNfByNncUCzGuUoQgGgCL53PFNHCfdoL9MX65yUcn/qvH
         nNBP0FOo1k23vq5l7OLdZxMpYDqsRkqCgx3e7EytETcyl1PYDJLxErUymc0Kc/eVGNCA
         Q9wJeFAxNVrRy/v8aWGt7c4AN+8Sxv4OiW/CqI0arYQBBl/hHUFtugthg9LUbycmu/Ev
         NzmTozGaNq0wzKg7z/v2hV5CUsWGFgjZFE6l1cLoC2Uw2Q4sjI5m8NnLsnArAB5Jeblu
         T+yO9kq1LWDg3rHRRqc0W4tPbq1zB6n+7roChTGFQeTna3wD8IgTBmDw92FEEphr3Lld
         vn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788966185; x=1789570985;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rRcHj/Y7sCFM6BIjv/vAHj4iQa4l8MfJuugG+12Z+qU=;
        b=Npp/WJ6IQLFKdU9xJ0SRHvTgDuBMn7oihC2si65tso6R+LC9tt+kMA4kZuQMJmQD7+
         AUHhUZ1XnWgH32JbNT3RxPfay2sDn+yA23l3p1JzOlZ4gMOcSEdVKiIjAjbersW4Tokp
         +n0yPM92urr1iqmeE+q71eHVSt02uXHVHcgZxo7nKzbGIpZjkK6RiEWXDP34eYzTBzfr
         N6UPU0zqx8obSSNgs5aku/5fwlHYmlRFfSxbP7RHw/F2cij7tGlcvs2tqU1tfNrYLwc0
         gwJzdh4hamqlIG7gvWmb08PXxcUCSCT2UmguWwspf9De/u/WbEQ2zbQZlFABy+XSUJCN
         /NUA==
X-Forwarded-Encrypted: i=1; AKwUvBzzrpQ5L7aXd6fRbFI3ukJ7oSUrKzJJVq0wxzYUmFKjiDB203TUbbi/0F3IcvyNs82rieMUgPI=@vger.kernel.org
X-Gm-Message-State: AFuF++kubK5SFwdKOd/y6qQTLNPgw/e9fEmtmrP7C6k22rUsNjA6J9j5
	ohzjfiphIqQxUNE9CpAiQ0ghqPunTnAsvO1LD3v4CNI+VfFT4SDZwO7iI0eCI+T5JgE=
X-Gm-Gg: AYBFou3k+CmxngO7+YidziOKxhf0D03mhkwidpq/QEyd6Pg5ordoEpOinWK4C5Ov+5W
	dfYBmzyeefcuVs4/NEhB6YhVdUMIxu8BlqS+42fk2/gHugHtFdVhnEXZlzKhbsg0thDIxhh5PPM
	HRM9eyfYaBspZUV1opnXC4Q//xLnHOM0XXd3DgBowHJfyquyyNyxxBQqEuhDD6m3uKqxdX8pqVY
	T8PIvWlyp5N9+PU9I3292MJoujoMFVINy1MQHWI6Yw2bwnpwiOMWM6+OECtncpHuVWhJ12Nkiy/
	ghiBkeEJTuMyBEB3dD/k1AR6p5ZR+/byWz32hNG51uUxq+qQc/djQYa8554e4AoXf6bKPBqxNqo
	nT38cuCC1TyjqNIfLd3b29DQWRNVZVpW04W8vxPOxWPO23m+4AtOmQ9yKTnmH+oaav3eYeQiXmJ
	OsTUQH7+nJEAHKr1WiGhCvmG7EaoVn/vXhlLhEtD/RTw4xuUyz9LCmtjxjLFMXFPUbMv9bfkg7c
	9xsejMwg0sCRJnjlaLNxNpnZYkd23qPyjYGAKdvMxuXGL88Sw==
X-Received: by 2002:a05:690c:94:b0:842:255f:4372 with SMTP id 00721157ae682-87127c2f703mr132533027b3.25.1788966185505;
        Wed, 09 Sep 2026 08:03:05 -0700 (PDT)
Received: from toolbox ([12.55.13.134])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8713d68fd00sm114995377b3.0.2026.09.09.08.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:03:03 -0700 (PDT)
Date: Wed, 9 Sep 2026 10:02:45 -0500
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Drew Fustini <dfustini@oss.tenstorrent.com>, 
	Joel Stanley <jms@oss.tenstorrent.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clk: tenstorrent: Assign .num before accessing .hws
Message-ID: <sf2wvxw5aojiffi6bwtvowvde4vh4o3gk4l2tgf77icc2pd62m@gtvsxcv6thot>
References: <AS8P251MB00013BD9A093C06D2D60E10EC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P251MB00013BD9A093C06D2D60E10EC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>

On Sat, Sep 05, 2026 at 09:48:35PM +0100, Aamir Ahmed wrote:
> Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
> __counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
> with __counted_by, which informs the bounds sanitizer (UBSAN_BOUNDS)
> about the number of elements in .hws[], so that it can warn when .hws[]
> is accessed out of bounds. As noted in that change, the __counted_by
> member must be initialized with the number of elements before the first
> array access happens, otherwise there will be a warning from each access
> prior to the initialization because the number of elements is zero.
> This occurs in atlantis_prcm_clocks_register() due to .num being
> assigned only after every clock has been stored in .hws[]. With
> CONFIG_UBSAN_BOUNDS and a compiler that implements __counted_by (GCC
> 15.1+ or Clang 20.1+), this triggers an array-index-out-of-bounds report
> during probe, and with CONFIG_UBSAN_TRAP the first store traps so the
> clock provider never registers.
> 
> Move the .num initialization to right after the allocation.
> 
> Cc: stable@vger.kernel.org
> Fixes: 23c8ebc95284 ("clk: tenstorrent: Add Atlantis clock controller driver")
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
> ---
> Found while auditing the remaining clk_hw_onecell_data users that assign
> .num only after touching .hws[], following the fixes already merged for
> clk-s2mps11 (3e14c7207a97), exynos-clkout (cf33f0b7df13) and
> clk-raspberrypi (6dc445c19050). The audit, the fix and this changelog
> were drafted with an LLM assistant and reviewed by hand.
> 
> Compile-tested only (W=1, no warnings) on x86_64 with GCC 13.3, via
> COMPILE_TEST with CONFIG_TENSTORRENT_ATLANTIS_PRCM=m. GCC 13.3 does not
> implement __counted_by (CC_HAS_COUNTED_BY needs GCC 15.1+ or Clang
> 20.1+), so the build only confirms that the change compiles; the
> sanitizer path was not exercised. I do not have the hardware, so this is
> not runtime-tested and no UBSAN report was captured.

With CONFIG_UBSAN_TRAP, probe fails like this in the QEMU tt-atlantis
machine

[    0.236357] Kernel BUG [#1]
[    0.236483] Modules linked in:
[    0.236699] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.1.0-00145-g42d8a0e21d1a #2 PREEMPTLAZY 
[    0.236778] Hardware name: Tenstorrent Atlantis RISC-V Machine (DT)
[    0.236833] epc : atlantis_prcm_probe+0x18e/0x194
[    0.237107]  ra : atlantis_prcm_probe+0xbe/0x194
[    0.237123] epc : ffffffff8060ed7a ra : ffffffff8060ecaa sp : ff20000000043b30
[    0.237134]  gp : ffffffff8173c808 tp : ff600001801f0cc0 t0 : ffffffff812db9e8
[    0.237143]  t1 : 8d795c92de4feea0 t2 : 0000000000000000 s0 : ff20000000043b90
[    0.237153]  s1 : ffffffff816d3b88 a0 : 0000000000000000 a1 : 0000000000000002
[    0.237161]  a2 : 0000000000000000 a3 : ffffffff81777080 a4 : 0000000000000000
[    0.237170]  a5 : 0000000000000000 a6 : ff60000180ee8000 a7 : ff20000000043954
[    0.237178]  s2 : ff60000180380810 s3 : ff60000180eedc40 s4 : ff60000180ee8000
[    0.237187]  s5 : ff60000180eedc48 s6 : 0000000000000038 s7 : 0000000000000000
[    0.237196]  s8 : ffffffff810a4b78 s9 : 0000000000000000 s10: 0000000000000000
[    0.237204]  s11: 0000000000000000 t3 : 0000000000000020 t4 : ffffffffffffffff
[    0.237223]  t5 : ff20000000600000 t6 : ff6000018040793e ssp : 0000000000000000
[    0.237232] status: 0000000200000120 badaddr: ffffffff8060ed7a cause: 0000000000000003
[    0.237288] [<ffffffff8060ed7a>] atlantis_prcm_probe+0x18e/0x194
[    0.237346] [<ffffffff806924f2>] platform_probe+0x66/0xac
[    0.237356] [<ffffffff8068f9ec>] really_probe+0x8c/0x23c
[    0.237367] [<ffffffff8068fc0c>] __driver_probe_device+0x70/0x110
[    0.237376] [<ffffffff8068fd82>] driver_probe_device+0x2e/0x108
[    0.237385] [<ffffffff8068ffc6>] __driver_attach+0x6a/0x168
[    0.237394] [<ffffffff8068d944>] bus_for_each_dev+0x60/0xb0
[    0.237403] [<ffffffff8068f48e>] driver_attach+0x1a/0x24
[    0.237412] [<ffffffff8068ec92>] bus_add_driver+0xca/0x1ec
[    0.237423] [<ffffffff80690c96>] driver_register+0x3e/0xdc
[    0.237432] [<ffffffff80691c2c>] __platform_driver_register+0x1c/0x24
[    0.237457] [<ffffffff80c30f16>] atlantis_prcm_driver_init+0x1a/0x24
[    0.237473] [<ffffffff8001012c>] do_one_initcall+0x5c/0x1c8
[    0.237483] [<ffffffff80c01396>] kernel_init_freeable+0x236/0x2cc
[    0.237493] [<ffffffff80ad82dc>] kernel_init+0x1c/0x14c
[    0.237503] [<ffffffff80011c74>] ret_from_fork_kernel+0x18/0x170
[    0.237511] [<ffffffff80ae2342>] ret_from_fork_kernel_asm+0x16/0x18
[    0.237598] Code: bf6d 55fd b5dd 854a 9617 00cc 0613 9326 55b5 b799 (9002) 57d1 
[    0.237743] ---[ end trace 0000000000000000 ]---
[    0.237956] Kernel panic - not syncing: Fatal exception in interrupt

Reviewed-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

Regards
Anirudh Srinivasan

>
> Based on v7.3-rc1.
> 
>  drivers/clk/tenstorrent/atlantis-prcm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/tenstorrent/atlantis-prcm.c b/drivers/clk/tenstorrent/atlantis-prcm.c
> index 6d4386eeb7d..a68534a295c 100644
> --- a/drivers/clk/tenstorrent/atlantis-prcm.c
> +++ b/drivers/clk/tenstorrent/atlantis-prcm.c
> @@ -796,6 +796,8 @@ static int atlantis_prcm_clocks_register(struct device *dev,
>  	if (!clk_data)
>  		return -ENOMEM;
>  
> +	clk_data->num = num_clks;
> +
>  	for (i = 0; i < data->num; i++) {
>  		struct clk_hw *hw = data->hws[i];
>  		struct atlantis_clk_common *common =
> @@ -809,8 +811,6 @@ static int atlantis_prcm_clocks_register(struct device *dev,
>  		clk_data->hws[common->clkid] = hw;
>  	}
>  
> -	clk_data->num = num_clks;
> -
>  	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
>  }
>  
> 
> base-commit: 654ae5d73c05bd2943d65636ce6cd0aa46e62f18
> -- 
> 2.53.0.windows.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
