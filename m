Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826061;
	b=A4rVt53lA4Ym1guKmwXleQPPmaG+S6psjj2JqDarXhJK7NgO5/J+aP5hYSddHoOs6X+o
	 u79LDrtmzbjccGvHWXB9EiP9QfyopEBxhi/McqUSMTwuXHfHU/RBW+3unf9pNCzY5Tlfe
	 Rn/PGgF5z+NtyqZsdD1hKPj0zidnAtnTjscl1xl5yPVeUiFtlYw2E79x4hR1JTk39p9ch
	 U9lqaHaNyvDvqwX5PrlExxurOB7aoogFfvR2pwNi1Rdu4JZZqK1PQ/epeMLhgw+Z7vvR6
	 JdSmXkRsCaW2k+wWJ7HTP4xq8HG4IxbrWnuKN7UQcpzFjQVHlHr0n79c4hHisxSXJQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826061;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jpFGPpxJvsWc+yR1AATTEDOFFhYrkMd+aw5etP91id8=;
	b=JB6Guw5KxQbwuTkNIRc0G/x7ZhSVmO2XOSn8SCza0n9tXGHxrs6hMouaPH6Il3jwEsox
	 xWWZbvymlrjW5puHZPyLJ+jq4Vzy/Dk/AFidzUsCn7KzmlYnv3tjtNOTpAvlZtBpeUia7
	 LS+yCJzb6Yjuzobw1sgdMJ3p5Czvi5NNQlTKqlbp0duXH2ocpk8k4sfIxd1SUfy5Pfimw
	 fJGfZya+dqZGiz7RvpJzsaz6ZP3Z3QEURb77wwhF4fH6gmXmYDa3hCE5tngos1pHMrrdv
	 XPdufq5A64NaECnR0BQ3CzKQUE/X+2pRzdRy8Q2nJUr8LSF/G0nMzOFFeoyY78aQYEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=i75XyGoj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RgR317EW;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5BC606C926
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 21:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E5BC606C926
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm3 header.b=i75XyGoj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RgR317EW
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8FFF2140014F
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:00:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 04 Nov 2026 16:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793826056; x=1793912456; bh=jpFGPpxJvs
	Wc+yR1AATTEDOFFhYrkMd+aw5etP91id8=; b=i75XyGoj6VKVeT6DMuCR2vusJo
	iDowfA4cxpA2HOXvd36rwN+OhoWBPNDm1GyjupuyQimueyW5YnCHfenNNMHYB0LZ
	I8Xkp4D0iOGBPKj/HylD/wWviQKlICQa3jpXzfpxSmERBM3eX+9qZZKqzyl1WaCl
	CmTN5aD2AYsVPvjL4P9TzV82Z7bpDhiTwoS1HvPkuyCZdirapHnvBgwU5edQZ7zn
	vLrhuuHHfl9lDKX+Jw5iUuY6e1L5fxI3X3A9OAfJ2D+F58wALvDESb0IROddUGN9
	V338ttmZNNXdqdVE3ziwD1rlcED0qvaA2kKZYHQD63rjkB0Uv3oMga/dkACw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793826056; x=1793912456; bh=jpFGPpxJvsWc+yR1AATTEDOFFhYrkMd+aw5
	etP91id8=; b=RgR317EWL0EhshEjn8Vp5rJUvCNKwdZnhHN8z4KSuNoKRZ4/PDj
	0vWmK5mLB9QH7ncZomXvwDBBD3DkX7waSzk9Xine5z3D7HFY7Ryk5S0I+8kY19Im
	dPwv3WDbsFm3yeKFqN+AhjfqaPTuahYYegKYQ6bVL7CNTjrO0h7tLP3wJdYVchmn
	zgYl3umI/pUEy+vupiXAsMuMpEBd9rdf5nRfsPpdNndLK/z5JVaBHT3ywChHtvO+
	qQvMoaguUJgIxJfH4cbBp/axj/D+o1qskwF66zN016CFTGu3tKO39Vj1202ZT1YN
	B4gVNluGzSzciPSVwApxWug58/Uh68qHJYA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793826056; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:dzBOKk+XMNojvw+DsezJMQ7Oa4jyd5W5h4EX4W9NDka3DNJ
	2Gk8KRBxJAObm7U/2h7MzD4q9Ud46BfRVMFPTKuR4EovsXpM/edixXpDUE72hYEb
	BAaYGFAF747pL6ym2+NEN8jpsSLJpxw2VSnVztCftoyFjjP/xl5Kkt66er8avSR3
	vZWDgyn0Fey0pK0CgrYI6+GrVIUlA3xU4qf3phI0rknS5YILifX5/faBy7Lpz4/2
	TpRnKzr9dGMy79PIVLSk6NrxjsT/sfPn2opOa3P0VJwUMxp0cc294FvhUQkKDDPR
	PMaLmbKPAyc2suZH5wBxneiouMh8yUbAx9c5eZg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:8WZNkkGG5Qqq12FckfQ8thyVO6Z7Lv2kHlf7aFARYis=:YBMGAioFGNqULhmRoXA3q4SHKoH5gsRvqIvsSdfu49I=;
