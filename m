Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B329471270
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129667; cv=none; b=euvV5BxKNRezLgDSyzzFgeaf7XLJmGgGdEYWfUTrsZOe9jxTSc/M7fapUduNEWF3GgRWxrtciZ8pn+J0KKwoW5mnJTHtjhqnvH4ixoOH6m9fWgfzp6QxX/TWRz2lLgvC0FuPaBQvPCFJKKXt2mO98bvq2xMdm34QWc1FUJ903l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129667; c=relaxed/simple;
	bh=rKZ5drMywbU7SzrJWghzpM5mIrZoFCFQLkPTMkOLXrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ws4EjWKmJqQ5RoBElOK1XUNIB13RjGW8nAmH8QG4AAd2Xk18/IKtJInA0CnAUX55/YvR/8DIPx0Ja1HOocMubaQsfIZm1x7hhPrSTLX6oQKh33mA3mTG1yUwwxAdcpM06Pp1VS25yatMzPC+YVQCPGMmTXdtcjWIhjhWHzIkYXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=CNHt3HiI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ndt4Jyiy; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="CNHt3HiI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ndt4Jyiy"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 8E59C1D0010C;
	Fri, 11 Sep 2026 08:27:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 11 Sep 2026 08:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789129663; x=1789216063; bh=8C71sEG1xO
	FOBwPbqeegSamwylFA1dVamCqv49junlw=; b=CNHt3HiI73Z9yXmAKJiSHEG2bK
	zNyddj6nGewGKCHWhTmNrZj7EMiq4gfWBIKFBdWKXJlVphRFxHMGmZ+EKmweQFKD
	bGj+Mu9onYjIHUKZ3R92CSW69Twpal0xqIjkmdu8063W9NNzJKaqYvK3prReL8jq
	9RT22xYOwtM9LiNUIvRtrZR1MsNbG3DWPW9bfedBu/imGLShFiQBrQ6r1E7m6qz0
	BPSvG/tgnhO1CaETgOIWkV6mnF4dMZYUzomxA5KXZEsvOWi+yqKtqH81VhBFYUaU
	R6/XkQpuMzx/IbIJagFl289+pROcXe3BD1WVJO6GlbKzMds6HJmwKisbE7LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789129663; x=1789216063; bh=8C71sEG1xOFOBwPbqeegSamwylFA1dVamCq
	v49junlw=; b=ndt4Jyiy00ZCyMLdjFDyFJpNkbuLbpVWjq8jOCkP6pHbMYWWcHU
	NBo5exn3C9TTLUQ/oaG+KxhWzBSw8MUjQ3u6Ythmq0QsesYC3G5umkVHGz0Z9ZmO
	2auEiKE3Z0ouXIVQYVkGBJqEaFl5ZMkz48zjBJW62Hz2csODuyNXZGAPY9uM6Cuh
	wZbOYbwVHk19rcZssLoYiKD74uINgspk1XpTwlPVjoQiE1kF1Zp0H+H8Orscdyml
	+Qa9bUsNZmtVRl+e6RZwfukWVaX4nSyi0L0JtHnTV8mQSVe1kpUQWNN0l3q3BP8d
	zwn87O2IVqtbZfmsn1gTHbOjFK/x6ARgTcg==
X-ME-Sender: <xms:vvOjagAfyulWbDU8YwtRUjEIXvpO4Eo_18vvIVa4Y8fe_EUyWfd74Q>
    <xme:vvOjau6yyffTGGbzFsqxUgb4woL3x__L3L5E75sBS7TIIPTp0aL8UVRmkyZ-ovdEE
    Tqr-wjtOwLrJaAp82cvvnOPSIOH--SjXc6vdZJeUF-0NU1p7L0>
