Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D336E27144B;
	Wed, 26 Aug 2026 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787730802; cv=none; b=eFyzR5edr+ot0FlArFbOZQbZ7ebiLZGe22b0ZjfE/tLbaZ7ex1kTG9JlcSzV5zabD/nSlIwDQoKLq9qSLshAp6NkEP/Mej0yldeEAZiWx+OitoeUN5XeYWpdNGW4eJ3bAx5Uqrs1MTnoyhYAcwmlz9GnulJyOClWzCq56dweooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787730802; c=relaxed/simple;
	bh=Z6HoB3ArP+HJHiuwC6X5orzCfydeM4JGAASPrl9zsZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMcqsA2qWtFJgH+oLIVf9/jSQwsSu0EQ1h8kDsef0C2utVHasOpXsHj3Xxoal+f1CzjwqBulRbcDT1aMhNTlY3ArpEyAy++IfAekEleXzl9iO9aumfrhUg/JIqjA3UrynzBqX2MLw4yB2NdzpG+jnP51ADDnSqHJKUxs8pU7KgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNTlomfv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNTlomfv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787730801; x=1819266801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z6HoB3ArP+HJHiuwC6X5orzCfydeM4JGAASPrl9zsZE=;
  b=eNTlomfv+rlj04YcDCnSlLoRKVkKSik0WBjhTXUjAryrwvpAXlNbBFBx
   ho9G9HeISisv2F+cqnEfR64ECJb2xmIqGvgtWNUL7fitv8drumNMsFA4q
   vmsUEbiQR/80OoNmV0X9dCr6/ifbRr2Pa6qicVyCc8go/hNpzStYbeAh0
   t71gbFg2iU96W3kPDgcNrSBEloYAzboL9CCsGcbYX9hOrPBNpU3YYM4uT
   /NNRE9ZR0yg2ph2KQbZeVSNtwktUhfEmyOlvC15rskZgx8V6EBGrh0EQk
   ffH0SUVsHM3F6l56wXyLzByFgFREbBEi8HkaYfowg8cfjYoxkZGcw3ktV
   A==;
X-CSE-ConnectionGUID: gVLjoKP4R6uL8TzDdFc6BA==
X-CSE-MsgGUID: MSwsjVLvTIqTnzFkkuBKng==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="105731356"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="105731356"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 00:53:20 -0700
X-CSE-ConnectionGUID: DC+xIrJ6SqqqIdzAU5YsnQ==
X-CSE-MsgGUID: Qm3E/VqFQlO6X9hueFekNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="267528830"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 00:53:16 -0700
Message-ID: <1743f6e6-85b1-4e10-b5bd-141cd513fbd7@linux.intel.com>
Date: Wed, 26 Aug 2026 15:53:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/23] perf/x86/intel: Guard counter masks against zero
 counters
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>, stable@vger.kernel.org
References: <20260821222002.54907-1-zide.chen@intel.com>
 <20260821222002.54907-2-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260821222002.54907-2-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 8/22/2026 6:19 AM, Zide Chen wrote:
> When running as a guest with a vPMU exposed, the host may expose zero
> general-purpose counters or zero fixed counters. In that case,
> GENMASK_ULL() is called with a negative high-bit argument, resulting
> in an out-of-range shift and undefined behavior.
>
> On systems with PMU partitioning enabled, this configuration is more
> likely. Change GENMASK_ULL() to BIT_ULL() to guard mask generation
> against zero counters.
>
> Fixes: 722e42e45c2f ("perf/x86: Support counter mask")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 2b35483e2b70..8b13bcc5259c 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -7905,7 +7905,7 @@ __init int intel_pmu_init(void)
>  		x86_pmu = intel_pmu;
>  
>  	x86_pmu.version			= version;
> -	x86_pmu.cntr_mask64		= GENMASK_ULL(eax.split.num_counters - 1, 0);
> +	x86_pmu.cntr_mask64		= BIT_ULL(eax.split.num_counters) - 1;
>  	x86_pmu.cntval_bits		= eax.split.bit_width;
>  	x86_pmu.cntval_mask		= (1ULL << eax.split.bit_width) - 1;
>  
> @@ -7924,7 +7924,7 @@ __init int intel_pmu_init(void)
>  		int assume = 3 * !boot_cpu_has(X86_FEATURE_HYPERVISOR);
>  
>  		x86_pmu.fixed_cntr_mask64 =
> -			GENMASK_ULL(max((int)edx.split.num_counters_fixed, assume) - 1, 0);
> +			BIT_ULL(max((int)edx.split.num_counters_fixed, assume)) - 1;
>  	} else if (version >= 5)
>  		x86_pmu.fixed_cntr_mask64 = fixed_mask;
>  
