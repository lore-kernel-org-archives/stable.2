Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E73ACA5A
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 05:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575935; cv=none; b=X0ZgCDVIIYN4Ya1irn1TCrfpMV0pSindkYJ9PWxA56E1me98o7QfnX/5nduNxNMGSL+oO6IkkQs9+JcgNlFhR+uthB01mHC9pWNH5O8Um5s8ISwBkM81FcndyQLS8GRbsxM7/m7khZMMqHYWvRBXr3rgyWOMjKMrOZfEAZtXIbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575935; c=relaxed/simple;
	bh=mC3oLMXWAbMD/8ggRenIHpAwU32uiCLRqrKbrmFUo/M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iUXJ7UpRRMnZnzRXSGuznYtx1Y4Xyl2nGrtVu6BYqSy9K672dp2vV5foSKYrBj+3nhREvC3isL30IaI3MEWiFbb44Eqbb3Nsa03NFDrzpH4ZPt1wgqgNyOL1Cn3NT7aIlA+aEMwWO/UztXdE8MBsgmksaR7/MQw9g9SWxK/M9J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+/b1Msi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+/b1Msi"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc80b585bfso4246415ad.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 22:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783575934; x=1784180734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yNOQxL4FXDmHyD0Kjq23REAu9LFdCtb3Pm7cOHC959s=;
        b=b+/b1MsiXghrnUV3jqlmzuR/k6mUQp0JeeNf+pMXneovULfK1MmbMw9Pav8g4QyA3s
         SUk72b7KiLJjspcYlpJGiAFIUTNv8uSLFrpo38MNo7NFDioiBLVqBqTR3K1nUs55dQO6
         x/aJ4qN3auxmyhY0KtTQjjLyDw5F9L4tfdcTUvQfNgFCIOJGQO1m8XZ86GHJBefMPa/1
         rkRqpDf4CvA41z0NQA/+Mcrg1YpsYpehU7+WiA/GKmoltRuHVT9XQUs2wUoy+t0FX0Qi
         QOs8yf0Bmr/+5ukmOGlwc5V3X8j6/VKVnHn1Ule6cQtX26m9KwiBwV+IiPQo7hOe/1cx
         BIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783575934; x=1784180734;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yNOQxL4FXDmHyD0Kjq23REAu9LFdCtb3Pm7cOHC959s=;
        b=rYgt71btXfYaCoI7IVTFU4N1hdBmpwsg0hnspyYDJSbHuNI5GtQwpapWsZ1NUbGZ30
         H9YD4xn6OGrO4MKeEWm1S6cgJHTPDIJ0bivWvY75KixrFNwCdMqJb/UsoqgEEHFjTf9x
         eB71pPxfDpB2yDzzGGXw78d/yCnMJ16nkKyN3iuBURYv19xF+GrxmKFVeVzWLn/RD4IL
         E7oRu/A0bvVbP3znRUSvFSdp4QyfunP7g9Vp9csnJIl+uqeof3bolGLMSI1Yk7AzpD//
         Wp9qjqEaXI29uffC18i855HOjrSSjIvSIvGI87yrSJrtRKNscMIuEvk9eFC61SjLBBWq
         cf6g==
X-Gm-Message-State: AOJu0YxNErdSaHTHDmY96P/M1L6tWYqMItb0EsyTlTRMuK2DAGWhjn5W
	iIJjB5ZrZT44ZQxwbIY12g52rO8WXqv1GheKrzHgFYvAH6qNV9Z/fPc8
X-Gm-Gg: AfdE7cnLQ3c0/ucqc9iAT0hFavyFE0MgfplcJoTN6fuJK9Zo33IG2jk9PnAk19HkJSh
	UZb66YE0uYksT/jGqbslkqAgbILth+DIf6b4v5v+9DBMAvx+WdraqC+jA81feuqa4MrIIHQ+2yt
	FX0vPC8Sg0suvontZt61RqbmpeYkxlWnI2QjKMaAwPE03HJZRtPSabq61lAvctkP3DlGGW9WRf3
	IEMEH/zjPU0Uv4uu62J/LwJtqB4YBv+kwfG/jlwMG7mwoO0vEQ0DNtlWIiMN6Rizk7Ys5+mcQ5b
	eyDsEkf+VDzwrWrEMoz/8P07F+uU1Asw88TsDli3QysG8M49nNF+ZcFdniIQ7m5zBojqzCinOzZ
	Q+6a6Keix/PETgtqL5qa8tbvGAdKOFBeSvUCCQarskEuZvdInFfxjVsgSdWLGKKzY8EwZbONv67
	mMq7iq1wOYFHpeayHF