X-ME-Received: <xmr:vvOjaoCUxlH0U1sMWOqrjCjXF9jTABLODtiQ376C7UxgWCDc1QcRNqXpHJDHu_wQqgGnEk2ZnIijYCocSymJdQcAVGI8IL27stAFyA-ZpSo>
X-ME-Proxy-Cause: dmFkZTFnJoqPX/SvSsMz2X81YVkc1CqkrfSOWB2lWeDVr4RRSfmdSQBURJAPaYgm/eh/9w
    zQf0dL3o0U3HaQxsW5GbKHmCdMQo7116FclMj5SCSIDS3W6wlURX0MLWWvp196303+LiXh
    b7T3CKqCy14N7x2y6Z/Hoq3GonvVniPfK941BcOG2+KZU/etcDIb354pTKsOMILbU6CYFu
    swXjklHpZd1y3j8mHqy0MgzWRpy7UopdWa8EOb3ZkDdV+P4wUd5KwuxsSV4H/337EVEGKJ
    i4eeKvZVztuTCLCkxqH/HLbN7pClN3/AsC9dxZfdL7USGD6v6m5L/ZiQalhygPSexHbqBx
    DpoJzqZQ2QkUHgd8X23h1MxHrUr5Q6Bc9fyEoCB6gc6XncGf+YKjOmEQkn/0hFr7j8Hs+R
    0fBb0F05XyYlTgg+NLXo1mnuXBuXck2jEUpJuNRkT+PO4cPvfWZB3DPF9Y/T7WQPn84iBp
    LsWG7dQE/n7VQYpmpVFfe3CIGrhzOa9tcdXiqzwwSS9LfDgpZjV3Y6E1GPywZ7eSmNLjmh
    7q8P7fHR+svwbSwDj6vkxveHYL8hR7E7jWmbfYaZJFWvoubUnAWzf/8qq3FnWs5UDpbxI4
    xkAzABo4LG5jGhsbjKwuM+Ne8Kv+DzeOaRV5ce7ADzmCR8ep04dnnXv0bUPQ
X-ME-Proxy: <xmx:vvOjak5PLajPT6YaUhkZWofA3QyC48CHpnGj72PWiXilTy7qqdmdvw>
    <xmx:vvOjaht4Ob0hPN1rzc57P_vOShJEhCjZXH9DdVJIinMaB7ScIc0hBg>
    <xmx:vvOjap6Jq3Fb227ct9SvcXqTWQTVnJBpVqJfmRcLTRrrReraVwWYhA>
    <xmx:vvOjal2RgPmMqcFtJFmRiOGdOMkHLOtwuIyPIEx_lysLiP8diyUxIw>
    <xmx:v_OjavXrgCcEvyz2UBGZorD1DyxGpJM1iqkiFnZzOafa8zNrPZlvdQcQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 08:27:42 -0400 (EDT)
Date: Fri, 11 Sep 2026 14:27:33 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>, Yosry Ahmed <yosry@kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 7.2.y 1/7] KVM: x86: Move tdp_enabled from kvm_host.h to
 mmu.h
Message-ID: <2026091128-scope-marmalade-2b92@gregkh>
References: <2026090906-angling-trickily-a20c@gregkh>
 <20260911104136.194961-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911104136.194961-1-sashal@kernel.org>

On Fri, Sep 11, 2026 at 06:41:30AM -0400, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit af0dbcaaa2bbc90ba8e6f696be725c4522face08 ]
> 
> Relocated the declaration of tdp_enabled into mmu.h, and opportunistically
> hoist tdp_mmu_enabled up to the top so that the two are co-located.
> 
> No functional change intended.
> 
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Message-ID: <20260613000329.732085-9-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Stable-dep-of: a4b8acd428ba ("KVM: x86: Always initialize EFER reserved bits on vendor initialization")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 --
>  arch/x86/kvm/mmu.h              | 12 ++++++------
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 6db5b5f79df9b..891c47a5607fd 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2148,8 +2148,6 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
>  
>  int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
>  
> -extern bool tdp_enabled;
> -
>  /*
>   * EMULTYPE_NO_DECODE - Set when re-emulating an instruction (after completing
>   *			userspace I/O) to indicate that the emulation context
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index e1bb663ebbd58..016a9fe60222e 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -7,6 +7,12 @@
>  #include "x86.h"
>  #include "cpuid.h"
>  
> +extern bool tdp_enabled;
> +#ifdef CONFIG_X86_64
> +extern bool tdp_mmu_enabled;
> +#else
> +#define tdp_mmu_enabled false
> +#endif
>  extern bool __read_mostly enable_mmio_caching;
>  
>  #define PT_WRITABLE_SHIFT 1
> @@ -261,12 +267,6 @@ static inline bool kvm_shadow_root_allocated(struct kvm *kvm)
>  	return smp_load_acquire(&kvm->arch.shadow_root_allocated);
>  }
>  
> -#ifdef CONFIG_X86_64
> -extern bool tdp_mmu_enabled;
> -#else
> -#define tdp_mmu_enabled false
> -#endif
> -
>  int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn);
>  
>  static inline bool kvm_memslots_have_rmaps(struct kvm *kvm)
> -- 
> 2.53.0
> 
> 

Series also does not apply :(
