Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774768;
	b=BsfOYL2Km9A0aHb9gcDVR/W76QsZ8i3GGEf0hCZSRzqnmKSU5kUZo+QH9G4wZArHuj4P
	 FNvLqNrWMpioMX/qaIPSzYQZHIlU1GLUJhPzLe9aSIpyH+hUwva4PxN9dCUlV9u1wOdVH
	 DyophAr0hvBZZfvnIee+EtrBNw2ApcLEazLwMxE8/cs9OVx82GJpHMaJbMHId3LyIfsN8
	 MXzHo6YqkPd0jJOk83Sib1t8BWdWl3K58nW+VHdOyr9GQ4ro+1HI/I+Oz7W0N5KPJN6Sf
	 3dVx9EcufmhLujrLOHLIuHztuAZoTB88KXUJfUVyG6qchqaxNHNgqwl9SjX1RZgqNaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774768;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=z2E8cye9N7jDa4iULpcVRKN56VXJv3+yGHq6G/gPctE=;
	b=eiekEFpsX42kquWRDUlxeM18FkNDnOl9XIiRIvImTP+pSB2D/HWCjbYvGfX2EwWJEUlv
	 Q39jRCHo+2w4ezhYvQoGVucZxqMnC8aTQBHCDmZZ60c0JJKyuheTa6z/FOcsaYwbXZZlk
	 dhunPPxvXTIDNNrubm1zljF3i7Hbf7ZjkGjFWXl4eBSouPf6QpTdZwg9XIzYkx15u3vEO
	 qz6IgVzrJSmfqKqppbT3zwZcWPxPXl9x6MqD5u+whs80Y4fYfNmlA3bgKaJgT+nSrK4BN
	 dheB9TFVFlzdOXOV+2o6Wnh4fNeaJssh8kQgirTjAX6/rGDfTnRnl9qtcOhCgN+YehQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXjEXxGs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141D6606A31F;
	Sun, 15 Nov 2026 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXjEXxGs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4BF1F000C4;
	Sun, 15 Nov 2026 20:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774767;
	bh=z2E8cye9N7jDa4iULpcVRKN56VXJv3+yGHq6G/gPctE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XXjEXxGsZhFdiIdgAd9zdQZ5sg2zi9bU9wCcqLMbLpM0K30o2aQN6JSwgfIj7Aima
	 UFwVvHruhejgF6ZccneCpLn9aoeV6eZoj/eLW3R+LzWeXoDdgNGbDuLEQnLxlPhsK7
	 mfFgdWvShzoZaqHjBKdGQV0IR96LRF37IKjvVT4Au4gurr6hcDFV1kxOIDlOgC8Mqa
	 uC6YdDM28Mi6nhMJX9zR3wKxYzCick+pbb7Zk28IFOk20ucBk2YzX2rm8/FAMhd/lX
	 9Ti3pvxcE/S3wru1A2wG41hMRq8nMcF7A9jVC4ZyDo1F08OOfbav9TYkj3usOGI/gR
	 lAiXr0naZ6nqg==
Subject: Re: [PATCH ipsec] xfrm: avoid wrapping AEVENT timer thresholds
From: netdev-bot+sashiko@kernel.org
To: flashhhhha@gmail.com
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, jhs@mojatatu.com, netdev@vger.kernel.org,
 ipsec@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 15 Nov 2026 20:32:46 +0000
Message-ID: <179477476677.3136.11263726270247439987@kernel.org>
In-Reply-To: <20261114091239.780633-1-flashhhhha@gmail.com>
References: <20261114091239.780633-1-flashhhhha@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch clamps x->replay_maxage only on the sysctl path.

--

xfrm: avoid wrapping AEVENT timer thresholds

This patch converts net->xfrm.sysctl_aevent_etime to jiffies in u64 and
clamps the result to min(U32_MAX, MAX_JIFFY_OFFSET) before storing it in
x->replay_maxage. It also widens the arithmetic build_aevent() uses when
it reports XFRMA_ETIMER_THRESH, so large stored values do not wrap on
readback.

> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index f802899d3d130..d7fa63aeea37b 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -924,6 +924,14 @@ static void xfrm_smark_init(struct nlattr **attrs, struct xfrm_mark *m)
>  	}
>  }
>  
> +static u32 xfrm_aevent_etime_to_jiffies(u32 etime)
> +{
> +	u64 maxage = min_t(u64, U32_MAX, MAX_JIFFY_OFFSET);
> +	u64 j = div_u64((u64)etime * HZ, XFRM_AE_ETH_M);
> +
> +	return min_t(u64, j, maxage);
> +}
> +
>  static struct xfrm_state *xfrm_state_construct(struct net *net,
>  					       struct xfrm_usersa_info *p,
>  					       struct nlattr **attrs,
> @@ -1022,7 +1030,8 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
>  	x->km.seq = p->seq;
>  	x->replay_maxdiff = net->xfrm.sysctl_aevent_rseqth;
>  	/* sysctl_xfrm_aevent_etime is in 100ms units */
> -	x->replay_maxage = (net->xfrm.sysctl_aevent_etime*HZ)/XFRM_AE_ETH_M;
> +	x->replay_maxage =
> +		xfrm_aevent_etime_to_jiffies(net->xfrm.sysctl_aevent_etime);

[Severity: Medium]
The commit message says the value is clamped to the range "safe for
jiffies comparisons". This clamp only applies to the sysctl default,
though.

A little further down, xfrm_state_construct() calls
xfrm_update_ae_params(x, attrs, 0). That call overwrites replay_maxage
with the raw attribute value whenever XFRMA_ETIMER_THRESH is present:

net/xfrm/xfrm_user.c:xfrm_update_ae_params() {
    ...
	if (et)
		x->replay_maxage = nla_get_u32(et);
    ...
}

xfrm_new_ae() reaches the same store on a live SA through
xfrm_update_ae_params(x, attrs, 1). The xfrma_policy entry for
XFRMA_ETIMER_THRESH is only NLA_U32, so it does no range check.

On 32-bit kernels, MAX_JIFFY_OFFSET is 0x3FFFFFFE. If a caller sends
XFRMA_ETIMER_THRESH >= 0x80000000, this call gives the timer a negative
delta:

    mod_timer(&x->rtimer, jiffies + x->replay_maxage);

The call appears in __xfrm_state_insert(), xfrm_replay_notify(),
xfrm_replay_notify_bmp() and xfrm_replay_notify_esn().
calc_wheel_index() treats a negative delta as already expired:

	} else if ((long) delta < 0) {
		idx = clk & LVL_MASK;
		*bucket_expiry = clk;

Would rtimer then fire on the next tick? If so, XFRM_MSG_NEWAE
notifications would no longer be rate-limited while the replay state
keeps changing.

This looks like the "turning a long threshold into a short delay" case
the commit message describes. It can still be reached through netlink
with CAP_NET_ADMIN in the netns, including from a user namespace.

Should xfrm_update_ae_params() apply the same clamp, or should the
XFRMA_ETIMER_THRESH policy carry a matching range?

>  
>  	if ((err = xfrm_init_replay(x, extack)))
>  		goto error;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261114091239.780633-1-flashhhhha%40gmail.com