X-ME-Sender: <xms:CJ3raqPcDXs-wf0H4XG4fPf2hwCcxomnDu-2RWFzTbJvXeIbpSOCnQ>
    <xme:CJ3ramxxhXIt94UD3yciKENt0GeoabE1Lbqtalej-TjV3DYG-ErsYhuVjMklBicz7
    kFBQWXYvz5qH2HboNd2pxcAWu4RLhKMKjbQaD-nyzCpvzHrDlw>
X-ME-Received: <xmr:CJ3raruIiYsm9NqS8xPucfkfkiG1ekHlQNwcILiU4UhnsfuL2lEm3_JIp2d9TQ>
X-ME-Proxy-Cause: dmFkZTG4wD77Kx/23uOAGmGprp4Q8UYI3jJjx2sYBbrtc7PmICrXUHYSOqK4AJ155Ot8pk
    D0gdj86/FgxC6bUDMBgRqbLXmRaGkQEXM/oGGPFdTJQRJ1BmFyOceu5CdEsCoYZ215OLT7
    yRG9EQ5yc0pQ6ykUWbVLmd/eHbA6qDb+NP6ASorVAnau2s/13XrHJAQfcQDIuEJtOytwk5
    8WhUs89Sbq2nI+5pIrs7pYrMrp43iW1LiBbfC5egtCDOysCEZS/0BSU3A4HXiURZsvZFcv
    LIElw+P9oD7aDL8KPB9p1fno4dS9hsmiWmO8xaznckONAItRpF+LbH1GFkmTUynePLH5Ri
    nsGNWkHl2WGXWKD1AbDPOTsqt/kht5e3GowW8BNgcZjQe1OzY2ZsZMhnbKEmxxmPzMBsIM
    6xVhAlLl6z/evteoJ+Cyv1Ukidm5D9DS/XtgiU1Dr7UKQKudXeSgKGeA0Ed3bGLmLCJ93+
    c+Fok+prVpSsXdxKUrlLJg3q4gsEmmnDYUPKFITZWNW554riieHWA+yD8Mr1api9M6eX1Y
    zhKAn0JnKNcSUYPNPmtwLPHIi7O1R7sJ8XSNxs9EXRaV/f5ltKHPzdrRJcwRsK33v+gG48
    lPmK+9d9Rfi/xWZMGzI69oinmpxt+6oCBjoRqiB+/aZKmwfrndWqQX328y9A
X-ME-Proxy: <xmx:CJ3ran6HYX-ip6uDDngUJHH2d2PZfo7YO8Kvhhbi4GWeQekn0kV32A>
    <xmx:CJ3raiT4VJDPPN8ZGIxZBUI6nPhNZTFpp75Hw8R-q0hof1GS240osA>
    <xmx:CJ3raurlet-QpEmtJUKtQSsGiARRnHJJEi541Kjti8vyMLLUKUXp-Q>
    <xmx:CJ3raoKzrhTvNRfkaR3OrJbQ7zdBdHRx2LJLK7j70SGes-gySOmyvw>
    <xmx:CJ3rauafrfQCeYG6ABRNYJ36y89mWuuQIKmgZBZBeUnDDxHvokeBIwNH>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 16:00:55 -0500 (EST)
Date: Wed, 4 Nov 2026 16:00:55 -0500
From: Greg KH <greg@kroah.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y 0/8] io_uring fixes for 6.1-stable
Message-ID: <2026110423-brick-bulginess-0f8a@gregkh>
References: <20261104184328.516206-1-axboe@kernel.dk>
 <2026110410-coasting-snowplow-6509@gregkh>
 <0503e43c-5a26-4ee2-9781-083f16ce5cb4@kernel.dk>
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
In-Reply-To: <0503e43c-5a26-4ee2-9781-083f16ce5cb4@kernel.dk>

On Wed, Nov 04, 2026 at 01:53:15PM -0700, Jens Axboe wrote:
> On 11/4/26 1:51 PM, Greg KH wrote:
> > On Wed, Nov 04, 2026 at 11:43:20AM -0700, Jens Axboe wrote:
> >> Hi Greg,
> >>
> >> Here are io_uring fixes for 6.1-stable.
> > 
> > Thanks for all of these different series, all now queued up!
> 
> Let's thank my tireless virtual assistant. Have the entire
> process dialed in now, we'll never miss another stable
> patch again and may even proactively backport things that
> are in the "good to have" bucket in terms of behavior or
> fixes.

Nice!

> Which makes me ponder if I should just switch the io_uring
> side to be entirely self-provided, rather than have any kind
> of automatic picking?

That's your call, I'll do whatever you want here.

thanks,

greg k-h
