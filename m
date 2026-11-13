Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794550971;
	b=qJO6+bxXF7kMQmJklyZPWu4sitf6ORnwJ37VWlyfoLE7EnkulhHaBNvUsP1JXD8gpwb3
	 HDSIKOxmDDk7/s6VHgLVJFmrx3pgSfq0n9tWvc4/l8zp42cA5iwJyyHfK06iU1VOfCiPu
	 c9QxO5SJhb1fxKqUs+mTYzKvH9DJzMYnm4f460k9RgJ1CJUxvqRVm0jcFmEeegrhzuztD
	 f9lTUZBVb8fa3QypgUHsTwaBd04RlMoLK+I4b0UqSACzqFI4FIzURJENaHrRqkpwSQCOE
	 ebSrxWEVoB75meagrxRtp10fs2F+BSChn/msBYRisISfb6HXXnEFLo32iqmWWsnPIVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794550971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kaz5hFFXdMAGt/u8uH63i3Sm8RKg80iivRox1D7f/QA=;
	b=x7t9hg2R2Reaee1k7iHZ84WngdZiZgFbCMK/5PgiXRnmf6lk7BztIt8UJArc9VqvR/mw
	 JtOgyARz5EH5XppychQr/IJXLfwUz97C7YjMT0IpuOdPYWRKo96yRLcdis4EefuHJOVEd
	 9hGYNJMv2K0g1QUQtj4GTgHHLg+D0KZN5OLct0qZ3SYAXLBywKdUk5gjnZQhtgiFk/8Ku
	 HOT9XUo91BCEII7VdtRDs3erzRxs7b6wrfZ6DUbOXySLRaAtNUoFRFxgN85q1VRDx9Qf6
	 x75Vvwu3LzteVAJqSuq9Q9KAGGpSnAch/3HNpeb7LuHpY3KKMjwDhi+a7GEbyev9iTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=BZ7XEh1O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3297E606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 06:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3297E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=BZ7XEh1O
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3adfc004920so7565581fa.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:22:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794550969; cv=none;
        d=google.com; s=arc-20260327;
        b=mV43lZr4IWtPS+xI+U51lKhHRlfPBJsX4xAyJEjt3jPlwnm8FxFE+hTEZXWMjhfekc
         elb6gVpTEW3ipGWEn1iwYyRMed/hrOBi+cS8hkBBo0Qc8kJl7z5QW4D5gWOQIAMbRo1f
         ABkld2JF1M0QtkTnKk4t7UAdLhisWHs219yBLcMuYzpxzHh9V4hA35FVUh7IMWqpxVFX
         LgZ0IEXkSiwSvreeLnQlCcKq5HMzbNfQVHiMmOb9zjYu78ROpNncKur6OMYsdoRBPE+j
         VrWmA465t3ShAawEqiUXrYqmDLS/pfNgbaqtLmHs1Ap8tx3LhpmHQck8GAPQTZ4l/Po7
         fxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kaz5hFFXdMAGt/u8uH63i3Sm8RKg80iivRox1D7f/QA=;
        fh=6xOQH+9K8xrBOoAYd474rcZWE/BJdCEMffEQ+XZ+GYc=;
        b=hAuVEh3BNgB0CUaLhG3TIUfsenk2zG8un4lDiRgalVu8KEt+jipD7A5sNjTM2C7FwB
         7R47jGDBtwY8zYSDGbQPAiC7IVypqjj1xzZ6c9IU6B3rsajl7uV6gXhZup+GIeyNIVoT
         LfiL6TcLIQF5f1sP3dK9XSnpa1FlcAB9ALyUwTEcS22hqiv/gdUyCeKt3GeCraLFLHK7
         Tkhc/nE38q3tuoOXMBI24beiDlP5aienmBV94nHQiXM+102DEwwk1nHiopPpZuBf5GNI
         nzuSEnTbd6Bbud9gMXFJZIN+OrKrAs3orMs8uOwCAppSqTbWbtNGu1zZ4jLVOO9G3AwX
         NaeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1794550969; x=1795155769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kaz5hFFXdMAGt/u8uH63i3Sm8RKg80iivRox1D7f/QA=;
        b=BZ7XEh1OUBU7AaigZZVIo7uWM6BGc7GFHVDN4uZTK8vSsBEo8lK90GCKY0GZTyfG71
         OzckKGZj5wCmtUZ8AAiLG+RkEgGbQk0MJg97uAjvABrNj8wLZBy2OhxvAXGJBGF7VkVY
         p7v5LVqRZIy0jILUFM7mituBmVZWCTbShH6m5ofC/gWKFtFpBNTAPnZiwZIh6/Ka4qxQ
         BEK19g/F4IOwjLrhFNrbeJhJqRUTUNx09f+37KXIGDlYUc+au7YObthQcCOdU3EvjcuW
         1arUwwt1SphY0qCfiBGtUmegDu0GbzNr7IprfbigT/yROyajzZEEkPTcWE7oQfcleKz8
         X2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794550969; x=1795155769;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kaz5hFFXdMAGt/u8uH63i3Sm8RKg80iivRox1D7f/QA=;
        b=yZwJGHhaj2lI+05ec0wDJZJWjD0UcjTa+iN1+Zlg8qtv7x7iYUHX6rxp+LVGzPhAje
         SPmKIke1hJEWn37Z8zoBT5EY0mrXuEME25Xyw/enwvHeQSbcua6g/1bi2O5/7DySZNXz
         x9hUI1FblV/ZpF7SGhqeC/tBXSGz+f6zJVuB7G3IBdLJ+l55wA9PAVKXKC7Rn+qwT7cW
         f9lR3JUUQiIh5TAsG+ZBMLSCP8bLSMwTgr60b+5AwdSNgCjGKjBK4BvMsLWamqqPe/h+
         UxbnSQapl5ZPT0Gs0kdnDRwVS8geXoSI4aor1slIiedyzIr9mlCERRbU1L3QEhFqArx/
         XYAg==
