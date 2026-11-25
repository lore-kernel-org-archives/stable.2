Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795640510;
	b=AAHF9QIofBr/06QhVRuaNXbtDKYDV4WlOdkefhWXw0DooYpS5+ly7yV9wZS2GKg1RyxX
	 SSQVislLKByvUAPvFffxSoKRy0NiSItBNjtA88yRN3FveXBX19A/rLex2qGRT14o7dG8D
	 CgjnHIK/iGPRLq7/2jFfuSp3EEOBTYmBJ1q8Bl8lc7pstjcz1ptuJisnIU0DeIYGuJIiZ
	 Nt+d8fk8LjGVi9KEfDqWGlFKQ/Ffwfs+sE09h8xzbg7CI+a5SgexfabhHffPVtHMWtRNQ
	 yqBZC9pXRaadzvpUczAyMghIZ6nfYWRnnxOt/Yde8rXrC5t/tyjGk86OJ/WaQaduJcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/xql7PxzylbnNqUypNzqY66e+XcyUxvn+W/FfLvEXM8=;
	b=dZXTK7q6mOQBhz4vo9HeOi4Awjxv+9Jmtra7t+CI8+nbyCsltdhuTsLQ2HDmPxpSc5eu
	 5Es6sHCZ/3rL5M12d3T2A+hIZbeqHIEAssvsycZgEOmeAu//D/kIZkITFq0oGhje/h9NG
	 oMMoLa+DJERModehhClz3RGCxBp5VCV+cMcnFG09R1M8uxkZYx69LCOYd0bcLkhvmEwTB
	 2/akMGHAzSqjlhzeca16/bZJZn0e09XRXMFKYWE9Qt5KAw8qq4R/k2hc4+/fh7LQahe+K
	 l14nvUO1gcr4jeR3WRNqgKkpd9Hfy2zDmga2IEn6TxxSkdl7cO0S2JMrz3u5BIf+lJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Rh656DFr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBE5606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FBE5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Rh656DFr
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6bab377105dso4917344a12.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:01:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795640508; cv=none;
        d=google.com; s=arc-20260327;
        b=rmF5u1ss8ucKM/PZUEw0kf6yiq2BYplZOTDnngq9Oebb1tQrlH/Xh0Xq+T6FKuh0kV
         eyD8Yx/GlIm75PcPJGaRAIJ/b7tBBuas+QM8DU9nDuOlwuhOHgVEvOFJZ/lw0zIcMw1O
         Ssd7G9L1gaAZ+aSG3oKczb3vcg97s8yFtXoIVMfAXO9+5drVwfPQPEhiMGCXW96fLiVk
         3cnb/EKA6t4s4u+Ex5eZ0jbWcECHtzb0fLV29aRUyZDIdSbOWhsVzO66HOJjDqoRnN3v
         NzZaJ80YjfyUWaNSph/9NLuGLR/Fz+j6DoB1KJNCsJmiZYuqMYOsfhhJWHzRIc84R0e1
         T2+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/xql7PxzylbnNqUypNzqY66e+XcyUxvn+W/FfLvEXM8=;
        fh=19uQl27XRk7c/cSLcUA2BvXL9duWnb53G27t1mxpZic=;
        b=JeRuSWziw8c2YUZbaq2VSN+odeKsx7bSPddmFcmNtqgT14sqhc/STRYqUbak+mVKCz
         ehMSzmX8NpgnS3UDbPU5Rhgyy/feDlkc7bh5WAdXUGpTe/+n64vMCcz0epco5DqWp/o7
         cAll5FvTI69LfT2rb2Ci/QdvWWdx0oLZAicTHiqDtm/2mBy52gvMJe1Rrx5zSS/b/77c
         JG7maSyZT3CgpWK2tYterpzX2KIGsWLr91dCDxfJiIXCasr7QcTkwJC1RsjLBJVIVq/o
         y4oOVZHDk6HgtzKU299CzM/x8YZF5WbKVf65b2XjckQ3JZ2DvXgfv7S9JtbsWqyezbzW
         xK7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795640508; x=1796245308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/xql7PxzylbnNqUypNzqY66e+XcyUxvn+W/FfLvEXM8=;
        b=Rh656DFrOJ38tdIvMqsn4aj9AH9Xbgikv38mEHthnHH+r1g04KWtfbAR0zMm6kA/BE
         lXT+1MAftWmHDaTShS3OvlcMTJ7addo56b1XybMjaDn7z+J5/N/V/UV0vR2fhZUlExrX
         famy6j5mA+2gQeJYlYsJ3YVDcnj8TYRWr9tARpMcbIpqLUKQRx8lm3ls5HsZYrT3kEJR
         1ljJKYmiD1fsVJromPArbSc93rIhKFf9jdgnWbf0gG+4Yu+lrQ7cTdt4I4jMTOD+hF7j
         0t+6S9HnL58sjenkJcnbABRt6sGLHE+87Wa0MFTjGfBiuGdx5hBvc14esLYtqQacXbR4
         AeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795640508; x=1796245308;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/xql7PxzylbnNqUypNzqY66e+XcyUxvn+W/FfLvEXM8=;
        b=gfvk5acoHY5DUAdCCyfntnklJlQORqcvDvSW0l0SmIBkpCZ2znTAfI2FtZwK1UupUk
         T0dOKJ5Bgpie4VzlyLbItoJpltNlQFWy+HKLBBgpCESxsFJljv3n8dgtXk8UoytP1rp/
         wPDU2LEh61NGZolaRHKG5rLfrj6P5FFAOB/eyY1eMcOMsMN+K+5DU4u8lJSrT7n3LjB8
         I9Vgr5CqNLhJpQjr78fHEYM7Ifz4j10hkzCtFyS9TX+2oFaT5pg+02fX97tqG5L+f2+i
         75IoCv7C2X12RWZkQVAZcVK5X8nrhS3LW0EPlGG14v52iMBbPyFq0wprs7fRrqyJg180
         4HQA==
