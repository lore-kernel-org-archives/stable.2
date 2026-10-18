Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDAB3DB64D;
	Sun, 18 Oct 2026 20:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792354728; cv=none; b=qoEs8zWCTMUaFn9CRmBqXpATA4oNXlIiMiIbP4rOtQNvyI6zuRUIEDwSWlT/7+hu84g3Ncho98tJuyeVJDSW3xjXXtspOPzJGXZDINB2TEpATyNS0/arMa2lrcSP/UurYjhNsjvWv9UmVeI+W4vEj1BX0GRINblRcx7FQ58D41c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792354728; c=relaxed/simple;
	bh=59OVdo2PjY95NdoYTMPvuuAFu/PyWOUVQ7pqOJbJx4Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uhuYLbK0iGMhR4iT+oEy/cWNx+asBKqbaMOFRGd8WfXmecuMMOlbhSVY+w7AfuGZhqb13e7Aohltkkv03/CqCri1Tt7gNTlyeTRBYtK9lKA60q/No8so5IrBxTHg1Qsql94cN+JYXf/8EI2MGfk2+nRnw5JeabYxzLzZIUV1UJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXlitjtr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXlitjtr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F32B1F000C4;
	Sun, 18 Oct 2026 20:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792354727;
	bh=KT5XCWY4ZCcqX5OOgQs37cKX0hdmIu5lGuJWPTgP6cE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CXlitjtrVyMbUHK+u3UkeRlE1jNibOC1Ibn/kJ8guxq/qAPjH7SMsNlC2O1rb352d
	 XfIFjKBoUo1uplZVoXql+6PjokdiZruqQMY3iuTL2DkAO8ZYklbh1WXFP/dPUnF3RV
	 DcoPbpW6WfyAvEPkOvr9tr0zSgDkRwRqu+4rh9O7E0aeX2M5d9bajcRkryThkTwlTB
	 Rty01y1oVTvcrflBSTUHeB/9xjyA4/c/crTX9s9bsF0GYqT68LsrQxWk73b1+XOMMn
	 G7lXGONpMqvDFv/BZVJk7DluuLfUkc7Xo0rMPyclygLMDKclkVPvc2YAwxkXtCEU/C
	 SVMYA6J4cgWMQ==
Subject: Re: [PATCH net v2] net: ipv4: add zero check for snd_cwnd_clamp
From: netdev-bot+sashiko@kernel.org
To: kj2864@nyu.edu
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 co+71b6509cb791e531@bugs.sh, stable@vger.kernel.org
Date: Sun, 18 Oct 2026 20:18:46 +0000
Message-ID: <179235472615.3135.13817965744546885405@kernel.org>
In-Reply-To: <20261014195640.430824-2-kj2864@nyu.edu>
References: <20261014195640.430824-2-kj2864@nyu.edu>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete, so the divide-by-zero it claims to fix
  can still be triggered.
- [Low] The new check in ip_metrics_convert() (net/ipv4/metrics.c:57)
  returns -EINVAL for RTAX_CWND == 0 whether or not the metric is locked.

--

net: ipv4: add zero check for snd_cwnd_clamp

This commit adds a check in ip_metrics_convert() that rejects an RTAX_CWND
route metric of zero with -EINVAL. It is meant to stop snd_cwnd_clamp from
being set to zero, which causes a divide error in tcp_cong_avoid_ai().

> diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> index ad40762a8b383..e83a129a25b68 100644
> --- a/net/ipv4/metrics.c
> +++ b/net/ipv4/metrics.c
> @@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
>  			NL_SET_ERR_MSG(extack, "Unknown flag set in feature mask in metrics attribute");
>  			return -EINVAL;
>  		}
> +		if (type == RTAX_CWND && val == 0) {
> +			NL_SET_ERR_MSG(extack, "RTAX_CWND must be greater than zero");
> +			return -EINVAL;
> +		}

[Severity: High]
Does this fully close the divide by zero? The new check runs only when an
RTAX_CWND attribute is present in the RTA_METRICS nest.

What happens if the nest has only RTAX_LOCK with (1 << RTAX_CWND) set and no
RTAX_CWND attribute at all?

ip_fib_metrics_init() allocates the metrics array zero-filled:

net/ipv4/metrics.c:ip_fib_metrics_init() {
    ...
	fib_metrics = kzalloc_obj(*fib_metrics);
    ...
}

This leaves metrics[RTAX_CWND - 1] at 0 while the CWND lock bit is set.
tcpm_suck_dst() then copies the lock bit and the value separately:

net/ipv4/tcp_metrics.c:tcpm_suck_dst() {
    ...
	if (dst_metric_locked(dst, RTAX_CWND))
		val |= 1 << TCP_METRIC_CWND;
    ...
	tcp_metric_set(tm, TCP_METRIC_CWND,
		       dst_metric_raw(dst, RTAX_CWND));
    ...
}

tcp_init_metrics() checks only the lock bit:

	if (tcp_metric_locked(tm, TCP_METRIC_CWND))
		tp->snd_cwnd_clamp = tcp_metric_get(tm, TCP_METRIC_CWND);

So snd_cwnd_clamp ends up as 0 and tcp_init_cwnd() returns min(cwnd, 0).
Then tcp_reno_cong_avoid()->tcp_cong_avoid_ai() runs this with w == 0:

	u32 delta = tp->snd_cwnd_cnt / w;

That gives the same oops as the one in the commit message.

A dump/restore cycle can also produce this input. rtnetlink_put_metrics()
skips metrics that are zero:

	for (i = 0; i < RTAX_MAX; i++) {
		if (metrics[i]) {

A route with a locked CWND of 0 is therefore dumped as RTAX_LOCK only.
Replaying that dump recreates the same state without hitting the new check.

Both IPv4 and IPv6 RTM_NEWROUTE reach this path through
ip_fib_metrics_init(). The only privilege needed is CAP_NET_ADMIN in a netns
owned by an unprivileged user namespace.

Would it work better to check after the loop that a locked RTAX_CWND has a
non-zero value? Another option is to guard tcp_init_metrics() so that a
locked CWND of zero is never applied to snd_cwnd_clamp.

[Severity: Low]
This rejects RTAX_CWND == 0 whether or not the CWND bit is set in RTAX_LOCK.
Is that intended?

Before this patch, an unlocked CWND of 0 was accepted and had no effect.
tcp_init_metrics() reads the metric only when it is locked, and for unlocked
metrics tcp_update_metrics() overwrites the cached value anyway.

With this change, RTM_NEWROUTE requests that carry an unlocked cwnd of 0 now
fail with -EINVAL. The subject says net: ipv4, but this also affects IPv6
routes, because ip6_route_info_create() calls the same ip_fib_metrics_init()
path.

A lock-aware check after the loop, or a guard in tcp_init_metrics(), would
fix the crash without rejecting this harmless input. Would one of those be
preferable?

>  		metrics[type - 1] = val;
>  	}
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014195640.430824-2-kj2864%40nyu.edu
