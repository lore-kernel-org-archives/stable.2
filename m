Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794943333;
	b=iILZPUE7nYbzCiUJq6DmAJBlp6MgJkOpYBuibym36bA6yh+OHqRp7j2w1+4YUvzvjdFC
	 FqJoq7ROehiKmnaLmZkPGIo8qwPKQwINye318508V3AHvMAhKhOhlNCXny0sgEjwdQAgq
	 a9ev12tx9R13Kk1aKHDI1hNYsY6wAEa15FBXXunfIZyNnMlangNjFOKkIVPNKzjcCGxyw
	 IsxW+eW0/cLmBW/98fbTI4NB0LYMYSnpXVMgmmcsN0YrX4D5LB19EXVTMruPFsu+omrlk
	 QqN0yY5hTSAr9MlPJK/V/A5/KjxDViiFUSrGZZSAIndsxL3XwP1w3C9fn7DNJpu2dRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943333;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=c9u4TJgEI+jc2jYFOVzcuBfnMeDekfshseAkpl+s6Eo=;
	b=Rx3+wsjZILYAOplEMbbvRkkmrNMfW2gPz4EQPqzpY+Vb4ywmHuQIiaL8HuzOP3zYIa5T
	 ateY1roEYBZzcXIMCsRCeU4ve4lPywpGWMHAuDEaO5nWyE6h2niM3LRFxgM5x86xh5P6p
	 HLNtfbdUnJNQpsljGYipxo1kP0JuKPnPXssroq2umz7tHY/PS6Octnwkq9v1XamdKbEf8
	 rRF0p7FrEl5hQPagfsHO+iXfLR6yyYOHUaNOKQnZHh4oRzF1DscFMaVRUbXq0obxc5Yuz
	 paJfdoRDXbeF0Mgsx5DKGymrCIhbKo3zU+B6vIR6V9RDZnA5D9fi5S+gMhfH/7VKenQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YEFufg5V;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hC6MtADM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A22606A334
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 19:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23A22606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YEFufg5V;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hC6MtADM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794943332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9u4TJgEI+jc2jYFOVzcuBfnMeDekfshseAkpl+s6Eo=;
	b=YEFufg5V3HyjvgY9OSTxS5VryEyXLhL87lfT3Bp2ILZDtRb+gZPuw5IalSsKYEYOhlDyC4
	pSdQDYznkSp2NKBpNNtxEmlFn7wBncf5YGnPUdaTlZtvW1mFMBRH/bGwnz5o+DcxDYsUD4
	PNDMsdKqeyClh1PgugfqjOkKxEhwe8w=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-EczEJ78fN3q1SQcSeCFhDA-1; Tue, 17 Nov 2026 14:22:10 -0500
