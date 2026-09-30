Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087664D6C3D
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790771390; cv=none; b=kp2atByrgybhDTqcaEH+4bj3LAGfDoeAgZcDALAT5Adx36nDlrvrSWRXySXmPmHsZmo0Y8/AS8R6xGsdsWYn2jc4oqQlusXx+Qapf7UPTayA4c+roNzDv230XSN2DbYZ+Uq7pUqwLl2bdxY4+0E2WR+xeVRXI3rU2DjmaHPI9oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790771390; c=relaxed/simple;
	bh=IWyJL2isfeHR8OOZXINyVfbouPVKCGSUgfAvzuW184I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgcRrcLv11ttO8Gh2MPttjbkam61WSKnajnM1lSdt07u/lmJWStcY7wx4EykOA+16Rdunc9OkNF+K8MfDWRSdA3hq/gu0IXQsuLV53ZSWV8PT9xGVVXXepU0OKZqo1vT2u+nzGOP42uawzncPd3yBGXs5GgWXiJ33IfUk5af0y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=oGRED6wi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JpzkYtXH; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="oGRED6wi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JpzkYtXH"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C67177A0769;
	Wed, 30 Sep 2026 08:29:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 30 Sep 2026 08:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790771383; x=1790857783; bh=CNJfAPl3oD
	9IXnM9hNHhYirPdDDPn98IiHjxO4gXc14=; b=oGRED6wix+ojFEoLkcZPVJJ8gv
	9gxxpLo+AmxHcwPQo+1XTLSx2o30KG0zJlD4XGTR4NhaGOcpRyhudJKE/5atLoK6
	uGSjzSh2s/STxyBWy/td5JiWlV8OWeVlXcpKf9dZNzaiZQXWxfZXlPuhE98i2u5G
	Lxbrna8DBZZLfQs1FyxtZxTKNPqWw1MGxitLN3vbAnOxpWasW6l4xHI12fDOPwbm
	C1Lx8CqnXvRMSFSTsnLr6xiQJvOKQjeFCRsiGRV+8q7kbxH9fXhFh3K+5Q3E8DCb
	9Cg2gwpf0zDyGAIv0T1d40/5OCcLv2uv+f8Ml8wlAyzUqvkkKljGQI3qjT2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790771383; x=1790857783; bh=CNJfAPl3oD9IXnM9hNHhYirPdDDPn98IiHj
	xO4gXc14=; b=JpzkYtXHh9W06cyrG3qTnus4QAqpS43GWPd3sxHamrgmlrEaRnk
	Lmsa1FWSu1M/VzSCpBn6/jlgEKrIWtDEEiWwpebN4HXR06Zu3f+OpuiH3s7pYb3a
	kSgrtGjpbkoRU868CgMaPeWBwY0LLVfBltGozt4BF8eu46wkfZpvl4HbewSLjqUh
	fOzLNfMY0D766CpP6zETvW2T100fqWx0Bo/mPRdYajauxXLzf4jXTADmCreh7uLv
	x3pC4jwHrK8fmxVVlBjFpVXg33X8a+JnkCTSS113bBMr/49G+GRWoBJIMV5/xWTu
	lBTHkwz9X1lN6C7OLs93oMYyMK9NoI1C5Cg==
X-ME-Sender: <xms:twC9auP86ukPIl0qNw42Tn1Z6hRqA4R1TP_RLPPDzIIblUF3MfGgNA>
    <xme:twC9alKv93XPc-oVV2I2sCOF_Glu_nzV1nfGI67rEVskDAufR0IuW5n6weUtI2xa3
    -E3eOWgAzq1NEqatzyxP8jR_csxqMJLGLPaynMO_g4Lkouh>
