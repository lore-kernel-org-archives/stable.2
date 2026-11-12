Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510335;
	b=DTaOfmODgHd4dbHQcfDTFo02J232/rXJ+qjHPTHaUUbrQ+0bXZpNftTaOS7MVzHjMnDW
	 J3Qm/ZMj7ylWhPQmT3461Nihxzn8QaqbVH8Gxqttpa682yI2h+AWJQo+rbx2qkiYUgRRA
	 ez6uzdOFn5aayF9eMTqmtZGgKlhAjwj0++SkKevEDsQVBtR5/H+hEpW8KeY6n1Zz6kH6/
	 ZDQxISqhkUwN3aaDlO6E/gH7RFwpY7JUDYET/761CIST0nmsuY0erwjgFpUdgEhj3D9Bp
	 No2X5kEtYpAQBZH1cMY9yuqJvRXeQplS6/Z2c6Rm0ZJUSS7LmLYQYFAgYt2nqNKcMwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510335;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IkoHKBcs8DdRKlBWjKbq/H9anim+FdWZe45kyXWCaEE=;
	b=NGgx2dWfqNSE5SR0VS0qQE72ulLtFWdQ3DwJyGCz25nWUVGTt252godl4dJlb/QaVRMb
	 HTLXOBFLMBG6YgzMCRBqgz/4izB3p36xLTlqmulezxUQ4FSCpuvx2Koy1dqzS6DMRcmPU
	 uyy4sZU/K2wuvQNB4ODQ5WY0yCF/uVPgpyUrh2dQg3qShks4G1ndeKZZN6UnXzKKq9jOG
	 5vjzjJJ2ItJIpyBGQveOTwdI+UJKhD/2TxBS0hrdLJnMYPxbcYcbOUSYUBjarBcJzmZ2i
	 84hbzg2AQGYVKXQmoT+zEctgN8T5y7gidN6T6i0lgRFydyRRa8BhnRjUBzWQXfIItow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=npcAVEsb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DA6606A32E;
	Thu, 12 Nov 2026 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=npcAVEsb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED52B1F000C4;
	Thu, 12 Nov 2026 19:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510334;
	bh=IkoHKBcs8DdRKlBWjKbq/H9anim+FdWZe45kyXWCaEE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=npcAVEsbt+MvXyBnqd/mZxOAE0GgevXo1brlm9pT0+D6oJS88wlKMSB4QbsLeY6Wv
	 2nCo1Zig6QLNjRARHHNXFQ+SS6KVzKv93AX21E2117TWOXtBWFMlcMZN4rYOOBYKUx
	 MV3WrEs2FatSumiWxpmwxUpWXJoQTb3IHihJx0BrzVmQv5ZX/ddNo4BRuFv3kIQkM3
	 ROEB8lGttz3gMBPJiKwbCcRF+ptggQ14v00rMleFS0DsJ0W42IkHr1uP2+EBgQuNfz
	 9Kv9kr38/jt/9gPj9X9dAWHTOPyNdsGGzXVnQkQaxwnIXAS2bVdQiE7feBd+kUaHL+
	 9Cz5/Y49uqbJA==
Subject: Re: [PATCH net v3] tcp: fix device binding after failed IPv6 connect
From: netdev-bot+sashiko@kernel.org
To: yanxia@cmss.chinamobile.com
Cc: netdev@vger.kernel.org, edumazet@kernel.org, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, yana06070@163.com, netdev-bot+sashiko@kernel.org,
 jiayuan.chen@linux.dev
Date: Thu, 12 Nov 2026 19:05:33 +0000
Message-ID: <179451033353.2199510.15626724662436845169@kernel.org>
In-Reply-To: <20261111113455.284747-1-yanxia@cmss.chinamobile.com>
References: <20261111113455.284747-1-yanxia@cmss.chinamobile.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix only covers errors that tcp_v6_connect() returns
  synchronously.
- [Low] In the late_failure path of tcp_v6_connect()
  (net/ipv6/tcp_ipv6.c:356-359), the patch now restores sk_bound_dev_if…

--

tcp: fix device binding after failed IPv6 connect

This patch saves sk_bound_dev_if when tcp_v6_connect() starts and restores
it on native IPv6 error returns. The goal is that a scope-id binding left
by a failed link-local connect does not affect a later connect on the same
socket. In late_failure the restore happens before tcp_set_state(TCP_CLOSE)
and inet_bhash2_reset_saddr(), and IPv4-mapped errors keep their existing
cleanup path.

