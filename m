Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567202;
	b=ypTGtgbyxaYheuURbXS0xFX5Vfnydtf2XXZCVvC80wH2LYRLigloUTrwwpSQ20HVrr17
	 VuQZq3NxZ/DHBjpruwuOuds05sSVT6tYkCxomkfBGhTXgnlFssnZMdfjD11oyfvOoFgmf
	 sPLbdit3K2x6PAZfJdTgHrKYM3v8KyRacVCZFF8jg7aDMFXNMYcshVH0QyE5ex2OR5si7
	 W73H/Uw2AE/G1jwqmLkMwTv2tCYmEaeaiftR0IXhcnLUo9ioBsVlmlZZ7M9KZ0+PciGg7
	 WECuLxh+gD1/mAzdeU3MvE0BHVAl/NPW5I5dv2NZPD8wRyW+0ddvtNQDFxQj3bgdadA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567202;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy;
	bh=G4uEKZRwUfb5zvd/yMth27AlEvMkO2zJDK4qdfnK/fc=;
	b=BUQTKceTF43zt0PcujPBTtt/pB9wqFslBA1dl58TgfukIYWtWDqgM33xRXgtQMtyGvID
	 rUfn0586Ee+pvUkW+QVkItRLGRbxXiRfTlGAITQXck0VmWE3xO6A4sHLAggi4EJG+aeUM
	 cF/94iQqwKsVHUrmUR/HBzDD+d5nWzzg68+/swKjhWhYECympmPQsHtFXsWxLW3PWibKO
	 7eUoKtAl/wLU6PpQjC1MP68L160Hk7wbfPn3HZcRT/fSeUH2SNGDK9eRcGd2oadEt+1su
	 3+Qnr6hrPPrlN/OR3+n9uusv79EmEJ3+AHzhwHt2z6tKsDuV3BoxtPplsqTO+stdz+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=CcsiSJnE;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC866606A8B9;
	Fri, 13 Nov 2026 10:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC866606A8B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=CcsiSJnE
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A326C208BB;
	Fri, 13 Nov 2026 11:53:14 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lhe_RJqkQRYP; Fri, 13 Nov 2026 11:53:13 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A5D11208A5;
	Fri, 13 Nov 2026 11:53:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A5D11208A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1794567193;
	bh=G4uEKZRwUfb5zvd/yMth27AlEvMkO2zJDK4qdfnK/fc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=CcsiSJnEutChhlxtaqO8Y0vnf8Gwp+NMl72TqQu/RsLOUeZTAPL7VZJt97Cpls2HZ
	 PgRHZme/RzV05+AeykbuWQgcyKCtcKUvuGwNBrNrczYxxx8zHrWGsT0BzSAtVIU858
	 nLCExdnZubTnQVVZq5YK+Pq596pra9S0nt8ct3upfXmM+EHA1s2rZW8k+wtOaJbiTX
	 u/oIE9bdKAbop0Wu2+m3/GVnDIM3xkVhjh63w5vgZJ0diukr/+4zN8VPJh+vU47Oya
	 hovgZUscAzI8JkHue7bq08Gwtl5ZcQDV0keyF0sFL74RIv2t0b50rKWtq/ratW6tP+
	 wCUVA48j9Ffig==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 13 Nov
 2026 11:53:12 +0100
Received: (nullmailer pid 60005 invoked by uid 1000);
	Fri, 13 Nov 2026 10:53:11 -0000
Date: Fri, 13 Nov 2026 11:53:11 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: =?iso-8859-1?B?Suly6W15?= Jean <jeremy.jean@oss.cyber.gouv.fr>
CC: Florian Westphal <fw@strlen.de>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v4 2/2] xfrm: fix selector matching for IPv6 atomic
 fragments
Message-ID: <avbsF2Fmc2G4Nztg@gauss4>
References: <20261109213803.1785516-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261109213803.1785516-6-Jeremy.Jean@oss.cyber.gouv.fr>
 <avW9OrfvkAF99uP_@strlen.de>
 <4231ca089dfd7e7ec42d85f9e72ac535@oss.cyber.gouv.fr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4231ca089dfd7e7ec42d85f9e72ac535@oss.cyber.gouv.fr>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Nov 12, 2026 at 02:33:35PM +0100, Jérémy Jean wrote:
> On 2026-11-12 14:20, Florian Westphal wrote:
> > Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr> wrote:
> > > +		if ((flkeys.control.flags & FLOW_DIS_IS_FRAGMENT) &&
> > > +		    ipv6_find_hdr(skb, &offset, -1, NULL, &fh_flags) >= 0 &&
> > > +		    (fh_flags & IP6_FH_F_FRAG) &&
> > > +		    !(fh_flags & IP6_FH_F_NON_ATOMIC)) {
> > 
> > Since you need to send a new version anyway, maybe avoid
> > double-neg, i.e.: (fh_flags & IP6_FH_F_ATOMIC) ?
> 
> Thanks for the advice, I will consider this for the next iteration.

When resending, please make sure to also Cc the new ipsec mailing list
so that the ipsec patchwork can track it:

ipsec@lists.linux.dev

Thanks!
