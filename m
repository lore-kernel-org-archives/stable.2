Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688512D738F;
	Sun, 18 Oct 2026 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792362668; cv=none; b=b2irppqt2ZWrEXji8i397LuMTj5LqU9s+ZhOD0DAgIu9PdsyneDTBncHFpf+YcMWvYDyi2D7opUXANyXBniDUzYBebWIGyyR36Vpz9CitkABepSmgnKS4XlNcY5KnBT1mvMBnjzxgcVYHnJ6Hp8fouLNM2hMJEyVrEhbLxwCayY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792362668; c=relaxed/simple;
	bh=BWnOAvNsu6Hn1Yo/1ltCClpl+2xOU9XjAaNDugUcWVk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cysZntdsnRg/VpGyn7wnNTKmOw9YmPHbNfIDdj6q8quRLHDRPqn2BpSJPmgPQrTKjAUvTM9HQ225KgIRx7dxtZUFx3TKqRgF2sCgyGn1I2b/1f3vRAI3sY2vPfl2LWE1XNQIIEHZVveY6t4zhCO1smIxYWdhfuql8aGE0WSZjUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4J8Tivn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4J8Tivn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428FE1F000C4;
	Sun, 18 Oct 2026 22:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792362666;
	bh=dZ+A9sRdQCSyqdCPlLTuLfwp38QHp8qh0nL7TJQw3CU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=n4J8Tivn+mJoUtx+Gf4drLXbJsSJdn2WlHNN1IhKDueNbqz7j6XFq4G20QaeqjeIk
	 9nnLMA0R+gOlew7SCrCKCaUyggPy89kmsGUaDDtwu94TxJVL7yJj8JXEgLfr+R4ESx
	 vnOdYAUV1biruiG01fhSnKKCtn72Caj+AhAN6/preC2K1GhjOzylwxmWjr47ZPEEwo
	 Kh5wN7tQ5i5esYcPw+wZouEAzBSJjZ0kmbQaRQakN7D4rZW5+e6ub5hYzVabIzDQTk
	 Kzy3vHshnLYTss3yVZsd5cIshVj7y5PWwDWeLtBdALAAcN2kyTx4YFvGf42qGLtrYs
	 2pH1rsP7krWNg==
Subject: Re: [PATCH net v4] net: ipv4: add zero check for snd_cwnd_clamp
From: netdev-bot+sashiko@kernel.org
To: kj2864@nyu.edu
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 co+71b6509cb791e531@bugs.sh, stable@vger.kernel.org
Date: Sun, 18 Oct 2026 22:31:05 +0000
Message-ID: <179236266579.3135.14593132945174653104@kernel.org>
In-Reply-To: <20261017214845.28769-2-kj2864@nyu.edu>
References: <20261017214845.28769-2-kj2864@nyu.edu>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch silently changes tcp_snd_cwnd_set() in
  include/net/tcp.h, a hot-path helper used by every TCP congestion…
- [Medium] The new check in ip_metrics_convert() rejects the wrong set of
  inputs.
- [Medium] net: ipv4: snd_cwnd_clamp still 0 in tcp_init_metrics() via
  RTAX_LOCK

--

net: ipv4: add zero check for snd_cwnd_clamp

This patch makes ip_metrics_convert() reject a zero RTAX_CWND metric.
The goal is to avoid a divide error in tcp_cong_avoid_ai() when
snd_cwnd_clamp is zero. The patch also changes tcp_snd_cwnd_set() so it
no longer has the WARN_ON_ONCE() and instead clamps the written value to
at least 1.

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 4416cdf9bf30e..ad80b8fb8a520 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1521,8 +1521,7 @@ static inline u32 tcp_snd_cwnd(const struct tcp_sock *tp)
>  
>  static inline void tcp_snd_cwnd_set(struct tcp_sock *tp, u32 val)
>  {
> -	WARN_ON_ONCE((int)val <= 0);
> -	WRITE_ONCE(tp->snd_cwnd, val);
> +	WRITE_ONCE(tp->snd_cwnd, max(val, 1U));
>  }

[Severity: Medium]
Is this change meant to be part of this fix? The commit message only
talks about rejecting zero in ip_metrics_convert(). This hunk changes
tcp_snd_cwnd_set(), which every congestion control module uses.

The WARN_ON_ONCE() came from commit 40570375356c ("tcp: add accessors to
read/set tp->snd_cwnd"). Its purpose was to catch where and when
tp->snd_cwnd gets set to an illegal value. After this change, a zero
cwnd from any caller is silently turned into 1, with no diagnostic.

Underflowed values such as 0x80000000 used to trigger the warning
because (int)val <= 0. max(val, 1U) leaves them unchanged, so they now
pass without any warning.

It also looks like this hunk, not the metrics.c check, is what actually
prevents the reported divide error. With snd_cwnd_clamp == 0,
tcp_reno_cong_avoid()->tcp_slow_start() now stores 1 instead of 0. That
means tcp_cong_avoid_ai() no longer divides by zero.

Could the WARN_ON_ONCE() be kept? If the setter change is really needed,
could it go in a separate patch, or at least be described in the commit
message?

> diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> index ad40762a8b383..cb36686973e57 100644
> --- a/net/ipv4/metrics.c
> +++ b/net/ipv4/metrics.c
> @@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
>  			NL_SET_ERR_MSG(extack, "Unknown flag set in feature mask in metrics attribute");
>  			return -EINVAL;
>  		}
> +		if (type == RTAX_CWND && !val) {
> +			NL_SET_ERR_MSG(extack, "RTAX_CWND must be greater than zero");
> +			return -EINVAL;
> +		}