X-Forwarded-Encrypted: i=1; AL+hErEF55RG5lmg2dQqXdSitnwGFbS02xt9gMOdoUCUOQtTYLrCH2//mD6sCrJ4+5dE7MDT1+eMeYg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8QdGbf5KpaLw8FfDQ0k8OmedEVHiMPZTl9JxCEi4+g3ShsDqdZ
	5emj0RLzgbCRiIrW7gxa1edETSZfUqcrmJvf96zQev800oSUxNutegXIHbi5uUoHtY+HpzHwag9
	+INLFp5jn8MXj50WxMJQZGxnTTe3JHB8L53UwLd5l0w==
X-Gm-Gg: AZFdTZefr4L8phPoQI4n9G8yAKdarWEpLCfesbXzDyK5n/FGsgs4NzWDAIvgljMg57d
	2Qvh9cA6psUMdOeGxrw/YiCtvb24RjWlPShR2ovb+fDON4x8AUdU9LeB0SCXyKlLe2f+v6/YlZc
	l2zJuWbTWKIDAHfe40vs4+f2bGl50epT6YLhZ/MAI20+SbunTp0PnoGN5JdWd8Ued3w/am6fll7
	pGxkbQpdAUfvCFTwvShSOPq/3MhNUpOKxBYA1iCUrhde3p5W1ApOeXUsZXkv0lF6UEXuECHr5Dk
	CljivgrClNvNiwJZnQdC+X+HeTKEPh6zQSVh+sIbemlfPnUyfQ+b3iy088S7eirijRg1tlsOeUP
	Yt7yl41Af+wgv2Bn9XTtkrSf2v7810zohEm7y4qZeE8ryK+KEu711p6tjChOrt/CusR1akDc=
X-Received: by 2002:a05:6402:3222:b0:6b2:2339:370d with SMTP id
 4fb4d7f45d1cf-6ba37ec485cmr16187328a12.39.1795640507528; Wed, 25 Nov 2026
 13:01:47 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-samsung-pinctrl-busclk-v1-1-6732c10a7f48@linaro.org>
