Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEC22A1B2
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110820; cv=pass; b=uP/VMlYRQZcZv5qgN0S7P0hWe8ZF+PM9k3aH/GGJTGrZ7Uy2tV2d8i0goJNJhQyZk26k0b+szIIYiMsuc/7HmkUxXY3bPG+yY70umLCsIrjz1+kgSUUP6dYNKgbbIr66zyT6JgByW5mt/xapaPZFZcgInPCnaJ4IFPDXgTjW5/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110820; c=relaxed/simple;
	bh=8KZYp8PPaN6hKy6+FTG/CHJiqBzG4jpnwoiy5g/jxaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TC20pshHM6HHqJcVXPmyfKoSZ2SEIcNicxlOyMc6JXfQVrptKpyRRYVU8X3O0TCTFlDjZBYwvTCKVUgn/N4re7+qQHXzZJqkbdEurTsO04ozRypduAqy2dvRvfAA15Z3WurWqfz/+coagk9BqRlxJP7oMqixobpeup/tOzdRfhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=j9zEMUZK; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="j9zEMUZK"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso3599582f8f.3
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 03:20:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784110817; cv=none;
        d=google.com; s=arc-20260327;
        b=Od2DzdN1muU4CY6m4X7g9GFex6oIVKwVHgeOOBGPV0Xuedr9vS6y+965OFDZn05qwo
         TgQL+2tisZytJWgJOFKXg/l8em92AuJC/cifjvYwgJX2pCwwuqqZAWw1afR6XMSQ/eLP
         uaLcP1KD9k+6T0BMFNvaUGSXak34JFws0QvxDuSSegAJ4V5GLdZ82LCWT+BmyMMdUE0e
         J5J1RNKPjkQR8osDXu6hvgf65xC9QmRrSZYjsMtDyvW7Shj5iMPIDnGcwWz3DmWZj0Qz
         tETBaXqHy6Fc9z/8RwiNc3PJvWIuPbVqCsfhxbqXS9oktcnF3TnPWSpo+ULrucf6hCFW
         Rm7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8odTX5AvByZVdUl692U2bQfzgsLDk1Bv6WHbb0zOhSw=;
        fh=zOFpFZz6k7b8AYokkFGsR/yk3P56ib10QnsQ9OZX+eE=;
        b=eB6IuOedGFsLAiPs/lVxKGjbU33s5S8FP8tAFKrzc99oR2JnSwxccTCG3+y/7CppNY
         1L2JiK6+V/rlZ0jyvHQIy1T1Rr9AInxkffvNO2NkH76XNmdwFYeORNxS7yu6vXIn+EQ/
         HwxF3PX17M0L8mIMOCl0M3ozDxHRFtShZn6CiaDCAGboSp3CI3gGO4iDvSxI6FBskbGN
         viy5fhkZY3ArKHLwyttaycRQitJsve/Ey3BxzqXbFjkpidWMCLS+HElp6vNGi5eN+JKX
         fd7J0J3ke94ypSME2i19AHO2vcKYa0YVkI+LZoLs8Fs0PYGbfvv5pDnnKB/hQn8F22YI
         xmPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1784110817; x=1784715617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8odTX5AvByZVdUl692U2bQfzgsLDk1Bv6WHbb0zOhSw=;
        b=j9zEMUZK3hwl7bN8mvWEN2AcDLvV5eLLcTxDh4yUourKryNCcXspqaKfC8LJSMjvt8
         D45NZZPB83MaeM/9vcnYTk42OSNdRVS+004kgjiU9II1X4ZbOYWsCeFHxKdwk0Tf7Y+U
         Woa76JaYCjTmCg89CGDCnPSR9bo7VXHWDF6uvGP0kVbA1n4heVC/uHkIi9d8DXwjEw9m
         gwCkUKYS75YJKXe85bOsARkv9m+BckLgyfjYExlsiG9yhPorFoBO2t5SGZB+nwNByTnG
         E/Fc4o7FEz0WiNp5KebfukPLRFsDUr1iV2OHCoFNm4SK6NFMkIjEhWB+XBEr4ZR3jsbn
         +cOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784110817; x=1784715617;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8odTX5AvByZVdUl692U2bQfzgsLDk1Bv6WHbb0zOhSw=;
        b=XBBg9c0ysXvv3c1ycDn9G9YSA20cPRypzfjIjOoKjzE7nYD5IooKGWuruavTgRDDkV
         pUxHbc3ayV4hFlxxaz2dhURnRCSrkUWQF8l8i3+eRkF2Hbg9ByM/4XjdORpXWi/b5Tet
         Ims8s8FJKw5jZ+BxRLATp5dbYvYPgM5BMlbK1ZpMTaqe/lDL6YK7+2+kfwoR8GnadUZH
         UToXN6aGjX0VJQHm5cgcflMjJ+jECbyY8Ra1yIuinTbtzbtDVM2oecrN0eXE1FiCWKE9
         KXpogkZMVOl0CuPKfDnEI0rWc+28gfd5dhyeibdahkrQ1uYN/P9OMKVTRDc8KeVuGYuS
         drpg==
