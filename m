Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521819;
	b=nd5naNIh39NyYra7GX2YSLk9bS06wgrAZbWDewvb25D5hWKk2o0IXildv0tlYvXxJyxs
	 dY+qG47243q9pNP4WuAC3zAzyESYzZRcZcuuaz/su/hvrB+iRDCI96/IJ6otlseeVzWLi
	 I73ceM112OFAGX75wjMkNfWF93moW9Db5iyN7Ot6zFkMn2YkFWSXFN1erDwVzNBHkC6QU
	 txVUYpLVylR/cflp7aaISZ6nZlhXAKP/KIZO559OU4LmgtYAEKp1sTcCjTWT80Aqu7+a2
	 ERjKliukUgTAW/L95/HYH/Dmq0P8jmjQdqsi0GfckuayjPVoMCUBmGuq9ye+VvRh5WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521819;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sq0GUY/ITn4SQxq/x1kkdeNsQ++qEz4hJvkAkG/WKPU=;
	b=uHySY9f7c0etHafltNseKZlPF888D5bbSOWQMugeBb16Qv+APIX/6VviQVk3GYo86P0h
	 r+e1uW9ddm7mNBpVrR/gCUwQsdCWcJC2fva8B/w7k7uw9DAa1Ep34y/tIMvQf0Afg7V6l
	 vqpQDcJpG461EhgPHS5Y7GP5u6dsRql4PzDRNkLhSkOOTEKsUTwtFb1czFkfWUTSdI3iZ
	 MKGdIgENs56E1pHHNhsAdnknArKT23XPMfxFdmE1Hx5uvrurfzTQgLZzNMpQXloml+lrq
	 xPUSl2Kr6o4AUE4lVWJl0/fz0qE4MX+IPyrsrLQU9B5YNNe4ftP8sHsiCm8Q/jaJSKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elw9lDlb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10EB606A325;
	Sun,  1 Nov 2026 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elw9lDlb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0EF1F000C1;
	Sun,  1 Nov 2026 08:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793521818;
	bh=sq0GUY/ITn4SQxq/x1kkdeNsQ++qEz4hJvkAkG/WKPU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=elw9lDlbOmEjCZYozD36NQhOlOae9eklhjYFasrHzcrnyMhvUeziCy9CqIujQUs9L
	 S/ghqD5Xzq8eNRw0xtinzVYmLJjdMFZ/YQUM/ussoNwGcWwhLKCu1t1hW0hn/2mzV6
	 8pN6cyK1an3Z8Hk7WKPcmHk3Kxxs5uYFIJJWJ+tvek1iWQbhpZFIexG2inf4a2Xtkk
	 zF2zyPQVSiqskfauYkImEhxKQ9OYW+9oqm03GqLtGDuwaRL4SvHnGmbHadOYgOTMek
	 d/13500EnpMa5lLKcX67IdPZZhohnjMmugmsuwmcDAhrivBVuKFOgLOFX+LzawLDo9
	 hp8c26JManPzw==
Subject: Re: [PATCH net] tcp: fix device binding after failed IPv6 connect
From: netdev-bot+sashiko@kernel.org
To: yanxia@cmss.chinamobile.com
Cc: netdev@vger.kernel.org, edumazet@kernel.org, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, yana06070@163.com
Date: Sun, 01 Nov 2026 08:30:17 +0000
Message-ID: <179352181715.3131.4301656429935322614@kernel.org>
In-Reply-To: <20261031074654.73952-1-yanxia@cmss.chinamobile.com>
References: <20261031074654.73952-1-yanxia@cmss.chinamobile.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [High] tcp: restore sk_bound_dev_if before inet_bhash2_reset_saddr() in
  tcp_v6_connect()
- [Low] The restore at the `failure:` label is unconditional.

--

tcp: fix device binding after failed IPv6 connect

This patch saves sk_bound_dev_if when tcp_v6_connect() is entered and
restores it at the failure label. The goal is that a binding taken from
sin6_scope_id for a link-local destination does not stay on the socket
after a failed connect, so a later connect() to ::1 on the same socket
can succeed.

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index e006a30360eae..7bb8266d9d1b7 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -146,6 +146,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
>  	struct flowi6 *fl6;
>  	int addr_type;
>  	int err;
> +	int old_bound_dev_if = READ_ONCE(sk->sk_bound_dev_if);
>  
>  	if (addr_len < SIN6_LEN_RFC2133)
>  		return -EINVAL;

[ ... ]

> @@ -358,6 +359,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
>  failure:
>  	inet->inet_dport = 0;
>  	sk->sk_route_caps = 0;
> +	WRITE_ONCE(sk->sk_bound_dev_if, old_bound_dev_if);
>  	return err;
>  }

[Severity: High]
Is the restore placed too late for the late_failure path?

When inet6_hash_connect(), tcp_fastopen_defer_connect() or
tcp_connect() fails, the code jumps to late_failure. That label calls
tcp_set_state(sk, TCP_CLOSE) and then inet_bhash2_reset_saddr(sk),
and only after that falls through to failure. Both calls therefore
run while sk_bound_dev_if still holds the sin6_scope_id value.
old_bound_dev_if is written back only at the end.

inet_bhash2_reset_saddr() calls __inet_bhash2_update_saddr(). That
function computes l3mdev with inet_sk_bound_l3mdev(sk), which reads
sk_bound_dev_if. It then passes that l3mdev to
inet_bind2_bucket_find() for the wildcard address, and calls
inet_bind2_bucket_init() if nothing matches.

