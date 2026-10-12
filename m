Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09DF39021A;
	Mon, 12 Oct 2026 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810311; cv=none; b=QvApjGRcRfSlDU4595yE4PzYjfNavPsvsm58GDpK8TKFFacCcKWXyesbsVCQIbf1PAopve6f/WCMIAXVGWc77LQ5ojSgQSDZn+w0VTIRt4oHmp0zml1XM09tDN99yIHneiJZ8QjcsS2u4VNqpddCRa0oalcoE7TJOW3huqkaH2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810311; c=relaxed/simple;
	bh=X5GjCGwug3T6t3kpl2vPNT3lYjGs5zu6QGaO+M+UGIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cabkhjxv6zLmjzhscjU/54b0oeicZCthBusKiunjxf3BAJ+XCVnmXiiDnShmSb0mQYM56VDnKS5uNOqtWVuGLDJl1g4eNUGo8aSuRzs6Icil4MgIviGmVLxfcL55+Rh0Px61HyCsrIq2AebcDrnSHSo1395hyFPxk6JzUpmiRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mX/XPvOY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mX/XPvOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D371F0089B;
	Mon, 12 Oct 2026 13:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791810309;
	bh=tFX0utyqGQ9LjVE1lOmvWMH4gqZCNOEBVSbJXf7asog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mX/XPvOYpTtSND2MoR34UMVlym60qhmhz8lduuHcaXojr91stAzhIeCDInjMK0yqK
	 xANUiz5QctxSHI9IvXxoFh0CY6nYH6aBgLRIaJLpiY9IX7VtnEBd+7Y50s5597wDHy
	 oMxcZdeyrGqJ7l7XwAzlGAKmpWDXQ6Z9H9o3ODAdknHt5eqlWgM2rxZYWuBHAUZuqR
	 CQYLbp6cs4qQeiTI7roQz5kD6bPGSJj+R/IF5LjGk3iZl3leexJ01PxihNCQdhBE+B
	 Yk0GViYE+GyK0r9YKpPTdvKzoU8dOM0v6lx0yhMvt5cXizIzGNBmHkY4o7SlD3p/ZO
	 WgIEuTMCSbPfQ==
Date: Mon, 12 Oct 2026 18:35:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, johan@kernel.org, 
	kishon@kernel.org, rogerq@ti.com, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, zhongling0719@126.com, stable@vger.kernel.org
Subject: Re: [PATCH v8 4/4] phy: ti-pipe3: Fix clock leaks in init/exit error
 paths
Message-ID: <aszZ1jXVI6Fcq0VJ@debian>
References: <20260909122630.1313205-1-zenghongling@kylinos.cn>
 <20260909122630.1313205-5-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909122630.1313205-5-zenghongling@kylinos.cn>

On Wed, Sep 09, 2026 at 08:26:30PM +0800, Hongling Zeng wrote:
> Two paths return without disabling the clocks that ti_pipe3_init()
> has just enabled, leaking clock enable references:
> 
> 1. In ti_pipe3_init(), when regmap_update_bits() fails for PCIe mode,
>    the function returns the error without calling
>    ti_pipe3_disable_clocks(). The clocks stay permanently enabled
>    since the PHY framework won't invoke the .exit callback on init
>    failure.
> 
> 2. In ti_pipe3_exit(), when the PHY is in SATA mode without
>    dpll_reset_syscon, the function returns 0 early to avoid powering
>    down the SATA DPLL (Errata i783), which also skips the
>    ti_pipe3_disable_clocks() at the end of the function. Every
>    init/exit cycle therefore leaks the clock enable reference taken
>    in ti_pipe3_init().
> 
> Fix both by adding the missing ti_pipe3_disable_clocks() calls,
> consistent with how the DPLL program error path handles cleanup.
> 
> Fixes: 234738ea3390 ("phy: ti-pipe3: move clk initialization to a separate function")
> Fixes: 0a0830feb2ad ("phy: ti-pipe3: fix suspend")
> Cc: stable@vger.kernel.org

This is not really a stable candidate...

> Reported-by: Sashiko AI <sashiko@kernel.org>
> Closes: https://lore.kernel.org/all/20260518023657.41852C2BCB0@smtp.kernel.org/
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
