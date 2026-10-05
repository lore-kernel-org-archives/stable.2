Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FD24418F2
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791200828; cv=none; b=gDrpX292Kv6ZIWjvICNuO9I3g4JDYbKisdp9TnIj1L8UtLBQyqSQLlIcCx9/d+GDmz4OdAGeVqjSPuDTlUroCJ1FZ73Vs23ygAC5GPx2WpskylogN+2z7ecoocd95XhuI2KjjchCfxDy224Q71aHJOS67uffJNf6hhqcivWIW6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791200828; c=relaxed/simple;
	bh=Pep1lzOX4NvtlkaFDNnRrFmn53W/taXQfFCjTHcxqwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwZMLWOAtQpFr86Ezr+xmWouWiSCEXO52w6IJ92K6UaRukwSzkX0eQaJW2QMo8IY5PhUelo57Bg/VNpjxOnYubDwCxGWywYwaOx+Jh/qJ3e70Dy3t3kz75Fc3nDtfxOwjf6oQPPG5+uDbpRxPBFFDs3ZMSrmQJy6WV3eGbGbce0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Jkmnz+yR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oIBYNHx/; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Jkmnz+yR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oIBYNHx/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1480BEC08CB
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 07:47:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 05 Oct 2026 07:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1791200824; x=
	1791287224; bh=BHKsQD6Urb/QtOqgcLb1Qe66saKaumexNB/VA4PE5/M=; b=J
	kmnz+yRPp3keffDyNkrmF7SzKDL10Jbvd7U5f9Mhrsexu56mIbYe7dUz7YRzXaYJ
	E0X5Lls53ZGHU3nmmOvr7eK2AtGJx7p58VdWtsh6oapwyG65kZYxT7CsUK61GBfJ
	8EouBZtBdZqlfDS8j/oDL4ORkaH+tg6bKHrEFzbD+dG+Y1Bh9zZP03uLb/EMPbHS
	rl7u464ft1jFWBXcfidlM3h61nI0BZPsPCQ8ytYu/QzJ8CRKc1EhkBTA1wliclFo
	3XMFCMKQho8uTjEHqHwG8u3jgPml31H8NrDTndUQcYFTULvhAPbYyYUpfwHHlQiu
	3tWkKuh97ru5NnQtxw4ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791200824; x=1791287224; bh=BHKsQD6Urb/QtOqgcLb1Qe66saKaumexNB/
	VA4PE5/M=; b=oIBYNHx/QYL9mHADZ4QIH9TJodJsf6WR+AQUKlOn+Zcq1+ko8Nh
	D3g5FvF7eTUznYaSEvxRGgo82cGgBuwSg/DWdqrKUyXKesxp9QFRxRdi6s/G+F+e
	ECql0e+heGjTg1oda3bJTCSqRDmO/GBRfz6SNwkqMPz0aBgIJoLVLZHkNtxWowBP
	tMKZXcS8DawfXu0Z+rSgjt+saEQBT17js3gCMSRVuN/VGfOJH4FMy7bG9gPdq7Uy
	nIO+cZ0JVwbXh2m8D80QUyauGxPgmP7PmSdSQBc+yYIRN83ufmbuxB6dHUzqtif3
	PkjjIw5HlRmx4YeQyGT2JLEYnzysMHkv1/A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=queasysnail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791200824; d=queasysnail.net;
	mf=PHNkQHF1ZWFzeXNuYWlsLm5ldD4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:lnigj/KI1vBiXJF1y3JyDrSqwBAhMzyd4+vGNFykPWfUXqK
	dEzCIyGEgi16EUTv0ducsYNAKBYqeTMYDva2Po0oeflm9IWUVy4e2Ib1dJkZ+Dl8
	igwj6KY2pnEbCEhULEj6Av5Jl++fSgzDA+cvC1iPyv27ZimdddxbtlK6gS3IACjp
	FhxBcYsPMy+KmYjWu5OpN8dkGYRisd7xWAPCPMa6XynF9n3b78w8osLh20UUMlNF
	UBeKwRql77Rql20dQNQ79MInob4wsZCEJYvH16ptp7d1jEFJysraD3mhdhWOPPPF
	N/0GT7psJa8W3HSWCeKknl9P7aOR/z6R15KEXTQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ydbqmc8/i15cx+VJRs0+TzRHd+IWS7DUvDyx2WBxJfY=:Pep1lzOX4NvtlkaFDNnRrFmn53W/taXQfFCjTHcxqwY=;
X-ME-Sender: <xms:N47DagpXwZyZed5ldwiPLErnYni0N7_DEGmhNizC30X7ipA2M2-8og>
    <xme:N47DaoI1XuHQblrqaKjCjZHXimEoN9GBb-du3EloiQ5Kc0jM3detgIV4mhz2ksiHp
    4c0JixVo9_DC-Ra8oTjQTKxTEIVlaA3jW-xbT-M1LPjZVuWDdlzUMk>
