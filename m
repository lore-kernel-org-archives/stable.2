Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794934928;
	b=iJHXhGhNSstU0jzxeYyjlzh4bjWkmQLSr9XO74MNh2F0bLOntLX6IUbkR/mKLpTSp2q0
	 2kHXKTmomyV0PD8ayOoBp9e7HYgrhfto70dsILjQ6kKML3nP2x+OuJNzLt1x9cQu74hFw
	 RZGzuj++aHr8XCUfHH0TEEHY41bHGs2WSphEmlECOCnR68V0nUyHUBtVUWQ1bHimBD3cC
	 Cc12GBhP56+yHf5+S5SaySQlFDeYPgpusk+uBc8a1FEd7Tm4zMCppcxLiK6w8C+XAgGLf
	 T+P3uppFMc+6PPOlbQs7IVDut1dbC9croVBgZCFImCO8fG/24QcTQ8XuXfujNn5/UIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934928;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=lK1gQ3SmM7pQ4McAq9Q5/iKvsOkayH6mq/h10984ZUs=;
	b=4ql1qeudOgJVJ1S4iDQ1bWddmFHBzJ8q+6eCIUASJLbp8HPd6q8ccQs/sBbF42CJI4yp
	 QHqRB17jU6PUFOiBVPcluuMoIQCJu5wuHxzT3itq/t4FgnggSLxS/8mAb7chGw2WoQ44t
	 EdjKsQ2u+EQ9pUuDtJBXRfxs64D/w511QeGlGENpffNPfFF6zsfHCz2DWChyezJN6u9Bf
	 H+MaczjdNF1NLP/C1D75mAomqfR0H0qhDMwluAyqjKRJQWY+8oGnD0a6lKPTunbJtW7JR
	 nRpbBaUyJsWi6XApWWeHt5zekuTeXMF0/AhMEQTXFEMNq5pTfy1BOh6HKzumzPjMaog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="fU+zi4/S";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=oJ85KNWU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583F606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6583F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fU+zi4/S;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=oJ85KNWU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794934926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lK1gQ3SmM7pQ4McAq9Q5/iKvsOkayH6mq/h10984ZUs=;
	b=fU+zi4/SLlfxMW5mWcSd6DlR8NZy6+hgY4ndomvukA6lQKTxzvlSxJ3qOEbGLy5fB+5QO3
	oafxEb8ekJ0S0ygoKp98v0WpUyy9uMgC3DzZOZyAvQ526sWFMVGXd7445bra1/+pDqrR+N
	0XpufZQSQ81y74bUKw/qBixosW7UqBM=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-rJRjN0_EPXqThRJaG4gQdw-1; Tue, 17 Nov 2026 12:02:05 -0500
X-MC-Unique: rJRjN0_EPXqThRJaG4gQdw-1
X-Mimecast-MFC-AGG-ID: rJRjN0_EPXqThRJaG4gQdw_1794934924
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5ece7e4af28so4427829e0c.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:02:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794934924; cv=none;
        d=google.com; s=arc-20260327;
        b=ps4NpuF9At+yt6nTa9EyQ/xMtz51wCL1YMZtZHXtHNybF634mH4NiP5I5hggxUDJBS
         7ea7zKRKYoyNTMYPwvCXwR6npUuOvyNKZc6kQg0f1dI5HJ0JEPEGjbOtieclecuhl6K/
         optg7OppO7cz7uoFSXqdK5wXAdlvu9yQXKHYI7PdPDupT5R0yyev4VjVyEOWdsw9SISv
         pqdn5rtRtY0DRDi5QE6APhwwSpuUnuSf2Ps2WgcyMfDGEddZzd4VkPisFV6ga1iYVdHp
         OvLqB3nHAxgh0hTlPL5YbrDNhRciqbmMvU3n4tPztQu25bdO/p9ObtlQqGWlegBrisOa
         1nww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lK1gQ3SmM7pQ4McAq9Q5/iKvsOkayH6mq/h10984ZUs=;
        fh=YLq+DSaV8z3/rwClu3BhYsdSUPBAWhsRkfyDnodBM5s=;
        b=jFT8VbU3DS5zia42+QMLVmfwFU56gwUmIWeUWhaSNivST4kBgtPvITbyCZIEdxFawI
         0hIqfKHVEvJf441RBCV13D4i98M4sx4qRWeq7RX4WFR38bc3Zsq4Prt1Ul9kCHLE+fDv
         yT4s20anAEhJX5LiJxzSNrLTscKCPLmS7/ZF3do1eZS8grUiAmo2yOymrpxCfSY+gBtH
         pkzpTom/9eNccLVa6F/D/Akji9YK7QPlu9M+b/AtroWFjmiykJqdK/ylx7KSTLQpwVu0
         cPNNE+65c8OMMnC0Wnq/88Vd6oGcg1DXUKXU2M2Y1NauLd8RJj/awqz91J1+RErauYm1
         yfyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794934924; x=1795539724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lK1gQ3SmM7pQ4McAq9Q5/iKvsOkayH6mq/h10984ZUs=;
        b=oJ85KNWU9tlgUffmfvDkKq4X8WXsVgot1WXmbe4KZ7sYJaeX1a8Ol+BoOIqVau2Fmo
         ad1o2iH+38UOmnBa73LByH2ejMy+FWwI+zu7IwQrRassE71VQ4E/PXnN4bCF7P0vPwQ+
         KLbTbuHs1DnjXhRloB00cSDCFT+LLWR25UqHGJOc0qohaw/SbqljT0Vj9BwVxGUJ3Huf
         tq7L2+nt4ZXvAAMvzKd6SYXeEpLmAf7SuQtfVQ0u29Ogl9C9Wq/s4cy+nlZeJNIHejq2
         4QjW8C11UtftBro+7Nay/dV7DSxietfTQjecp7tqvCJr9xVhMmbt7pxgJlazP2nKR7X4
         oRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794934924; x=1795539724;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lK1gQ3SmM7pQ4McAq9Q5/iKvsOkayH6mq/h10984ZUs=;
        b=S/ZOho2rG1g9AGBSYMIBZB0ctbOd3Cb2HsV3aJaKVXMZau5qTdFm+mi4Bl0uLwlEC1
         1zmPOcmTmRwBOP6pDw5bKaOklC6u9IDUSJNtDJab8Ul6kNvJewaoR362HLc8TdDmjuco
         GafbsFly5YEJ247AqHSV/7XT2XdKd7vrzUgutM8kmnm9p3OZ5OTlVpOCmNJ61KX6qOt4
         3ekH8eFnUjMu74nHxtjCxJ0+lECZO3SpxGdHyaE0rIC7daeMk29rwBFUubrIEz61StN9
         78HCmC56POkbiIn4l5UOLRVboN70UGj0DPC/Y49HDU7eb1IwGdifr+d6INISSTJrmj3x
         03lw==
