Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390290;
	b=UuRctn8cyUmgZF6OpZ3vZJ6NBehixVv+RynfMnPlJ0X9sPDaeQIxa2ofuYfNT94lFAhw
	 gQC9MvsRRRbEPokfaMPdxivPeDK1LqkXbvEiITFLQI+IU62XGNF2aayK0yvSLagjewi2K
	 mC2LoOunBAppu1ZfGle5gOu4yQJFY/n8+o89Iw9VvF1p2xJgC2Ejy+gSmwHZxDGFzei48
	 Axesbt6tYhv8+T+ehPjl4SEqn+iuBs7oxoxiIpFLySZ1PINJlMo4s2oRVv2M6QYbBeNqN
	 w349ls61jTUjcUNOx/Qj4qrwYGN800cTQ29UAoUFeW6lRUUsjU+hLEbpIRzGFCvfRaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390290;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=mSg7ezHNLdRMO5rUaap7UyEFdy4UwZI7t6qPA3oqw5g=;
	b=CJymZrSMbMSKJ4VdVlDlJELyQFu2rS+ScPohd4IQQunDcUJzfu0kgOWPYuv+uIHmlIOH
	 F9nh1R6KQkdnUwzqYgXwzYVkUbjocKvs4kZN9fIG6w4v4Z/1UzFTXm81C1ZqsIRtX1BA8
	 ep2RzCF0Ff8EpP806rjJmQXvBhRie8rNGoQdCWl26On8jYkxrlNIdmjYhLfW2sBq/221d
	 gMgL17UPdhQaCOwgxDcMvLD54NIi5hxiQ6G4K32ShrY0BINb3ul0fGTMxGJ/NfdLURGbk
	 /AYz46fKxIyZuEeZDMrme+sNjHAYwbnPXkw24EaNdJkNAnzzR2UDVJVFCgQ/SgPmxbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BetHikey;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89886606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89886606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BetHikey
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794390289; x=1825926289;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xpdSU5zA9geXq9QlD3U4rWfHR2Tfm6HGoaBhzYGC1cw=;
  b=BetHikeyZaVeEevO6CthoQOLEnk8gV+IGZDrEWL0r3Mn7U167ZL+PpGm
   iz5jdVP4UJwpDRDcok7Z5J/K4LuGicmRGrZp0XTU+bk8enJ5oip/x8Ej0
   jdiF7xt+BBVai58XKvPfWyFqHhenWzyme+9/6FRY+nLjEXL5WdAY2GpGb
   DMi797fHFf989MEunDTEtDnn+tWthHOgNsULPNMGNAvgqV/zLcjg4PHDj
   ctCm669yhwIGjJm/GR4PPmrdfh4/WLGlaHeCcgnA3FLyaXaftzjFhsZGf
   zmNWbRIh9y9syfCGsjxYUtizquTIyciCAHNRtwkG18ITqMt5Mtp2L3WR7
   w==;
X-CSE-ConnectionGUID: 3cXDQEFQTiKiABD4sKgDVQ==
X-CSE-MsgGUID: T4K5iZnFSomi+zeWv2fCWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3066261"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3066261"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 01:44:48 -0800
X-CSE-ConnectionGUID: bSoWkVJCT6qZ8arLY0vwvg==
X-CSE-MsgGUID: FRvokAocTYCdx/JdTfgY7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8559683"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.71]) ([10.124.240.71])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 01:44:47 -0800
Message-ID: <0c53480c-770f-4568-b44f-cf13961d6f5f@intel.com>
Date: Wed, 11 Nov 2026 17:44:44 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y] KVM: VMX: Make handle_bus_lock_vmexit() a shared
 helper
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Nikolay Borisov <nik.borisov@suse.com>,
 Sean Christopherson <seanjc@google.com>