X-ME-Received: <xmr:N47DalRRHd7tJtnfxF2K2Ug8pnk1Tyw6ux9xqKkcKAJJDD54kpjuiWCflJAA>
X-ME-Proxy-Cause: dmFkZTGZtJyTLqJ2GH6KpNW1wDraWqDX7NIqVoJ8AZk5Zllfmy7fbo0pw7Va+m5zqyiAD8
    UX++pjJ8dejMcieB03aUsoWWwsWIq/yeZWWccRkskYwLLKQNnZ+c+8h91FLI/Clia2Dz/X
    WfXjvRdypdUMbyj4+mxnl0Oa3qd+mIszzuJj7HxeYLfCpN6X8l8jJfQnmgAF3QYoI2H8JP
    xPtuEUdXLbIGoOI6AQ0pWAxElW2fNknadfYR09rWN8KDkp0rjIXmjBZ45wpN38HIRlUrQ1
    VnqAwj1gJBpYkQMMJbEHyZM5AUIMUNh35HsDU6FeBLb6CEwIrtMMi8fMEtGoL5wf96H1bp
    tWmg+KXn9lPpbSlHrEqD+c0IVULSOzBRh+pr9PVhGN3XPOd9TTNVzGtGLFTPYo0cM3qbzB
    MGzj1xOe2vqpVWa2URJuCYdVo7lwEIXVMZtaPo5/8z8Fm8T72iUFAhspJlBc8OTYk0zY2+
    9CqP+Z4/uk5GE4A9IFU6YJIP06QmtywhB82xgU6WwxNTXNzddxygQ/buyzerI61y1PbC5Y
    S+VRvFTUdFe4GKnFiI0wVB2iuMWsv9nYjXof5LZ7r+EGin+MVc+OaHFMFlKrwgqpLZA3Lf
    s4f0vKMRRNuSPbz8qkHvuy9P9R8Ai8IY/J7v650GmkDqVr/tScKDUL1OxgxQ
X-ME-Proxy: <xmx:N47Danty-b5I-fSll5OmQRALjVDxPu9bb8AnGKUDItCwHKVOBSW_Og>
    <xmx:N47DamaIrfbJTG370U46OFeEIkLwszX-8-7C4zGIY5zNGHBkORgkLg>
    <xmx:N47DatH45xkFugWWsAyQETCaZaZYYGpQ3d1sYUPgOBFwCofYGX-TCw>
    <xmx:N47DaqwRwFgg8f0HoF4UVud9pRzkVq5K0Q171L9rawGqPI5Hvst2zg>
    <xmx:OI7Dallz_EaiIIDenEaHQsEh1sjXkBv-lvP_E2GIqsOwBHGFHwVuVHX0>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 07:47:03 -0400 (EDT)
Date: Mon, 5 Oct 2026 13:47:01 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jiayuan.chen@linux.dev, imv4bel@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] strparser: make sure __strp_recv isn't running
 before tearing down the parser
Message-ID: <asOONdAf6gcon6MB@krikkit>
References: <f06217a9b95b7027286c7df21336e67e334c3e6e.1790674872.git.sd@queasysnail.net>
 <179089956689.434549.15887968585245541352@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179089956689.434549.15887968585245541352@kernel.org>

2026-10-02, 00:06:06 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: High]
> This is a pre-existing issue, but the new sync here depends on
> strp->stopped being set reliably. In KCM, that store looks like it can
> be lost.

I guess I'll add that just to make sashiko shut up.


> [Severity: Medium]
> Can this oops for a parser set up in general mode? strp_init() still
> accepts a NULL sk as long as cb->lock and cb->unlock are supplied, and
> stores it unchanged:

Yes, and the notes in the patch say that.

> All in-tree strp_init() callers pass a real socket: espintcp_init_sk(),
> kcm_attach(), sk_psock_init_strp() and ovpn_tcp_socket_attach(). None of
> them overrides cb.lock/cb.unlock, so nothing in-tree hits this today.
> 
> This is headed to stable, and the API and documentation still allow
> general mode. Would one of these be better?

No...


> [Severity: Low]
> This isn't a bug introduced by this patch, but the comment above
> strp_done() reads:
> 
> /* strp must already be stopped so that strp_recv will no longer be called.
>  * Note that strp_done is not called with the lower socket held.
>  */
> 
> With the new lock_sock() here, would "must not be called" be clearer
> than "is not called"?

Would anyone actually do that when the _3rd line_ in the function is
lock_sock()?


Something needs to be fixed for the last 2, and it's not the patch...

-- 
Sabrina
