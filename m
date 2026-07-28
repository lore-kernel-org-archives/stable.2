Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990631AF24;
	Tue, 28 Jul 2026 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237475; cv=none; b=APtwSCoLng9vm7uE9ofCybeN8/vVPVsZ/GVOkdUCYT9FYmrHiwGNsbaaGmTa7P65bZhr4PNY8m4X4/g0erCi2DXDrsXbBbrqSFxW5wv+aritBeg11K0f0GT+JSiwdsRtNDpbOkId/IAwxDQNGGZgvfsgI95wzyUOh357SN8ocY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237475; c=relaxed/simple;
	bh=atL7xaZ/1Mdyxo1UEOFoCAMRzxxhzojRkIlUA9mPeD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsEMg6tLp9zzb5+3qS2oxQ263F360VGPdOxDhpEwmedm+eSUMnKVk6TmemA6EZXSIMW4sZy0GD+ffTFF7v5nyxzJz1Q31rzDmIgK+FyT9zg5A/8Ly0wn68iZL2xVGBN/yGsxlGeUUKVvzOpvQZoFLB6b1WrP6t4WPYNcnVd06fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPbDKVLv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPbDKVLv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90631F000E9;
	Tue, 28 Jul 2026 11:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785237474;
	bh=VJB5QQyhbCwyyIdOpL3gynrSH4a3kKTKTWVbCcBni5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iPbDKVLvhJ3Bbmuqo41XqwB3PUgWJ5xG7VipP4LoMGUPUb43CDwZq+AdvhLUSUYhM
	 YyYazR3MI6PqbARXesyT4GrfCXFQsZB4XAH+AgmuXFZ2BOBGsV5/pKyeqBV7pF1p45
	 jzyPk32keo7QYSeuKIrruK7Rwm6Zy3MlGB+2eaFc6zG/lIw6MxlEeA/xzCqD4T+KL3
	 PEuLrs6R3u3WCfYMUnskrSFVURQ1VufcjNHbxA/UB2mp9TKBeyrds8imt2QzryfSii
	 LXZ2vOtYIbLIYYr/TAJvxLcbNdGTCCTM13a3AK3DnxhJTwJhzVWyBJFCSJ5TA09cNH
	 LycsdkAlFu0/Q==
Date: Tue, 28 Jul 2026 11:17:51 +0000
From: Yixun Lan <dlan@kernel.org>
To: Peixin Xie <peixin.xie@linux.spacemit.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Oza Pawandeep <quic_poza@quicinc.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] riscv: acpi: Handle LPI architectural context loss flags
Message-ID: <20260728111751-GKC76518@kernel.org>
References: <20260728-riscv-acpi-lpi-timer-v1-1-c722bce01e48@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728-riscv-acpi-lpi-timer-v1-1-c722bce01e48@linux.spacemit.com>

Hi Peixin,

On 17:36 Tue 28 Jul     , Peixin Xie wrote:
> Commit 4785aa802853 ("cpuidle, ACPI: Evaluate LPI arch_flags for
> broadcast timer") replaced the generic nonzero check for LPI
> architectural context loss flags with arch_get_idle_state_flags().
> RISC-V does not implement the helper, so it falls back to the stub
> that returns 0. Consequently, CPUIDLE_FLAG_TIMER_STOP is not set when
> an LPI state loses the hart timer context, preventing cpuidle from
> using a broadcast timer for that state.
> 
> Implement the RISC-V helper and map the hart timer context loss flag
> to CPUIDLE_FLAG_TIMER_STOP.
> 
> Fixes: 4785aa802853 ("cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peixin Xie <peixin.xie@linux.spacemit.com>
Looks good to me, with one minor comment

Reviewed-by: Yixun Lan <dlan@kernel.org>

> ---
>  arch/riscv/include/asm/acpi.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> index 26ab37c171bc..3a3da834c340 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -12,6 +12,8 @@
>  #ifndef _ASM_ACPI_H
>  #define _ASM_ACPI_H
>  
> +#include <linux/cpuidle.h>
> +
>  /* Basic configuration for ACPI */
>  #ifdef CONFIG_ACPI
>  
> @@ -67,6 +69,23 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
>  
>  void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
>  			     u32 *cboz_size, u32 *cbop_size);
> +
> +/*
> + * RISC-V Functional Fixed Hardware Specification Version v1.0.1
> + * Table 4: LPI Arch. Context Lost Flags

As I checked https://docs.riscv.org/reference/acpi-ffh/v1.0.1/ffh_use_cases.html
It's table 3, and I'd suggest to put more precisely as:

"Chapter 2.1.1.2. Arch. Context Lost Flags, Table 3"

> + */
> +#define RISCV_LPI_HART_TIMER_CTXT_LOST		BIT(0)
> +
> +static inline unsigned int arch_get_idle_state_flags(u32 arch_flags)
> +{
> +	if (arch_flags & RISCV_LPI_HART_TIMER_CTXT_LOST)
> +		return CPUIDLE_FLAG_TIMER_STOP;
> +
> +	return 0;
> +}
> +
> +#define arch_get_idle_state_flags arch_get_idle_state_flags
> +
>  #else
>  static inline void acpi_init_rintc_map(void) { }
>  static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> 
> ---
> base-commit: 1d6f0a217c662693d2307ee06851cb4bfcbf9529
> change-id: 20260727-riscv-acpi-lpi-timer-6f1739a6c831
> 
> Best regards,
> --  
> Peixin Xie <peixin.xie@linux.spacemit.com>
> 

-- 
Yixun Lan (dlan)
