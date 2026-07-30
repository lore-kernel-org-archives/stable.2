Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77794519A1
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428060; cv=none; b=i22zMW50RCZlrbCD9+xKNWlFG0qZq+qyF/eCS1rMAGRp6Oxn0N0a5LJK8V5+PQIzwVEnmdFVkbpeUXgAF/wldgmv14/q89O0Db4wRX9/KmcrjSJnLXqBbaGlGqzM9Moj9A3qMCq0UJbnHpXd49QUHpK8z0exuvZHmUMj07SYP+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428060; c=relaxed/simple;
	bh=RI77UXgu1cCbRF+YvSa6vEyphVqioCtWqxxDfmCM7g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDLHHWqo8QqpJzsraHbKtxzFJ2cpnLh8pIZJdmVbYTwAWLpUMUc+g+bGd9qmRfafti1MGt3zYRuv+YD0RZS+dqsg4knLaXx8gcTfrkea9PxeOHqRzoiFC6Ukg42EOz0OyAh2lbaxK642+r0iPChTK+wrUMrPY2wkKv5wcTA54R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPpsBI6r; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mw4Fgzyi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPpsBI6r";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mw4Fgzyi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785428056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+6btDPNM97WzMYH5D23AWn86cOtGDouehBPODye2wE=;
	b=LPpsBI6rGFsXritNlwyU6n2wOVuHWpwBtRen6c8ayCu3cVl6k6Tgj0mNp+ieXN8OSLRipq
	B2+ngPEvJhPZN1hQZmi45Sp+LHErc/7IQvYnnKyKdqQOcrhyxNZYw/s3zCuEMzaLJypyn2
	4uNSxerKneVn2T9oUnGCXPiAz/6MzXU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-A0AGKHI8PVC7qmUq-6p-RQ-1; Thu, 30 Jul 2026 12:14:14 -0400
X-MC-Unique: A0AGKHI8PVC7qmUq-6p-RQ-1
X-Mimecast-MFC-AGG-ID: A0AGKHI8PVC7qmUq-6p-RQ_1785428054
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7fe835353acso37935177b3.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 09:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785428054; x=1786032854; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:content-type:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L+6btDPNM97WzMYH5D23AWn86cOtGDouehBPODye2wE=;
        b=Mw4FgzyiCqpGasbmDCWsA5XFcWK6GSrIjTMi9alLUdeohvL8orGZb3KHFwe/CJ6Dvy
         2ibKoGeVeDzsvA98O3mYup+2KmeDUelGOwlpoz+tTsUMi/CkA5+PN5gWkfxH8e1b3ZH5
         r5iEb22GEqfky76ZokFgvbG2Nkxptvu8wB+aJ2wDHOBjWuTBkwefQ8LJBgGX/qAoIabh
         fi2g2W+CaJVs+YRERdXZcU6JuPgLWw/xexW1oVfpsK4yTeI2XZks2hOWipB0H/TUIa5r
         7WwIBrZ7ESUql1+S+VkAFfMILvBxouUFbZ/sczwtB/gZgO6x6zOc3fTt804crJWXmlBD
         Cj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785428054; x=1786032854;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:content-type:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L+6btDPNM97WzMYH5D23AWn86cOtGDouehBPODye2wE=;
        b=sQynwBUJ/b6X4IlAG0ohZ5QcRPeknRYzXg2U5OfSzv0xDh23fLVJTNPw6479MhKd+x
         InghlfXUV7US2jv0J4KTUrKrImJ6k8KjyygNd1cslKsWPmLv4f6MRijzxzJLBTGxaR1F
         UaCR9HxTkh3+1OWZiCycSBxntjJYpDkVe2gWqPSXZbVx0cX2iQOMP349I9CeU+s4vOAA
         eUbCcFJp65dAhu7psBN7vV5icDpmrZD0oLHla/skYt4GGu0evI+d2DeEYJduRLb6feLS
         Jm4Vcp5TtN6xBZpJfePpBhtATDcuLVFo9pu8rOJFWxa5fRpg3QGxbMCZJesNKUhsQx6t
         fQfw==
X-Forwarded-Encrypted: i=1; AHgh+RoRRAWard8YQou7Xdr4rZuUfhoKhq+x6NsVUd2OBNv/u/ca2ijSvz5BeYu7+Js/yU6TosJI+T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJPqaBeyjgySsEuXJAU7/mX5L+AVrF9CbqdLt+YjsieTDFDLIa
	elqgRFmZASgefqqY4l8XHCzKIRngRbbdHa6NTSVQ8rNFo6xPsFsuYik17nWeIBt2hg9u7/cdLgC
	3umjOjMsX2gaOqpAcjoUXt3uGYlNDJhkBYnsfugtAuvoFocI4TqWSCGUBlQ==
X-Gm-Gg: AR+sD12OvLNllcQ9TXvWSIBqOCP8y3Ok1qlMnSCzvspZf4V6Fi23dnz9c+HgjiB+J3B
	ePHphxljWP2nm8w6lx5rbRvIEs1QnapxUYnIoeMQBZH3WDYs04SK8K9mL8fza9ZURX6d182kyFq
	fbLALxBCs1adIF8EQjU5Pq0GtJ9/mOdnQlR48ZykpcnC4ohzl0nPGoNT2P2UCaLHtX50b+Ljz3R
	ny+KthnUZTfYzuJ0Exd5hKcvTB65XAx98oK8zkGhO7dxUp0SmORnYFc2SwL5WUuEC5KJNX1kbtO
	U3O1eDlD2xBQPn5fR6g3c9CbEwzgl8azHeiFYY10kc2A40guieMckyq2neBen4smEC3d4DKGJNW
	Yu7msnw37IEP205HSHLxyU70B6exStl73h4M=
