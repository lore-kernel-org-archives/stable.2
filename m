Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793955067;
	b=LVVNooNHyj1ZRo7vcYtRYiDCIHh5c2MbNrttqb6Mvb1OWQbC2r4H1UnoaiqPbe3HWy75
	 HT0EIxzDWkPEptlO4hZeEkvae9fypjY+Kgi087gfqjUObTIzWgLlmuPM3xxn28RC9jqM8
	 D+ZNgvP7oE53R1VdV5V3a1etfgb2JqeqmBgSjsCtMdJpDtiREWbSzptFGVsUusnqeskdS
	 +0vA41ykkwUlfZfT8O9vCJvTzewVL+EfwLKlsBMinSvQlgzphmg2rkhyQ7ZNPtxvwFU4O
	 f110DgtRze5MRzubfyiSBQOgf3EggspPvZhqYgLjQqgU9K/TUM9Trt5F/nu8Sce3tAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955067;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=u683Mp167vRRYMWqRckD1jVWMTr0O+F8yrVQZIo8ll8=;
	b=R+OHKKrNIrGNetP+1P10hE8GZouKo/ESB9fA+FDA8q/RRbv7tTByX6yWyPzkMAzwLvgv
	 IFjAlTjtavaI6tVXCoq9f27rf9mNJrOrQezZC4Lbw5kMbGKEQ1Lh4mAJU84lGVcnQ2PEo
	 KJtWn3FyKUTd84j1y4ZIFMGZSQTTh4yRbo+3hbubDsM5Ukg09y96Krj+Qge6mUEQI7/3r
	 h3RqPmxnGgrkKvkY0v14uhzw0uiVn4I7DyPwo37sG9EXf4YsuneIjKOa62pEsUcskF24y
	 wzWuYnKLRa863evX3Hi6LQxW4NqyH9BCnTRqOx8kAoDoA7oe+b39IRmP14t1QwqFInQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ziyao.cc;
	spf=pass smtp.mailfrom=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=cg9wurH7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A77606A326;
	Fri,  6 Nov 2026 08:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22A77606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=cg9wurH7
ARC-Seal: i=1; a=rsa-sha256; t=1793955022; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=K1sEecgNybdmwlsQxMYevt5CmsQ5ihQPj0LcKrmw9V2q8WhI9b+mH/xemeAoCQRPgjJRtsNIdHcN63pXjW9bfDVn72Bv8De18Mqg1N++SbosmpbO1KruYapOnTjFX3CXXmN8i5Ux2rIQqEJZItqs9SPaLSy1INk6uRe3iPVMMiA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793955022; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=u683Mp167vRRYMWqRckD1jVWMTr0O+F8yrVQZIo8ll8=; 
	b=mg7xe9OEmaB0+oJUjp9z9dzXQ7E1/5tQ1TARRUpwNKr5rTRYfazlcZzgPgkwY4elXLDCreYF7TGw/r7M+EtFAfeTxRo1yAsUQnsZtBd4xxYbM/QC5IBLUdF2ysIh524fEGHSI6hQn7WnLrKxXJzQ8VaX0ojE92TnOet9TBCYWSY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256; b=cg9wurH7f+KD2WoCD5W+v4QLoDmjBS81b79BGy2k4WFlu3/10c0Vyb4upbEllly6vKmjc7iqXCzh+7w0yqnJsOU142b9iCig0GwgUov+B+Y2B8g7TIDGeMUbK9OjWviWi8TLCtXXQ39HfZ/wvnPrV/DrPMfubgQVH1X4qCO1LVo=; c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1; bh=u683Mp167vRRYMWqRckD1jVWMTr0O+F8yrVQZIo8ll8=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793955019916373.169635391934;
	Fri, 6 Nov 2026 00:50:19 -0800 (PST)
Date: Fri, 6 Nov 2026 08:50:06 +0000
From: Yao Zi <me@ziyao.cc>
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>, Yao Zi <me@ziyao.cc>,
	Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Midgy BALON <midgy971@gmail.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Frank Zhang <rmxpzlb@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Kevin Hilman <khilman@linaro.org>, Caesar Wang <wxt@rock-chips.com>,
	Elaine Zhang <zhangqing@rock-chips.com>
