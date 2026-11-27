Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795766718;
	b=OgSfeEbqe+KMhvxLjxjHS2wNSLQYaBkILA1+EGve0udiTGOfifjwbSy28gvA0HxxLCYV
	 DCK9p1szYKxP2ipMycv+cC3iORP4GD+Y8vZnmTn6ZH4NqrpOUhd4JduVemKgWVhgi2z8/
	 di73C6ZU0poVrBfa7f3F3uBsxeU3owCcExX/TOzhza8p3Ke3RRd+bL3at31mQtmus8WW3
	 rORxTc2B7txRsL4TQ47sJICoquCFMPDz7VMdhf1/Ph0N63TRWz8rKoziJLW1ms5CQqm9a
	 uJ/GWsBPGSf9wR3hEJrhsLyxn2GVHSJjIZ7qR2ROvmxlwPG4y5XVdOu5bPVL9SlGPdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766718;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=bwe/UjGyShc26iKofLMVW5svfGCRRls1wB4gxHcz7YY=;
	b=NTHMiHdVkazMt/D07lNXoJHSSI9gb6sbpggUPOBaGaFAF/cQN3xeYeKLyCq76xxsgM6r
	 JtNa3NYkB27c98A+s5NlSWJFKqBZ1b4OGi2ofBkXB3psG4gyUh6TYHEWS/6M7koE8ZcF0
	 i0htPsgeNBu9JRHklE+Ktk/0YAZrbEoshLtYlb0mewqU+/1GN29yDLBSw/ZhV1q9rUvYW
	 EmrjCbmqUmaHvY0aCInflOf6FK4m5bSnRCBjWZEfP37G2BSKyIehrY2BrO7BDpSvN4Pwp
	 5CcFWCNiI3TnPBmyenJnnXs8qwU6EKvQ3Z6d1WdHlkfQDnGlca4gTKrixVw/VT3MzHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=nN8Ls91b;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YQrHg05Y;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C044606A32A
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 08:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C044606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=nN8Ls91b;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YQrHg05Y
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5C570EC0BAE
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 03:05:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 27 Nov 2026 03:05:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795766716; x=1795853116; bh=bwe/UjGySh
	c26iKofLMVW5svfGCRRls1wB4gxHcz7YY=; b=nN8Ls91b8vQ2BUfL99uBXzSDFH
	h2jUK3Dlskcsqzf9E5hocDRXznh/urzf6/LklS9x/iNbPOJxTzftPvczZscvo+Wo
	VcOdNcvwuh8HaEsKusH0otxunSGVdc6wfIBxlIbk61Ffvc8sOiZspCqT+zraT4gC
	lJyEe8pOmcQAy8GNVPpwqR7VkA4Ots0cB2nRBdzu5yT/ZmgIDZjgy2QXayLieJZH
	s/rfFqcgN2YOSCwyy/se3zrk5hqgqTcbMmZRwqzPHTSKAbz95oCogwdUQBJ328e3
	bl9+oMh2pgkYrbRNEBwboSYo2MrAf7zVY6rBklA1ZyDBEe9fDM4FgxccC38Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795766716; x=1795853116; bh=bwe/UjGyShc26iKofLMVW5svfGCRRls1wB4
	gxHcz7YY=; b=YQrHg05Y2j7DbdoWVLNFH4BH9YuerouQPJYzY1ElsGzYlG7THed
	grEOKa5tGthxTWWgLRcYEVqkGAmx5Og1ZNyWnGejt1wUjdiN6lAei4EcuBHQGG1S
	7E0JWi4OfHZ3qMjS+rbwklbwnr8UeBTdHrWN8lK41S/Q+fSWUc4+rR5pRriOhRA0
	D+AZgIBchexGdiqBxq5vKlv0YHZo2Gl/xhqyz9UuVEbZvNB8U83bY7OSJ3tWPIpV
	Ti8m/5ahTpfPMJBLP1u9k7kBHFcPlcsewCx/AXHCBCzFzTUmTU0I+b0J8BLhS85W
	mZ/wgtxJtF2NeSIeNJaccu8zL0JsVon5j9Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795766716; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:heM/GvqAyBQaENxSPQuEBj20pC2bQP2OxJGiiXHHxsFKMuf
	TUtnvSWSfulQVINZzBJ6Rtvuceql8J5EZorW7ZTkH4iaFaITwy4ZNlAaUYJVA3oh
	TP/qC8YqLy5N/RqJ8wLhnDYqvkQselVZfjbr6EpDNOcQmAHiHizQODuZgV5Wk3Ew
	a5zQ6La070Z9Cs8hrkleGxrLb3hOVhxTVENqHEBim9AaLL411Uj8+h0oFjbY8f/Z
	Q8RnFB8X/PwPKAg+EYmP19itT81KyMRRvYTFvaefLgyiY3NX6eHKJ57WAyJafasi
	kDzlCQqiRYq+vZx3bouswr0/xs+sQvDpi661/Gg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:DfCr7ox4wigYjcN34GgavSAGmOFPux5GMUIf+AsVJ1g=:WyCyDNGRRtJ5zWU7g5QTiuKhWP9FMywwRqIz0UFCfmw=;
