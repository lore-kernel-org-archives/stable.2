Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794806506;
	b=q97fLDVIKyvcMofK44QSdjl8DibpsFSzj6fS2DXToX62GagCYqmwAjiB1A0FltaWcSpR
	 Zas6kjP0+/UEYoJ+ptaxKQvpbhd0PLcy2LPfE8OJ6XiFwET3xftaPT1YZPa79vFIRHHp3
	 Mkr5awwml7OsWpaMeOaP4gdTlPxT/SZRj6l5Nm6RYbp+oGlIJatPGgy93dB3f9lzAsd8G
	 gqPqz/H72io1YX73q+vAvidtqscmaSoCf71fp8DE+FJa3q/7Di/5UNOncfBKeIizngTZW
	 gCbR5adAkX4yUjkSp9YTJRcv6XZcdbG7Yi9sYdtt3cV/TLXkqdbSIRzhSIWUiVcyf5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794806506;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jEfV+JQF7FD38ojElSzO1mtu8Ghpnr4QfBw1VO2XPSQ=;
	b=q2FSFaQcKAH7o/aGzNmQDG7Y9PrzUVqBseWKS7xhs+AgrHrNX9KgknePMQoRtObuZdRL
	 DpiwxmxWQwnTZ7DB6bnP024oVMByWSrJWHvrwkpr7Z1Vu4OzlzuggUGvOWK5SHBnM1wik
	 FBzGOipQ/1IAA2kc1qfkh8u5n0e3hFhqBADeFjGi0mJ+ts6swwdZeaRqCHM2ksIbyrDgc
	 x7aFdkNiTSKOAPniKAg0o8Z5D0eWIMI8scSgn0EZ6Ly7+4udQcOcwjFUfY1fgnUcDAByT
	 HEcFyyd5iNEqI7jiXHQdSNzs9kOC+25AzL5hGnFHQpA7ClfgWroD1R9vRFvaSM1Gbgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9xEqbK8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5A5606A334;
	Mon, 16 Nov 2026 05:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9xEqbK8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C991F000C4;
	Mon, 16 Nov 2026 05:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794806506;
	bh=jEfV+JQF7FD38ojElSzO1mtu8Ghpnr4QfBw1VO2XPSQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M9xEqbK8ku6TWTxTq5yvkeE98zgiMdOubhckbSmZq2fehatceTUvvOt6B/Xg+69Mq
	 TtsweDShv4do/NIiGebsAFq4Gj+Fgd14ptYRa7T3a3nF8pQ/Ym5lR9apF4tMSFsDAX
	 SttAb/pY9sDt06vkKNvxUlKJJHxwAApReIfRY3niXP58rZ4ZLCoNpAwR5fzHCtKS4v
	 yHbVDJaQ65eOb9t9Qytur1d5G5fwN0JMZ+ziI55498x3vyY0wS6SdbPncYXzajmgkF
	 TkE3heWXrvUJ8lmc4zQ8DgVRSwcMpYA0iFsCSTTDfYJpo/UACiYi4HF4SpXUTekeBN
	 eDRGq+q1xgg6A==
Subject: Re: [PATCH net v2 2/2] mptcp: avoid wrapping blackhole timeout
From: netdev-bot+sashiko@kernel.org
To: x-professor@outlook.com
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, linux-doc@vger.kernel.org, edumazet@kernel.org,
 ncardwell@google.com, gang.yan@linux.dev, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 ycheng@google.com, weiwan@google.com, stable@vger.kernel.org,
 yangang@kylinos.cn
Date: Mon, 16 Nov 2026 05:21:44 +0000
Message-ID: <179480650425.3133.15313880518132043396@kernel.org>
In-Reply-To: <070c69fa36f83fe47a5eb6d1434f543dabe930e7.1794672619.git.x-professor@outlook.com>
References: <070c69fa36f83fe47a5eb6d1434f543dabe930e7.1794672619.git.x-professor@outlook.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message body refers to earlier revisions of this
  patch: "In the v1 arithmetic-only test, the unpatched kernel retried…
- [Low] mptcp_active_should_disable() (net/mptcp/ctrl.c:514-515) now
  silently clamps the disable interval to MAX_JIFFY_OFFSET.

--

mptcp: avoid wrapping blackhole timeout

