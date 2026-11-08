Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794145665;
	b=5YTS3aNhwptf5goI5+154V14IuQtXZehZo2/bW7WQosZ8MmCY3F0PHq1vh8ph4v5Nw4D
	 zxjOsfvL8cK9brFaqpqfa42Ydc2SK42wY3NdTk7+ONpxbfTOkclIMceYKZMyKi2aPp/pl
	 rNy2RiOs/i3aq4sEa4Jw6rpGr44hfGJCgnWHUbtkV6nsyT/PaakY1AtwyAXtzVXEOWXhb
	 CpD272iitiw3vES+XySjkfJxKAuTs+G6kg1GHCbIecV45yjND+xoq2WgoIIgpeNgfz5EK
	 svm81TwWX1E84g1rR8nsX5EK4/VD2iBjaGU26bRIg4ekuiAOKCEeXTlujy5VDXrMwGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794145665;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=KQvKnJoLSad3X2bW2vkpqO4AzuTEcyx0E6Lwx/x6aqI=;
	b=qgGW8VXVKw2caLhlK35ZrmBN261oIynTAT/mwgA1GqiKKSFTz48DH8GW+s2YhfxSPIyH
	 cT4IrEmw8jmhgYcOcOvSXCuYyjeZ/UF/ASTOipog8dAC1jjl6piLUO3xGrt4Cc3abwq8K
	 ZDYm1ys0h0nefYmT+DZJr4Px4kLt7Ww6kQTtugpWxQaIgMgVPER0mti9y7/LQL9Pdavcc
	 HyQ5mPJBPBVYq65ixfn0Ipk4VzrI3VzUg6R4vVKODjTjDNyDA6L++/yGguAit4MUpW/2Z
	 aDCpwsbl0QKJ0Io8ZHrcuvXuOMTkmCtnKGS/HEXpQCVJ3BO56yU3wZcc5fKJMoc2klA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=Z3TP5E7D;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kJCnf2Hw;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAFE606A321
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 13:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FAFE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=Z3TP5E7D;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kJCnf2Hw
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 21781EC01FB
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 08:47:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 08 Nov 2026 08:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794145658; x=1794232058; bh=KQvKnJoLSa
	d3X2bW2vkpqO4AzuTEcyx0E6Lwx/x6aqI=; b=Z3TP5E7DqO6i2aKpZaXbN6De2i
	o672eW7Foi6MyHABW2rBUdqvkmRXL7sUouMIVFSpUH1Emm9CBJvYxY0KxQoYxDFO
	56pBfSpshSK6EBDUSW6gG3tA56pYx3346k3OX7z4jSxAZqfO0U9Dt2FPh/GKSFYn
	x5jyyW55QW4FBVqluqdwj+wVXl/LPS2BvpeXmFYNXRsojFwQ+dDuykiPqY1zQpIq
	3rWjsHIb8zO9Y4Px2Aa64B0Q9dcBmoIPFoo3EORXC1ZE1qQ0Iram8WWmfPuAmsw4
	HevCkF811qCqK79gq4lYNrK3kXVuN9ydYJ8MC3DBBxB6mJGD0FogL6f67ATg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794145658; x=1794232058; bh=KQvKnJoLSad3X2bW2vkpqO4AzuTEcyx0E6L
	wx/x6aqI=; b=kJCnf2HwNfFgmOfrh4Sz9oWn/cGLxGvSkM5fNgFoBX+zILglwHg
	znii6mr0e/yHxTJeL7Tyl7Kpt+Gz4/VuyOq6u6OV/rgLuxNRnRpM+SjXllSz8Aa9
	ftfkLucAnKPQbp74lnPm7EUgyuuL5d2MXrNxoCFe8Bdgly9fkOqIRiMscQbDUm3Q
	ACmtjnNqRjwNKpdVjIm5hsYnuhCZFX33LsS+OUHQD1wFXyahjzOJ0/MSoeFV1iJ8
	30CJo07bpGXO45A6KpxaPf1iQ4ogTh8KlnIDPvdUyVEbkZTYwck2e3xiyMefXVLT
	7gWKmhxyG4yqa+4897HyzNIlL70V9RLSRZw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794145658; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:juUOBFgfEstwDkv5x0JEcwR+UbulYTr60zsQersXif5MdmD
	JyP5qufWKlSCMGLa+8jpHXPQLzFBH1v3r9IxAlJzfewIN2epR9cTEfvjIlOMUnZY
	ebqv15tO3G69w51tyQS6G3IOthymOBw/a+2nofkFH3FkUXklWcVPQsHt/qEFN7m+
	1KXJvMrO9JuPsYsSBvY8aaAwHFXA7OgQZUdaIhghuTHZKIaC1D9Om3X2IZgGirqA
	LPyhBF+EwQtdP80GZu3wjIHmuMjE2L8phFRb//XhW0QUr7OHJXTC1MG/ob3R+hux
	Hw79vwFYGCcC8Beoxb1L/ytTurM6aExfBQtUsow==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1fxyD/GgwFR1ADWMmOKHoZ3pbQ2u2UWkZXleSXHnY28=:c7RQcdWh7amFtCifXvSYontS3T9BppkolwHGXPNbhdQ=;
