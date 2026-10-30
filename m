Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361201;
	b=Kop5zR/FCV+VuxJz2ZsXdo99+1tkkmb/azIBai0IRCIfZ4LaQq+IrkV6X7FMkQ4VUI8A
	 NKm31P+sZqiBIyBgv0+yapczOXBKwPxdbKvXFake3AKnOQH+mpjNNDKdAoo66wJzSSqsK
	 XbiNCzVP0JraNDJkKy7lNAgbR+vQgtbA6v7qxEGIxRn18HivDXlYAtdPKEbs4WfwJOgcr
	 9uru/TSXXAqaj7ENV+m06gdZRsum6LCU3/SJ40XKXlCMZrY37lcuy9HTPavzeb4LyadvW
	 OeAEF9POAdrSXhJPn0iBee4iqjthxUefOMgtg/nU1AMp8fXE1tZ9GbfOGZFIrk864og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361201;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=mEwGWDcHWaLkp+5zlz9DxIZFTTgCkctRKHzPuG+Jo+M=;
	b=vjM6F61lqeKHsRJE5HZPGuq6oFo8OvkaTCTYEynyKgpiTlwFKIWeq7RZJpC/zmp4WExL
	 +/SADEvN0H1Dsi7aLmfz+rddTLPLo4aaHOhS5TBGqtfnj4ymsVsxOOrYy7Yk9KItIbWMk
	 VC5wFLfMg+hQ0sXHJoqTVvz8/XBEB3JpaOrxZ89TWhX+5aWKCuWUVxpryDuKupnrskyw7
	 WgZaOHo6EmFY2Sgqzde+3Vtd+h/gEfO5AjwT3LRERS+nUtGWIIsJ52Emv3Qpp6weKzQsX
	 ct1ihntnBIlyf64fLZbrp379Lqu0dpTDx52CfNON+CaT1tJKyQJc5Yctvn+/2fVTn6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b=OduHKrdj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TWlNGqou;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C98606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2C98606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b=OduHKrdj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TWlNGqou
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F27017A0145
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:53:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 30 Oct 2026 07:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793361199;
	 x=1793447599; bh=mEwGWDcHWaLkp+5zlz9DxIZFTTgCkctRKHzPuG+Jo+M=; b=
	OduHKrdjxLHqfWqkH47Pk8WAuoHC51BqVU1eRRF/+bIDc8PCxQTnshkozUg+aASF
	umVej2dIhOaNWF5l+S5s6xXAPC35acNgGffhoQQyiR2e1hB3NKGxW8CcZDtWK7V9
	CGPh/c5xh9YIyzsLFR3g4WbdII1Ls4gmypJH4wYaxR9RIePewXL3y8EDrrVinzou
	6ET+9RPSmc3/eU0kZnvziSPwpTFw0D3Bf1zE9EZmOIteD4Srn13cED/dpjQKsuL5
	Acbw2rqhCDPTkKKpUVA0R315zSOD3JFFwxkuZHaoR6tsoggkF065ArkvButpsIhQ
	PPjYqrHLZLRDboEa76GWCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793361199; x=
	1793447599; bh=mEwGWDcHWaLkp+5zlz9DxIZFTTgCkctRKHzPuG+Jo+M=; b=T
	WlNGqouRtvVS0LQGjQ1mTXe5d8y/P/GN5Mzjg/dAs0TLEvjDjRbr/Xuk2rPt6L7C
	nkF/2to8mnrmFuUyGqaoVsblDJWsa3VpEkZmHsl3W5Xk7OnmvZZGTyzmd7pS1ofT
	v4wP3k1li+mtQz0Al7JIwaOwzI9MTi/miJsreoVMLYfqoBEdrMq6CusEMRNfsMP1
	eX2jZzBH3k1l8L7XJpaRAD0Fy1kdqcPSYiYqFcJPZZMI2YMh2VKpI0mMro7ZvSti
	k8X6Bgr9ddVwvE9RcpvDWOIEPs+ZhVXA4Dl+MtnYQupyXIRzUurtnLibwfJAcQsL
	pjLUZulrzw8Phs/WENQIw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793361199; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:HuKXoL9dkkzAial/fILPvFF/HIghuzvnzgmY3K/63hTfSCV
	koid/lhPzojPj2UR5+4blhvznG/LL4BgBL13R0EInz0TEv3rvtdV9rtkm3q4UL0p
	NcOYd33jUc9Z/Xt6SMmT3r3eNbKZNR1ijVVVg5FNcYVr7PluEXnzZY9FNyBdaQti
	p/vbOgPyr2GLxPWkWdR2HSZ7nrDWzMSctfyX7KNMSEhMx8iGpWFfjRbR8OJ9IOKj
	RPvo1/Q5wdgp+nBKXM04hWH/yUNc5+wZCGootsHG5KsAWYPEhwWxkME7WcJ4IjQ3
	RJdFamS6J5gJ0h7/3nxVoNnNEteUkKBXtXZtpHg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:V4y0ikRh81F+RID/yOa7HlyVsvAbPD4YKARZyZXv5Ag=:0JVONLFZZ6gdcHNYtO6dkHTirj64Dd06EGzmrIVkx10=;
