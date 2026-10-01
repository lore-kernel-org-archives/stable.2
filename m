Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61454BF94F;
	Thu,  1 Oct 2026 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847794; cv=none; b=LCWMu3rfMU+E9AEXxPrBz4Kg89I8fM3mvegfhhpwX5DJ1NBEMw/heq8/zoPNvjdR/7Wyud/8IW+7xWrnYdcZFGuTWPUnc39IMmxFIA/66KIDqXaK2APwMgmk93qJkQvtT+LPE7g0GMNTkD4Bx3THtPYcRi08EMZQl7ahfHA6EM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847794; c=relaxed/simple;
	bh=aTOh2uYr/Zfwj4dE0uQ+wLez7SFg750t2JTGvp2gFos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKZB9uLTf2FEgd8MyewGqJTI1xWe0DpjqCxCI+P/QTLswOvXkprXYm3ch/8w+SRmBRYb1WUgOnQFeSbMclzbGSXzRt3QOuxE1EzvaM/OFmNybOfrNVV0knRq0IAVvYOKSg2Ri6nSVgtWpb0OOHtEwtBR8NscrhctRfX/WEuN0no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=T8FSFjmm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vfRnCntF; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="T8FSFjmm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vfRnCntF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C6B27A0090;
	Thu,  1 Oct 2026 05:43:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 01 Oct 2026 05:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1790847790; x=1790934190; bh=0Od092CjJ6wZcmKWTEOEVG5cubRv6lXM
	tEGzr08dRVQ=; b=T8FSFjmmuzIBmmRbmFIKNFDvilcgRvD6Xak7kw1y15A1zbq1
	oSiu6/zGaYra/hQO7scZafNcwYHTvjUP9BN0r1Y0Zq3ItfJJ+aDrR6uOyfffTYzf
	NJf1sqdcJeePqzCHl43cRNyAl3NWiBA0XZsQmZwZnWcFSs2ma890d6EvsO82E/sR
	H8ar3n6qlSrHpEEMPpXwWvr1x+96Y6zXJr8wjj6gxl7YJachCuojdC9aUqAUNqlH
	Yx7EQOwA1HPy6tdMqu750K3TbYyzsAziZGdHo0FQbho6Gsv/EVkYBB/qF3x0zV1D
	8Gzm9EL7YXMXlcUdwoV/bLwDifO1ycyVtAjLJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790847790; x=
	1790934190; bh=0Od092CjJ6wZcmKWTEOEVG5cubRv6lXMtEGzr08dRVQ=; b=v
	fRnCntFCZ8lvBDmQWMg98ScV2QO+gcYmjmHVVShrmlq8tnUh2iQi13RR58sKeend
	4JDU+DEd7UQPIFVRO+YYJndIFv492KgzGSMBSJkug5jQq8bUmRIVth7uBq9FVUF7
	6LB9JJR+QxX+7kJqnUKRYMoSipc3JjN+IYGeUten3nigBwDgtbhl1kYSdRhiCJj4
	R5SNrbq3w89T1N0q9XmcdaQLw2pXp2Xxt2qBC0n9ILb2cR5ojWN9ngqPBmcP1ksx
	YwfYToNfVKvHZa0XUYo93j+laIeQC0QQN83zwEUs1BpwJUPk4qHY+/4TrvQJdK+f
	j7tx+Dott+UG9VatjRpLg==
X-ME-Sender: <xms:LSu-apzClId97LjGUNGvHZHJQTUk8SQdjTYqLPmmNn9-CuMVP34UMw>
    <xme:LSu-aqwuoJZbMx7CgGKiiank0pZdViDOcljTNAku8ufLLhHO6CxJHHUtjz0yEyKx-
    _n01DBWZvkqwvoU_qX8AEUA_4cW1MUEPXFwH7uN4A74JsgJB78yqQ>
