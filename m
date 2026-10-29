Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312638;
	b=m0ur2kVbThocXS/lIjkPgqvpoWR4qBP7WfVqe5Yn5+eTpH5kFG4yMMMFGxOKNIl7lLra
	 cIDWCMoeR+ns2UoosCTKB6yEfiXr0inrfnYdEsWQzejmnT2FXyfIDFeFtgBKvGvH9wEl4
	 0zgztF06C+6OkSp/HiUB3QzsqX3q8AfTVc2EXzd0DNan3TL7Opc/aK4HOdcGAajO40GEA
	 ofsgGBT/R7rbqBJC9GClmD28N6yhnJEXFiS8Boi5fhADJ1J9hwx26LNaYJlgcfRcEI1Xl
	 ffts0YcOGPkHYQ+nfKDKwhN/HLnhttJ4+DLG3R3kY6WAUfvIKrk0HBEDj6rZej3sm7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312638;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=3kiZulZmsMW30AFctFkvQQNZ5K7UBvVZ9vKgq36uOxM=;
	b=LoxFz3L6Awn9kWqDbwKHfCKDvHM/iI2QkQKU+JSTcrNqMNCQFjohwStk38i9PdIOaQFL
	 oYwYa8O4kKgyIHprj000chdNfTV3c+yoUyeGoNfHMgOqXvhWvpWaqr0DysbwsaXV71uj6
	 O2RyVCZvfr+4QPHYhjBlCpWQNpQjSSOhK3vKw0CHiW9QriCtJ2F2bw7vy4o5/g6qP8Zwh
	 +zImZuMc1m351VAd3DkGpXRRFGfJWCybmyxhXpayiTodttWp64NHziV0pRvk8zIwshXeV
	 ZxPHS5oinyZE3nEMH2KoYBky5WXUySjSaa4t9A+bXarz5dFASNSIPBeo3hsO7qTp5fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=seanlyon.dev;
	spf=pass smtp.mailfrom=seanlyon.dev;
	dkim=temperror header.d=seanlyon.dev header.i=@seanlyon.dev header.a=rsa-sha256 header.s=fm1 header.b=ock8aaYD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kChEqgEW;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419E0606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 22:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 419E0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=seanlyon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seanlyon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=seanlyon.dev header.i=@seanlyon.dev header.a=rsa-sha256 header.s=fm1 header.b=ock8aaYD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kChEqgEW
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6CC11EC017A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:23:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 29 Oct 2026 18:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seanlyon.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793312626; x=1793399026; bh=3kiZulZmsM
	W30AFctFkvQQNZ5K7UBvVZ9vKgq36uOxM=; b=ock8aaYDfNTFGCndeRQENHS+Ho
	D+8Wmgv97Y1Y7DCGbcy0RQWJwzTSzWSP8cDvR8WoIOYnwqb+dRAZ+7vghVs6kjnp
	8G0o5uOLTNZ2d7O+DIFRHivI0LfCSP4LsP2V+ESUaCi/uefQAXa9Q+wgIPace7Qx
	+pJ2qRPVzWhbGtl05GSiY1Ygf5csV1mbOqYcTvVNZvz37JTnOOhQC6s8WtltDoxl
	Q9ysensTNiXtXH6s0zs5jypnoo5dR+vzAu8XCzbsccBQilCAxpB5k3CD2DRqiiri
	oAtvswxTdm7pAS+3o44OF/Jkhe+WYIPgCys7NSfppP7jNjEKYnjlf4Xg8xwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793312626; x=1793399026; bh=3kiZulZmsMW30AFctFkvQQNZ5K7UBvVZ9vK
	gq36uOxM=; b=kChEqgEWN6+UGUa5muOA5cxzbrmZ3vdwpSMrWUc9HFziAooUMPc
	/grfLraOrO2btwbhnmw1c0tJAK4elR0jqdTt1CJcWULxutCrV610mASTUjUTRZwD
	8VnTuELeZJ2UteAFD8/HdMFE37U86GoTIcQU2ycZ8FXyaD4M+hBuZefeEpreTXtx
	1b933Ls/6uP1sGRNnapfq/Y7/URGX99dKOSEzyLKklA82TnlbSqfRLXez4Wb7F6h
	r962hk8f9edR+YC3VWCqJwQ5BAGSMSGVA30Gu2jqO2/GkisgQenbYjukfkqZztVJ
	s1XT198CwzetWah5Cl3t+79ZHYU8M057emw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=seanlyon.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793312626; d=seanlyon.dev;
	mf=PHNlYW5Ac2Vhbmx5b24uZGV2Pg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:v74+P4d2Yep5RDBjq2sRzkYwxdgwZ02W0yWmSl8XvNI+jYl
	gU6hMJkdrBFIlcNpjNzWwWIhBA/iraZM7YGcknyYoe1BastSTFATv2NeFhm22ONU
	d5MoTffIJrsoo0Z022MJVN3J6b6BdLHpdQi30CLUXeGDyyeyYemG2E+GMyqCFFG0
	UhWyneauH5L6CMHgM4AqEEsCEz/sO1c6uJmYpN90jgrHXhRNDsaX8tUq+EYK5ysJ
	JD3FLWIhuWoZRGsJU5s6IPuvsuvUDBLXUH3gAot8D6YteqrPsT9FlkqJXQsNWBVa
	WYPoYjT1m/Taqs20yZOA6GXTNoTEaAobpu7Fymg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:GzoDna3Fq6+crKYNj7BIe6kIAovVHOhT+X4UWWxtcPs=:UGJq2selnKm3jmH0h6j35mWKm0O2jeSQKvSZ4gQ9qzg=;