Link: https://lore.kernel.org/netdev/062d02ca-e9e1-4f4e-ac57-0de27272a205@linux.dev/
Link: https://lore.kernel.org/netdev/20261110100224.57cbf548@kernel.org/

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index b1dec5d86d633..641b74aaf1963 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -134,6 +134,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
>  			  int addr_len)
>  {
>  	struct sockaddr_in6 *usin = (struct sockaddr_in6 *) uaddr;
> +	int old_bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
>  	struct inet_connection_sock *icsk = inet_csk(sk);

[ ... ]

> @@ -197,7 +198,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
>  			if (!sk_dev_equal_l3scope(sk, usin->sin6_scope_id))
>  				return -EINVAL;
>  
> -			sk->sk_bound_dev_if = usin->sin6_scope_id;
> +			WRITE_ONCE(sk->sk_bound_dev_if, usin->sin6_scope_id);
>  		}

[Severity: High]
The binding is now restored when tcp_v6_connect() fails synchronously.
What happens when tcp_v6_connect() returns 0 and the handshake fails
afterwards?

If tcp_connect() sends the SYN, the scope id written here stays in
sk_bound_dev_if. Some ways the handshake can still fail:

  - a blocking connect() gets an RST, an ICMP unreachable or a SYN
    timeout
  - a non-blocking connect returns EINPROGRESS and fails later

Either way the socket ends up in __inet_stream_connect():

net/ipv4/af_inet.c:__inet_stream_connect() {
    ...
sock_error:
	err = sock_error(sk) ? : -ECONNABORTED;
	sock->state = SS_UNCONNECTED;
	sk->sk_disconnects++;
	if (sk->sk_prot->disconnect(sk, flags))
    ...
}

tcp_disconnect() never touches sk_bound_dev_if, and the socket can then
be connected again.

Would a retry to ::1 on the same socket then skip the link-local branch?
It would use fl6->flowi6_oif = sk->sk_bound_dev_if, which is the old
interface, and could fail with ENETUNREACH. That is the symptom the
commit message describes.

The VRF case looks reachable too. Take a socket bound to [::]:P with no
device. It connects to fe80::x%vrf_slave, the connect fails
asynchronously, and tcp_disconnect() then runs with the stale binding
still set:

net/ipv4/tcp.c:tcp_disconnect() {
    ...
	inet->inet_dport = 0;

	inet_bhash2_reset_saddr(sk);
    ...
}

__inet_bhash2_update_saddr() would look up (any, P, VRF), find nothing,
and create a new tb2 under the existing tb, whose l3mdev is 0.

A later listen() reaches inet_csk_get_port(). There, l3mdev is computed
from the stale binding, the existing tb does not match, and this fires:

	WARN_ON(inet_csk(sk)->icsk_bind_hash != tb);

The commit message says the VRF cleanup tests no longer show this
warning.

For comparison, UDP covers both paths:

  - ip6_datagram_connect() restores old_bound_dev_if on error
  - __udp_disconnect() does WRITE_ONCE(sk->sk_bound_dev_if, 0)

The commit message only excludes "Deferred Fast Open failures after
connect() returns success". Should ordinary handshake failures
(ECONNREFUSED, ETIMEDOUT, EHOSTUNREACH) be covered as well? One option is
a restore at disconnect time that records whether the binding was
implicit.

[ ... ]

> @@ -353,9 +354,14 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
>  	return 0;
>  
>  late_failure:
> +	WRITE_ONCE(sk->sk_bound_dev_if, old_bound_dev_if);
>  	tcp_set_state(sk, TCP_CLOSE);
>  	inet_bhash2_reset_saddr(sk);

[Severity: Low]
When the binding is restored here, the socket is still in ehash.

inet6_hash_connect() has already hashed it, and its 4-tuple uniqueness
check was done against the scope device. The socket is only unhashed
later, inside tcp_set_state(TCP_CLOSE), after the BPF STATE_CB and
bpf_tcp_ops_call(set_state) have run.

Lockless RX lookup reads the binding through inet6_match():

	return inet_sk_bound_dev_eq(net, READ_ONCE(sk->sk_bound_dev_if), dif,
				    sdif);

and inet_bound_dev_eq() does:

	if (!bound_dev_if)
		return !sdif || l3mdev_accept;
	return bound_dev_if == dif || bound_dev_if == sdif;

In this window, can the hashed socket match the same link-local 4-tuple
arriving on a different interface? With an old binding of 0 that would be
any non-VRF device. With an old binding of the VRF master it would be any
slave of that VRF.

Errors that reach late_failure after hashing include:

  - -EKEYREJECTED from tcp_connect() with TCP-AO
  - -EHOSTUNREACH
  - -ENOBUFS
  - -ECONNREFUSED

Such packets would go to the backlog of the closing socket and then be
discarded by tcp_rcv_state_process() in TCP_CLOSE. A different connection
using the same link-local 4-tuple on another link could therefore lose
segments, though retransmission should recover them. Before this patch
the binding stayed on the scope device until after unhash.

Could the binding be restored after the socket is unhashed but before
inet_bhash2_reset_saddr()? That would need to fit with the intent that a
binding set by the CLOSE callback takes priority.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111113455.284747-1-yanxia%40cmss.chinamobile.com
