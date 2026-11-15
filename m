Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794783106;
	b=e7G7RGMlEYRNKuXKOz/SzMgVSdEuCP8UgGme8Adu+tdtSluaetURXy9Zy+lx8EzbSkmY
	 X1CxfgRYgt3TLdgRTl9YexUHRXDWtHc3fPhRjWUNP9hVY7Co9OciwvXfZCZTB3YqQY9bF
	 6Ou8RzWWmz0UBSgQ3ipQNkfCIz5JBHytnGJK9cQbh8ecxbUiaI/thDSwcDrW0u12l1V80
	 UDqjn1CE0QplsGx+HezDbDCrBRhR20RrCpW9H4ALlfJIdy1kouGWLHvG9NAm+PQacMBXv
	 ak24AW6Ni4Lie5iAx9WOwGd7ai0w2FqEMOXxtWJKIfb56vkNFtINMAreVmeeEoQ48CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794783106;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0pLj+olZoSsGogi6vlPNdxgybAe1TouvBILAaXOZkU4=;
	b=5LxwvcMWntqWakbyiLDZHK9nqxqeXi8NMhKMk9Tbprt+5f/LME2dzotYwWii0ZqUVuug
	 qw8QbPV8fjBAw/h5MIdZGfrq9JRmXV8zQ3a2T5vzxQ38atkZQD4pOt/NKjmJg2KRb20lR
	 MC8kwf70TBU/8nkF1EdmSMVMd2R0ZAZ1IHqveqCi4KnmatRmv92VPrI/HOiosuYvomJvA
	 VXtQooqPC/aA11yws6DUF7kLX4pUst/1J37JnRzZdmMR7FYQsl6mO+3NTaLGw9ryevwWE
	 o3hC84TRwX1Pli9hy6Zr65eaVvSNisXoqvUHy1/zRqXWDyWzgO+e7MIXlfl8TGypFEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="byXV765/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA492606A31F;
	Sun, 15 Nov 2026 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=byXV765/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31EE1F000C4;
	Sun, 15 Nov 2026 22:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794783106;
	bh=0pLj+olZoSsGogi6vlPNdxgybAe1TouvBILAaXOZkU4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=byXV765/qIpG5ugJXO9Hg56ukuj2ntuD1afLRTqgvNpOMVZdA7OcViBHPRNTozoBJ
	 ffH18wRor9fbGwdjKdR2w5grpsmk6dFWFhin9ky8GmPheSvSna8qIPbX74Ul6nK0BX
	 MklV8M9qwDJb3KUMW1I7QCMQNXQd4cQgyp3aCsgTWPh4qsKLsxu6zucfJmpf503Vte
	 bMJIUnPaB/UFon4LILgKkhh3Q5y+slYKVgO1MV3aSza7RlgG+7YBLVxT6rEzRIbgDt
	 A5GYL7/5vP1lm0aK15txn1tkP+ISGFpkU4rCkD97i61DwsTa+204QsvRwyePaTpIjH
	 706ImYB9G2tpg==
Subject: Re: [PATCH net v2] udp_tunnel: fix GRO callback mismatch during setup
From: netdev-bot+sashiko@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 15 Nov 2026 22:51:45 +0000
Message-ID: <179478310543.3136.4977357785981182737@kernel.org>
In-Reply-To: <20261111214622.2482547-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261111214622.2482547-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix still lets receive and completion use different tunnel
  parsers on the same packet, so the out-of-bounds write the commit…
- [Medium] udp_tunnel_gro_count only describes how the head skb of a GRO
  entry was parsed, not the packets merged into it, so packets in the…
