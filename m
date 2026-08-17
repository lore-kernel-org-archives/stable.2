Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B97D377558;
	Mon, 17 Aug 2026 19:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996519; cv=none; b=S0PItnAaFPh1hBKWSG3WiTcyaq+iHUVMP3dfnTzHFR9ItmjT0jm7rlE0fikp3DXOD1pTjHFmSQKsp6aHxVuEGlyK00L3YG1oqLQdelu2lc+9zQ5XJjJg4esVzSB2B/exPc7pB0vFMvtkoNubABEoi7Nj0Ooo9tOg7c28hMOzQUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996519; c=relaxed/simple;
	bh=QidQL50ZfV3C2t+wpX467C/t72zkyKNRTxxjF2ANlyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iy5VvEKv9gv+iTXslKOlXcEbVisSFD4TL+3OwVvB4t99fJPvMco4VAda9WcEozD8qw9ItVsZo3YaNIqMMCEibAqTIPdSBpD3xL/ieCjphTEkMIiBuD3qll8v/m7WG9ws+RXzcv7CxPrFkpo+9OJU7SKH6uOwFLfY7arKZKEwYXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oT2Eadib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT2Eadib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E701F000E9;
	Mon, 17 Aug 2026 19:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786996518;
	bh=KWas6xRtcY9D5YMxy+1OJ7ZnBQfr4u4aQ3tcwN47YAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oT2EadibTM0/m3QmI+OB2/hVROTb+bPy2q/9Pb7vu7LEeA8qipnDRSK5yEsNFJfLX
	 eUiZ2B8AcTeEC3ozLasRb+aj4tYCcAUR4svGW4urZYcsNpK28skzFOvHzYxRCLsNUu
	 Dqeo0YF1gkbc9/xeZN8mJLowjrM3a2SlDfrglr9PTwff5y35V83QIFZLiJDqO1xgEO
	 o+b09ZVGqQ1J5CDvrcX9D0ZpzikcZmMac6/5SLhgJAS/ZJ9QyXTYzlCQGS4Tu5Z/pv
	 1OQ+uPVyWXlz+Y1qw1jrar1WLU5jKaHLvrtEdNcsnSbxMqfOZ6A5VHYwEgbRl93/7b
	 +uTmPRYh43N+g==
From: Jakub Kicinski <kuba@kernel.org>
To: ast@fiberby.net
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	knielsen@knielsen-hq.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] tcp: reset late connection after listening socket close
Date: Mon, 17 Aug 2026 12:55:16 -0700
Message-ID: <20260817195516.3560500-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811210925.1751466-1-ast@fiberby.net>
References: <20260811210925.1751466-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
tcp: reset late connection after listening socket close

When __inet_inherit_port() returns -ENOENT because the listener already
released its bound port, the child socket was dropped silently and the peer
could hang forever. This patch adds an -ENOENT case to both
tcp_v{4,6}_syn_recv_sock() that sends an RST with the listening socket
before dropping the child.

Link: https://lore.kernel.org/87sf0ldk41.fsf@urd.knielsen-hq.org # [1]

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index b8887cdd66c5..9a14c2e56ec3 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c

[ ... ]

> @@ -1756,8 +1757,12 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
>  		goto put_and_exit; /* OOM, release back memory */
>  #endif
>  
> -	if (__inet_inherit_port(sk, newsk) < 0)
> +	ret = __inet_inherit_port(sk, newsk);
> +	if (unlikely(ret < 0)) {
> +		if (ret == -ENOENT)
> +			goto send_reset_and_exit;
>  		goto put_and_exit;
> +	}
>  	*own_req = inet_ehash_nolisten(newsk, req_to_sk(req_unhash),
>  				       &found_dup_sk);
>  	if (likely(*own_req)) {

[ ... ]

> @@ -1784,6 +1789,8 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
>  exit:
>  	tcp_listendrop(sk);
>  	return NULL;
> +send_reset_and_exit:
> +	tcp_v4_send_reset(sk, skb, SK_RST_REASON_TCP_STATE);

[Severity: High]
Can this oops when the listener has TCP-AO keys installed?

As the commit message explains, this label is reached because
tcp_set_state(sk, TCP_CLOSE) already ran inet_put_port(), so sk->sk_state
is normally TCP_CLOSE here, and the socket was never established.

tcp_v4_send_reset() then feeds that socket to the AO code:

net/ipv4/tcp_ipv4.c:tcp_v4_send_reset() {
	...
	if (aoh && tcp_v4_ao_sign_reset(sk, skb, aoh, &arg, &rep.th, rep.opt))
		return;
	...
}

and tcp_ao_prepare_reset() only special-cases listen/request sockets:

net/ipv4/tcp_ao.c:tcp_ao_prepare_reset() {
	...
	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_NEW_SYN_RECV)) {
	...
	} else {
		*key = tcp_ao_established_key(sk, ao_info, aoh->rnext_keyid, -1);
		if (!*key)
			return -ENOENT;
		*traffic_key = snd_other_key(*key);
		rnext_key = READ_ONCE(ao_info->rnext_key);
		*keyid = rnext_key->rcvid;
	...
}

