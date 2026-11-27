Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796558;
	b=3LqCQ6C39sQ2KnQ8Lsgluxl1oiyAE/ua8d1/07N0wXR0VlYPwDF1HwbdsAJ4cc3o1fyx
	 9ArJsX3Use93kX/8n8CO6hW7csJqivNKRSdsV3Ps92g1veD9Nrk8SXFHtNDDggOvEJYM+
	 jPB00CjmFvrC9ivD3Ts3em3bI3gdeittcqLCcX/eewwERdKBBe+i++Ca2bQPV1pBFT97G
	 vYUJaXV3AR6hSfZ1OF1K1dSQthxJYTj8Fuk5IC2YhGSWj7QQ+bPgTnC7xAnHS67mty3BH
	 QVxv2atCGHCGZUSlqYvkvOyTfhW69SDQo2FLFqrl4I4xMOJe4S99YzYVTBVPxEjavOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796558;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:Received:X-Received:MIME-Version:
	 References:In-Reply-To:Reply-To:From:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=2FluCkB23A2rX2sPHBDAcwkjRgUYCjrVI/IlnA5wVSI=;
	b=Hra6cCJSBLaHnviOIiBtufT5ayysCldKp5ywn9u1gwH17h7Wo9fTO2MPmn6vGhWkU6NG
	 8LKi9kalUqOFLsBXwxQVotSaGydq4aZ9+bllR//uT7zvAhFptSD7qn2DZolgVGcSUKoMG
	 GPA2VKt7PI5iZYWzPZgKzRMO6oEmOzQ+1FdSiuJV6jROviu5FEVsVDh+7BiexXU1GUCLF
	 jRloZuIDipxtFqhw/Z/Tiu/QHo4xdf6+6BNknQbkc1sMwE6bIMvkEumP3c9dnFvdkAent
	 UcDt8KbadKkmaVLP/upgt307UvHQcARbjQh/hQGsCHHQvRFc5KxAHfWFsnFzkqgqMkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DE9606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 16:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80DE9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b4f4095a7aso72831437b3.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 08:22:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795796556; x=1796401356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2FluCkB23A2rX2sPHBDAcwkjRgUYCjrVI/IlnA5wVSI=;
        b=DI3g41cT8ECiFzj8ziGaHSqmAWKgkT01io7+Kj8LKILJ185GmKTBzpqK8fiMOg05Mr
         s0gW3/wsilio6VD0sMPZzveCPsD3geJeQgn8izx+0y7QEWNjWaNPWb5kvhIeoM7kYji0
         Wmhi+7T4CFWWn1OofqK62H9OaRKpbVjxh0ThewEGAAAVB3vp7cn3mBKgee22+J/3ioAg
         H7itUcD/TEhP1t0wtcEPmxjXsqQY///O0EBkI8ruEzdWX5IDC6zTi5lS0zH4j1AEMW0S
         O0b+Fs1Ygps7VULhfl2oi1isB3hbJD3HMlNVY6bj91kRvcnX02i5QEVJEf+owV0994aa
         PcIw==
X-Gm-Message-State: APuU4Z+DJF4MowZKP5w+wH3QoNMSmasKAZDsF0oqEg1YwbI7oO5nlQ46
	t4eGrKMZgftK6g8pkUjmq4hIxg0Uf+FcstqW4EBv+nXjnf4TLaVtNMwEpLiPY+gZ
