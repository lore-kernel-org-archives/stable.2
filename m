Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878583F3298;
	Sun, 20 Sep 2026 10:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789899071; cv=none; b=fu10CIg0O7Hp7j3sEei88K6E6YT+fprWD5M5InKhbHD3+mf8nI0hlSywEzH6FHm5gw1//LSvF0iLCFvpDxRdpOTgfP/Hkt/tF2wfhNquFRzPDSxruk7mzDd+6cH2VLLp73fuQxoltYRSlkJgCsjHDKeqL3NHiKNGcB2xc388MJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789899071; c=relaxed/simple;
	bh=2tIpJtLwgbJnNgwuF5UdNkvi2kLXZt5YsvQ/gOhIPsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjIDDsUnf9NDm8IMszsXozAMtyeh/yFVryGrs8XoczFpMtIl7+AJc9FK8oOTOZas7klFHTf6cgG5s+OUj3M4FLVjcC/LZxt7B5hogYwwwDbr1xcaN4mabDPy/DYQ+f7BCKNwCRxEhSV/brE7E3Hm1Vxu7Re5eeQY3D7OvKqCQ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lpCbIOcN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lpCbIOcN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7863D1F000FF;
	Sun, 20 Sep 2026 10:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789899070;
	bh=/26KFgiBxppLZooT5+1vSUzRmBgjxV2CEAJs4q740vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lpCbIOcNNCOYwjYxt9DBNZ7s8aCkf518UUtFj0cU5MaTuzQ4p7J6p6JNx0JW6y1Ad
	 H5un1/1p5NzZUqyg/90rBExmll9Isvd9Wu/KimFTTekOAiXoR5Umhb5GVm3e84+2EQ
	 JMwgoAlDEWZHbYKJRMopXHTs6Gw0UvVwiUDqCw5g=
Date: Sun, 20 Sep 2026 09:45:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hyunwoo Kim <imv4bel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 net-next 0/2] net: Disallow buggy TCP transitions and
 IPV6_ADDRFORM.
Message-ID: <2026092048-splashed-trespass-d2da@gregkh>
References: <20260904033543.2635540-1-kuniyu@google.com>
 <aq28mdNpi3ssjgXz@v4bel>
 <20260919142035.4d0e11a8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919142035.4d0e11a8@kernel.org>

On Sat, Sep 19, 2026 at 02:20:35PM -0700, Jakub Kicinski wrote:
> On Sat, 19 Sep 2026 07:35:05 +0900 Hyunwoo Kim wrote:
> > >   Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")  
> > 
> > Hi netdev maintainers,
> > 
> > What is the plan for stable backports here? Does the uapi change rule
> > this series out for stable?
> 
> Not super well defined to be completely honest.
> My gut feeling is that we should wait for it to reach Linus, and ~rc3
> then pull it to LTS. Which would mean 2 months from now (mid Nov).

Once it's in a released -rc, why not have it backported then?  Why wait?  :)

> That said, I am personally pretty unbothered about local exploits.
> There's too many of them. And because of the serious exploits
> (remote, VM escape etc) I think people are not deploying stable
> much more rapidly and with less testing. I don't want to inject 
> a de-feature under such condition.
> 
> Adding Greg and stable in case they have a stronger stomach.

I like to see the stable trees match Linus's whenever possible,
especially when we have known bugfixes.

> Also FWIW I believe that Eric D is AFK at the moment, and he's the only
> netdev maintainer subscribed to security@, AFAIU, so y'all may be aware
> of more things than I am...

Not any more aware of anything other than the normal flood of crud...

thanks,

greg k-h
