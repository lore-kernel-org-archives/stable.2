Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697945;
	b=ur5jVoXSF4yYIVSLa0TuyjoeCKVbHnKlEXZWtXw+fs0y8TKOL3OtSQ7YN7xhctBGSA15
	 +xx8y8pTkNeqe6o2q7ZJ8W9LqsgP3E0V/jbiOk0zWgiNrPr8SI2rCS+URPNzgj65cDN77
	 KEfbXWatWqDTx8t+AW3wc6QcW9wUK+NxKEPvGJ7rfr6fE4U2ybu9C+gGZqfofPUUC/EDa
	 tuIaGTJY7NRvCLIK8IkIix2DSjdKJNsWhb9HA5A2ALZy4wsBkoBL6likqK//h7vh5sBYG
	 7s3THAVLHfk/zxZ0v4Fis1yVtJLhy7I6tqUpkw94QZN0Wti5Hqq5cjhnRuefWAlv96g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697945;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=tiTkjpc0NuvqBWv837EWlf6QF9n69r13tmpd5iDaULI=;
	b=Wwt49kbV1iyLVvCRivldbQzAhmIJqyEPwByDklCdmBrOpH7LgMMRQfhTCx1RYVqnrrJo
	 QXOyfwt87Zu+xOykzmXxEh6vjHDJ6x0lV5uXFmaskIb/mN9n3DqIGQs56cvs+ls3C0aaL
	 kAZ/EIRPco2XEvrenJAtriX11f+P2CwkIC75JFqjyivTpuP50uFT/nFPd++o9Hbo9scJD
	 v8p84fTh49+7OxG+bXp0re/O8oxrXFlqdAnOejfVxWcVgeosj4msTZ1A6FsnrlXg1jWtv
	 nOYC6SUrcGiQYk3rwIFEMH1E4oTHhce0cQX0fGb/ofVH25CHfpWDA6SuGbL4j18qkBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=Idc9bhoC;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=l+3MoF8F;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D3E606A327
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69D3E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=Idc9bhoC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=l+3MoF8F
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB6D27A0507
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 07:59:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 26 Nov 2026 07:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795697943; x=1795784343; bh=tiTkjpc0Nu
	vqBWv837EWlf6QF9n69r13tmpd5iDaULI=; b=Idc9bhoCSf8Og6HYUmT5aU4L+r
	4zGf+cthOl5nPFYs1qR7p9+jA/NL/3zTFC60k7+8oYd3y2GvVtcTlGa+ZV5s5ULg
	rVMNutFJuvDJ0AY96LdkwMfychfRviWCnq2qDp/AJwoOA/9IugjK9/5CVLspODsA
	uROxIcalty5qCfhzuio+exynFBeCqg3ctDu77ZJvfKlAQHDmK2oJeL6H9A/zTqqM
	hJJ1bm6Q7acOENujQa7f4Gyf/yyRA8co/sr3QF153b3eG2CCMnbY+WN3GuceZwJH
	qfg0ll8PvOUj3Mm22opMTLvrDvMGXxhfXnvXogenPvn5R46cUDMwEcI5vEnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795697943; x=1795784343; bh=tiTkjpc0NuvqBWv837EWlf6QF9n69r13tmp
	d5iDaULI=; b=l+3MoF8FVU8D9N6RyGEqlsDGKqsP6Sbm5U8qhI/h50vsr0noWpU
	F/omqGIgZS17XR6QRAQQi0wIqzARTx5+5+SiV/BYz87vC3B24b9u5tRfXgyIorn1
	uRrU9bHkI3HENQ/gV1NwL13RResdS3JdTpF9U0ukgUg1vjkDT1kcpoiVaX+WDY1a
	oBWu1khZBB2D0N58SBnxI/OmNKbqt0RpMe2WLa9kCgdGEu3ss2eJnzEdYhnqd8nT
	RPxJJLGSTQaVqYxqDCBuWW0c0f+hd38oW2uZF4qSoJhM9jcXQjaOPAGz43gadfjD
	hBBCA99rPsU8+cLv+7sKb9cSfeC9ExAqJmg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795697943; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:kTRl+Q/P7uPILOOA2/bTvw/KqePa05o/YvqRIZZHOSFvrVB
	KqfRSSuWZS7MRq77brOUtaFuJZShLkIOIZte0hhHcV9ii9uFQ09B70Jg9f9LFZFM
	Yp5iyONAH8RxYT5S6i6V+GYDw+Nn92s0rGfED+OTCaLhIWMnOQFfWyb5oAXZ+nEp
	h0Q2mrwpv9w0ExBPrKDevPNZBIX8A7HcmWZyUqpZbtsqAqqtWFRvgKeMxJr+6xG2
	3C8KD+jv3b+M1UodaeISCQRFs5cjp853C7jOVIkyigHpY0rYyy0qqg4JornHlwJe
	0AjIh5k6EkFXnAm+Y8rtelzgtrvYn1vy6ESZlgw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:hTyR09MH1w9HjPMyjx0xRTXO9VdzNQrO6Zak5IhElbg=:QPbSA6qMZJz2MbJz9lcuJQzGd1zlbXCULgcIBcHMHdU=;
