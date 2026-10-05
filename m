Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EF52868B4;
	Mon,  5 Oct 2026 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791219138; cv=none; b=mbJIbxVETXsTUy3xdW/63Rdc37XfIEowSAc+dYLAzYli/dV4xfL0mXZ5dE4wStoqMSEhR9TnB4oZSmUSlKWqWvWit8UoVHRNaF8G6IRZdXxfy0KXfg0iVpnlFqVtT9kDMtbDf8GjlzHbEjFRhZQ2pgNWyC8d2cLM91Rj4h+7M6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791219138; c=relaxed/simple;
	bh=ThwnO0ZqW23dg9Rvi9a8YjvO99W4F+lredTWaNy2D3w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JusXV1xWkc/kykirQU8pHq47JDM/d6MiSIdSKNi7zixiyb12HOZR6Bvg4lUtFKgYejo9/Y6Urx8xGpCWpkAlb4AxZaLkfboSMANURLTmFGfuZBUem312PcolqE6EAcNvHPwkQ8s7OgPokVa10Se/XnEsQkFOeGWFFKsD2BmShsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSKIP36A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSKIP36A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1171F000FF;
	Mon,  5 Oct 2026 16:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791219137;
	bh=HRxEkL1IAUgC2G4AWcfq7OttzJ4GxtkLGdjSWS21CBY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QSKIP36AY9RlYw/Wf6Mi6UqMoDOtTQ/fiyxOIwhjSScyyeFeuJxgEiShGVkU+azNu
	 IrY2Gh804gaD6ukltlUB0PIpT5YAUzqINl5/9NkHs1slpG1ctakTaCRDyA2aZiGjcK
	 b7OgKx+jfwXh81Z/wyJz1YtIZ0eMMeoEEn5Bq9q0qMJoxAkcTiD15Vsa33zP/PpzYh
	 MFuHBN+5Lj6Lp24mmNOrvi96iLnBJkkKWuZKtVC2R20TPA0W9Er/aPU62HdEVaONkI
	 F59+Gn3omRquSxEpALgwoBc4DcbXoKAfwHgtI3p0JkpdNmnE2ra/I4gyvNIXyeZlON
	 OMujDLm8lMqig==
Subject: Re: [PATCH net v2] tcp: reject zero CWND route metrics
From: netdev-bot+sashiko@kernel.org
To: bestswngs@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 co+71b6509cb791e531@bugs.sh, xmei5@asu.edu, edumazet@kernel.org,
 stable@vger.kernel.org
Date: Mon, 05 Oct 2026 16:52:16 +0000
Message-ID: <179121913618.434549.2293013212977621085@kernel.org>
In-Reply-To: <20261004164944.2006741-1-bestswngs@gmail.com>
References: <20261004164944.2006741-1-bestswngs@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In net/ipv4/metrics.c:ip_metrics_convert(), the new per-
  attribute check `if ((type == RTAX_CWND || type == RTAX_INITCWND) &&…
- [Low] The commit message says the locked-CWND check exists 'so a zero
  CWND cannot enter the TCP metrics cache'.

--

tcp: reject zero CWND route metrics

This patch makes ip_metrics_convert() reject RTAX_CWND and RTAX_INITCWND
metrics that have a value of zero. It also rejects routes that set the
RTAX_CWND lock bit but do not supply a CWND value. The aim is to stop a
zero snd_cwnd_clamp from reaching tcp_cong_avoid_ai().

> Reject zero RTAX_CWND and RTAX_INITCWND metrics while parsing route
> metrics. Also reject a locked CWND without a value, so a zero CWND cannot
> enter the TCP metrics cache.

[Severity: Low]
Is this description accurate? tcpm_suck_dst() always copies the raw route
metric into the cache:

net/ipv4/tcp_metrics.c:tcpm_suck_dst() {
    ...
	tcp_metric_set(tm, TCP_METRIC_CWND,
		       dst_metric_raw(dst, RTAX_CWND));
    ...
}

dst_metric_raw() returns 0 for any route that has no RTAX_CWND metric. So
even with this patch, a zero CWND still enters the TCP metrics cache for
most routes.

That zero does no harm, because tcp_init_metrics() only uses it when the
CWND lock bit is set. What the new check really prevents is a locked zero
CWND.

Could the commit message say that a locked zero CWND can no longer reach
snd_cwnd_clamp, rather than saying no zero CWND can enter the cache?

> diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> index ad40762a8b383..c26f95126ae72 100644
> --- a/net/ipv4/metrics.c
> +++ b/net/ipv4/metrics.c
> @@ -54,9 +54,19 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
>  			NL_SET_ERR_MSG(extack, "Unknown flag set in feature mask in metrics attribute");
>  			return -EINVAL;
>  		}
> +		if ((type == RTAX_CWND || type == RTAX_INITCWND) && !val) {
> +			NL_SET_ERR_MSG(extack, "CWND metric must be greater than zero");
> +			return -EINVAL;
> +		}

[Severity: Medium]
Does this per-attribute check reject more than the divide by zero fix
needs?

The kernel used to accept route installs such as "ip route add ...
initcwnd 0" and "ip route add ... cwnd 0" (without lock). Both now fail
with -EINVAL in ip_fib_metrics_init()->ip_metrics_convert(), for IPv4 and
IPv6 alike.

The only reader of RTAX_INITCWND treats zero as "use the default":

net/ipv4/tcp_input.c:tcp_init_cwnd() {
	__u32 cwnd = (dst ? dst_metric(dst, RTAX_INITCWND) : 0);

	if (!cwnd)
		cwnd = TCP_INIT_CWND;
    ...
}

A cached CWND only reaches snd_cwnd_clamp when the lock bit is set:

net/ipv4/tcp_metrics.c:tcp_init_metrics() {
    ...
	if (tcp_metric_locked(tm, TCP_METRIC_CWND))
		tp->snd_cwnd_clamp = tcp_metric_get(tm, TCP_METRIC_CWND);
    ...
}

When it is not locked, tcp_update_metrics() only compares or averages it.
It is never used as a divisor.

The lock-gated check after the loop already rejects a locked zero CWND on
its own. That covers both an explicit zero and a missing attribute, since
ip_fib_metrics_init() zero-initializes the metrics array.

This patch is tagged for stable. Would it be better to keep only the
lock-gated check, and drop the INITCWND and unlocked CWND rejections?

Also, Documentation/netlink/specs/rt-route.yaml still describes cwnd and
initcwnd as plain u32 values and does not exclude zero. If these
rejections stay, should the spec be updated to match?

>  		metrics[type - 1] = val;
>  	}
>  
> +	if ((metrics[RTAX_LOCK - 1] & (1U << RTAX_CWND)) &&
> +	    !metrics[RTAX_CWND - 1]) {
> +		NL_SET_ERR_MSG(extack, "Locked CWND metric requires a value");
> +		return -EINVAL;
> +	}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004164944.2006741-1-bestswngs%40gmail.com