X-Forwarded-Encrypted: i=1; AHgh+RqEDGMlV1fksPdPq0t9xEHiyXLNYETCTyvQdod4zORKGwXq79cANuoKgB82FnD5ylUcydIGSP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAeTN8BUm32eBVDs23ZgR3jpUlizsr0BTbt0E63O57O7HJ8M77
	9cFkgyaSo4Zq2vdDRUFhFGA3cnbs71e/gK40bMa3rdoJcQjrzrFxC0WU/wcPd8ewtxg1BzzxGZ7
	ywlZbeQFa+tp/mVHNkW1mWMdld+hWxKMSJRD2xIe2OQ==
X-Gm-Gg: AfdE7cmVAxKbJ951d6oIw0TAJ64qHn0LV6RrKdAkcvr1mFpvwvscRxOWbmMutTcpUy/
	hM/3mkjoydA53FYmSnmpGm15sZ+y+9dg27J9fp7fpT6qXkMWSzShpKuYVh93TA8zTM6/zbEFK3T
	BQ6LdORoHtcDcoZQNF76l8YXna6G2ZJT2Mt8hF4lWPdPg+0HkbheMsAZx7gr0WvP8ILEN9vhNV5
	OM9Fz4wWxTioKQ4BuTii84FkNWe1/LTzjAL9vWiMmbJ8ZDyRo1jTMEZ3JGba7HnkavpOqoYgxSq
	1IPRdn2QzzbnGwnR9akv9q9uVbsRqY0s1EkM6NKS02Gcs2SeLd4g9jk/oLu6QrpdjTe2GJA406V
	2GVbN31nzlSc8Rm0t4zSMWNwvpmiNLeESUR8y9g==
X-Received: by 2002:a05:6000:1844:b0:47d:df96:c9f4 with SMTP id
 ffacd0b85a97d-47f4632fd93mr9600109f8f.10.1784110816315; Wed, 15 Jul 2026
 03:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178159067899.108868.8176174463274678253@ultrarisc.com>
 <CAAhSdy3_YnzNiSE=KykriwSWU8X2CLhdr2E8CB=32JxA_L7caA@mail.gmail.com>
 <20260713073346.1293408-1-xb@ultrarisc.com> <20260713073346.1293408-2-xb@ultrarisc.com>
 <CAAhSdy0hX0z6BpOUZSnCmhh7aeHUm3Yh5k9TdzUGC+4A1W+Czw@mail.gmail.com>
 <20260715020359.1521354-1-xb@ultrarisc.com> <20260715020359.1521354-2-xb@ultrarisc.com>
