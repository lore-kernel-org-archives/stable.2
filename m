Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D79C4D6C31;
	Mon, 21 Sep 2026 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790011392; cv=none; b=dhZFfO32XaxQ11JULB/gYYibTb+t9uZEozbTUKYS04vpw1OuZ2ZTiiDImWJG2+T+iV3TYjjAqM4rkOQrvmwQ3Xn+9ZcIobMOHnOi0ZzgSF3aO0+1Swk8hHWacp+8Zrv4qEAugIKN1DmU7dVFs+zlupD0u27YNi3EWE6GHSdnNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790011392; c=relaxed/simple;
	bh=JiLNX98jI4OtQal/ERNc5yQcQ2+ueGwvfnM/h6YpGO0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VopYWHjGaHwEm5lTi+lHkCugejQSDuhk1OTwQCwFUMnFwkkqpmhQxxD//RgKkhKN/iv2T0q/wyMQKE6HtttgXl4Pf/CW3k5sTgot/C5rlHXuV2ojI+hf+/U/nvhbTb2UjaAHGq4KiQeKgLVujXF7ktKmmreANca+T57Zrzs+Yy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF/RajFh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF/RajFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A844B1F000FF;
	Mon, 21 Sep 2026 17:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790011391;
	bh=j0AIO/Y0DvvHriDnEfGdu7esqUAgVEM5Xu8m1k0M+G8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fF/RajFhhe6ROJzIqV3CiHpAlTCkjsg9g9NXpUMw5JigTRSf34paMjsKjolCG20lL
	 74UoZk2/i1D89W2HhNWKFA4QdvRyKd7il4jLOh2flVDHhBkpwLKpgf6sAcwEQpLEma
	 r775H5cSVsISMXoH29QvHKXJG56XEyI3uzuQ7J4XJcTJtqGnoLpLHvb4hTzjdsn2ot
	 W7c9sHf6r/kf/3b5cRxmTDVbM1ptpKq5Sn4ghZGRkDDnhwcicy9cL0GCUBfNPlCXCq
	 ugd9fskOHXJ3/OctQwjaNe4aUnbhA/4DtXGcBLX2Son/zx9dgIAeKlwfJr0+mya9RE
	 OzebGMP2ZtfBQ==
Date: Mon, 21 Sep 2026 10:23:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hyunwoo Kim <imv4bel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Neal Cardwell
 <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 net-next 0/2] net: Disallow buggy TCP transitions and
 IPV6_ADDRFORM.
Message-ID: <20260921102310.49c9e008@kernel.org>
In-Reply-To: <2026092048-splashed-trespass-d2da@gregkh>
References: <20260904033543.2635540-1-kuniyu@google.com>
	<aq28mdNpi3ssjgXz@v4bel>
	<20260919142035.4d0e11a8@kernel.org>
	<2026092048-splashed-trespass-d2da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 09:45:14 +0200 Greg Kroah-Hartman wrote:
> On Sat, Sep 19, 2026 at 02:20:35PM -0700, Jakub Kicinski wrote:
> > On Sat, 19 Sep 2026 07:35:05 +0900 Hyunwoo Kim wrote:  
> > > What is the plan for stable backports here? Does the uapi change rule
> > > this series out for stable?  
> > 
> > Not super well defined to be completely honest.
> > My gut feeling is that we should wait for it to reach Linus, and ~rc3
> > then pull it to LTS. Which would mean 2 months from now (mid Nov).  
> 
> Once it's in a released -rc, why not have it backported then?  Why wait?  :)

To be clear - it's in -next right now.

> > That said, I am personally pretty unbothered about local exploits.
> > There's too many of them. And because of the serious exploits
> > (remote, VM escape etc) I think people are not deploying stable
> > much more rapidly and with less testing. I don't want to inject 
> > a de-feature under such condition.
> > 
> > Adding Greg and stable in case they have a stronger stomach.  
> 
> I like to see the stable trees match Linus's whenever possible,
> especially when we have known bugfixes.
> 
> > Also FWIW I believe that Eric D is AFK at the moment, and he's the only
> > netdev maintainer subscribed to security@, AFAIU, so y'all may be aware
> > of more things than I am...  
> 
> Not any more aware of anything other than the normal flood of crud...

Okay then, I think we should just wait for the merge window,
and reevaluate if^w as new bugs show up.

Hyunwoo, if you have bugs in the queue that are solved in -next
I'd hold off on sending the fixes unless they can be triggered
remotely or from a VM.
