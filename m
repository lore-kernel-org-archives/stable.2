Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89293C07A;
	Tue, 13 Oct 2026 04:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791867101; cv=none; b=S9r/++EiTc3dw8zXbKd1o9YipvvtM3gIsBw6igi4oLZJiS8/i0ywuBznMLZRAtkY/qfkE0NPV7TjOj1EN3WQkC9zNtEUlALiXAY3o1BL0Zlpftdm8EPpLLhkyBmvDtEUza2gQIxhf5ygSeQzkZT46MS3AVcz1SfQJuvSIkYrctM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791867101; c=relaxed/simple;
	bh=7RKZZItk8g+R4JYvSk3BdudnGBrDu4OaXsDqhSZZ/sM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GqTYyUxdTH4vNE3uWlRGYqTcq2yjg9hI1gNH/UEScrmR2kX+K15ypaOWA1e0FM6MdrARCXGn52u5GvhryquES/z2OnbEq6HoGMLAHzJmw5N1BOyrxarp6L894J4IBYHrJYyLJSqJvugQkYwm1cK0V6CsBp0yK9qpD/OmYTrjNwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL3NE/lv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL3NE/lv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF231F000FF;
	Tue, 13 Oct 2026 04:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791867099;
	bh=2uoa3rlTPsqF5WVC1KJ22msnIAaVeXC7kqTLcn+GQmw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JL3NE/lvcnHazw2aBgWOmEGQWiw1FvI+Q+0sWq+2itDqeMap2kB1BU43d7K9lrnvD
	 n+TV8DuD/vCKi5PknrhzzhEP/kUdrNKTxm4y19xcKc05ms+1GgONJ9qlsjAgo8duVu
	 9eGqqIm5v/WVuShIgDGEvRKk3J95Ege8YQav7h3RHJAiQRh7BGhFTf4/cxCNI34ODz
	 rnjiD/QI6oioUY5+cpRa9xcoeEZplIMQrsOvlQrdji07V6IRGOc4yfCgKP5CYBwdlW
	 3RdUxC0aS4T6UBv/5HSlUn5pxFnmn2p2VvHicnhlGdgebnXC4wD8GCPLXBCGPNKi0c
	 oUKhpbpxHeRVg==
Subject: Re: [PATCH net v2] net/sched: sch_netem: prevent packet length
 underflow with negative overhead
From: netdev-bot+sashiko@kernel.org
To: dungvn2345@gmail.com
Cc: stephen@networkplumber.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, hagen@jauu.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 13 Oct 2026 04:51:38 +0000
Message-ID: <179186709813.434549.16042014331752584322@kernel.org>
In-Reply-To: <20261012044322.503949-1-dungvn2345@gmail.com>
References: <20261012044322.503949-1-dungvn2345@gmail.com>
X-sashiko-severity: Critical
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

