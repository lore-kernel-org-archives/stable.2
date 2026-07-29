Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08154052B2
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342097; cv=pass; b=jqgZyUwcAYlluS1iBr347WNzTTF79Ll7JZxIx21QpYYtqzQciN3mrxtT1rqTe1FMU7k76fKqogi9D3OnsXqIzvP+AuL6ahY/gWnbzO7SFYc+4ucD9jmr2TbrR0kGFaAp6qVMf8FNW2NwJXZdo2FlwSd3fErNh+5Vo0tP09SZUpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342097; c=relaxed/simple;
	bh=LyMy1F4QlR8PI9H1s9I6XJ2S/7VeTGQVnwWyO1tA/fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qsf+i5hPwginaY9GF3qsPrBEBJ/3GyTtvje9fIp1a+Yoss7ovL3v/lisUcYIMSYPsvAvFyu/9sUWUPd4akQZ8aEZcoCg6pqXipXL6l1NtYLJS3PGpmuRCZQrFwT8rAp6Vls8qTXDMJKy4qip/yLdJier31tkBFna6NesKBwXrCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=fAR/CNKI; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="fAR/CNKI"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f7872abb6so752286f8f.3
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 09:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785342094; cv=none;
        d=google.com; s=arc-20260327;
        b=d8+GBfFyPRRP/GGJYBbp55gQXqcIRwA7YB3DGvyyWuEgfjClkYr8I45G3Hndd9kZeF
         68UpOFAdaJ9uSmje6PKwkGZol3IeG57u2aEk10u/MPU+1XvSW5YqggQ5rPs5caihC2aw
         qAUZ9hFDjD0aCly4ksCvlMFPuxKdmnlTeFkGodHXTwxsFhx7sN3hXlwz65Rh73HMKrSK
         NzQChYpC8gRAhMK1hMEU9YjKztWOAF95eKK7fhSIobmXt+amcaK8Av/lWhrvKm/CGoFF
         YoC8x/0pubO3Tq1b0/HupKt+duYW1x9XXt/Z/eiek6yW+Dj2eQCjIaXjH2mbYffzIjne
         DUtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xlNUGStHPcM9h7uZ5gMcfZsRgLFM6lwcIC3C63GbVXU=;
        fh=rNek2Q7hmuaXX22wmAdggliBbjkyBqLJiPqsspGEdbc=;
        b=cotMtA+JbX0pOrxzjaPw222/CCfEYjLsHftTKNOyVQ2PKPtdpl1kdiQR7oYB8oaG/y
         FURowbxsRCFERjD4SPgYptS/eLH56LfHIk0qgQ+DEhMCm6r7VSvi6bx/OFvCLVjdXaOl
         yGgYLuJGPHBmcjAQYLnPbuQG8BDC9rB1uC8TllLbzaFY499Brg8yEeArQCbO2CbHMPUm
         jQ45lKHZ8HITkqPF2rZLwPyCSpwuzIryV+wqmDtRtJTfSbXXkcIkCq29STT49/CbuSVW
         /akPZXF6nQPkCDFUYowxNBqDR98i+wMxipQg7hwMjm8n0gh4annt6YoMLebXS/ABIQtS
         gaqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785342094; x=1785946894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xlNUGStHPcM9h7uZ5gMcfZsRgLFM6lwcIC3C63GbVXU=;
        b=fAR/CNKINJPvZ6qY+0+fxjat+cwjLzJErBHWl/kH2/FG23D/EjRNBiYE7qFzKISP3M
         5kOd4/NGw1H8Q/7gezl39QbEfbpGjhOaNncy8hGWL92p8V0Guyq6LbgEJKSi3q0BlcVB
         JvAnNgivFMXE7kcy+WWg7uR6jWt1mUAtCTC6duKHGE2en4Gh4jkNbJfZ/qRxbSoN5axa
         pazQgTfQ1HEumzBmwdhDasAbrIgzX/0U4QdCin0R2fYgWD0TmQvVyWM/WnHGeUbp12Eu
         Vl8BT7pFyHl7dLcDrcu+W+i8930fp6wEBGtQ3EHvDc/lj1AYkygLiqu8d4jV3QP30kQq
         t/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785342094; x=1785946894;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xlNUGStHPcM9h7uZ5gMcfZsRgLFM6lwcIC3C63GbVXU=;
        b=mGb8a4bHTQAPUyTxYP87cPY3bplcwrz3xkXWyJImXF4vrN0zFqWMCbVKNSlg3GsyEB
         BtIKXQPdFbWdeCulrKdzXSzNF8S5dFvjrTZIRJiU2im8Gm3CAo2O15Qww4qE8mWTYnII
         73KUYP4vQ/rVY1GUSo7TAQJlk/JurLNcaD8I9MVd7LxdLaD80gvnKIKS5+BuU/H7Lxhs
         XPX5IMMjvn8xuEIqI+osbIjYyPMif6XqsOjp+oEo4ykPniBcHummCy1WRpVcNWKMryQD
         ICmotxU2NroZolYIzAePSfqEmychkZ4QOIDe9C7vhCNtcz5OUYq0s1in4geqCe+ZKLro
         jQkQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqc2NnecaMeKDC3A+Lk6g2Cz8fWTjo0D6+6HizFBCxm21zF24JgNzpDkhIb6PLtlKBEZVRrTN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoYoBcpqNsJakChgqM0/rY+CMZUgRhQIsfAIH9NLelfq75Avpj
	5z5ns9jUmi+7s95OzmBG7UbYNnAqJXcn4MOOIOEVfF4FmoaF9kw8+GyiXdRefJYfBsKadvdiSYo
	soci+g0dSDaCPZuPEOaxsjOIJ1LMuwVxK5osK9Qkpng==