In-Reply-To: <20261123-samsung-pinctrl-busclk-v1-1-6732c10a7f48@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 25 Nov 2026 21:01:35 +0000
X-Gm-Features: Aa3M54oXxYlXaOdRYB1cQuxq3Qps4EcCjGoYfXvMRW_bw_T0X2BdIFPg-0Amxy4
Message-ID: <CADrjBPr9UJ0NzJ1tT2KY=H2ar4vUZBrzQvwfuT_Q_fSUe5x8KQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: samsung: keep bus clock enabled
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Linus Walleij <linusw@kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Juan Yescas <jyescas@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Nov 2026 at 15:59, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> With CONFIG_PROVE_RAW_LOCK_NESTING=3Dy, lockdep reports:
>
>     [ BUG: Invalid wait context ]
>     irq/130-1-0025/196 is trying to lock:
>     (enable_lock){....}-{3:3}, at: clk_enable_lock+0x68/0x110
>     other info that might help us debug this:
>     context-{5:5}
>     locks held by irq/130-1-0025/196: 1, on CPU#0:
>      #0: (&irq_desc_lock_class){-.-.}-{2:2}, at: irq_finalize_oneshot
>     Call trace:
>      _raw_spin_lock_irqsave+0x60/0x98
>      clk_enable_lock+0x68/0x110
>      clk_disable+0x34/0x68
>      exynos_irq_unmask+0xd8/0x1c0
>      unmask_threaded_irq+0x58/0x80
>      irq_finalize_oneshot.part.0+0x98/0x108
>      irq_thread_fn+0x68/0xc0
>      irq_thread+0xd0/0x1e0
>      kthread+0x118/0x138
>      ret_from_fork+0x10/0x20
>
> The driver enables the optional bus clock ("pclk") around each register
> access using clk_enable() and clk_disable(). Both acquire the clock
> framework's enable_lock, which is a spinlock_t. On PREEMPT_RT,
> spinlock_t turns into a sleeping lock and must not be acquired in hard
> interrupt context or while holding a raw_spinlock_t. Most register
> accesses happen in such contexts:
>
> * The IRQ core invokes the irq_chip callbacks .irq_mask(),
>   .irq_unmask(), .irq_ack() and .irq_set_type() with the raw_spinlock_t
>   irq_desc::lock held.
> * exynos_irq_demux_eint16_31() is a chained interrupt handler and runs
>   in hard interrupt context.
> * The gpio_chip callbacks don't sleep, so GPIO consumers may call them
>   in hard interrupt context or with a raw_spinlock_t held.
>
> Lockdep reports this only when enable_lock is contended, because
> clk_enable_lock() tries spin_trylock_irqsave() first and lockdep
> doesn't check the wait context of trylocks.
>
> Enable the bus clock once during probe instead, keep it enabled for as
> long as the driver is bound, and drop all per-access clk_enable() and
> clk_disable() calls. Also revert samsung_pinmux_setup() back to void
> and drop the now-unused pclk member of struct samsung_pinctrl_drv_data.
>
> This reverts only the per-access clk_enable()/clk_disable() portion of
> commit f9c744747973 ("pinctrl: samsung: support a bus clock"). The
> driver still has to acquire and enable the bus clock: without a
> consumer, the clock framework turns off unused gate clocks on kernels
> or DTs without automatic clock gating, and gs101's alive GPIO clocks
> don't set CLK_IGNORE_UNUSED.
>
> The in-tree DTs provide this clock for Google Tensor gs101 only. Since
> commit 298fac4f4b96 ("clk: samsung: Implement automatic clock gating
> mode for CMUs"), the gs101 clock driver registers this clock as an
> automatically gated clock, for which the enable and disable operations
> are no-ops, so keeping the clock enabled doesn't stop the hardware from
> gating it. Without automatic clock gating (in older kernels, and with
> old DTs whose CMU register range size is not 0x10000), the clock stays
> enabled for as long as the driver is bound.
>
> The DT binding requires this clock for Exynos8890 as well, but the tree
> contains neither a DT nor a clock driver for Exynos8890.
>
> Fixes: f9c744747973 ("pinctrl: samsung: support a bus clock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  drivers/pinctrl/samsung/pinctrl-exynos.c  |  80 ----------------------
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 106 +++---------------------=
------
>  drivers/pinctrl/samsung/pinctrl-samsung.h |   2 -
>  3 files changed, 9 insertions(+), 179 deletions(-)
>
> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/s=
amsung/pinctrl-exynos.c
> index c45da9f13411..8adfeae96566 100644
> --- a/drivers/pinctrl/samsung/pinctrl-exynos.c
> +++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
> @@ -13,7 +13,6 @@
>  // the Samsung pinctrl/gpiolib driver. It also includes the implementati=
on of
>  // external gpio and wakeup interrupt support.
>
> -#include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
>  #include <linux/irqdomain.h>
> @@ -69,12 +68,6 @@ static void exynos_irq_mask(struct irq_data *irqd)
>         else
>                 reg_mask =3D our_chip->eint_mask + bank->eint_offset;
>
> -       if (clk_enable(bank->drvdata->pclk)) {
> -               dev_err(bank->gpio_chip.parent,
> -                       "unable to enable clock for masking IRQ\n");
> -               return;
> -       }
> -
>         raw_spin_lock_irqsave(&bank->slock, flags);
>
>         mask =3D readl(bank->eint_base + reg_mask);
> @@ -82,8 +75,6 @@ static void exynos_irq_mask(struct irq_data *irqd)
>         writel(mask, bank->eint_base + reg_mask);
>
>         raw_spin_unlock_irqrestore(&bank->slock, flags);
> -
> -       clk_disable(bank->drvdata->pclk);
>  }
>
>  static void exynos_irq_ack(struct irq_data *irqd)
> @@ -98,15 +89,7 @@ static void exynos_irq_ack(struct irq_data *irqd)
>         else
>                 reg_pend =3D our_chip->eint_pend + bank->eint_offset;
>
> -       if (clk_enable(bank->drvdata->pclk)) {
> -               dev_err(bank->gpio_chip.parent,
> -                       "unable to enable clock to ack IRQ\n");
> -               return;
> -       }
> -
>         writel(1 << irqd->hwirq, bank->eint_base + reg_pend);
> -
> -       clk_disable(bank->drvdata->pclk);
>  }
>
>  static void exynos_irq_unmask(struct irq_data *irqd)
> @@ -134,12 +117,6 @@ static void exynos_irq_unmask(struct irq_data *irqd)
>         else
>                 reg_mask =3D our_chip->eint_mask + bank->eint_offset;
>
> -       if (clk_enable(bank->drvdata->pclk)) {
> -               dev_err(bank->gpio_chip.parent,
> -                       "unable to enable clock for unmasking IRQ\n");
> -               return;
> -       }
> -
>         raw_spin_lock_irqsave(&bank->slock, flags);
>
>         mask =3D readl(bank->eint_base + reg_mask);
> @@ -147,8 +124,6 @@ static void exynos_irq_unmask(struct irq_data *irqd)
>         writel(mask, bank->eint_base + reg_mask);
>
>         raw_spin_unlock_irqrestore(&bank->slock, flags);
> -
> -       clk_disable(bank->drvdata->pclk);
>  }
>
>  static int exynos_irq_set_type(struct irq_data *irqd, unsigned int type)
> @@ -159,7 +134,6 @@ static int exynos_irq_set_type(struct irq_data *irqd,=
 unsigned int type)