Cc: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rockchip@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] pmdomain: rockchip: Don't log when of_clk_get()
 fails with -EPROBE_DEFER
Message-ID: <au2UvnY0CdGTRnum@pie>
References: <20261105001257.1368266-1-me@ziyao.cc>
 <20261105001257.1368266-3-me@ziyao.cc>
 <71b77625-8475-43da-a62b-983cf572229d@auroraos.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71b77625-8475-43da-a62b-983cf572229d@auroraos.dev>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.948.33
X-ZohoMailClient: External

On Thu, Nov 05, 2026 at 11:47:13PM +0300, Sergey Shtylyov wrote:
> Hello!
> 
>    Please consider using --no-git-fallback with scripts/get_maintainer.pl --
> I don't see what do I have to do with this patch (other than fixing another
> bug in this driver earlier).

Thanks for the reminder, I usually enable it but forgot it this time, sorry
for disturbing...

> On 11/5/26 3:12 AM, Yao Zi wrote:
> 
> > Current error handling code considers -EPROBE_DEFER as hard errors,
> > logs misleading dmesg like,
> > 
> > rockchip-pm-domain ff600000.power-management:power-controller: power-domain: failed to get clk at index 0: -517
> > rockchip-pm-domain ff600000.power-management:power-controller: failed to handle node power-domain: -517
> > 
> > Use dev_err_probe() at the callsite of of_clk_get(),
> 
> > and check for -EPROBE_DEFER in places> where its return value could propagate to.
> 
>    To where?

rockchip_pm_add_one_domain, rockchip_pm_add_subdomain, and
rockchip_pm_domain_probe. I think it's obvious in the diff and too
detailed to the commit message, so didn't add them here.

>    And I didn't understand why you couldn't just call dev_err_probe() everywhere --
> the error code seems to always be propagated...

This was what I originally wanted to do, but dev_err_probe() sets the
deferred probe reason, and if we call it several times, the earlier and
more specific messagess ("failed to get clk at index %d") get overridden
by the later and less descriptive ones ("failed to handle subdomain node
%pOFn"), which I think would make it harder to debug.

> > Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain driver")
> > Fixes: 6be05b5ec161 ("soc: rockchip: power-domain: add support for sub-power domains")
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/pmdomain/rockchip/pm-domains.c | 22 +++++++++++++---------
> >  1 file changed, 13 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> > index 34c862e56aad..c147cc88edb1 100644
> > --- a/drivers/pmdomain/rockchip/pm-domains.c
> > +++ b/drivers/pmdomain/rockchip/pm-domains.c
> [...]> @@ -1006,8 +1006,10 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
> > 
> >                 error = rockchip_pm_add_one_domain(pmu, np);
> >                 if (error) {
> > -                       dev_err(pmu->dev, "failed to handle node %pOFn: %d\n",
> > -                               np, error);
> > +                       if (error != -EPROBE_DEFER)
> 
>    Why not just call dev_err_probe() instead?
> 
> > +                               dev_err(pmu->dev,
> > +                                       "failed to handle node %pOFn: %d\n",
> > +                                       np, error);
> >                         return error;
> >                 }
> > 
> > @@ -1102,15 +1104,17 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
> >         for_each_available_child_of_node_scoped(np, node) {
> >                 error = rockchip_pm_add_one_domain(pmu, node);
> >                 if (error) {
> > -                       dev_err(dev, "failed to handle node %pOFn: %d\n",
> > -                               node, error);
> > +                       if (error != -EPROBE_DEFER)
> > +                               dev_err(dev, "failed to handle node %pOFn: %d\n",
> > +                                       node, error);
> >                         goto err_out;
> >                 }
> > 
> >                 error = rockchip_pm_add_subdomain(pmu, node);
> >                 if (error < 0) {
> > -                       dev_err(dev, "failed to handle subdomain node %pOFn: %d\n",
> > -                               node, error);
> > +                       if (error != -EPROBE_DEFER)
> > +                               dev_err(dev, "failed to handle subdomain node %pOFn: %d\n",
> > +                                       node, error);
> >                         goto err_out;
> >                 }
> >         }
> [...]
> 
> MBR, Sergey
> 

Regards,
Yao Zi
