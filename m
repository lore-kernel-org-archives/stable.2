Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10883485920;
	Mon, 21 Sep 2026 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000593; cv=none; b=Jgos/AFR5cLiSa99M343N02/VoOX7qYLPzbH2EKtx/64SxfMO9x5di55k4htSj9HQck3oYgQrGPwyOUsDYLlDdHjLKFdxhfzk4p2ufG9eMIz8CO0xejNv6clHe7VzqGIuL9zrhj33SnWtOI+irvMouCsYxQicVDyekw4vrqmnIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000593; c=relaxed/simple;
	bh=J0NhnTIdZfc1maI3V9gVZgNvP0uc8Mqeed1SKhJQI+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJPjA4M8UEZOyUtQ86Weeq5fbyCpY0xWVcb35m6dEbRxU092ode6E1z7CTTY4GZ4DlCFaqP9hWzyy0xmcBTNwcXKGWaI4xJQp+O7ta+RM6m8K+RpC8ScERfgn1CUGB6nGIr1B84T4VjqgeSelTPbTw1lm68p6PUvBZ35+nGs8co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnOe8jxV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnOe8jxV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB521F000FF;
	Mon, 21 Sep 2026 14:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000590;
	bh=Is3Db20YH22gFXuvTYxllbXmr5H7bNjAEg3XbePztsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BnOe8jxVXgmtwwE4mHMhrHcyfLevWWz4hO8HFL50XiqZUSYUIZqDc9fmr5ieuwQbD
	 bUiMqcdHbQRhs6y51wYxnkPZOpVtWwad9aBeL9ZSba6wwZnAS79N9gEdM2DogNjr/p
	 4FtsoxBvwJ9eWu/QaEj7EUdHBMjCvu+Sie4WPUgV9D78u4ZH7OdaIqxS/puXG9kZqn
	 d2916KeTyQwL2QYu51xGb6OoQ0Zje+HvRMe3IZpte1JbONm4ric3py+qp61YAztt0E
	 uXhDq2LfYp7T+q0jMRUcagv3Rwog15Wl7OS7PK6vj/yMvjoT1CDg5O4hht/gvRp8ki
	 oMOn4Q7AM96eg==
Date: Mon, 21 Sep 2026 15:23:05 +0100
From: Simon Horman <horms@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org, co+c09f7e87f6209a56@bugs.sh
Subject: Re: [PATCH net] rxrpc: rxgk: Initialize challenge control message
Message-ID: <20260921142305.GT13925@horms.kernel.org>
References: <20260918145705.1511737-3-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918145705.1511737-3-bestswngs@gmail.com>

On Fri, Sep 18, 2026 at 10:57:07PM +0800, Weiming Shi wrote:
> rxgk_challenge_to_recvmsg() copies the complete rxgk_challenge structure
> into an RXRPC_CHALLENGED control message.  The pad member of the embedded
> rxrpc_challenge is not assigned, so the copy can disclose one byte of
> kernel stack memory to userspace.
> 
> Initialize the whole structure before filling its meaningful fields so
> that the reserved byte is always zero.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
> Reported-by: <co+c09f7e87f6209a56@bugs.sh>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...
