Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793845048;
	b=PcD9idGkEZuKspFdsTvzPBs+Omo7fBBQsDVZFyDNdJ+iG36sMpwhpQfk4rqi78oiWOrS
	 o6l5CiE9twPqaf4lNXi7Vlit3pWIaGgAzuYGOs24HvqZJMWiiSVJsYcGyEjDNaudILy3w
	 GhteeNQ5OQBqLMYjOIt90PuEzE8OoUOMbjkED8xWsHHl8kB06nd7YffQhO8GA773x13oc
	 XaKHprprxhPnOQajUP8+EOnJMtd4LsDX5Yz9yf46e2BvImmZ148SEGthob3CzfTJYggMB
	 UYpfuqBHsJkbF6o1D17fjhIQCLOGyJC/bOustcXwzi6jZ+TVqVQV07rH8uiskkd8pzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845048;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/FWJAoIb9uElG4DB4bUNynw7lCgNggKU5iZJJqwDhh8=;
	b=4cpIN4uOcPmm+xOnTMPvsndIUpF1MpLjYK1mu/JnyLsXet4FsMmIsXU4qr3SCX6uYLIs
	 h0NsKjnUpEhZNReSolDmzj1mP/6Fo7vcCQcgegjVux17YfE2DpJdt5/CHieIrUhfauhlA
	 pEmneaHqCmIqEx6j1ytJOz5OAIROhfVtxjc6EwxA3ZnheOmt/MSstOQKwjb1j7Nc7c/by
	 oeq1y6lyJYZS789l3zIWMfZ/KO7hVpfxyS+6Aff01osqw/e8aXwwD20AQIlv3+DEB+67g
	 LYSyo9rgs/53dLZCrOU4Eh2U2u9k+2Rqc0cLRwfKskqnKvANmDr+++jT7qFsgMkzTHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=EBmXrC5i;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46905606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46905606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=EBmXrC5i
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A980240E0299;
	Thu,  5 Nov 2026 02:17:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ux4-rOmZKd3P; Thu,  5 Nov 2026 02:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793845040; bh=/FWJAoIb9uElG4DB4bUNynw7lCgNggKU5iZJJqwDhh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EBmXrC5ilV2vgaQ/7Fz9xX4AIaXopt3zqHgRj7VRIwApQd73B8b+DkDcWHTpp/nVP
	 ayXvlJMKyxRuIcXFlTOV8mLtu93HMu53f6WajupyqxWvxMn5dJx/MPbs2un6wUijTe
	 FVKdOG3wkYwd4Nk6HJloV6Ta63+KB/qWEtVZcQa3X6qHO3EWdOSfOq4FFn04A78lG+
	 aG+tQbWxLc7HxPEwoTpQCyshzs6lgd4L6QuU35eLuoO4HxGBrUdAbFXXA1A0B7N7IO
	 UVrILVv9bkafC/H/wgsHNzomzhmeGfMrLH/aTdDdANHmF845T8CdxTBElxnpvgyArG
	 htq5qszKHb2lkfVVVvV+nJj7r4bECTyDYsesivQG+xIGsP9Ujx9So6Gb9iB0TVTlTN
	 OZxAed1TcxOB4NHDiAVTecxIahwRB9mEFl24iy6umgFro2Vl1oq8vLLBGs7qz8sv8A
	 CR6qd0hpqLiYF0+X9ybYGLF0V4iFMOvaW1Hkv0jwqctyttHLIsMmYOM+4OxOxzm4/4
	 Cpk1NoW4Jd80VhUap0lFFriWn8nTX9lGCUilE5ePEnmAWHzDtyRRpASFH9Dix3DAl0
	 CnR42SHdvULpN+HCgjxipuY0g64ArfPsSx7VHu2ayuAeM4y+pzOxtJ/HOoeIvaVTBa
	 G5w7j8fksgvRIXn6WxG2ZgbA=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1FC7D40E0140;
	Thu,  5 Nov 2026 02:17:16 +0000 (UTC)
Date: Wed, 4 Nov 2026 18:17:14 -0800
From: Borislav Petkov <bp@alien8.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "S Shaiju (AMD)" <sshaiju.lkml@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 6.18] x86/bugs: Adapt SRSO mitigation to Zen6
Message-ID: <20261105021714.GFauvnKiFQ6WljaPBj@fat_crate.local>
References: <20261103182143.27403-1-sshaiju.lkml@gmail.com>
 <2026110405-exporter-surfacing-9624@gregkh>
 <A286426C-2D2B-4CC2-B113-7212B62CB03F@alien8.de>
 <2026110456-greeter-reconvene-ad9e@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026110456-greeter-reconvene-ad9e@gregkh>

On Wed, Nov 04, 2026 at 04:19:06PM -0500, Greg KH wrote:
> > Ah, thanks. You guys are opening and closing non-LTS branches waay to fast for me :-)
> 
> 7.3 will be LTS :)

LOL, I don't wanna play anymore!

:-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
