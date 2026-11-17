Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794940339;
	b=mGFeyMA4SYzU6DoG7Uj8e7QumtI8jmamwQKYRpyHQb8qsVM50ExBUj0S6pfVWM+FWWsi
	 YC5oUcuiQW7fb0wJhJvPyLAGA4wvf4M2FqqscU3Katw7lZg5iDajEPkpCAO6s3HkzoIGG
	 TBNtzI782ffdXNAT71X72IVdln7psUib1Je2WREJxaU8ZMLmu8uZe+U9cC2vIexezeMD5
	 FsGDqiETlA1ekM67GjRIzu5os5sKM/PqmyXIy0oio6xBKwMjw2BzFn8aLhxYbuhqtli6A
	 ViLRtejkXBDmp+fSEdq/GD4VOmxZhRZLkBW6YZDJHfwWgsJ+lxtJdaXyon7P+jj/l8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940339;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=uTh7X6FSU3b6y5XIhDDbQ0ywYHbKHfhmsXY4WOeAGRU=;
	b=5Y/nJ4bg75O8C4xFuK/aQuoITUuRWMm+wsHOdW1h8Mv2fjl23NpTtBMoESjQ/VdrSt1s
	 pQEP/09+M0/rnHKE5sNodmtwRL6pDUTkY8AalCMHexb0oPnrWhN6j6BwGf00ExDGALpf4
	 Ulc2QzE7zJyRCSNss6dbjgKgSKJNFxjcoGwWd9Xhn0WcwJwlaRkGv4QCFhL0RPPVo4ij2
	 WtoFh21w0rzbCZ5irggGLJiXXj492HgENJY7DPuu6wxiAUed2A9TWs3MLAE0eIlsQWd7l
	 ZPPQ0T1LmoKTKlPpkg0qvioAddsLSs/yo6hx5jEZqglbnVh2SQLXggCXkhkpmcjIqIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MPIax1Hu;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pLtAwHF8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9F3606AECC
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 18:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C9F3606AECC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MPIax1Hu;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pLtAwHF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794940338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTh7X6FSU3b6y5XIhDDbQ0ywYHbKHfhmsXY4WOeAGRU=;
	b=MPIax1HuJ52SNhU50yL1G/52K39yxpWDgm8+0v9PGu60MdQt//3V9JJK2MUOvxOlwSfzXJ
	2bh/nl6Pd9fvmmepVfNsWFOmy5cc3QIvzJF0C7hSZX5rhPhb1wRGO3erqVuJS2rTNdvIow
	AlkM6btYD2ZGzC9xmS1ksiN/5B2t4uo=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-avNQCxKbPcmLIJpWbUiNoA-1; Tue, 17 Nov 2026 13:32:16 -0500
