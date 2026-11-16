Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794806504;
	b=J7Td53IbBQQAZHW6AkPF/M1MahDuoOocCOOSf3vUmqUNPiaE1Yzk7a++bGgFItuS1oDU
	 TbpAKjwhRXvy11YtQm9nh8xMvDL2Q0qJt2TjlK/U0aah02nal5wuoEa7M3aM8TB4TIhZ/
	 n06XVAIfzNbFZiOq1gJ4nafI9LvUcAT2hBVIx+APF37JtYDEwYfS9owwE9ow8lXoQ9FKB
	 0LpPnhcSTCbWzoE2z8fzFQPdQtO9vkK9zYnHAh9qXyheix9Gdnb6L0Fpow9TZZ5MibQfq
	 PpwSutwy/SlmmsWSWSvgbkAjPYUYssMSFSgcFbl++S0MeIjufmfNY4CaaFuiYm9Izcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794806504;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fBQuIlX1DRBYchoBiFw8IVANuBNaBS/6iLy0xMzuzEI=;
	b=Wzj5Azt/9VyfuEzg8mhqcGhcLX6p2tdyPRwE+pVueGOs7lLc/If9/4k3RRQh3XfrCy+X
	 io8PG5TdGW4Wdn8KIgxNMB6jM4IVNOlZOw0Df+TaUQIhX3KOUpUGeQLFaYFR4a1HRTGIH
	 CwVSeA8C0HJTA/ih1ekda1lrecU0ey1/1YZUK0PmEbvaDl2MA2s2i6f9Ehd1oqJ3TG7/6
	 nWoXLTOh7bX7VXVEN/T+Q4FlxU9kERbQftwjwry5t4FeFrqRzHdkikPuL2X3zQ/06S97r
	 Fr3eDC6Gd8uR2ZoXs/UOgjxI39rWtsk8cwk7sSkZokNoP3twGsqwJjVzdMGnfmTI5AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kdbr1DW9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB00606A323;
	Mon, 16 Nov 2026 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kdbr1DW9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79721F000C4;
	Mon, 16 Nov 2026 05:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794806504;
	bh=fBQuIlX1DRBYchoBiFw8IVANuBNaBS/6iLy0xMzuzEI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kdbr1DW97+dIb6BvDMoons5bpJwMFi84dmJhwINDj1S4w/iHun5uxSEAfo2g4sQ2N
	 SpPvvjkRcPmc+aDhIbJqe7BACUZFdvDEOwFFZIMwasljxW4EvLLnlApNjsYEvtYx16
	 Qpb+HMu9CfZ31u+WgJZwh4PKZlkt+ctyBtYv+8YFZ3Shvpepq1GMz7bzz9qK8gI1OF
	 KQaX1pMzLiu0DU7nqpY47x5GsDn2C1PIiSzaW0WvsYyWL0tk7LoOJlyOP7dbQM/ebu
	 qKF3ByTngMALVw19vnmqLV0K2aQ1JG7VGo3GM/+9vHKzo8XMFls8p7z4LP+RK+8FVk
	 OhrPstSvYZ8Ug==
Subject:
 Re: [PATCH net v2 1/2] tcp: avoid wrapping Fast Open blackhole timeout
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
Date: Mon, 16 Nov 2026 05:21:42 +0000
Message-ID: <179480650221.3133.4194401145263235869@kernel.org>
In-Reply-To: <072048c5616098a20126342372d66697c728881d.1794672619.git.x-professor@outlook.com>
References: <072048c5616098a20126342372d66697c728881d.1794672619.git.x-professor@outlook.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds a new upper bound, `.extra2 = &one_day_secs`
  (86400), to `net.ipv4.tcp_fastopen_blackhole_timeout_sec` in…
- [Low] The commit body of "tcp: avoid wrapping Fast Open blackhole
  timeout" refers to patch revisions: 'In the v1 arithmetic-only test,…

--

tcp: avoid wrapping Fast Open blackhole timeout

This commit computes the Fast Open active-disable interval in
tcp_fastopen_active_should_disable() as a u64 and caps it at
MAX_JIFFY_OFFSET, so the delay can no longer wrap. It also limits
tcp_fastopen_blackhole_timeout_sec to 86400 seconds and documents the new
limit in ip-sysctl.rst.

> This issue was found using a static analysis tool. A loopback reproducer
> induced 12 Fast Open blackholes and waited 1.2 seconds before opening
> another connection. In the v1 arithmetic-only test, the unpatched kernel
> retried active Fast Open, while the fixed kernel used a regular TCP
> handshake. The reproducer required neither kernel modifications nor
> fault injection. The input limit added here rejects that large setting.

[ ... ]

> On the v2 kernel, the sysctl accepts 86400 seconds and rejects 86401,
> leaving the previous value unchanged.

[Severity: Low]
This isn't a bug, but these sentences mention patch revisions (v1 and v2).
Could this revision history go below the --- line instead? Once the patch is
merged, v1 and v2 won't mean anything in git history.

The wording also suggests that the only functional test of the arithmetic
fix (the 6912213 second timeout) was run on v1. The submitted code now
rejects that input, and the only v2 test described is the sysctl range
check.

The arithmetic fix still matters within the new limit. At HZ=1000,
64 * 86400 * 1000 = 5,529,600,000. In 32-bit math that wraps to
1,234,632,704 jiffies, which is about 14.3 days instead of 64 days.

Could the changelog describe a test of the submitted code on that path?

The companion MPTCP patch in this series uses the same v1/v2 wording.

> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index bf193e7ec5168..5bc357e189bde 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -1152,6 +1152,7 @@ static const struct ctl_table ipv4_net_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_tfo_blackhole_detect_timeout,
>  		.extra1		= SYSCTL_ZERO,
> +		.extra2		= &one_day_secs,
>  	},

[Severity: Medium]
Is this new upper bound needed for the overflow fix? The patch is also
tagged Cc: stable.

proc_tfo_blackhole_detect_timeout() calls proc_dointvec_minmax(), so extra2
is enforced:

net/ipv4/sysctl_net_ipv4.c:proc_tfo_blackhole_detect_timeout() {
    ...
	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
	if (write && ret == 0)
		atomic_set(&net->ipv4.tfo_active_disable_times, 0);
    ...
}

Before this patch, any non-negative int was accepted, such as 172800 or
604800. Now those writes fail with -EINVAL. The stored value stays as it
was, and the tfo_active_disable_times reset is skipped.

At boot, the stored value is the per-netns default of 0 from tcp_sk_init().
If sysctl.conf has a multi-day value, would Fast Open blackhole detection
stay disabled after a stable update?

The u64 calculation and the cap in tcp_fastopen_active_should_disable()
already seem to handle every int input:

	delay = (u64)multiplier * tfo_bh_timeout * HZ;
	...
		  min(delay, MAX_JIFFY_OFFSET);

tfo_bh_timeout is at most 2^31-1, multiplier is at most 64, and HZ is at
most a little over 1000. The product stays below 2^48, and the cap covers
both 32-bit and 64-bit kernels. So the one day limit looks like a policy
change, not part of the fix.

The commit message mentions the limit. It doesn't say that values accepted
before will now be rejected.

The companion patch in this series, "mptcp: avoid wrapping blackhole
timeout", makes the same arithmetic fix and says "Preserve the existing
sysctl input range". So the two patches treat the input range differently.

Could the bound be dropped here? Or could it move to a separate patch,
without Cc: stable, whose changelog describes the narrower range?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794672619.git.x-professor%40outlook.com