X-ME-Sender: <xms:Fy0Ia_dqqFBvbkNXz8oXwNMYhTazyJwU5IKXm37CVG8RjZxi1R2nQA>
    <xme:Fy0IazCDo07XoA-AtJtqnti_IIDKqAyySjyAH2dJRt8tuRSlzH4LRNxvwVYNG_WI8
    hyqrDkkthnl2rAM4omVdolHqb30ZtNMBCD3w4xUCx6FdkiGusY>
X-ME-Received: <xmr:Fy0Iay8x_aBnrhFuBYYPf9uh-UHxUNEcyHN9vpMfhW65m17tdt2cxQ74DI04kqPVAHR4KDxk3nz0YL3-88FptRWdkRspMFg>
X-ME-Proxy-Cause: dmFkZTGpWyO0t4HQ/aicvFnnVRKAEvvw0DLQlMgmCbGTyNFC3JzuRhQynuJWamEtfCVFhk
    ssdpo3puBLlLFtUGo2IjpY2RmNBGsyyL71Togb4nZUJWKW4kKQ+Ubnl2oQOUz5Hwzcz0Se
    1IcNOy8DF7KTbeOS3FoMad0Qvz/6G9ypntZD/CHVJqvfOgfPo4Tjs046fazfqOnE8SPwG5
    FPAa6UT/C6yVA5ImDjyz94XJ4KzRlIgmLJdfK56Cm9XGEHFnMtWXXwbewg/CNicrr9pQoI
    sPlcz4Du1s0HyhT4KwHUBWmYNaN6FSY59OzGiIv53/FwLOCcBZkl1b9MW8dnKtv1zlsVFJ
    /M7Jk2VsOo3VhqqxxvamNcunYqJ1Gxe5WztOGPQ8ZFOurJvzMHzUBsgSf6AUToy/rx/YnR
    tmE2Yt2N5RoOXVr1Wnk6latFYda+SGgslVu99kWshexklt/68cMCdl6xP1d8ZoDwPsy6hu
    vYHlvI5ipwvaFMT242nsbxl5LMUfF6HPpQzfgK+ZaKkW/qaMef6UcyQCxfzVosC+mf/H4s
    nrntONv8s8N72O/mZhTM3qsHNXNTvjnX9y8GTnfDtWmq1DeKqH2zRtE1b2k5CJL8Rkl6ma
    PsmORPkwwDuHNV4uyQ4EocBDiISfknTvWIe75oX2frhi7pU/Golhy83JgpfQ