X-Gm-Message-State: APuU4Z/VcVhA9TwC+J66T/0ewCb2IY1QoQ1nmj3pwFxKPrrBX0osuuFw
	4ARKNnbrRkW8krhC8RkfIpBlozoITUvLvRag2FrBZMshFgF7iDixZZLEGSZew6HVI4tfrf+qm6b
	P4C9737peaUblVBcz3xYUE0h5yHx2XfBIf+q0pNWTohRixsLAkBvuA45tE5kPiirNbKKkHT4/2k
	ymew1EJmgYoscBubapF8Fyv00VOFGtQUjSd9FpLEucMkk=
X-Gm-Gg: AYBFou1nFBRBRdvc0oGqoVoOvIKhgv/MzjSvEzuRurG0aNuv2u2SoUTKYNPdOQQrA5E
	VsG2cOebB/zQnPf8UgFe2XxVK1HmdXuD4Rn5wE9Rz1MiCuTaSOwFMC11p5IB4YaUxbZmEBfFS/X
	oEIMoH/zb+wLVT90s0RjYkHNsLx17iar9gwpNmeb7qUIH1Ol1QDyVpyHVpruGjxPCl02WpzAd+L
	kqoh2dX4bYuJPE9hS/8eR6sf1C+v7poO5eRWItLQDol
X-Received: by 2002:a05:6122:218e:b0:5ea:bda1:7689 with SMTP id 71dfb90a1353d-5ee646ad053mr135009e0c.4.1794934924136;
        Tue, 17 Nov 2026 09:02:04 -0800 (PST)
X-Received: by 2002:a05:6122:218e:b0:5ea:bda1:7689 with SMTP id
 71dfb90a1353d-5ee646ad053mr134916e0c.4.1794934923474; Tue, 17 Nov 2026
 09:02:03 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117161945.1965350-1-sashal@kernel.org>
In-Reply-To: <20261117161945.1965350-1-sashal@kernel.org>
From: Charles Mirabile <cmirabil@redhat.com>
Date: Tue, 17 Nov 2026 12:01:52 -0500
X-Gm-Features: AclHuK-GuBoblpoTeZ4BDh_uFzuOqrjwdowxIkzfWrfHKMFzCIIY_qwxPncTfQ0
Message-ID: <CABe3_aGGSWW2LrPHNtAU8Lc2NqgeOQJrZNma2WzQ-JH+vFyWJg@mail.gmail.com>
Subject: Re: Patch "irqchip/sifive-plic: Cache the interrupt enable state" has
 been added to the 6.18-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>, 
	Radu Rendec <radu@rendec.net>, Paul Walmsley <pjw@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All=E2=80=94

On Tue, Nov 17, 2026 at 11:28=E2=80=AFAM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> This is a note to let you know that I've just added the patch titled
>
>     irqchip/sifive-plic: Cache the interrupt enable state
>
> to the 6.18-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      irqchip-sifive-plic-cache-the-interrupt-enable-state.patch
> and it can be found in the queue-6.18 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This patch makes substantial changes to the driver and how it
processes interrupts. I am not sure it is a great candidate for
stable.

