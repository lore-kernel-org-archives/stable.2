Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ADC39B97F
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258185; cv=none; b=kvPGZB5RJgcBIVo1ORk/7Au83Csd9Pq9EIHw6PZPTBoizFUJ9jzkk7FfF6dVnh7drl7JOIiMv96hof0gWJJ67AZmE0ZXMlX1/hesO6zH//fstJTHZFWKNhMGSAynX3XnTWx1X19UbsrVobx3H9RCHy5eUjBft5x+fE4kcW9xUM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258185; c=relaxed/simple;
	bh=THe/MCYOUCFl3gSUIjbQcNbN3jTDUYeawApb6k2z2BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQixLf4b8hfNb4P7QJK89oVs/FWATkPtHGWlDz9809iKVcJ8VMZJuagxhjRhlBB5YLGaX6Z5V61VxVv52vvicCz8rEwL0RKR0yBT+Ow0oFxJiPizYepGvy54RZzJ2LpheMb1rgzSke8pm/ILYndCvXJDcznzOyPaS7tFno7ByjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfXsxd98; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfXsxd98"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cad4170e8eso1576585ad.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785258183; x=1785862983; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H9tbT3MmTWZadkFYtLmnXOyq2+XHjhkh1A8FrJjDKXM=;
        b=HfXsxd98gAl6vHmkHPb/Qn0em6GKopn1H6G6vOAkyCgQjgzqhfIMxBthvDfrwzwPFx
         oMtkcSPNA89WvOvgGmLXNE6mJcjX3mhvGBAbLDKiLnRkH+llyaw1qi8qzt+bAtY+bmaz
         CM/kAJFuwcyacqZz7cY1SadJ9qy5ds9hBxABX8H8YQQzgT0RPtHg02E6sF5xg6NX9Qkg
         0DwYL70AG3u3Te29FFqe5lD+/f2zJXUCyDfoy+Pp1V7ZZoho0CFiWhqy0dxfoID6BkS0
         lqDhJQGr9YFoQF4ZSzkVD4NWxDrf1AG5hpoRb+sRdvrLd63KWij1y5CWY29V3mpdlBgE
         6OSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785258183; x=1785862983;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H9tbT3MmTWZadkFYtLmnXOyq2+XHjhkh1A8FrJjDKXM=;
        b=Jj3F0yPHUmyk4/WxOqRARzRub97AREa3vKjWI+Pb5x2+AgaWJTEudqrlTChPsVZSj3
         zM9eoXRbeK2Ft/ZkGKm3him14ZO7krpGwc35/U8GXuSkem3UJ/+Y95P/WQ5uwm/dpsUt
         iNsJyx+y0pCabXydSmAnfr/0P8lm86L6U2sd50JqAakIczvvcl6J5uXw9OOzbQyHLDRa
         UTzFLQwpYTo3/XSaWiqnc5GXk+WpfZyPMQeMADWoCkW17CKh0SBIvKHpcXrN4gHarS8i
         VpaNK65ddQMYve9KVJ5pwcMNBMxeWYZOH3vMyy8EkvgTM+dteEuiZ94SGS8uf12TMyVu
         wbhg==
X-Forwarded-Encrypted: i=1; AHgh+RrMicrZVlDT0SjURDyoNwF+IDcXiW+nOsWvEp4PgbkABX4NEKnFP5B5ctXC3Xid/AibEAxCS3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV3DhO1nG/FV9Zhnpz/nDFHMhte6tWMZrYMuhMapQq9mMPIUzB
	5G9EvVPS1o8h1Y4J3/JTTi6mAxQUqXlsYgW4vpk38UMcDrrGkxZw4Ss4
X-Gm-Gg: AR+sD11bpvpd8ojs3k/r6Gj/fd+mpIYsiGOt/ATgwHyCNB92C25HYy5GatHhGU0KBRr
	X5g6+4m7x3mgWkBM+PeNTEWGESfHlcPGTbwpeF8/H8iNh+lVsh74kfgTbD6rtT5DXKqwI8uf/OX
	DoqzI23JJ4Y29sPiEMzdLNlgLVpJDnBxjaobHA+UsC1vN5K7VulCR+jz6YIpSYRKFiiK8Z/RnHp
	uLTyKg1OOrrkivk8UTKTzaYqYsgLnvqV4c6vRKs6Ha8i9HiHWTOdaqkE9POsSBwfPdb9sidBXdP
	R5cqrgKcS93B+jYwcbdJny6C12DbF88zf++dq0kaSDtAqnVDWBH3ZtBzak3lReMl5FpyBt0AEZ4
	Ek5Vz+AMlqnkepJ6F8R/gQ1P0XDYj2wt6xX4xGEhg3Qcy58bbyy5TaywIjHszsqEWHgRZ18YuMo
	I8FLdWaX1OqmPDHeABPEQcdvRMh1nrjoCkog==
