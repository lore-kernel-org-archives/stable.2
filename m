Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485E73E95A0;
	Tue, 21 Jul 2026 00:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594251; cv=none; b=L5gM2rjJHz16lhieV04PkGksHY3JT7Ho9Dclppd3vAd3jxT6c8c2gKQ79xLfLIcGWz2FYCibBGtG7CC9HIe8tX8AorZnebrknXkTByGiv2MsEapxtz2ZHtZ1c9ilJoqKYPOSHxrcZIb8bblfgDVjYxBpOtth3prL2mwDyDN/nC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594251; c=relaxed/simple;
	bh=xe8V8/lM28GRpy62dcipQyokgnfte5mcd3RxhguMFgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V++l6LGy7sXkXuToOwoylsUnTQrrr9VxGkWVGFy5/iAYoXKuwL8byaME8lBO2zm0R6pUQsugrDIDq15jA373R8C7bWZDzW1ZBXfCoGOhJ8SlHymOkQ96J39ZTUSpYNif1bATl1X8LVC2qM4621eZ0obIF/j1swNZNvr3QvhS2uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jf9hj4X9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jf9hj4X9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784594250; x=1816130250;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xe8V8/lM28GRpy62dcipQyokgnfte5mcd3RxhguMFgU=;
  b=Jf9hj4X9HF6pNxqFIWIEYrLuM4GwWDZmNh5KG9QSh0zHJjhZuJJb/LZl
   WBj5XmTgpsyKzgDoza0VXKB6549Zdtd1+B38WphnO5mWExDfLCA8zzX/y
   4UClaCuv3z3ic765EIj99qUrO9OKnb6shEwkIT6Tj6HUbzAL8OTp/6MXM
   D5cO1bU35nL1RyjkwZkqDf5dz3eQz+LJi/v1/FmFRem7BoqUZ2ho41Mqf
   pwHJkR0pjWA2yvvHN/0A07lYQCYXbU0nDNpLgyFgXc4T2Mp6FNGybw9GT
   y7NOxx/ssl9OkuTRWbPG7/pkw5eijVGXln5Vn337QtW+lKxcJB2a128AL
   g==;
X-CSE-ConnectionGUID: Tj4Zo/M5SCqbKWxlb/8dnA==
X-CSE-MsgGUID: Oaq9WP+ITMue8/MzjkQxww==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="96544679"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="96544679"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 17:37:29 -0700
X-CSE-ConnectionGUID: FkU5R4aaSbaC5UM/aHpRrQ==
X-CSE-MsgGUID: XglyZnC6Tk2p+rTgKlOczA==
X-ExtLoop1: 1
Received: from unknown (HELO [10.238.208.132]) ([10.238.208.132])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 17:37:27 -0700
Message-ID: <f1ace36f-bbc8-4537-928a-98e0d61d61a3@intel.com>
Date: Tue, 21 Jul 2026 08:37:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: x86: Remove AMX-TF32 enumeration
To: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com,
 stable@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>
References: <20260720205208.519622-1-chang.seok.bae@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260720205208.519622-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/2026 4:52 AM, Chang S. Bae wrote:
> AMX-TF32 enumeration was added based on the Intel documentation [1]. The
> recent update removed the feature, indicating that the feature is no
> longer planned for hardware implementation.
> 
> [1] Intel Architecture Instruction Set Extensions and Future Features
> 
> Note: The feature first appeared in the September 2025 revision of the
> document and was removed in the June 2026 revision.

The feature was first introduced in revision 054, October 2024.

It's recorded in the revision history.

> Cc: stable@vger.kernel.org # v6.20+
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
> V1 -> V2: Collect tags (Zhao, Binbin), put note (Binbu), and cc @stable
> ---
>   arch/x86/kvm/cpuid.c         | 1 -
>   arch/x86/kvm/reverse_cpuid.h | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 591d2294acd7..759a1c557080 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1082,7 +1082,6 @@ void kvm_initialize_cpu_caps(void)
>   		F(AMX_COMPLEX_ALIAS),
>   		F(AMX_FP16_ALIAS),
>   		F(AMX_FP8),
> -		F(AMX_TF32),
>   		F(AMX_AVX512),
>   		F(AMX_MOVRS),
>   	);
> diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
> index 2ad25781cefb..1bb13903c5b2 100644
> --- a/arch/x86/kvm/reverse_cpuid.h
> +++ b/arch/x86/kvm/reverse_cpuid.h
> @@ -56,7 +56,6 @@
>   #define X86_FEATURE_AMX_COMPLEX_ALIAS	KVM_X86_FEATURE(CPUID_1E_1_EAX, 2)
>   #define X86_FEATURE_AMX_FP16_ALIAS	KVM_X86_FEATURE(CPUID_1E_1_EAX, 3)
>   #define X86_FEATURE_AMX_FP8		KVM_X86_FEATURE(CPUID_1E_1_EAX, 4)
> -#define X86_FEATURE_AMX_TF32		KVM_X86_FEATURE(CPUID_1E_1_EAX, 6)
>   #define X86_FEATURE_AMX_AVX512		KVM_X86_FEATURE(CPUID_1E_1_EAX, 7)
>   #define X86_FEATURE_AMX_MOVRS		KVM_X86_FEATURE(CPUID_1E_1_EAX, 8)
>   