X-Forwarded-Encrypted: i=1; AL+hErHVV8PaqHBgXXlIP1PtPKmxmboCUnCyEEEFBxgk4gaZo7ne79w7eOLdgJfYy7F6dzWQn9IZ2Ak=@vger.kernel.org
X-Gm-Message-State: APuU4Z/t+7nqJnzhQXTdqPF74/NLwCYY1aUWfxWXF7trhAnr6TnKjFWQ
	MphKX4Qve9zabUCev3o3px25d2UUQ+PiLtMzi9r/4QID/rWmd73UB7jnL9ExvEapOxDsLKjyyqn
	KunlzzzXnlT0VzlStDuoQHe/nJN1hDjLU+S6K1H+d4A==
X-Gm-Gg: AYBFou1aI8ppJJzrHb8R5fGszgPnsEVA3NF4NFkADefTzV/9qOgFnlUBnzYz7oFTDN+
	D288JbVbP6ZDBItYeZbmgMJjKTy6lt8ysOSTOtKL8yyPYnRKBwKErFFhedAy+KN0i4tj7dOAfWZ
	mItwjD/i0nktzb2h3eiz2lpWxZ+MeOcpIXC/rXoPlPjFQMXdekzQ3t+3Nde1R2OoM2rrBUKd8GQ
	Dq9+bFH3AgqDcnY3JwRpgz7VG4IJrb9gRZTAdfif8vvlS2JWGQDYfjBn5mTZ+Cz3D9Y5FD2JZRi
	yy881jqq4kudAkRUjwfZ7GGcR3/zCxunw2GAHuoYXMY2j3GUb5yQQUf8kkTDvk2tos14mkp8DwO
	Lf1S0gkxYIRrooELgoVhsIbm7imJklM5ewIG0b55KRTanC8pPNjV4QVPjbHBspL1o7UE8hOHLrg
	sOjFzXPpKggz/7ERfYIW6W7xg+f3VCyct2a5D6VsRIkptTROzbXsdXhmrZxWQvw3S7ck9vSYVnu
	3b6hQ==
