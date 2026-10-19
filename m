Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.245.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444495;
	b=IXzPrL7+JX8d12IcCFnEEX/28BguWIFoQT0GZKo2hiC5iN+OP8XmIt6H0t08bJnxycmM
	 kMMLHKR1c+79j8kyGHHgsc6+Z1/oF55NhXJzB9soU1n9ExvGhqf+2djZZ3EV0svFb7D3d
	 L3pWGNeta6Xn2l9K32kcninTAbGAt/Lp9I8SbzgJA3Weq13xCbb1Muj92CIvSLyGeg5vY
	 kef904MEZsY7TxwgtIFc/l8D7veIIYLO6AOM6I7FatuJFIuUOgHVGM52+w5iYaTUaXHc2
	 pHhiUThdr7WsUrX/QBQxpyXhwrzFoiTWhIdM0tY0E+ui1B3XdKTkjx9SSjf63wFNcGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444495;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Fc+mbDm2DgYQ1VrXoQJ9t7BbigOlRzpc+tzJi7I+sE0=;
	b=xDO156Dh9rxDLnOhUxnc02J9TGqEKQoP4ixhFkvH+wPskxcPkv2Kelh2bJbbe5W3SLTp
	 2qpks8DVoJKp9s+fKUCtMKqPVDQtu/rQQDvswQuzsXP5BhrrdHktKbAXWr8Rc2gIlADrB
	 mnyTa3aKmdzUPB5Ko4rMzm1akAmgLcI98fuDSTPHUO/jqsGG1dR61PCCX5Nv3n27JApRx
	 AY+wgnNjWlmXARyf2vQOXQrHKgDvVLZuEvAWIahWpYFnWNHb7jq6Jj959Jw5CqwQPBxGu
	 KmUSE/osYxghhJFq0GJXhQWGjPxqMLrVUXukHlyulwGcbMv9ZWBNGcY19/bzObhXiYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=strlen.de;
	spf=pass smtp.mailfrom=strlen.de;
	arc=none smtp.remote-ip=91.216.245.30
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3010606A320
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 21:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3010606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B561660515; Mon, 19 Oct 2026 23:14:46 +0200 (CEST)
Date: Mon, 19 Oct 2026 23:14:39 +0200
From: Florian Westphal <fw@strlen.de>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
	security@kernel.org, Willy Tarreau <w@1wt.eu>,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: Re: [SECURITY] netfilter: nft_byteorder leaks uninitialised kernel
 stack on 6.12.y with CONFIG_INIT_STACK_NONE (CWE-457)
Message-ID: <ataIP3xm8DDtO82v@strlen.de>
References: <179239012164.14465.16534329674629579851@gmail.com>
 <2026-10-19-1-daily-reply-0008-nft-byteorder-security-declined@kernel.org>
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
In-Reply-To: <2026-10-19-1-daily-reply-0008-nft-byteorder-security-declined@kernel.org>

Sasha Levin <sashal@kernel.org> wrote:
> > Stable maintainers: would you prefer this minimal init patch or a backport
> > of bb061d3de4170741?  Either works from my side.  The memset preserves the
> > existing multi-register ABI and is the smaller change; Florian is fine with
> > either.
> 
> That commit has an explicit stable+noautosel tag, but now it needs to go into
> stable?

I did not consider this earth shattering enough to risk nft -f croaking
and refusing to load the ruleset.

The change has been upstream since 7.1, i.e. June and I am not aware of
regression reports.  If you prefer to wait longer: no problem...
