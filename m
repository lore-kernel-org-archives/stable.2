Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094232;
	b=Su/DkcVUo2fKr8v0GzGtVBn88QurDBwYMmMH8KARDh/4vS18wVQ/zd1uRKdizFhyoHif
	 wCK/bvnZekkeZl6D0aulvDfwKyKf4Vt6NlhriO6XTB74DhDVvd0RVDJ/StqQ6qngwldIQ
	 EF3l5R0nMwp+qMKujragsv9RzCqWZXFkJg6Iy7dUiqoxBfGyY8UNF06proTfFcThMTT+s
	 yy5GJe+imGNxwhPzbyiiKRMGc2AwLZWmS5LlL+zk1aPMqvLZTeC1dTvF56b572O6lW/ZS
	 nYva2RWjph+9ir5yZrO+pIpaqANXIFc/hfFYWQYgJVbs1dMsDSH7fqrgjsuQELJMLww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094232;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cbtuAy679Vx5DoCRLgBiCoNhOo/U7L9hTUeby+Ckq5g=;
	b=VobtsL7vF/ZtPuFfBfznoXpWH45gOUdvoFrhvFdJ2dPJ1e9TiwYFb+x9ua+00GGnUVmi
	 /iHGVmk9tU58OxYc6KbBx5pPpbObTHlPAH/tdo61yEOrz3GMuyvWp7/3kDbrg8eT3l+Wa
	 JxIiSct+SrRwhU9iApwqkJ2B6PzfuxYrZXRO7ghlGzlAbxACDgqVaqHjU8pfGUYYSGP/5
	 ZmZnvDjOxefF1GhnZwxIObAJz/SG5vGl3E7JeeS9XvV+FgJtRU2KLQBVvKIBV2OKSMBVe
	 30zPksYSZQUJwlhF/7+g55FhySa6H1YjXq+PrWH3LMdk55okoWDmFJ08qlp+4I7uqkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VVTNROYG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D0D606A32E;
	Tue, 27 Oct 2026 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VVTNROYG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AB71F01825;
	Tue, 27 Oct 2026 09:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793094231;
	bh=cbtuAy679Vx5DoCRLgBiCoNhOo/U7L9hTUeby+Ckq5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VVTNROYGw+gItX3qfed+Wm+aoJsMhRwAp67hu74qKhubz/zquwRJQZoEUhfc6kok0
	 JhawwmrFhwnHEwxvI8QzBjMFElr9rXfldXQTCk58AKEiq5NzQeCBXPCPA4i3Bzr4py
	 yBkmeOUOObr4FIl5t5idXBNqI1xYa1tYXOHkmiCXcsr0oRZ071yBleQ4p6VZPgo9HK
	 HdN5UxFaWvypiREpr7UPccXpnIgNUHbk12BJE8jC8v0TtttOT4bcPcBd3BlsWgATae
	 OjhOF3jZWrubNzKXoJQ49P3Nd9zETCLD+kp0aiS6RddvYIpVEaNSDe0KFBPyj32oD0
	 inCWBhGS9Yirw==
Date: Tue, 27 Oct 2026 10:43:48 +0100
From: Antoine Tenart <atenart@kernel.org>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Zhou Qiuyue <n0ps1edzz@gmail.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: raw: fix use-after-free in
 rawv6_send_hdrinc()
Message-ID: <auBs0Xn5yVJ1NtdK@kwain>
References: <20261026044808.613-1-n0ps1edzz@gmail.com>
 <at7uk8gXtzNufuQF@fedora>
 <at9sKRSEJLVGj9OK@kwain>
 <auAAmqXcxmC6BDrR@fedora>
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
In-Reply-To: <auAAmqXcxmC6BDrR@fedora>

On Tue, Oct 27, 2026 at 09:38:34AM +0800, Hangbin Liu wrote:
> On Mon, Oct 26, 2026 at 04:07:40PM +0100, Antoine Tenart wrote:
> > On Mon, Oct 26, 2026 at 02:09:23PM +0800, Hangbin Liu wrote:
> > > On Mon, Oct 26, 2026 at 12:48:08PM +0800, Zhou Qiuyue wrote:
> > > > diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> > > > index b965258cf..bdea82543 100644
> > > > --- a/net/ipv6/raw.c
> > > > +++ b/net/ipv6/raw.c
> > > > @@ -654,6 +654,9 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
> > > >  	if (unlikely(!skb))
> > > >  		return 0;
> > > >  
> > > > +	/* l3mdev_ip6_out() may have replaced the skb dst. */
> > > > +	rt = dst_rt6_info(skb_dst(skb));
> > > > +
> > > >  	/* Acquire rcu_read_lock() in case we need to use rt->rt6i_idev
> > > >  	 * in the error path. Since skb has been freed, the dst could
> > > >  	 * have been queued for deletion.
> > > 
> > > Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
> > 
> > Doesn't this change the device seen by the nf hook / used for the stats?
> 
> Should we still use the old/released rt->dst.dev after the VRF output
> path replace skb->dst? vrf_ip6_out_redirect() said it allows the nf hook
> use vrf device.

Right, but then in the direct path the NF_INET_LOCAL_OUT hook would be
run twice with the same dev. Looking at other call sites for
l3mdev_ip6_out, it's not clear either,  __ip6_local_out reloads the dev
while ip6_xmit does not. I'm not sure what is the expected behavior.

Regardless of that, the change in behavior (if right) would be worth
mentioning in the commit log.
