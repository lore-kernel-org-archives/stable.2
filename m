Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EE637A84A
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829876; cv=none; b=QIzoXmtGwF0vp/yTeSVXGQWdTkOfPqmOK+RrVrcAL4a6EgadthY0rA+gDg1YwNwLx72kW1YMcPCwuvncum8Wd0buE/NFZ/CeiPkRBoRW4N8PWbNchFKjUsypOfZ2yHpUdoV52kOrpyy6i3QsDpUWQsRgBtKuuQJckUHjEonckAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829876; c=relaxed/simple;
	bh=FA8+57wcob+MTE9XfqIzqO6YaSWzXTaxb3eQ5Poz4N4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GbfWxJaOICkHbVtdFPBNjyk1EsLejuDIN3ubid2gAOrsor5eWKLamnbIanRmWi8jq7lSNjjLS2b63p0XwwKbJ1zFuCiDDIDwBr7porEeKl0kOS2gvXBDuNGXtwY5k2rfzoNcQ0opTqoAT7198g2IINEeIP5VOSPW247SERjC/Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qISaaorR; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qISaaorR"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e2f61c09dso1479777a91.2
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784829875; x=1785434675; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qMh/62kafhHoFqv8DTLKCjWgXtXQT4BcRTSx3NgtOZw=;
        b=qISaaorRn4x6mALglXYa7lb1udanD9ZaAeYPpaG3uFmc5Emm6AyQQjWFdoHw9K/mkY
         /68fqaNIfzbcuo5vGTNtWyvDu1f1rSUhUOFg9gVxxvN5wLB3Q6jHaNhln/H06pfyNvkH
         g3CE0UmK8MMJrlbeS3g8Ub+U19vPDNWi7yO5gyaA3/c2hTW7W3nBrci/lZfKdaC47zTy
         mFvCh4S9ArPtRrRdHvnNHXd5Stc8kUAUkI0UN17m8Umnx3lZX8eUjrI9okq0SRocSArg
         s0fiWkhxsXRPcVO4U3iTc5HiAIBp3NVJMhELS7byw+ivE2MTtSUbMdMXsEP5tuc7EXnj
         6nAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784829875; x=1785434675;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qMh/62kafhHoFqv8DTLKCjWgXtXQT4BcRTSx3NgtOZw=;
        b=S1NAjFV+8qx7b0Q2DHjOcToexqAmURWwEIKVq2UOmjFnHg+18Pu09IQXAWgqC5wbLw
         oiLMQTOZQ2L6flxfxX45zXqAY/Gb5R+Kymykiy/wccE7mwnc/uYJSCxW+AwTjGhYgfHJ
         vr8aXlUB9BRrhB1LqJEesiwRoz3BDtYIbnGq02c6AoZypS/ysDLQg9p6ZCAtmoiJVXq9
         SXdSD8p3GmZDPiYyFVw/lDtb082vzQh9mjNVY5rw1Z5Ej+AzS5ZQbIQA0Q9GcVjwd9M2
         63mx3qie65PmtnF8dQnOVnzfonHV0zClY4566Qky4oz0mENuvYBtBZIG8MrzvdliFMTc
         CU1A==
X-Forwarded-Encrypted: i=1; AHgh+Rrt3w/NfK+oHfbNmGZAFtJXG8hOkvDWV9GLp4kxlRKGrDk1LVrWgyNIF9CMFPKNnEsIVdjlqQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxVbyEayiyGKsKBLBEngAnMM3TpyeRElkS/v0dgguGdi/rt3ci
	VnA1FUymuMc8j/5NQiO/lx2ol9iLCGirTZGTSLWTBfKAE7wZgNXardilWuKoV46HvKJoujr2Ots
	YcGQBnQ==