X-ME-Received: <xmr:LSu-ajYkyG-fiTJWNry7CKPKL4HvazpH6WYYQanKJl8hFzTSIi7pbwp9Z8Vv>
X-ME-Proxy-Cause: dmFkZTF/B8rAEk8rK7fLcnFT+wAiFTzXt5p+pkTnYvhBgJhFaxMk/WopBRLxJiEWF/tHOO
    1KmcqYdtveJEURgf/XtVP0YELY8GPEETynSJ0VUT51D8rgldYwF/xkGQevwXVOQZRJThnc
    op8FXp5aSBoZv17J816+tyMED7CYSDWHqQBEEGZAo6urqDJVWDVG+QovWI7+WwfKPFVb7L
    1CMHNgYvwfsLE7mOOo7R4Z0cqGj3iWbInOTWq5SpkP0ln8V4fDVXelp6YtX7RhLD13A7kr
    hvwF1/9MkHzK3pxbUR3i2bG2g56bycmAbRPpMvkzMEQuYIZoVKGyiid19xcVc+wT+NvfNY
    PMHR96YV2+buNan/EmLZwHsunhm7Ltp1t+nJ6kUoGyF8H9KK/7KBpqtjIAYEqYaCpyiTqx
    p/f2eseYRsV1/yTYIJCGwLFBDuNXXPJLFVh9K3xoGkGup+b4BdfIXh4/xFK87UYmn5Y+9o
    sZtbVWc6Y/8G3nMaEtHtbhpgptBjI0pvddJvIwHjH0zaAPVv/C75OjRXWInNDFoU358HlF
    OssT76vEVqoBQb914hh3GEzAZ4vnUpd1MY4PrDt3gLxgAZLRZa8pdU5roeLfdRvFwSlY/l
    E6UolqtaXnm86chnSp9Zof1GBww3le+NBFgMnPmsUaBMJzZkCNOennmKtzRQ
X-ME-Proxy: <xmx:LSu-arVIhKKcYzCvwsmOCD6p4n2xA2HrLiohaNzvjj5-MCjhEpdwWw>
    <xmx:LSu-ahjbul5O143xuqmU2petlQWQskOeWKhAYE8etFtjhrA3OVU2jQ>
    <xmx:LSu-apsa-PcaVKdZd75zrKuUs4MdV31FvvQf5yl-YFS2UdQRInzFfA>
    <xmx:LSu-aq7wMbZcgpNmAxmpkeIxpktVDy2E9CUrA3EtAR5vZySDUiTMgw>
    <xmx:Liu-aiZ_v2y0dDIOYLfW6gxBKHhCU2sPdV97RdjiX-Ej8J4Y7nfYGhDd>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 05:43:09 -0400 (EDT)
Date: Thu, 1 Oct 2026 11:43:07 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: =?utf-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] macsec: prevent AES-GCM nonce reuse after packet
 number wrap
Message-ID: <ar4rKxYd7Csm6l2t@krikkit>
References: <20260930203333.598733-2-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930203333.598733-2-Jeremy.Jean@oss.cyber.gouv.fr>

2026-09-30, 20:33:33 +0000, Jérémy Jean wrote:
> When MACsec uses 32-bit packet numbers, 0xffffffff is the last valid
> packet number

This makes it sound like it's only a problem for 32b packet numbers,
but I think it affects both? Sure it's unlikely with 64b unless we
start from a large offset, but a well-behaved userspace should also
rekey and switch SAs before we ever wrap to avoid losing packets while
the rekey completes (but yes, "losing packets" is not as bad as
"breaking crypto").

> and after allocating it, MACsec deactivates the
> transmit SA and wraps the next packet number to zero. Packets already
> in flight can still be processed after that.

So this is more of a race condition than a full "forever" bug. I think
commit messages should be clear about that (and that doesn't mean it's
not bad or not worth patching, but it's worth mentioning).

Once TX operations hit macsec_encrypt -> macsec_txsa_get and see
!sa->active, packets will be dropped and nonce reuse stops.


> The first late packet gets packet number zero and is dropped, but
> tx_sa_update_pn() has already advanced the stored counter to one before
> macsec_encrypt() drops it. A second late packet can then be sent with
> packet number one again, reusing the AES-GCM nonce from the start of the
> SA.
>
> Keep next_pn at zero after wrap so all late packets are dropped.

"late packet" is defined on the RX side, but it doesn't make sense on
the TX path.

The diff looks good to me.

-- 
Sabrina