In-Reply-To: <20260715020359.1521354-2-xb@ultrarisc.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 15 Jul 2026 15:50:01 +0530
X-Gm-Features: AUfX_mwFwrrJyEZ4u0cLVNsx2DU_83EiCvCM7sVTLeTfgrSzHGQHU6ElPgDlbSU
Message-ID: <CAAhSdy2OrFc0cdW6FRjFEMo97E1c0n7yuFhDLahuqiXLsy9skw@mail.gmail.com>
Subject: Re: [PATCH v5] RISC-V: KVM: Serialize virtual interrupt pending state updates
To: Xie Bo <xb@ultrarisc.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 7:34=E2=80=AFAM Xie Bo <xb@ultrarisc.com> wrote:
>
> RISC-V KVM tracks guest interrupt state with two bitmaps:
>
>   - irqs_pending: interrupts that should be visible to the guest
>   - irqs_pending_mask: interrupts whose pending state changed
>
> The current code updates those bitmaps with independent atomic bitops
> and assumes a multiple-producer, single-consumer protocol. That model
> does not actually hold.
>
> kvm_riscv_vcpu_sync_interrupts() is not a pure consumer. When the guest
> changes guest-visible HVIP state, sync_interrupts() writes both
> irqs_pending and irqs_pending_mask to reflect the new guest state back
> into KVM state. As a result, irqs_pending and irqs_pending_mask form a
> single logical state transition, but they are not updated atomically as
> a pair.
>
> This allows a race where a newly injected interrupt is lost. For
> example:
>
>   CPU0                              CPU1
>   ----                              ----
>   kvm_riscv_vcpu_set_interrupt(VS_SOFT)
>     set_bit(VS_SOFT, irqs_pending)
>                                     kvm_riscv_vcpu_sync_interrupts()
>                                       sees guest-cleared HVIP.VSSIP
>                                       sets irqs_pending_mask
>                                       clear_bit(IRQ_VS_SOFT, irqs_pending=
)
>     set_bit(VS_SOFT, irqs_pending_mask)
>     kvm_vcpu_kick()
>
> After that interleaving, a later flush can update HVIP without VSSIP
> even though a new virtual interrupt was injected. In practice, the
> guest can remain blocked in WFI with work pending.
>
> The same pending/mask protocol is shared by VS soft interrupts, PMU
> overflow delivery, and AIA high interrupt synchronization, so the race
> is not limited to one interrupt source.
>
> Fix this by serializing all updates to irqs_pending and
> irqs_pending_mask with a per-vCPU raw spinlock. This keeps the pending
> bit and the dirty mask as one state transition across:
>
>   - set/unset interrupt
>   - guest HVIP sync
>   - interrupt flush to guest CSR state
>   - vCPU reset
>   - AIA CSR writes that clear dirty state
>
> Use non-atomic bitmap operations while holding the lock. Hold the lock
> across the AIA sync, flush, and pending checks as well, so both bitmap
> words share the same serialization domain.
>
> This intentionally replaces the existing lockless protocol instead of
> trying to repair it with additional barriers. The problem is not memory
> ordering on a single field; it is that two separate bitmaps encode one
> shared state machine while both producers and sync paths can modify
> them. A per-vCPU raw spinlock keeps the fix small, local, and suitable
> for backporting.
>
> Fixes: cce69aff689e ("RISC-V: KVM: Implement VCPU interrupts and requests=
 handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xie Bo <xb@ultrarisc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this as a fix for Linux-7.2-rcX

Thanks,
Anup


> ---
> Changes in v5:
> - Keep kvm_riscv_vcpu_aia_has_interrupts() as a single helper and let
>   it acquire irqs_pending_lock while checking the high pending bitmap.
> - Keep the IMSIC VS-file check outside irqs_pending_lock.
> - Keep guest CSR updates outside the irqs_pending_lock critical section
>   and serialize only the dirty bitmap updates.
> - Improve lock/unlock readability and clarify the race example.
>
> Changes in v4:
> - Split the AIA pending bitmap check from the IMSIC VS-file check.
> - Release irqs_pending_lock before the IMSIC check takes vsfile_lock,
>   avoiding sleep-in-atomic on PREEMPT_RT and an ABBA lock ordering cycle.
>
> Changes in v3:
> - Rebase onto Linux 7.2-rc3.
> - Use non-atomic bitmap operations under irqs_pending_lock.
> - Hold irqs_pending_lock across the AIA sync/flush helpers and add
>   lockdep assertions for their locking contract.
> - Protect kvm_riscv_vcpu_has_interrupts() with irqs_pending_lock.
>
> Changes in v2:
> - Expand the race description and user-visible failure mode.
>
>  arch/riscv/include/asm/kvm_host.h | 10 ++---
>  arch/riscv/kvm/aia.c              | 35 ++++++++++++----
>  arch/riscv/kvm/vcpu.c             | 66 +++++++++++++++++++++----------
>  arch/riscv/kvm/vcpu_onereg.c      |  8 +++-
>  4 files changed, 85 insertions(+), 34 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 60017ceec9d..e2d5808169e 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -209,13 +209,13 @@ struct kvm_vcpu_arch {
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
> index bafb009c5ce..9a653b4ad40 100644
> --- a/arch/riscv/kvm/aia.c
> +++ b/arch/riscv/kvm/aia.c
> @@ -53,12 +53,15 @@ void kvm_riscv_vcpu_aia_flush_interrupts(struct kvm_v=
cpu *vcpu)
>         struct kvm_vcpu_aia_csr *csr =3D &vcpu->arch.aia_context.guest_cs=
r;
>         unsigned long mask, val;
>
> +       lockdep_assert_held(&vcpu->arch.irqs_pending_lock);
> +
>         if (!kvm_riscv_aia_available())
>                 return;
>
> -       if (READ_ONCE(vcpu->arch.irqs_pending_mask[1])) {
> -               mask =3D xchg_acquire(&vcpu->arch.irqs_pending_mask[1], 0=
);
> -               val =3D READ_ONCE(vcpu->arch.irqs_pending[1]) & mask;
> +       mask =3D vcpu->arch.irqs_pending_mask[1];
> +       if (mask) {
> +               vcpu->arch.irqs_pending_mask[1] =3D 0;
> +               val =3D vcpu->arch.irqs_pending[1] & mask;
>
>                 csr->hviph &=3D ~mask;
>                 csr->hviph |=3D val;
> @@ -69,6 +72,8 @@ void kvm_riscv_vcpu_aia_sync_interrupts(struct kvm_vcpu=
 *vcpu)
>  {
>         struct kvm_vcpu_aia_csr *csr =3D &vcpu->arch.aia_context.guest_cs=
r;
>
> +       lockdep_assert_held(&vcpu->arch.irqs_pending_lock);
> +
>         if (kvm_riscv_aia_available())
>                 csr->vsieh =3D ncsr_read(CSR_VSIEH);
>  }
> @@ -77,13 +82,22 @@ void kvm_riscv_vcpu_aia_sync_interrupts(struct kvm_vc=
pu *vcpu)
>  bool kvm_riscv_vcpu_aia_has_interrupts(struct kvm_vcpu *vcpu, u64 mask)
>  {
>         unsigned long seip;
> +#ifdef CONFIG_32BIT
> +       unsigned long flags;
> +       bool pending;
> +#endif
>
>         if (!kvm_riscv_aia_available())
>                 return false;
>
>  #ifdef CONFIG_32BIT
> -       if (READ_ONCE(vcpu->arch.irqs_pending[1]) &
> -           (vcpu->arch.aia_context.guest_csr.vsieh & upper_32_bits(mask)=
))
> +       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
> +       pending =3D vcpu->arch.irqs_pending[1] &
> +                 (vcpu->arch.aia_context.guest_csr.vsieh &
> +                  upper_32_bits(mask));
> +       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
> +
> +       if (pending)
>                 return true;
>  #endif
>
> @@ -207,6 +221,9 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
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
> @@ -219,8 +236,12 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu=
,
>                 ((unsigned long *)csr)[reg_num] =3D val;
>
>  #ifdef CONFIG_32BIT
> -               if (reg_num =3D=3D KVM_REG_RISCV_CSR_AIA_REG(siph))
> -                       WRITE_ONCE(vcpu->arch.irqs_pending_mask[1], 0);
> +               if (reg_num =3D=3D KVM_REG_RISCV_CSR_AIA_REG(siph)) {
> +                       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lo=
ck, flags);
> +                       vcpu->arch.irqs_pending_mask[1] =3D 0;
> +                       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pendi=
ng_lock,
> +                                                  flags);
> +               }
>  #endif
>         }
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index cf6e231e76e..0065a15c9aa 100644
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
> @@ -352,10 +356,13 @@ void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcp=
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
> @@ -363,11 +370,13 @@ void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcp=
u *vcpu)
>
>         /* Flush AIA high interrupts */
>         kvm_riscv_vcpu_aia_flush_interrupts(vcpu);
> +       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>  }
>
>  void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
>  {
>         unsigned long hvip;
> +       unsigned long flags;
>         struct kvm_vcpu_arch *v =3D &vcpu->arch;
>         struct kvm_vcpu_csr *csr =3D &vcpu->arch.guest_csr;
>
> @@ -376,34 +385,41 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu=
 *vcpu)
