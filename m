Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F69318B83;
	Mon, 12 Oct 2026 04:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791779244; cv=none; b=OTG0JQR/ka7WLUoUdkE2AwGGN6S1C8q9Zb/oejPogHI3dWbAbGD8dNn77o9rvRqz5KwHWPDynfoAvL5Noe5FzRhTwkj/MLnQDhJCxiMzeBW0DCCpKPlJplzgZdEg5Fg63Rlo0sL4U+rG57lKnb5uJfs61G+dbHJ66Gn3UaJzwPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791779244; c=relaxed/simple;
	bh=OSualuFA1JNLwwDkgs3/qCuuG8cnTESHH3RVN3CNw0Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sWH50S+R56yVaK2ArwB+xFaKylJjSXBEyPmazuRsNk4c+AIPmTZPPdKEwTwK43ytrlFOHdH21Ew+OO43/tJhDnTWaQ1NezehjGf8d/98esecqLcRelp4rP2nqe8ns4rjMh5fIj5ust5T8LkrsyTkkP4QmPinpHIZXWTTT8tNnQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb3kZnQL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb3kZnQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF091F0089B;
	Mon, 12 Oct 2026 04:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791779241;
	bh=QJh9QaUYrLN+/jImyp2k/Z7vS07GIEVHDzwZt/doNeE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Cb3kZnQL9KjNvfhws20mp2cemQVwc1a68eWhAX7KdVkpLxv5pkggQV3Q+pyQ7ibni
	 IDRYIlW0liiMWn7U3dtInxjRmY9PU2XMydKFZxTGJfGKgg1URa9X8B+IUaGeUpSZFz
	 XHdj+PCOhv+3K45GA2BIkYE4C0nxgYKNT0ARj4xJvaSs+Mvd7AUipiIt4CMo7Gr3A4
	 oHvfppuj0d55QlclGLIrzciAiGzvsYl/HRpi+UMXxL4RpEfl7spPUydi3TR+hB+XHJ
	 XNK3nWcC1srlPuWITKu8uzKOsuFLq5YXczDG0JRdqsJb6zi9nEeeaZBA0sHHzD8WzH
	 lwaflmLjxVq9Q==
Subject: Re: [PATCH] net/sched: sch_netem: prevent packet length underflow
 with negative overhead
From: netdev-bot+sashiko@kernel.org
To: dungvn2345@gmail.com
Cc: stephen@networkplumber.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Mon, 12 Oct 2026 04:27:20 +0000
Message-ID: <179177924024.434549.1159457377130534867@kernel.org>
In-Reply-To: <20261008035656.330667-1-dungvn2345@gmail.com>
References: <20261008035656.330667-1-dungvn2345@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In net/sched/sch_netem.c, packet_time_ns() line 376 now does
  `s32 cell_len = (s32)q->cell_size + q->cell_overhead;`, and lines…
- [Low] In net/sched/sch_netem.c, packet_time_ns() now computes the cell-
  adjusted length as `len = (u64)cells * cell_len;` (line 382) instead…
- [Low] The commit message says the new clamping is 'matching the
  behavior in sch_cake and sch_tbf'.

--

net/sched: sch_netem: prevent packet length underflow with negative overhead

This patch changes packet_time_ns() in sch_netem. It now returns 0 when
the packet length plus a negative packet_overhead is non-positive, and
also when cell_size + cell_overhead is non-positive. The cell-adjusted
length is now computed as a u64 product instead of a u32 one.

> Clamp the effective packet length to 0 if the overhead adjustment
> would underflow, and return 0 delay if effective cell length is
> non-positive, matching the behavior in sch_cake and sch_tbf.

[Severity: Low]
Is the comparison to sch_cake and sch_tbf accurate?

sch_tbf uses psched_l2t_ns() with struct psched_ratecfg, where overhead is
a u16. Its overhead cannot be negative, so there is no negative-overhead
behavior to match there.