X-Gm-Gg: AR+sD12vRfhXmzXmmsaqWVVyb3WRzMl9I7z7NfsZyyaGZsSSsOmCW/y4AM2hhCj5UvT
	y1U1RTxKp6ln9nXak3EeMGfr9yX3JHOzO01kYWDPvhKAC1/dHS9+BrtXH9mNVd6iu6LDLT5XX10
	tZRTRy5/ned+/KGC5/4n/oiTQLr7TvpM0/siT/dCK8hWYqkopCkbc2tDL8sjvWxA/Mb7Frj0SBm
	k+aUW+Tr07lDUkWMwMN3wlgZJl5BCuuXhFa05WWEyVLxCH+t3/MfCNL+NC5QGrW70LNs5/51WPz
	FQTeP/rabonEwx5iAQh6WpE2//vCpS28iRIJT5kdY5jXEHZZGv3CvdBCnAcgJEGQoc7MAWEzgpt
	NgqlnI8NZyWe/Er6389+SEZQQLM/BGuneAsMKqPQ0gdEN1baxsOVpnOiHmogYjyHP
X-Received: by 2002:a5d:5f51:0:b0:47f:91eb:342 with SMTP id
 ffacd0b85a97d-47fb1e89ab3mr9574371f8f.13.1785342093792; Wed, 29 Jul 2026
 09:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729075230.743030-1-shanbeeyoo@gmail.com> <20260729120733.829457-1-shanbeeyoo@gmail.com>
 <20260729120733.829457-4-shanbeeyoo@gmail.com>
In-Reply-To: <20260729120733.829457-4-shanbeeyoo@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 29 Jul 2026 21:51:19 +0530
X-Gm-Features: AUfX_mw18Ate4H7RNWrC9_sDszX8h_ptllZ_3py1A1MYtGllTZvUWlrvnw0-9-Y
Message-ID: <CAAhSdy0y-K3_-=_SCDwAqEiCb0PKmNHVcNDgyY+pGGF4N3gEGQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] RISC-V: KVM: Widen G-stage fault address to gpa_t
To: "Bingyu.Xian" <shanbeeyoo@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Quan Zhou <zhouquan@iscas.ac.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 5:37=E2=80=AFPM Bingyu.Xian <shanbeeyoo@gmail.com> =
wrote:
>
> fault_addr in gstage_page_fault() and the fault_addr parameter of
> kvm_riscv_vcpu_mmio_load/store() are unsigned long.  On RV32 with
> Sv32x4, guest physical addresses are 34 bits, so a 32-bit unsigned
> long truncates bits 32/33 at two points:
>
>   - reconstruction: fault_addr =3D (trap->htval << 2) | ... is evaluated
>     in 32-bit arithmetic, dropping bits 32/33 before widening;
>   - the MMIO handler call: even with the local widened, the handler's
>     unsigned long parameter narrows it back to 32 bits, aliasing
>     accesses above 4 GB into the low 4 GB.
>
> Widen fault_addr to gpa_t end to end: the local in gstage_page_fault(),
> the (gpa_t) cast before the <<2 shift, and the fault_addr parameters of
> kvm_riscv_vcpu_mmio_load/store().  The handlers' internal uses
> (run->mmio.phys_addr is __u64, kvm_io_bus_read/write() take gpa_t) are
> already 64-bit, so no further changes are needed.
>
> Also in preparation for sharing a common struct kvm_page_fault across
> architectures, where fault_addr is gpa_t.  No functional change on RV64.
>
> Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programmin=
g")
> Assisted-by: YuanSheng: deepseek-v4-pro
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Bingyu Xian <shanbeeyoo@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.3