X-Received: by 2002:a05:651c:984:b0:3ae:25db:778e with SMTP id
 38308e7fff4ca-3ae2b4f8c44mr5983811fa.25.1794550969373; Thu, 12 Nov 2026
 22:22:49 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <OSQPR01MB6326DDE9C2F390EA3F0F444EC2662@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
In-Reply-To: <OSQPR01MB6326DDE9C2F390EA3F0F444EC2662@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 13 Nov 2026 11:52:37 +0530
X-Gm-Features: AclHuK8kJEX4JlRXb2KsetLnyCm5PUC-HVvhCYSR9hJmTyId-OXBRfW2YskwCEk
Message-ID: <CAAhSdy1vRrD17+a2-QLAqDiJd=S=H08n66x9hW+-NFQEKdU01g@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix builds without CONFIG_RISCV_ISA_V
To: slack up <yxcnew@outlook.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Andy Chiu <tchiu@tenstorrent.com>, 
	Yong-Xuan Wang <yongxuan.wang@sifive.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 11:02=E2=80=AFPM slack up <yxcnew@outlook.com> wrot=
e:
>
> From: Xiaochun Yu <yxcnew@outlook.com>
>
> Commit b5060a4aa33d ("RISC-V: KVM: fix vcpu vector context
> handling for kernel-mode vector") made the KVM vCPU load and put paths
> call get_cpu_vector_context() and put_cpu_vector_context()
> unconditionally.  It also added an unconditional call to
> __kvm_riscv_vector_restore() on the guest entry path.
>
> The no-op definitions of the first two helpers live in <asm/vector.h>,
> but <asm/kvm_vcpu_vector.h> includes that header only when
> CONFIG_RISCV_ISA_V is enabled.  The KVM header also does not provide a
> no-op __kvm_riscv_vector_restore() in its disabled branch.  As a result,
> a KVM build without CONFIG_RISCV_ISA_V fails with missing helper
> declarations.
>
> Include <asm/vector.h> unconditionally to reuse its existing no-op
> helpers, and provide the missing KVM restore stub when Vector support is
> disabled.  This does not change the Vector-enabled path.
>
> Fixes: b5060a4aa33d ("RISC-V: KVM: fix vcpu vector context handling for k=
ernel-mode vector")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiaochun Yu <yxcnew@outlook.com>

A similar fix from Zhanpeng Zhang is already merged.
https://lore.kernel.org/r/20260922021823.44251-2-zhangzhanpeng.jasper@byted=
ance.com

Regards,
Anup

> ---
> This single patch fixes a build regression when KVM is enabled without th=
e
> RISC-V Vector extension.
>
> Tested on base a804c5742bff (Torvalds master):
>
> - CONFIG_RISCV_ISA_V=3Dn, CONFIG_KVM=3Dm: full Image modules build passed=
.
> - CONFIG_RISCV_ISA_V=3Dy, CONFIG_KVM=3Dm: vcpu.o and vcpu_vector.o rebuil=
t.
> ---
>  arch/riscv/include/asm/kvm_vcpu_vector.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_vector.h b/arch/riscv/includ=
e/asm/kvm_vcpu_vector.h
> index 6371d5ea5392..ebc619ed67dd 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_vector.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_vector.h
> @@ -11,9 +11,9 @@
>  #define __KVM_VCPU_RISCV_VECTOR_H
>
>  #include <linux/types.h>
> +#include <asm/vector.h>
>
>  #ifdef CONFIG_RISCV_ISA_V
> -#include <asm/vector.h>
>  #include <asm/kvm_host.h>
>
>  static __always_inline void __kvm_riscv_vector_save(struct kvm_cpu_conte=
xt *context)
> @@ -55,6 +55,10 @@ static inline void kvm_riscv_v_exit(void)
>
>  struct kvm_cpu_context;
>
> +static inline void __kvm_riscv_vector_restore(struct kvm_cpu_context *co=
ntext)
> +{
> +}
> +
>  static inline void kvm_riscv_vcpu_vector_reset(struct kvm_vcpu *vcpu)
>  {
>  }
>
> ---
> base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
> change-id: 20261021-ospp-c1-b4-submit-e22dc09faf5a
>
> Best regards,
> --
> slack up <yxcnew@outlook.com>
>