X-Received: from pjd6.prod.google.com ([2002:a17:90b:54c6:b0:381:224:393a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5146:b0:38e:6f72:9be4
 with SMTP id 98e67ed59e1d1-38ec6495a15mr4529269a91.3.1784829874614; Thu, 23
 Jul 2026 11:04:34 -0700 (PDT)
Date: Thu, 23 Jul 2026 11:04:33 -0700
In-Reply-To: <20260720205208.519622-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720205208.519622-1-chang.seok.bae@intel.com>
Message-ID: <amJXsVGv3xe7GKu1@google.com>
Subject: Re: [PATCH v2] KVM: x86: Remove AMX-TF32 enumeration
From: Sean Christopherson <seanjc@google.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	stable@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 20, 2026, Chang S. Bae wrote:
> AMX-TF32 enumeration was added based on the Intel documentation [1]. The
> recent update removed the feature, indicating that the feature is no
> longer planned for hardware implementation.
> 
> [1] Intel Architecture Instruction Set Extensions and Future Features
> 
> Note: The feature first appeared in the September 2025 revision of the
> document and was removed in the June 2026 revision.
> 
> Cc: stable@vger.kernel.org # v6.20+

6.20 isn't a thing.  And given that this is clearly associated with a specific
commit, just do:

  Fixes: 58cbaf64e653 ("KVM: x86: Advertise AMX CPUIDs in subleaf 0x1E.0x1 to userspace")

and let script magic sort out the rest.  No need for another version, if we
agree that ripping out support is the way to go, I'll fixup when applying.

> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---
> V1 -> V2: Collect tags (Zhao, Binbin), put note (Binbu), and cc @stable
> ---
>  arch/x86/kvm/cpuid.c         | 1 -
>  arch/x86/kvm/reverse_cpuid.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 591d2294acd7..759a1c557080 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1082,7 +1082,6 @@ void kvm_initialize_cpu_caps(void)
>  		F(AMX_COMPLEX_ALIAS),
>  		F(AMX_FP16_ALIAS),
>  		F(AMX_FP8),
> -		F(AMX_TF32),
>  		F(AMX_AVX512),
>  		F(AMX_MOVRS),
>  	);
> diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
> index 2ad25781cefb..1bb13903c5b2 100644
> --- a/arch/x86/kvm/reverse_cpuid.h
> +++ b/arch/x86/kvm/reverse_cpuid.h
> @@ -56,7 +56,6 @@
>  #define X86_FEATURE_AMX_COMPLEX_ALIAS	KVM_X86_FEATURE(CPUID_1E_1_EAX, 2)
>  #define X86_FEATURE_AMX_FP16_ALIAS	KVM_X86_FEATURE(CPUID_1E_1_EAX, 3)
>  #define X86_FEATURE_AMX_FP8		KVM_X86_FEATURE(CPUID_1E_1_EAX, 4)
> -#define X86_FEATURE_AMX_TF32		KVM_X86_FEATURE(CPUID_1E_1_EAX, 6)

I'm not convinced that yanking out support is the right move.  By publishing the
feature, for several years, Intel pretty much burned that CPUID bit.  E.g. it's
not impossible that someone other than Intel has implemented TF32 instructions.

The opcodes are fair game in the future, because their use can be qualified and
guarded, but the same doesn't hold true for enumeration.  E.g. similar to how
MPX got ripped out and its XSTATE assets got reused for APX, but the CPUID feature
enumeration is forever reserved for MPX (I hope).

If the argument is that "Intel Architecture Instruction Set Extensions and Future
Features" isn't binding documentation, i.e. that Intel can do take backs until a
feature is documented in the SDM, then I honestly don't see any option but to
refuse to accept new features until they land in the SDM.  Which I don't think
any of us want.

>  #define X86_FEATURE_AMX_AVX512		KVM_X86_FEATURE(CPUID_1E_1_EAX, 7)
>  #define X86_FEATURE_AMX_MOVRS		KVM_X86_FEATURE(CPUID_1E_1_EAX, 8)
>  
> -- 
> 2.53.0
> 
