Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794936787;
	b=eIFRKZs+gsQAMqPGpLugX3MEjU64i1xIOUszqSh2oKb85xTwS9GRloCngMvwt4kQGVfN
	 PB0t+chERIOVP0vjNXlnIRPw6B/tBFZL7G2zBkH6fL6Y4iKqHyrC+R5rr2ZoJasUKJuUg
	 NRDoV4dw/obEzaEt8MnA/jz7deEVFzMkKtMZN7XOvtIZVbpduq8qyzK3dFuHvmRfeWV4d
	 KYV03LHpjRTZN1vyEDd8KaDWOjMvHRuYx2o3CG66mkGDJnG5Q66xvO7rWQJgCZE0cHOEE
	 +uRVwj+5pckOHlf7BLtSHPddkYsLjfv9l4sUSlRYTjXc9Xdh7OFWMBiHKwGJSs0/64Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936787;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=a82dlEFENLIW4sgoVBtYD60lkUHWQf9Lza6blcAb4ZU=;
	b=BFDRe7wODVG+gQS8hcnWNT3dTbCYexlojM2UdMjQUsF6bUPgcx1YdDyRUPG/RCV8r8Dr
	 TuO39tmjhY4L/9lhoYUhdaVs/sV9roAYQVBj7gsduaU/bD0DBbPAVjZnncWDKqPyxrjA5
	 xH9KBFx3l6k4GCWMI4eFkdfVye8ERpvNBJ9uCgue7Xj0zXNEgkmbw1dgZZAxhgj43jGAL
	 kZ+X3DXHHffjI5skfl99vusUO/A6FkJl8dxPZqV9EZG3IBR9Szz05ZsiKqcjLIY1pGbcp
	 NKQFiieBKp8tfcet/guEwuMC6NtgRnx8PDvnWFSlCzqZ5gBlOWDoNALQOyediBcieCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XUNOpCAc;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NtPJplwP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE309606A32A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE309606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XUNOpCAc;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NtPJplwP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794936784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a82dlEFENLIW4sgoVBtYD60lkUHWQf9Lza6blcAb4ZU=;
	b=XUNOpCAc+l6ScA4c6d68P/A2kIkYHn7Dc9Wzbv/1QfiVu8oIBETeDOW/vLgsDk2pWTTo8Z
	TenvgY9MGe9D6JKSsoOyy6k/CBD5ejvtimXZRhB6ViWtTW+ssvPDRv1X9V8BunwPLtJNTF
	eQSzwwKCJkD3n5VdzsUwRH6KOgbsbew=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-LR-cG8vkNQqK7QXkh2TmIQ-1; Tue, 17 Nov 2026 12:33:03 -0500
X-MC-Unique: LR-cG8vkNQqK7QXkh2TmIQ-1
X-Mimecast-MFC-AGG-ID: LR-cG8vkNQqK7QXkh2TmIQ_1794936783
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7d64f59c80aso847069137.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:33:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794936783; cv=none;
        d=google.com; s=arc-20260327;
        b=owsVOoR2T4QIQYZf6lEdaNW0a69eDLe2g0bagWtRQ8IA3qKjybWpxpcKYUWTwQiPAf
         uWgfqUOATdLwhXzs4so+GU8j6KE54AK/luT1iE8Y5nsVnGPbWRPv6i3ugVdk+MYL0mJQ
         HyninNrmMp4cWDZ6dsQO876GFbqRv2ypnSZhsJ6oOriHUD1w7oOSaGtbfwSGlWEEzM0Y
         rq8ttNtvhMVX7IDuQWPGCKabXixXaAEH/zr+xySNdbi469C16lnEbWWmdhCrJrRjZnmI
         amOXEbXSnui4RQqVZwKFdOq1DWFKwyoSPuJla7Qyug4ZQMdZkjKMzosYj5b0JqoG4kvw
         EXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a82dlEFENLIW4sgoVBtYD60lkUHWQf9Lza6blcAb4ZU=;
        fh=YLq+DSaV8z3/rwClu3BhYsdSUPBAWhsRkfyDnodBM5s=;
        b=B6ytEmBLgOVji4b0eMNInfJNpZfRKTGjiu0Q+NMj0getgLRbejLuTfAFspM9KbWRcG
         8QfIobGcA04U1owEEIBx4xci6atXQMCOfURXMYr9tVAdUZGJHQD2CrmiQsH9VcWDNzuG
         3fRqKBYDr0p1Vux/b9jWYju7XK6YnIGuJcUHurucCCeIUrm07cT8FcMG7Eu7hKE+bkAp
         r6hay4oDSJhwLfSuI3bOy1laFMeKOTJweW4Pb8ZINZ07C332wegBCS1bLwmEzxwLMq7H
         BcYZUoan3Y6gHplI8/NreD9FzbpbfrKnPGEHZ1IV2PyuZjjctp/oAUjyDmKUb0FByJsk
         VwZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794936783; x=1795541583; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a82dlEFENLIW4sgoVBtYD60lkUHWQf9Lza6blcAb4ZU=;
        b=NtPJplwPQZ4W6lKofSmxFRiTWuEnftiTGr8tNd1ejlNXJ6q8twRZCpgNEiucEOLMVE
         R5zdEbhQe+TxAxZTlJEPWxkdVL+Dd6Nq6wJXOwAuv4xiWaDSnL/aGTGXxuNowibhtiHD
         NOVIrCLWSmWqj4k/BCbE38UG1+JnYelIcvric03UCzFwreqt6G1H5pp5izNbv41KBDyc
         npdVzL4KjQnveZ0KBR9z7P6hyThG9ifut1qFpGngh4kK8DzrH82cWpROSx6BQUWQxa57
         CIJSmMsTwzDKu3sfHvuiZgnbVAlA4joirXfoHMyj4yw1UMOLP5TibKI5r4LpP2F5s50T
         p7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936783; x=1795541583;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a82dlEFENLIW4sgoVBtYD60lkUHWQf9Lza6blcAb4ZU=;
        b=XoYNyRIUDiU2lrlExXIoFsgmBtXcFgpO9CbOLpe0OcfNOY0fAYiuT7h7/3XREs5u6l
         zg7j9ByCnXbxlU0LKmCCdn6y+sJeXmarqgUMJ+myGvvH8ARMEXFClPAXOwAGQ2G1r87A
         lKEsRSonsZyc7azkldyWvf7wQmjhY/5hje32NKi+jlNEdPJqaHi+k8GKgqntuUPabrVM
         25ytYVv4YiCp2atieQjSptsEDQ5c8GR7tf/8w9FLvvoh83/I94ON09XYXgiOpOROmsJO
         oVSjOrT1rR1mbeS9F6JpO/6BVB3jCYxSoh0n1x7yz/CdefzB8YZl1j8O84W7Uo7projS
         pRIg==