X-Received: by 2002:a17:903:3903:b0:2cb:14b3:4cfe with SMTP id d9443c01a7336-2ccea582ae2mr60334915ad.45.1783575933576;
        Wed, 08 Jul 2026 22:45:33 -0700 (PDT)
Received: from [10.42.12.77] ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc99cc5aasm38156905ad.0.2026.07.08.22.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 22:45:32 -0700 (PDT)
Message-ID: <c12700ab-7f0c-452d-b8de-8e23ca48f1bd@gmail.com>
Date: Thu, 9 Jul 2026 13:45:23 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: leixiang <leenollei@gmail.com>
Subject: Re: [PATCH] KVM: Nullify irqfd->producer when add_producer() fails
To: Sean Christopherson <seanjc@google.com>
Cc: stable@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@ozlabs.org>,
 Suresh Warrier <warrier@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 leixiang <leixiang@kylinos.cn>
References: <1782119051448443.14545.seg@mailgw.kylinos.cn>
 <ak59frQUBl9Gs3Qn@google.com>
Content-Language: en-US
In-Reply-To: <ak59frQUBl9Gs3Qn@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/26 00:40, Sean Christopherson wrote:
> On Mon, Jun 22, 2026, leixiang wrote:
>> The x86 and powerpc add_producer() callbacks set irqfd->producer before the
>> fallible setup and never clear it on error.  The bypass manager doesn't
>> register a producer whose add_producer() failed -- producer->eventfd is
>> left NULL, so the later unregister early-returns and del_producer() is
>> never called -- so nothing ever drops the pointer.
>>
>> For VFIO PCI the producer is embedded in struct vfio_pci_irq_ctx and freed
>> when the vector is disabled, after which a routing update dereferences the
>> dangling pointer via kvm_arch_update_irqfd_routing().
>>
>> Nullify irqfd->producer on the error paths.
>>
>> Fixes: 77e1b8332d1d ("KVM: x86: Decouple device assignment from IRQ bypass")
>> Fixes: c57875f5f9be ("KVM: PPC: Book3S HV: Enable IRQ bypass")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: leixiang <leixiang@kylinos.cn>
> 
> Please post the PPC patch as a separate patch.  x86 and PPC are separate maintainer
> domains and the backports will likely need to go to different LTS kernels.
> 
> I'll grab/extract the x86 change from here (and I'll massage the changelog as
> appropriate).

Thank you for the review and guidance.  I will submit a separate PPC patch.

>> ---
>>  arch/powerpc/kvm/book3s_hv.c | 4 +++-
>>  arch/x86/kvm/irq.c           | 4 +++-
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>> index 61dbeea317f3..14919b76fb32 100644
>> --- a/arch/powerpc/kvm/book3s_hv.c
>> +++ b/arch/powerpc/kvm/book3s_hv.c
>> @@ -6114,9 +6114,11 @@ static int kvmppc_irq_bypass_add_producer_hv(struct irq_bypass_consumer *cons,
>>  	irqfd->producer = prod;
>>
>>  	ret = kvmppc_set_passthru_irq(irqfd->kvm, prod->irq, irqfd->gsi);
>> -	if (ret)
>> +	if (ret) {
>>  		pr_info("kvmppc_set_passthru_irq (irq %d, gsi %d) fails: %d\n",
>>  			prod->irq, irqfd->gsi, ret);
>> +		irqfd->producer = NULL;
>> +	}
> 
> Unlike x86, AFAICT there's no need to set irqfd->producer before configuring
> the passthru/bypass stuff.  So I think that fix could be this?
> 
> diff --git arch/powerpc/kvm/book3s_hv.c arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3..ff7b25629125 100644
> --- arch/powerpc/kvm/book3s_hv.c
> +++ arch/powerpc/kvm/book3s_hv.c
> @@ -6111,12 +6111,12 @@ static int kvmppc_irq_bypass_add_producer_hv(struct irq_bypass_consumer *cons,
>         struct kvm_kernel_irqfd *irqfd =
>                 container_of(cons, struct kvm_kernel_irqfd, consumer);
>  
> -       irqfd->producer = prod;
> -
>         ret = kvmppc_set_passthru_irq(irqfd->kvm, prod->irq, irqfd->gsi);
>         if (ret)
>                 pr_info("kvmppc_set_passthru_irq (irq %d, gsi %d) fails: %d\n",
>                         prod->irq, irqfd->gsi, ret);
> +       else
> +               irqfd->producer = prod;
>  
>         return ret;
>  }
Agreed. Your approach is cleaner.
