Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613163CB918
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695219; cv=none; b=lt/qz+N+59bRemigEaJpRS9uG3aHwCrWoNgTlm/+QdWifLOxlYc0CHmNa3XSjbOblyWKFbdDds3ceGk9Qw0yVPZ9zz2dmEBpsh//Uu3GFoLhSRRO5ayjwZu2ggPyh4F6zhZ6nD5cK+VwX/xvEFs6PEy4YuwDZKiLK+OWM+blIrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695219; c=relaxed/simple;
	bh=CN3hTnHGTzcazerSqLwxWW1GpSBEGf3IG1NQptlmTJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzR56MMl03lb+20V6S4VawYs7pSxJb3NUDC4lV27R581oBv3kEsT7jknODAoi1pTVX6n6ckgjMUv6UTdyrYxolfRnm+F7hUA/A255tQjtm5qQS4SXCggIT4fNIU9YuRFLh7gkldmCsx3X/wsaludSjYDzXJVLr5l3TZDS5ctkeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecEorMHW; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecEorMHW"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-399389dae7fso8614381fa.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 04:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781695214; x=1782300014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fEPBS2XQIGG150Y2esIPhsZu4HIK10nFbPjkifBbsWY=;
        b=ecEorMHWxYRrFshldT4/9/HxINnrxEwiWHKpjj6NiVHDowYEgdGiP/kEd7VTQZF28F
         ySgjjBkQYPSPB2u6Hy+r+6kvnJqRsouiSykcEf6loKSJAPbLZCufdjF+GMEtO48Oy+8M
         2G3N0maccsgvVmClYCSGeoNm1f+HeAEfVP9Fr3Ewm6l6g5KrV/fpz2Ix/Mxv+cnE23EM
         CFLz84P3IhH4iJjQDYvOb2l9LtKxU0u4tyzbgaWWJ9v8uvEuCsTIeSb6INi1R7NM7+GK
         GJUN404Z7BvolbDAm33V4jvoi/zdw/V0YQoMkIV1kOAps7YMrE40RRpOAc9hadzs5m8F
         rtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781695214; x=1782300014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEPBS2XQIGG150Y2esIPhsZu4HIK10nFbPjkifBbsWY=;
        b=ZvnObjsl/xIQKxKLT5fcZw/H1ddLL8oL6fRKhpmxsBsUi16ez7aigXUP0jsx1YJswP
         WTnbuQtj7jilCYLWK8T+QYBpKE26SN8+d2T8OTQ03tygbg1ARj6jqELylBahOaskixl2
         HuV8QOfyvL9QUEgjXUVJZ7eRoq2vdxCIWGZZByaM5mZY0BO8LP5kaGzGrrrR+epwY75W
         ++4QnfPu00hgI/tkIRO3J0AMPqCkAEVhW1gIKIwg41VAYOAIzjuWwVZMzOjhiidcL8YQ
         llb1qUml3n8w65cjfSTvmf2l2kIQl104cgRiXv2cLto1FkKtJKQTocx3lVmxWcBj3FlX
         p+Nw==
X-Forwarded-Encrypted: i=1; AFNElJ+YPo0nzcg4BxZl/+1/rOACZ9NVYPp71wOm3KtrmD7Cj0W6UaJTcJ6G16ZzYCE9Ldms+uar56g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgJvD9zN2dZL6c7oFiXjkHSWSdlmP5MgYoTgdSjFzYh+ZGNkcW
	Ul8wANJe2VxvNefcjxbwZaioW4zoYDmqtmUX2iGG8f4FBweCi+vghZ55
X-Gm-Gg: AfdE7cl4mEQajcFP4UOBGoNLW2J1H3EimUs1EmYbJbQJ/oFATn64TBceizHZDSZdCeS
	0XujN7qkZqBqZeZmxqhG2vSkFPJIHOCh4yHnKK7Su0V3s47a02jszRLHCQGz46iCwIL+nHfNEzK
	paD/IbaBoPGxPfFOuy+i7KRT4v/fWa+00Yop3i9EszfNR7IKw2BC+AsXIJYhFpUNky/HNN3RT7o
	N8/QxrWBzJC1vxwk8Gl7i1eMrlmY6FmljbA8yC+5RFZepGUlbqjd0wbj9mFDcRcSTuAoa7endOJ
	2w9zjDXvPGrLgroLzMB3yAiu/18NPoZASAhX9TR4L5/wMHRvhfX80HSxMD2XLfk/NnKPo7I5CPi
	3GCX8W9s4b6upqbubyVKfit4L1icLrjAD0yVslJnQzbKOMIedDhHaMoKe+P/kF4fzY4uIImLyQy
	kwGL3KQ0ig+3X5whcGm4Y6c5VcEJDqPoNxL98loYzdBLuouaBUhGMmHXctNGYsTx0jaLoRe6cUu
	eISTqyEv8UfSmrvuy5px2NW/3NUuGY+Y65oRqqQrEiAF/HULg==