X-Gm-Gg: AZFdTZcSzkcXCBy4bluHLh5rY8+1u2kQmNVnoOiNdcr7qU3sSXSC4kpowqWpW3pcXzq
	VG2O7XuF+SoSwrEN7T2U1PtJ3yKdpEn95/Idwa9CDUQlGscT7fCKSSejnBOA8E2L0JQmMxUoas8
	nNXE4Tl8e2ZJmhi5P3JcBUNYOTjDyxzOdX23zop/AobMeghPv9Auyco3g0wiph5ajfCpaAkCUpr
	07jn4GKOvsu7acbED1kdX4jgMdlAnePDnaiSvaBP8s/wk3yqp/bYNgFDT7Rw7FVZZE4FyYA+q1v
	uiFf9e044XtheUzlUzpzHAlmucLd0Rtw/LaF79hO81GVC+IBm47nCo+bIEwWfmj5jTXIg0UDD2k
	zguiwChAkEc7snwqY4tVlXVi+lIW3sCUdhxBlsMj2OKXRQ+w9kaJbd49Vfop0LNKbleu7H+fiCB
	cH4FhESyPxrG7V+wKfmf9NJMdbPlrCfhDukNed1w0ZB+D/2EEId7AvyTSieA/UVjr3Rxlj67x/7
	VOVmrxFuxIdmgxF4HAB4Pa/IqwxhDUvqXRJjgaspr1MVanEuI509vqenl9aX4lCvcboee7QVSz6
	52PFK+CEtjVz/mTCOj+PlHQmQ7G1aP88yGzQrzRljD+Zuyu8WpTZ5RaGnvMqikBz5NR89z7GGPB
	2ZR0pSnMzbyjMrFajw3AwlaQWnke4GxdAm7mDBld+oF58khvI//0z7fdchw==
X-Received: by 2002:a05:690c:338e:b0:8b4:d166:1808 with SMTP id 00721157ae682-8b520500fa4mr118112637b3.41.1795796556240;
        Fri, 27 Nov 2026 08:22:36 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b520ca0cf8sm93987207b3.29.2026.11.27.08.22.35
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 08:22:35 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b4f4095a7aso72831047b3.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 08:22:35 -0800 (PST)
X-Received: by 2002:a05:690c:9a82:b0:8b0:c71d:2b2b with SMTP id
 00721157ae682-8b5205137b8mr119923687b3.45.1795796555253; Fri, 27 Nov 2026
 08:22:35 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114133738.52817-1-tanure@linux.com>