- [Medium] The Fixes: tag blames only 5d7f5b2f6b93 ("udp_tunnel: use
  static call for GRO hooks when possible", v6.16), but part of what the…
- [Low] The new synchronize_net() in udp_tunnel_update_gro_rcv()
  (net/ipv4/udp_offload.c:139) runs with the global…

--

udp_tunnel: fix GRO callback mismatch during setup

setup_udp_tunnel_sock() now writes gro_complete first and publishes
gro_receive last with release semantics, and udp_gro_receive() reads
gro_receive once. A new per-skb udp_tunnel_gro_count in napi_gro_cb is
incremented for each tunnel gro_receive callback and consumed in
udp_gro_complete(). The static call is used only when its target matches
the socket's callback, and a grace period is waited before resetting it.

> Fixes: 5d7f5b2f6b93 ("udp_tunnel: use static call for GRO hooks when possible")

[Severity: Medium]
Is 5d7f5b2f6b93 the only commit that should be named here?

That commit added the static call machinery and udp_tunnel_gro_rcv(). It
did not touch the gro_receive/gro_complete stores in
setup_udp_tunnel_sock() or this check in udp_gro_complete():

    if (sk && udp_sk(sk)->gro_complete) {

The older mismatch goes like this. Receive treats the packet as plain UDP
and holds it through udp_gro_receive_segment(). One example is sk == NULL
because udp_encap_needed_key is not enabled yet, on a device with
NETIF_F_GRO_UDP_FWD. setup_udp_tunnel_sock() then sets gro_complete. The
unconditional lookup in udp_gro_complete() finds the socket and runs the
tunnel gro_complete on a packet that was never tunnel-parsed.

The new udp_tunnel_gro_count is what closes that case: with a count of 0
the packet goes to udp_gro_complete_segment(). The commit message only
describes the socket callbacks and the global static call disagreeing,
though.

Stable tooling relies on the Fixes: tag, so kernels without 5d7f5b2f6b93
(6.12, 6.6, 6.1, ...) would not get this fix. Could another Fixes: tag be
added for the commit that introduced socket-based UDP tunnel GRO
completion, or at least a note in the commit message?

> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index b77ae2f00c626..92c5e34bcf734 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -136,6 +136,7 @@ void udp_tunnel_update_gro_rcv(struct sock *sk, bool add)
>  		static_branch_enable(&udp_tunnel_static_call);
>  	} else if (old_gro_type_nr == 1) {
>  		static_branch_disable(&udp_tunnel_static_call);
> +		synchronize_net();
>  		static_call_update(udp_tunnel_gro_rcv, dummy_gro_rcv);
>  	}

[Severity: Low]
This synchronize_net() runs with the global udp_tunnel_gro_type_lock mutex
held. Is that a concern, given that unprivileged users can reach this
path?

udp_lib_setsockopt(UDP_ENCAP, UDP_ENCAP_ESPINUDP) on a socket with
UDP_GRO set:
    set_xfrm_gro_udp_encap_rcv()->udp_tunnel_update_gro_rcv(sk, true)

close():
    udp_destroy_sock()->udp_tunnel_cleanup_gro()
        ->udp_tunnel_update_gro_rcv(sk, false)

These callers don't hold rtnl, so synchronize_net() turns into a regular
synchronize_rcu(). An unprivileged process can keep triggering the 1->0
or 1->2 transitions, for example by alternating xfrm4/xfrm6 ESP-in-UDP
sockets.

vxlan, geneve and fou setup and teardown take the same mutex, usually
under rtnl. Would they then wait behind those grace periods and add to
rtnl latency?

[ ... ]

> @@ -847,7 +863,7 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
>  
>  	skb_gro_pull(skb, sizeof(struct udphdr)); /* pull encapsulating udp header */
>  	skb_gro_postpull_rcsum(skb, uh, sizeof(struct udphdr));
> -	pp = udp_tunnel_gro_rcv(sk, head, skb);
> +	pp = udp_tunnel_gro_rcv(gro_receive, sk, head, skb);
>  
>  out:
>  	skb_gro_flush_final(skb, pp, flush);

[Severity: Medium]
Does udp_tunnel_gro_count cover the packets merged into a held GRO entry,
or only the head skb?

Say a packet P is held before setup_udp_tunnel_sock() publishes
gro_receive. P goes through udp_gro_receive_segment() in one of two ways:

  - NETIF_F_GRO_FRAGLIST, with is_flist = 1 because the kernel tunnel
    socket lacks GRO_ENABLED
  - sk == NULL plus NETIF_F_GRO_UDP_FWD while udp_encap_needed_key is
    still off

Either way, P has udp_tunnel_gro_count == 0 and encap_mark == 0.

A packet S on the same outer flow arrives after setup and takes the
tunnel path. The loop over head above only compares the ports and
whether the checksum is zero:

    if ((*(u32 *)&uh->source != *(u32 *)&uh2->source) ||
        (!uh->check ^ !uh2->check)) {

Nothing checks whether p itself was tunnel-parsed. Then
udp_tunnel_gro_rcv()->vxlan_gro_receive()->eth/inet/tcp gro_receive walk
P at p->data + off_vx and the inner offsets. They can merge S's inner
payload into P through skb_gro_receive() or skb_gro_receive_list().

At flush, udp_gro_complete() (or the fraglist shortcut in
udp4/6_gro_complete()) looks only at P's own count of 0. It completes the
aggregate as plain SKB_GSO_UDP_L4 or fraglist. P's gso_size is the outer
UDP payload size, but the merged data has its tunnel and inner headers
stripped.

Can this corrupt segmentation and payload for packets that arrive during
the setup window?

For napi_gro_frags() style drivers, P's linear area ends at the outer UDP
payload (see gro_try_pull_from_frag0()). Would S's tunnel receive then
also read P's inner headers beyond skb_headlen(P)?

[ ... ]

> @@ -933,7 +950,12 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
>  
>  	sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
>  				udp4_lib_lookup_skb, skb, uh->source, uh->dest);
> -	if (sk && udp_sk(sk)->gro_complete) {
> +	if (NAPI_GRO_CB(skb)->udp_tunnel_gro_count) {
> +		NAPI_GRO_CB(skb)->udp_tunnel_gro_count--;
> +		if (sk)
> +			gro_complete = READ_ONCE(udp_sk(sk)->gro_complete);
> +	}
> +	if (gro_complete) {
>  		skb_shinfo(skb)->gso_type = uh->check ? SKB_GSO_UDP_TUNNEL_CSUM
>  					: SKB_GSO_UDP_TUNNEL;
>  

[Severity: High]
Does the counter actually tie completion to the gro_receive that ran at
receive time?

udp_tunnel_gro_rcv() only increments udp_tunnel_gro_count. It does not
record which callback or socket ran. Here udp_gro_complete() still does a
fresh udp4_lib_lookup_skb()/udp6_lib_lookup_skb() at flush time. Whenever
the counter is non-zero, it calls the gro_complete of whatever socket
that lookup returns.

Held GRO packets are not inside an RCU section. They can stay held across
NAPI polls when gro_flush_timeout and napi_defer_hard_irqs are set, since
napi_complete_done() only does gro_flush_normal(&n->gro, !!timeout). So
something like this looks possible:

  vxlan_gro_receive() aggregates the packet, udp_tunnel_gro_count = 1,
  and the packet is held on the NAPI GRO list

  the vxlan link is deleted:
    vxlan_sock_release()->udp_tunnel_sock_release()
    (nothing flushes the lower device's GRO lists)

  a fou/GUE port is added on the same UDP port:
    setup_udp_tunnel_sock() runs while the packet is still held

  flush:
    udp_gro_complete()->udp4_lib_lookup_skb() returns the GUE socket
    gro_complete is gue_gro_complete()

gue_gro_complete() in net/ipv4/fou_core.c then does:

    guehlen = sizeof(*guehdr) + (guehdr->hlen << 2);
    ...
    err = ops->callbacks.gro_complete(skb, nhoff + guehlen);

hlen comes from vxlan header bytes. vxlan_gro_prepare_receive() only
compared those bytes for flags and VNI, so guehlen can be up to 128
bytes. The inner inet/ipv6 gro_complete handlers then write
tot_len/payload_len/check and dispatch L4 completes at offsets that
receive never validated.

Can this still cause the slab-out-of-bounds write shown in the KASAN
report in the commit message? It needs CAP_NET_ADMIN in a netns, which
an unprivileged user can get through a user namespace with a tun
IFF_NAPI device.

The opposite case also seems possible. If the new socket has no
gro_complete, or the completion lookup returns NULL while the receive
lookup found a socket, the counter is still consumed. Then
udp_gro_complete_segment() marks a tunnel-aggregated skb as plain
SKB_GSO_UDP_L4.

One way for the two lookups to differ is the port-only fast path in
udp4_gro_lookup_skb():

    sk = udp_tunnel_sk(net, false);
    if (sk && dport == htons(sk->sk_num))
        return sk;

__udp4_lib_lookup() at completion has no such path. A VRF slave with
udp_l3mdev_accept=0 is one example.

This sequence could also happen before this patch. However, the stated
goal of the patch is to stop receive and completion from parsing one
packet differently. Would it work better to record at receive time which
callback or socket ran, or to refuse tunnel completion when they differ,
instead of counting callbacks?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111214622.2482547-2-Jeremy.Jean%40oss.cyber.gouv.fr
