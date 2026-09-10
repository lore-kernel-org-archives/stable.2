Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F8B492E58
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048763; cv=pass; b=JsHo2QpVJgs23joSgAHyFzHLfxpLpVXJUpcGhpIc13ToJv2gBJei6ofWeNbVa4xTazUWNzIeCiSULwyHA1YTO5/6eoFgm8nJsZVBHuiXI6RIV3V58qkFtsnMON1mYxaRYPkwHAueFLyHoAe2KAZ6yf/IexXm64RrbVyFz4ThGjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048763; c=relaxed/simple;
	bh=4FCRoa1ZFnGPclKdf7FZ3h4xxGbrom0G8s8bGT+RMtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivu0OCcsJvhvbDNuBs0e8Tafwf1fVB+EawlCndZbYsvcBzu2ouVvT7SoWyDwufTIYSUcYRhKPCr6oOnCERe+Se49ZWd8p2uPohhBmUcx00MibUeimzCm07ZmV9WDDB4beUTuQ6GJzRiHKuvSFeRME9v8V/StRqa76GV9ykV9d6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=cezdMIZV; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="cezdMIZV"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47de0093c42so6582291f8f.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 06:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789048759; cv=none;
        d=google.com; s=arc-20260327;
        b=nNIT4RqAe1t/RBK+whi2KEMqyJavWHVyIhHABqwjp8Zc3BMyGrjgdHHDTXZJXRm7V6
         mtv7fl20tH9j7yPHROOqjG5VOE5OCBjPs7MDPiee08HKWr2KO2fIAqKz8vPQ5pjb0qx2
         Poxhoi80GPzU2TV9lXU69j8wI9ic1wqD0N4INIL4T3L4C/H3f293WOQ2y+GYTs0yZcp2
         2TAAK87quyZYdN9iCIDMLtTMAtlSipPp3wPdpWbMpibCsF7tBNL3W8h8Eryib1G1G855
         Aid8pyOpCltVgcRem3PtOS2KI5RyIKaEfpk7IdVUKmCF0ODUYy0wK4GvX7wrCoJwWXgp
         KUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a8PvUIr6sHE6mWd/xzRSFBh1HE+N0XSCwjCHHa9qZcw=;
        fh=sYqRrxAKjsZ1uevm2y7N0i18/VMvSgpO8YYCzhcAPXs=;
        b=AvTt6hDl0C6/ICDTmgDTGatzc6KiabN2jrgahv+I/TxV7p2bF57YJy7ecZ9610+mE7
         9dNlrJnxvr5ssQ5iRczq/Nzb7xkZ83bm80cwy270Lv10uoyPAuHr8vGiVsF5WB1VIuji
         Ud/GdSEqE3fZfbJ46JHRoBz3p6kU//hD+VEHQYE3+HqQ6oZcrB0WM0G7C0C7Y03Zjp6F
         /zgZHle7j9Ms4DeLW68z8RIpYakSK0d9d4IatEwmEQe7pvnEgUqcZ1TvEMYnOEsAac8D
         HnI/wM6QTrtF9JWFlh2bOa57nEVMYuQnRrZHij/2PWYZ/K5DhiIk0S2XbXmcD4ZRv6l+
         3njg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1789048759; x=1789653559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a8PvUIr6sHE6mWd/xzRSFBh1HE+N0XSCwjCHHa9qZcw=;
        b=cezdMIZVSt/fPfjPM4Tz7FCdYVXwEhvQh4y1VNkoAE6iTTKKxoAwM2P6UpEay8aZRo
         xkeuPkPs1GKJxYdoFtai1dg31xay+5IogFF/e9TemeVV0ohMBYVMeMsoyqxARbg6vsey
         bqn4f9KdCZpO4bxWRqgA0LWYRCm0ddgKK2F6DCFGaeIy9oCc7H+Ovmzf2DKYinnjJAzS
         IoX198GgGsmkCnV/qgo25Cku/TF8djv4y+M+6RcRFn63TN+jTyd/yW/41hfqCRyaOw/4
         So4AA6wKwzBm7nODwEKHitRIcNBnT07F55ldEm1M/0U5dpiw/PSckrTOMpVVfeSX0+kS
         yZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048759; x=1789653559;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a8PvUIr6sHE6mWd/xzRSFBh1HE+N0XSCwjCHHa9qZcw=;
        b=MUAiU76IFTQ5rQw7icYXqmm/Rhqj/KWd+pr+DD9xOgUt5jaQMKla8LX6Cy84P/chVN
         J+k+UfvH70gyFbgvWsb4vYG/oNMlKtzQnz//gvKHKJ+4QVQcY/iwESFxW2QCQl8Zk8Dm
         QHiKXjpJBx6fg2EK6B7//p4bzyUAjVkLq4l1U/eRGvDaym+6Xi8OkSt0vS5H7JLOr9u+
         3fEBCjBv7cvKHQ/yUX/scXrRWtgrLh0Dq4jcnhPOwB1HgWW1gg+hVsHks1IM+95TFm4F
         w83hBjzFuK5wa/cWUQgJC9H2sxtMnRM1S500fTti9OrTObATXBWddF+gguMtiVq1RdDc
         4M5w==
