Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74813955D1;
	Thu, 25 Jun 2026 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384979; cv=none; b=hIz2T5FpzONdx02R8cDvHbhfkwM9eZKCxooq34ni6uSrnOPYYHzMFUb9MFvNG/leZxnQFJO4g9hI6akpPrV1XxutkATGkbypM576s/W/wLhB2c7y9m6LmjWPE+39PxY2KIIQ0ted2y7N78HlnGaMw5FHuYzNkAJMmFND4shE0Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384979; c=relaxed/simple;
	bh=tGWUn02tNG9o+chTsHDI1dr4SgGq5r1Akfmi8wIJ+dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5yy97z3z58esDJpVRv/JPZZX2jixP8H1xuELWfIC7sTsC8PIF4C9bwNpes0lnrlBwwuZWRBDUQLxamGElr4Jw5AkyTtuLLhmN+eQijspQnYiPOymHdF+uy97n9sFsJ15nSDN1S8hv/JuGfWDhv+h+vRy4ozQPXF4YzDebJoLlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=p3FUmEUV; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="p3FUmEUV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pPsz2JsGGZpss51JTCJrMmTpT1mDu8FL5PuRq05nfa8=; b=p3FUmEUV7nVJ9mIInkCU4X8KFj
	xQloqlkunCnvUzYsHNOb5pY3YYtF+Ifzpn2arUzJlt28y42LPlszM5pU/iSZZH4E/SaxleWkD47bm
	RaYCn8fLWuNFao4qhYzbnqPZj3Xv/ciSDOuLZZNk7SYmQoe0DkzPTP4pJ9eIP0KSr863FYw4N7nux
	ILVOzSRo3BE7hE3TvBJXkdzTw9o9IKfq00tWDlVtZLdEDtj18+2wplWyCZBLsMZUHd87Vd9NlPtfb
	Rvmy77JCfga1dSsV/k63l1VexGOr30o4F+OahXmA7Ph4jMHnHb2tMFqrogi5LGffLS91BphSwEJ5O
	L7ccwS1Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wchka-0039GK-0X;
	Thu, 25 Jun 2026 10:56:04 +0000
Date: Thu, 25 Jun 2026 03:55:58 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Amerigo Wang <amwang@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vlad.wing@gmail.com, asantostc@gmail.com, kernel-team@meta.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH net] netpoll: fix a use-after-free on shutdown path
Message-ID: <aj0HCBYX97SydzlW@gmail.com>
References: <20260622-netpoll_rcu_fix-v1-1-15c3285e92e6@debian.org>
 <20260624192513.33023e54@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624192513.33023e54@kernel.org>
X-Debian-User: leitao

On Wed, Jun 24, 2026 at 07:25:13PM -0700, Jakub Kicinski wrote:
> On Mon, 22 Jun 2026 08:01:23 -0700 Breno Leitao wrote:
> > +		 * synchronize_net() does not protect the worker
> > +		 * (queue_process() is not an RCU reader). It fences the
> > +		 * senders -- the real RCU readers -- so they cannot re-arm
> > +		 * tx_work after the np->dev->npinfo was set to NULL.
> > +		 */
> > +		synchronize_net();
> > +		cancel_delayed_work_sync(&npinfo->tx_work);
> 
> Maybe we can avoid the sync_net and the comment by using
> disable_delayed_work_sync() ?

I've been thinking about it, and I think you have a good point.
queue_process() is the only place that take npinfo without RCU
protection.

This is what it happening right now:

CPU0 {
	run tx_work (queue_process())
	npinfo = container_of()...
	while {
A:		deqeue skb from the txq
		try to send
	}
}

CPU 1 {
	call_rcu() -> rcu_cleanup_netpoll_info()
	np->dev->npinfo, NULL
B:	kfree(npinfo);
}

Then, if B happens before A, we have the UAF. That said, if we make sure
that tx_work() is done, then we are OK with rcu_cleanup_netpoll_info

I am not totally sure if the order of pointer zero'ing and disabling
tx work is important, but, it doesn't seem so, any order would be OK
for:

	RCU_INIT_POINTER(np->dev->npinfo, NULL);
	disable_delayed_work_sync(&npinfo->tx_work);

Given that npinfo is not read inside queue_process(), then, order doesn't
matter.

Thanks for the point, I will update.
--breno

---
pw-bot: cr

