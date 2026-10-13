Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CC83FE35F
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887875; cv=none; b=AJ7PpFs6UWSHDDiti7CxWU1NaCYdwPP8w5VCduJttWsPfth/xnM7i45C9xTSg4U6gU7WkQGqtjDqDzs4Ha/syqG+2ojgn/QEIXTqkEonUp4H6FgTvb2UVfAyZa+ke6ugjGBLWk7l0KVvstKlWXfopabxn9GNpvGw/yRjO7MCAZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887875; c=relaxed/simple;
	bh=/ui4dXjobdz5UqRZsY830TrRCZjFHMZMThYR8piTOSc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omZOxRST4rejM/KuhR1EADe9refaya6F8GvbXo5Xi4LrB32NoFzSMsWab/ZkEYMqlCKQ3Q8QErS9RtildiX1p8fHY8ijjg+chLzdk8I+CoSM4i1uI5W4nh0+Kehtm3meqBzIAPzBiWP20HwbRx/21MvmCkxT4adWJ+KIkfuonQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=nDZac4d0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u7/L9daB; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="nDZac4d0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u7/L9daB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B2DF37A00C3
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 06:37:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Oct 2026 06:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791887872; x=1791974272; bh=4iKO3Hw4MH
	2oKvAYWzgzWMSA/7UnI2ec5ORW9Jd+MK0=; b=nDZac4d0ToSiiq4pbCm8ZKp5DZ
	d+sRXerbTugRdnFpfe09yFahXFz3QS6bOFqqVYvaINtW8AYYUpggFEjqItNu+2HH
	ohw1OOhXHDpaPB+y03Synk2SLzJa6VW2nEv38Q3tvi9mX50xxcoNVFfOABxBV+cq
	zFxDHWLKCum0fng0nUdRjylY6FKgCJCauWuM+U5XuglOsMia0DqFhy1PTiqqHNQe
	oLrlbmS0/LoxHGuG0t6w1eYv3Er0a8J657CT4nXH4gudh8DLE5LBCBhwQiVX28eC
	ZQyQCoA7kRml3Gq8FY5txoMsRTiegPj1bZa3XHujqhM4WpvpTqIy0U1Yq1IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791887872; x=1791974272; bh=4iKO3Hw4MH2oKvAYWzgzWMSA/7UnI2ec5OR
	W9Jd+MK0=; b=u7/L9daBkBT4Jv6Ym+/IdhmRDbNkpDIhzfK7VPsGdavMxqvXY9E
	74s58ovmCs7hWQhN5Goip2MAeL+1gG7JZLI5RdnWsYYdqp3/r+wS1BZJriWWhOrx
	Io17IPHvOvSXRs1RDfGmVx4RMKtRGSrm/1p/34ALa3wG5LSVxRoTRKZH5+9zU3bS
	iWNqPOHQ80VjkiTNge31eMDPJWJJw2KYxLjuQuN9fcEsvxsCxGR+j46qylaarFfh
	fHI0zQG5ZJIiNDM0QGh0UTVyj/WCZwsVhzcbSKlp7ebJ+4OnEPPTIorCLITxQNi2
	ppiBaLTBo+QK+mQLlEuQ8AZn+P39ftpNCPQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791887872; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:oDHNp3vz5HGVYFIKpLTnFNEhYv0Wgtz6iHbXryydRGhqneP
	K/eFzY8PjOgfhgCL75Pya6LxcUNjgwbgjt+WKDpcNwTE95FQkSUNwQYCYo0NQY1P
	unabvLTIVIE33bNZUW4h4wCSc88Bn7/DKQYiV9e4PABQ37tBujta3EHwJsLUI5uP
	syEg/Z5bgCag4AdoyZZPSLjmNcGbdKzXgufl1l8oDkQNdYvNA0RvNa28Lup0Sudq
	0h7dYXjkycpE4QYNaEzQoG6doYfgJsBn2iX2rh34btCRO68XtPXn5vUk9kavtcgz
	T534btTphe4u0I1Xon3qrOkxNacxz69o3Aj+Blg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:b9tPCqaniAXal9g0usUxceyCVrssoCHEAztGqWbW9FE=:/ui4dXjobdz5UqRZsY830TrRCZjFHMZMThYR8piTOSc=;
X-ME-Sender: <xms:_wnOat6CKDxPQ7ewupZNPLK9p7QzEIsakAlilhqo7ZButVLs8jGZjw>
    <xme:_wnOarqKUSbanm6dhOlM3tS044Uk7s5g8ih7ZTySLOnQ9lCgbcQtp6lqQOapgQVf-
    sQM6G9ktr1GEjGkvy7-Y0sxnkGH7a4AB1197buNmPaSopId3yk>
