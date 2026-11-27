Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785008;
	b=cG6C54jYq2M2h0f2NBUF4QnqrbUEsveZq20xeNtHulbOgPRWsu4pE2u/uKqcjHxzhxoD
	 LAn7nXYnKztQVHiVNWERn9cFMJ7UguYk6cEiUZ8tK6lyPgis+362blYCORHoMMwLoC58Z
	 B24PQ6li5G4sO4hji40edENW96yFkFovDJIZBJaIXoLvi03K1YWb9gZ4HHUcIQcRCc01H
	 DSSGGGWIstKcntH3yzgNOMhWFBqS0Ud7/oIfjL8PH0OMH5a1CtkjxXvuRLPM53WWrJ0dW
	 DChmseEWNRhtkCoB9QZ1k8Mx0jOdnHyTcfe7uWlON2qcx44/cM1BwM9YxGyIZ1YgWoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785008;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=KP3hyIl9nfIZ4kIlM+oZLvLEmTE3FJBTBM7sQHy4gKs=;
	b=vP7KD3/TZgeIQvuLjNo599GjcJy4hVWAvx/U7oyQsKQDrBxhbbPJQuNhQir+ZXQUf04+
	 SZiQ7BSfkXYBGhEBLmNxeTJLR1CeS6LvLjXqZFcvwXqv1/pRZmGYbocGVQr5jhbFvQ4kB
	 CgHttetuLQxhlj2Qye63S1mdjr+5glOyyWHN9im9Q+qtOWODtGm34U8RkR28RuzkoiuLA
	 98iRQTcKDc/K03PAtpWHMAQuyMBz47laao75uU/RolDznFDQQpJR5TaN1wygHNEvoBEKQ
	 VL6yMnjRDBqKrg0dQF/AwKe+xJsVOJyQVSAiTmq7JiZr5Z9k1Ys9zOqD0EprqqzBbNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=t1tR6Olx;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sOg59rmt;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A99F606A31F
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 13:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A99F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=t1tR6Olx;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sOg59rmt
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 48BC5140037D
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 08:10:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 27 Nov 2026 08:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795785006; x=1795871406; bh=KP3hyIl9nf
	IZ4kIlM+oZLvLEmTE3FJBTBM7sQHy4gKs=; b=t1tR6Olx1emUWag1Mea45cwCnP
	c+svAP2vAcMz9hkBtzpBUa+LQVo2df4BnNFk6W6KHRx3W/wtg0Gu1stkuG09iCPE
	JbjQlrho/bsTbqEjOPn69xKp/+eh/atDUxuRcsX3nzo9nATDkfaKSZJMJd/GDF1W
	1HwIfaptpTEovEsi2i3HkR7l5+wGtCBE34c6H7+id3D0nNcgJ9XAOYQun06qL2aM
	Jh4yePqdl+nMXy3mmwNOXGU/ZgW6oXr8INhO811LJED/0yqxp9TkI4YREjJ/tzAe
	N2UNAVVGRYsvMyl9KzjmRAwtbVJWkUXr2ivk+/zqGqD1SWbbjnEQtOoBnucQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795785006; x=1795871406; bh=KP3hyIl9nfIZ4kIlM+oZLvLEmTE3FJBTBM7
	sQHy4gKs=; b=sOg59rmtya8u+BzfDo7fN832zM+0PLvc2OmrF9894HtAJ4TdKVK
	4k81ItUqtqH4RcyJGtcxfALh2Oh2rxgWv4Zj2eOW3Z8P14dfln0vReBfOjW4dd1h
	PX0P7ZHsUOOn5fmtQHXJ4mQVnj631Vow7pwEMPiVm7Rk/gsnDQsfy/8qp2MnpqYS
	vE30XbNj244QFgZYoySANB+n0SEoLQE1DyaVR0aH7UUohRvkLjssPx8uAo1EXMd3
	4Vq4zx8VWrO7aBAQ57uuxVG+g06QQ2PBza5v8ipzPeWP1/5bf8JUFPrZ8K9GfonY
	dBBMrANHE4IDgA1cD7muEGXkX1TdtDxtoOQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795785006; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ZdbgWCwssqdIkAVWjUhZgyBxwtc/5LUp4bVxggZdqPogbCw
	G0DHbjWsRl+k9ejIs4nk/2FznYJuV+u7wVCjgWec978oLevYAkhNWQvVDBAZh8CM
	AaFU9AQnJ/p6mhzxKqfcMVF+K0Ct13evWdVXus4+OGbMIWFPCM/b1TtoKy74wvpC
	GOucJK2oI3e+PIatXNMCvvZol3l8bDLIaQSFa8Cd60hACU8ZxoN9mww0yyC+T/+t
	ucfpMTjs5kvL8aPvqtQPdh8DWfPt2IiNgwrwaM93K0kO38nFt0nNA5LRnCnGvps9
	BE5msdudttSKcwWjBzSoZJPz1ydxesosDom/YNg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:IAr/TVSBEkSRQiLiqIJVU+2cgoP6Bt/xNIm3OY1b9mY=:cBRs1vpLHwlMgryddMjyaQrf7s9vezl4Mm1me1HrSEo=;
X-ME-Sender: <xms:LoEJa3DDcR1KebcQ3cpVncDqYOJIfFfFl3U-3Kew5gVcXGVmcpX3BQ>
    <xme:LoEJa7XkZuNNzOmFP4p-29MdGivWxEqhuNzOVHWbGcXh4TvaHdckhjjQW7AsUyag9
    PFrqhpltr9Z7IXBqUUVqq48X5HVj6ZyNZtWkXm_xh5loGhyXA>
