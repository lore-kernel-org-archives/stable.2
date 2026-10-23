Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792718910;
	b=IqZVtZo1gO/zjMzXEx0mkoiOln+hNzPh/g53f5ckQl6/wSqFXKhwdO5/xzA/QaWHjNGD
	 Vc+C9uAKqc4B9X55553+sZXxFrL3RG49xUJ7zdItPzbEE/0S0u+pqAdKsmi78rcSh3+J7
	 unJPpBtcFTYGf5rAkcvuT3QVSgpaG9oEAuXZ/5Isn3ILkDWeFDd/7QXNU3NipVCue4tqE
	 Na1KjPeX5KgE/LAG20+3CYTjzGIbUgkNLwNebh/9+WLUnsyX/sHzvHbi3a5bCC2wAbQKJ
	 bAYoSASkJY439YZG1YV3gmQL5baoKVSefViX0uUty5xniCHfIgT/ie9O4BLGtRrSifA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792718910;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LQy2wg2eqw7YI+7MNRGfuKHoTfwnWJ2WrDcljy7soo8=;
	b=kCrrGQu0SAC2Yt+nkZniAEzu+BGfhA1vlGgajgcIzhRLFMpSvaM7eXODIxhl5j/XOxbR
	 NL/4OAvfwtaUn2D+KxC/yGYa1bi9VTIvO5XuqNUfUOgTquOjmpfZbWeKfG1JTn1pNW3/1
	 2LFTRt8l6mYJLLO9dNBruXoHInA3el0wbGmT90wwOMVfY/vQclsr7QRlzuKrO+EjOhSh9
	 GXX2RGjXThrCuqw4xrNuz1nL0dHrKfeus+wxnPaoW7wtZn5WzlDy3vvDssRTSORBZhQ7a
	 SwVvxyA+cW9/v4Gf9KztuZQpkvuqkzp06d6j5fs+FNkobccU2dtWHCH6uIL1uuKXJpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGSWZA+T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B90606A319;
	Fri, 23 Oct 2026 01:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGSWZA+T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CBF1F01825;
	Fri, 23 Oct 2026 01:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792718909;
	bh=LQy2wg2eqw7YI+7MNRGfuKHoTfwnWJ2WrDcljy7soo8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JGSWZA+T0XsP3RcJjj9Oa3HuR7hkJGk05bufLJIY0tD6aCP7iIfDbOByBWO8oD6HX
	 CXcPc0P9ttr5W8x4ogIc32+Xdgk0Qjs42/au/Rc323onK7vClXggEdpvYW1eTr58da
	 Jbdvk0u80LZcut0OwQRs5NQRct2ZHvmQyhXMVJhh6pi2mEMJgnNMfIEO1WQ81zqtXl
	 MXePke+jwO7FAVn0Pj7xD16ytaDMtS+zOyzi2KAkQPX9/xbNpMKy7gmREmpboAlulP
	 X9p2kTE3CE3Yu4vQ71WbMk/SG33GCXj3uBhKgPTWLwZuZt2TWEgOsHhcv9gUaQr58s
	 pMbQ2VPsKWYJQ==
Subject: Re: [PATCH net v5] net: ipv4: add zero check for snd_cwnd_clamp
From: netdev-bot+sashiko@kernel.org
To: kj2864@nyu.edu
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 co+71b6509cb791e531@bugs.sh, stable@vger.kernel.org
Date: Fri, 23 Oct 2026 01:28:28 +0000
Message-ID: <179271890858.3134.5358152366592526065@kernel.org>
In-Reply-To: <20261019222531.1073-1-kj2864@nyu.edu>
References: <20261019222531.1073-1-kj2864@nyu.edu>
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

Critical: 0 · High: 1 · Medium: 2 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not close the bug its commit message describes:
  userspace setting tp->snd_cwnd_clamp to 0 through route metrics.
- [Medium] The patch changes the core inline helper tcp_snd_cwnd_set()
  (include/net/tcp.h:1522-1526) to store max(val, 1U) instead of val.
- [Medium] ip_metrics_convert() now fails any IPv4 or IPv6 route
  add/replace whose RTA_METRICS carries RTAX_CWND = 0, with -EINVAL,…
- [Low] The new error path in ip_metrics_convert() uses a plain-text
  NL_SET_ERR_MSG(extack, "RTAX_CWND must be greater than zero") and does…

Pre-existing issues:
- [Medium] Even when no route sends a zero RTAX_CWND, tp->snd_cwnd_clamp
  can still become 0 through a lockless race in the TCP metrics cache.

--

net: ipv4: add zero check for snd_cwnd_clamp