Critical: 1 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] In packet_time_ns() (net/sched/sch_netem.c), the patch swaps
  `div64_u64(len * NSEC_PER_SEC, q->rate)` for `mul_u64_u64_div_u64(len,…
- [Medium] The commit message says clamping packet_time_ns() to S64_MAX
  "prevents the resulting delay from turning negative in s64 delay…

--

net/sched: sch_netem: prevent packet length underflow with negative overhead

This patch makes packet_time_ns() return 0 when the effective packet
length or the cell length is non-positive. A negative packet_overhead
then no longer wraps len to a huge value and stalls the qdisc. The patch
also computes cell_len as s64, uses mul_u64_u64_div_u64() for the final
calculation, and clamps the result to S64_MAX.

> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index 8a1b89a289d8f..3eccdc93c0b6b 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c

[ ... ]

> @@ -366,17 +367,26 @@ static s64 tabledist(s64 mu, s32 sigma,
>  
>  static u64 packet_time_ns(u64 len, const struct netem_sched_data *q)
>  {
> +	u64 d;
> +
> +	if ((s64)len + q->packet_overhead <= 0)
> +		return 0;
> +
>  	len += q->packet_overhead;
>  
>  	if (q->cell_size) {
>  		u32 cells = reciprocal_divide(len, q->cell_size_reciprocal);
> +		s64 cell_len = (s64)q->cell_size + q->cell_overhead;
>  
>  		if (len > cells * q->cell_size)	/* extra cell needed for remainder */
>  			cells++;
> -		len = cells * (q->cell_size + q->cell_overhead);
> +		if (cell_len <= 0)
> +			return 0;
> +		len = (u64)cells * cell_len;
>  	}
>  
> -	return div64_u64(len * NSEC_PER_SEC, q->rate);
> +	d = mul_u64_u64_div_u64(len, NSEC_PER_SEC, q->rate);

[Severity: Critical]
Can this trap on x86-64 before the S64_MAX clamp is reached?

mul_u64_u64_div_u64() expands to mul_u64_add_u64_div_u64(). On x86-64,
arch/x86/include/asm/div64.h implements that as a plain mulq followed by
divq:

/*
 * Will generate an #DE when the result doesn't fit u64, could fix with an
 * __ex_table[] entry when it becomes an issue.
 */
static inline u64 mul_u64_add_u64_div_u64(u64 rax, u64 mul, u64 add, u64 div)
{
	...
	asm ("divq %[div]" : "+a" (rax), "+d" (rdx) : [div] "rm" (div));
	...
}

include/linux/math64.h also says "Architecture specific code may trap on
zero or overflow". So this code can't depend on the saturating behaviour
of the generic version.

The new s64 cell_len also makes the overflow much easier to hit. The old
expression cells * (q->cell_size + q->cell_overhead) was a u32 product,
so len * NSEC_PER_SEC stayed within u64. With len = (u64)cells * cell_len,
len can now get close to 2^62.

get_rate() copies rate, packet_overhead, cell_size and cell_overhead from
TCA_NETEM_RATE without range checks. For example, with rate=1,
cell_size=1, cell_overhead=INT_MAX and a 100 byte packet:

  cell_len                 = 2^31
  len                      = 100 * 2^31   ~= 2.1e11
  len * NSEC_PER_SEC / 1   ~= 2.1e20      > U64_MAX

The divq would then raise #DE in this path:

netem_enqueue()
  packet_time_ns()
    mul_u64_u64_div_u64()
      mul_u64_add_u64_div_u64()   /* divq */

This runs under the qdisc root lock, possibly in softirq context. The
first packet enqueued would oops the kernel. Triggering it only needs
CAP_NET_ADMIN in the netns, and unprivileged user namespaces can provide
that.

If packet_overhead=INT_MAX is also set, len is about 4.6e18. Any rate
below roughly 250 MB/s then traps.

The commit message says:

    Computing the final transmission time with mul_u64_u64_div_u64() and
    clamping to S64_MAX avoids 64-bit multiplication overflow

Could the value be saturated before the helper is called? One option is
to return S64_MAX when div64_u64(len, q->rate) >= div_u64(S64_MAX,
NSEC_PER_SEC). Another is for get_rate()/netem_change() to reject rate and
cell combinations that can overflow.

> +	return min_t(u64, d, S64_MAX);

[Severity: Medium]
The commit message also says the clamp "prevents the resulting delay from
turning negative in s64 delay arithmetic". Is that true for the caller?

The clamp only limits the value that packet_time_ns() returns. In
netem_enqueue() that value is added to a delay that may already be
positive. The result is then added to a now that may already be a
deadline far in the future:

net/sched/sch_netem.c:netem_enqueue() {
    ...
			if (last) {
				...
				delay -= last->time_to_send - now;
				delay = max_t(s64, 0, delay);
				now = last->time_to_send;
			}

			delay += packet_time_ns(qdisc_pkt_len(skb), q);
		}

		cb->time_to_send = now + delay;
    ...
}

validate_time() only checks that the TCA_NETEM_LATENCY64 latency is not
negative, so delay can already be large before this addition. Adding a
result close to S64_MAX to any positive delay wraps it negative.

The absolute deadline can wrap even with zero latency. Take
packet_overhead=0, cell_size=1, cell_overhead=INT_MAX, rate=8 and a 64
byte packet. The quotient is about 1.7e19, which fits in u64 and gets
clamped to S64_MAX:

  packet 1: time_to_send = T + S64_MAX
  packet 2: now = T + S64_MAX
            time_to_send = T + 2 * S64_MAX  ~= T - 2

tfifo_enqueue() would sort packet 2 ahead of packet 1, and
netem_dequeue() would treat it as already due. The packet skips rate
shaping and goes out of order.

Should netem_enqueue() saturate the accumulated delay and
cb->time_to_send as well, instead of only the per-packet interval?

>  }
>  
>  static void tfifo_reset(struct Qdisc *sch)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012044322.503949-1-dungvn2345%40gmail.com