X-MC-Unique: avNQCxKbPcmLIJpWbUiNoA-1
X-Mimecast-MFC-AGG-ID: avNQCxKbPcmLIJpWbUiNoA_1794940335
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5ee30bf935eso31005e0c.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 10:32:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794940335; cv=none;
        d=google.com; s=arc-20260327;
        b=FNd5lbh+OKgGvzhWHJE4xuuzeXDnryM7GTWl1CCSaecqsphW2rS4oKop/jtMBaMafF
         iAkuOfOA5quVF6v31P1RajBT8MQV4NShT2CCj6i5ya3VTCPAbPJohDIBNnsBGOGgV8h0
         GKHjvRF4BHjG8RtENvyZGZMJvecPGjMGMCjxB3ZaNQBViEDlWJefiy8yOlTNiwpcPz1H
         5lw5bXlGNe60fCuFZbiGirFOQm5eEJ8hTidXRhV6qgkEaTuPDxgcRpOT14vKm7lR2kB7
         iT1t7CTeWr8v7TcNchAQA5/VRldUXD+8GGBAFCriu0UnBZ3pcrkOup7RYrDqxmywijKq
         WNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uTh7X6FSU3b6y5XIhDDbQ0ywYHbKHfhmsXY4WOeAGRU=;
        fh=YLq+DSaV8z3/rwClu3BhYsdSUPBAWhsRkfyDnodBM5s=;
        b=RlCZkDNMOfSoER5dhsZJEine3wlURe/kl3Hg2pNyhTtwl1Af84v7wxYTGhCBm1khXU
         KiiOqmHj901t0iRmrMWOgANSaYakgbgaqwv8dAMthwsnt+S1GVue4IDiHnzQs6FjypB4
         ZvvnuiPlSPNqS6dj7lF6MDbK7k7re0fVfs7q8uREG37zWjqDRBK8kIV0cNhB4uCIXNNI
         7bPKWFlK5405DuaUm0N5f+0DZGIF2cnqSLnzFZSaOg4bZZPIcmyFpNhQZPVq6Y9fvzjv
         P85Q3H8yzMsKSi/RyjqwdB4fzqHUs43a6TJjK2sTqm3D85UHwZW0eFfr0Rv90LODOFwH
         MYGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794940335; x=1795545135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uTh7X6FSU3b6y5XIhDDbQ0ywYHbKHfhmsXY4WOeAGRU=;
        b=pLtAwHF8c6Hjr40MYJh6mw73qohKCUqsGkUtlOf4qWEyyWtGdc43xunCafxLar3CNe
         cXFNAa4Gp7BE75nQl6Ishpwm9E6ANJJczoTdFShTFBGaNemR4KMMCgm8voQAuI0Xp7V0
         FSXoEqTuZtMKbnaJPVlvk1/oTlIyb7Jj4+RNuCXL/BZrOQv8XroQK+7n70J4Ro171qhT
         KL+lBzhQQyxv5MqHZkngY6IqEfnIG4weLJESLTeXvEvQDxAJcw13vGPzEmJBiBMXqDXu
         HTKZsEQ2mJNrr4X9zx0r46kQAipSYVp+YpZqTp0t/5d+sewqWx4wd6VYUhyv/Z/9GYPz
         Cxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794940335; x=1795545135;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uTh7X6FSU3b6y5XIhDDbQ0ywYHbKHfhmsXY4WOeAGRU=;
        b=v2G3mKW3pAjkpRUukWJ2i9NZChLju+ZkOddUXwUZdzIE5vjT3pQc0bDDYMBO+ueI1X
         NRWZ8a0riIIXo2RO1MqewZGBzbFRaUn+GUUMwf3N0b7TxNfDT+1IIahehmU6bl2oOy4V
         HbIWHn6RwQ0vrpbHSKWa0ReJ9CbvDzF/BH1qXpz7eUwRLss+tHwe8hImXzhVrHPbMg9u
         A0V5QFeUW2GAF1Bg+2FrSlI1o3Hxbmyo0cluhlRHkKTw8+O9Za5WN1/WgqhuQN5SZH4p
         gPzK3RDJ5EIqgXJtxpxDIhCO8aDh9oX0hUY8lemvtfGkxlpXF2qiI/blKqx4+7zLQJ4z
         X6wg==
X-Gm-Message-State: APuU4Z9glUWAx5NyNUnVlfQ+m9KeHZyf8dneniWKZJAy6yZke5NDvAhi
	cyLXRp/S6lJzb1zATzLwsfbHLUGJ+zMbLLk4Hvw+LIv3afwAQ+57adesBaGQvypoBJzDn8LKwbM
	T7KmjWUxXqUJZ3a+tRrJMmn4e/rjrHl7dTK1jt7MIOREH30MeIKqzw6pfB7yXFcZxtQp5w9+Hv/
	iil+9HjoB2kSr4DVfMHcUNcPBAtH/O9sJmGFjE7yLXLks=