>
>         /* Sync-up HVIP.VSSIP bit changes does by Guest */
>         hvip =3D ncsr_read(CSR_HVIP);
> +
> +       raw_spin_lock_irqsave(&v->irqs_pending_lock, flags);
> +
>         if ((csr->hvip ^ hvip) & (1UL << IRQ_VS_SOFT)) {
>                 if (hvip & (1UL << IRQ_VS_SOFT)) {
> -                       if (!test_and_set_bit(IRQ_VS_SOFT,
> -                                             v->irqs_pending_mask))
> -                               set_bit(IRQ_VS_SOFT, v->irqs_pending);
> +                       if (!__test_and_set_bit(IRQ_VS_SOFT,
> +                                               v->irqs_pending_mask))
> +                               __set_bit(IRQ_VS_SOFT, v->irqs_pending);
>                 } else {
> -                       if (!test_and_set_bit(IRQ_VS_SOFT,
> -                                             v->irqs_pending_mask))
> -                               clear_bit(IRQ_VS_SOFT, v->irqs_pending);
> +                       if (!__test_and_set_bit(IRQ_VS_SOFT,
> +                                               v->irqs_pending_mask))
> +                               __clear_bit(IRQ_VS_SOFT, v->irqs_pending)=
;
>                 }
>         }
>
>         /* Sync up the HVIP.LCOFIP bit changes (only clear) by the guest =
*/
>         if ((csr->hvip ^ hvip) & (1UL << IRQ_PMU_OVF)) {
>                 if (!(hvip & (1UL << IRQ_PMU_OVF)) &&
> -                   !test_and_set_bit(IRQ_PMU_OVF, v->irqs_pending_mask))
> -                       clear_bit(IRQ_PMU_OVF, v->irqs_pending);
> +                   !__test_and_set_bit(IRQ_PMU_OVF, v->irqs_pending_mask=
))
> +                       __clear_bit(IRQ_PMU_OVF, v->irqs_pending);
>         }
>
>         /* Sync-up AIA high interrupts */
>         kvm_riscv_vcpu_aia_sync_interrupts(vcpu);
>
> +       raw_spin_unlock_irqrestore(&v->irqs_pending_lock, flags);
> +
>         /* Sync-up timer CSRs */
>         kvm_riscv_vcpu_timer_sync(vcpu);
>  }
>
>  int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq=
)
>  {
> +       unsigned long flags;
> +
>         /*
>          * We only allow VS-mode software, timer, and external
>          * interrupts when irq is one of the local interrupts
> @@ -416,9 +432,10 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vc=
pu, unsigned int irq)
>             irq !=3D IRQ_PMU_OVF)
>                 return -EINVAL;
>
> -       set_bit(irq, vcpu->arch.irqs_pending);
> -       smp_mb__before_atomic();
> -       set_bit(irq, vcpu->arch.irqs_pending_mask);
> +       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
> +       __set_bit(irq, vcpu->arch.irqs_pending);
> +       __set_bit(irq, vcpu->arch.irqs_pending_mask);
> +       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>
>         kvm_vcpu_kick(vcpu);
>
> @@ -427,6 +444,8 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcp=
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
> @@ -439,26 +458,33 @@ int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu =
*vcpu, unsigned int irq)
>             irq !=3D IRQ_PMU_OVF)
>                 return -EINVAL;
>
> -       clear_bit(irq, vcpu->arch.irqs_pending);
> -       smp_mb__before_atomic();
> -       set_bit(irq, vcpu->arch.irqs_pending_mask);
> +       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
> +       __clear_bit(irq, vcpu->arch.irqs_pending);
> +       __set_bit(irq, vcpu->arch.irqs_pending_mask);
> +       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>
>         return 0;
>  }
>
>  bool kvm_riscv_vcpu_has_interrupts(struct kvm_vcpu *vcpu, u64 mask)
>  {
> +       unsigned long flags;
>         unsigned long ie;
> +       bool ret;
>
> +       raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
>         ie =3D ((vcpu->arch.guest_csr.vsie & VSIP_VALID_MASK)
>                 << VSIP_TO_HVIP_SHIFT) & (unsigned long)mask;
>         ie |=3D vcpu->arch.guest_csr.vsie & ~IRQ_LOCAL_MASK &
>                 (unsigned long)mask;
> -       if (READ_ONCE(vcpu->arch.irqs_pending[0]) & ie)
> -               return true;
> +       ret =3D vcpu->arch.irqs_pending[0] & ie;
> +       raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock, flags);
>
>         /* Check AIA high interrupts */
> -       return kvm_riscv_vcpu_aia_has_interrupts(vcpu, mask);
> +       if (!ret)
> +               ret =3D kvm_riscv_vcpu_aia_has_interrupts(vcpu, mask);
> +
> +       return ret;
>  }
>
>  void __kvm_riscv_vcpu_power_off(struct kvm_vcpu *vcpu)
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index bb920e8923c..2031beb9bba 100644
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
> @@ -311,8 +312,11 @@ static int kvm_riscv_vcpu_general_set_csr(struct kvm=
_vcpu *vcpu,
>
>         ((unsigned long *)csr)[reg_num] =3D reg_val;
>
> -       if (reg_num =3D=3D KVM_REG_RISCV_CSR_REG(sip))
> -               WRITE_ONCE(vcpu->arch.irqs_pending_mask[0], 0);
> +       if (reg_num =3D=3D KVM_REG_RISCV_CSR_REG(sip)) {
> +               raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flag=
s);
> +               vcpu->arch.irqs_pending_mask[0] =3D 0;
> +               raw_spin_unlock_irqrestore(&vcpu->arch.irqs_pending_lock,=
 flags);
> +       }
>
>         return 0;
>  }
> --
> 2.54.0
>
