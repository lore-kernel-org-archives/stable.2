Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051093BB4A;
	Sun, 16 Aug 2026 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786869639; cv=none; b=cTqYr7r4uJdYN4usA9sPC8nGTGcCg2i+5BuAOcjFUfJMKuzG6jKqEsEVcf0PbYDqo28dOGR1+eqxAMRRhf651oOZHp4seEKN5neD2ecnGbfLhR3zDN9LbQgFiKmOWG0kSla9EaOzR76A0hegub87jEWhLsrJ/DdbN4KaWYn7Z0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786869639; c=relaxed/simple;
	bh=+snPUrO06f07JkvLRZBcshd6XmCFCTaPNVQiBCB5u48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xc3+5HoNsFthVdFyvmSDonGtU3eyrLZbyCEOXlBx0CgBzApaF4bWVLUjgVaLpvjV93s0n5XLrvt+NRlO7vcC0DFfbSTu0I8dMuHHg66im3eVJXtQFddqcdQRHqDeF5JzGRQRE4ABNWLmlH5GIGW66g5uA+aBxkkOzhLUrqtIxwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAEIP+fJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAEIP+fJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8661F000E9;
	Sun, 16 Aug 2026 08:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786869637;
	bh=11Tl+8QITJlApV/arZRysuZlEcln9IcnFTpqE9Wj410=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GAEIP+fJLQsJweuQV2dasPDpw0vzWVP6I6DYe6tcHmKd61IpmwqVL1Kr/AgnCGCRO
	 scYIXIp6hwMYXZDOcsv8BOL+vkV9kbpvb3gPGV6f7xumpDB0z6F4B8lWzoOsc1g7wA
	 bZYyt/h0L7bbugcJ9gWYpVH0HQFwbgGcSjxoBk1+y1mODUemZwKXpxV0zX2Xz0OuSK
	 Yrd6pdUk3UuPKr3jOYVWkFIRRuY/JUBgwKVAXASxvxzvTNx4WeYQEW+o6vjDzA7lmK
	 OGyYg9nwTv2VSLOpO4IuUdbu09SBP0XrWlXDRpiGg7Y3ItE2EaA17dFhvuyrRe7f3V
	 EeLoa156ujwGA==
Date: Sun, 16 Aug 2026 08:40:34 +0000
From: Yixun Lan <dlan@kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	spacemit@lists.linux.dev, stable@vger.kernel.org,
	Guodong Xu <docular.xu@gmail.com>
Subject: Re: [PATCH] riscv: dts: spacemit: k3: fix IMSIC guest parameters
Message-ID: <20260816084034-GKC318749@kernel.org>
References: <20260816074125.2105828-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260816074125.2105828-1-guoren@kernel.org>

hi Guo,

On 07:41 Sun 16 Aug     , Guo Ren wrote:
> From: "GUO Ren (XuanTie)" <guoren@kernel.org>
> 
> The initial K3 device tree used generic/placeholder values for the
> IMSIC guest configuration:
> 
>   riscv,guest-index-bits = <6>;
>   riscv,num-guest-ids    = <511>;
> 
> According to the SpacemiT K3 User Manual [1] these values are
> incorrect for the X100 cores:
> 
>  - Hypervisor Extension: RVH 1.0, GEILEN = 8
>  - Advanced Interrupt Architecture (AIA):
>     - M-mode MSI: 512
>     - S-mode MSI: 512
>     - VS-mode MSI: 64
> 
> Therefore:
> 
> - S-mode IMSIC (simsic) only needs guest-index-bits = 3 (to cover
>   GEILEN = 8) and num-guest-ids = 63.
..
> - M-mode IMSIC (mimsic) does not implement guest interrupt files at
>   all, so the guest-related properties must be omitted.
> 
Cc Junhui

There is already one fix for IMSIC [1], but it's actually too late to
pick for v7.3 .. I'm not sure how best to handle this, would it possible
on your side to pick Junhui's patch and rework to combine them to 
send a V2? or I could pick his patch first ..

https://lore.kernel.org/all/20260729-k3-mimsic-fix-v1-1-368c0aec04b9@pigmoral.tech/ 

> Although the KVM AIA driver will re-detect the actual number of guest
> interrupt files via hgeie and correct guest-index-bits at runtime, the
> device tree should still describe the correct hardware parameters.
> 
> Update the device tree to match the silicon.
> 
..
> [1] https://www.spacemit.com/community/document/info?lang=en&nodepath=hardware/key_stone/k3/k3_docs/k3_usermanual/08_cpu.md
> 
no blank line and use "Link: https://.. [1]" format

> Fixes: 56f37e391a62 ("riscv: dts: spacemit: add initial support for K3 SoC")
> Cc: stable@vger.kernel.org
> Cc: Guodong Xu <docular.xu@gmail.com>
> Cc: Yixun Lan <dlan@kernel.org>
> Signed-off-by: GUO Ren (XuanTie) <guoren@kernel.org>
> ---
>  arch/riscv/boot/dts/spacemit/k3.dtsi | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
> index 19fc9b49668e..4120eb0c4083 100644
> --- a/arch/riscv/boot/dts/spacemit/k3.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
> @@ -1127,9 +1127,9 @@ simsic: interrupt-controller@e0400000 {
>  					      <&cpu4_intc 9>, <&cpu5_intc 9>,
>  					      <&cpu6_intc 9>, <&cpu7_intc 9>;
>  			msi-controller;
> -			riscv,guest-index-bits = <6>;
> +			riscv,guest-index-bits = <3>;
>  			riscv,hart-index-bits = <4>;
> -			riscv,num-guest-ids = <511>;
> +			riscv,num-guest-ids = <63>;
>  			riscv,num-ids = <511>;
>  		};
>  
> @@ -1168,9 +1168,7 @@ mimsic: interrupt-controller@f1000000 {
>  					      <&cpu4_intc 11>, <&cpu5_intc 11>,
>  					      <&cpu6_intc 11>, <&cpu7_intc 11>;
>  			msi-controller;
> -			riscv,guest-index-bits = <6>;
>  			riscv,hart-index-bits = <4>;
> -			riscv,num-guest-ids = <511>;
>  			riscv,num-ids = <511>;
>  			status = "reserved";
>  		};
> -- 
> 2.43.0
> 

-- 
Yixun Lan (dlan)