In-Reply-To: <20261114133738.52817-1-tanure@linux.com>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Fri, 27 Nov 2026 16:22:23 +0000
X-Gmail-Original-Message-ID: <CAJX_Q+15Vit+pU3XE+DiUH4u6APf-FYBuhnrVGx9=pZC8MGpWw@mail.gmail.com>
X-Gm-Features: Aa3M54quNMc8BBDlmy1z8lmGJhR7RotCtAP1c_2g21GpRyDjwzEWIScV0cEj9Ts
Message-ID: <CAJX_Q+15Vit+pU3XE+DiUH4u6APf-FYBuhnrVGx9=pZC8MGpWw@mail.gmail.com>
Subject: Re: [PATCH] iommu/rockchip: do not walk the page tables of a disabled MMU
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Cc: stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 1:37=E2=80=AFPM Lucas Tanure <tanure@linux.com> wro=
te:
>
> A page fault handler running while another CPU detaches the same IOMMU
> can read a cleared RK_MMU_DTE_ADDR, turn it into a linear-map pointer
> and dereference it, which panics the machine. A dummy or firmware-left
> address is as unsafe.
>
> Seen on PX30 at reboot: the display controller still fetched an
> unmapped framebuffer, its IOMMU sat in a page fault, ignored the stall
> and paging-disable commands, and had RK_MMU_DTE_ADDR cleared during
> the handler's second run.
>
> No wait works: the master shares the line, the RK3588 NPU driver
> detaches from its interrupt thread, where synchronize_irq() deadlocks,
> and synchronize_hardirq() skips a force-threaded handler. A spinlock
> orders the walk against the register clear.
>
> 6.1 vendor kernel log, rk_pagefault_done is the walk, per CPU:
>
>   CPU 1, init, reboot path:
>   [ 1069.789374][    T1] rk_iommu ff460f00.iommu: Enable stall request ti=
med out, retry_count =3D 0, status: 0x0002cb
>   [ 1069.791314][    T1] rk_iommu ff460f00.iommu: Disable paging request =
timed out, retry_count =3D 0, status: 0x0002cb
>   [ 1069.830197][    T1] Call trace:
>   [ 1069.830922][    T1]  iommu_detach_device+0xd0/0xdc
>   [ 1069.831483][    T1]  rockchip_drm_dma_detach_device+0x1c/0x34
>   [ 1069.832033][    T1]  vop_crtc_atomic_disable+0xb0c/0xc44
>   [ 1069.832751][    T1]  drm_atomic_helper_commit_modeset_disables+0x348=
/0x690
>   ...
>   [ 1069.836601][    T1]  drm_atomic_helper_shutdown+0xa0/0x158
>   [ 1069.837152][    T1]  rockchip_drm_platform_shutdown+0x18/0x2c
>   [ 1069.837870][    T1]  platform_shutdown+0x3c/0x54
>   [ 1069.838599][    T1]  device_shutdown+0x194/0x260
>   [ 1069.839160][    T1]  kernel_restart+0x40/0x128
>
>   CPU 0, page fault handler:
>   [ 1069.790364][    C0] rk_iommu ff460f00.iommu: Page fault at 0x0000000=
0ffee0000 of type read
>   [ 1069.792129][    C0] rk_iommu ff460f00.iommu: Page fault while iommu =
not attached to domain?
>   [ 1069.792184][    C0] rk_iommu ff460f00.iommu: Page fault at 0x0000000=
0ffee0280 of type read
>   [ 1069.794604][    C0] Unable to handle kernel paging request at virtua=
l address ffffff8000000ffc
>   [ 1069.805998][    C0] Internal error: Oops: 0000000096000006 [#1] PREE=
MPT SMP
>   [ 1069.809484][    C0] pc : rk_pagefault_done+0x1b4/0x3c8
>   [ 1069.810548][    C0] lr : rk_pagefault_done+0x19c/0x3c8
>   [ 1069.832390][    C0] Call trace:
>   [ 1069.833116][    C0]  rk_pagefault_done+0x1b4/0x3c8
>   [ 1069.833844][    C0]  rk_iommu_irq+0x64/0xc8
>   [ 1069.834395][    C0]  __handle_irq_event_percpu+0xe8/0x2ac
>   [ 1069.834945][    C0]  handle_irq_event+0x40/0xbc
>   [ 1069.835675][    C0]  handle_fasteoi_irq+0x118/0x28c
>   [ 1069.836404][    C0]  generic_handle_domain_irq+0x44/0x6c
>   [ 1069.836954][    C0]  gic_handle_irq+0x60/0xf0
>   [ 1069.837505][    C0]  call_on_irq_stack+0x3c/0x5c
>   [ 1069.838235][    C0]  do_interrupt_handler+0x4c/0x94
>   [ 1069.838963][    C0]  el1_interrupt+0x44/0xa8
>   [ 1069.839446][    C0]  el1h_64_irq_handler+0x18/0x2c
>   [ 1069.839997][    C0]  el1h_64_irq+0x78/0x7c
>   [ 1071.215224][    C0] Kernel panic - not syncing: Oops: Fatal exceptio=
n in interrupt
>
> Fixes: c68a292152d3 ("iommu/rockchip: rk3288 iommu driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  drivers/iommu/rockchip-iommu.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iomm=
u.c
> index 1fa3110b142a..0f40d9678344 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -115,6 +115,7 @@ struct rk_iommu {
>         struct iommu_device iommu;
>         struct list_head node; /* entry in rk_iommu_domain.iommus */
>         struct iommu_domain *domain; /* domain to which iommu is attached=
 */
> +       spinlock_t lock;
>         const struct rk_iommu_ops *rk_ops;
>  };
>
> @@ -543,7 +544,8 @@ static int rk_iommu_force_reset(struct rk_iommu *iomm=
u)
>         return 0;
>  }
>
> -static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
> +static void log_iova(struct rk_iommu *iommu, struct iommu_domain *domain=
,
> +                    int index, dma_addr_t iova)
>  {
>         void __iomem *base =3D iommu->bases[index];
>         u32 dte_index, pte_index, page_offset;
> @@ -563,6 +565,12 @@ static void log_iova(struct rk_iommu *iommu, int ind=
ex, dma_addr_t iova)
>
>         mmu_dte_addr =3D rk_iommu_read(base, RK_MMU_DTE_ADDR);
>         mmu_dte_addr_phys =3D iommu->rk_ops->pt_address(mmu_dte_addr);
> +       if (domain =3D=3D &rk_identity_domain ||
> +           mmu_dte_addr_phys !=3D to_rk_domain(domain)->dt_dma) {
> +               dev_err(iommu->dev, "iova =3D %pad: page directory %#x is=
 not the attached domain's, not walked\n",
> +                       &iova, mmu_dte_addr);
> +               return;
> +       }
>
>         dte_addr_phys =3D mmu_dte_addr_phys + (4 * dte_index);
>         dte_addr =3D phys_to_virt(dte_addr_phys);
> @@ -593,6 +601,7 @@ static void log_iova(struct rk_iommu *iommu, int inde=
x, dma_addr_t iova)
>  static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>  {
>         struct rk_iommu *iommu =3D dev_id;
> +       struct iommu_domain *domain;
>         u32 status;
>         u32 int_status;
>         dma_addr_t iova;
> @@ -606,6 +615,8 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id=
)
>         if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
>                 goto out;
>
> +       spin_lock(&iommu->lock);
> +       domain =3D READ_ONCE(iommu->domain);
>         for (i =3D 0; i < iommu->num_mmu; i++) {
>                 int_status =3D rk_iommu_read(iommu->bases[i], RK_MMU_INT_=
STATUS);
>                 if (int_status =3D=3D 0)
> @@ -625,15 +636,15 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_=
id)
>                                 &iova,
>                                 str_write_read(flags =3D=3D IOMMU_FAULT_W=
RITE));
>
> -                       log_iova(iommu, i, iova);
> +                       log_iova(iommu, domain, i, iova);
>
>                         /*
>                          * Report page fault to any installed handlers.
>                          * Ignore the return code, though, since we alway=
s zap cache
>                          * and clear the page fault anyway.
>                          */
> -                       if (iommu->domain !=3D &rk_identity_domain)
> -                               report_iommu_fault(iommu->domain, iommu->=
dev, iova,
> +                       if (domain !=3D &rk_identity_domain)
> +                               report_iommu_fault(domain, iommu->dev, io=
va,
>                                                    flags);
>                         else
>                                 dev_err(iommu->dev, "Page fault while iom=
mu not attached to domain?\n");
> @@ -651,6 +662,7 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id=
)
>
>                 rk_iommu_write(iommu->bases[i], RK_MMU_INT_CLEAR, int_sta=
tus);
>         }
> +       spin_unlock(&iommu->lock);
>
>         clk_bulk_disable(iommu->num_clocks, iommu->clocks);
>
> @@ -921,16 +933,19 @@ static struct rk_iommu *rk_iommu_from_dev(struct de=
vice *dev)
>  /* Must be called with iommu powered on and attached */
>  static void rk_iommu_disable(struct rk_iommu *iommu)
>  {
> +       unsigned long flags;
>         int i;
>
>         /* Ignore error while disabling, just keep going */
>         WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
>         rk_iommu_enable_stall(iommu);
>         rk_iommu_disable_paging(iommu);
> +       spin_lock_irqsave(&iommu->lock, flags);
>         for (i =3D 0; i < iommu->num_mmu; i++) {
>                 rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, 0);
>                 rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, 0);
>         }
> +       spin_unlock_irqrestore(&iommu->lock, flags);
>         rk_iommu_disable_stall(iommu);
>         clk_bulk_disable(iommu->num_clocks, iommu->clocks);
>  }
> @@ -997,7 +1012,7 @@ static int rk_iommu_identity_attach(struct iommu_dom=
ain *identity_domain,
>         if (iommu->domain =3D=3D identity_domain)
>                 return 0;
>
> -       iommu->domain =3D identity_domain;
> +       WRITE_ONCE(iommu->domain, identity_domain);
>
>         spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>         list_del_init(&iommu->node);
> @@ -1051,7 +1066,7 @@ static int rk_iommu_attach_device(struct iommu_doma=
in *domain,
>         if (ret)
>                 return ret;
>
> -       iommu->domain =3D domain;
> +       WRITE_ONCE(iommu->domain, domain);
>
>         spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>         list_add_tail(&iommu->node, &rk_domain->iommus);
> @@ -1227,6 +1242,7 @@ static int rk_iommu_probe(struct platform_device *p=
dev)
>                 return -ENOMEM;
>
>         iommu->domain =3D &rk_identity_domain;
> +       spin_lock_init(&iommu->lock);
>
>         platform_set_drvdata(pdev, iommu);
>         iommu->dev =3D dev;
> --
> 2.56.1
>
ping?
