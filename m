Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90703C0619;
	Mon, 17 Aug 2026 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786956625; cv=none; b=YlKfOffPvx1kedFkdarGO6SHXAk7ZxxUgIp9lMkHf5MDF8IDVhG30FPseUtOewtdRJxqcU0PZ2dISQ5t0F1/nvKPuSwreAQ18jB/KJ4D1ZpLn5zR6c8smBYn8yO96yimBo6Cc0bkQpS81uL5gpUIyuWlK+JXYX7x//1JFVoYMRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786956625; c=relaxed/simple;
	bh=HTsJFf2fB2f4yRKdoFXC/7hJQf+ILq783r7QSY/F3q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlVpTgSiCxnsgMVG1GELDZSaSYIeBLQ32N7AZkV+NDy4BxfHIHP6yRU46+fcuvIxfj3P83TS4h77s0BE7YmD1K1zYs3zthUSSm7cmuHUGeBPYBh1PEsWsZMobvButcl07q6Glvj+AMRStg+HALhg0hF1Wzki3y/P+4MpvMTIZdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7g9ylkH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7g9ylkH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06281F00A3A;
	Mon, 17 Aug 2026 08:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786956624;
	bh=Uc7aL40On+N+owN43pREKxKVuYx6yh3KMGJHIRHRr+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m7g9ylkHRhKs8rGQtvNnGNQvSsQeDKdhZqNE4JFdCFAh8VV6jL9h5kLUzFYQR/ODB
	 888l22EMeOBNcHMqO+Sf9WbbQ+NLxV1ASriq/bX0DWpcAkaeovMa81dg/ZJzy7WRLh
	 a+nK32Utj3gdApPAzxZhnh8TAP94OzqFXgdo4Uzio8gm0QsV5mhoMLKpknnIA0MRXZ
	 fi6eaYP7dwDDR2QRtULZ8PjaxeD1qkMMhgRPqDp5ieUmvsyRiELMP+c3coUhHkNx6x
	 L/jFD/oUqm+uCD3J9bpHlYpZcFa0ey3HmpKzhaxypNHogF44ZLqBlstSIyMplbpvxd
	 zd/rzOhfyyv6A==
Date: Mon, 17 Aug 2026 08:50:22 +0000
From: Yixun Lan <dlan@kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, spacemit@lists.linux.dev,
	junhui.liu@pigmoral.tech, stable@vger.kernel.org,
	Guodong Xu <docular.xu@gmail.com>
Subject: Re: [PATCH V2] riscv: dts: spacemit: k3: fix IMSIC num-guest-ids
Message-ID: <20260817085022-GKB571540@kernel.org>
References: <20260817033038.2286436-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260817033038.2286436-1-guoren@kernel.org>

Hi Guo

On 03:30 Mon 17 Aug     , Guo Ren wrote:
> From: "GUO Ren (XuanTie)" <guoren@kernel.org>
> 
> The initial K3 device tree used generic/placeholder values for the
> IMSIC guest configuration:
> 
>   riscv,num-guest-ids    = <511>;
> 
> According to the SpacemiT K3 User Manual this values is incorrect
> for the X100 cores:
> 
>  - Advanced Interrupt Architecture (AIA):
>     - M-mode MSI: 512
>     - S-mode MSI: 512
>     - VS-mode MSI: 64
> 
> Therefore, S-mode IMSIC (simsic) needs num-guest-ids = 63.
> 
> Fixes: 56f37e391a62 ("riscv: dts: spacemit: add initial support for K3 SoC")
> Cc: stable@vger.kernel.org
> Cc: Guodong Xu <docular.xu@gmail.com>
> Cc: Yixun Lan <dlan@kernel.org>
> Signed-off-by: GUO Ren (XuanTie) <guoren@kernel.org>
> ---
> V2:
>  - Drop the riscv,guest-index-bits change for simsic: the property
>    describes the number of guest index bits in the MSI target address,
>    and the per-hart stride on K3 is 0x40000 = 2^(6 + 12), so 6 is
>    correct as is.
>  - Drop the mimsic changes: already fixed by Junhui.
>  - Reword the subject and commit log accordingly.
> ---
>  arch/riscv/boot/dts/spacemit/k3.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Reviewed-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)