sch_cake's cake_calc_overhead() clamps to the MPU rather than to zero:

	len = max((s32)len + q->rate_overhead, (s32)q->rate_mpu);

Its ATM/PTM framing is fixed, so it has no configurable cell size and no
rule like "return 0 delay when cell_size + cell_overhead <= 0".

The commit message also doesn't mention that the cell product is now
computed as (u64)cells * cell_len instead of in wrapping u32 arithmetic.
That changes the computed delay for large configurations.

Since this is tagged for stable, could the message describe this as a new
policy (a non-positive effective length means no rate shaping for that
packet) instead of an existing convention?

> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index 8a1b89a289d8f..a3dcd33bec499 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -366,14 +366,20 @@ static s64 tabledist(s64 mu, s32 sigma,
>  
>  static u64 packet_time_ns(u64 len, const struct netem_sched_data *q)
>  {
> +	if ((s64)len + q->packet_overhead <= 0)
> +		return 0;
> +
>  	len += q->packet_overhead;
>  
>  	if (q->cell_size) {
>  		u32 cells = reciprocal_divide(len, q->cell_size_reciprocal);
> +		s32 cell_len = (s32)q->cell_size + q->cell_overhead;
>  
>  		if (len > cells * q->cell_size)	/* extra cell needed for remainder */
>  			cells++;
> -		len = cells * (q->cell_size + q->cell_overhead);
> +		if (cell_len <= 0)
> +			return 0;

[Severity: Medium]
Can cell_len come out negative here for configurations the kernel already
accepts?

q->cell_size comes from the __u32 cell_size field of struct tc_netem_rate.
get_rate() stores it without any range check:

net/sched/sch_netem.c:get_rate() {
    ...
	q->cell_size = r->cell_size;
	q->cell_overhead = r->cell_overhead;
    ...
}

In two cases cell_len goes negative even though the real cell length is
large and positive:

  - any cell_size >= 0x80000000 turns negative after the (s32) cast
  - cell_size = 0x7fffffff with cell_overhead = 1 wraps the s32 addition
    past INT_MAX

In both cases packet_time_ns() returns 0, so this line in netem_enqueue()
adds no serialization delay:

	delay += packet_time_ns(qdisc_pkt_len(skb), q);

The configured rate shaping is then silently skipped. Before this patch,
cell_size = 0x80000000 with cell_overhead = 0 still produced a large
positive delay, and netem_dump() reports the value back unchanged.

Would computing the sum in a wider type avoid this? For example:

	s64 cell_len = (s64)q->cell_size + q->cell_overhead;

Another option is to reject these values in get_rate()/netem_change()
with an extack error.

> +		len = (u64)cells * cell_len;
>  	}
>  
>  	return div64_u64(len * NSEC_PER_SEC, q->rate);

[Severity: Low]
len is now a u64 product, so it is no longer bounded by 2^32 - 1. Can
len * NSEC_PER_SEC overflow here?

Take cell_size = 1, cell_overhead = 0x7ffffffe (so cell_len = 0x7fffffff)
and a 1500 byte packet. reciprocal_value(1) gives cells = 1500, so len is
about 3.2e12. len * NSEC_PER_SEC is then about 3.2e21, which wraps u64.

With a small q->rate (for example 1 byte/s) the quotient can also exceed
S64_MAX. The s64 delay in netem_enqueue() would then turn negative:

	delay += packet_time_ns(qdisc_pkt_len(skb), q);
	...
	cb->time_to_send = now + delay;

and time_to_send would land in the past. The old u32 product capped this
at about 4.3e18, which is below S64_MAX.

The same configuration already gave a meaningless delay before this patch,
because the u32 product wrapped. The patch moves the wrap into the 64-bit
multiply and adds the negative-delay case.

Would mul_u64_u64_div_u64() or an explicit clamp make this well-defined?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008035656.330667-1-dungvn2345%40gmail.com
