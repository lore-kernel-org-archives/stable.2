Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487148;
	b=tTC38kI5fJbwwAMlc9jH9TEPZSxExa09dJavSuoLoTWlll9HEJ+RWRHcVujLBrweZgqI
	 wMpN28L4xxLF+GKLi5P+2vFCfXgUnFETQ8XhGDt6f9hQkBC/y18p/B5kOWCfTulfXauHp
	 lJcCnV2BVhne8g98RVzR0EEIhYQA49+kjvDYJxQ1trEhTuakemqltruCxMAt/G6/vkvw9
	 a/gGy/QdGM09aYpyeHqxcTQ8aSTSWVzro+W5dFD+xYFiubzrQMiBDpiCb2c2vBTcKMEST
	 +5ya3ubWup+VHwcCdCZwdeGMHdq+IW1xo0fokUE+5ejiehZItgcOKeBTPNsgYtWC4wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487148;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vh0wEAdasYoPETQarwZ1upH2wgAJIcq1wNovfVXcsvM=;
	b=pT3Yf6o0693pecQ+Wxg+U8Fn0FlJtoiNQKRKnDh8+CTJNp9MOZ4G9NJSwFXMHkMppTuU
	 LtUB8x8L/Gyau+gAusyWHmSRC5njKRyw2RN4iQkx+GlRHAwxE8QblW2AloK1apPRPC4y+
	 N1ROLqPrm8bNUlJq60wYfbNXmBuZ1Am7RlkTZdXIEs5QrCoN+LdcyTOKXJoPyVQ+AlR65
	 u/wUCSXG+FGsqRzprTJ7aBRxgSWGx+JF+nIJv1F0PEedtfKVSUgNMGP1vn0HYi+HPMz9w
	 x9oEU41vZls95MQIff8s/m+CpU+Es2Ej0IDYsj9+fYt/EjZN14Tdx5/voC1bD1EkSsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IZ801P0m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811F7606A339;
	Thu, 12 Nov 2026 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IZ801P0m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A9A1F00A05;
	Thu, 12 Nov 2026 12:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794487148;
	bh=vh0wEAdasYoPETQarwZ1upH2wgAJIcq1wNovfVXcsvM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IZ801P0mO831HJkHpzTQChJSe9EGTEVSnliF4yzppHntTAOIz4vW3s+5i6liGSaoB
	 ISZ8oACkEGCzXkzokMHHdDR2PIxprZ7qSxJo07e0xadmkQ14gOFkJSr9khYdGRQpM2
	 srTEyrLKJzwI3kHxZNOO1iEBsoyOB+0VWIjonkTNS0/eK7WEvg3C7HiL4/Twh9k+i0
	 U7Tnjd1cz4cI9Kzu8EEa66SLwJ28f1zPr4dG5aPxXZozDDrRpspkCiNTxNLnq/MGwP
	 Lm9BOIEdqeUOc+n3cyt9XDmbqxsydTmCCgN7N95rVKgAIAv3CeqrfsKh3MbkzxxKy8
	 UcNf7QKLJzExg==
Subject:
 Re: [PATCH net v4 2/2] xfrm: fix selector matching for IPv6 atomic fragments
From: netdev-bot+sashiko@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, dsahern@kernel.org, idosch@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kuba@kernel.org
Date: Thu, 12 Nov 2026 12:39:07 +0000
Message-ID: <179448714728.2199510.9531579994326693774@kernel.org>
In-Reply-To: <20261109213803.1785516-6-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261109213803.1785516-6-Jeremy.Jean@oss.cyber.gouv.fr>
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

- [High] The fix still leaves SCTP over IPv6 atomic fragments with zero
  ports in the XFRM flow, so the policy bypass the commit claims to…
- [Low] The new AF_INET6 branch in __xfrm_decode_session() takes
  FLOW_DIS_IS_FRAGMENT as proof that the dissector parsed an IPv6…

--

xfrm: fix selector matching for IPv6 atomic fragments

This patch restores IPv6 selector fields (ports, ICMPv6 type/code, GRE
key) in __xfrm_decode_session() when every Fragment header in the chain is
atomic. ipv6_find_hdr() gains an IP6_FH_F_NON_ATOMIC flag and now reads the
initial IPv6 header through skb_header_pointer(). The ports are taken
from the transport offset found by the flow dissector.

> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 4f6a5b81e3b5a..9ea816a8c5f63 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -3530,9 +3530,23 @@ int __xfrm_decode_session(struct net *net, struct sk_buff *skb, struct flowi *fl
>  		decode_session4(&flkeys, fl, reverse);
>  		break;
>  #if IS_ENABLED(CONFIG_IPV6)
> -	case AF_INET6:
> +	case AF_INET6: {
> +		unsigned int offset = 0;
> +		int fh_flags = 0;
> +
> +		if ((flkeys.control.flags & FLOW_DIS_IS_FRAGMENT) &&
> +		    ipv6_find_hdr(skb, &offset, -1, NULL, &fh_flags) >= 0 &&

[Severity: Low]

Can FLOW_DIS_IS_FRAGMENT be set here for a packet that isn't IPv6? The
IPv4 branch of __skb_flow_dissect() sets the same flag:

    key_control->flags |= FLOW_DIS_IS_FRAGMENT;

With *offset == 0, the new ipv6_find_hdr() code also skips the version
check:

    if (!ip6 || (*offset && ip6->version != 6))
        return -EBADMSG;

vti6_rcv_cb(), vti_rcv_cb() and xfrmi_rcv_cb() pass
family = x->inner_mode.family. xfrm_inner_mode_encap_remove() picks the
decap routine from the inner nexthdr instead. An IPIP inner packet goes
through xfrm4_remove_tunnel_encap(), which sets
skb->protocol = ETH_P_IP, and the packet is then checked with AF_INET6.

In that case ipv6_find_hdr() parses the IPv4 header as IPv6. Byte 6 is
the IPv4 flags/fragment offset byte, and 0x2C there reads as
NEXTHDR_FRAGMENT. The parser then walks the IPv4 fragment payload as
extension headers.

If those payload bytes look like an atomic Fragment header, this branch
clears FLOW_DIS_IS_FRAGMENT and loads ports from the fragment payload.
Before this patch those ports were always zero.

The addresses are already mis-decoded in this case, and the reassembled
packet gets checked again with AF_INET, so the impact looks small. Should
this branch also check flkeys.basic.n_proto == htons(ETH_P_IPV6) before
it calls ipv6_find_hdr()?

> +		    (fh_flags & IP6_FH_F_FRAG) &&
> +		    !(fh_flags & IP6_FH_F_NON_ATOMIC)) {
> +			flkeys.control.flags &= ~FLOW_DIS_IS_FRAGMENT;
> +			flkeys.ports.ports = skb_flow_get_ports(skb,
> +								flkeys.control.thoff,
> +								flkeys.basic.ip_proto,
> +								NULL, 0);

[Severity: High]

For SCTP over IPv6 atomic fragments, do the ports still end up as zero?

sctp_rcv() pulls skb->data past the SCTP common header before it calls
the policy check:

net/sctp/input.c:sctp_rcv() {
    ...
    __skb_pull(skb, sizeof(struct sctphdr));
    ...
    if (!xfrm_policy_check(sk, XFRM_POLICY_IN, skb, family))
    ...
}

When __xfrm_decode_session() runs, the transport header therefore sits
before skb->data. The dissector finishes with nhoff = -12. On the
fragment path __skb_flow_dissect() clamps that value:

    thoff = min_t(u32, nhoff, skb ? skb->len : hlen);

Converted to u32, the negative nhoff becomes a very large number, so
thoff becomes skb->len. skb_flow_get_ports() at that offset fails and
returns 0. FLOW_DIS_IS_FRAGMENT has already been cleared at that point,
so decode_session6() copies sport = dport = 0 into the flowi6. The
non-fragment port path uses the signed nhoff and does not have this
problem.

sctpv6_protocol is INET6_PROTO_NOPOLICY, so this is the only IN policy
check SCTP/IPv6 gets. Could a plaintext IPv6 + atomic Fragment + SCTP
packet still miss a policy such as "proto sctp dport X" that requires
ESP?

The ipv6_find_hdr() call above already handles a start before
skb->data. It leaves the correct transport offset in offset and returns
IPPROTO_SCTP. Could those values be used here instead of
flkeys.control.thoff and flkeys.basic.ip_proto?

> +		}
>  		decode_session6(&flkeys, fl, reverse);
>  		break;
> +	}
>  #endif
>  	default:
>  		return -EAFNOSUPPORT;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109213803.1785516-2-Jeremy.Jean%40oss.cyber.gouv.fr