This patch makes ip_metrics_convert() reject a zero RTAX_CWND value, so
userspace cannot set tp->snd_cwnd_clamp to 0 through route metrics. It
also changes tcp_snd_cwnd_set() to store max(val, 1U) instead of val.

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 4416cdf9bf30..9f605d9ecb35 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1522,7 +1522,7 @@ static inline u32 tcp_snd_cwnd(const struct tcp_sock *tp)
>  static inline void tcp_snd_cwnd_set(struct tcp_sock *tp, u32 val)
>  {
>  	WARN_ON_ONCE((int)val <= 0);
> -	WRITE_ONCE(tp->snd_cwnd, val);
> +	WRITE_ONCE(tp->snd_cwnd, max(val, 1U));

[Severity: Medium]
The commit message only describes the netlink check:

  Fix by checking if user pass in zero as parameter,
  if so reject the value zero.

Should this hunk be described in the changelog too? tcp_snd_cwnd_set()
is used by every congestion control module, by tcp_input.c and
tcp_output.c, by the TCP_BPF_IW path in net/core/filter.c, and by
struct_ops congestion control through the tcp_slow_start() and
tcp_cong_avoid_ai() kfuncs.

With this change, a computed cwnd of 0 is quietly raised to 1 while the
WARN still fires. That can hide caller bugs and leave connections stuck
at cwnd 1.

The clamp also doesn't match the WARN condition next to it. Values of
0x80000000 and above trigger the WARN but are stored unchanged.

This hunk is also what actually prevents the divide error on the
RTAX_LOCK-only path described below. If a stable backport drops it as
unrelated, would the divide error come back?

>  }
>  
>  static inline bool tcp_in_slow_start(const struct tcp_sock *tp)
> diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> index ad40762a8b38..cb36686973e5 100644
> --- a/net/ipv4/metrics.c
> +++ b/net/ipv4/metrics.c
> @@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
>  			NL_SET_ERR_MSG(extack, "Unknown flag set in feature mask in metrics attribute");
>  			return -EINVAL;
>  		}
> +		if (type == RTAX_CWND && !val) {
> +			NL_SET_ERR_MSG(extack, "RTAX_CWND must be greater than zero");

[Severity: Low]
This isn't a bug, but could this use NL_SET_ERR_MSG_ATTR(extack, nla, ...)
like the length check earlier in ip_metrics_convert()? That way userspace
learns which attribute was rejected.

> +			return -EINVAL;
> +		}

[Severity: High]
Does this check close the path the commit message describes? It only
runs when an RTAX_CWND attribute is present, and it never looks at
RTAX_LOCK.

A request can set the CWND bit in RTAX_LOCK and leave RTAX_CWND out
entirely. ip_fib_metrics_init() allocates the array with kzalloc_obj(),
so the CWND slot stays 0. dst_metric_locked() only checks the RTAX_LOCK
mask.

>From there:

tcpm_suck_dst()
    copies the CWND lock bit and dst_metric_raw(dst, RTAX_CWND) == 0
tcp_init_metrics()
    if (tcp_metric_locked(tm, TCP_METRIC_CWND))
        tp->snd_cwnd_clamp = tcp_metric_get(tm, TCP_METRIC_CWND);

When an ssthresh metric is cached, tcp_init_metrics() then also clamps
snd_ssthresh to 0. tcp_update_metrics() never overwrites a locked CWND,
so the 0 stays for later connections.

Next, tcp_init_transfer() calls tcp_snd_cwnd_set() with tcp_init_cwnd(),
which is min(cwnd, 0) == 0. tcp_slow_start() and tcp_cong_avoid_ai() then
pass min(cwnd, snd_cwnd_clamp) == 0 on every ACK.

The divide error is now avoided only by the max(val, 1U) in
tcp_snd_cwnd_set(). WARN_ON_ONCE((int)val <= 0) still runs before that
clamp. Anyone with CAP_NET_ADMIN in a user namespace can still trigger
the warning, which panics with panic_on_warn. The connection also stays
at cwnd 1.

For comparison, TCP_BPF_SNDCWND_CLAMP in net/core/filter.c rejects
val <= 0.

Would it be better to fix this in tcp_init_metrics(), applying a locked
CWND only when it is non-zero? Another option is to check the final
metrics array against RTAX_LOCK after the parse loop.

[Severity: Medium]
This check also changes rtnetlink behavior for both IPv4 and IPv6 routes.
An RTM_NEWROUTE with RTAX_CWND = 0 in RTA_METRICS, for example
"ip route replace ... cwnd 0", used to succeed. It now fails with -EINVAL
whether or not the CWND lock bit is set.

An unlocked CWND of 0 is the same as leaving the metric out, since
dst_metric_raw() returns 0 either way. tcp_init_metrics() only reads
TCP_METRIC_CWND when it is locked, and tcp_update_metrics() only updates
it when it is unlocked.

Is rejecting the unlocked case intended? The commit message doesn't
mention it, and a fix in tcp_init_metrics() would leave what rtnetlink
accepts unchanged.

>  		metrics[type - 1] = val;
>  	}
>  

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch, but
tp->snd_cwnd_clamp can still become 0 without any route carrying a zero
RTAX_CWND.

tcp_get_metrics() calls tcpm_check_stamp() with only rcu_read_lock held.
After TCP_METRICS_TIMEOUT, that can call tcpm_suck_dst(), which rewrites
a live entry in place:

net/ipv4/tcp_metrics.c:tcpm_suck_dst() {
    ...
	WRITE_ONCE(tm->tcpm_lock, val);
    ...
	tcp_metric_set(tm, TCP_METRIC_CWND,
		       dst_metric_raw(dst, RTAX_CWND));
    ...
}

tcp_init_metrics() reads the lock bit and the CWND value as two separate
loads. Take an entry built from a dst with no cwnd metric (lock 0,
value 0) that gets refreshed from a dst with "cwnd lock N". Can a
concurrent reader see the new lock bit with the old value 0 and set
snd_cwnd_clamp to 0?

The reverse transition has the same window. The reclaim path in
tcpm_new() also rewrites entries that RCU readers can still see. With
policy routing, two concurrent tcpm_suck_dst() calls could also leave an
entry locked with value 0 until the next refresh.

The new netlink check doesn't cover this case. Only the max(val, 1U) in
tcp_snd_cwnd_set() avoids the divide, and the WARN_ON_ONCE still fires.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019222531.1073-1-kj2864%40nyu.edu
