Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442924;
	b=S7hM2ex4mbEVfnwqqbUJj5gZ8tuo3M3OCvAg3dpyzlHrJKRZUNcJGuO3za6tNloEOl8m
	 dvMmCZr4I6J50hSY20Qryga5NLSI5raRsMiNfYsOmLQg/7/3pSxJ/10quCgo9LPpAE89n
	 JIE/KySC3Wt5fpgGVmWZjn5rCc5OBjn5UbL7Sts9BTi1M5XHxgj1Nb25BEK6iJTMXoHe4
	 U3eXNy03jXuqRsb9OQAaPmMetoS4z8DQpTqrSr93Hy52OHk+Mq8RoVu1MNcF+Hv0Ts8qz
	 gC5xnezyUM/oFMhUYw0vmaADW6BGRNMvnKqpwE18s6y33XeRh6v+F3tQ6aqwMmmPR2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442924;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=znHKFW5DZ1DFTZiPSdRamz8km2jluecigHe2x27tyX4=;
	b=PIZScdS4TOZ2Cbq/F/xMSV09p6e2h7o0wZ+i3+j+uo9LsKr1wGzitSLsJXcgDyi65EtE
	 l0PJKJy7pdzNh3qf8p9/uhsbT9m1C1ErbKFgYq/xnND3g667bOrGTNPg3RJZ1tBDmo2wO
	 Wh3nwSLBtM2Wf92Iocw6v8Xsn88a8MXhVDD0wF7pk3lx24BvtM4q20lu6LNspwIEfZQp5
	 UY01M+TYzCMGR7R2kOMpnMlLGUeH8pkgyv1F1xlgUDMkzpTrpXG9JayyUuMqSS6J0ELRu
	 mRLD7bYEwb6HIacHKdWQf2UORxbnQ45dmlt448DPy3wGpVzTcYDX4aEG/4J9zxIE/kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oniOVljK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0A9606A31D;
	Mon, 19 Oct 2026 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oniOVljK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5B01F000C4;
	Mon, 19 Oct 2026 20:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792442923;
	bh=znHKFW5DZ1DFTZiPSdRamz8km2jluecigHe2x27tyX4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oniOVljKooIW2lqCf7/qMu1/csgI97HBwSQv84eCIHogk/qwVx/o3c98KMHIiNe6r
	 17/2HvDy5qYtW186SRUGm0cYKk5NXuzvKOe5hTZw+cIB0F3sm+KBQho9Tty5QfhD0u
	 EoLg3rLmjLkLlJhgqyw+dJcAJqksh/9SbyASLVeolARzy6+48KqScqpTX6YGvn8spj
	 rew9irxFes56ef49+eJFlcvtQsD0JIWRSz+RROFwQXSkwLzS2JlZtmIyS4uqRn7RIR
	 yRoGjMeUdyQg/8hRD76RlhNdZU5QqEzUNGhe5ofDemGMffRKId2n89t/m+v0k4J18C
	 mFKtMyBvwgBtw==
Subject: Re: [PATCH net v3] net: ipv4: add zero check for snd_cwnd_clamp
From: netdev-bot+sashiko@kernel.org
To: kj2864@nyu.edu
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 co+71b6509cb791e531@bugs.sh, stable@vger.kernel.org
Date: Mon, 19 Oct 2026 20:48:42 +0000
Message-ID: <179244292273.3135.7259079039663290152@kernel.org>
In-Reply-To: <20261015201549.4023-2-kj2864@nyu.edu>
References: <20261015201549.4023-2-kj2864@nyu.edu>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: the divide-by-zero it targets can still
  be triggered.
- [Medium] The new check rejects every RTM_NEWROUTE with RTAX_CWND == 0
  with -EINVAL, whether or not RTAX_CWND is locked in RTAX_LOCK.
- [Low] The new error path in ip_metrics_convert() uses plain
  NL_SET_ERR_MSG(extack, "RTAX_CWND must be greater than zero") and does…
- [Low] In the commit message, 'Reported-by: co+71b6509cb791e531@bugs.sh'
  is followed directly by 'Assisted-by: LLM' instead of a Closes: or…

--

net: ipv4: add zero check for snd_cwnd_clamp

This commit adds a check in ip_metrics_convert() that rejects an RTAX_CWND
route metric with a value of zero. The goal is to stop snd_cwnd_clamp from
being set to zero, which causes a divide error in tcp_cong_avoid_ai().

