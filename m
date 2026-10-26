Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792997438;
	b=i8jtNAvAAk/5O2+qqdpX285f2utHNjcVSxEb21fNoExjvsAedm+BZAj93UnWqvFfMkl0
	 1OdN4Y2o1tXXxDVnZIMj+MQMd2r7s5v/v+7nd1Q/VUdh1iMB2CStnRhZE6MeO3SATGI6Y
	 GuemrWX3zZKZcgInZLHr7gGbaBb1akbezgDlREAFkGarKHZwbWBouZiqE2ckC4vbgJ16k
	 G+DV79a6LWH2yJwkJAl5eHy6PGvhHvy06plqoD6J7TIuDWgpYZ/2ofds7zVQC5Mw6naNR
	 PcQ3ttqpiyx28p7kLFU+lL6dKordj4fYpsAdPefZ9Ra05FiawoMr7mje1IB5CDdZZeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792997438;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mGGTzTbDVNWYnQmVpbZgCh4dhNFuupx1F6U7YbVqkjw=;
	b=KDyw5WDIsZTJSsyS4/eHI3ti14hheub03B418PHFdGYCXMTxuml8r0MACB0FNn76Lmty
	 mO0//ZYAsJHqXSW9qi1/J4MCa+cP2gGKsqO1rbuLsqmND88iJh7FXyVtO+hNFyw5QA14W
	 g4I3bnZ9W8/xlRvBzokryomUtirNFyZprfOPItTkpcqkEJNs4LtDS/97c6QuWoTdvLWBS
	 8lEM/y6jbs4S6Fo19Z5bfY8lUVSj4/reIqjoBnjDptjA5wVITPni1PwvjqCfeBz4S71Yx
	 EaZeD10kfaUsWsjCwM203rC+fUk96jDKx7EQwIFMpDdH5Ne7alUigGIOVtvewz3wXNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUF0qaOc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD46A606A320;
	Mon, 26 Oct 2026 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUF0qaOc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC20A1F01828;
	Mon, 26 Oct 2026 06:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792997432;
	bh=mGGTzTbDVNWYnQmVpbZgCh4dhNFuupx1F6U7YbVqkjw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EUF0qaOcqXijAYxN/SEzQ6twa4I5WqUb0a/9TjIoalYIbhIo12caB9egezz5tDZh1
	 ZaY69jnouSphGUfRckZwX/YFmSK+rtAIU9mBW7939sKiwpJ3OE5shSfKp4+lLPQupM
	 SGjw/ug6YOzvdRFymXnFbABt0lpH5Rxt88XuwbFev4oX8TEW+bM+EK+VbQAp/+FDGt
	 7OKJaS/kbwlNPqTpfofy5sc+ZHUPnJ/Hv/DfYygru7MoMOSWQos6pcWWF6qWDhqno0
	 HiWAZP7Vb7EYWPxLmUSi+KQcz/9i/+zy5tlvuQEJxubUTrqN/yllli5xSFaXlSSarP
	 vRjyGJPrxjx0w==
Subject:
 Re: [PATCH net 2/2] tcp: fix shift-out-of-bounds in inet_csk_rto_backoff()
From: netdev-bot+sashiko@kernel.org
To: jiayuan.chen@linux.dev
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 ncardwell@google.com, kuniyu@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 06:50:31 +0000
Message-ID: <179299743134.3134.13204213247651180532@kernel.org>
In-Reply-To: <20261023064915.401112-2-jiayuan.chen@linux.dev>
References: <20261023064915.401112-2-jiayuan.chen@linux.dev>
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

- [Medium] The code change is correct.

--

tcp: fix shift-out-of-bounds in inet_csk_rto_backoff()

This commit caps the shift amount in inet_csk_rto_backoff() at 32, so a
large icsk_backoff no longer causes an out-of-range shift of icsk_rto.
The clamp covers both callers, tcp_ld_RTO_revert() and the orphan check
in tcp_probe_timer().

> icsk_backoff is bumped on every RTO and zero window probe, and the only
> thing bounding it is tcp_retries2 (a u8 sysctl, 0..255).

[ ... ]

> Set tcp_retries2 to 64 or more and keep the peer silent, icsk_backoff
> climbs past 63 and the shift is UB.

[Severity: Medium]
The code change looks correct to me. Is this description of how the bug
is reached accurate, though?

tcp_retries2 caps icsk_backoff only in the zero window probe path:

net/ipv4/tcp_output.c:tcp_send_probe0() {
    ...
	if (err <= 0) {
		if (icsk->icsk_backoff < READ_ONCE(net->ipv4.sysctl_tcp_retries2))
			icsk->icsk_backoff++;
    ...
}

In the RTO path there is no limit on the count:

net/ipv4/tcp_timer.c:tcp_retransmit_timer() {
    ...
		icsk->icsk_backoff++;
		icsk->icsk_rto = min(icsk->icsk_rto << 1, tcp_rto_max(sk));
    ...
}

The connection is killed only by tcp_write_timeout(), which calls
retransmits_timed_out(sk, retry_until, icsk_user_timeout). When
TCP_USER_TIMEOUT is non-zero, the tcp_retries2 based model is skipped,
and only elapsed time is compared against the user timeout:

net/ipv4/tcp_timer.c:retransmits_timed_out() {
    ...
	if (likely(timeout == 0)) {
		...
		timeout = tcp_model_timeout(sk, boundary, rto_base);
	}
    ...
}

Even when the user timeout is 0, the model bounds elapsed time and not
the icsk_backoff count.

No privilege is needed for either socket option. tcp_sock_set_user_timeout()
accepts any value >= 0, and TCP_RTO_MAX_MS accepts values down to 1000 ms
in do_tcp_setsockopt().

So an unprivileged process can trigger this with default sysctls:

  setsockopt(TCP_RTO_MAX_MS, 1000)
  setsockopt(TCP_USER_TIMEOUT, a few minutes)
  peer goes silent
    tcp_retransmit_timer() fires about once a second
    icsk_backoff passes 63 in about a minute
  ICMP unreachable arrives
    tcp_v4_err()->tcp_ld_RTO_revert()->inet_csk_rto_backoff()

Without TCP_RTO_MAX_MS, a TCP_USER_TIMEOUT of a few hours is enough. An
orphaned socket reaches the same shift through tcp_probe_timer().

Is the impact also larger than a UBSAN warning? On x86-64 the hardware
masks the shift count. tcp_ld_RTO_revert() could then compute an
icsk_rto that is far too small, and the orphan alive check in
tcp_probe_timer() could give the wrong answer.

Could the commit message say that unprivileged socket options and a
network ICMP are enough to trigger this, and describe the RTO impact,
instead of saying it needs tcp_retries2 >= 64?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023064915.401112-1-jiayuan.chen%40linux.dev