X-Gm-Message-State: APuU4Z+Q1FCLv1j5w8eFUUWif9RVKCEYnFcmHRzXXxMKxmBuE7y0MWCq
	Au45EhmIxMSw2j7AoCmibMWARx8/GmwIjDUMO2LwfgsKlczJJ8udn8Hhr1jXpBoRjjN3o6XDXcr
	lkZioMkckGhpeOb/70oQm3OWaJLLoIs81aShLarVoOgEse+RhjLk1x8VwXCHcu/Jo4mnenwLCh6
	8FEfSw5km42iwY2bK+X+OZU/x+V5rO5q9cDSNxJI5iQrY=
X-Gm-Gg: AYBFou2bBDT7TiDdYH304xTBu1Xz6l5A4L+cFgYOn5mMjWSMbab4bz0Reppct42oQ18
	79TFjblNT0N6p6qPoxnuY+ZWK5Va6ULShUa3ZYAgq93J/H4yGRqO+7FEfilN8v+eeE6Mk5dqBAY
	zChfuG96WkPOyj5gzTyvIl0e2yrC6iDEX4rise4y066ieLSnNQMaMboNrwVCkzvzasr2kodSfFK
	pa+RIa93ZOChoY0jjSv0qem6qiK2WWzkeVHM8gqDPtp
X-Received: by 2002:a05:6102:d8e:b0:7cb:91a5:7cb1 with SMTP id ada2fe7eead31-7d69f8700cdmr1152615137.39.1794936782781;
        Tue, 17 Nov 2026 09:33:02 -0800 (PST)
X-Received: by 2002:a05:6102:d8e:b0:7cb:91a5:7cb1 with SMTP id
 ada2fe7eead31-7d69f8700cdmr1152606137.39.1794936782281; Tue, 17 Nov 2026
 09:33:02 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117172636.2142261-1-sashal@kernel.org>
In-Reply-To: <20261117172636.2142261-1-sashal@kernel.org>
From: Charles Mirabile <cmirabil@redhat.com>
Date: Tue, 17 Nov 2026 12:32:51 -0500
X-Gm-Features: AclHuK_ybCjuryCHfxfRYMob6J2idAlIf0-rGM_aBnOtmSqebtyX73TvIBCQ3-U
Message-ID: <CABe3_aG74Df8S+c9Mis4-dvd5LJzyJL9KQkHhV61yBFAPfi5Vg@mail.gmail.com>
Subject: Re: Patch "irqchip/sifive-plic: Cache the interrupt enable state" has
 been added to the 6.12-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>, 
	Radu Rendec <radu@rendec.net>, Paul Walmsley <pjw@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All=E2=80=94

On Tue, Nov 17, 2026 at 12:26=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> This is a note to let you know that I've just added the patch titled
>
>     irqchip/sifive-plic: Cache the interrupt enable state
>
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      irqchip-sifive-plic-cache-the-interrupt-enable-state.patch
> and it can be found in the queue-6.12 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Same concern as 6.18 stable=E2=80=94this patch makes quite substantial chan=
ges
to the driver. I don't think it makes sense for stable.

>
>
>
> commit 93c071c13839d60f69c7dbd6b1857d3b8d13c433
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

Consider this altnernative version of 0f214e5bbee5
("irqchip/sifive-plic: Avoid signed shift in interrupt enable mask")
which applies on v6.12.118

diff --git a/drivers/irqchip/irq-sifive-plic.c
b/drivers/irqchip/irq-sifive-plic.c
index d57e9b25d0b4d..b061062f47c58 100644
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

Again, forgive me that it is not a proper patch for git am, it is a
one line diff.

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