> Reported-by: co+71b6509cb791e531@bugs.sh
> Assisted-by: LLM

[Severity: Low]
This isn't a bug, but checkpatch.pl warns that Reported-by: should be
immediately followed by a Closes: or Link: tag with a URL to the report.
Could the link to the original report be added?

> diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> index ad40762a8b383..e83a129a25b68 100644
> --- a/net/ipv4/metrics.c
> +++ b/net/ipv4/metrics.c
> @@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
>  			NL_SET_ERR_MSG(extack, "Unknown flag set in feature mask in metrics attribute");
>  			return -EINVAL;
>  		}
> +		if (type == RTAX_CWND && val == 0) {

[Severity: High]
Does this fully close the divide-by-zero? The check only runs when
RTA_METRICS actually contains an RTAX_CWND attribute.

Suppose RTA_METRICS contains only RTAX_LOCK = (1 << RTAX_CWND) and has no
RTAX_CWND attribute. Then this loop never sees type == RTAX_CWND.

ip_fib_metrics_init() allocates the array with kzalloc_obj(), so
metrics[RTAX_CWND - 1] stays 0, and the lock bit is stored unchanged. That
leaves the same state as the locked "cwnd 0" configuration this patch is
meant to reject.

>From there, the path in the oops looks the same as before:

tcpm_suck_dst()
    if (dst_metric_locked(dst, RTAX_CWND))
        val |= 1 << TCP_METRIC_CWND;
    ...
    tcp_metric_set(tm, TCP_METRIC_CWND,
                   dst_metric_raw(dst, RTAX_CWND));

tcp_init_metrics()
    if (tcp_metric_locked(tm, TCP_METRIC_CWND))
        tp->snd_cwnd_clamp = tcp_metric_get(tm, TCP_METRIC_CWND);

tcp_slow_start()
    tcp_snd_cwnd_set(tp, min(cwnd, tp->snd_cwnd_clamp));

tcp_reno_cong_avoid()->tcp_cong_avoid_ai(tp, 0, acked)
    u32 delta = tp->snd_cwnd_cnt / w;

Both fib_create_info() and ip6_route_info_create() go through
ip_fib_metrics_init(), so IPv4 and IPv6 routes would both still be exposed.

Could this per-attribute check be replaced? One option is to check after
the loop that a locked RTAX_CWND has a non-zero value:

    if ((metrics[RTAX_LOCK - 1] & (1 << RTAX_CWND)) &&
        !metrics[RTAX_CWND - 1])

Another is a guard in tcp_init_metrics() that only applies the clamp when
the cached value is non-zero.

[Severity: Medium]
This check rejects every route with RTAX_CWND == 0, whether or not
RTAX_CWND is locked in RTAX_LOCK. Is that intended?

As far as I can tell, the value only reaches socket state through
tcp_init_metrics(), and only when it is locked:

    if (tcp_metric_locked(tm, TCP_METRIC_CWND))
        tp->snd_cwnd_clamp = tcp_metric_get(tm, TCP_METRIC_CWND);

The other uses in tcp_metrics.c only update the cache for unlocked entries.

So a route such as "ip route add ... cwnd 0" without lock used to be
accepted and was harmless. It now fails with -EINVAL. This applies to IPv6
routes too, because ip6_route_info_create() uses the same
ip_fib_metrics_init() path. With Cc: stable, the same change would reach
stable kernels.

The commit message also says:

    User can pass zero to snd_cwnd_clamp via RTAX_CWND type.

However, the value only reaches snd_cwnd_clamp when it is locked. The
"net: ipv4:" subject also doesn't mention that IPv6 route installation is
affected.

Would a lock-aware check after the attribute loop, or a guard in
tcp_init_metrics(), avoid rejecting the harmless unlocked case?

> +			NL_SET_ERR_MSG(extack, "RTAX_CWND must be greater than zero");

[Severity: Low]
This isn't a bug, but could this use NL_SET_ERR_MSG_ATTR(extack, nla, ...)
so the offending attribute is reported? The nla_len check earlier in
ip_metrics_convert() already does this, and nla is in scope here.

> +			return -EINVAL;
> +		}
>  		metrics[type - 1] = val;
>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015201549.4023-2-kj2864%40nyu.edu