X-ME-Sender: <xms:L4XkalSTELpaOjoPV5wgE3etxk6Ouy9Niu4i2WpNS9dg3FF92RGi3g>
    <xme:L4Xkal3JN4cRSU-hWOFa1HbLS0cwYrZd8iHZzzHr3wHx_9chMjaeqVFL_NppHwhFN
    d_d6e1ukDjq2bSPbzp7Xv-0lDg7AiIRnVWnnJ5Zmx1Sxz_C7g>
X-ME-Received: <xmr:L4XkaihsMAM_2i2ou2atD8C13U4odde8xkHkOgvlw3DcisR2JgEuluVNZhnqv2h5qBNhTwdJfhz6QbKXZRTiZ4ATiqdgSahTf85EvS-BmcE>
X-ME-Proxy-Cause: dmFkZTEBWqqmyo8WB757nOxa4NgheVxOazllpBg/uwyCy1WpruXXxJMwk3S6kGXmYsA9rV
    sfC5NH7ZbVQhCogp7GeP7Lzp6WwVJ6E1lea57cp5XnTRMuQGb//5jk4TQgvFw7cMrqOagE
    UB/k8vt0BE8fRdw3mAHLvln8H5OtkzHBw8WLX12WOW+pCRvl5flwXlrVOhCFUCTROQ81Xz
    LMSBXtLcyK+tPsBpjq5XeDEmBKExEP3h7+oZ2cRMrssXfZRVynt1rSeHO174JNu0uVdgXh
    V9A2Vw0oSAiUGaL9y33oKNW3og02Qlib1dlwTBGNIZ2EMuuhluFNJn0olECi8qu0UxQ+E+
    Z+d0/vujMxEHLagG/e90BGJSp+l7tWnbpCRSSMNW45V3znRsicLqSl11JaR42Dzx7jfCcS
    4gI9vsrXGWKPcup6C/lhsOM8tl+OiLv0ovYrx56hLiEcIZziTJM5o+LoqfmGsW5emksxh3
    iwEczJhX+AVfPR1sZLbxASozapHrzWF6v6A/xX3vvRs0/cYUPmGy+4wLJlunZKPqCh8+WV
    PzV4NNb0LVstsuyeBo/UkibUxQxcxirdAnMOlefdPv+P78pDQ7wSVsaHrpv6j0U63J81Ng
    fhY2y0qEXzoR6r88GHpTO68sjld/ZIwx1BBWTNPaIh+rIQP7hZorWUThTV5Q
X-ME-Proxy: <xmx:L4XkajaxuAubDwwvr9MHmGh66qeeBk2vqifq-HGRM1NI4UDrXRE2QA>
    <xmx:L4XkarMFXJ2YP0VR1RODYff8fVl-DPRxHJmsXUJoIizgReGMHYWEYg>
    <xmx:L4XkanTwIsYXchNn_DDMQvGU5p6FpRsiWoDCMZ8dNV-nCB7LuAyUJg>
    <xmx:L4Xkau6dB5-qnWCgy6FLl1QaM4G_efR5BkY0CrVxsWsE0WEkFiUoqQ>
    <xmx:L4Xkamh-LqP2X8gIkcNJgpxS0Q1ssTXeK3iRUODnv3JB2mdPj5fIQhVH>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 07:53:18 -0400 (EDT)
Date: Fri, 30 Oct 2026 12:53:16 +0100
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: stable@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Juan Yescas <jyescas@google.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 6.12.y] kbuild: link-vmlinux.sh: improve detection of
 third pass requirement
Message-ID: <2026103007-hundredth-deskwork-738e@gregkh>
References: <20261030-linux-kallsyms-fix-6-12-v1-1-9c43c892de04@linaro.org>
 <3e4f24686842918a3a340cab4a7cbeb7540b8a1e.camel@linaro.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e4f24686842918a3a340cab4a7cbeb7540b8a1e.camel@linaro.org>

On Fri, Oct 30, 2026 at 11:34:34AM +0000, André Draszik wrote:
> On Fri, 2026-10-30 at 11:29 +0000, André Draszik wrote:
> > xxUpstream 14b8b4bf2d7b cherry-picks cleanly onto 7.2; please apply it to
> > the stable 7.2 tree as well.
> 
> Forgot to remove this stray comment from the v6.18 version. Please ignore
> this line.

Please fix it up and resend.