This commit computes the active-disable interval in
mptcp_active_should_disable() in u64, so multiplier * blackhole_timeout *
HZ no longer wraps in 32-bit arithmetic. The result is capped at
MAX_JIFFY_OFFSET before it is added to active_disable_stamp.

> This issue was found using a static analysis tool. A loopback reproducer
> induced 12 MPTCP blackholes and waited 1.2 seconds before opening another
> connection. In the v1 arithmetic-only test, the unpatched kernel retried
> MP_CAPABLE, while the fixed kernel used TCP fallback directly. The
> reproducer required neither kernel modifications nor fault injection.

[ ... ]

> On the v2 kernel, the loopback blackhole reproducer completed all 12
> clients and the probe used TCP fallback directly instead of retrying
> MP_CAPABLE.

[Severity: Low]
This isn't a bug, but the changelog refers to earlier revisions of the
patch ("In the v1 arithmetic-only test" and "On the v2 kernel"). After the
patch is merged, v1 and v2 mean nothing in git log. This is also tagged
for stable, so backporters will read it without the mailing list thread.

Could the reproducer results be described once, against the final code,
with the per-version history moved below the --- line?

The numbers themselves check out. 64 * 6912213 * 1000 = 442,381,632,000,
which is 512 mod 2^32. With 12 blackholes the multiplier is
1 << min(11, 6) = 64, and a 1.2 second wait is longer than 512 jiffies at
HZ=1000.

> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 63c5747f0f63c..0b10e94e7f43c 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c

[ ... ]

> @@ -501,12 +502,17 @@ bool mptcp_active_should_disable(struct sock *ssk)
>  	/* Paired with smp_mb__before_atomic() in mptcp_active_disable() */
>  	smp_rmb();
>  
> -	/* Limit timeout to max: 2^6 * initial timeout */
> +	/* Limit the backoff multiplier to 64. */
>  	multiplier = 1 << min(disable_times - 1, 6);
> +	delay = (u64)multiplier * blackhole_timeout * HZ;
>  
> -	/* Paired with the WRITE_ONCE() in mptcp_active_disable(). */
> +	/*
> +	 * Cap the delay for safe jiffies comparisons on 32-bit systems.
> +	 * The timestamp read is paired with WRITE_ONCE() in
> +	 * mptcp_active_disable().
> +	 */
>  	timeout = READ_ONCE(pernet->active_disable_stamp) +
> -		  multiplier * blackhole_timeout * HZ;
> +		  min(delay, MAX_JIFFY_OFFSET);

[Severity: Low]
On 32-bit kernels MAX_JIFFY_OFFSET is ((LONG_MAX >> 1) - 1), which is
0x3ffffffe jiffies, or about 12.4 days at HZ=1000. Does this clamp
silently shorten blackhole_timeout values that the sysctl still accepts?

The sysctl entry only sets a lower bound:

net/mptcp/ctrl.c:mptcp_sysctl_table[] {
	...
	{
		.procname = "blackhole_timeout",
		.maxlen = sizeof(unsigned int),
		.mode = 0644,
		.proc_handler = proc_blackhole_detect_timeout,
		.extra1 = SYSCTL_ZERO,
	},
	...
}

So values up to INT_MAX are accepted. Anything above about 1,073,741
seconds is cut short even on the first blackhole (multiplier 1). Smaller
values stop doubling before they reach the 64x factor.

time_before() handles deltas up to LONG_MAX, so the cap is half of what
the comparison can take. The old code compared intervals between 2^30 and
2^31-1 jiffies correctly, and those are now shortened.

For example, take HZ=1000, blackhole_timeout = 2000000 and a first
blackhole. The old code disabled active MPTCP for 2e9 jiffies (about 23
days). The new code disables it for 1,073,741,822 jiffies (about 12.4
days).

The commit message says:

    Preserve the existing sysctl input range and backoff
    for representable intervals.

But this interval is representable and still gets shortened.

Documentation/networking/mptcp-sysctl.rst, and the zh_CN translation,
still describe blackhole_timeout as an initial period that will "grow
exponentially", with no upper bound mentioned.

Should the clamp be documented, or should the sysctl get an upper bound
that matches it?

64-bit kernels are not affected, because MAX_JIFFY_OFFSET there is far
above 64 * INT_MAX * HZ.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794672619.git.x-professor%40outlook.com