Thanks,
Anup

> ---
>  arch/riscv/include/asm/kvm_vcpu_insn.h | 4 ++--
>  arch/riscv/kvm/vcpu_exit.c             | 5 +++--
>  arch/riscv/kvm/vcpu_insn.c             | 4 ++--
>  3 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_insn.h b/arch/riscv/include/=
asm/kvm_vcpu_insn.h
> index 350011c83581..a5c50dd4a884 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_insn.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_insn.h
> @@ -38,10 +38,10 @@ int kvm_riscv_vcpu_virtual_insn(struct kvm_vcpu *vcpu=
, struct kvm_run *run,
>                                 struct kvm_cpu_trap *trap);
>
>  int kvm_riscv_vcpu_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run,
> -                            unsigned long fault_addr,
> +                            gpa_t fault_addr,
>                              unsigned long htinst);
>  int kvm_riscv_vcpu_mmio_store(struct kvm_vcpu *vcpu, struct kvm_run *run=
,
> -                             unsigned long fault_addr,
> +                             gpa_t fault_addr,
>                               unsigned long htinst);
>  int kvm_riscv_vcpu_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *ru=
n);
>
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 6c8530b9f29e..28cf9b27bb07 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -17,12 +17,13 @@ static int gstage_page_fault(struct kvm_vcpu *vcpu, s=
truct kvm_run *run,
>  {
>         struct kvm_gstage_mapping host_map;
>         struct kvm_memory_slot *memslot;
> -       unsigned long hva, fault_addr;
> +       unsigned long hva;
> +       gpa_t fault_addr;
>         bool writable;
>         gfn_t gfn;
>         int ret;
>
> -       fault_addr =3D (trap->htval << 2) | (trap->stval & 0x3);
> +       fault_addr =3D ((gpa_t)trap->htval << 2) | (trap->stval & 0x3);
>         gfn =3D fault_addr >> PAGE_SHIFT;
>         memslot =3D gfn_to_memslot(vcpu->kvm, gfn);
>         hva =3D gfn_to_hva_memslot_prot(memslot, gfn, &writable);
> diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> index f09f9251d1f0..6506411a3f78 100644
> --- a/arch/riscv/kvm/vcpu_insn.c
> +++ b/arch/riscv/kvm/vcpu_insn.c
> @@ -371,7 +371,7 @@ int kvm_riscv_vcpu_virtual_insn(struct kvm_vcpu *vcpu=
, struct kvm_run *run,
>   * Returns < 0 to report failure and exit run-loop
>   */
>  int kvm_riscv_vcpu_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run,
> -                            unsigned long fault_addr,
> +                            gpa_t fault_addr,
>                              unsigned long htinst)
>  {
>         u8 data_buf[8];
> @@ -494,7 +494,7 @@ int kvm_riscv_vcpu_mmio_load(struct kvm_vcpu *vcpu, s=
truct kvm_run *run,
>   * Returns < 0 to report failure and exit run-loop
>   */
>  int kvm_riscv_vcpu_mmio_store(struct kvm_vcpu *vcpu, struct kvm_run *run=
,
> -                             unsigned long fault_addr,
> +                             gpa_t fault_addr,
>                               unsigned long htinst)
>  {
>         u8 data8;
> --
> 2.54.0
>
