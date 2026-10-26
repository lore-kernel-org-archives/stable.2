Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792997432;
	b=IGEqzqGLCnw+AoO2JkIKLraDpTJyodBAyg0qDFAKGfojZTw9mHLjhilwziXH4aa75TeU
	 8UhtezIeMPtGYstPrjwxB4VPi1/vxFIlrwcPRvkmDrI16my6/0bamnqHb9v4jTH0lkayu
	 niIdTsszD5UnfSv0re4M+ZXcE8yFzlqO93qukUk4gpHRhS5JQxX42LTHzpsJxPhOPswvb
	 ANG0iRyQXwDoCMO0OYElch+GTh/Z+RYMRZ32LlLpyD26iyxlNABjg3rqblTzjrCM2Fcuj
	 Pz2WjifhurZA/VuIILevCc0HLhYYXJ2U9mUCITle5A52TyzCVxYLDdFOPNbECWmTv0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792997432;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WdCYRudtEDYPOH46p/Wih0pwrS9+80f8dSGtERPW1PE=;
	b=SY26ss1ILXB35XhWksCaXmpqHwMSOx15Aliwb0mcAahLzkPmkIx2wdGH7DiCxU3gW2Jw
	 jY/WDIpPMtMy3M5wKI8rWSf77oV8UQhrxVoeqnRM01T0UCZcbvV9u0lDShspgeA0hrwE+
	 95ZWhk9pGznehuCzksA2JMq2zDs3aWc+M1WRWKbE1UH6xq6bLALnoNqDOF/AFNhLdRVBd
	 h6h2r50I1NvgjtDpwF3Ke5KlEAZEaNMy4kfvkg9WXV9bQnLQUhTl2dNqz1CtKqwnGpocQ
	 j7WHTUinrNTsUjz2ii3PiVppMDTvl5y69Dp0FzH0l5Kt2tV/k6vCW3EXFCD3ThbTMRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTOXNwUp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC58606A31A;
	Mon, 26 Oct 2026 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTOXNwUp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1C41F01825;
	Mon, 26 Oct 2026 06:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792997431;
	bh=WdCYRudtEDYPOH46p/Wih0pwrS9+80f8dSGtERPW1PE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eTOXNwUpY83L2zD0pNiRjvoA5e60H1H1rDNgnjv1s5ZGJqirSnmQu71gaK+qeoq1n
	 0X4tO2I2zAY780okWtzNuQgt5RfDpHrsV1ZmC62ZdV7UKfWl6lxFHr3om6tJgfbeQV
	 4FgXOEPRQv/ocMcsbPA62msjA/sfaflrvI2SxzyH50NwyrGYQC9lRnNzpmfvcDFof1
	 FX9L7ZZ8BunXl3WxVwdRSc9l5xLaKXscQGVaVCjJrKmHf4WSEftCgDmV5g/pDJmXjr
	 jt0XAegyagAZKAaIJRHOMCHHFBwi0PQWNKrR1wfU6+DVB8tFYB5ShoC8vKwq+dFvX+
	 FADFmclygMf1Q==
Subject:
 Re: [PATCH net 1/2] tcp: fix shift-out-of-bounds in SYN-ACK retransmit timers
From: netdev-bot+sashiko@kernel.org
To: jiayuan.chen@linux.dev
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 ncardwell@google.com, kuniyu@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 06:50:29 +0000
Message-ID: <179299742989.3134.10967114195935725081@kernel.org>
In-Reply-To: <20261023064915.401112-1-jiayuan.chen@linux.dev>
References: <20261023064915.401112-1-jiayuan.chen@linux.dev>
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

- [Medium] The commit message gets the TCP_DEFER_ACCEPT path wrong and
  does not mention a user-visible change.

--

tcp: fix shift-out-of-bounds in SYN-ACK retransmit timers

The patch caps the shift amount in the request_sock SYN-ACK timeout helper
at 30. It also limits max_retries / max_syn_ack_retries to 127, the width
of the num_timeout field, and sends the TFO SYN-ACK timer through the same
bounded helper. A further hunk lowers the TCP_DEFER_ACCEPT conversion cap
in secs_to_retrans() from 255 to 127.

[ ... ]

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 99d7237a623d8..a309fd45ad425 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -358,7 +358,7 @@ static u8 secs_to_retrans(int seconds, int timeout, int rto_max)
>  		int period = timeout;
>  
>  		res = 1;
> -		while (seconds > period && res < 255) {
> +		while (seconds > period && res < MAX_TCP_SYNACK_RETRIES) {

[Severity: Medium]
This hunk lowers the TCP_DEFER_ACCEPT cap from 255 to 127. It seems to be
the actual fix for the defer-accept trigger, but none of the three bullets
in the commit message describe it. Could the change list mention it?

The commit message also says:

  TCP_DEFER_ACCEPT can derive a comparable count. Both feed the
  max_retries / max_syn_ack_retries that decide how long a request_sock
  keeps retransmitting SYN-ACKs.

Is that accurate? do_tcp_setsockopt() stores the converted value in
icsk_accept_queue.rskq_defer_accept, and syn_ack_recalc() checks it as a
separate condition:

net/ipv4/inet_connection_sock.c:syn_ack_recalc() {
    ...
	*expire = req->num_timeout >= max_syn_ack_retries &&
		  (!inet_rsk(req)->acked || req->num_timeout >= rskq_defer_accept);
    ...
}

tcp_check_req() also compares req->num_timeout against rskq_defer_accept
directly. The value never passes through max_retries or
max_syn_ack_retries, so the new min_t() clamps in reqsk_timer_handler() and
tcp_fastopen_synack_timer() don't apply to it.

Before this patch, take rskq_defer_accept above 127 and a peer that sends a
bare ACK (acked=1) but no data. The 7-bit num_timeout can never reach
rskq_defer_accept, so expire stays false. reqsk_timer_handler() then keeps
re-arming through tcp_reqsk_timeout(), and the shift goes out of bounds once
num_timeout reaches 64.

That path only needs setsockopt(TCP_DEFER_ACCEPT) on the caller's own
listener, with the default tcp_synack_retries=5. The commit message gives
the trigger only as "Set tcp_synack_retries high enough", which needs root.
Would it help stable backporters to say that this is reachable without
privileges?

There is also a user-visible change here. setsockopt(TCP_DEFER_ACCEPT) now
stores at most 127 retransmits, and larger requested values are truncated
without notice. As a result, the largest value getsockopt(TCP_DEFER_ACCEPT)
can return drops from retrans_to_secs(255, 1, 120) = 29887 seconds to
retrans_to_secs(127, 1, 120) = 14527 seconds.

The ip-sysctl.rst update only covers tcp_synack_retries. Should the commit
message or the documentation mention the new TCP_DEFER_ACCEPT limit?

>  			res++;
>  			timeout <<= 1;
>  			if (timeout > rto_max)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023064915.401112-1-jiayuan.chen%40linux.dev
