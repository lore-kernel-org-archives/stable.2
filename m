Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660966;
	b=VOJ7WtTej0sRT3uTzNxME0KzP/4axNrYFl6AzpCedwhqfNtYQ4zTgniAq8cQlvsb6EiV
	 EyU0JcznK7SWM25TrS9PfVuNkS6URHuqIPXqTlG5nSaKj2JPD4bndmYuX468BIcH6AjuF
	 X9BULOF39nnLUE1w0GdauDcikf3qsutGc3r7VXSxEYrKgAKCq5/FnyvpOBfyGsKe9u5SL
	 KOAcLSaj3hSpOco7Mz7x/rjpzKiVed2F/v8Ki+dvBhqpWlsfTna0CxH/5TNH4eEvdY2y/
	 Kk3D7SVtFkLNzIfLGOqYtrHqsVykSX3XRpbeeOrESo8KTMYOHQRcGU9YOcpHN/e/CMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660966;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=RfIi8e/km/yTMqBDj5BNJrvMDAONuazl+6BSjcWIbRI=;
	b=kwu2VFBy0askTt4Cufw+Gg7zaPqoQgUqCDYgCRd6iF8TpywYU25Vta8Xfv0DZgv4xR4f
	 UFfhHetsxxDOC8J910KnOWN9PjvAs/34al52nb5rBxOORbaChQri0+E9hyIhZIOLPvJGD
	 aDOaghekPl+pmrZO9MlnmQfT8AeglGyP4Z2zF9ZDBJX3xaNVCnnL2rFVr6cKcVWm1GKj1
	 dDmcLpGe2+SW7lKVtAo1H5ei+KkslzqNflMyEAAwZEkakx11mWvWU2NIrV/1nqL/lKGxD
	 R3kDA8APmH61RuODFFU3axR88HIvFastuZR+3fVhdNCKgxK0sOhaEaG2VJB5gkZ4ycQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtNk3ZMJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AB1606A324;
	Mon,  2 Nov 2026 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtNk3ZMJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9D31F00A17;
	Mon,  2 Nov 2026 23:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793660966;
	bh=RfIi8e/km/yTMqBDj5BNJrvMDAONuazl+6BSjcWIbRI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GtNk3ZMJOF9f7TWz3ZWYjuU12IriyRO0lKLjVq+cRwhGjTk0TLKG4XDs4nZRPPTEY
	 BV5rV43ArkF4rFvpQl7z4RYsdiWAZQhivmz+2uyeB0QCZXCYLE+H8MDvMBUYdjbjCW
	 ERoPFs4hOlVks3qbIR98ULsCqyhFsW/95cTytVTktghwOz8oNTxl+KRN9oEWOEoPnl
	 kFHkNMXwujVZfrsSHhhoPxMnrUGPHEebIfXJPlo1d+wQ7JOK9dir07isJ15NVDkFgO
	 pnH22AtizzXySuTRAt8LEP95DDppfGnbfAC0nlk8R5IQPrIYwoqtLqegQvCqUcmlGT
	 2Fk+puIWDrvNA==
Subject: Re: [PATCH net] xfrm: fix IPv6 first-fragment protocol decode
From: netdev-bot+sashiko@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kuba@kernel.org
Date: Mon, 02 Nov 2026 23:09:25 +0000
Message-ID: <179366096529.3131.16773351906482343613@kernel.org>
In-Reply-To: <20261101230745.2043474-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261101230745.2043474-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] After this patch, decode_session6() stays compatible with the
  old decoder's fragment behaviour only when the built-in C flow…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is an IPsec
  policy bypass on the same code path.

--

xfrm: fix IPv6 first-fragment protocol decode

For AF_INET6, this commit makes __xfrm_decode_session() pass
FLOW_DISSECTOR_F_PARSE_1ST_FRAG, so the flow dissector walks past an
IPv6 Fragment header to the real upper-layer protocol. It also changes
decode_session6() so the GRE key and ICMPv6 type/code are only set when
FLOW_DIS_IS_FRAGMENT is clear, which matches the old decoder.

> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 9ea60c7717ff8..c9c2370b07cc1 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -3489,14 +3489,16 @@ decode_session6(const struct xfrm_flow_keys *flkeys, struct flowi *fl, bool reve
>  		fl6->fl6_dport = flkeys->ports.dst;
>  	}
>  
> -	switch (flkeys->basic.ip_proto) {
> -	case IPPROTO_GRE:
> -		fl6->fl6_gre_key = flkeys->gre.keyid;
> -		break;
> -	case IPPROTO_ICMPV6:
> -		fl6->fl6_icmp_type = flkeys->icmp.type;
> -		fl6->fl6_icmp_code = flkeys->icmp.code;
> -		break;
> +	if (!(flkeys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
> +		switch (flkeys->basic.ip_proto) {
> +		case IPPROTO_GRE:
> +			fl6->fl6_gre_key = flkeys->gre.keyid;
> +			break;
> +		case IPPROTO_ICMPV6:
> +			fl6->fl6_icmp_type = flkeys->icmp.type;
> +			fl6->fl6_icmp_code = flkeys->icmp.code;
> +			break;
> +		}
>  	}

[Severity: High]
This is a pre-existing issue, not one introduced by this patch, but it is
on the same path. This path now finds the real L4 protocol for IPv6
atomic fragments (offset 0, M=0). Could the ports and ICMPv6 type/code be
recovered as well?

An atomic fragment is a complete datagram. ipv6_frag_rcv() only moves the
transport header past the Fragment header and returns 1:

net/ipv6/reassembly.c:ipv6_frag_rcv() {
    ...
	if (!(fhdr->frag_off & htons(IP6_OFFSET | IP6_MF))) {
		/* It is not a fragmented frame */
		skb->transport_header += sizeof(struct frag_hdr);
		...
		return 1;
    ...
}

After that, udpv6_rcv()/tcp_v6_rcv() -> xfrm6_policy_check() ->
__xfrm_decode_session() -> __skb_flow_dissect() dissects the packet again
from the network header. With PARSE_1ST_FRAG, ip_proto is now correct.
The ports are still skipped, though:

net/core/flow_dissector.c:__skb_flow_dissect() {
    ...
	if (!(key_control->flags & FLOW_DIS_IS_FRAGMENT))
		__skb_flow_dissect_ports(skb, flow_dissector, target_container,
					 data, nhoff, ip_proto, hlen);
    ...
}

So flkeys.ports keeps its memset value of zero, and decode_session6()
copies zeros into fl6_sport/fl6_dport. The new gate above also leaves the
ICMPv6 type/code and the GRE key unset. The ICMPv6 type/code share storage
with the port fields that xfrm_flowi_sport()/xfrm_flowi_dport() read.

As a result, __xfrm6_selector_match() can never match a selector scoped by
port, ICMPv6 type or GRE key:

	!((xfrm_flowi_dport(fl, &fl6->uli) ^ sel->dport) & sel->dport_mask) &&

Take an inbound "proto udp dport 1701, tmpl ESP level required" policy,
with no broader policy covering that traffic and a default inbound policy
of accept. __xfrm_policy_check() then takes its !pol branch and returns 1.
Could a remote sender put plaintext UDP or TCP inside an atomic Fragment
header and have it delivered to the socket that policy is meant to
protect?

The old open-coded decoder behaved the same way (NEXTHDR_FRAGMENT set
onlyproto = 1), and the commit message keeps this on purpose. For atomic
fragments (FLOW_DIS_FIRST_FRAG with M=0), the ports are as reliable as
the protocol. Would it make sense to handle that case here?

>  
>  	fl6->flowi6_proto = flkeys->basic.ip_proto;
> @@ -3507,10 +3509,13 @@ int __xfrm_decode_session(struct net *net, struct sk_buff *skb, struct flowi *fl
>  			  unsigned int family, int reverse)
>  {
>  	struct xfrm_flow_keys flkeys;
> +	unsigned int flags = FLOW_DISSECTOR_F_STOP_AT_ENCAP;
>  
>  	memset(&flkeys, 0, sizeof(flkeys));
> +	if (family == AF_INET6)
> +		flags |= FLOW_DISSECTOR_F_PARSE_1ST_FRAG;
>  	__skb_flow_dissect(net, skb, &xfrm_session_dissector, &flkeys,
> -			   NULL, 0, 0, 0, FLOW_DISSECTOR_F_STOP_AT_ENCAP);
> +			   NULL, 0, 0, 0, flags);

[Severity: Medium]
Is the old fragment behaviour still kept when a BPF flow dissector is
attached?

decode_session6() copies flkeys->ports into fl6_sport/fl6_dport for every
packet. Only the GRE/ICMPv6 fields check FLOW_DIS_IS_FRAGMENT. Fragments
get zero ports only because the C dissector skips
__skb_flow_dissect_ports() when FLOW_DIS_IS_FRAGMENT is set.

When a BPF_PROG_TYPE_FLOW_DISSECTOR program is attached to init_net or to
the netns, __skb_flow_dissect() runs it instead of the C code.
bpf_flow_dissect() passes the new flag through unchanged:

net/core/flow_dissector.c:bpf_flow_dissect() {
    ...
	flow_keys->flags = flags;
    ...
}

The in-tree reference program, PROG(IPV6FR) in
tools/testing/selftests/bpf/progs/bpf_flow.c, keeps parsing first
fragments when PARSE_1ST_FRAG is set:

	return parse_ipv6_proto(skb, fragh->nexthdr);

That fills in sport/dport. __skb_flow_bpf_to_target() then copies them
into FLOW_DISSECTOR_KEY_PORTS without any fragment check:

		key_ports->src = flow_keys->sport;
		key_ports->dst = flow_keys->dport;

So with a BPF dissector, IPv6 first fragments now reach the XFRM policy
lookup with real ports. Later fragments of the same datagram get zero
ports, and so does every fragment under the C dissector.

The forward path checks fragments one at a time:
ip6_forward() -> xfrm6_policy_check(XFRM_POLICY_FWD), then
xfrm6_route_forward(). Could a port-scoped selector match the first
fragment but not the rest, giving fragments of one datagram different
policy and routing decisions?

Before this patch PARSE_1ST_FRAG was never passed, so both dissectors
stopped at the Fragment header. That conflicts with this part of the
commit message:

  "Keep GRE and ICMPv6 selector fields unset for fragmented packets,
   matching the old decoder's behavior."

Would putting the port assignment in decode_session6() under the same
FLOW_DIS_IS_FRAGMENT check used for GRE/ICMPv6 remove this dependency on
the dissector?

>  
>  	switch (family) {
>  	case AF_INET:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261101230745.2043474-2-Jeremy.Jean%40oss.cyber.gouv.fr
