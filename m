Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BEA27B35B
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 04:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780807286; cv=none; b=LiBD8QHtXlmbe8S9dbd7JuLsHuH2c/LsU7CtilOM6GZTloNVGfrhDcTBVqSvkOW09JmumS9Nls5RNCEEj5J6JAXV96fa6cdF3IsVlCsr3UkHWd1gNUQamc8nf0WFzu1lcdOFrZdJzjb4jdHDVKJ742ylklmnbH173nn/BkDJHMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780807286; c=relaxed/simple;
	bh=/DH4VhimRHnMz+eyOydnUJcx+rf6CrAJ8lBeVO8RsXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cw3UdbgLwSn2VIYBThvuyxi2hTIkc+VFUrOkERo9a29APeoYVVLsIr5rnq2bsCapLaXWSinS/rcocunfSOiM/iOp8eMEIPiJwyKip0pbk0tv/3xf3lkVCi3JRolJ4vhNkfq97EM3LYFV5hjfkAR832fh/oZ0fRcCVlD9aX/XVjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRTEh9DB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRTEh9DB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993711F00893
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 04:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780807285;
	bh=ljyyB1Wby8hpR9aoUaGD8JjiN8Lswlx633ECi6/VALo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GRTEh9DBuB5bxOL3Y71KsF8V35xpmVC7pZBZU0P2XG4g2yE+9741DGQu3948AJyRu
	 yMn943cFif/dHG+4ud6uYuQfvmG3UvZnTA98am1NYEzw87fTCxVWIn5lIR7bAsMFn8
	 oAqFNBsX5ds1yjbLRObbBQpsVJL0Lg9eknb7lJ3xlQZsTour4aHlbAlRgNC13zm/XQ
	 KduzwL1pJwRpKYlKCouDGdFaYV0oRxQ409/xugRQGTU4V2kR1nEfTXOgDx5JMAKVVY
	 LP6Nco9bNYYaD035fwRUUbDA5VtJMU4wUJ4DlBVMe7+DNMhZzT7rNCZsyBJQ7JB5pS
	 GY78ZSYz6u/5Q==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-68b90fc6a1dso6031427a12.1
        for <stable@vger.kernel.org>; Sat, 06 Jun 2026 21:41:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+O0B80aWj2mGwwU0lNKqO0XklkZtrMSItXh0wpIMvUM/ycQUkbl9in/VmEefiGHNn/1gRe0mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvoYdSCwbgoMlN3iP1gFh5/RmXdxFBtByAkaY1ZK3z47uGfcPS
	5AL47HPVuaM8qxHxF75Vh4nyfLf0KKEENTzCkf8FeX3vWCOQJcilCjOXb3DTjKJHuE7K7BEhb9r
	3CJBtKJSvOAWBhnFNjyd/i+vuEPDnyk0=
X-Received: by 2002:aa7:d6ca:0:b0:691:2ef1:d7d1 with SMTP id
 4fb4d7f45d1cf-6912ef1ddb5mr2007013a12.16.1780807284248; Sat, 06 Jun 2026
 21:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603023430.1748197-1-maobibo@loongson.cn>
In-Reply-To: <20260603023430.1748197-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 7 Jun 2026 12:41:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H53PNRdH02c9O8ngdoitWts6=t-42Xa1EvWgLS+05qznA@mail.gmail.com>
X-Gm-Features: AVVi8CfjB7rXjzkWVlnAgfl60GhmPz9uUWIw4VfP_5gsNWsFEDA1KhHVwCzZmzw
Message-ID: <CAAhV-H53PNRdH02c9O8ngdoitWts6=t-42Xa1EvWgLS+05qznA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: Fix FPU register width issue with user
 access API
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Wed, Jun 3, 2026 at 10:34=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> At the beginning, only 64 bit FPU is supported. With FPU register
> get interface, 64 bit FPU data is copied to user space, the same with
> FPU set API. However with LSX and LASX supported in later, there should
> be FPU data copied with bigger width. Here fixes this issue, copy the
> whole 256 bit FPU data to user space.
>
> Fixes: db1ecca22edf ("LoongArch: KVM: Add LSX (128bit SIMD) support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/kvm/vcpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index e28084c49e68..2e40386f8686 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1312,7 +1312,7 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vc=
pu, struct kvm_fpu *fpu)
>         fpu->fcc =3D vcpu->arch.fpu.fcc;
>         fpu->fcsr =3D vcpu->arch.fpu.fcsr;
>         for (i =3D 0; i < NUM_FPU_REGS; i++)
> -               memcpy(&fpu->fpr[i], &vcpu->arch.fpu.fpr[i], FPU_REG_WIDT=
H / 64);
> +               memcpy(&fpu->fpr[i], &vcpu->arch.fpu.fpr[i], sizeof(union=
 fpureg));
>
>         return 0;
>  }
> @@ -1324,7 +1324,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vc=
pu, struct kvm_fpu *fpu)
>         vcpu->arch.fpu.fcc =3D fpu->fcc;
>         vcpu->arch.fpu.fcsr =3D fpu->fcsr;
>         for (i =3D 0; i < NUM_FPU_REGS; i++)
> -               memcpy(&vcpu->arch.fpu.fpr[i], &fpu->fpr[i], FPU_REG_WIDT=
H / 64);
> +               memcpy(&vcpu->arch.fpu.fpr[i], &fpu->fpr[i], sizeof(union=
 fpureg));
>
>         return 0;
>  }
>
> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
> --
> 2.39.3
>
>