X-ME-Sender: <xms:eX3wam_9ZyKjZF7jAF10KusY5Y82VcMkSMDv2nfSlrVgMPl2qjB5IQ>
    <xme:eX3wagvANW31TEdO3_FI3XZ4J5d2O7-SjEGAXfM0NdG--tuKDH2arIEitZU-Y4Kjw
    sbp8rEwp8TKKqzk_RkdZUwvAnhCCOzyKz962J1D_Y3ZsPnx>
X-ME-Received: <xmr:eX3waio1z4a-gGYS8OB6JgMbqKfR8jdO0P_FdKi-7eq0UWF1Q_7jjQP4PYBjw5sOCFYSviX2TtySBC4-Jl2S9lxUYA>
X-ME-Proxy-Cause: dmFkZTGhpSzRi1Q2WXN2h7g3cl6Dy6oPrM1NhbaZRCt2Iu5sR7W92dxxIbj0eIQzLkKiOt
    esT1CKqK7CRbhbd+EB5FRt+4A4dlB1cOddOLzMilqf0ZU9bW0WiYZRwBlwKaD29Z///jPW
    k9H53gmhYEycped1+eoYQOKjKEgMuvwwsC+Jp8eLej3gFaiZE8Tdr/ZV9dsYS6fby+BVD+
    /l6UxSUbRzlzufSWNp1kb0BcqF0xZCiiGz95mAOBH5aQmL+K3F45r8rabzGQUO7dINJQuY
    88DQKbzsV9fgy5jiwuTv4ePNGAlGbkdoArbrd3epOJ4w5i3veVxO60esfkVS9uiDEQDUSr
    e470pjIlkIThizzX3IWxtaRryUMoAvED+BXaQSH9rr3+9vRrUCXcpNOuGnNwqZuGzSHfNL
    RkpCZ7Z8VRLuu7hNt83guxMO+eyez4+GLdvhyyqG6If0mwvaFHWm+kZfnOA9R3I95LsX2h
    4cnWOWMIAHOfvIV+kcnDariPhxzGbggDbzZ9TZPKCjoij+T0UTIb8iKPxJvrAVLuEjWSZ2
    AHvC1YQv7UtDZG17OmDcsOdytGI0qWHgqWMD/RELd6W8wYecvl4kMdkvXlr6KaYU8qHonf
    6MQ/bOxd3OWqW02odPbWHl6dBX/J0HbPQiS1f4VAgggj84OBa4VyRmRP397A
X-ME-Proxy: <xmx:en3waspcbd9QpfH5tX6jZCp6AFnq0Qvp5Hg9enUnxak_sKOHRXX2bg>
    <xmx:en3wapZO6ZtMJ2xt3ic97ZEtTjp3Ek3v6Oyyigurdwii853A9q2efg>
    <xmx:en3wai8a7befyVXOySSFtSyIoIy9CEbNPww7AinROyLFk2g8Mm2Imw>
    <xmx:en3wavk07MHro-QcpvDklC48Obv1ET7ADPt-OPH0GO4rtNcXJA03yQ>
    <xmx:en3waunA9x99uAbhtCaBDd9KenHbUrmi1DKmC4vGTa9xEhZ99E5jgtF5>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 08:47:37 -0500 (EST)
Date: Sun, 8 Nov 2026 08:47:35 -0500
From: Greg KH <greg@kroah.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, aalbersh@kernel.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] fsverity: Explicitly require FMODE_READ
 to retrieve hashes" failed to apply to 6.18-stable tree
Message-ID: <2026110824-steerable-unopened-a5d8@gregkh>
References: <20261107051544-failed-6.18-1acb4fd2d011@kernel.org>
 <20261107190447.GA6049@quark>
 <au-Ux9Sunxhat_jo@laps>
 <20261107212633.GA137269@quark>
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
In-Reply-To: <20261107212633.GA137269@quark>

On Sat, Nov 07, 2026 at 01:26:33PM -0800, Eric Biggers wrote:
> On Sat, Nov 07, 2026 at 04:14:47PM -0500, Sasha Levin wrote:
> > So I feel we have had the Cc discussion quite a few times now. We really have
> > to limit how many mails end up going out: this last release had thousands of
> > mails which took hours to send. Adding more lists will simply kill the mail
> > server and will harm everyone.
> > 
> > We have solutions for that!
> > 
> > See Konstantin's writeup[1] about lei with filters like dfn: or dfhh:.
> > 
> > We're not going to change this on our end: the kernel.org folks will complain,
> > mails will take days, and people will be grumpy at us.
> > 
> > If this is really not something you can work around, then we can figure out a
> > filter to exclude your patches so that all of us can continue being happy going
> > forward.
> > 
> > 
> > [1] https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started
> 
> I've already started to use lei to work around this issue with the
> stable process, but everyone else will as well, which seems unlikely to
> work well.  This also effectively means that subsystem mailing lists are
> deprecated, as some of the development process is happening off-list.

No, all of the people involved in the patch that failed is copied.  It's
very odd that people who are not on the s-o-b chain would want to get
notice that a patch did not apply.

thanks,

greg k-h