X-ME-Proxy: <xmx:Fy0Ia-J46G35IrKLy1Khe3GPilUC99IG55_M12LoE_-MlLV-7u0MXg>
    <xmx:Fy0Ia7iX2Zy6UYYV74UsoA8gPS86L_NWevCp836ZuHl_IFAkfElNXA>
    <xmx:Fy0Ia-7Pwc9o-o4XH6ONEryvj-mFpIklJzBQBQflX42b80542If_4w>
    <xmx:Fy0Iazbvz0wPRgVABuek_0pDQ5JBxY5Co5we4IjPChwUKG6O4p_01Q>
    <xmx:Fy0Ia6BArDhKY9P8h-smOnVUOyKRWJ31Ik7zov5HnrulFVh0g9XWE3WZ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 07:59:02 -0500 (EST)
Date: Thu, 26 Nov 2026 13:59:23 +0100
From: Greg KH <greg@kroah.com>
To: Dickson Wu <dickson.wu@certik.com>
Cc: stable@vger.kernel.org
Subject: Re: Request: security fixes for 5.10.y and 5.15.y
Message-ID: <2026112605-alias-passion-6781@gregkh>
References: <CAFaZ9eogwNaXVeVhOrtz9montDVg6G8zYR8rOGdpZr26nHFO-A@mail.gmail.com>
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
In-Reply-To: <CAFaZ9eogwNaXVeVhOrtz9montDVg6G8zYR8rOGdpZr26nHFO-A@mail.gmail.com>

On Thu, Nov 26, 2026 at 02:41:22AM -0800, Dickson Wu wrote:
> Hi Greg and Sasha,
> 
> Could you please queue these upstream commits for the trees below?
> They're security fixes that newer stable branches already have or have
> queued, and each one cherry-picks cleanly onto the current branch tip.
> 
> 5.10.y:
> - 18e126e97c96 ("firmware: dmi-sysfs: Fix null-ptr-deref in
>   dmi_sysfs_register_handle")
>   CVE-2023-53250. 5.10.y has the commit it fixes as 985706bd3bbe, and
>   5.15.y already took this one.
> - 88b839ce497c ("arm64: ptrace: Keep 'orig_x0' in-sync with x0 on
>   syscall entry")
> - 5306f124f317 ("arm64: ptrace: don't warn on missing siginfo in a
>   group-stop")
>   CVE-2026-90347. 5.10.y took e057b9477232 and then reverted it
>   (ba8b9a906d80), same as the newer branches, but it never got the
>   replacement fix that 6.1.y and newer have. The second commit fixes a
>   warning the first one adds and is queued for 6.1.y, 6.6.y, 6.12.y,
>   6.18.y and 7.3.y.
> 
> 5.15.y:
> - a81047154e7c ("netfilter: flowtable_offload: fix using __this_cpu_add
>   in preemptible")
>   CVE-2022-48976. 5.15.y has the counter change it fixes as
>   5345d78ae64d. 6.1.y and newer have it from v6.1.
> - 88b839ce497c ("arm64: ptrace: Keep 'orig_x0' in-sync with x0 on
>   syscall entry")
> - 5306f124f317 ("arm64: ptrace: don't warn on missing siginfo in a
>   group-stop")
>   CVE-2026-90347. Same situation as 5.10.y: e057b9477232 was taken and
>   reverted (7ec6eebb438b), and the replacement is missing.
> 
> Testing, on v5.10.275 and v5.15.226: cherry-picked onto the branch
> tip, W=1 build of the touched objects before and after with no new
> warnings. The dmi-sysfs and netfilter picks were built and booted with
> x86_64 defconfig plus the relevant options under QEMU/KVM. The arm64
> pair was built with an aarch64 cross compiler and booted with seccomp
> enabled under qemu-system-aarch64. I didn't run targeted runtime tests
> for these paths.
> 
> The list and the test runs were prepared with AI coding tools (OpenAI
> Codex agents, with review by Claude).

Same with these, please provide backports that you have properly tested
and signed-off-by on.

thanks,

greg k-h