X-MC-Unique: EczEJ78fN3q1SQcSeCFhDA-1
X-Mimecast-MFC-AGG-ID: EczEJ78fN3q1SQcSeCFhDA_1794943330
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5ecd7e10ca7so36803e0c.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 11:22:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794943330; cv=none;
        d=google.com; s=arc-20260327;
        b=gFn0H3AB257AOP36dbIYtRzetur+RRpVAriSQ3mKrpc5UWd3XWIXboSRfoLnAVT3e5
         c27mOjBORa440AQ3wyTp70wCT/Jw4IAUk8AsRe66fbnx5owDZ6IyLA8I0Kbw/g6DGN3T
         7Jkd5hrYg37DaOw/wpFFe/p8BOVZrFIjPcuBnAWF6IgXYjwpBEuZQwvVZws5e4fq0qa+
         +4sz7+DcVK8ZtrJR5B4a76ZbviCRdVyurVwG34R2nyxW3g+fi2kSKrtGtW21SscHLzDz
         31gWfXZZaSojX6eKFEqdHxjoZr+Pksk36ZoaY20Ko0NW6tvP7FszrOM11VRLKgb3aexF
         5EKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c9u4TJgEI+jc2jYFOVzcuBfnMeDekfshseAkpl+s6Eo=;
        fh=YLq+DSaV8z3/rwClu3BhYsdSUPBAWhsRkfyDnodBM5s=;
        b=sAQnn+nps+fh5V3FVO1epmyw7UsPW8nhc0HoPkoozE5ZSyGr2VO7cryTawPH7xwg+c
         gOXAaMXMZK/wDdw1LjJB4dLoaJLWRvSBXSk86JvyFiO2MmwgKXqeTmX4jZHWZlJh7k/u
         l5qDnxv0zGM0r8ap6EVIB4X4qSUXlsyZxZWRGB2SM1IJfY1Y9fwLUK2Sk5LS26fYRIr5
         lUt8N8JlInnhC7ubdDz7HG21/9qIRLWonOuCM4VV7myJmqVp1daT457HtM7Uas1YKqVr
         R4KcH5GJeBemJnbeQVyyc7Qmdr4u5s+M+v3XJpHvlKbGms7iRHBLbBhiAZqlqbKFf902
         lQDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794943330; x=1795548130; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c9u4TJgEI+jc2jYFOVzcuBfnMeDekfshseAkpl+s6Eo=;
        b=hC6MtADMRcqmNsaDh5aOtDh46eT9NyDx/brwP86DPqC3My7RJi+FnnOzr0xJJOesv4
         3itdRDiof4T2weEYaKsYMRYTKAVFEFWZ8CiA3A0po0LN+1KC/SETdHuFYMgquzPVabIc
         neceTgqC2dy8yoe0DWyDnYcxLXMAuLegPiXXPnR7B+o5HpDEBxOlSxlCyQWdpHlKXuVr
         jGAZr+mXHgydl53wCDsSra3/LhHEPDQ+X7JCoXnt58yIeCs38W0RQrKnOsw73B3UIjAS
         MjKMbEbssODOr1Bsi/+X7C8twb68ShFovvE637/ksS7XZw6BzviZyBr0LG25Iiukeoy/
         Ga2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794943330; x=1795548130;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c9u4TJgEI+jc2jYFOVzcuBfnMeDekfshseAkpl+s6Eo=;
        b=ZiTbQZ+g89Jpjk69lHzPexJVn7G5CG+Xi72tWO7p97t4Hny5VEMb2QhgEfc/m60i0p
         afbQewlxYDtI4EkFr+mfw365YnThBf4x6VZUReVOJmSSvo3VKVKtjrgbGXBqKVFOVntY
         kdL5jFwsrwcAU66f1QnndGxO6hW+Fg9mXkgFiuRyFiTMX7oHS0rZp1jemiAMiqY9+3Uu
         laNby/6tTnLH6BDpp/eXqNrKQTIAgH8CE7IUyUkWjXjaMjoXNP50aD/l+5taNRZJ4m2X
         t+SyW7thqDRc2gMi46rVY/s2RTFF4c4YtoMOvVWug95O4fQ9tYsQCRonCft0rC8EY11L
         U6Sw==
X-Gm-Message-State: APuU4Z88eSG7kp5pVUFwVpS+aG61XOSgxnwa7bJobd1WJVoYZnhKHn7h
	1I6LQoMhBDT7tc1Ry15IozAYVPZwxZEOvejLQRMQPsZ/PGwFR78BIAHBghlOHUfAcXFrKqsFd63
	spiOtMWqJWxWtcUkuKbdJfLA5DoY/75MGkoBbejDhd2PxKlciuMzdSgldGZttROB5Fl1c2OZJbu
	ZABw/u/VldE/2H8fWx9Py3dK1jeR3WJyZNBptryd9yYkM=