[Severity: Medium]
Does this fully close the zero snd_cwnd_clamp case? The new check only
runs when an RTAX_CWND attribute is actually present in fc_mx.

ip_fib_metrics_init() allocates fib_metrics with kzalloc_obj(), so
metrics[RTAX_CWND - 1] starts out as zero. Consider a route request
whose RTA_METRICS has RTAX_LOCK with (1 << RTAX_CWND) set but no
RTAX_CWND attribute at all. It passes ip_metrics_convert() with CWND
locked and the CWND value still zero.

tcpm_suck_dst() then sees dst_metric_locked(dst, RTAX_CWND) and copies
both the lock bit and dst_metric_raw(dst, RTAX_CWND), which is 0, into
the tcp_metrics_block. tcp_init_metrics() applies a locked CWND
without checking for zero. TCP_METRIC_SSTHRESH and
TCP_METRIC_REORDERING are only applied when non-zero:

net/ipv4/tcp_metrics.c:tcp_init_metrics() {
    ...
	if (tcp_metric_locked(tm, TCP_METRIC_CWND))
		tp->snd_cwnd_clamp = tcp_metric_get(tm, TCP_METRIC_CWND);

	val = READ_ONCE(net->ipv4.sysctl_tcp_no_ssthresh_metrics_save) ?
	      0 : tcp_metric_get(tm, TCP_METRIC_SSTHRESH);
	if (val) {
		WRITE_ONCE(tp->snd_ssthresh, val);
		if (tp->snd_ssthresh > tp->snd_cwnd_clamp)
			WRITE_ONCE(tp->snd_ssthresh, tp->snd_cwnd_clamp);
	}
    ...
}

So tp->snd_cwnd_clamp is still set to 0. If a saved ssthresh exists,
tp->snd_ssthresh is clamped down to 0 as well.

tcp_init_cwnd() then returns min(cwnd, tp->snd_cwnd_clamp), which is
0. The congestion control paths that clamp against snd_cwnd_clamp keep
computing a cwnd of 0. These include tcp_slow_start(),
tcp_cong_avoid_ai(), hstcp_cong_avoid(), htcp_cong_avoid(),
tcp_veno_cong_avoid() and tcp_vegas_cong_avoid().

With the tcp.h hunk, tcp_snd_cwnd_set() silently turns that 0 into 1.
The divide error goes away, but the connection is pinned at a cwnd of
1.

BPF congestion control programs (net/ipv4/bpf_tcp_ca.c) are also
allowed to write tp->snd_cwnd directly, bypassing tcp_snd_cwnd_set().
They can still end up with snd_cwnd == 0.

This needs CAP_NET_ADMIN, but so does the RTAX_CWND == 0 case the
patch is trying to close.

Would it be better to validate the final result after the loop? For
example, reject the route when metrics[RTAX_LOCK - 1] has
(1 << RTAX_CWND) set and metrics[RTAX_CWND - 1] is zero. Or should
tcp_init_metrics() ignore a locked CWND of zero, the same way it
already ignores a zero ssthresh?

[Severity: Medium]
Should this check only apply when RTAX_CWND is locked?

TCP uses the CWND metric as snd_cwnd_clamp only when it is locked:

net/ipv4/tcp_metrics.c:tcp_init_metrics() {
    ...
	if (tcp_metric_locked(tm, TCP_METRIC_CWND))
		tp->snd_cwnd_clamp = tcp_metric_get(tm, TCP_METRIC_CWND);
    ...
}

When it is not locked, RTAX_CWND only seeds TCP_METRIC_CWND through
tcpm_suck_dst(). After that, tcp_update_metrics() treats it as a running
estimate and overwrites it:

net/ipv4/tcp_metrics.c:tcp_update_metrics() {
    ...
		if (!tcp_metric_locked(tm, TCP_METRIC_CWND)) {
			val = tcp_metric_get(tm, TCP_METRIC_CWND);
			if (tcp_snd_cwnd(tp) > val)
				tcp_metric_set(tm, TCP_METRIC_CWND,
					       tcp_snd_cwnd(tp));
		}
    ...
}

So an unlocked zero means the same thing as unset. With this patch,
route requests that used to be accepted, such as "ip route add ...
cwnd 0" without "lock", now fail with -EINVAL.

ip_metrics_convert() is shared by IPv4 through
fib_create_info()->ip_fib_metrics_init() and by IPv6 through
ip6_route_info_create()->ip_fib_metrics_init(). The stricter input
check therefore applies to IPv6 routes too, even though the subject
says "net: ipv4". The commit message does not mention this change in
accepted input.

Also, a locked CWND with no RTAX_CWND attribute at all still seems to be
accepted. That leaves metrics[RTAX_CWND - 1] at zero, which
tcp_init_metrics() then copies into snd_cwnd_clamp.

Would it be better to check for "CWND locked and final value zero" after
the loop, rather than rejecting a zero attribute value?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017214845.28769-2-kj2864%40nyu.edu