X-Forwarded-Encrypted: i=1; AKwUvBwKpG9MJRFEH1a3m9xPFmN3gmA4xBPQu8gMRseOphyYUfuZhJZaamW1VCmZFaWJXs6xfIwrwPY=@vger.kernel.org
X-Gm-Message-State: AFuF++l2A8kUEuQ3XxWHmj897X+3UTbqGesmQDACRxreCKP6c8IsP4ve
	8Nnny4qkhT1Hh2sib9Q7YYUr8+yu8uejQ49Lc8RIN999i96HR7bVqUvJD8wCuB0w1did6GSSJ5K
	xVuBNjhza30ZBXMK/fJea7TZUU1Bss6ZWcxYyC8Bjfg==
X-Gm-Gg: AYBFou0xTKcvFPdXVSX1aFrC2ApRg/mraeRTCr33zbMnp7pmub6+VmaBH/CAdBBnBsS
	NoSLc9p1NUWp42GbhrNkBzbBD6B715SIJj8szf7GN6RRD/H8cRDFXMXlWjiD32hIHRD5FFMjebB
	8sbKTXPx0LedzGKe3aeI638sRtUHi9xsXLz2HQr6k/yjh8GtVHYk8diCTC8VSeFW/R2hoSryjMr
	jVIHDrV9BYUXR7LENlznIqcvYrqVvcHGvDv5IISy8Q/yWSFRkCn3PvyC4bcIMiWUa94Zo9EI0F4
	MIZ0VNbyOVKLFv6f/dfxSWV7n1Rx9JDF01BXHMxhzhbMtyu1+SROtOMikv98GicM+rLkaBr4pYv
	vQEGPshYl31ZOJDtv8xfWHGLjoUu4fXPmHkFllysiI+LdakKwqHcJvcR94MzjlCgrTlfKoUMprA
	==
X-Received: by 2002:adf:e19e:0:b0:485:8c16:5eef with SMTP id
 ffacd0b85a97d-4858c166088mr39391128f8f.41.1789048759310; Thu, 10 Sep 2026
 06:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810051544.3953925-1-xb@ultrarisc.com> <20260810051544.3953925-3-xb@ultrarisc.com>
In-Reply-To: <20260810051544.3953925-3-xb@ultrarisc.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 10 Sep 2026 19:29:06 +0530
X-Gm-Features: AcwNN1W7Uqn-QGBR02QgV1a2VTJVT2tlA_caJMvDJlneztIk9EUK-XjvcF0ult4
Message-ID: <CAAhSdy2qxD9x-mvt=5yEKA+xoa8QJ9evnQkJot9n+rkxvOQukA@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/2] RISC-V: KVM: Propagate interrupted G-stage faults
To: Xie Bo <xb@ultrarisc.com>
Cc: kvm-riscv@lists.infradead.org, Atish Patra <atish.patra@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 10:46=E2=80=AFAM Xie Bo <xb@ultrarisc.com> wrote:
>
> __kvm_faultin_pfn() reports an interrupted host page fault with
> KVM_PFN_ERR_SIGPENDING. RISC-V currently handles it as a generic error PF=
N
> and returns -EFAULT.
>
> Return -EINTR for the signal-pending sentinel so callers can distinguish
> an interrupted fault from an invalid userspace mapping. Do not log the
> expected interruption as a vCPU exit error.
>
> Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programmin=
g")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xie Bo <xb@ultrarisc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this as a fix for Linux-7.3-rcX

Thanks,
Anup


> ---
>  arch/riscv/kvm/mmu.c       | 2 ++
>  arch/riscv/kvm/vcpu_exit.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index d189fd5..3e955d8 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -708,6 +708,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>                                 vma_pageshift, current);
>                 return 0;
>         }
> +       if (is_sigpending_pfn(hfn))
> +               return -EINTR;
>         if (is_error_noslot_pfn(hfn))
>                 return -EFAULT;
>
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 88e0c36..8d36eb8 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -283,7 +283,7 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct=
 kvm_run *run,
>         }
>
>         /* Print details in-case of error */
> -       if (ret < 0) {
> +       if (ret < 0 && ret !=3D -EINTR) {
>                 kvm_err("VCPU exit error %d\n", ret);
>                 kvm_err("SEPC=3D0x%lx SSTATUS=3D0x%lx HSTATUS=3D0x%lx\n",
>                         vcpu->arch.guest_context.sepc,
>