References: <20261107051725-failed-6.12-326fa2c9b4d3@kernel.org>
 <20261110151928.2074971-1-sashal@kernel.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261110151928.2074971-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2026 11:19 PM, Sasha Levin wrote:
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> [ Upstream commit 326fa2c9b4d3e6cab58c139eb55aaabd7179192e ]
> 
> Move handle_bus_lock_vmexit() from vmx.c to main.c to make it a shared
> helper so that TDX can use it for Bus Lock VM exit handling as well.
> Rename it to add vt_ prefix to reflect that it is a helper for both VMX
> and TDX.

TDX support was merged since 6.16. I think we don't need to backport this patch
before 6.16 since there are no TDX code to share anything and no vt_*()
functions at all.

> Cc: stable@vger.kernel.org
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Link: https://patch.msgid.link/20260819094903.3060020-8-xiaoyao.li@intel.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [ sashal: Replaced to_vt() with to_vmx() to access exit_reason in the existing vCPU structure. ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/x86/kvm/vmx/common.h |  2 ++
>  arch/x86/kvm/vmx/main.c   | 12 ++++++++++++
>  arch/x86/kvm/vmx/vmx.c    | 13 +------------
>  3 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
> index 27beb9d431e00..86d6753a0d867 100644
> --- a/arch/x86/kvm/vmx/common.h
> +++ b/arch/x86/kvm/vmx/common.h
> @@ -31,4 +31,6 @@ static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
>  	return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
>  }
>  
> +int vt_handle_bus_lock_vmexit(struct kvm_vcpu *vcpu);
> +
>  #endif /* __KVM_X86_VMX_COMMON_H */
> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> index 8a922ce0d19c4..089a544cba862 100644
> --- a/arch/x86/kvm/vmx/main.c
> +++ b/arch/x86/kvm/vmx/main.c
> @@ -3,10 +3,22 @@
>  
>  #include "x86_ops.h"
>  #include "vmx.h"
> +#include "common.h"
>  #include "nested.h"
>  #include "pmu.h"
>  #include "posted_intr.h"
>  
> +int vt_handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * Hardware may or may not set the BUS_LOCK_DETECTED flag on BUS_LOCK
> +	 * VM-Exits. Unconditionally set the flag here and leave the handling
> +	 * to .handle_exit() callback.
> +	 */
> +	to_vmx(vcpu)->exit_reason.bus_lock_detected = true;
> +	return 1;
> +}
> +
>  #define VMX_REQUIRED_APICV_INHIBITS				\
>  	(BIT(APICV_INHIBIT_REASON_DISABLED) |			\
>  	 BIT(APICV_INHIBIT_REASON_ABSENT) |			\
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 8e23e901a7593..a5614dd74e8cf 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6051,17 +6051,6 @@ static int handle_encls(struct kvm_vcpu *vcpu)
>  }
>  #endif /* CONFIG_X86_SGX_KVM */
>  
> -static int handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
> -{
> -	/*
> -	 * Hardware may or may not set the BUS_LOCK_DETECTED flag on BUS_LOCK
> -	 * VM-Exits. Unconditionally set the flag here and leave the handling to
> -	 * vmx_handle_exit().
> -	 */
> -	to_vmx(vcpu)->exit_reason.bus_lock_detected = true;
> -	return 1;
> -}
> -
>  static int handle_notify(struct kvm_vcpu *vcpu)
>  {
>  	unsigned long exit_qual = vmx_get_exit_qual(vcpu);
> @@ -6144,7 +6133,7 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
>  	[EXIT_REASON_VMFUNC]		      = handle_vmx_instruction,
>  	[EXIT_REASON_PREEMPTION_TIMER]	      = handle_preemption_timer,
>  	[EXIT_REASON_ENCLS]		      = handle_encls,
> -	[EXIT_REASON_BUS_LOCK]                = handle_bus_lock_vmexit,
> +	[EXIT_REASON_BUS_LOCK]                = vt_handle_bus_lock_vmexit,
>  	[EXIT_REASON_NOTIFY]		      = handle_notify,
>  };
>  