Consider a socket bound to [::]:port with no device, so tb->l3mdev
and tb2->l3mdev are 0. It then connects to a link-local address
whose sin6_scope_id names a VRF slave, with tcp_l3mdev_accept=0.
sk_dev_equal_l3scope() passes because sk_bound_dev_if is 0, and the
scope_id is installed.

If the connect then fails after inet_bhash2_update_saddr(), the
reset rehashes the socket into a bind2 bucket keyed on the VRF
master's l3mdev. The failure label then puts sk_bound_dev_if back to
0. The socket is left with an icsk_bind2_hash whose l3mdev disagrees
with both icsk_bind_hash and its own restored binding.

A later listen() looks up tb2 with the restored l3mdev in
inet_csk_get_port() and hits
WARN_ON(inet_csk(sk)->icsk_bind2_hash != tb2).

If another socket shares the port, things get worse. The reset can
create a duplicate wildcard bucket, or link this socket into another
VRF socket's bucket. In the second case, closing the sockets in the
wrong order can destroy the wrong inet_bind_bucket. The VRF tb is
then leaked with an empty bhash2 list, which later trips
WARN_ON(hlist_empty(&tb->bhash2)) in __inet_hash_connect().

Before this patch the binding simply stayed in place. Later bhash2
lookups then at least used the same l3mdev that the reset used. The
mismatch between the restored binding and icsk_bind2_hash is new
with this change.

A smaller side effect is that tcp_set_state(sk, TCP_CLOSE) runs the
BPF_SOCK_OPS_STATE_CB and bpf_tcp_ops state callbacks while the
failed scope_id binding is still visible.

Should sk_bound_dev_if be restored at the top of late_failure,
before tcp_set_state() and inet_bhash2_reset_saddr()? Or is there a
reason the reset is expected to use the connect-time binding?

[Severity: High]

Does this handle a connect() that fails after tcp_v6_connect() has
already returned 0?

The restore only runs when tcp_v6_connect() itself returns an error.
After tcp_connect() queues the SYN, the function returns early:

	err = tcp_connect(sk);
	if (err)
		goto late_failure;

	return 0;

Suppose the peer sends RST, the SYN times out, or an ICMPv6 error
arrives. Then __inet_stream_connect() sees TCP_CLOSE and takes the
sock_error path:

net/ipv4/af_inet.c:__inet_stream_connect() {
    ...
sock_error:
	err = sock_error(sk) ? : -ECONNABORTED;
	sock->state = SS_UNCONNECTED;
	sk->sk_disconnects++;
	if (sk->sk_prot->disconnect(sk, flags))
		sock->state = SS_DISCONNECTING;
    ...
}

tcp_disconnect() undoes the auto-assigned source address with
inet_bhash2_reset_saddr() and drops the dst with __sk_dst_reset(). It
never touches sk_bound_dev_if, so the socket stays bound to the
interface taken from sin6_scope_id.

On a retry connect() to ::1, sk->sk_bound_dev_if is copied into
fl6->flowi6_oif. ip6_route_output_flags_noref() then adds
RT6_LOOKUP_F_IFACE:

	if ((sk && sk->sk_bound_dev_if) || rt6_need_strict(&fl6->daddr) ||
	    (fl6->flowi6_oif && any_src))
		flags |= RT6_LOOKUP_F_IFACE;

The lookup then fails with ENETUNREACH, which is the symptom the commit
message describes. A successful link-local connect followed by
connect(AF_UNSPEC) ends up the same way.

An unprivileged user cannot clear the stale binding either.
sock_bindtoindex_locked() returns -EPERM when sk_bound_dev_if is already
set and the caller lacks CAP_NET_RAW.

So with this patch, the implicit binding is undone after a synchronous
failure (route lookup) but kept after an asynchronous one (RST, timeout,
ICMP). Would it make sense to also undo the scope_id binding on the
disconnect path, or to track it so it can be undone there?

[Severity: Low]

Could this write-back clobber a binding that was set after the snapshot
was taken?

The restore is unconditional. It runs even when the sin6_scope_id
branch never changed sk_bound_dev_if. tcp_connect() runs the BPF
connect hooks before several of its error returns:

net/ipv4/tcp_output.c:tcp_connect() {
    ...
	tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_CONNECT_CB);
	bpf_tcp_ops_call(connect, sk);
    ...
			return -EKEYREJECTED;
    ...
	if (inet_csk(sk)->icsk_af_ops->rebuild_header(sk))
		return -EHOSTUNREACH; /* Routing failure or similar. */
    ...
	if (unlikely(!buff))
		return -ENOBUFS;
    ...
}

A sock_ops program can call bpf_setsockopt() with SO_BINDTODEVICE or
SO_BINDTOIFINDEX from CONNECT_CB, and sol_socket_sockopt() in
net/core/filter.c accepts both.

If tcp_connect() fails after that, the path goes late_failure ->
failure. The value saved on entry then overwrites the binding the BPF
program just installed, and no sk_dst_reset() follows. Before this
patch, that binding would have survived.

Would it be better to restore only when tcp_v6_connect() itself wrote
sin6_scope_id into sk_bound_dev_if?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261031074654.73952-1-yanxia%40cmss.chinamobile.com
