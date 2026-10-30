Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400025;
	b=xHvUzibcf3Jw2KdyxoEwEB/9oD+k3ausFbCcqbZ765dxP6dkT7bsND2zFGz+D/ojwx5C
	 D68QZfTyqzlpMeFvyzHSeJ3IiH5cI+qvJC10hIxXcUA0ttY6/I+zWVKp/vCOdIdwK+zVC
	 GGxhwe8XSfPV35ueEelsfldH7g5rzYLkRX5ngmflwqp9UjQiFr2cB9anf/TM3cxklVA/C
	 BZvKMnGZtxMDg5+8kdB08Mzq0ISalZn32FwErc0R2xVDt14Hs+wLZibks7XeftszkkU28
	 EmkCJ+rjxs8Fh+OAELqD0ElaBYSK1iRal5VpAgSWef+hmem8spK5xlSWwd/nBZUTaSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400025;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pKaXAD++xzCTb9YAmzxK6XCkM1LAwdtdAL8cl3z8d/E=;
	b=F+nbgLmr874VRP/Qkgt4a7KGYgu89OO1ytrnABPmGN2d8mwRKP0nOuZ6VRokJmSlnap1
	 g1Wr6F3d0RoYupNwbmXMHohqWdEfCpO5URds1mQeX5Zrk3RyoMW1gy8IYX/yiSyWC1+t8
	 9MoN1QbGgK5PC+g9D6h32cwcNtrVNxUemqXa2+MHAEcpKx4bO4Wyae/Y5oNJSczFEWMCX
	 WMxD5amEEMDinqsw70b8SbsmXQmnhcV26JgUoL2Abok9drRufSWmRgh17g4h/d+F6s6Di
	 +jdsg+OC7wgOZIg7Blvq/ofwSfMQ38C58t2k9dCeHWbyuRJ+JfPqU4LEtQkD1ll91UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7RjqwR1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25915606A31A;
	Fri, 30 Oct 2026 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7RjqwR1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAE01F00A17;
	Fri, 30 Oct 2026 22:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793400024;
	bh=pKaXAD++xzCTb9YAmzxK6XCkM1LAwdtdAL8cl3z8d/E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U7RjqwR1CCYKpI3YLKiGdzMbMplGHQR6AzHAljoDcgO1qr4m2jtLoQB8sIn007k9D
	 7ZwJUxKa27N9A7MSEVhk+4AWJvXrmm8ZXsw+rhwfeYBtOgjOA0Nf0t10irrnjonjp0
	 lTh9pHEShngtoOkVUe9uBp+ZQmzaywEnOgnp9PFa5uQxBUUw/fZJQOsBHeXwhKdUZl
	 WENVWioWxHZuz7tgv6vmptqPNl9xdsTTK0LOc7TnJLdjGkl377ZZfC7UKbL5avVjIJ
	 eV9IDyudNPp3FKnjnoXMdm56puymFl9SVH018aSUpVM5ZNUmRklbvhrD8FjUGXxcTU
	 XX/pa/ZrQ/HYw==
Subject: Re: [PATCH net] l2tp: fix use-after-free in l2tp_udp_encap_recv()
From: netdev-bot+sashiko@kernel.org
To: xiaolinkui@126.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, gnault@redhat.com, kuniyu@google.com,
 michael.bommarito@gmail.com, alice.kernel@fastmail.im, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn, stable@vger.kernel.org
Date: Fri, 30 Oct 2026 22:40:23 +0000
Message-ID: <179340002340.3131.5823454250644987437@kernel.org>
In-Reply-To: <20261027063657.1359170-1-xiaolinkui@126.com>
References: <20261027063657.1359170-1-xiaolinkui@126.com>
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

- [Medium] The commit message describes a use-after-free that no code
  path in the current tree can trigger.

--

l2tp: fix use-after-free in l2tp_udp_encap_recv()

This patch reorders the error paths in l2tp_udp_encap_recv() so that
tunnel->stats.rx_invalid is incremented before the session reference is
dropped. The commit message says the old order could write into a freed
tunnel when packets are processed from the socket backlog, and the patch
is tagged for stable.

> The frees are RCU deferred, which hides the bug on the regular path
> because __udp4_lib_rcv() holds rcu_read_lock().  It does not hide it on
> the backlog path: __release_sock() drops sk_lock before invoking
> sk_backlog_rcv(), takes no RCU read lock and may cond_resched() between
> packets, so a grace period can complete before the statistics update.

[ ... ]

> Found by inspection; no reproducer.  Hitting the window needs a session
> teardown racing a packet on the backlog path, and the RCU deferred frees
> mean KASAN is only likely to report it with CONFIG_RCU_STRICT_GRACE_PERIOD.

[Severity: Medium]
Can the backlog path described here actually be reached?

Only one sk_backlog_rcv callback calls l2tp_udp_encap_recv(), and that is
pppol2tp_backlog_recv() in net/l2tp/l2tp_ppp.c:

static int pppol2tp_backlog_recv(struct sock *sk, struct sk_buff *skb)
{
	int rc;

	rc = l2tp_udp_encap_recv(sk, skb);
	...
}

pppol2tp_create() installs it:

	sk->sk_backlog_rcv = pppol2tp_backlog_recv;

Nothing seems to queue skbs on a PPPoL2TP socket's backlog, though.
sk_add_backlog() is called only from __sk_receive_skb(), tcp, sctp, tipc
and x25.

The callers of __sk_receive_skb() are pppoe, pptp, l2tp_ip, l2tp_ip6,
phonet and vmci. Each of them targets its own sockets, never a
PF_PPPOX / PX_PROTO_OL2TP one.

The live entry point is the UDP encap hook set up in
l2tp_tunnel_register():

	.encap_rcv = l2tp_udp_encap_recv,

That hook is called only from udp_queue_rcv_one_skb() and
udpv6_queue_rcv_one_skb(). Both run under the rcu_read_lock() taken in
ip_local_deliver_finish() and ip6_input(). NF_QUEUE reinjection runs
okfn with BH disabled, which also counts as an RCU read-side section.

The free path is:

l2tp_session_put()->l2tp_session_free()->l2tp_tunnel_put()
  ->l2tp_tunnel_free()->kfree_rcu(tunnel, rcu)

So with the old ordering, a final put could only queue the free. The
tunnel memory would stay valid until the reader leaves the RCU section.

For the same reason, can CONFIG_RCU_STRICT_GRACE_PERIOD expose this? A
strict grace period still cannot end while the receive path holds
rcu_read_lock() or has BH disabled.

The reordering itself looks correct as hardening. Would it be more
accurate to describe it that way, and to drop or justify the
Cc: stable tag, rather than present it as a reachable use-after-free?

Also, pppol2tp_backlog_recv() appears to be unreachable, and it passes a
PPPoX sk to a function that expects a UDP tunnel socket. Could it be
removed as part of a respin?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027063657.1359170-1-xiaolinkui%40126.com