TCP_CLOSE is not in that mask, so the else branch runs on a socket whose
ao_info->rnext_key was never set.  tcp_ao_add_cmd() deliberately skips it
for listen/close sockets:

net/ipv4/tcp_ao.c:tcp_ao_add_cmd() {
	...
	if (!((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE))) {
		tcp_ao_cache_traffic_keys(sk, ao_info, key);
		if (first) {
			ao_info->current_key = key;
			ao_info->rnext_key = key;
		}
	}
	...
}

and include/net/tcp_ao.h documents "Never dereference any of them from
listen sockets".  Does rnext_key->rcvid then dereference NULL in softirq
context?

If rnext_key happens to be non-NULL, *traffic_key = snd_other_key(*key)
returns traffic key bytes that were never computed, since
tcp_ao_cache_traffic_keys() is skipped for LISTEN/CLOSE and
tcp_ao_key_alloc() uses sock_kmalloc() without zeroing.  Would the RST be
MACed with uninitialized memory and dropped by the peer?

In the narrow window where the listener is still TCP_LISTEN, the LISTEN
branch derives the key with sisn = th->seq and disn = 0, which only matches
a SYN, not the final handshake ACK that got us here.  Does that leave the
RST with an invalid MAC (or no RST at all when tcp_ao_do_lookup() fails and
tcp_v4_ao_sign_reset() returns early), so the hang this patch fixes remains
for TCP-AO connections while the child is still destroyed?

[Severity: Medium]
Is this path also reachable from TCP Fast Open, and if so, is the RST
correct there?

tcp_fastopen_create_child() calls into this function with the TFO SYN skb:

net/ipv4/tcp_fastopen.c:tcp_fastopen_create_child() {
	child = inet_csk(sk)->icsk_af_ops->syn_recv_sock(sk, skb, req, NULL,
							 NULL, &own_req, NULL);
	if (!child)
		return NULL;
	...
}

For that skb th->ack is 0, so tcp_v4_send_reset() emits RST+ACK
acknowledging the SYN.  The NULL return does not abort the handshake:
tcp_try_fastopen() returns NULL and tcp_conn_request() continues in the
else branch:

net/ipv4/tcp_input.c:tcp_conn_request() {
	} else {
		tcp_rsk(req)->tfo_listener = false;
		if (!want_cookie &&
		    unlikely(!inet_csk_reqsk_queue_hash_add(sk, req)))
			...
		af_ops->send_synack(sk, dst, &fl, req, &foc,
	...
}

Does that mean the same receive pass sends an RST and then a SYN-ACK for
the same 4-tuple, and leaves a request sock hashed on a listener that is
being torn down?  There is currently no way for this label to tell the
caller that the flow was already reset, so the fast open fallback cannot be
suppressed.

>  put_and_exit:
>  	newinet->inet_opt = NULL;
>  	inet_csk_prepare_forced_close(newsk);

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 9e9155b1b3aa..ecb0b405703c 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c

[ ... ]

> @@ -1547,6 +1552,8 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
>  exit:
>  	tcp_listendrop(sk);
>  	return NULL;
> +send_reset_and_exit:
> +	tcp_v6_send_reset(sk, skb, SK_RST_REASON_TCP_STATE);
>  put_and_exit:
>  	inet_csk_prepare_forced_close(newsk);
>  	tcp_done(newsk);

Both questions above apply here too: tcp_v6_send_reset() calls
tcp_ao_prepare_reset() with the same closed listener, and
tcp_fastopen_create_child() reaches tcp_v6_syn_recv_sock() through
icsk_af_ops->syn_recv_sock() as well.
-- 
pw-bot: cr