X-Gm-Gg: AYBFou3H37+Ua4fKYkQCICsShlrxku1wwX0im3fux7DPEVEzpJfY5hGS437SP5jVU7A
	CQd1Ulu04Hz+EAmsxoU3mUQ1MDzxJE4C7uHd2PFnUqJnXwi9X44MTHvFaFzTMIbGq/hrUUQ6EmC
	oKkFmvhS6V1yMY/6XWfjqq9qWJ8pUXaQOCsaqnXANM/i6w06srqBf6qwZF4Ntr4fq60cepk5EAb
	qtF6RiIsWxf33xPtcB3QD+2sUabAXUayrzCXkGFA9fr
X-Received: by 2002:a05:6122:6e01:b0:5ee:28b4:915 with SMTP id 71dfb90a1353d-5ee64761144mr326163e0c.19.1794943330048;
        Tue, 17 Nov 2026 11:22:10 -0800 (PST)
X-Received: by 2002:a05:6122:6e01:b0:5ee:28b4:915 with SMTP id
 71dfb90a1353d-5ee64761144mr326155e0c.19.1794943329555; Tue, 17 Nov 2026
 11:22:09 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117190542.2302722-1-sashal@kernel.org>
In-Reply-To: <20261117190542.2302722-1-sashal@kernel.org>
From: Charles Mirabile <cmirabil@redhat.com>
Date: Tue, 17 Nov 2026 14:21:58 -0500
X-Gm-Features: AclHuK8nJW8SwUP-2Pvl_9nSlOLeenXsBfNLgDneF1K0Fmqo_jclsMOQZaQB8sM
Message-ID: <CABe3_aGdrHqO-JjbyLmXF3u0S6ujxnSOH2kASuVS46WJxUW7mw@mail.gmail.com>
Subject: Re: Patch "irqchip/sifive-plic: Cache the interrupt enable state" has
 been added to the 6.1-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>, 
	Radu Rendec <radu@rendec.net>, Paul Walmsley <pjw@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all, me again=E2=80=94

On Tue, Nov 17, 2026 at 2:05=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a note to let you know that I've just added the patch titled
>
>     irqchip/sifive-plic: Cache the interrupt enable state
>
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      irqchip-sifive-plic-cache-the-interrupt-enable-state.patch
> and it can be found in the queue-6.1 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>

Yes, I think we should not backport this and instead accept a slight
context difference in 0f214e5bbee5 ("irqchip/sifive-plic: Avoid signed
shift in interrupt enable mask")

The following diff applies on v6.1.192

diff --git a/drivers/irqchip/irq-sifive-plic.c
b/drivers/irqchip/irq-sifive-plic.c
index fb1dae22ab17f..396fb37abf611 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -89,7 +89,7 @@ static int plic_irq_set_type(struct irq_data *d,
unsigned int type);
 static void __plic_toggle(void __iomem *enable_base, int hwirq, int enable=
)
 {
  u32 __iomem *reg =3D enable_base + (hwirq / 32) * sizeof(u32);
- u32 hwirq_mask =3D 1 << (hwirq % 32);
+ u32 hwirq_mask =3D BIT(hwirq % 32);

  if (enable)
  writel(readl(reg) | hwirq_mask, reg);

Best=E2=80=94Charliediff --git a/drivers/irqchip/irq-sifive-plic.c
b/drivers/irqchip/irq-sifive-plic.c
index fb1dae22ab17f..396fb37abf611 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -89,7 +89,7 @@ static int plic_irq_set_type(struct irq_data *d,
unsigned int type);
 static void __plic_toggle(void __iomem *enable_base, int hwirq, int enable=
)
 {
  u32 __iomem *reg =3D enable_base + (hwirq / 32) * sizeof(u32);
- u32 hwirq_mask =3D 1 << (hwirq % 32);
+ u32 hwirq_mask =3D BIT(hwirq % 32);

  if (enable)
  writel(readl(reg) | hwirq_mask, reg);

>
>
> commit 0281eadd39536ef2d99dd6ce5bbedfaac4db9ca9
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
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifi=
ve-plic.c
> index 1986d4a49e671..cd537d8714721 100644
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
> @@ -249,33 +256,16 @@ static int plic_irq_set_type(struct irq_data *d, un=
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

