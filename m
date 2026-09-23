Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1872419FD4
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153504; cv=none; b=hE51B+Zn4OD0GfJDg3OsG2yJQJKxVLZ+Kdd4w9o/NxBEQhyg10AwfgGx3DnKBDc0X06hlF4MDoB0IFyRqr5Gfax/XSbUM9S9pulmMrj0L/iGm39PbyZksVlEADg8eNrO0q8yGh/11Map0+54nIdqC4QJq5sI7boVPkKsfpx4dkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153504; c=relaxed/simple;
	bh=8xFdmkERDNMYT9GJs1YpZbjEatl0XPmGU4xouAxZON4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efygbgU8BDh4TPbyXtHhHqrpuU2EePFt2zQYnLbgrUsrGS+habmHDVKr1A85Of/UhQa2JMTLpez8VpA8sthQUcqR/dYL9m69S9n9UyeJJXhy+fZ7HG4HwI2r7KnIB0MFAARA6X3MBULpdZ7Bov4TC7A8/tEe1siQfPC4YlgwL/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=J3f5XQ+M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LA/qgHSd; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="J3f5XQ+M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LA/qgHSd"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 796EA1400056;
	Wed, 23 Sep 2026 04:51:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 23 Sep 2026 04:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790153499; x=
	1790239899; bh=D3eh+PmAK1IoXX9JCxrv29DY1YVk9gtKxSHNcOJDJKY=; b=J
	3f5XQ+MdF6AzC3YQBNodjrriAgrsdJHwjKpl0VWvQQhtl0Q7rh3k4eISIQTR59VD
	X7dwk4h2Fau5/mEHoP5rMxKnEInmpTCxWFU8UEaXRAHaExWj1xCY490npoH7HZkK
	Z6US+DBivEt6IsIwLgdrS0GGjsjOwANtV1uDIgGumhaenE32r4hwPTENmkQXMVKS
	M4U1tDm5NJfuckVN4nZ4YQ0joxeu12tug9nFcrckM39HwBrYHRj8YyywIjTw/kdt
	mZW6Ank856zFipDdbHq2sapMzmlvbp9huYW39te//Cz1eazcU6+8hkwYkZb8UXD7
	l0OG7IUp2b2t/HoLLNH/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790153499; x=1790239899; bh=D3eh+PmAK1IoXX9JCxrv29DY1YVk9gtKxSH
	NcOJDJKY=; b=LA/qgHSdQ5EjPhF7VZnIelvCDFiCHCO7jGqvxlDFD2szW4rkHv7
	PFSwc6n0BuFAbYedDlEaBDrUsIm+QrpKXsJto6/oLViKQJTDgWgYZfODVRoR0a0F
	SuUwidPlNwi06dldYPyHsyFRYwCvOgfT1wT09VoiEDJkbb8Yk7hxmkZ6p9kpZ6ZO
	eda4gBhBktPs5j8JfbmzGDz0bcArm72+U5XNYYNPDmiqC3UJ3PSumbHyF/x9+S5w
	26jRBg6MB3Po8OhkhfwSHa0uhiA5Fb+YWN+BZB37tQgRT7rr3W6BB+eQboL79ewK
	3odTeVclDuOTnF28or1+5ryNc3IMM3RZqRA==
X-ME-Sender: <xms:G5Ozai1QxtktwCRIdtm-1MSYZggXA8AlHl7E3VIUDPeXOHbaLoig-w>
    <xme:G5OzarEwiK0aInjlA0ivfACwArU3YNgqpzGgi4K2tbcyCNB03VVKFZJxgMy28z_Rg
    6qbk-r2f1whruTxnX5Jv8D-iJa6SamjZFehshHqUM3uEiyKgck4lx8i>
X-ME-Received: <xmr:G5Ozaoi3MNQI3QjFzVa_sfOqDU1uop4dsplwYNU7hjc6bvoDignreqHJKU6c>
X-ME-Proxy-Cause: dmFkZTFUSbpx0TGPAZzpjSv66mNYNAzOMKxp/VEjwS4i7TjlCYXIKLblme5IkqziLb8XMY
    uIHctklO38TLIow5Ei7MWcvdtPVE3chKeKkEvyLIK42Ac590P8nqAMqyiDJsOF7PXwcQBT
    pnc1CafNytaroy+AE3sYb+xEAhLasXb0Au1NWkazi0ieOjXqhpwkmnUUOAKY7J+chG9iP5
    s+XqdsAOgOnvvu2qaL78tDoXqG4xtTJmAFz2Uo5nvoqib537HYb/PoACastiYb3VzQUjVN
    PQZSIMdWI5lL1Bc1D0yUB3ZjxDZFPbsX1P1gX/NDlD0hwPyPLHAAsZJuBuo2xZUMqlrzSG
    pT+02UiicR4Aixm29BLTkMEj4MhF97U+F+pDBpQBITq7IdOwDTGK00YqQYvr0ZyyzsPK2I
    lFItpV4nuV5XnzfOYhkB8qyfW5DGLblLJ8nh9q3BNXwgNguWVBuQC19NN661vTd8gXWVB2
    dnDo9vrPaIgpZ2cU40JnzDbyCh2uWu+MKLhJBSxxmwefInJBdfW+wBfolLDVZXbI+6jJX3
    jQXN0FTXwGPpWVVJV/GKQfEgpVjPFv3+2f1NlcdaiRjUXIsbJZUrmvQ2GbnU1daPuIKMp1
    GBlQrirZE9Z4TuVauroR0ndb4h3egrfjFdk+WOuoqCWvHyDu2Dbo22S9UlcA
X-ME-Proxy: <xmx:G5Ozau-d3GZGkIhcwwJ4rwarfrO6x71LbefpVqqzbgo3P1Tn51Pw1Q>
    <xmx:G5Ozanp27sXr-_EQ45vUJDUF4lPLtgSV1o6uiQ0QxoqaZjWEHxOA-g>
    <xmx:G5Ozal_5CSdvRIeifH9EKBeLqeQIY6QfTGGh75WibzY-ZRPn7Tq7Xg>
    <xmx:G5OzajU6c7YQDPUORQt_unQe9MJ4toxSO5cCteUAByWRqw0CpUYW5Q>
    <xmx:G5OzatLlqsdyMgOPjh_4S2GoV2Zl0iZ9it3Lk1JyWxdUVXnsFC_X0qI4>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 04:51:38 -0400 (EDT)
Date: Wed, 23 Sep 2026 10:51:36 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: Patch "xfrm: propagate extack to all netlink doit handlers" has
 been added to the 5.10-stable tree
Message-ID: <arOTGAw0cDSexlez@krikkit>
References: <arIzFfvyTnZnz-XZ@krikkit>
 <2026-09-22-daily-reply-0007-re-xfrm-extack-dep-chain@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026-09-22-daily-reply-0007-re-xfrm-extack-dep-chain@kernel.org>

2026-09-22, 11:39:00 -0400, Sasha Levin wrote:
> > You're backporting all this stuff to avoid a completely trivial
> > conflict on the nlmsg_unicast call in the context for d1ebd9081879? :/
> 
> Yes, and you are right that the conflict is trivial. The deps went in so that
> d1ebd9081879 ("xfrm: fix compat ALLOCSPI request use-after-free") stays a
> mechanical cherry-pick on every tree instead of a hand-resolved one.
> 
> This makes it much easier for us to maintain the trees for longer, as there are
> less conflicts we will need to resolve in the future.

I'm quite familiar with that problem. Oh well, I guess those other
patches are correct enough when applied on top of this old stuff.

-- 
Sabrina