X-ME-Received: <xmr:LoEJa9A0Z77cSObSD9qnKiB7M3ZMDyw1fZC_A59b3vN2hEEhh9K6nmrhzcw3Rsn8OReWup1F9FHpBWsnG2dTi_Qa7NNkxk4>
X-ME-Proxy-Cause: dmFkZTFcSCesdafieJv4jg2qYjBkj2DPfCzZLjUepAaY36fmD7dC5H7QGLqvRNMrnPhZan
    EFvdD3ICsmmg5HZi8tHM563XSZHwZTjCswMb985Wk7aF/Y+Ty67ClM+DMJIaul1+D8TyMY
    8uD7RNw/gNTSQYiIO3lDrcpyD1Kdc0LNjqHvjoYl8ZQ3glvBuY7FpmC5zVb34R/CX9WwMv
    T3YxiHVg+LDZFduZ0eOYV4OFq5SohXZ+R1aUtMbYVyHUXPyv5fawcTt9ZpSjcuPiRmbTQh
    rHZtrwsdZ/wLdu/gBztiOcAZPXjH6ZTJW24u/1dQTmcFvm9VaBYpRtbLzfLTO8cOXoB0CL
    jkkT6WxM00TSLQt9wbbmT3bqZExV8WU4M0cOgp8HbuX7wu2Jekvj5V2g1cKu5PkzFn89Ye
    yoiXe4UHB5rpgu3U4yzzfYjgESUY4Lggc3/ZbKbu5YWXC76B7ZIA9R9dBesEDqiHNH+q/w
    pqPypoQb9v8xoO50GiRKRjYvkOzaD7uCNKUnAbqG1D5XZRu0dHMEwZhx16tw6PBDxKzRXW
    cNGaI7PZZOC4AUwCMVn7fVDfDicLa8G/EnZAp5Vhqt1ZECYKI3yEO0S8kkzi737y+RZq6m
    dBrMYwiZ/C4ZAApf6s6P5ipvECOvY/m/4qDdJspNUENIbz0pEOYkBYfJ9KXw
X-ME-Proxy: <xmx:LoEJa2-quikh9u_XJTi0RTc__BAQIjuwLgvEvzZRFWcHUFpmir1-CA>
    <xmx:LoEJa8Fe2WE1r-KcPY7ENuWiTEXEXm5nIxrSaXDV18FQxZrnGjQaSQ>
    <xmx:LoEJa8Okx8fYZWQ9jNCOtx69FvM4Oh9l6qCXs93XSes8vBccsEu5-Q>
    <xmx:LoEJa-fr3g65su1-PfRjMlvHlPGqPGS6Gibk17He-FWoG7Gzihytvw>
    <xmx:LoEJa-nM3rEY9hZrkyB6qD3DKHroJT4ouMGpkyI5Hm1opVFOL5hR1ine>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 08:10:05 -0500 (EST)
Date: Fri, 27 Nov 2026 14:10:25 +0100
From: Greg KH <greg@kroah.com>
To: Dickson Wu <dickson.wu@certik.com>
Cc: stable@vger.kernel.org
Subject: Re: Request: security fixes for 5.10.y and 5.15.y
Message-ID: <2026112710-wharf-playgroup-38ea@gregkh>
References: <CAFaZ9eogwNaXVeVhOrtz9montDVg6G8zYR8rOGdpZr26nHFO-A@mail.gmail.com>
 <2026112605-alias-passion-6781@gregkh>
 <CAFaZ9epm3Tcuz1Fs7wSOqECzZbwdwEYmwSxwUM72jPMZKZArvA@mail.gmail.com>
 <2026112723-jogger-splice-ce25@gregkh>
 <CAFaZ9eqpPdQ3fiu=gO28rJY48Jh9SqiRxdpXYtBzB5hcoGH7Nw@mail.gmail.com>
 <2026112733-gambling-twistable-dc4a@gregkh>
 <CAFaZ9erPPdqJq-Xpys5crfAcJ4W4MCE_O24KvciLSk+nSSny=g@mail.gmail.com>
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
In-Reply-To: <CAFaZ9erPPdqJq-Xpys5crfAcJ4W4MCE_O24KvciLSk+nSSny=g@mail.gmail.com>

On Fri, Nov 27, 2026 at 12:10:59PM +0000, Dickson Wu wrote:
> On Fri, Nov 27, 2026 at 09:12:18AM +0000, Greg KH wrote:
> > Do you actually use 6.1.y? If so, why and what is your plan to get off
> > of that kernel to a newer one as soon as possible? Same for 6.6.y and
> > 6.12.y? Sticking with older kernels is almost never a good idea...
> 
> No, I don't run 6.1.y myself. I'm a security researcher, and I've been
> looking for security fixes that made it to mainline and the newer
> stable trees but missed the older ones downstreams still build on
> (Debian 12 and CIP are on 6.1, for example). Totally agree people
> should move to newer kernels, this is just for the ones that can't yet

For Debian, yes, that is good, be even for there, users of that kernel
should move forward "soon" as 6.1.y will only be alive for one more
year.

If you can actually test the patches, for the backports you do for the
older kernels, that would be great.

> If it's more useful, I can focus on the "FAILED: patch ... failed to
> apply" mails for 6.1.y and newer and send tested backports for those.

Sure, that would be great but note that Sasha has a bot that does that
already :)

thanks,

greg k-h
