Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC37F457E7A
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243819; cv=pass; b=twx93CaEgoD8nx/Am7OU48j5MmbuMVtuiGj252HuGy+5P02x/0G8gsHk+d+dtTZO7ZTEluW8iIqFItd8SN1ABmIX1U8vyo0rgz+tLLbxS+VlZgJywL64s9VFTZuGeiNXlxRgqrOYdUrqayz3y0dPuNBtI/395CpmSOXqGes+RVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243819; c=relaxed/simple;
	bh=P1ndA+eBVn+zYbAgTqPlA5s6bd2yOGM1nW0tBCwcEQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6s8vm7oLVWH5789l+g9YREmvzYbYxgZNKba+8Vj1iuhjCPReQQeoVc6L3JMFR1j/A1Aq+vqKqEqHHpC/rE8XtUcnpjYqmA0O1ioL/EYHEiLl/x2V7JoCq2iqazsm+up8r9XDXcIv9Bg1brsWaI/WZnqAAaVKJOqCJGRng/wJP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJVbFSWT; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJVbFSWT"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76906adso31304671cf.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 02:56:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790243801; cv=none;
        d=google.com; s=arc-20260327;
        b=IbWe9v9AtohgnON02qJiC0KNOsF6iF86cgDfpSIoTiDCcXtVCTpTAn/uN6ilzRv8jv
         h+h3myEsNbkmOQMeH0N6+bkSU1qvnp/D++vTRF30wLlRfhMLjrl6sWrccTrR8KuW4PhF
         nSsXw/SC6PBFvStjWjj0a/nk13SkEghRuVXS0BHoJXPnylkNopcPdQxsupcVLz49UVau
         asKAP4R2sZc0KqawdnznpHWhXFsjXzTXJpjdVFnui1HwTsBcS9UgTVq+HRAiM63f1XXV
         QO/rcM4mBlkRMU5B3bfr6LsCZigvlG0+dhbDD9CCLoDLQHwbprGRfktYTunMee3fs+gs
         wFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZIYNgjeCL0OsYc0prVytzssq1ZX8j8EgYAM9VB1jIEI=;
        fh=dUnfrn/WxkPSCMREUDAAenF3jtmpv+x0JF9ey5HpHpM=;
        b=jH0TA8giBxZnQ2lMOfInu56TVJAY2S5tkMz67E/K4UwUEMGLqEq4ymID6NKbcor5mf
         Ib/0J6lkviWmgVvllcRGQ4MNkGUHP06brFADxMKHrzDAZXo4ubF04gUwLDMNNekMZQZI
         C7FGMZCFDuVV8odeVtt/SYTbVlYJXIBHvW0KuL1GxA48UOmB/a8IPEr4f9mn7jW9Z1ZT
         0Dro4Ab/nAa9/TGkg5duEOLVS+Tkqi8AnY9njK0FqWMgardBY9lyqqjwoi5Uuu0WO3fb
         2nGSVSaqklH/2A/ZRF/yKP/Vy4QCUaSsITrwVqBmYpcWoQMEH6kh8EsgCKfsOKhpRb5T
         ppAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790243801; x=1790848601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZIYNgjeCL0OsYc0prVytzssq1ZX8j8EgYAM9VB1jIEI=;
        b=PJVbFSWT1X8mh3hx5PnKzYW0FA/5H4rTYypMG8e8iiFO5+aj/nMoI9Gyr3Iu0eiS0a
         ZaaWilagYC66hqDVHeZrt/JkpRuoFook6AwqndEcd9wc9iKuSc/qkSEA4OBN1vUN4A6E
         SPbEJivIzQWCLAgHdwfpXWFin95GtMqkzsmw7Y/lPabc1SvRNmaAs6/UEfvMWBAzsVKT
         /YRgxIyEqzYo9ZzcInvBJwndjBRVcoeIYlqOm12/vGG55nYbJC+qBj2inSaSB4zHV4jY
         EzcG4Fv3KSfA1uX9XE3lOwQwhVmJjQeKaDTbbvgnl/i5Lr52Hm272rIZRl00vaFuE1/V
         sgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790243801; x=1790848601;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZIYNgjeCL0OsYc0prVytzssq1ZX8j8EgYAM9VB1jIEI=;
        b=T8ByXw2QclHEyX8UCday20RPxqao+phAxfpRLpE6jqvG4U1l7da2Vf2ir9nBX8irAU
         x6PDlF2rWP3AHgtcXqdQCV6zjTo8iwWCXgl0YS8c33p2ZyNqxaSO+ZAyaH+RLwGH3xRd
         WTAqtYcEuA2744OPWJThM6t5W8+Lz3jjtyB34aKgKXvJbKsMRwAPeUtJowE9kohV8A1r
         XX6UItPFvzMF1om5LF6DRMGdXgWnnzDbdC5rqJuKd0A/dkL0ERwFSzO4RBwvJTEIIqJS
         50FDrS2XF9W24N/8sky9mb/CFB4MBwOKn7OtFM0ckIxMWQ15VWZ0zSR7cbLEmcUgmYrd
         vXDQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/jBCSXP9Ds+DEAN6aLJ/oootKfq6FuB+POtAn/QiV/2SyueJcoXyDzPu8IfIjcaHbj9a3h6g=@vger.kernel.org