X-ME-Sender: <xms:ccfjahRjiyZu8F9m2suNjBFlF0DilQadZpzZRFK-dgW1X03Df-swdQ>
    <xme:ccfjamp20C5M29AlFR01yaVpsNXIO8bNc9uzN10bgVdjEmgiVZ-cDKt0mhGX8CVvF
    Q2k_mhmiZD98xGcFsyIaHCfH960IJzpbDtiCFTKR93Z98CMJc2OLjj8>
X-ME-Received: <xmr:ccfjaiWO8Vf3mc9pvrojwp3BjEA8wdyJ0Y1YgT0kjNnVV-kR0ZvP8syzS6L-cR85cxPt31p20CFR1lso9EFMxI7fu48>
X-ME-Proxy-Cause: dmFkZTEsMFK4+tEdeywpm1S+ggPFr2a5W3qul9TABGbQw3zx9wuVbpnBWg8DlbilZqRshp
    WklaP9mfBkypsFNTF3l5tUe3kyADfhQ8Ad+sx4bYD6v3lnZnfRvbRGMrOZO4mivMBWpZ1D
    KXi04N47mjESyF1Gh7PT3h7cYn90qSIFiTXhLqHujfQwK5+htDtdwcGZK1lyotxEUqauER
    Vrt0ZBHj33iY6qbvecKnlmxUoQr3xBR0IXHAv9N8OZUP+pVZB8Uc1aEQb6tCsiMZjDLukn
    EPa07eMNCmvYS9nb4g66l1HcGw9Zw8AOphnvjAIslajx32TbGGo1AMohozDjtW8zwPtNJe
    buDEzv0uzBaxc+Wlidk28w5uxRlOoXNXgxpc3hSP0mP0qKMbHMZXVZg3aqPxT6NfLQtn14
    fOYZUH2Desg21+SWlr73FzRLXgW86iGD2kTSZEiFYnBsZ2atNRBvisFVW/+gPT+J6guH1B
    CLZPGus2vRHeGNa26mJAlBSy3vpLx5/iA1nWt3DnVkYnSUmd5kOk4AUmvm6n5ybqImFEMx
    TQCWCBsI9ThE0ncGJopXzGTWTRTI5lwBHJAeMJhhDydMoSCnbcwniAPYQ4pIxkZ2auadTJ
    hlNL1V7Ie+ztbcZfDGHtpNH7ts7QCJxNZLhzz8VzQd+ohLSb+gZsIgbyHwsQ
X-ME-Proxy: <xmx:ccfjas-tHeusEU3hwJWqjzR01dm1PWdwy3NSoDyaP6eSPCpBhqMj3g>
    <xmx:ccfjaia0Cv5Nb-b5BAR2iOeafACodHZBF5WMgZ-ymHraLjQR259lIw>
    <xmx:ccfjasduzI9TAGso-Fb9KIaD_y-k1g5hFsm1mfHFS8zlyiIG7XWvew>
    <xmx:ccfjakoW0KBxWY-SevK3AVmGExypzSFDrt7gYucKNJV0BjdjmY6chw>
    <xmx:csfjaoGmCQThLF5cpOt4oSmPfZXzHI2qp5Qk0CTMs8dqZ6_NxJaovsWL>
Feedback-ID: i07c64b5b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 18:23:45 -0400 (EDT)
Date: Thu, 29 Oct 2026 18:23:44 -0400
From: Sean Lyon <sean@seanlyon.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/247] 6.12.115-rc1 review
Message-ID: <auPHcDLRykuYd3ni@ncase>
References: <20261028165947.349197979@linuxfoundation.org>
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
In-Reply-To: <20261028165947.349197979@linuxfoundation.org>

On Wed, Oct 28, 2026 at 05:56:43PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.115 release.
> There are 247 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Built, booted, and tested on hardware for x86_64:

- Intel N100

No regressions found.

Tested-by: Sean Lyon <sean@seanlyon.dev>

Thanks!
Sean
