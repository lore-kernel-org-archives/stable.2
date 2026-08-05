Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419193E315E;
	Wed,  5 Aug 2026 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919232; cv=none; b=O+FfIOYSYV+dsuPWf77jV0oaOs7UNlRvQwYSZzs3up7/ZOhuKG5rLUH6ztfM7LyfH69NG02w82ysw14EDtqFbzj4JgVaZdIEg+rB0cWmND9qqwpBsJnkS/elzqSJHQKShG/uHLdJg2gM82JwiuA/DdSm9Ws5XmJs9uwQZkQozQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919232; c=relaxed/simple;
	bh=gcB4lEiCOaCymtow9fcgrR+qMGvRF0K+NeIA+CgVvm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ks3QGssrHk5SeuFa0HFZO6aM5BfkUNgbe4otG7ZstJcQ7bl4npKbb2yf/PL+rov4+LGv2Der7A6JPfVoGOQS1hBKfMOB483MqAvBEfIrXiU+YXa1BT9jtzDIth9+QBqAUDJRX+AbIhuz/oYNLp4QrdBaCulSed1JxX2ligOTeWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=caQutrPB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UEHrnR3h; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="caQutrPB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UEHrnR3h"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C7F81400100;
	Wed,  5 Aug 2026 04:40:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 05 Aug 2026 04:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785919230;
	 x=1786005630; bh=u1PjjoI35Ws2xcnYvX3C+TUHtz2ZlmJvAor96QUKabY=; b=
	caQutrPBcR1gVTSgqUwmRD0b1ngXxoBSauOcvTBZ9uwUj3hqmy+a9JNUtk+SrC4a
	KQblsgJIs58BfYrt7++ezQjszUsLM7gQdhfHa+YzeBlbGLEWVhRJKX3J3jU/m5tH
	SdHjI1j7QzYirYU/B+nX9qfS6A3y6DQL0yQTofqC42WRDi4eYSMzF+/qgnLJ4q+8
	Cd8FqRAUUbqgpwBYc6vXRyLmKQqUXan1/y4YTJqcWOq/zq1ZsnezzYO88fqy4Kei
	rTewqxZDE7iEFmsmXn8fQ2tqvJNQYklBRsZrn9gwG+4HWlsUTGA10vdszDd0Y5C+
	+0clVaJNfwkUxruZl2nL7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785919230; x=
	1786005630; bh=u1PjjoI35Ws2xcnYvX3C+TUHtz2ZlmJvAor96QUKabY=; b=U
	EHrnR3hLojszPayrT/Faxv9wJDgv2t+l1UxaJQeNH8Aab4QCGjixBVxiV/vCrK8G
	YYv3IRpLzxNEzIknytwWEfyNkcNKxUhKuIOvoRZAb3cFqDn+Hu5hkifpxEqHyftm
	7Ha4yrff7+H4VytseLxI7cyS8oZcv5F1VGAohT3pv3j+amjTnNfqNQ56sT68SODr
	/NwR7cnd+vQmwGPs2v46XikQxq+idEQWqu5SH3rsLgb8+JIkEBpJh+umOArk0nxg
	GMnp4HHO/xnYt9YPL9qyCCQkjakXKFZxvuGLOuOzxW8rTkjPEMaKkSRym0Xd90Yq
	g0GLJD2EIL/R28QW12Z5A==
X-ME-Sender: <xms:_fZyaqNbY6M34iCEp7c2HCE-vA2zy4gFsb2d2DyyuL1ux1PccwuCuQ>
    <xme:_fZyaoi1BEjqj95GtcN3RwjwLrue310wIKU78m6wz5lf-uKny74Y6I_AFQH7NEXmB
    bfPsksDKuZ6muPvApzWfjzij6RrcNddoEpIDUnm99oRSOmB21goUrYd>