X-Gm-Gg: AZFdTZfUwfeHBAwuZ/pPBH+Sy3dzwctXWdHm9ZxHijhJz9MZHs9QoNeZ73J0LOqAKyi
	yRwgr3h12W+fmIZjuOyUolssrsDuXRXrdxV4Ilz6sSjFdxMHDogDe8pZPg0y2+cANYrEWnXLyH0
	nC5yZ+zOzn32Z7vQGq+vAv9q6tRUsZQXGAM3w8pVSO/VYaoOXBJrnYzmzbIVoUqbaybIOnNvfvQ
	kz6odGfvCMOui+nG7Qye7U7OYviBs+7EwGTN6Ew6wUm
X-Received: by 2002:a05:6122:4d05:b0:5dd:bc1:93da with SMTP id 71dfb90a1353d-5ee64708033mr273881e0c.17.1794940335464;
        Tue, 17 Nov 2026 10:32:15 -0800 (PST)
X-Received: by 2002:a05:6122:4d05:b0:5dd:bc1:93da with SMTP id
 71dfb90a1353d-5ee64708033mr273802e0c.17.1794940334919; Tue, 17 Nov 2026
 10:32:14 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117182018.2243569-1-sashal@kernel.org>
In-Reply-To: <20261117182018.2243569-1-sashal@kernel.org>
From: Charles Mirabile <cmirabil@redhat.com>
Date: Tue, 17 Nov 2026 13:32:03 -0500
X-Gm-Features: AclHuK-fdCuk5-leGvDjtKf3Z2Fpctdx1uFh37-8jLExShjpJFKFZQSXpTzNMOY
Message-ID: <CABe3_aG244c_SSt0LBHaCznN9SqsNCb=qAqQYezouHHpvo7h3Q@mail.gmail.com>
Subject: Re: Patch "irqchip/sifive-plic: Cache the interrupt enable state" has
 been added to the 6.6-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>, 
	Radu Rendec <radu@rendec.net>, Paul Walmsley <pjw@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All=E2=80=94

On Tue, Nov 17, 2026 at 1:28=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a note to let you know that I've just added the patch titled
>
>     irqchip/sifive-plic: Cache the interrupt enable state
>
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      irqchip-sifive-plic-cache-the-interrupt-enable-state.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>

Yes, as with 6.12 and 6.18, I do not think that this makes sense for
stable because it is a substantial refactor.

>
>
> commit 4de7d81db4c2e56ddbad8b8c4ed6929f37605e2f
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

Instead of dragging in this commit to apply 0f214e5bbee5
("irqchip/sifive-plic: Avoid signed shift in interrupt enable mask"),
consider the following which applies on v6.6.162

diff --git a/drivers/irqchip/irq-sifive-plic.c
b/drivers/irqchip/irq-sifive-plic.c
index 794bdb6d4d1e3..a9f1e87fec166 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -93,7 +93,7 @@ static int plic_irq_set_type(struct irq_data *d,
unsigned int type);
 static void __plic_toggle(void __iomem *enable_base, int hwirq, int enable=
)
 {
  u32 __iomem *reg =3D enable_base + (hwirq / 32) * sizeof(u32);
- u32 hwirq_mask =3D 1 << (hwirq % 32);
+ u32 hwirq_mask =3D BIT(hwirq % 32);

  if (enable)
  writel(readl(reg) | hwirq_mask, reg);


>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifi=
ve-plic.c
> index 9018fb2c73d1f..1f2db377bacd3 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -90,15 +90,22 @@ static DEFINE_PER_CPU(struct plic_handler, plic_handl=
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
> @@ -106,7 +113,7 @@ static void plic_toggle(struct plic_handler *handler,=
 int hwirq, int enable)
>         unsigned long flags;
>
>         raw_spin_lock_irqsave(&handler->enable_lock, flags);
> -       __plic_toggle(handler->enable_base, hwirq, enable);
> +       __plic_toggle(handler, hwirq, enable);
>         raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
>  }
>
> @@ -251,33 +258,16 @@ static int plic_irq_set_type(struct irq_data *d, un=
signed int type)
>
>  static int plic_irq_suspend(void)
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