>         unsigned int shift =3D EXYNOS_EINT_CON_LEN * irqd->hwirq;
>         unsigned int con, trig_type;
>         unsigned long reg_con;
> -       int ret;
>
>         switch (type) {
>         case IRQ_TYPE_EDGE_RISING:
> @@ -192,20 +166,11 @@ static int exynos_irq_set_type(struct irq_data *irq=
d, unsigned int type)
>         else
>                 reg_con =3D our_chip->eint_con + bank->eint_offset;
>
> -       ret =3D clk_enable(bank->drvdata->pclk);
> -       if (ret) {
> -               dev_err(bank->gpio_chip.parent,
> -                       "unable to enable clock for configuring IRQ type\=
n");
> -               return ret;
> -       }
> -
>         con =3D readl(bank->eint_base + reg_con);
>         con &=3D ~(EXYNOS_EINT_CON_MASK << shift);
>         con |=3D trig_type << shift;
>         writel(con, bank->eint_base + reg_con);
>
> -       clk_disable(bank->drvdata->pclk);
> -
>         return 0;
>  }
>
> @@ -242,14 +207,6 @@ static int exynos_irq_request_resources(struct irq_d=
ata *irqd)
>         shift =3D irqd->hwirq * bank_type->fld_width[PINCFG_TYPE_FUNC];
>         mask =3D (1 << bank_type->fld_width[PINCFG_TYPE_FUNC]) - 1;
>
> -       ret =3D clk_enable(bank->drvdata->pclk);
> -       if (ret) {
> -               dev_err(bank->gpio_chip.parent,
> -                       "unable to enable clock for configuring pin %s-%l=
u\n",
> -                       bank->name, irqd->hwirq);
> -               return ret;
> -       }
> -
>         raw_spin_lock_irqsave(&bank->slock, flags);
>
>         con =3D readl(bank->pctl_base + reg_con);
> @@ -259,8 +216,6 @@ static int exynos_irq_request_resources(struct irq_da=
ta *irqd)
>
>         raw_spin_unlock_irqrestore(&bank->slock, flags);
>
> -       clk_disable(bank->drvdata->pclk);
> -
>         return 0;
>  }
>
> @@ -275,13 +230,6 @@ static void exynos_irq_release_resources(struct irq_=
data *irqd)
>         shift =3D irqd->hwirq * bank_type->fld_width[PINCFG_TYPE_FUNC];
>         mask =3D (1 << bank_type->fld_width[PINCFG_TYPE_FUNC]) - 1;
>
> -       if (clk_enable(bank->drvdata->pclk)) {
> -               dev_err(bank->gpio_chip.parent,
> -                       "unable to enable clock for deconfiguring pin %s-=
%lu\n",
> -                       bank->name, irqd->hwirq);
> -               return;
> -       }
> -
>         raw_spin_lock_irqsave(&bank->slock, flags);
>
>         con =3D readl(bank->pctl_base + reg_con);
> @@ -291,8 +239,6 @@ static void exynos_irq_release_resources(struct irq_d=
ata *irqd)
>
>         raw_spin_unlock_irqrestore(&bank->slock, flags);
>
> -       clk_disable(bank->drvdata->pclk);
> -
>         gpiochip_unlock_as_irq(&bank->gpio_chip, irqd->hwirq);
>  }
>
> @@ -342,19 +288,11 @@ static irqreturn_t exynos_eint_gpio_irq(int irq, vo=
id *data)
>         unsigned int svc, group, pin;
>         int ret;
>
> -       if (clk_enable(bank->drvdata->pclk)) {
> -               dev_err(bank->gpio_chip.parent,
> -                       "unable to enable clock for handling IRQ\n");
> -               return IRQ_NONE;
> -       }
> -
>         if (bank->eint_con_offset)
>                 svc =3D readl(bank->eint_base + EXYNOSAUTO_SVC_OFFSET);
>         else
>                 svc =3D readl(bank->eint_base + EXYNOS_SVC_OFFSET);
>
> -       clk_disable(bank->drvdata->pclk);
> -
>         group =3D EXYNOS_SVC_GROUP(svc);
>         pin =3D svc & EXYNOS_SVC_NUM_MASK;
>
> @@ -729,20 +667,6 @@ static void exynos_irq_demux_eint16_31(struct irq_de=
sc *desc)
>
>         chained_irq_enter(chip, desc);
>
> -       /*
> -        * just enable the clock once here, to avoid an enable/disable da=
nce for
> -        * each bank.
> -        */
> -       if (eintd->nr_banks) {
> -               struct samsung_pin_bank *b =3D eintd->banks[0];
> -
> -               if (clk_enable(b->drvdata->pclk)) {
> -                       dev_err(b->gpio_chip.parent,
> -                               "unable to enable clock for pending IRQs\=
n");
> -                       goto out;
> -               }
> -       }
> -
>         for (i =3D 0; i < eintd->nr_banks; ++i) {
>                 struct samsung_pin_bank *b =3D eintd->banks[i];
>                 pend =3D readl(b->eint_base + b->irq_chip->eint_pend
> @@ -752,10 +676,6 @@ static void exynos_irq_demux_eint16_31(struct irq_de=
sc *desc)
>                 exynos_irq_demux_eint(pend & ~mask, b->irq_domain);
>         }
>
> -       if (eintd->nr_banks)
> -               clk_disable(eintd->banks[0]->drvdata->pclk);
> -
> -out:
>         chained_irq_exit(chip, desc);
>  }
>
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/=
samsung/pinctrl-samsung.c
> index 0c91e1124a46..16980f4ef3b1 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> @@ -370,8 +370,8 @@ static void pin_to_reg_bank(struct samsung_pinctrl_dr=
v_data *drvdata,
>  }
>
>  /* enable or disable a pinmux function */
> -static int samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned se=
lector,
> -                               unsigned group)
> +static void samsung_pinmux_setup(struct pinctrl_dev *pctldev,
> +                                unsigned int selector, unsigned int grou=
p)
>  {
>         struct samsung_pinctrl_drv_data *drvdata;
>         const struct samsung_pin_bank_type *type;
> @@ -381,7 +381,6 @@ static int samsung_pinmux_setup(struct pinctrl_dev *p=
ctldev, unsigned selector,
>         unsigned long flags;
>         const struct samsung_pmx_func *func;
>         const struct samsung_pin_group *grp;
> -       int ret;
>
>         drvdata =3D pinctrl_dev_get_drvdata(pctldev);
>         func =3D &drvdata->pmx_functions[selector];
> @@ -397,12 +396,6 @@ static int samsung_pinmux_setup(struct pinctrl_dev *=
pctldev, unsigned selector,
>                 reg +=3D 4;
>         }
>
> -       ret =3D clk_enable(drvdata->pclk);
> -       if (ret) {
> -               dev_err(pctldev->dev, "failed to enable clock for setup\n=
");
> -               return ret;
> -       }
> -
>         raw_spin_lock_irqsave(&bank->slock, flags);
>
>         data =3D readl(reg + type->reg_offset[PINCFG_TYPE_FUNC]);
> @@ -411,10 +404,6 @@ static int samsung_pinmux_setup(struct pinctrl_dev *=
pctldev, unsigned selector,
>         writel(data, reg + type->reg_offset[PINCFG_TYPE_FUNC]);
>
>         raw_spin_unlock_irqrestore(&bank->slock, flags);
> -
> -       clk_disable(drvdata->pclk);
> -
> -       return 0;
>  }
>
>  /* enable a specified pinmux by writing to registers */
> @@ -422,7 +411,8 @@ static int samsung_pinmux_set_mux(struct pinctrl_dev =
*pctldev,
>                                   unsigned selector,
>                                   unsigned group)
>  {
> -       return samsung_pinmux_setup(pctldev, selector, group);
> +       samsung_pinmux_setup(pctldev, selector, group);
> +       return 0;
>  }
>
>  /* list of pinmux callbacks for the pinmux vertical in pinctrl core */
> @@ -445,7 +435,6 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pct=
ldev, unsigned int pin,
>         u32 data, width, pin_offset, mask, shift;
>         u32 cfg_value, cfg_reg;
>         unsigned long flags;
> -       int ret;
>
>         drvdata =3D pinctrl_dev_get_drvdata(pctldev);
>         pin_to_reg_bank(drvdata, pin, &reg_base, &pin_offset, &bank);
> @@ -457,12 +446,6 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pc=
tldev, unsigned int pin,
>         width =3D type->fld_width[cfg_type];
>         cfg_reg =3D type->reg_offset[cfg_type];
>
> -       ret =3D clk_enable(drvdata->pclk);
> -       if (ret) {
> -               dev_err(drvdata->dev, "failed to enable clock\n");
> -               return ret;
> -       }
> -
>         raw_spin_lock_irqsave(&bank->slock, flags);
>
>         mask =3D (1 << width) - 1;
> @@ -482,8 +465,6 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pct=
ldev, unsigned int pin,
>
>         raw_spin_unlock_irqrestore(&bank->slock, flags);
>
> -       clk_disable(drvdata->pclk);
> -
>         return 0;
>  }
>
> @@ -574,22 +555,12 @@ static int samsung_gpio_set(struct gpio_chip *gc, u=
nsigned int offset,
>                             int value)
>  {
>         struct samsung_pin_bank *bank =3D gpiochip_get_data(gc);
> -       struct samsung_pinctrl_drv_data *drvdata =3D bank->drvdata;
>         unsigned long flags;
> -       int ret;
> -
> -       ret =3D clk_enable(drvdata->pclk);
> -       if (ret) {
> -               dev_err(drvdata->dev, "failed to enable clock\n");
> -               return ret;
> -       }
>
>         raw_spin_lock_irqsave(&bank->slock, flags);
>         samsung_gpio_set_value(gc, offset, value);
>         raw_spin_unlock_irqrestore(&bank->slock, flags);
>
> -       clk_disable(drvdata->pclk);
> -
>         return 0;
>  }
>
> @@ -600,23 +571,13 @@ static int samsung_gpio_get(struct gpio_chip *gc, u=
nsigned offset)
>         u32 data;
>         struct samsung_pin_bank *bank =3D gpiochip_get_data(gc);
>         const struct samsung_pin_bank_type *type =3D bank->type;
> -       struct samsung_pinctrl_drv_data *drvdata =3D bank->drvdata;
> -       int ret;
>
>         reg =3D bank->pctl_base + bank->pctl_offset;
>
> -       ret =3D clk_enable(drvdata->pclk);
> -       if (ret) {
> -               dev_err(drvdata->dev, "failed to enable clock\n");
> -               return ret;
> -       }
> -
>         data =3D readl(reg + type->reg_offset[PINCFG_TYPE_DAT]);
>         data >>=3D offset;
>         data &=3D 1;
>
> -       clk_disable(drvdata->pclk);
> -
>         return data;
>  }
>
> @@ -661,22 +622,13 @@ static int samsung_gpio_set_direction(struct gpio_c=
hip *gc,
>  static int samsung_gpio_direction_input(struct gpio_chip *gc, unsigned o=
ffset)
>  {
>         struct samsung_pin_bank *bank =3D gpiochip_get_data(gc);
> -       struct samsung_pinctrl_drv_data *drvdata =3D bank->drvdata;
>         unsigned long flags;
>         int ret;
>
> -       ret =3D clk_enable(drvdata->pclk);
> -       if (ret) {
> -               dev_err(drvdata->dev, "failed to enable clock\n");
> -               return ret;
> -       }
> -
>         raw_spin_lock_irqsave(&bank->slock, flags);
>         ret =3D samsung_gpio_set_direction(gc, offset, true);
>         raw_spin_unlock_irqrestore(&bank->slock, flags);
>
> -       clk_disable(drvdata->pclk);
> -
>         return ret;
>  }
>
> @@ -685,23 +637,14 @@ static int samsung_gpio_direction_output(struct gpi=
o_chip *gc, unsigned offset,
>                                                         int value)
>  {
>         struct samsung_pin_bank *bank =3D gpiochip_get_data(gc);
> -       struct samsung_pinctrl_drv_data *drvdata =3D bank->drvdata;
>         unsigned long flags;
>         int ret;
>
> -       ret =3D clk_enable(drvdata->pclk);
> -       if (ret) {
> -               dev_err(drvdata->dev, "failed to enable clock\n");
> -               return ret;
> -       }
> -
>         raw_spin_lock_irqsave(&bank->slock, flags);
>         samsung_gpio_set_value(gc, offset, value);
>         ret =3D samsung_gpio_set_direction(gc, offset, false);
>         raw_spin_unlock_irqrestore(&bank->slock, flags);
>
> -       clk_disable(drvdata->pclk);
> -
>         return ret;
>  }
>
> @@ -1028,7 +971,6 @@ static int samsung_gpio_set_config(struct gpio_chip =
*gc, unsigned int offset,
>         struct samsung_pin_bank *bank =3D gpiochip_get_data(gc);
>         struct samsung_pinctrl_drv_data *drvdata =3D bank->drvdata;
>         unsigned int value;
> -       int ret =3D 0;
>         unsigned long flags;
>
>         switch (pinconf_to_config_param(config)) {
> @@ -1045,19 +987,11 @@ static int samsung_gpio_set_config(struct gpio_chi=
p *gc, unsigned int offset,
>                 return -ENOTSUPP;
>         }
>
> -       ret =3D clk_enable(drvdata->pclk);
> -       if (ret) {
> -               dev_err(drvdata->dev, "failed to enable clock\n");
> -               return ret;
> -       }
> -
>         raw_spin_lock_irqsave(&bank->slock, flags);
>         samsung_gpio_set_pud(gc, offset, value);
>         raw_spin_unlock_irqrestore(&bank->slock, flags);
>
> -       clk_disable(drvdata->pclk);
> -
> -       return ret;
> +       return 0;
>  }
>
>  static const struct gpio_chip samsung_gpiolib_chip =3D {
> @@ -1257,6 +1191,7 @@ static int samsung_pinctrl_probe(struct platform_de=
vice *pdev)
>         struct samsung_pinctrl_drv_data *drvdata;
>         const struct samsung_pin_ctrl *ctrl;
>         struct device *dev =3D &pdev->dev;
> +       struct clk *pclk;
>         int ret;
>
>         drvdata =3D devm_kzalloc_obj(dev, *drvdata);
> @@ -1285,9 +1220,9 @@ static int samsung_pinctrl_probe(struct platform_de=
vice *pdev)
>                 }
>         }
>
> -       drvdata->pclk =3D devm_clk_get_optional_prepared(dev, "pclk");
> -       if (IS_ERR(drvdata->pclk)) {
> -               ret =3D PTR_ERR(drvdata->pclk);
> +       pclk =3D devm_clk_get_optional_enabled(dev, "pclk");
> +       if (IS_ERR(pclk)) {
> +               ret =3D PTR_ERR(pclk);
>                 goto err_put_banks;
>         }
>
> @@ -1335,13 +1270,6 @@ static int __maybe_unused samsung_pinctrl_suspend(=
struct device *dev)
>         struct samsung_pin_bank *bank;
>         int i;
>
> -       i =3D clk_enable(drvdata->pclk);
> -       if (i) {
> -               dev_err(drvdata->dev,
> -                       "failed to enable clock for saving state\n");
> -               return i;
> -       }
> -
>         for (i =3D 0; i < drvdata->nr_banks; i++) {
>                 bank =3D &drvdata->pin_banks[i];
>                 const void __iomem *reg =3D bank->pctl_base + bank->pctl_=
offset;
> @@ -1377,8 +1305,6 @@ static int __maybe_unused samsung_pinctrl_suspend(s=
truct device *dev)
>                         drvdata->suspend(bank);
>         }
>
> -       clk_disable(drvdata->pclk);
> -
>         if (drvdata->retention_ctrl && drvdata->retention_ctrl->enable)
>                 drvdata->retention_ctrl->enable(drvdata);
>
> @@ -1397,20 +1323,8 @@ static int __maybe_unused samsung_pinctrl_resume(s=
truct device *dev)
>  {
>         struct samsung_pinctrl_drv_data *drvdata =3D dev_get_drvdata(dev)=
;
>         struct samsung_pin_bank *bank;
> -       int ret;
>         int i;
>
> -       /*
> -        * enable clock before the callback, as we don't want to have to =
deal
> -        * with callback cleanup on clock failures.
> -        */
> -       ret =3D clk_enable(drvdata->pclk);
> -       if (ret) {
> -               dev_err(drvdata->dev,
> -                       "failed to enable clock for restoring state\n");
> -               return ret;
> -       }
> -
>         for (i =3D 0; i < drvdata->nr_banks; i++) {
>                 bank =3D &drvdata->pin_banks[i];
>                 if (drvdata->resume)
> @@ -1448,8 +1362,6 @@ static int __maybe_unused samsung_pinctrl_resume(st=
ruct device *dev)
>                                 writel(bank->pm_save[type], reg + offs[ty=
pe]);
>         }
>
> -       clk_disable(drvdata->pclk);
> -
>         if (drvdata->retention_ctrl && drvdata->retention_ctrl->disable)
>                 drvdata->retention_ctrl->disable(drvdata);
>
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/=
samsung/pinctrl-samsung.h
> index 7c60375d5924..5390c6d1d7a5 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.h
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
> @@ -302,7 +302,6 @@ struct samsung_pin_ctrl {
>   *             through samsung_pinctrl_drv_data, not samsung_pin_bank).
>   * @dev: device instance representing the controller.
>   * @irq: interrpt number used by the controller to notify gpio interrupt=
s.
> - * @pclk: optional bus clock if required for accessing registers
>   * @ctrl: pin controller instance managed by the driver.
>   * @pctl: pin controller descriptor registered with the pinctrl subsyste=
m.
>   * @pctl_dev: cookie representing pinctrl device instance.
> @@ -322,7 +321,6 @@ struct samsung_pinctrl_drv_data {
>         void __iomem                    *virt_base;
>         struct device                   *dev;
>         int                             irq;
> -       struct clk                      *pclk;
>
>         struct pinctrl_desc             pctl;
>         struct pinctrl_dev              *pctl_dev;
>
> ---
> base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
> change-id: 20261123-samsung-pinctrl-busclk-7211f2c20f58
>
> Best regards,
> --
> Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