X-Received: by 2002:a2e:a594:0:b0:38a:5bf2:80d6 with SMTP id 38308e7fff4ca-3996a013db5mr9545231fa.5.1781695214065;
        Wed, 17 Jun 2026 04:20:14 -0700 (PDT)
Received: from ?IPV6:2001:14ba:6e:3100:ab3:3fa0:bafe:f56b? (2001-14ba-6e-3100-ab3-3fa0-bafe-f56b.rev.dnainternet.fi. [2001:14ba:6e:3100:ab3:3fa0:bafe:f56b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3995c191cd8sm14748111fa.20.2026.06.17.04.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 04:20:13 -0700 (PDT)
Message-ID: <09f69783-3eca-4318-b09b-78e6730e899c@gmail.com>
Date: Wed, 17 Jun 2026 14:20:12 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] KVM: VMX: guard regparm(0) on
 vmread_error_trampoline for x86_32 only
To: Clark Williams <clrkwllms@kernel.org>, stable@vger.kernel.org
Cc: bpf@vger.kernel.org, x86@ekrnel.org, kvm@vger.kernel.org
References: <20260617011303.3969027-1-clrkwllms@kernel.org>
 <20260617011303.3969027-3-clrkwllms@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?SGFubmUtTG90dGEgTcOkZW5ww6TDpA==?= <hannelotta@gmail.com>
In-Reply-To: <20260617011303.3969027-3-clrkwllms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/17/26 4:13 AM, Clark Williams wrote:
> [ Upstream commit 0b5e7a16a0a79a3742f0df9e45bca46f01b40e6a ]
> 
> regparm(0) overrides the kernel's -mregparm=3 convention on x86-32 so
> that vmread_error_trampoline receives its arguments on the stack, matching
> the inline asm callers that push args before the call.  On x86-64 the
> attribute is a no-op and newer GCC now emits -Wattributes for it, which
> becomes a build error under -Werror.  Guard it with CONFIG_X86_32.
> 
> [ clrkwllms: the upstream commit redesigns the trampoline declaration as
>    an opaque symbol; this simpler approach guards the regparm(0) attribute
>    with CONFIG_X86_32 since the attribute is only meaningful on x86-32. ]
> 
> Assisted-by: Claude:claude-sonnet-4.6
> Signed-off-by: Clark Williams <clrkwllms@kernel.org>
> ---
>   arch/x86/kvm/vmx/vmx_ops.h | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
> index 5edab28dfb2e..50328be40b2b 100644
> --- a/arch/x86/kvm/vmx/vmx_ops.h
> +++ b/arch/x86/kvm/vmx/vmx_ops.h
> @@ -11,8 +11,11 @@
>   #include "../x86.h"
>   
>   void vmread_error(unsigned long field, bool fault);
> -__attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field,
> -							 bool fault);
> +/* regparm(0) overrides -mregparm=3 so args are stack-passed, matching asm callers */
> +#ifdef CONFIG_X86_32
> +__attribute__((regparm(0)))
> +#endif
> +void vmread_error_trampoline(unsigned long field, bool fault);
>   void vmwrite_error(unsigned long field, unsigned long value);
>   void vmclear_error(struct vmcs *vmcs, u64 phys_addr);
>   void vmptrld_error(struct vmcs *vmcs, u64 phys_addr);

Hi,

I've sent a backport patch for this commit, see here:

https://lore.kernel.org/lkml/20260617105100.22094-1-hannelotta@gmail.com/

The commit applies cleanly without any modifications, and compiles 
without errors with gcc-16, and boots.

For commits that apply cleanly, you can simply use:

     git cherry-pick -s -x <commit-id>

And after that

     git commit --amend

to add the required [ Upstream commit <commit-id> ] line.

I wasn't able to see other compilation errors for v6.1.175 using gcc-16. 
I tried with allyesconfig and my local config.

Hope this helps.

Best regards,

Hanne-Lotta Mäenpää
