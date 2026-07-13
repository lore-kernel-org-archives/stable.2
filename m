Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D307347536
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783917839; cv=pass; b=ZXq/f7Y73NeI8xGCw18iix67/s94HcoFDqbE8RH34yCHJE7wkWXH6NKsWBSET1RL3jjtuhwyS1+O+Vrbom4j/3ISpM6NYOx5HuQF/GaZmY2d9JsRc7HoNPZm2SvvkDEkXsh0lJ5eAvIaNfFgKLPT0ReMkEd8g6wh5AMYN5bH0gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783917839; c=relaxed/simple;
	bh=QkoFcxcoQQZgwrnT1nLF2datVGZctHylRNUSzDDmLK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ld6hSIRsF0s7+HSGtQUluVOlL6pfYxpPNJ5lhNQMd1x/nQq7yhM1/9E1gfMWHfA9kvwnJHgmm9V/cm7s9d5OmYhrTjiv+ijry5BvB9u/t4KZRnJl9ELTjgNxBCgAQcYq9HF+2KcZ7gWsvyj3MsvJ2LE8HELzixEDg2UoWGJENKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=E0+49HKA; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="E0+49HKA"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4720d22c94aso2197840f8f.1
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 21:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783917834; cv=none;
        d=google.com; s=arc-20260327;
        b=PEJt37EljOwVbnDFtxBIPkrHrf6ixN0LBNPh7DIdzZ893ByRGdrxd93BL/V7bf4YuF
         25tr422YkFnAE/hBrXeU5iIjRnxb9qfg9LFMGNzfQHw5gSFSQhWWRWyT4QkjXMdM+6ZC
         iwB0umRWfFD1mWr03DaURmdu5unxBIcgr38Z9gktnHNn8xE6hZ+fNtBfsG0RBypsF1da
         Qw8jT1WUT3naZtlMuJwMnD94jjKzP8mWvV0wB8tymRsD/EnILsXm0LuMcM0R6F1hd1ZC
         bM4yDMEaoi8ZZVa8Y81/cCas9OllAsXErHgDlj28EhpW+Ws3KHBMFM37s63uElNknTRO
         dLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=srrtRaovW8/W7ZMmlWp7f6IeR2Pc1TTrTnTMQhqgF98=;
        fh=9kNGBM6VOiimUxREdLc3QAXEyLi0d/eIG+X2r09vIRw=;
        b=rawMFnaIRR20vxkK/VznhvCiaOjJnyoMJjTWMaDOWhVg9Laiaf/juGsYH3w6scGE1W
         zNSFosEboCi8eDzYkVAbjX04ktoKM7DnWco8JCjCkhp+WDcK9TOjRBMa+E7sPQEBmoMJ
         jH52xBhV9T/7/xSWf5FzRZtjfiDL3JTUTOyldjXVEINTLhli3rVabEr+WRVvdK6Z0ND8
         nagcg/JGuzgjKBYaIgxneYf34tGKpvNn8tefCsWurJlEQ2QZgLlP6yCQdk7FqWyt51U9
         Zkq9e0/HBOnhGVqPvAoleRUSxyIB41wm2DvIBFsi64PghdiLOzvnRch65s9QvXs5D3AQ
         WhLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1783917834; x=1784522634; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=srrtRaovW8/W7ZMmlWp7f6IeR2Pc1TTrTnTMQhqgF98=;
        b=E0+49HKAxMI27T58oVplc+Mn2bSiTe1u7qbgOwUV8AKfAZXWEVrqGfvdmLZ1eD++0Z
         ZmRLyVRJu4rxkcx1GYai5NFxas+Jam7W5EduVFy712Dh4L/AqVRhXNtcSdq2uRLbAiGA
         hsnHU77Zt4YqUBbYjsuUiAFCey7hKxjqkDKMh9Vq9tidDTKDCKgKrBx9dJjf5RH7Ibh3
         T4ln1bPIkNNdZc7n6vCQW4qcxWBHx24tvQoiHCrp9rOQTo6C7ndVTKv2+mfZE/mDu57z
         843239E7i+OgPOddfYW6ok0u93hdqYth9GyYaRSzpP7GPwFV+eogi23vPbH0jZGUbeay
         nGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783917834; x=1784522634;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=srrtRaovW8/W7ZMmlWp7f6IeR2Pc1TTrTnTMQhqgF98=;
        b=XOMnevItrvDm5yshUTuEQ0lsc25CppMQy7Rzgc+MyRcq9Z9NwIpoYg0BSRzjIpEY9H
         sq9jKt/10bOstBIz21DIw2IQ36aZ4U/piX0eLxdyzAPJJpNSXJ3NzN1m8MqHHOdyh2uZ
         TD/zkC32yk+Q9ZJFDIJSoVQFmQQ6tfnLdXOwBrfntdqeYbNQMGwAeBurIGPas1KN7WqP
         +TVbQT8nQslWXL4Fv5FJcWAG1nUZn0/dAznmlPdKS2ymKUx+nZLiZWDSTO57ZPMMB9cR
         HlD6hYnQvDEYaTTwq0isOq/kmTBI0WAiJRTxtvKFT6SoC3ltd+1A0NL6OXt2APRMJmNm
         3W5g==
