Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1460E2D94B5;
	Mon,  6 Jul 2026 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345981; cv=none; b=S04Oxz0/hB6uUDdcnu2nV2kiMoiefbVDLNZfZvLL7coUubZQS9rMPgCHfP1RhDPGMUUJYtit0pRmZ3+PulbVJuAbW/FDrvEs4O4Vv/1E4oQlFJ+5VJKIO1Z72/Yit8Z9F8qebW3FCjxwZrxh+1ImuhwXLaNgXfMCrtWz6KQkWm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345981; c=relaxed/simple;
	bh=X9u2Yb++bPGtSX8B8ceMfGalDUd/9dCI2PW/K2HBQ5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWuqnL5v6AnOIW/wfDHeiGSFRI9mXy67MQ9kJ9CkmHSkuZqUtYKKSeh+qHIOzgmhW8hZl1FyZ++9oKMc6NbOBLlCaPRdelx3ow3F7z/Yh9D+LeE+jF/EH3MCQlEcBV1KDWBLQ/PinnGgQuv7jw+Xt39D8ai3zcEiAnjUyKFZ6Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=HfcBssDi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BU+yYIMj; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="HfcBssDi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BU+yYIMj"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 23EEB1D00131;
	Mon,  6 Jul 2026 09:52:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 06 Jul 2026 09:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783345977; x=
	1783432377; bh=ri7UpKBxtxOWBJ5q0RP7VJp2qNGzQPVzz7f6EvwhtRM=; b=H
	fcBssDiLO9kMJ0PsCumgPMzDr9w/vRnZVf8SBnRA1BUMSBFRr+skIJtBhpE9d4Qj
	r90s8dnYUlWHrBAFgKBu3tjjEGcnaMBgXw1sXQRfErNiUExe4b2/R1ZF4m4Jdh10
	8s9tf1slzgnrOx9W17f7uaWEMMprUeE3QC71VlxmAGi6eADqy5WSIEUhaup/kNnJ
	NbaIY4J6r2MWpmRHiQYvOGSwNi1iU66rUYXXRJH8tZH59i/pzSY/7yppFGgk7IyY
	xkS3jJWVe/AIZGITOVkmirhhnIgOWctYtcbrO1+r6ycdZNOvSkH7OfFVCx8Ra2BF
	JmUjV9K+HGZUfXgV3sXWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783345977; x=1783432377; bh=ri7UpKBxtxOWBJ5q0RP7VJp2qNGzQPVzz7f
	6EvwhtRM=; b=BU+yYIMjEnVPhMPVw1WHDvrVPOc9UIxfpkjmTFbT3lS/ZpyvQ3U
	MiPuxyJDS0bBDd/1Xv1fnPPWtgMWBuK7j/Hep6Bvhs4CzC1CAxATVr/UKnvVLIVu
	FT6h87rb+pqEpDmC41h6rlMEQ6+IFg+gQ18543kwqDJyuaqBaD4uZsUn2FhPMqZo
	pWN4cm3MQm9V9iSET0VHLQYCBSdF+n+BarKgdg9l5bBlctBRuZZuIb+zJOxqELZ+
	2ObDC3aURdsXGuYPEOStRl8CHvpjBdWmJrAws/Ok2NvxYdr+XWcgeVXzCzobD0qn
	Tqi+URVb2eILPEm1sjYraw9WhagEYhu732Q==
X-ME-Sender: <xms:OLNLaq8tbEqgbBz9iaPlYzj-JCM6qchgi8rKhUp_7ZmqPIhfkJvhXg>
    <xme:OLNLas-xPL8hs5SkZwAwmf05SY9fpaNxqjRc5PklXBNvyCIudAzoqlD_id2dH5pJg
    gSL2T-n9Ft-Wlun0fWWAkLyi2jCe736h5DVNiLmZU3huevJjU2Oins>