X-ME-Sender: <xms:vDkJa5ol7jqGzjKGM23BfiMXyVGyVvxqbjNnG2VTzRO7AFk1fTUc5g>
    <xme:vDkJa5dsRhx2Fvn2f2eiDMmZrx5hVUJ8pjg3lPysxqi1miCjyAQcS1M-SUNhLUDfD
    xxmcInEjanmFcI-bJmsFd6a0tjSBZny8MpQDHe0rTDonyKDlNn4>
X-ME-Received: <xmr:vDkJawocAQoK2qfo2kI3RTTfOzf1FNjZLJhXVKFoQew5AF6ekpYNzpiaaWwG1gtxfWALE81UO7phKpXbAUcGfssZh5NNCUs>
X-ME-Proxy-Cause: dmFkZTGdP25K7F0p3EtY2T5UI21nLN1AoN0og5IO2QtX/Xx2gYTb6mH4bf8NZ6nTQXklxt
    9D+InUf3caxVzpb0z8oCQwo+K4dEGLf2Toxn8ArjYgh98Jonetx7FDI4L7DQH/wkC3USxU
    96DO4F+NCuFd6IjFQMhH6M6K/HsQKtrdwY/efnj4sMhfZJ6dOVANRpMeYDZ9hcrpeTRbOM
    SCeKQgUpQHPjiMfxQutMSgW4C7Dmjqc6OexakTDpDSl9GVkp3AZoUK9zWDRz4XPtzFYj6Y
    acXc9FFTDLrVzmZRgewLwF2ravU60HWAI2QL3Mp3DIZRpr77V2oPfdjO+IRPqtQGYhpfSC
    04X4UsrUNruv212ns5eEt5N8qAf6Dlhvy1QnclC3H6UjZqRpFrs/ACRPDMZ4Hry4ch8YtZ
    GfB8ND/tkrzT3OflaT6bZArRd2IWoZT7l360JQqlSpBj/zOodkvvURDzJwvSBPi14+mvaa
    /i781JRN7aJ8ulEFWe7A5z7BpQR3aWavvQSVs7HRmUIkVv2w279I0VlLPIC/c0xcWhDyJ+
    NkAgi5VcAsW+Bdrtb/zRvlaXyHAg4oFP513BgYGCbA4jd/GMKBb/sSVzou+68NKkOP2ya6
    jD7UazpcqDM516ngFgRM3KtH3y0HpIGwu/bUqaXuTUi3YCiKBanJkKx+fTCQ
X-ME-Proxy: <xmx:vDkJayE6eBXtblIxJtqTQR4g6d1ovs9kcurotkMGkntqaxDzFNboXA>
    <xmx:vDkJa4t5weRcrcL5auqBWVzvVJCJcoagouxec5BnHimswbzRmAKBgQ>
    <xmx:vDkJa8WI5Or1KihDGeNmyMCeDnavQUffJ4PE6jmv4IGfNwJGNnDLRg>
    <xmx:vDkJa8HM3eQjqaef8nN8TZB7klNxVRDxVf7ZTM1HfznUkEqb4wo5Xg>
    <xmx:vDkJazOI3rAD_YDq8DL7mvLCG4SzqPf1fU20iD_zQrK9w8p_4bSmcfaG>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 03:05:15 -0500 (EST)
Date: Fri, 27 Nov 2026 09:05:12 +0100
From: Greg KH <greg@kroah.com>
To: Dickson Wu <dickson.wu@certik.com>
Cc: stable@vger.kernel.org
Subject: Re: Request: security fixes for 5.10.y and 5.15.y
Message-ID: <2026112723-jogger-splice-ce25@gregkh>
References: <CAFaZ9eogwNaXVeVhOrtz9montDVg6G8zYR8rOGdpZr26nHFO-A@mail.gmail.com>
 <2026112605-alias-passion-6781@gregkh>
 <CAFaZ9epm3Tcuz1Fs7wSOqECzZbwdwEYmwSxwUM72jPMZKZArvA@mail.gmail.com>
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
In-Reply-To: <CAFaZ9epm3Tcuz1Fs7wSOqECzZbwdwEYmwSxwUM72jPMZKZArvA@mail.gmail.com>

On Thu, Nov 26, 2026 at 10:57:03PM -0800, Dickson Wu wrote:
> On Thu, Nov 26, 2026 at 12:59:23PM +0000, Greg KH wrote:
> > Same with these, please provide backports that you have properly tested
> > and signed-off-by on.
> 
> Will do, thanks. The netfilter one is out now as a tested backport with
> my Signed-off-by:
> 
> 5.15.y netfilter, a81047154e7c:
> https://lore.kernel.org/stable/20261127-so5-nf-515-v1-1-ce02c323f842@certik.com/
> 
> I rechecked it against v5.15.226 the same way (SHA reference, patch-id,
> subject, and later reverts in mainline), and it isn't in yet.
> 
> The other two:
> 
> - dmi-sysfs 18e126e97c96 for 5.10.y: dropped. Getting it right on 5.10
>   needed new lifetime handling that mainline doesn't have, which is too
>   much for a stable backport.
> - arm64 ptrace pair 88b839ce497c + 5306f124f317: on hold. 5306f124f317
>   was only queued for the newer trees this week, so I'll send 5.10.y
>   and 5.15.y once 6.1.y and newer have it in a releasea

Thanks, but as both of these are going end-of-life in a few days, and
the final -rc releases have been sent out for them, they are not going
to get merged.  Anyone still running these kernels should move on to
newer ones now.

greg k-h
