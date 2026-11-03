Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716634;
	b=LTnVSGqOmrUWvaQ/K5btBcXcrCBdKZFsW5iKi/Wl8sx4jfGU3anNwUhVFciHcr5OoAa8
	 sxAwPAR68v7Fh9iqmr1Uf49mgZvcwM+bOA5j+EiWHch20YLGkqaYNd0mh0LyAPdqLH82h
	 NyzRzrFI6+Cg+Ipgou7WWrvlGJo03RnOae2VklnxCvMCtmZNLuf67DWFjkoE/ot47xDYt
	 6VHTHE30HduWhnpW1bFiMpjK30O7urnaDPTQN7Ygb3MFS97ymOzP1l0WbNSFKYfrPoV7q
	 HtAnnIArgF/1rrIp4yeGJp/aR36ekwMPmq6Ugzi6YngOwrOQMNTzTyho1pDk5S7K20w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716634;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=q0TVcuTt7SGrb/sID1cbKwtmkXku8PrdSS6xR4gRG/M=;
	b=oGo/n54dDsr6+oLffM9wUGYP3CAVNadKNUfwmea6nV3A6clBDhPgJ/9b35ITmNpeJDjx
	 0WKFdTFQ4MtdzeqKzcDhrrv33Lgn3fv2HbRLh3LYR0ck9bLrJ7eafXUQz5nAGmjZ5tKEU
	 NhOYcDTh6ar+dBq2EA1mLde8QrTEZdGUNXwmoT4C9Baqi3qV7oaxXaCO/60aC2PsS+9z5
	 YSq0raSdv/zYNI2QJgSFFEZWmVbO0c44g74tl/YZUocG+lSbgPszJnXwsLv4IHrdttifP
	 HgmDYi8VKRzVDIpIWyNRjDC/56tg/M0zluYkVEvpNvKBDCzirBLOCngt7IOhEJkTHHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ekMoRaRj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F752606A328;
	Tue,  3 Nov 2026 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ekMoRaRj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A783F1F000C1;
	Tue,  3 Nov 2026 14:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793716633;
	bh=q0TVcuTt7SGrb/sID1cbKwtmkXku8PrdSS6xR4gRG/M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ekMoRaRjV1/HXGsMqViPRjiata/mnS8JwfH8YJGdvOjtjHqW84i19pjlayiWq5+HN
	 mVMqwnTaCzG2Q8q7pagTBsFSW5fJyJ+bCG9pqGL4TdsNwUSTvphPNCxT45hLdeXkH0
	 tZ8EY81RmGfDZMAtXrfdKtVEJbg7EYYzjPTaDnDcPImU32XjzHSMA4nmo8iAaGiJ/x
	 a9ZpxOegWyZNN1epyDe01pqxpeOwbtaAJEoG5EuZA3/ybG7W0R1GUIwl7uDx6J6yA7
	 5E9yorSMH60EkLBwE7DUn/pWY3rfKv/MsETvKemJmyZiNGZe5ClE1UPYAeTJp6gReH
	 6iPMO5EzqDWwQ==
Subject: Re: [PATCH net v2] tcp: fix device binding after failed IPv6 connect
From: netdev-bot+sashiko@kernel.org
To: yanxia@cmss.chinamobile.com
Cc: netdev@vger.kernel.org, edumazet@kernel.org, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, yana06070@163.com, netdev-bot+sashiko@kernel.org,
 jiayuan.chen@linux.dev
Date: Tue, 03 Nov 2026 14:37:12 +0000
Message-ID: <179371663219.488856.3400501885593862638@kernel.org>
In-Reply-To: <20261102143352.135769-1-yanxia@cmss.chinamobile.com>
References: <20261102143352.135769-1-yanxia@cmss.chinamobile.com>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The TCP Fast Open deferred-connect path skips the new restore.

Pre-existing issues:
- [Medium] __ip6_datagram_connect() in net/ipv6/datagram.c (UDP, raw,
  ICMPv6 ping and L2TP-over-IPv6) has the same stale-binding defect, and…
- [Low] In tcp_v6_connect(), the store that installs the scope binding at
  net/ipv6/tcp_ipv6.c:202 (`sk->sk_bound_dev_if = usin->sin6_scope_id;`)…

--

tcp: fix device binding after failed IPv6 connect

This patch saves the original sk_bound_dev_if in tcp_v6_connect(). On
synchronous failure paths it restores that value, but only if the binding
was installed from sin6_scope_id by this call. On the late_failure path
the restore happens before tcp_set_state(TCP_CLOSE) and
inet_bhash2_reset_saddr(), so the bind2 cleanup sees the original l3mdev.

Link: https://lore.kernel.org/netdev/062d02ca-e9e1-4f4e-ac57-0de27272a205@linux.dev/

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index e006a30360eae..5bd4bd49d2824 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c

[ ... ]

> @@ -198,6 +200,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
>  				return -EINVAL;
>  
>  			sk->sk_bound_dev_if = usin->sin6_scope_id;
>  			^^^^