X-ME-Received: <xmr:twC9ag0UDAdE_EbzGUpO73X9vclnDpYNHGpRkD8SzAelHfzhbN6rezbut4Bxxum908TYoirktMQgNFQoY-I0V1aSEi9qBc0zR3j3d9Ejssc>
X-ME-Proxy-Cause: dmFkZTFXCsOVrdLiRbK5UbJH6hQv28aHP2TBNsUsVyeuIv120SkNwD8CrQ9G0XQTuWQJ+L
    5SZAl8HJS3rHMocOvj8/TslQF3pw7RJMuJmPtS0i0I+QGYMJdblfNN3SBBYH/qaNirMzfN
    b2iUnbALvp9PqAmD9p2o/DSekRfN8V0isKDcva1cqQyuDDv9vCL7N2OYV6V9C55gJ7CL8X
    vfD+CMFYFWAxppmqfS0L+z7ue/krNzMnzr+H3/vEYwtRU9oAWTNFBKA/47nHBdnN43Tcpr
    G7Xyrdi6yTDa2+LAegX9khMlBbvZqia6rRjlF3RPef6Ta9Vvd5GcESeKq5wl5UiMQO52Iu
    zCEyfMX09hy53eeEctu17Ec/mE5xBdHU4JBziQ6NmSu943fr5A03O3ezux59pC6RUpNMuo
    5WXyujyOa6JGKwZc7qhy0JtKo/SuZr9Fahl1mCJO66K5jW7odivo7Xwl0/QH6HUn/mWqoN
    FYWNZKSl/OpQRSYfVlUXsMC1PvhVk/0kCAH8WKidGU8S2qB+P9BZjaun/DFl2Sd3EhwFGp
    k3a9T7yW30ScetddXKcW2riZEW3bkB2W7jXGrnFYIqhUmMlu32y84I8o/jyZHOKAx4QAZ5
    7XUDix3nlL0KjseLp5SAE1Xpxt2wKBt8KLO43FrGpogAMccO6J13t9nwgI+Q
X-ME-Proxy: <xmx:twC9apW9nP7TisVp5TDDpSleHxacdg_YgzMYgfAEIMYs8h5gLdKlIA>
    <xmx:twC9aiPaui1OhHhCsadOBDh1V_Q_PzHMWsFnpm4voHku8sR7px_Y5A>
    <xmx:twC9as0ls8F_fuGQFYTeqRu7leiURK0fGMcAwS5qmyxMntAXGOpUew>
    <xmx:twC9amRhBNxUmhC8knoUtCzcvROXoNbs5GFKi29pkJG15ZM7fk3yjA>
    <xmx:twC9al8CjdvJ-mTT-V3FJkP9gwnmmNjoI0s7_6Xsh3BsWmHI9eb8aqrV>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 08:29:42 -0400 (EDT)
Date: Wed, 30 Sep 2026 14:29:37 +0200
From: Greg KH <greg@kroah.com>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org, damon@lists.linux.dev,
	Liew Rui Yan <aethernet65535@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y 1/2] mm/damon/core: allow esz to be set to zero
Message-ID: <2026093029-pardon-carnivore-8fb7@gregkh>
References: <2026093025-cadet-late-bf00@gregkh>
 <20260930080958.11031-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930080958.11031-1-sj@kernel.org>

On Wed, Sep 30, 2026 at 01:09:58AM -0700, SJ Park wrote:
> On Wed, 30 Sep 2026 06:34:35 +0200 Greg KH <greg@kroah.com> wrote:
> 
> > On Tue, Sep 29, 2026 at 12:13:19PM -0700, SJ Park wrote:
> > > Hello stable team,
> > > 
> > > 
> > > Please don't apply this patch.
> > > 
> > > On Tue, 29 Sep 2026 10:44:55 -0700 SJ Park <sj@kernel.org> wrote:
> > > 
> > > > From: Liew Rui Yan <aethernet65535@gmail.com>
> > > > 
> > > > When the temporal quota goal tuner determines that the goal has been
> > > > achieved (score >= 10000), it sets esz_bp to zero so that the esz becomes
> > > > zero.  However, damos_set_effective_quota() clamps the esz to
> > > > min_region_sz when quota->ms is set.
> > > > 
> > > > This is a minor issue, the main problem is that it doesn't match the
> > > > description in the documentation, which state that if the goal has already
> > > > been [over-]achieved, the quota will be set to zero.
> > > > 
> > > > Fix this by set quota (esz) as minimum as possible.
> > > > 
> > > > Link: https://lore.kernel.org/20260908135413.97570-1-sj@kernel.org
> > > > Fixes: 8bbde987c2b8 ("mm/damon/core: disallow time-quota setting zero esz")
> > > 
> > > The problem happens only when there is temporal tuner.  Temporal tuner is a
> > > feature that introduced in 7.1.  Hence <7.1 stable kernels don't have the
> > > temporal tuner, and this patch shouldn't be applied.
> > 
> > SHould we skip patch 2/2 here too?
> 
> 2/2 is good.  Sorry for not clarifying it.  Please let me know if there is
> anything I can help.

Great, I'll take that one now, thanks.

greg k-h
