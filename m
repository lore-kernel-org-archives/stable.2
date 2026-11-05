Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860382;
	b=npWeue18FpgJGLSIm1pQnAs09bfCMlbInxzhGcTsiC+TA3DysZ4eEpgh+Usd3Oz3Xz/v
	 /Pe6HrumQ8/x++ACcx/qN8FUMI5Xx+5WfpdpL/Ig7nDxaYIDUXepvl1MHggS8Y3Ul/2H2
	 dqSVq0EOc6EuZxyEKcNbxagXQJ9+snCIUh4MpNWjXGCtyn6ILJ2icakEm7IOizSRX0m3+
	 /HE5b8J9vv3qaQoY7SEyXAuMR+shozVY+WcII9XbQalcwwxip0lgwqeHDyGanUyDt5KzY
	 kDxjHi62qXY1BTaotMkzNzdvVXBbLdt8AKypmkA7YcY5IvS1lB6S4MA/A2pPA2+fxWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860382;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=i9lUQhKTJARLIGZRhVPiKhYepIMb4qgefFmvf1eFIYU=;
	b=CGujyaqJeiY9Psbpux5lKBkiOJ+c8+WCUkU+CP/UsxW1Z9EnfQ3kcW9RdvI6KFAOuiLV
	 q3AgCRKyMZVSDD7y/q7uE7W7MvG6UWAr72GLjaYyfNrZ5OtWe5h/3nKIbalgZpkEdWjV/
	 nIX7wjIi3SoeBMmyyUCgqAg1RA5T/x4+sT04S4ASC5K8yHvxRBxpmvzqeWdmXWbqSqAu8
	 Z+9Q4F8i1ktGprkCLTkoMlGSB8wdqy3Hy/zAQ5yaxzoT3SiiT7PnuVggahYUHRHMMQRJ/
	 8KyNDRlZD4FlvDljS+rOXRJAsS7Yzr4wD8M6mPCOcyFUEHlwp5Up5j64EoRs9cLLlAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BtweYb3c;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA03606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 06:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAA03606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BtweYb3c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793860381; x=1825396381;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8P3cdLGyuNT+F+1XsXoqEW14jcmXDRbaqV2gGMoUKVo=;
  b=BtweYb3c0/RYqnEH2AMQ0+flgnjw2brHBPEGtkKQ5ijwZUlPa3zcTgAG
   HvyxOYfAZ31Jg1Wz/fkuNWVP07fySE4naduAfG/BFbwnhImXan05K+xDh
   atgygwhnlfLeG47BYxvcLepEmh5FIk4dE4h+9bX2oBpDq1pzo58/0e1Uu
   bnPZXc5Bp/eTkHn67zS6XYuOrvdI3JVZda/Qx6izoShZzDZWsSp1QLypm
   i2Q6/z7iPpCX2+bAn9iOxhcIjveZ1BFTHP89LnFbe15Hk+m2TDGSgaOOc
   tbFRvwV16pSdzeBQ64ibZ/Nq/RSLvYBhn4WsL/qDoKILTDxtHtDfe8/Rj
   A==;
X-CSE-ConnectionGUID: LeaAMfY1St6hq9o4ePxlDw==
X-CSE-MsgGUID: k1HW+fVnRXiTw4xnt3yTOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2534429"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2534429"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:33:00 -0800
X-CSE-ConnectionGUID: uQG8tVdDQjOCyiQ0Cc2Wkg==
X-CSE-MsgGUID: GxcZXKwASKu8KWM7dtGUWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7048378"
Received: from unknown (HELO [10.238.0.97]) ([10.238.0.97])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:32:59 -0800
Message-ID: <3f991366-7a8e-443d-bce1-9ad14c20386f@intel.com>
Date: Thu, 5 Nov 2026 14:32:54 +0800
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
Subject: Re: FAILED: patch "[PATCH] KVM: VMX: Preserve negative return value
 in vmx_handle_exit()" failed to apply to 5.10-stable tree
To: gregkh@linuxfoundation.org, seanjc@google.com
Cc: stable@vger.kernel.org
References: <2026110401-siren-occupancy-2a61@gregkh>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <2026110401-siren-occupancy-2a61@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/2026 3:19 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

This one doesn't need to be backported to 5.10-stable. It fixes fe6b6bc802b4
("KVM: VMX: Enable bus lock VM exit"), which was merged since 5.12

> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x cef48693da1e964e9f192bfc16cd0ed287c48337
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110401-siren-occupancy-2a61@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From cef48693da1e964e9f192bfc16cd0ed287c48337 Mon Sep 17 00:00:00 2001
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Date: Wed, 19 Aug 2026 17:49:00 +0800
> Subject: [PATCH] KVM: VMX: Preserve negative return value in vmx_handle_exit()
>  with bus lock detected
> 
> Preserve the negative return value from __vmx_handle_exit() when a bus
> lock is detected, instead of always overwriting it with 0.
> 
> The purpose of bus_lock_detected handling is to force a userspace exit to
> inform userspace that a bus lock happened. The negative return value can
> achieve this purpose, and changing the negative value to 0 fails to return
> an error to userspace. So, preserve the negative return value.
> 
> Fixes: fe6b6bc802b4 ("KVM: VMX: Enable bus lock VM exit")
> Cc: stable@vger.kernel.org
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260805034602.5B2BB1F000E9@smtp.kernel.org/
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Link: https://patch.msgid.link/20260819094903.3060020-7-xiaoyao.li@intel.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 965141e0d4c8..6df390ae8708 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6864,11 +6864,12 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>  	 * a bus lock in guest.
>  	 */
>  	if (vmx_get_exit_reason(vcpu).bus_lock_detected) {
> -		if (ret > 0)
> +		if (ret > 0) {
>  			vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
> +			ret = 0;
> +		}
>  
>  		vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
> -		return 0;
>  	}
>  	return ret;
>  }

