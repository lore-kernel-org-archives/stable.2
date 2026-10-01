Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93E02D322E;
	Thu,  1 Oct 2026 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859315; cv=none; b=Ddvg3SDmoh3iKTHAwKA7zMeQS7y1TDXU2psuSo3c8VJo2fdvnk/wLCpNFMmqwh94oifOL6f2911j3qIfkCNdH7AhTHhyIRx7vpJyBRJRu6YG1UXconrdzsVsy+Mo1KG76+BPI6DsIbxfRf+9lgWbXQNGVli8ToriVEyj5XKM6ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859315; c=relaxed/simple;
	bh=58xgignJAc4rhG6g12SHvbHxinAj1Bb5MXzBnbYoYP4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kIeTtbWDajVU2mNcJFyeFCS98MCiqhUf9J1bxGvf+OFp99gd/pePND34yPyifaolyNUGDlpDwYneNiyNffyvNzgFZNNOfYhY5GUxUjnRPpC4fnwBfgD1IosMH8ONrOuFl1rtvDsd1AbM0MBiBB9OIDyyxuUIDFkZT2NZ+8SAQn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd6Mf6W3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd6Mf6W3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762CD1F000FF;
	Thu,  1 Oct 2026 12:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790859313;
	bh=3fgHPqf0YJKXygyHGkknczbnTpWy5xDOm1SENDpy+Ho=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Qd6Mf6W34H5RxuJxeLeoc21zMNZLNpz5PunfFUFio4C/ikbacxH0FjHNt3MkBgKBt
	 /dvvXFnKqLHQImyl5of17XsiMt+K/Q8rArgM2XzsXRYoJONlX9nI6L3K8AEASO+zeJ
	 UqFV8cYznQqwUBZWUUDxxd3hh8W8zcmvAXdpxYhhjTZp1duPe7VCtlSm379fJw8c9Y
	 2zx2YKDWRqq9EV3YWDvfv+9766vSouYr2Fd7NOE/xUkHAxgAZIGr69/SNlrtHOyGzs
	 rWERhmiYShl/D6N/p/pJCTsVH7pnmWQbu2fYx3CmTDWmWN8Y0myyAYjWYDH+9tDfUv
	 OfEQgCzCxPkdA==
Subject:
 Re: [PATCH ipsec] xfrm: espintcp: reorder operations within espintcp_init_sk
From: netdev-bot+sashiko@kernel.org
To: sd@queasysnail.net
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, stable@vger.kernel.org, yuantan098@gmail.com,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
 ronbogo@outlook.com, zylzyl2333@gmail.com, n05ec@lzu.edu.cn,
 eulgyukim@snu.ac.kr, jjy600901@snu.ac.kr, kuba@kernel.org
Date: Thu, 01 Oct 2026 12:55:11 +0000
Message-ID: <179085931198.434549.11976738723347461302@kernel.org>
In-Reply-To:
 <dcb164e6a1064fcd32c2e72fd9ee918dd1427f15.1790617484.git.sd@queasysnail.net>
References:
 <dcb164e6a1064fcd32c2e72fd9ee918dd1427f15.1790617484.git.sd@queasysnail.net>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not fully close the race it targets.

--

xfrm: espintcp: reorder operations within espintcp_init_sk

This commit reorders espintcp_init_sk() so the espintcp_ctx is fully set
up and published in icsk_ulp_data before the socket callbacks, sk_prot and
socket ops are switched to the espintcp versions. It relies on the barrier
in rcu_assign_pointer() so that callers always find a valid ctx.

Link: https://lore.kernel.org/all/c30b645074a1b379e0f7fe297f917c66137d9964.1778464688.git.zylzyl2333@gmail.com/
Link: https://lore.kernel.org/all/20260819155349.3555804-1-jjy600901@snu.ac.kr

> diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
> index 3e72b9f067b9..1087a8dd94f4 100644
> --- a/net/xfrm/espintcp.c
> +++ b/net/xfrm/espintcp.c
> @@ -466,9 +466,23 @@ static int espintcp_init_sk(struct sock *sk)

[ ... ]

> +	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
> +
> +	sk->sk_data_ready = espintcp_data_ready;
> +	sk->sk_write_space = espintcp_write_space;
> +	sk->sk_destruct = espintcp_destruct;
>  
>  	if (sk->sk_family == AF_INET) {
>  		sk->sk_prot = &espintcp_prot;

[Severity: High]
Does rcu_assign_pointer() actually order the stores that come after it?
The commit message says:

  "rely on the barrier provided by rcu_assign_pointer to ensure callers
  will have a struct espintcp_ctx available."

rcu_assign_pointer() is smp_store_release(), and a release store only
orders the accesses before it. The plain stores after it are not ordered
after the publish. These are sk_data_ready, sk_write_space, sk_destruct,
sk->sk_prot and sk->sk_socket->ops.

On arm64, POWER or RISC-V these stores can become visible before
icsk_ulp_data. On any architecture, the compiler is free to move them above
the release store.

The read side has no ordering either. espintcp_getctx() uses a plain load:

include/net/espintcp.h:espintcp_getctx() {
	/* RCU is only needed for diag */
	return (__force void *)icsk->icsk_ulp_data;
}

Readers reach this load through an indirect call after reading ops or prot
with READ_ONCE() at most. That gives only a control dependency, which does
not order one load after another.

The writer holds only the socket lock:

do_tcp_setsockopt(TCP_ULP)->sockopt_lock_sock()->tcp_set_ulp()->
    __tcp_set_ulp()->espintcp_init_sk()

Several readers never take that lock:

sock_poll()->espintcp_poll()
    return datagram_poll_queue(file, sock, wait, &ctx->ike_queue);

inet_recvmsg()->espintcp_recvmsg()
    skb = __skb_recv_datagram(sk, &ctx->ike_queue, flags, &off, &err);

inet_sendmsg()->espintcp_sendmsg(), before lock_sock():
    struct espintcp_ctx *ctx = espintcp_getctx(sk);
    struct espintcp_msg *emsg = &ctx->partial;

esp_output_tcp_finish() in net/ipv4/esp4.c (and the same code in
net/ipv6/esp6.c) checks tcp_is_ulp_esp(), which is a plain sk_prot load.
It then calls espintcp_queue_out() or espintcp_push_skb(), and both
dereference ctx.

Suppose one thread runs setsockopt(fd, SOL_TCP, TCP_ULP, "espintcp") while
another calls poll(), recvmsg() or sendmsg() on the same fd. Can the second
thread still see the espintcp ops or prot with ctx still NULL, and oops on
a near-NULL dereference? TCP_ULP needs no capability, so an unprivileged
local user can reach this. The window is narrow. On x86, if the compiler
does not reorder the stores, the new order is enough.

tls_ctx_create() in net/tls/tls_main.c uses a similar pattern, but it pairs
its sk_prot stores with WRITE_ONCE().

Would a complete fix need ordering on both sides? On the write side, that
means an smp_wmb() after publishing ctx, or WRITE_ONCE()/release stores for
the callbacks, sk_prot and ops. On the read side, it means
rcu_dereference() or an acquire load in espintcp_getctx() and
tcp_is_ulp_esp(), or NULL checks on the lockless paths. Otherwise, should
the commit message and the comment in espintcp_getctx() drop the claim
that rcu_assign_pointer() gives this guarantee?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/dcb164e6a1064fcd32c2e72fd9ee918dd1427f15.1790617484.git.sd%40queasysnail.net