[Severity: Low]
This isn't a bug introduced by this patch, but the store that installs the
scope binding here is a plain write. The new restores in late_failure and
failure use WRITE_ONCE().

Other code reads sk_bound_dev_if without this socket's lock. For example,
inet_bind_conflict() runs under the bhash lock:

    bound_dev_if2 = READ_ONCE(sk2->sk_bound_dev_if);

The matching store in __ip6_datagram_connect() already uses WRITE_ONCE():

    WRITE_ONCE(sk->sk_bound_dev_if, usin->sin6_scope_id);

Could this store also become WRITE_ONCE() in a respin, so that setting and
restoring the binding use the same annotation?

> +			scope_id_set = true;
>  		}
>  
>  		/* Connect to link-local address requires an interface */

[ ... ]

> @@ -353,9 +356,16 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
>  	return 0;
>  
>  late_failure:
> +	if (scope_id_set &&
> +	    READ_ONCE(sk->sk_bound_dev_if) == usin->sin6_scope_id)
> +		WRITE_ONCE(sk->sk_bound_dev_if, old_bound_dev_if);

[Severity: Medium]
Does the TCP Fast Open deferred connect path still leave the scope binding
in place?

With TCP_FASTOPEN_CONNECT set and a usable cookie, tcp_v6_connect()
returns early with the binding still installed. The cookie can come from
the cache, TFO_CLIENT_NO_COOKIE or the fastopen_no_cookie route metric:

	if (tcp_fastopen_defer_connect(sk, &err))
		return err;

old_bound_dev_if and scope_id_set are stack locals, so they are lost once
this returns.

The SYN is sent later from tcp_sendmsg_fastopen(). That function has its
own copy of this failure path, and the copy does not restore
sk_bound_dev_if:

net/ipv4/tcp.c:tcp_sendmsg_fastopen() {
    ...
	if (inet_test_bit(DEFER_CONNECT, sk)) {
		err = tcp_connect(sk);
		/* Same failure procedure as in tcp_v4/6_connect */
		if (err) {
			tcp_set_state(sk, TCP_CLOSE);
			inet->inet_dport = 0;
			sk->sk_route_caps = 0;
		}
	}
    ...
}

tcp_connect() can fail here in several ways:

  - -EHOSTUNREACH from inet6_sk_rebuild_header(), which redoes the route
    lookup with flowi6_oif = sk_bound_dev_if (for example, if the
    interface went down after connect())
  - -EKEYREJECTED on a TCP-AO/MD5 key mismatch
  - -ENOBUFS or -ECONNREFUSED

__inet_stream_connect() then sees TCP_CLOSE and takes the sock_error
path, which disconnects the socket and sets SS_UNCONNECTED.
tcp_disconnect() does not touch sk_bound_dev_if.

A later connect() to ::1 on the same socket would then use the stale scope
device as flowi6_oif and fail with ENETUNREACH. This is the symptom the
patch fixes on the non-deferred path.

An unprivileged user also cannot clear the binding by hand, because
sock_bindtoindex_locked() returns -EPERM without CAP_NET_RAW.

The two "same failure procedure" copies now behave differently. Does the
original binding need to be stored somewhere that outlives
tcp_v6_connect(), so that tcp_sendmsg_fastopen() can restore it too?

> +	scope_id_set = false;
>  	tcp_set_state(sk, TCP_CLOSE);
>  	inet_bhash2_reset_saddr(sk);
>  failure:
> +	if (scope_id_set &&
> +	    READ_ONCE(sk->sk_bound_dev_if) == usin->sin6_scope_id)
> +		WRITE_ONCE(sk->sk_bound_dev_if, old_bound_dev_if);

[Severity: Medium]
This is a pre-existing issue, but __ip6_datagram_connect() in
net/ipv6/datagram.c seems to have the same stale binding problem. That
covers UDP, raw, ICMPv6 ping and L2TP over IPv6 sockets.

It installs the binding without saving the old value, and it may also set
np->mcast_oif:

			WRITE_ONCE(sk->sk_bound_dev_if, usin->sin6_scope_id);

If the route lookup then fails, the error branch restores the peer
address, flow label and port, but not the binding:

	err = ip6_datagram_dst_update(sk, true);
	if (err) {
		/* Restore the socket peer info, to keep it consistent with
		 * the old socket state
		 */
		sk->sk_v6_daddr = old_daddr;
		np->flow_label = old_fl6_flowlabel;
		inet->inet_dport = old_dport;
		goto out;
	}

ip6_datagram_flow_key_init() later uses sk_bound_dev_if as flowi6_oif.
A following connect() to ::1 skips the scope branch, so it would fail the
same way as the TCP reproducer. Only connect(AF_UNSPEC), through
__udp_disconnect(), clears the binding.

Would a similar fix make sense for the datagram connect path?

>  	inet->inet_dport = 0;
>  	sk->sk_route_caps = 0;
>  	return err;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102143352.135769-1-yanxia%40cmss.chinamobile.com