X-Gm-Message-State: AFuF++n5EONA8XPLEzqDvCzaOgfISR/3FIpaDmlJb88weYoRuCZfo7Zx
	PQCXD3RczvpMfonEttlw4CmxbheoLRRbxST+iCdMUVt1sop+uq8hZzJggrH7Vo797/dfi4X+GVK
	FsNQJrW3cNOZP1o+13Gva260aDe2KWLQ=
X-Gm-Gg: AYBFou2UmIIFpSn0MdnEBScwnwkFwbFl2CA2WThhdGG/hum1KXsiGdCxvwV059RnAdR
	x7l0/qyBn5RqyIhwvZYB+gFZ9Q/R/qg6LoF8ukjtlMsIYQbcEshjn3FbGCV6eqPULYBi8xDAXn0
	bLTD7s+tOWwl4Hw6qC9qqHgyWqn0tr9dGd/YCuVtqlx7ES3bNR8bRSA+XWlAK3bgT1ZsgrP2DP3
	VrzCn5OZ1pnfnjiQeBDb5+jb73ZuROEKLQ1XjOaTllxX583elerEvmJNrlkPNCVV41rPRTy16yd
	ZGsvLYrZ/Te3tXzcKOo6rhJgj/kAaxT5Qfy30vxFJMJ/zb1aRm3DXBWL
X-Received: by 2002:a05:622a:410:b0:532:d838:12dc with SMTP id
 d75a77b69052e-532fe9eed7fmr14187851cf.3.1790243800860; Thu, 24 Sep 2026
 02:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924095152.3069-1-nsvatoslav515@gmail.com>
In-Reply-To: <20260924095152.3069-1-nsvatoslav515@gmail.com>
From: =?UTF-8?B?0KHQstGP0YLQvtGB0LvQsNCyINCd0ZbQutC+0LvQtdC90LrQvg==?= <nsvatoslav515@gmail.com>
Date: Thu, 24 Sep 2026 12:56:28 +0300
X-Gm-Features: AclHuK83QQU4UjKE_sfTN9cHFKc0YIJOfadhF_smKbWELBPGpi5wSU3S_A9rXeo
Message-ID: <CAJ_tAk7VFvsRk-suqg7-JJHcm=N1kEt9-qgg6sD+u5oAfyB03Q@mail.gmail.com>
Subject: Re: [PATCH net v3] net: e1000: fix warning in iounmap on probe failure
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please drop this version. I accidentally sent this without staging my
local changes.
Sending v4 shortly with the actual code.


=D1=87=D1=82, 24 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 12:52 Svya=
toslav Nikolenko <nsvatoslav515@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> When e1000_probe() fails, the shared error handling ladder attempts to
> iounmap() the hw->ce4100_gbe_mdio_base_virt pointer. If the hardware is
> not a CE4100, this pointer remains uninitialized (NULL). On architectures
> like x86, passing a NULL pointer to iounmap() triggers a WARN_ON_ONCE,
> which is fatal under panic_on_warn.
>
> Fix this by conditionally unmapping the CE4100 MDIO base only if the
> mac_type is e1000_ce4100, matching the exact logic used in e1000_remove()=
.
> The hw->hw_addr iounmap() remains unconditional since it is guaranteed to
> be valid for all error paths reaching the err_sw_init label.
>
> Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dca1ef9e2e234b8d3599b
> Fixes: 13acde8fffc0af ("e1000: Fix the CE4100 bus type for the MDIO/PHY r=
egisters")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
> ---
> v3:
>   - Switched from pointer null-checks to checking hw->mac_type =3D=3D e10=
00_ce4100
>   - Removed redundant check for hw->hw_addr since it cannot be NULL here
>   - Added missing Cc: stable tag and Closes tag
> v2:
>   - Expanded commit message to answer reviewer questions (reproduction de=
tails)
>   - Added appropriate Fixes tags
>   - Added Reviewed-by tag from Aleksandr Loktionov
>
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/=
ethernet/intel/e1000/e1000_main.c
> index d7f5c6f16142..156903089fa6 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -1227,8 +1227,10 @@ static int e1000_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>         kfree(adapter->rx_ring);
>  err_dma:
>  err_sw_init:
> -       iounmap(hw->ce4100_gbe_mdio_base_virt);
> -       iounmap(hw->hw_addr);
> +       if (hw->ce4100_gbe_mdio_base_virt)
> +               iounmap(hw->ce4100_gbe_mdio_base_virt);
> +       if (hw->hw_addr)
> +               iounmap(hw->hw_addr);
>  err_ioremap:
>         disable_dev =3D !test_and_set_bit(__E1000_DISABLED, &adapter->fla=
gs);
>         free_netdev(netdev);
> --
> 2.47.3
>