X-Forwarded-Encrypted: i=1; AHgh+Rq6Mz/NKWgkepNnMPF5qDxeVHN5Mm/vpzd9h5gl3VSdJh4XqW5T+0wfCf6MtiMxldTJtlus0/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYe2KDidoAMmAqOBXLnZpqEcKaGenPCK3eEgEGLYtcScoSkhu9
	ueM6S8fKmDHfU23u77ZqL2ljfIjAwlIfzwDlS0sl3j0dpnp+OFSJDFm29sMI3XvGDXJ2kRdID2s
	qKf7eFAAsbgHsA5ZqmHxKrD+LaFx18/smDdEl3knXwg==
X-Gm-Gg: AfdE7cl8qJBKKhkxo/x+vbjYyLCYsWl2A1DVZxtfXKUuLcQzQXtICe6xzrX5SAOwY76
	3qtVVorI+uaaBgwpm38UcNLSP1X6gqqODGR2hX8zWvnyWUPkI3ocC+VXHcR9kZ5Jb4OSs4F9CJO
	4Gfmtp6KIHZv+xA7qEYlt14yMiLeV6eIpzZ7d22dBJgwiBKNtGrpoWLki09T897K1SxuMA5WESM
	Qp6wEDJ23iDgHkvXrA7TSzXIIMu5rPGVse0970xJU8hMjYCe7HTTpZc3dfPxgWpSc3WkdL8pSTo
	4U8f4y3tWTc7l1RoNLvcilZDq3/eMZHUDHEUDvwiL35BCa0NG7xu5Dk9L1LZV0a42tLO/NORaxP
	meTLuYYz/Px9LD6Dh
X-Received: by 2002:a5d:64c4:0:b0:473:c18:f2cb with SMTP id
 ffacd0b85a97d-47f2dcc03b2mr9258760f8f.18.1783917833946; Sun, 12 Jul 2026
 21:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178159067899.108868.8176174463274678253@ultrarisc.com>
In-Reply-To: <178159067899.108868.8176174463274678253@ultrarisc.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 13 Jul 2026 10:13:42 +0530
X-Gm-Features: AUfX_mxN7W6u4HvIati0rXIaMxvXZx2GbbKTxaPRSTnLKvB1WOEYs62mSI0qa7Q
Message-ID: <CAAhSdy3_YnzNiSE=KykriwSWU8X2CLhdr2E8CB=32JxA_L7caA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix lost virtual interrupts during IRQ sync
To: Xie Bo <xb@ultrarisc.com>
Cc: kvm-riscv@lists.infradead.org, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 11:48=E2=80=AFAM Xie Bo <xb@ultrarisc.com> wrote:
>
> RISC-V KVM tracks guest pending interrupts with irqs_pending and
> irqs_pending_mask. The existing code uses atomic bitops and models the
> state as a multiple-producer, single-consumer queue where the vCPU is
> the consumer.
>
> The atomic bitops make each individual bitmap operation atomic, but
> they do not make the pair of irqs_pending and irqs_pending_mask an
> atomic state transition. The vCPU interrupt sync path is also not a
> pure consumer: it writes both bitmaps when it reflects guest-visible
> HVIP changes back into KVM state.
>
> For example, kvm_riscv_vcpu_set_interrupt() can set IRQ_VS_SOFT in
> irqs_pending while the target vCPU is concurrently syncing a
> guest-cleared HVIP.VSSIP bit. If sync observes irqs_pending_mask before
> the producer sets it, sync can set the mask and clear irqs_pending. The
> producer then sets the mask and kicks the vCPU, but the pending bit has
> already been lost. A subsequent flush updates HVIP without VSSIP, and
> the guest can remain blocked in WFI even though it has work queued.
>
> Serialize all updates to irqs_pending and irqs_pending_mask with a
> per-vCPU raw spinlock. This intentionally replaces the lockless
> pending/mask protocol with one small critical section per vCPU, so the
> pending bit and the dirty mask are updated as one state transition.
> Use the same lock for sync, flush, reset, and userspace CSR writes that
> clear the dirty mask, so a newly injected interrupt cannot be
> overwritten by a concurrent HVIP sync.

