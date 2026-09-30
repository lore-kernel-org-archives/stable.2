Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96AB4718D4
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764407; cv=none; b=R31+Z32fr0fiiTqBI5fO8MbSu/DOes8xe6Atehxz1pwj0/gZwb+b+sjh1YEMYnrqYdOEudQ8/iXqf7iAPC62zfI/tqUU2mt0EA0AALwTEtL9iC5ByvSTot7Ic1xfECPLU5nuEf/tyajhZMAA8K0Vhc+ezE1B0HWZFzaXgZ//U2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764407; c=relaxed/simple;
	bh=Afge1VGxYThuk4VFTZQjrw9p5H+Ni7gcE5O2Mz88XpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=brOlF55nET+KGt7Qa3n0wZeOsK8A9YrmDBynWepocAZUxVELJw3OyzTuvcwEXNWrjeMhKSy3od7gK7qkqGrj8yeAV4gB4hDdUIszh1XzRC+5Jm/oMPlKADn8v0Nl19bL/99rItWXMY1FGOHaNd53OdR/78ZQcvYZ+R7j/FKEiPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=E2lOBVIo; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E2lOBVIo"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260930103316euoutp0187885ff089d44dc32d3df6094d1a45cf~aErsCNMkl2549425494euoutp01L
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 10:33:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260930103316euoutp0187885ff089d44dc32d3df6094d1a45cf~aErsCNMkl2549425494euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1790764396;
	bh=FJ+htCVvKAhLkwC8CUAuytt3OB7IBWbiwLyL2rvPoSg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=E2lOBVIo/7n1IPo2fFD6qsSxcKMCFCoNKB79E6YI9JVI3ET/dGqoHL7EsoEM5F3d2
	 kV0R6PwC6d+dXDLN/0VgElM3s3wu40j9RkJIhNAlFWC2Q1xj1VfKbje48WvsZoDLm3
	 zLk3l3+dXG+F6trEvKNgxC4KIAldNa7VQ0vVtGJ4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260930103315eucas1p1dc6504dfed6803e1f6c1a9d4156e3da0~aErrrMstU2676926769eucas1p19;
	Wed, 30 Sep 2026 10:33:15 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260930103314eusmtip169db81e9f1c9f97f31c91e3ec55f06e6~aErqyiXeU0732407324eusmtip1b;
	Wed, 30 Sep 2026 10:33:14 +0000 (GMT)
Message-ID: <a95a44d9-6572-40f4-ab6d-1c160ecd5349@samsung.com>
Date: Wed, 30 Sep 2026 12:33:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pwm: th1520: Fix 32-bit build with COMPILE_TEST
To: FUJITA Tomonori <tomo@flapping.org>, fustini@kernel.org,
	guoren@kernel.org, ukleinek@kernel.org, wefu@redhat.com
Cc: a.hindborg@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
	bjorn3_gh@protonmail.com, boqun@kernel.org, dakr@kernel.org,
	daniel.almeida@collabora.com, gary@garyguo.net,
	linux-riscv@lists.infradead.org, lossin@kernel.org, ojeda@kernel.org,
	tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, FUJITA Tomonori
	<fujita.tomonori@gmail.com>, stable@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20260930101257.1649945-1-tomo@flapping.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260930103315eucas1p1dc6504dfed6803e1f6c1a9d4156e3da0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260930101334eucas1p2ec64abcf499a296767711f13ad70c486
X-EPHeader: CA
X-CMS-RootMailID: 20260930101334eucas1p2ec64abcf499a296767711f13ad70c486
References: <CGME20260930101334eucas1p2ec64abcf499a296767711f13ad70c486@eucas1p2.samsung.com>
	<20260930101257.1649945-1-tomo@flapping.org>



On 9/30/26 12:12, FUJITA Tomonori wrote:
> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> Fix the following build error on 32-bit ARM with COMPILE_TEST:
> 
>   ERROR: modpost: drivers/pwm/pwm_th1520.ko: symbol '__aeabi_uldivmod' undefined!
> 
> The driver divides u64 values when it converts between nanoseconds and
> clock cycles. On 32-bit ARM, these divisions are compiled to calls to
> __aeabi_uldivmod, which the kernel does not provide.
> 
> The TH1520 is a 64-bit RISC-V SoC, so the driver is only used on
> 64-bit kernels. There is no point in compile testing it on 32-bit.
> Limit COMPILE_TEST to 64BIT instead of changing the arithmetic to use
> the div64 helpers.
> 
> Fixes: 3c180003dffb ("pwm: th1520: Fix missing Kconfig dependencies")
> Cc: stable@vger.kernel.org
> Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
> Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/topic/64bit.20division.20in.20.60pwm_th1520.2Ers.60/near/626825599
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
> v2:
> - Fix a typo in the commit message
> - Add Cc: stable, Reported-by and Closes tags
> - Add Reviewed-by tags from Andreas and Gary
> - Rebase on v7.3-rc5
> 
> v1: https://lore.kernel.org/all/20260929095612.1072417-1-tomo@flapping.org/
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 729776086879..abecd95b0c3c 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -772,7 +772,7 @@ config PWM_TEGRA
>  
>  config PWM_TH1520
>  	tristate "TH1520 PWM support"
> -	depends on ARCH_THEAD || COMPILE_TEST
> +	depends on ARCH_THEAD || (COMPILE_TEST && 64BIT)
>  	depends on RUST
>  	depends on HAS_IOMEM && COMMON_CLK
>  	select RUST_PWM_ABSTRACTIONS
> 
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e

Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>

