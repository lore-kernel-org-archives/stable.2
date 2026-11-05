Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871541;
	b=lvyKUhfjme2SdXzaGKck2rDHgtLsu4iI4GdvLg8aRpdodDyo++xerz7/LNEK+XJVdQXj
	 U0dzAjxyjNseNALcSzfgqa7GORYg1gwhSbB2MC1SO+5uDtITYRHmZsw8JJwoSVMZpEPRQ
	 C8bC8/hrV/whzHOi4TGDEtdfj+RgpKEGPFrcJsQrpVhztLsYacOUkBV14+4ctTjeGB0V6
	 bjkhxauKyzghIlDZyp4c6a3dwYMYVSQkKOpTfVsGZvVBjs6wLxgPSR9PlLxNn4BXK8oJX
	 RC1F596EBKCnvH6jBJB3bpLTSjrAcxN7luYXv+u/isCRMqp0VV7km8mZs3banaduQ/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871541;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KK6onKCfxr7bkL9HSFeq+KJ2AjJsxiy091lScR+TtCc=;
	b=Xci2kmZg8Rjzpv/PTkpLrSbIDgPa4/34o1tntmrFVbB6JbK6FAR/OruH25b0BJstRMsl
	 ZJabS/gx8hbVoSKhiu6MiBwkMqGIy9PP4dWvfimP7OA/x5QxxdFLklVzxf+G0/0ZzwY+O
	 npelzJqB9lHt312LQJhXx7Z10sfS2PgXhKgh5S0gKhN//URtxcDNzv2YxAs5EpWb0/6FO
	 ttyBtimLoVep2MFZmODZDNR+fcXtTYq7cSrQXus3EwdWdVx/pwjwts2nOisetsHDHPZiP
	 LhR5nat/DdpRl69s+C3VhIL2Rcjdb8K7kMeAesqgYDUtxEGqjvv48gVnHQTak7xIzjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bB6H5JNA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B19C606A326;
	Thu,  5 Nov 2026 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bB6H5JNA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2AD1F000C1;
	Thu,  5 Nov 2026 09:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793871541;
	bh=KK6onKCfxr7bkL9HSFeq+KJ2AjJsxiy091lScR+TtCc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bB6H5JNABr9jnK6w08hihsO+R+hTcyz8vFo42mAo8EIKyVyrDIIi1j5H8b3/O3PQD
	 lTStYvLKHw6eM3uV4EK+f3kHzQ2XeShEQLRrmP5loxqVnK8pjB7OwjVpsHCzAR6V4b
	 iZq3y6mOaBS3tuTOuXQ6CwTt1uhHo+0VizwNbR0cMKgY//Oz8i/xOzrLiv0IZ59VnP
	 LCuxTOlO/mNOAzgdtuTwNqxOLBmEj8k+RcE8MCmCixG8zmujnVF/bZqi2pknGc4i0a
	 WozQmp7rHqq6rzDbvV7UoLhhB3+hy5fThx8oSMCbxXx9+gfPj2nc3z0ZQF1ZTf9g5q
	 EKTmJm8nMTGHw==
Subject: Re: [PATCH net v2 1/2] ipv6: fix cached route reuse for SO_MARK
 control messages
From: netdev-bot+sashiko@kernel.org
To: yanxia@cmss.chinamobile.com
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, willemdebruijn.kernel@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, yana06070@163.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, willemb@google.com
Date: Thu, 05 Nov 2026 09:38:59 +0000
Message-ID: <179387153949.488856.16266299848614841295@kernel.org>
In-Reply-To: <20261104092240.15649-1-yanxia@cmss.chinamobile.com>
References: <20261104092240.15649-1-yanxia@cmss.chinamobile.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.

--

ipv6: fix cached route reuse for SO_MARK control messages

This patch adds a mark_set flag to struct ipcm6_cookie. The flag is set
when an SO_MARK control message is supplied. When it is set,
udpv6_sendmsg() and ping_v6_sendmsg() call ip6_dst_lookup_flow()
directly instead of ip6_sk_dst_lookup_flow(), so a route cached for the
socket mark is not reused for a different per-message mark.

> diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> index ff7a7ffbf9833..f3f3d0254e419 100644
> --- a/net/ipv6/datagram.c
> +++ b/net/ipv6/datagram.c
> @@ -823,6 +823,8 @@ int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
>  			err = __sock_cmsg_send(sk, cmsg, &ipc6->sockc);
>  			if (err)
>  				return err;
> +			if (cmsg->cmsg_type == SO_MARK)
> +				ipc6->mark_set = true;
>  			continue;
>  		}
>  
> diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
> index 6e90d0bf9f3da..e1676de75ae99 100644
> --- a/net/ipv6/ping.c
> +++ b/net/ipv6/ping.c
> @@ -148,7 +148,10 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  
>  	fl6.flowlabel = ip6_make_flowinfo(ipc6.tclass, fl6.flowlabel);
>  
> -	dst = ip6_sk_dst_lookup_flow(sk, &fl6, daddr, false);
> +	if (ipc6.mark_set)
> +		dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl6, daddr);
> +	else
> +		dst = ip6_sk_dst_lookup_flow(sk, &fl6, daddr, false);
>  	if (IS_ERR(dst))
>  		return PTR_ERR(dst);
>  	rt = dst_rt6_info(dst);
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 59f9872c35521..35f7b0a47f7dd 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1693,7 +1693,10 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  
>  	fl6->flowlabel = ip6_make_flowinfo(ipc6.tclass, fl6->flowlabel);
>  
> -	dst = ip6_sk_dst_lookup_flow(sk, fl6, final_p, connected);
> +	if (ipc6.mark_set)
> +		dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
> +	else
> +		dst = ip6_sk_dst_lookup_flow(sk, fl6, final_p, connected);

[Severity: High]

Does this fix all reuse of a stale cached route, or only the SO_MARK
case? The commit message gives the root cause as ip6_sk_dst_lookup_flow()
consulting the socket dst cache even when connected is false. Only
mark_set bypasses the cache here, though.

ip6_sk_dst_check() validates only daddr, saddr (and only with
CONFIG_IPV6_SUBTREES) and oif:

net/ipv6/ip6_output.c:ip6_sk_dst_check() {
    ...
	if (ip6_rt_check(&rt->rt6i_dst, &fl6->daddr,
			 np->daddr_cache ? &sk->sk_v6_daddr : NULL) ||
#ifdef CONFIG_IPV6_SUBTREES
	    ip6_rt_check(&rt->rt6i_src, &fl6->saddr,
			 np->saddr_cache ? &np->saddr : NULL) ||
#endif
	   (fl6->flowi6_oif && fl6->flowi6_oif != dst_dev(dst)->ifindex)) {
    ...
}

The comment above that check says source and TOS routing are not
supported. That no longer seems accurate.

fib6_rule_match() also matches DSCP, flowlabel and sport/dport.
Several other per-message keys appear to still get the route cached at
connect() time:

  - an IPV6_TCLASS cmsg sets ipc6->tclass, which is folded into
    fl6->flowlabel just before the lookup
  - an IPV6_FLOWINFO cmsg, or sin6_flowinfo with SNDFLOW set
  - IPV6_PKTINFO with a different source address, when
    CONFIG_IPV6_SUBTREES is off
  - sendto() to the connected address with a different sin6_port

For the sendto() case, udpv6_sendmsg() points daddr at sk_v6_daddr, so
the daddr_cache check passes even though fl6_dport differs:

	if (sk->sk_state == TCP_ESTABLISHED &&
	    ipv6_addr_equal(daddr, &sk->sk_v6_daddr))
		daddr = &sk->sk_v6_daddr;

Here is one example: connect() a UDP socket, then call sendmsg() with no
msg_name and an IPV6_TCLASS cmsg of 0x10.

mark_set stays false, so
ip6_sk_dst_lookup_flow()->sk_dst_check() returns the cached dst. The
packet is sent on that route instead of hitting a dsfield prohibit rule
that would return -EACCES. ping_v6_sendmsg() behaves the same way with
an IPV6_TCLASS cmsg.

None of these paths need CAP_NET_RAW or CAP_NET_ADMIN, which the
SO_MARK cmsg does need.

The socket-level IPV6_TCLASS option already calls sk_dst_reset() in
do_ipv6_setsockopt(), so tclass is already treated as a cache key
there.

For comparison, the IPv4 udp_sendmsg() clears connected for any cmsg.
It calls sk_dst_check() only when connected is still set:

		if (err > 0) {
			err = ip_cmsg_send(sk, msg, &ipc,
					   sk->sk_family == AF_INET6);
			connected = 0;
		}
	...
	if (connected)
		rt = dst_rtable(sk_dst_check(sk, 0));

Would it be better for udpv6_sendmsg() to skip the cache whenever
connected is false, with a matching condition in ping_v6_sendmsg(),
instead of adding a flag just for SO_MARK?

>  	if (IS_ERR(dst)) {
>  		err = PTR_ERR(dst);
>  		dst = NULL;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104092240.15649-1-yanxia%40cmss.chinamobile.com