X-ME-Received: <xmr:OLNLaiSLr0ziU1DYfWIszelmRgDoY4SfaGteOWCgPwGj-VmLpBpJ0EAowLk>
X-ME-Proxy-Cause: dmFkZTGjbR1FjwQurhhE+qJKgDg+cwJc/ciwGMB482qq+sWBS4ugETC1jqfQwy6dShhfRF
    m+pOfGxPIri0E6YtbhLutPfjLPxQnbSxv7ZFRvpE8iqx2tkhxUzEQFl48+qoIvznz2lV07
    6YDFzQu1iKWTtC7QfZDNpreij/q6BtaMOrg9T3AxNtFREEuOi6GPUyMWZm/OkqyAgVCo8v
    fSfu8XQCouBZ8+DOQksyqWhmMulco3RPLVqYFA2TdXN/28n8/7fGi3esqYMOugts+biltt
    7sf6/XaNpo5tjGIdnvLsZry8aauADQ4JLlLsydKPssBIQySAtua/pKZFh4iBEGbTBGHkgs
    jHjPS/jETresIncZLvtuK0G4vewb4AFMJlmSoX6y/eSFAQZwsp8Gc/V8m5+CWgi5uwblp5
    i+p0mmq3Ybf5S8Jv4CY47qL9OQ3H60yDhDoDXSZBynwhhMI8T4/NuFDYTY+I1XIwNnM3Z1
    PVG7Mvejr/0xHJNfIEW0e8apxIcLZynQuvdZ8H2TaV/PW9zL1uhlY6dnvfs/JgLyoyntsJ
    Rq5fNPVqQlOyTn0gcwPJSuOgkouJNHIC9cx14jT2LjmWGdWAIrwKxT5icJbbJrsAfcolyM
    tjkJ8J4m5vPNLmmmC9taKQ0D3BLheTB8YGaAo0Q1VNJBg/n9Qf64fktv/Gwg
X-ME-Proxy: <xmx:OLNLaocEoGmynKA4GAw-SABN_nCcYxcoaKH8mRrkvDyS04zpvB3xiQ>
    <xmx:OLNLauALXEPI-ItpcbUUezjRVyZZQ_yM0qKzi-Is44PdLdJfXdfcjg>
    <xmx:OLNLaimuqeU4xAEXLmUCdqzLEMgnvufaamDqa8Zn7fzuecgMrHIKeQ>
    <xmx:OLNLahdZXstHwcYGa0sqDNq-uHqMcS7AqrslfoRznMcih1-sxw_2Cg>
    <xmx:ObNLahCnjG2hY9Wt8gxc07Jhb34-8HpuaBDOaeKnV1jd2PZwidWLCNAe>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 09:52:56 -0400 (EDT)
Date: Mon, 6 Jul 2026 15:52:54 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, stable@vger.kernel.org,
	zdi-disclosures@trendmicro.com
Subject: Re: [PATCH ipsec] xfrm: espintcp: fix UAF during close
Message-ID: <akuzNohOorXU3RyA@krikkit>
References: <50e2ab4348eb8177581058f0152394cfae6a8d27.1783071494.git.sd@queasysnail.net>
 <akfkd_1yI_G4cVoc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akfkd_1yI_G4cVoc@gmail.com>

2026-07-03, 09:36:42 -0700, Breno Leitao wrote:
> Hello Sabrina,
> 
> On Fri, Jul 03, 2026 at 04:21:12PM +0200, Sabrina Dubroca wrote:
> > diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
> > index 374e1b964438..f09b5dd85db8 100644
> > --- a/net/xfrm/espintcp.c
> > +++ b/net/xfrm/espintcp.c
> > @@ -517,6 +517,8 @@ static void espintcp_close(struct sock *sk, long timeout)
> >  	sk->sk_prot = &tcp_prot;
> >  	barrier();
> >  
> > +	synchronize_rcu();
> 
> I've got the impression netdev usually prefers synchronize_net() instead
> of synchornize_rcu(). Is there any reason for synchronize_net() not
> being used here?

I don't think it makes sense here. We're not holding RTNL (those are
just basic userspace TCP sockets), and we're not on the netns exit
path.

> Also, given you have a explicit synchronize_rcu() here, should the
> barrier() above be dropped?

Ok, I can clean that up in v2.

-- 
Sabrina
