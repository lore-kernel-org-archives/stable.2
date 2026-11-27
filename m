Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770745;
	b=ZqfWqITSJ4ApRktXsCSMckt6I5XSXniLSpxD6/oNljQGR7HlIrrzF1HmnoeYaBAiJRPJ
	 mxTyvtapQMZdCPUp4qHFPNl6B1KY3J1nj2dupYMF6GcnmVTxUiMHuRxOJcMfEbXvgFgnI
	 kj13ylb4xoMzbPvzJwRRUDD/EzKFNezzrtbNg1kbpn83u47tO2PCxXlRI55TU44kgyH1q
	 QF+sJzIa8J+aPSo3X+uE7GFPDLtgeE3Xi6+KMd5VNJDuC62YSzS4zrBp2d3FeD8TcPM5h
	 yBM1jK2SYoUOytTWQGwIjvtRR2oqtWZ7ePhVcN/gVGvjMoM4DP8sEhIJRYPMIrLu0hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770745;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ETOKvQ/TjInfLOX83E4AxZ4c49LkeJoAzUkyf0rB/VU=;
	b=Q1az8OkIDDrXIaSlN1peW68va1aFtXdU0iiGHiRCj6/WboDXqsNxmn1vABmQPwD4mH2P
	 i4J8O3zljKla8Mi3CD5UEaG9ZNV2LFiXoxYUT7OHZGstW1AGrIOTYVNl7r46H7/Bfhjaz
	 4aVwSZhMD1/tg7aMQqc+Q28C7q5VsOBswBOXBBJxGKc++K7a+ZO/hxho9rcfT2EIZ0mp3
	 7YYmIEr1gfqyENRh2xXeWt2cgysX47v//9WMW5cwYDcXo/zFXk+VRccAmGbpCegc5bBpI
	 dlp/9e6i8IntI1vHViyMRszkQa3+vbZ3uozgc0emyxQMaRPWFkMkXA6jbyfpf2dF8EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=n0arh5iz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5e+Oxowr;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCA4606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CCA4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=n0arh5iz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5e+Oxowr
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1ED2A14002B9
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:12:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 27 Nov 2026 04:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795770744; x=1795857144; bh=ETOKvQ/TjI
	nfLOX83E4AxZ4c49LkeJoAzUkyf0rB/VU=; b=n0arh5izrZKi9/VgIFmL7e2oL1
	bID4UWmI37YUyeeT60ApyJnJ6AtLxLSW+zQ3b5Gzd6hf9+Rc6aX+NUlOXVg255BJ
	JSq60jivpLkKKOHkNuxc98WJjMWOA59GpThmLxKOBPvTmStZMGtomsP3Xts485FX
	XdJyxD29xKrFHrvLVS8BU1kIjUqC5ECUdUDiw7ZpdKKAgPrgVUf7Yxl2eqRWyHe7
	4KwHzKroBBpcVTuV30t9dAVp3ZrmLY4hjrZE3rWzYZMpQldVbmU0RYMAet2BAtuq
	8lqnsHgjtSptKxYi91HSx9m25GQEFNI3ZCvedH6djVdbRz6SSB7XhvQZ7Ibw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795770744; x=1795857144; bh=ETOKvQ/TjInfLOX83E4AxZ4c49LkeJoAzUk
	yf0rB/VU=; b=5e+OxowrTHxG4pjnAzc6o1gY4Xdb0pDRuArQjyudbYboi9pKuyg
	AS8bPi3bE9NHh8Tg/ajMBaoYWxN5h2aB1+mgAhX+vTtLD6k4iQrLLKZvVwB1PwLx
	aN3RFAS5sWFBJ2UeyG23AsG+gl0IaUtFAOTxnsWjGHobLeDxXpbLVudBMfyu1aI+
	kKvySes4Hu0PX/iHMl92z+5eHo6KJlwx4F+lbXWTu+1gdI+eJMtGOXCQa0rJWDVY
	yFBOKc6O/q/uUBHvAE3Sjolho7L2ewvROgObX6jRC6yHwhRERPGse+to+RujcALA
	Ruvzh9Wc92Hq2T9qz02tnsUNI/bwKz7Av6A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795770744; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Zc6u3cFRRFDhINsN0IY8+wgjfHVQX++41zW9EWa4KqDvgK7
	1fwipQjuxRNd1/w6qOMmyKJauJZSxd0JTSOGn5t+sNni9Ad0AMk9pHd7U97f495Y
	iSLcuJQ4tsuAmFmN5aK00POkhcqoNIRGsS2Q71BRmi47ipm1knbNnUr2fnAbp+jF
	0958oKUGcQRDV51oSBSMo5+F2U5e1TpbTUQOT2qmUoM1O6A/WS7svoMg7DrThJ7G
	YXZ4Q1LfqHZvtPywD88Zt+mjqTz8zw5Jf+qpsHMPmov9xBGMm6uwhxvN+/s7CBzV
	Q0euXGKXRETsVXuS70iSG6a3fWX6G/p4KYxA0VQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qf9XJBJZ7KPvSkCwzr5y9Gy4tkyiGoIB65SSF/wP64U=:Bp1io4GlRTO+xbvmqZxo0PDKCvejoZ81oxBesPJEhKk=;