X-Received: by 2002:a17:90a:dfc7:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-38f6a33d8c3mr3853027a91.8.1785258183046;
        Tue, 28 Jul 2026 10:03:03 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f64111441sm1667127a91.1.2026.07.28.10.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 10:03:02 -0700 (PDT)
Date: Wed, 29 Jul 2026 02:02:59 +0900
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, stable@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>, 
	Miles Chen <miles.chen@mediatek.com>
Subject: Re: [PATCH v2 5/6] clk: mediatek: mt8173: fix memory leak on module
 removal
Message-ID: <amja9vnEoRTstmGN@buffalo-ssd>
References: <20260707074839.240676-1-akkun11.open@gmail.com>
 <20260707074839.240676-6-akkun11.open@gmail.com>
 <amjCTJguiANLY0vj@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amjCTJguiANLY0vj@redhat.com>

Hi Brian,

On Tue, Jul 28, 2026 at 10:53:00AM -0400, Brian Masney wrote:
> On Tue, Jul 07, 2026 at 04:48:34PM +0900, Akari Tsuyukusa wrote:
> > clk-mt8173-apmixedsys.c and clk-mt8173-infracfg.c do not call
> > platform_set_drvdata() during their driver probe callback,
> > but their remove callback calls platform_get_drvdata().
> > This results in platform_get_drvdata() returning NULL,
> > which leads to calling kfree(NULL) in mtk_free_clk_data(NULL).
> > This leaves clk_data unreleased, causing a memory leak.
> > 
> > Fix this by calling platform_set_drvdata() during probe.
> > 
> > Fixes: 4c02c9af3cb9 ("clk: mediatek: mt8173: Break down clock drivers and allow module build")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
> > ---
> >  drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 2 ++
> >  drivers/clk/mediatek/clk-mt8173-infracfg.c   | 2 ++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
> > index d7d416172ab3..65dc4489a09c 100644
> > --- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
> > +++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
> > @@ -179,6 +179,8 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
> >  	if (r)
> >  		goto unregister_ref2usb;
> >  
> > +	platform_set_drvdata(pdev, clk_data);
> > +
> >  	return 0;
> >  
> >  unregister_ref2usb:
> > diff --git a/drivers/clk/mediatek/clk-mt8173-infracfg.c b/drivers/clk/mediatek/clk-mt8173-infracfg.c
> > index fa2d1d557e04..8b69009e1965 100644
> > --- a/drivers/clk/mediatek/clk-mt8173-infracfg.c
> > +++ b/drivers/clk/mediatek/clk-mt8173-infracfg.c
> > @@ -128,6 +128,8 @@ static int clk_mt8173_infracfg_probe(struct platform_device *pdev)
> >  	if (r)
> >  		goto unregister_clk_hw;
> >  
> > +	platform_set_drvdata(pdev, clk_data);
> > +
> 
> This patch doesn't compile.
> 
>     drivers/clk/mediatek/clk-mt8173-infracfg.c: In function ‘clk_mt8173_infracfg_probe’:
>     drivers/clk/mediatek/clk-mt8173-infracfg.c:131:36: error: ‘clk_data’ undeclared (first use in this function); did you mean ‘clk_gate’?

Sorry for sending you a broken patch.
I accidentally built only with ARCH=arm and missed the build failure.

While fixing this, I noticed that clk-mt8173-infracfg.c can be converted
to use mtk_clk_simple_probe()/remove() instead of adding driver-specific
drvdata handling.

The helper currently lacks cpumux support, but I have a reviewed patch
for it:
https://lore.kernel.org/lkml/20260304181024.738391-2-akkun11.open@gmail.com/
(Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>)

Also, adding PLL support to the helper should allow more MediaTek clock
drivers to use the common probe/remove path:
https://github.com/TeamYogaBlade2/linux/commit/d991a61887ab76fd83708dffe8e48192e01023d5

Would it be preferable to extend mtk_clk_simple_probe()/remove() with
cpumux and PLL support and reorganize this series around it?
or should I keep this series focused on the current simple fixes?

Best Regards,
Akari