X-ME-Received: <xmr:_fZyalkO9RA3txJKipcYEa9BYfrCQ4Z2HEvgcLEmLCtf5hRmayZv50zMm7Cp40Cw6MRRNUF8gkWakl4U2jFctMV9RKNi6ck>
X-ME-Proxy-Cause: dmFkZTEAsYWjtkRA35fl88tIw5zGlye6xJH0Q1nXL32ic3sSb02vOCFHVqm2lipD9RQO5P
    9WG9J1X4W/aA5IQBsYZ/O76E0cghup/SUqxMUwOzc9S0H4JZwgYXLmN/UuPQnx9J6JvQGL
    2QlXxPmn/FbES0V9ZYAwEStrS9K+CHstwVie2dVjgkUiMUN9YoQMylN7JYR6UFIXU19POU
    MW9PrtDF2CQ043c/0EsXqAWTvm4tuhkvo9gVBkd//gxSIaBWrQWoJgDg3mi9iXskJvcN/K
    z8l0yKsPU/7JCOY3bj27Sw9XDDqzlPokTwHpKuaoGl1UIB01kxqJx6UJA0ctWGIpsintro
    0dicIZqjHM1GdR++NU8xOHGTBty+7r0cTN0fj6n2ZoZ+vmrccdRQIx0/9AYnZC06hpNZhU
    4ub0A/Z2KrU4FfVQTLNCzFapQgfNkEHGpqbHDOxQPavw+SAQKMpv94mv+kunn8wgc1cypy
    A1eHdJjdExrCMQgpke3wTfuBttkdSanTClUFSKHqQzopyoGCpRbL0/hE5SQ7YQf6fjoxYx
    1+BwTV6LD+RXYUyU5Bmo6Tdr19CWIsWZvh6s316eRw07se1NAEjabX5J2AiPfIlWmHLTnS
    3zD8OqLebw1N9qtEZs0Wd9x9iJnCaHdgKJY38X77lMdHR/uVOYbF+KvvzBUQ
X-ME-Proxy: <xmx:_fZyatORJwyGSeEp0KMRIz92gV52agIAuR1AkX1FoX9ezct-81ZItw>
    <xmx:_fZyagE6HGVGdiTfNHVGG6ZJUZ6gKt5gQM3mhSPZyEAm-2eKpQcA1w>
    <xmx:_fZyajutQkcpzmK6PbYRgGWiC6kwO7olqOO1fRfIkDkX1KXAqUIRLg>
    <xmx:_fZyagRkMciGU8HKmq3VpgLD-_2hvcIQAt8SF7KuJCgIKtaG6yAgig>
    <xmx:_vZyaom1qQNDq3HMggwC1XIK7actS2aCI4Z55xrgMIKqFwgol6PN4Iik>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 04:40:28 -0400 (EDT)
Date: Wed, 5 Aug 2026 10:40:27 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xuanqiang Luo <xuanqiang.luo@linux.dev>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	paul@pbarker.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
	masaru.nagai.vx@renesas.com, sergei.shtylyov@cogentembedded.com,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: ravb: fix use-after-free in ravb_get_ts_info
Message-ID: <20260805084027.GF346309@ragnatech.se>
References: <20260802090750.116215-1-xuanqiang.luo@linux.dev>
 <20260802121727.GA2716708@ragnatech.se>
 <20260804180855.75f6c91c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260804180855.75f6c91c@kernel.org>

On 2026-08-04 18:08:55 -0700, Jakub Kicinski wrote:
> On Sun, 2 Aug 2026 14:17:27 +0200 Niklas Söderlund wrote:
> > > The PHC is registered by ravb_open() and unregistered by ravb_close().
> > > However, ravb_ptp_stop() leaves priv->ptp.clock pointing at the freed
> > > clock. Since the netdev remains registered after ndo_stop, get_ts_info
> > > can still pass the dangling pointer to ptp_clock_index(), resulting in a
> > > use-after-free.
> > > 
> > > Clear the pointer after unregistering the clock and only advertise hardware
> > > timestamping support when a PHC is available.
> > > 
> > > Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>  
> > 
> > Thanks for re spinning this,
> 
> The AI reivewer has more comments, but at high level - why unregister
> the PHC when the device goes down? The clocks stop?

Yes, PTP clock is in the same power domain as the ndev. When the device 
go down runtime PM suspends the device so the clock also stops.

-- 
Kind Regards,
Niklas Söderlund