X-Received: by 2002:a05:690c:c1e:b0:81d:bc5:4624 with SMTP id 00721157ae682-81fb8953397mr23680477b3.25.1785428053873;
        Thu, 30 Jul 2026 09:14:13 -0700 (PDT)
X-Received: by 2002:a05:690c:c1e:b0:81d:bc5:4624 with SMTP id 00721157ae682-81fb8953397mr23680137b3.25.1785428053319;
        Thu, 30 Jul 2026 09:14:13 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8abd480sm12784947b3.36.2026.07.30.09.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:14:12 -0700 (PDT)
Date: Thu, 30 Jul 2026 12:14:10 -0400
From: Brian Masney <bmasney@redhat.com>
To: Akari Tsuyukusa <akkun11.open@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
	stable@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>,
	Miles Chen <miles.chen@mediatek.com>
Subject: Re: [PATCH v2 5/6] clk: mediatek: mt8173: fix memory leak on module
 removal
Message-ID: <amt4UpSfiMwxNTBS@redhat.com>
References: <20260707074839.240676-1-akkun11.open@gmail.com>
 <20260707074839.240676-6-akkun11.open@gmail.com>
 <amjCTJguiANLY0vj@redhat.com>
 <amja9vnEoRTstmGN@buffalo-ssd>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amja9vnEoRTstmGN@buffalo-ssd>
User-Agent: Mutt/2.4.0 (2026-06-19)

Hi Akari,

On Wed, Jul 29, 2026 at 02:02:59AM +0900, Akari Tsuyukusa wrote:
> On Tue, Jul 28, 2026 at 10:53:00AM -0400, Brian Masney wrote:
> > On Tue, Jul 07, 2026 at 04:48:34PM +0900, Akari Tsuyukusa wrote:
> > > clk-mt8173-apmixedsys.c and clk-mt8173-infracfg.c do not call
> > > platform_set_drvdata() during their driver probe callback,
> > > but their remove callback calls platform_get_drvdata().
> > > This results in platform_get_drvdata() returning NULL,
> > > which leads to calling kfree(NULL) in mtk_free_clk_data(NULL).
> > > This leaves clk_data unreleased, causing a memory leak.
> > > 
> > > Fix this by calling platform_set_drvdata() during probe.
> > > 
> > > Fixes: 4c02c9af3cb9 ("clk: mediatek: mt8173: Break down clock drivers and allow module build")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
> > > ---
> > >  drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 2 ++
> > >  drivers/clk/mediatek/clk-mt8173-infracfg.c   | 2 ++
> > >  2 files changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
> > > index d7d416172ab3..65dc4489a09c 100644
> > > --- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
> > > +++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
> > > @@ -179,6 +179,8 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
> > >  	if (r)
> > >  		goto unregister_ref2usb;
> > >  
> > > +	platform_set_drvdata(pdev, clk_data);
> > > +
> > >  	return 0;
> > >  
> > >  unregister_ref2usb:
> > > diff --git a/drivers/clk/mediatek/clk-mt8173-infracfg.c b/drivers/clk/mediatek/clk-mt8173-infracfg.c
> > > index fa2d1d557e04..8b69009e1965 100644
> > > --- a/drivers/clk/mediatek/clk-mt8173-infracfg.c
> > > +++ b/drivers/clk/mediatek/clk-mt8173-infracfg.c
> > > @@ -128,6 +128,8 @@ static int clk_mt8173_infracfg_probe(struct platform_device *pdev)
> > >  	if (r)
> > >  		goto unregister_clk_hw;
> > >  
> > > +	platform_set_drvdata(pdev, clk_data);
> > > +
> > 
> > This patch doesn't compile.
> > 
> >     drivers/clk/mediatek/clk-mt8173-infracfg.c: In function ‘clk_mt8173_infracfg_probe’:
> >     drivers/clk/mediatek/clk-mt8173-infracfg.c:131:36: error: ‘clk_data’ undeclared (first use in this function); did you mean ‘clk_gate’?
> 
> Sorry for sending you a broken patch.
> I accidentally built only with ARCH=arm and missed the build failure.
> 
> While fixing this, I noticed that clk-mt8173-infracfg.c can be converted
> to use mtk_clk_simple_probe()/remove() instead of adding driver-specific
> drvdata handling.
> 
> The helper currently lacks cpumux support, but I have a reviewed patch
> for it:
> https://lore.kernel.org/lkml/20260304181024.738391-2-akkun11.open@gmail.com/
> (Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>)
> 
> Also, adding PLL support to the helper should allow more MediaTek clock
> drivers to use the common probe/remove path:
> https://github.com/TeamYogaBlade2/linux/commit/d991a61887ab76fd83708dffe8e48192e01023d5
> 
> Would it be preferable to extend mtk_clk_simple_probe()/remove() with
> cpumux and PLL support and reorganize this series around it?

Yes, that sounds good.

Brian