>
>
>
> commit 036776c9c1002f36de16fa9e17e5fafccd095864
> Author: Charles Mirabile <cmirabil@redhat.com>
> Date:   Fri Oct 24 09:36:42 2025 +0100
>
>     irqchip/sifive-plic: Cache the interrupt enable state
>
>     [ Upstream commit 14ff9e54dd14339776afff78e2d29e0edb3a4402 ]
>
>     Optimize the PLIC driver by maintaining the interrupt enable state in=
 the
>     handler's enable_save array during normal operation rather than only =
during
>     suspend/resume. This eliminates the need to read enable registers dur=
ing
>     suspend and makes the enable state immediately available for other
>     purposes.
>
>     Let __plic_toggle() update both the hardware registers and the cached
>     enable_save state atomically within the existing enable_lock protecti=
on.
>
>     That allows to remove the suspend-time enable register reading since
>     handler::enable_save now always reflects the current state.
>
>     [ tglx: Massaged change log ]
>
>     Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
>     Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Link: https://patch.msgid.link/20251024083647.475239-4-lzampier@redha=
t.com
>     Stable-dep-of: 0f214e5bbee5 ("irqchip/sifive-plic: Avoid signed shift=
 in interrupt enable mask")

Especially if we are just trying to backport this commit...

Consider the following version of 0f214e5bbee5 ("irqchip/sifive-plic:
Avoid signed shift in interrupt enable mask")

diff --git a/drivers/irqchip/irq-sifive-plic.c
b/drivers/irqchip/irq-sifive-plic.c
index ca70641982ed6..0995e1fdd5b47 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -97,7 +97,7 @@ static int plic_irq_set_type(struct irq_data *d,
unsigned int type);
 static void __plic_toggle(void __iomem *enable_base, int hwirq, int enable=
)
 {
  u32 __iomem *reg =3D enable_base + (hwirq / 32) * sizeof(u32);
- u32 hwirq_mask =3D 1 << (hwirq % 32);
+ u32 hwirq_mask =3D BIT(hwirq % 32);

  if (enable)
  writel(readl(reg) | hwirq_mask, reg);


that applies on 6.18.64. Forgive that this is not a proper patch for
git am, I am not at a system with git-send-email set up.

>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifi=
ve-plic.c
> index ca70641982ed6..2056a4d45656a 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -94,15 +94,22 @@ static DEFINE_PER_CPU(struct plic_handler, plic_handl=
ers);
>
>  static int plic_irq_set_type(struct irq_data *d, unsigned int type);
>
> -static void __plic_toggle(void __iomem *enable_base, int hwirq, int enab=
le)
> +static void __plic_toggle(struct plic_handler *handler, int hwirq, int e=
nable)
>  {
> -       u32 __iomem *reg =3D enable_base + (hwirq / 32) * sizeof(u32);
> +       u32 __iomem *base =3D handler->enable_base;
>         u32 hwirq_mask =3D 1 << (hwirq % 32);
> +       int group =3D hwirq / 32;
> +       u32 value;
> +
> +       value =3D readl(base + group);
>
>         if (enable)
> -               writel(readl(reg) | hwirq_mask, reg);
> +               value |=3D hwirq_mask;
>         else
> -               writel(readl(reg) & ~hwirq_mask, reg);
> +               value &=3D ~hwirq_mask;
> +
> +       handler->enable_save[group] =3D value;
> +       writel(value, base + group);
>  }
>
>  static void plic_toggle(struct plic_handler *handler, int hwirq, int ena=
ble)
> @@ -110,7 +117,7 @@ static void plic_toggle(struct plic_handler *handler,=
 int hwirq, int enable)
>         unsigned long flags;
>
>         raw_spin_lock_irqsave(&handler->enable_lock, flags);
> -       __plic_toggle(handler->enable_base, hwirq, enable);
> +       __plic_toggle(handler, hwirq, enable);
>         raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
>  }
>
> @@ -252,33 +259,16 @@ static int plic_irq_set_type(struct irq_data *d, un=
signed int type)
>
>  static int plic_irq_suspend(void *data)
>  {
> -       unsigned int i, cpu;
> -       unsigned long flags;
> -       u32 __iomem *reg;
>         struct plic_priv *priv;
>
>         priv =3D per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
>
>         /* irq ID 0 is reserved */
> -       for (i =3D 1; i < priv->nr_irqs; i++) {
> +       for (unsigned int i =3D 1; i < priv->nr_irqs; i++) {
>                 __assign_bit(i, priv->prio_save,
>                              readl(priv->regs + PRIORITY_BASE + i * PRIOR=
ITY_PER_ID));
>         }
>
> -       for_each_present_cpu(cpu) {
> -               struct plic_handler *handler =3D per_cpu_ptr(&plic_handle=
rs, cpu);
> -
> -               if (!handler->present)
> -                       continue;
> -
> -               raw_spin_lock_irqsave(&handler->enable_lock, flags);
> -               for (i =3D 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
> -                       reg =3D handler->enable_base + i * sizeof(u32);
> -                       handler->enable_save[i] =3D readl(reg);
> -               }
> -               raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
> -       }
> -
>         return 0;
>  }
>
>

Best=E2=80=94Charlie