X-ME-Received: <xmr:_wnOaoRsyFake5IX9PCNnhQqWk9JBGvcXAfDkwa-bgf3crnU-PoXKxezkrbuOEf0BENcafjBzGaQmZnUJ5TjIieq_FrUGjNkG3IdItVjMfk>
X-ME-Proxy-Cause: dmFkZTFPIMnMVCMZsP0EpKFW4O6lgv388cE7op1Tp5P4uL/JRnh0btbxq8M1slUHL+9oX0
    eB8EnwDZ/WQwSWswc4Fz6bjkM4oA1mm6RJoIMFtyiXrVZSR6+PdWZFxu0Pnd2SYAjffsXE
    EhLhat1fBf7z5S4PwxEIo8Rbl6zXGOTRdpcSa1zopVrTz/7P77WQaX2OPcylcX5JAh9iid
    yosZ65JuXD9EqvKuZ1GUeoI9O5B+H1RioVPk8SYzOYicgOYYBuo5izVWnUGRSEi8zSeqyN
    bNk/OETj2d/rt2IaWuDykdd3jtirebCi28xVlpAaeoaA6S8FRuaYILPHrwmKn+e7jayrET
    durfl6XfcKTLcvUt1/OO+sxvlCJFb1AtG9JkhFIDgUkJA4zleHd2H3tgdQ8IKsjfidgl6F
    Nbhv4h7fOo9kHj6tB6Xx1j4rnVsLpv1ZDLrhoF4ftxosupGX+xCiS3VgCZr1rvlUYY6Zaf
    lklNm82TMa/mEfiYd1COZ5TpLaiISVo7OWmVnEUEsqkbDT3sjbxRiO0ThBCv6jZ9SOCV08
    5sP69Lw4c+bliw9Zmp2Un2MGpZEb5eE3I1wflyqLPBL5nI3IKfuLOlwve/Sr1rMjgT+jVG
    /dXAglsMtBKYMFIaZqOthr+rI0jpSoaWmL8H7sho5Qcc0iRFeIAQSUM0qCMA
X-ME-Proxy: <xmx:_wnOant6nuBeRj1FpvBkpCjzCIU3X0w4-5vWgQwxAyNIqGLJn-rSPw>
    <xmx:_wnOagOcbkjEaZFaJLbOXRSQei4IvjpFFm9x1fsixWNj2xBxswjs6A>
    <xmx:_wnOapVFeYeopRYT1l9AIpYj80oJ70Wdr5SlVAIo0pz-rrBX701HGg>
    <xmx:_wnOagiAFfiZAVkJn4J9Bn1HuNsaZx3rNoGct5strfHBKzGTGgs6Dg>
    <xmx:AArOarMZAcNc-w7fbsJLXw7Jpj-vI8CfkCQnEh-yxpk1hGtiHRhzyN8g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 06:37:50 -0400 (EDT)
Date: Tue, 13 Oct 2026 12:37:56 +0200
From: Greg KH <greg@kroah.com>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	stable-commits@vger.kernel.org, xiang@kernel.org,
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <hongbohbli@tencent.com>,
	Chunhai Guo <guochunhai@vivo.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-erofs@lists.ozlabs.org
Subject: Re: Patch "erofs: remove fscache backend entirely" has been added to
 the 6.18-stable tree
Message-ID: <2026101340-upcountry-wildland-6ebf@gregkh>
References: <20261013020044.2527207-1-sashal@kernel.org>
 <as3drCZLoTUPS_oC@XiangdeMacBook-Pro.local>
 <2026101352-subtract-deflector-a77b@gregkh>
 <as3o3Q8X-2gK2HyF@XiangdeMacBook-Pro.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as3o3Q8X-2gK2HyF@XiangdeMacBook-Pro.local>

On Tue, Oct 13, 2026 at 10:16:29AM +0200, Gao Xiang wrote:
> Hi Greg,
> 
> On Tue, Oct 13, 2026 at 09:59:58AM +0200, Greg KH wrote:
> > On Tue, Oct 13, 2026 at 09:28:44AM +0200, Gao Xiang wrote:
> > > Hi Sasha,
> > > 
> > > I'm not sure why we need to backport this into stable kernels, as there
> > > are users who use EROFS over fscache on these stable kernels.
> > > 
> > > The functionality works and it's a breaking change.  Could you please
> > > kindly tell why?
> > 
> > Why would you have a breaking change in Linus's tree?  We never break
> > existing users, so how was this ever accepted in mainline?
> 
> Because the similar + better functionality "erofs over fanotify" is
> already available in the recent upstream, and it has simpler interfaces
> than "erofs over fscache.", so we don't actually break users as long
> as one of those functionalities exist ("erofs over fanotify" or
> "erofs over fscache".  Many stable kernels don't support "erofs over
> fsnotify", so backport this commit will make existing users using
> old stable kernels have no choice (no "erofs over fanotify" nor
> "erofs over fscache").
> 
> The commit message is already described well I think. 
> 
> > 
> > As this removal fixes known bugs, isn't that a good thing for those
> > older users as well?  Why would you want them to run broken systems?
> 
> I think it depends on the importance of the bug, at least "erofs over
> fscache" is usable (and it's used by vendors) on stable kernels, but
> it's unneeded to address every edge case found by LLMs since I mostly
> think it doesn't impact the real use case, and as I said, we have
> a new unique interface ("erofs over fanotify") now, but only on very
> latest kernels.
> 
> Also there could always be breaking changes for various reasons (e.g.
> obsolete/dispute filesystem breaking changes these years like
> bcachefs, etc), will these commits be backported to all stable kernels
> too?

Sometimes, yes they are.

But this makes sense, I'll go drop this patch now, thanks.

greg k-h