X-ME-Sender: <xms:d0kJawBJ1Jt3VemxQ2IuVUUGWJsZ5sjFiNmRW7DFAyZFPWXAEykSow>
    <xme:d0kJawUjGTinxiMCEz1weFBxamrnOkcYNu5Y8MziKQbz_SUdoIhD5bRdoiCZ7ESF3
    MaytXNsVnVzrrAi17a3E6uoPabImizV7f_8Ej9X-gSXkUfby14>
X-ME-Received: <xmr:d0kJa-CcB8SBVUTvMsQMcaj0XjXWPQVteeM9DJuiQ3PQyf6d79Zhph4BeoKO-9G1-5--XMWJNVmrxo4KlpPjQTxfAlII-hs>
X-ME-Proxy-Cause: dmFkZTGmbOa8stGUEaXppJOy4ztoIxiV/RYZxHpOhZw1e8Hn5oAgdgwuu+j0rlHeUE1Lsh
    YihYyOYDi+z+iBVmUmBR2l9uuZIJQsPihwJ3D2SopJ5zq0CEAxBq9OJecZHZKB6+QDNUBF
    xmQKxxzeZc1FylFmFzt9F4ViHREOPGBn87m/TzE0SgF4ET4S43gPq8XZFBt80Bt4JfAxJz
    OytNLFdVvfSTu4Es86ZAbEO/NXnVnunEEB7WV39PoiTC+MOXIau1WJczxMIIGZVAVkU07l
    f10jr5BDqDq6tfU3WjzrGtckI61BboOre4he0cTNRik9A87KGy8r3q6ND4pYdmdL6uxwVt
    KjEKwaw/5Cx4qXvQAFhhz196ITJeloUHy7i3tINockB6rbuf6ayy8HXaOGgHr7aXDYHyRi
    ulMWpW8wAq0ZUyQyft57wRYMOovBrxpOV1M2O+AYSpTGwr+gKD9Rtua9Pt5Fg+6G2u6oKp
    nJU5/jqKVTCmV8NIatjdEtZWzgPslr+bxDTzeOj9cms2eE5DlzfB2IdSpkltwN0XVLiaKa
    0JH+YE99BvQVIoyRIUzUMBAuR3hU5kmmR3P64A7G9S4iCEvronLO9ytvjHNdrwVbcv/isv
    hc0ioIZy4CqLKJ/IspdQApCZ2SsGwbvv8qL/WZMw6hpcidDQx9yCs9pTwroA
X-ME-Proxy: <xmx:d0kJaz9ZRXuUxHMI1AdQao2t3SD_XsFOoyMcoDb4PXz_B0EaiogzgQ>
    <xmx:d0kJa1GttDpyMMZaubLmc3XfbSi01ma_TNcG8si-l4kw-az7KhM7rQ>
    <xmx:d0kJaxN4fXJ4aD3CENJUzZxL1r5UumRZux5SxS6ArgxNMl6_cf4wpA>
    <xmx:d0kJa_fE40dVNzsI0YGMuHoq6C4BnvENcbC_Zebyi-srsrQenVP6dQ>
    <xmx:eEkJa2xruJkckIOYAfZoANF6QlwVoIwpr-A6zmMHE_2mZgro1vFbmbAh>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 04:12:23 -0500 (EST)
Date: Fri, 27 Nov 2026 10:12:18 +0100
From: Greg KH <greg@kroah.com>
To: Dickson Wu <dickson.wu@certik.com>
Cc: stable@vger.kernel.org
Subject: Re: Request: security fixes for 5.10.y and 5.15.y
Message-ID: <2026112733-gambling-twistable-dc4a@gregkh>
References: <CAFaZ9eogwNaXVeVhOrtz9montDVg6G8zYR8rOGdpZr26nHFO-A@mail.gmail.com>
 <2026112605-alias-passion-6781@gregkh>
 <CAFaZ9epm3Tcuz1Fs7wSOqECzZbwdwEYmwSxwUM72jPMZKZArvA@mail.gmail.com>
 <2026112723-jogger-splice-ce25@gregkh>
 <CAFaZ9eqpPdQ3fiu=gO28rJY48Jh9SqiRxdpXYtBzB5hcoGH7Nw@mail.gmail.com>
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
In-Reply-To: <CAFaZ9eqpPdQ3fiu=gO28rJY48Jh9SqiRxdpXYtBzB5hcoGH7Nw@mail.gmail.com>

On Fri, Nov 27, 2026 at 02:50:16AM -0600, Dickson Wu wrote:
> On Fri, Nov 27, 2026 at 08:05:12AM +0000, Greg KH wrote:
> > Thanks, but as both of these are going end-of-life in a few days, and
> > the final -rc releases have been sent out for them, they are not going
> > to get merged. Anyone still running these kernels should move on to
> > newer ones now.
> 
> Ah got it, thanks for the heads-up. I'll stop sending for 5.10.y and
> 5.15.y and stick to 6.1.y and newer

Do you actually use 6.1.y?  If so, why and what is your plan to get off
of that kernel to a newer one as soon as possible?  Same for 6.6.y and
6.12.y?  Sticking with older kernels is almost never a good idea...

thanks,

greg k-h