Overall, I agree with the race condition and proposed solution. The
race-condition is primarily because for VSSIP the VCPU acts as both
producer and consumer which breaks the lockless multi-producer
single-consumer approach.

I have the following suggestions:
1) Now that we have a spinlock protecting irqs_pending* bitmaps,
    it is better to do non-atomic bitmap operations on these bitmaps
2) To minimize the lock/unlock dance, various kvm_riscv_vcpu_aia_xyz()
    functions must be called with irqs_pending_lock held
3) The kvm_riscv_vcpu_has_interrupts() function must also be updated
    to use the irqs_pending_lock

>
> Fixes: cce69aff689e ("RISC-V: KVM: Implement VCPU interrupts and requests=
 handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xie Bo <xb@ultrarisc.com>
> ---
>  arch/riscv/include/asm/kvm_host.h | 10 +++++-----
>  arch/riscv/kvm/aia.c              | 28 +++++++++++++++++++++-------
>  arch/riscv/kvm/vcpu.c             | 27 ++++++++++++++++++++++-----
>  arch/riscv/kvm/vcpu_onereg.c      | 13 +++++++++----
>  4 files changed, 57 insertions(+), 21 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 75b0a951c..97e42645c 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -207,13 +207,13 @@ struct kvm_vcpu_arch {
>         /*
>          * VCPU interrupts
>          *
> -        * We have a lockless approach for tracking pending VCPU interrup=
ts
> -        * implemented using atomic bitops. The irqs_pending bitmap repre=
sent
> -        * pending interrupts whereas irqs_pending_mask represent bits ch=
anged
> -        * in irqs_pending. Our approach is modeled around multiple produ=
cer
> -        * and single consumer problem where the consumer is the VCPU its=
elf.
> +        * The irqs_pending bitmap represents pending interrupts whereas
> +        * irqs_pending_mask represents bits changed in irqs_pending. Upd=
ates
> +        * to these bitmaps are serialized so vcpu interrupt sync/flush c=
annot
> +        * drop a newly injected interrupt while syncing guest-visible HV=
IP.
>          */
>  #define KVM_RISCV_VCPU_NR_IRQS 64
> +       raw_spinlock_t irqs_pending_lock;
>         DECLARE_BITMAP(irqs_pending, KVM_RISCV_VCPU_NR_IRQS);
>         DECLARE_BITMAP(irqs_pending_mask, KVM_RISCV_VCPU_NR_IRQS);
>
> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> index 5ec503288..821d2cb6d 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c
> @@ -50,17 +50,21 @@ void kvm_riscv_vcpu_aia_flush_interrupts(struct kvm_v=
cpu *vcpu)
>  {
>         struct kvm_vcpu_aia_csr *csr =3D &vcpu->arch.aia_context.guest_cs=
r;
>         unsigned long mask, val;
> +       unsigned long flags;
>
>         if (!kvm_riscv_aia_available())
>                 return;
>
> -       if (READ_ONCE(vcpu->arch.irqs_pending_mask[1])) {
> -               mask =3D xchg_acquire(&vcpu->arch.irqs_pending_mask[1], 0=
);
> -               val =3D READ_ONCE(vcpu->arch.irqs_pending[1]) & mask;
> +       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
> +       mask =3D vcpu->arch.irqs_pending_mask[1];
> +       if (mask) {
> +               vcpu->arch.irqs_pending_mask[1] =3D 0;
> +               val =3D vcpu->arch.irqs_pending[1] & mask;
>
>                 csr->hviph &=3D ~mask;
>                 csr->hviph |=3D val;
>         }
> +       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>  }
>
>  void kvm_riscv_vcpu_aia_sync_interrupts(struct kvm_vcpu *vcpu)
> @@ -205,6 +209,9 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
>  {
>         struct kvm_vcpu_aia_csr *csr =3D &vcpu->arch.aia_context.guest_cs=
r;
>         unsigned long regs_max =3D sizeof(struct kvm_riscv_aia_csr) / siz=
eof(unsigned long);
> +#ifdef CONFIG_32BIT
> +       unsigned long flags;
> +#endif
>
>         if (!riscv_isa_extension_available(vcpu->arch.isa, SSAIA))
>                 return -ENOENT;
> @@ -214,11 +221,18 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcp=
u,
>         reg_num =3D array_index_nospec(reg_num, regs_max);
>
>         if (kvm_riscv_aia_available()) {
> -               ((unsigned long *)csr)[reg_num] =3D val;
> -
>  #ifdef CONFIG_32BIT
> -               if (reg_num =3D=3D KVM_REG_RISCV_CSR_AIA_REG(siph))
> -                       WRITE_ONCE(vcpu->arch.irqs_pending_mask[1], 0);
> +               if (reg_num =3D=3D KVM_REG_RISCV_CSR_AIA_REG(siph)) {
> +                       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lo=
ck, flags);
> +                       ((unsigned long *)csr)[reg_num] =3D val;
> +                       vcpu->arch.irqs_pending_mask[1] =3D 0;
> +                       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pendi=
ng_lock,
> +                                                  flags);
> +               } else {
> +                       ((unsigned long *)csr)[reg_num] =3D val;
> +               }
> +#else
> +               ((unsigned long *)csr)[reg_num] =3D val;
>  #endif
>         }
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index a73690eda..b04730ccd 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -80,6 +80,7 @@ static void kvm_riscv_vcpu_context_reset(struct kvm_vcp=
u *vcpu,
>
>  static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu, bool kvm_sbi_res=
et)
>  {
> +       unsigned long flags;
>         bool loaded;
>
>         /**
> @@ -104,8 +105,10 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vc=
pu, bool kvm_sbi_reset)
>
>         kvm_riscv_vcpu_aia_reset(vcpu);
>
> +       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
>         bitmap_zero(vcpu->arch.irqs_pending, KVM_RISCV_VCPU_NR_IRQS);
>         bitmap_zero(vcpu->arch.irqs_pending_mask, KVM_RISCV_VCPU_NR_IRQS)=
;
> +       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>
>         kvm_riscv_vcpu_pmu_reset(vcpu);
>
> @@ -151,6 +154,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>
>         /* Setup VCPU hfence queue */
>         spin_lock_init(&vcpu->arch.hfence_lock);
> +       raw_spin_lock_init(&vcpu->arch.irqs_pending_lock);
>
>         spin_lock_init(&vcpu->arch.reset_state.lock);
>
> @@ -352,14 +356,18 @@ void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcp=
u *vcpu)
>  {
>         struct kvm_vcpu_csr *csr =3D &vcpu->arch.guest_csr;
>         unsigned long mask, val;
> +       unsigned long flags;
>
> -       if (READ_ONCE(vcpu->arch.irqs_pending_mask[0])) {
> -               mask =3D xchg_acquire(&vcpu->arch.irqs_pending_mask[0], 0=
);
> -               val =3D READ_ONCE(vcpu->arch.irqs_pending[0]) & mask;
> +       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
> +       mask =3D vcpu->arch.irqs_pending_mask[0];
> +       if (mask) {
> +               vcpu->arch.irqs_pending_mask[0] =3D 0;
> +               val =3D vcpu->arch.irqs_pending[0] & mask;
>
>                 csr->hvip &=3D ~mask;
>                 csr->hvip |=3D val;
>         }
> +       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>
>         /* Flush AIA high interrupts */
>         kvm_riscv_vcpu_aia_flush_interrupts(vcpu);
> @@ -368,6 +376,7 @@ void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcpu =
*vcpu)
>  void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
>  {
>         unsigned long hvip;
> +       unsigned long flags;
>         struct kvm_vcpu_arch *v =3D &vcpu->arch;
>         struct kvm_vcpu_csr *csr =3D &vcpu->arch.guest_csr;
>
> @@ -376,6 +385,7 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *=
vcpu)
>
>         /* Sync-up HVIP.VSSIP bit changes does by Guest */
>         hvip =3D ncsr_read(CSR_HVIP);
> +       raw_spin_lock_irqsave(&v->irqs_pending_lock, flags);
>         if ((csr->hvip ^ hvip) & (1UL << IRQ_VS_SOFT)) {
>                 if (hvip & (1UL << IRQ_VS_SOFT)) {
>                         if (!test_and_set_bit(IRQ_VS_SOFT,
> @@ -394,6 +404,7 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *=
vcpu)
>                     !test_and_set_bit(IRQ_PMU_OVF, v->irqs_pending_mask))
>                         clear_bit(IRQ_PMU_OVF, v->irqs_pending);
>         }
> +       raw_spin_unlock_irqrestore(&v->irqs_pending_lock, flags);
>
>         /* Sync-up AIA high interrupts */
>         kvm_riscv_vcpu_aia_sync_interrupts(vcpu);
> @@ -404,6 +415,8 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *=
vcpu)
>
>  int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq=
)
>  {
> +       unsigned long flags;
> +
>         /*
>          * We only allow VS-mode software, timer, and external
>          * interrupts when irq is one of the local interrupts
> @@ -416,9 +429,10 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vc=
pu, unsigned int irq)
>             irq !=3D IRQ_PMU_OVF)
>                 return -EINVAL;
>
> +       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
>         set_bit(irq, vcpu->arch.irqs_pending);
> -       smp_mb__before_atomic();
>         set_bit(irq, vcpu->arch.irqs_pending_mask);
> +       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>
>         kvm_vcpu_kick(vcpu);
>
> @@ -427,6 +441,8 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcp=
u, unsigned int irq)
>
>  int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu *vcpu, unsigned int i=
rq)
>  {
> +       unsigned long flags;
> +
>         /*
>          * We only allow VS-mode software, timer, counter overflow and ex=
ternal
>          * interrupts when irq is one of the local interrupts
> @@ -439,9 +455,10 @@ int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu *=
vcpu, unsigned int irq)
>             irq !=3D IRQ_PMU_OVF)
>                 return -EINVAL;
>
> +       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
>         clear_bit(irq, vcpu->arch.irqs_pending);
> -       smp_mb__before_atomic();
>         set_bit(irq, vcpu->arch.irqs_pending_mask);
> +       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>
>         return 0;
>  }
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index bb920e892..cba368294 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -298,6 +298,7 @@ static int kvm_riscv_vcpu_general_set_csr(struct kvm_=
vcpu *vcpu,
>  {
>         struct kvm_vcpu_csr *csr =3D &vcpu->arch.guest_csr;
>         unsigned long regs_max =3D sizeof(struct kvm_riscv_csr) / sizeof(=
unsigned long);
> +       unsigned long flags;
>
>         if (reg_num >=3D regs_max)
>                 return -ENOENT;
> @@ -309,10 +310,14 @@ static int kvm_riscv_vcpu_general_set_csr(struct kv=
m_vcpu *vcpu,
>                 reg_val <<=3D VSIP_TO_HVIP_SHIFT;
>         }
>
> -       ((unsigned long *)csr)[reg_num] =3D reg_val;
> -
> -       if (reg_num =3D=3D KVM_REG_RISCV_CSR_REG(sip))
> -               WRITE_ONCE(vcpu->arch.irqs_pending_mask[0], 0);
> +       if (reg_num =3D=3D KVM_REG_RISCV_CSR_REG(sip)) {
> +               raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flag=
s);
> +               ((unsigned long *)csr)[reg_num] =3D reg_val;
> +               vcpu->arch.irqs_pending_mask[0] =3D 0;
> +               raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock,=
 flags);
> +       } else {
> +               ((unsigned long *)csr)[reg_num] =3D reg_val;
> +       }
>
>         return 0;
>  }
>
> base-commit: 481329ec5b31d2c48ac6b8b703c8008133884c7e
> --
> 2.54.0
>

Regards,
Anup
