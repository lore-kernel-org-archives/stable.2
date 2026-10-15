Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69F2565119;
	Thu, 15 Oct 2026 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087113; cv=none; b=LhZ+oqlt7Hww9xK/o9SUVWHt0kYxKaZ1V8FW4dk2LxtDks/lvxjKu5ML4zLhFChCgH9oU7Rxgss/+HqP1RWV0nr2+/4j6zNKfj55Nw6W6EwDA1PKTNI4WKWTDyKNrYKDQWq0StncjPGFiAEM+sZzIMmKcqreHI00I3NV4FM4puU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087113; c=relaxed/simple;
	bh=qvPGO9pAyxBSZn4aaNFYkrTQgYwhVRcpnLkRfV0YLzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOs6iCXC0TiW5bOJmw1+T90057SamrhXhKw4mAsNq3hmnYqd5Jw9lbciz5dQRo5r4b+WZo15t6r7lvDEjX3IaENEyp722qbAIodza7PnyWcCKlSUjRM5xuQLLfmchwnSQ6DPGdoT8yQp1B7PO77CQ+QMdW/pfoa+2tW55GSW9RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+BYtSrj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+BYtSrj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178CF1F000C4;
	Thu, 15 Oct 2026 17:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792087107;
	bh=sw5Vs35NHiaOZ7dr1okYjwaIOYOwhFc/brSVUiHaWv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M+BYtSrjlClM7TXreyMdxE+xstViocEmiak/TbwCFFCvktQOhci+9Gywo+ijccSnB
	 6OTF3Ps/9DioxA0L6HeYBSDO3NntO2HyAR8DbFoZXbeSrNyLlRAQ2HilkaTB++WF7K
	 6aM329sP3dqdyj/vqZDuQzoImAfaMSBK+/UA6zckbvIhaZNzsOnyb7vllQ/qmjkROU
	 X6atAnnSx4s2bmmuiSrPDQCFJbDf5KbCkfmevi621I/rS2zRJvpl4GTjYWOKmYqkcB
	 hhpZY22kfVWKgNe2YMuveV7/ZQzxrqWU7jG35aaRuasr90tcohMG0KrcTN2DTwKIHz
	 E7h1P+/zBl5qA==
Date: Thu, 15 Oct 2026 10:58:26 -0700
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Brad Spengler <spender@grsecurity.net>,
	PaX Team <pageexec@gmail.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-hardening@vger.kernel.org,
	Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next net] netdev: Hide the netdev_priv() origin from
 GCC in netdev_from_priv()
Message-ID: <202610151056.DB82177C@keescook>
References: <20261015165959.i.798-kees@kernel.org>
 <202610151006.E2F587A60@keescook>
 <20261015103410.15ae1b8e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015103410.15ae1b8e@kernel.org>

On Thu, Oct 15, 2026 at 10:34:10AM -0700, Jakub Kicinski wrote:
> On Thu, 15 Oct 2026 10:07:06 -0700 Kees Cook wrote:
> > geh, for the subject "net" and "net-next" glitch: I've poked my 
> > subject-building tooling again, this should be for "net", not
> > "net-next"... 
> 
> :) Ack. Just missed today's PR but looks like this is 2 releases 
> old so not _extremely_ urgent. If you think it is we can also ask
> Linus to take it direct

This is only hitting one place (currently), but as it went unnoticed for
a while (GCC has been bugged for a few releases, it seems), I think the
urgency isn't high.

-- 
Kees Cook
