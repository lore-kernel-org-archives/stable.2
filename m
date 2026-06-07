Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63127EC7C
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 04:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780807312; cv=none; b=E0hH0LePrCXSc/tl/wVaFVEu+V89Rd5Ew7Cm8GB+lZ/qicCgLqGoq/IWUDziRvNRknuje7WkrrwnCYjQe0lODnJMbvHiKNsztMDu4poVk3vADs2uWyiMtrjit5ZHBPs2IaHD34FSLcKvicTvLTbZgSqD2AcCaHbiLwcdh86H87I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780807312; c=relaxed/simple;
	bh=zw10WzH9Tr28aLBQzDK44CuhW3w/WSkEZ9mSyKQk4+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idwz5gnMpXsSLglERL81pyGQGaTtppMSDfTkR90f6zznsrlHRcBCRqQgwOW94Kksrai71K0bv1/zCH5EmCePQHq+AUl0RuA4/YgbaCSp5IzZCDkdZG8aa2OSqJK0rnYk8+ArlMGl45WY+Wnhu458lI6yALObABsa9ppCKEMDUpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fteKFm9Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fteKFm9Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11281F0089C
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 04:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780807309;
	bh=wjgnXGDtibQBEb4kF61nGsrg+xeD+keGIY9o1YJM9qM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fteKFm9YA4ySHooSBYi+3hZuo4tevzziErV6uJjyIEXwH0UO7GjxEBcE5HXqujuNK
	 QQUZ5UX206OAPY+ZO1oa+PoP2iHewnyZzlDuLVJiDPFq7baenTaDRGrHkD0b+zy6pn
	 V32Agy9vX6LQr7w+1r0u1gGPKR+Dh6g59R1iMaK4vOK5Lgn0BwhYiiQJnpnH8OvdwS
	 EST0L/tU/bQVA15oV6ejhUfMK0GyLIji6ltwn5dzZla/AtVanOWeVdBs5jW3TXlZw6
	 JzXT/GRQNb+HpmTTBXNPSnKU64DVmzisSr4kDiU8G3FGq99ouaUrtd+PxiYQ25iByF
	 I9rGL4hl3wofQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68cc6c7df99so4640431a12.1
        for <stable@vger.kernel.org>; Sat, 06 Jun 2026 21:41:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/vKjwAsU8tgDM35o9Zxy5hxD8spBn9SylNW20Yg8dXUXhwj2AJGaAtCSTdpchC6vtB2QfrVGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOJ4gwDzVEGDe792gLoBzxL2avPZDsLmodgRP2hx0ILAXCZcXH
	eSlixwpLQhsJ9GlujmrDjYRTDM5wAhw6Cw1TN4Nfh/4fw1Awz9gwArM1bTY0l5lvocllHorZxKX
	2L/e/0wRrhiIZwn3hXKB4jvpE/Dc08t0=
X-Received: by 2002:a05:6402:51c7:b0:67c:a6d1:c48b with SMTP id
 4fb4d7f45d1cf-68fa4e2c7dbmr5058461a12.11.1780807308444; Sat, 06 Jun 2026
 21:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531135326.2238555-1-yanfei.xu@bytedance.com> <20260531135326.2238555-2-yanfei.xu@bytedance.com>
In-Reply-To: <20260531135326.2238555-2-yanfei.xu@bytedance.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 7 Jun 2026 12:41:35 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Gk4dDek5HnKx5f_oSZ00ZWnk5Nf5ygiGKE22z8vDCqw@mail.gmail.com>
X-Gm-Features: AVVi8CfdV3X5ExYzOTFbLqmfRbAXzH21R98_Jvaw8v351jsO4seqkdKvp64fjAM
Message-ID: <CAAhV-H6Gk4dDek5HnKx5f_oSZ00ZWnk5Nf5ygiGKE22z8vDCqw@mail.gmail.com>
Subject: Re: [v2 1/2] KVM: LoongArch: Validate irqchip index in irqfd routing
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: harshpb@linux.ibm.com, zhaotianrui@loongson.cn, maobibo@loongson.cn, 
	maddy@linux.ibm.com, npiggin@gmail.com, sashiko-reviews@lists.linux.dev, 
	seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org, 
	stable@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, caixiangfeng@bytedance.com, 
	fangying.tommy@bytedance.com, isyanfei.xu@gmail.com, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Sun, May 31, 2026 at 9:54=E2=80=AFPM Yanfei Xu <yanfei.xu@bytedance.com>=
 wrote:
>
> Sashiko reported that the irqchip index is not validated for LoongArch.
> Add validation and reject out-of-range irqchip indexes to avoid indexing
> past the routing table's chip array.
>
> Fixes: 1928254c5ccb ("LoongArch: KVM: Add irqfd support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/kvm/20260525051714.485D51F000E9@smtp.kern=
el.org/
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
> ---
>  arch/loongarch/kvm/irqfd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kvm/irqfd.c b/arch/loongarch/kvm/irqfd.c
> index f4f953b22419..40ed1081c4b6 100644
> --- a/arch/loongarch/kvm/irqfd.c
> +++ b/arch/loongarch/kvm/irqfd.c
> @@ -51,7 +51,8 @@ int kvm_set_routing_entry(struct kvm *kvm,
>                 e->irqchip.irqchip =3D ue->u.irqchip.irqchip;
>                 e->irqchip.pin =3D ue->u.irqchip.pin;
>
> -               if (e->irqchip.pin >=3D KVM_IRQCHIP_NUM_PINS)
> +               if (e->irqchip.pin >=3D KVM_IRQCHIP_NUM_PINS ||
> +                   e->irqchip.irqchip >=3D KVM_NR_IRQCHIPS)
>                         return -EINVAL;
>
>                 return 0;
> --
> 2.20.1
>
