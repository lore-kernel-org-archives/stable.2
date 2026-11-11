Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389384;
	b=BXn6hU6J3gcDxyqXnzDACc3/Nm5Jyjf7bgCQR5eeIElPcbJ3ifWWDWSF0j1shE/CsvKz
	 SMog0WN7xWJpXdMEYsigvOFbemvDUgrYYVUUvaPPZyGtdpmUJhygOKPbxWJrUe/ydfqI4
	 xQIRjR42Lk/a6H3IOq5rb1cq23dp2yQ5Acp6Rs0rAOs9DdhEUytuCzO9DCOHGJi1hbo3N
	 sHfOuVx/752N3oDlCDY7aeKRAoP5SCxcCWgZ5HxwHFN/40pA6jmI4MJqPFizA9Co7woyt
	 TPUvfmGZ23a9rl+wxOtTMJsugV/Zu2jcs1twrToSx+iDj0BCOIJ+t5E8k2up0vJI9FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389384;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=BXO0H+TyOgHRUlbds2Hg4gJpn24KgarijWqnBDSEl+c=;
	b=SIk2RCKBez9OVoEGfaQvnaxLAVuHhIYFLe/lbYNPzm4Q7YpurgpqhIMnrOMRrxBBikx6
	 au0fFeCXHWdivwfYkiDSTrOJqnui9+Te6g8K0ab71cDthxwD2b4i1KJ5eljoNCwabYN6R
	 ogEX8+Up0T0Ns1wque0tcurgy4de5PjHJcCBP4gMEtsw0/skXV0EHFNfvBms9ZhZhQi6K
	 5s2ZsIbp30jiME1KR1nJfcXhdsEpFn5M4BpcgyvohobgiNQ6CxJwmCxOUYCglRS0zzHfX
	 JAaziOWrtebhay1FSIEqQwb49nSXIrWiE2KfFZQ/fkX1m18X+EvqcimHM5fu2XNZjRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fUoHW4iv;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1353606A334
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1353606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fUoHW4iv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794389382; x=1825925382;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BADAe6Ay5L4MLKKT5lPnpfKwviZ527525Pue9Z9JehQ=;
  b=fUoHW4ivFNSFog9v23+v3g1NMl7GSgx7N1NyQpqyXICUSTJCVx1wX5+I
   rRyC3e72mkFnlpn07Z5Pgs9WXv8b5L/dQAVM2IIva1ykqknIbSkktRF0+
   LCs7L3uNeS8Da/ZgJeYEdIzfCF5s3FgXGDFd1mlsothi9UqCdJR0XcH/a
   4XyTCgpnsfRPVL1Mp34AD4XdBTGI/cb1tIuJYo9FSU5hziko/ql+Enoy5
   pkZAeMBq8IbMEE59hy9ljOjDRRHDtW+itCTZsH4SmDE5/oWvQuIhZjW5K
   B524PP4IocCpfuC7M5Wvm7Klg55uudgTFX3Z7OBOwy8K6qDVYwPHRQFzX
   Q==;
X-CSE-ConnectionGUID: IOx37+jIT2qNl9my6QyN1Q==
X-CSE-MsgGUID: AWBTqvRvQma/XuK78Rz7WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3064460"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3064460"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 01:29:42 -0800
X-CSE-ConnectionGUID: OPHRV1Q4S9mnsaei0GT+RQ==
X-CSE-MsgGUID: kkhsXIJqTTS8T2mmrPNC0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="10107143"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.71]) ([10.124.240.71])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 01:29:41 -0800
Message-ID: <4b44bfcf-9a4b-4dae-9546-94c42d4b7559@intel.com>
Date: Wed, 11 Nov 2026 17:29:37 +0800
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
Subject: Re: FAILED: patch "[PATCH] KVM: VMX: Disallow using to_vmx() in
 common VT code" failed to apply to 6.12-stable tree
To: Sasha Levin <sashal@kernel.org>, seanjc@google.com, kai.huang@intel.com,
 binbin.wu@linux.intel.com
Cc: stable@vger.kernel.org
References: <20261107051723-failed-6.12-f305fd31f52a@kernel.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261107051723-failed-6.12-f305fd31f52a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/2026 6:17 PM, Sasha Levin wrote:
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

This patch doesn't need to be backported to 6.12 and earlier stable trees.

Because, on 6.12 and before, posted_intr.c uses to_vmx() and it causes building
error with this patch.

> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x f305fd31f52a8d3ce4d2bf0c88c45bb7a373809c
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051723-failed-6.12-f305fd31f52a@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'
> 
> Thanks,
> Sasha
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From f305fd31f52a8d3ce4d2bf0c88c45bb7a373809c Mon Sep 17 00:00:00 2001
> From: Sean Christopherson <seanjc@google.com>
> Date: Thu, 3 Sep 2026 18:03:46 -0700
> Subject: [PATCH] KVM: VMX: Disallow using to_vmx() in common VT code
> 
> Poison to_vmx() in main.c and posted_intr.c so that attempting to interpret
> the vCPU as a VMX vCPU will fail at compile time, as opposed to failing at
> runtime, or worse corrupting state without outright failing.
> 
> Note, to_tdx() is buried in tdx.c, i.e. isn't broadly reachable, and so
> doesn't need the same treatment as to_vmx().
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Tested-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/20260904010353.3175819-2-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/main.c        | 2 ++
>  arch/x86/kvm/vmx/posted_intr.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> index 4c52ab8d07869..ea0d825e556d2 100644
> --- a/arch/x86/kvm/vmx/main.c
> +++ b/arch/x86/kvm/vmx/main.c
> @@ -10,6 +10,8 @@
>  #include "tdx.h"
>  #include "tdx_arch.h"
>  
> +#pragma GCC poison to_vmx
> +
>  #ifdef CONFIG_KVM_INTEL_TDX
>  static_assert(offsetof(struct vcpu_vmx, vt) == offsetof(struct vcpu_tdx, vt));
>  
> diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
> index 4a6d9a17da238..24221ba553be1 100644
> --- a/arch/x86/kvm/vmx/posted_intr.c
> +++ b/arch/x86/kvm/vmx/posted_intr.c
> @@ -14,6 +14,8 @@
>  #include "vmx.h"
>  #include "tdx.h"
>  
> +#pragma GCC poison to_vmx
> +
>  /*
>   * Maintain a per-CPU list of vCPUs that need to be awakened by wakeup_handler()
>   * when a WAKEUP_VECTOR interrupted is posted.  vCPUs are added to the list when

