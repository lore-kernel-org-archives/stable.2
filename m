Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794103880;
	b=OZ69h5H7GAEC7usoYNhrvkqiGuGhuPpsZN3izC5G0zZMWbpGTnG9UZ7I4pfFmX+Qlt8c
	 Ptkob3H8QUzZd47AaE6qRT+v4UWo1pAfMtaAclKmQsERWedW8drBwQdLQA4g1yTYC10OV
	 MflWlx2HaZK7GIB/TMd7Czw164io+x/6l5/q4ui4Z4olSTEmOwk+VCkGs54cGKCyGcdPw
	 IR5I3KROAzt0ql4PvFAIAY4VvFs4lK4kLlKs3YwV7kHP6fq/cKTwPW4BTnioYegYG0fSG
	 b6jT3BXhpPwi7Q93NEgYiwAK1hBS9+Y1b2VU/U4t9NB7v5Qc5tpm2FqlLRf3Y6fn8Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794103880;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gQaCTOTpCvF7DZ5GQ3rLnRX05Gyc9PqQ55BJs+cL+kc=;
	b=tILXS5y1xHeBEGse9uwZgiZDK8K7zwIkWqxkGtOxyPdMrXSbbY1hptKjN9lYmz09BBVD
	 SvRWEZn23rGDHFbNG/cKZYo/tmYqsFdEWzrst6pKXZpiOrcv6x5wPvOQCZNSm9wjzY/sw
	 7xf826myb4liNSzDIslyFE0HsKkZDvGw6AeLI0nKWfUZ1aXfgRN+WBfFAr9bYo5RV5XJ2
	 4Ttvv/fWOZAv6Rdhf1w0Uxr6Bejsdvrve8UaPt+NNDlSYaRUmGmpfZwXOm1+HKLDIJVgC
	 rJK9DHioCyq94Lm0k+0kTaHt/QIeCcniKxhwqnvmg0RgCZk96dHSY/DckI+AKCJe2iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFtJ4rs3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB70606A31F;
	Sun,  8 Nov 2026 02:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFtJ4rs3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB611F008A1;
	Sun,  8 Nov 2026 02:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794103879;
	bh=gQaCTOTpCvF7DZ5GQ3rLnRX05Gyc9PqQ55BJs+cL+kc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NFtJ4rs3/7TZFXLhRMyF0pX3xpa0qsqf72Jez9M70SKrM23v/ZyF1e1hu1BnuyOJm
	 t2A2rSgfdwCwEmLA3zb3eQPTTVZ4By9iITy96X9Q0JP5thwfMf+1MCxZtIfKElhK71
	 Yyeg6Aj9IBe2meIx1FA85UUt301+DUNGbDwjdiKBBWN7vN8l1518EphRNNjg27iuej
	 50Np2Dacw8C3RmaihkRD1U5+iW22BVeGK3r4IUuc89srEq0sIGGwWj7PafKQ4Qgnml
	 w2SuKHVLTrMmdSKe7CZX9jgJ4JhE4MGgvct/ETXOjWsRCjMMMdPJwC5rEfzaWSiPai
	 KKJjaVv98D/Ig==
Subject:
 Re: [PATCH net v2 2/2] xfrm: fix selector matching for IPv6 atomic fragments
From: netdev-bot+sashiko@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kuba@kernel.org
Date: Sun, 08 Nov 2026 02:11:18 +0000
Message-ID: <179410387864.994134.9353647654476828846@kernel.org>
In-Reply-To: <20261103225842.3204446-4-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261103225842.3204446-4-Jeremy.Jean@oss.cyber.gouv.fr>
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

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new atomic-fragment shortcut in __xfrm_decode_session()
  (net/xfrm/xfrm_policy.c) checks only the FIRST IPv6 Fragment header,…
- [High] xfrm: out-of-bounds read via ipv6_find_hdr() in
  __xfrm_decode_session()

--

xfrm: fix selector matching for IPv6 atomic fragments

This commit changes __xfrm_decode_session() so that an IPv6 atomic
fragment (offset 0, M=0) is decoded as a complete datagram. It clears
FLOW_DIS_IS_FRAGMENT and recovers the ports at the transport offset found
by the flow dissector. Real fragments keep ports, ICMPv6 type/code and GRE
key unset.

> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 4f6a5b81e3b5a..5acb1e0c1b02f 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -3530,9 +3530,25 @@ int __xfrm_decode_session(struct net *net, struct sk_buff *skb, struct flowi *fl
>  		decode_session4(&flkeys, fl, reverse);
>  		break;
>  #if IS_ENABLED(CONFIG_IPV6)
> -	case AF_INET6:
> +	case AF_INET6: {
> +		struct frag_hdr _fh, *fh;
> +		unsigned int offset = 0;
> +
> +		if ((flkeys.control.flags & FLOW_DIS_IS_FRAGMENT) &&
> +		    ipv6_find_hdr(skb, &offset, NEXTHDR_FRAGMENT,
> +				  NULL, NULL) == NEXTHDR_FRAGMENT) {
> +			fh = skb_header_pointer(skb, offset, sizeof(_fh), &_fh);
> +			if (fh && !(fh->frag_off & htons(IP6_OFFSET | IP6_MF))) {
> +				flkeys.control.flags &= ~FLOW_DIS_IS_FRAGMENT;
> +				flkeys.ports.ports = skb_flow_get_ports(skb,
> +									flkeys.control.thoff,
> +									flkeys.basic.ip_proto,
> +									NULL, 0);

[Severity: High]
Is it safe to call ipv6_find_hdr() here without first making sure the
IPv6 header is in the linear part of the skb?

Everything else in __xfrm_decode_session() goes through
__skb_flow_dissect(). That reads headers with __skb_header_pointer(),
so it copes with a nonlinear network header. ipv6_find_hdr() does not.
With *offset == 0 it starts with:

net/ipv6/exthdrs_core.c:ipv6_find_hdr() {
    ...
	u8 nexthdr = ipv6_hdr(skb)->nexthdr;
    ...
}

That reads skb_network_header(skb) + 6 directly. There is no
skb_header_pointer() or pskb_may_pull() in front of it.

xfrm_icmp_flow_decode() looks like a caller where the header may not
be linear. It clones the ICMPv6 error skb and does
pskb_pull(newskb, hl), which drops only the outer IPv6 and ICMPv6
headers. It then calls skb_reset_network_header(newskb) and
xfrm_decode_session_reverse().

Nothing pulls the quoted IPv6 header into the linear area. If that
header sits in page frags, skb_headlen(newskb) can be 0 at this point.
The dissector still copies the inner IPv6 and Fragment headers out of
the frags and sets FLOW_DIS_IS_FRAGMENT. The new ipv6_find_hdr() call
then reads ipv6_hdr(newskb)->nexthdr past skb_tail_pointer(newskb),
into tailroom or skb_shared_info.

This is reachable from xfrm_selector_inner_icmp_match() for an incoming
ICMPV6_DEST_UNREACH, ICMPV6_PKT_TOOBIG or ICMPV6_TIME_EXCEED message
whose quoted packet carries a Fragment header. A remote sender can
therefore trigger it. A BPF flow dissector that sets is_frag on a short
or nonlinear skb would reach the same call.

Before this patch, the AF_INET6 case never read the skb directly, so
this read is new. Could this avoid ipv6_find_hdr() and walk the
extension header chain with skb_header_pointer() only, starting at
skb_network_offset(skb)? Or is there a guarantee I am missing that the
network header is linear for every caller of __xfrm_decode_session()?
A pskb_may_pull() here would modify an skb that these paths otherwise
only read, so I am not sure that is the better option.

[Severity: High]
Can the Fragment header checked here differ from the one that thoff and
ip_proto describe?

With target == NEXTHDR_FRAGMENT, ipv6_find_hdr() stops at the first
Fragment header in the chain. The dissector runs with
FLOW_DISSECTOR_F_PARSE_1ST_FRAG, so it skips past any offset-0 Fragment
header and keeps walking:

net/core/flow_dissector.c:__skb_flow_dissect() {
    ...
	key_control->flags |= FLOW_DIS_IS_FRAGMENT;

	nhoff += sizeof(_fh);
	ip_proto = fh->nexthdr;

	if (!(fh->frag_off & htons(IP6_OFFSET))) {
		key_control->flags |= FLOW_DIS_FIRST_FRAG;
		if (flags & FLOW_DISSECTOR_F_PARSE_1ST_FRAG) {
			fdret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
			break;
		}
	}

	fdret = FLOW_DISSECT_RET_OUT_GOOD;
    ...
}

It stops at the first Fragment header with a non-zero offset. At out:,
thoff = nhoff, so flkeys.control.thoff and flkeys.basic.ip_proto come
from the last Fragment header it processed.

Take a packet like this:

  IPv6 | Frag(off=0, M=0, nexthdr=44) | Frag(off=N>0, nexthdr=UDP) | payload

This is a real non-first fragment. ipv6_frag_rcv() treats it as one: it
skips the atomic header and then reassembles the inner header.

Here, though, only the outer atomic header is checked. FLOW_DIS_IS_FRAGMENT
is cleared, and skb_flow_get_ports() reads at an offset inside the fragment
payload. decode_session6() then copies those payload bytes into
fl6_sport/fl6_dport.

Forwarded fragments are not reassembled unless nf_defrag_ipv6 is loaded.
So a remote sender could get this packet matched against port-specific
selectors through ip6_forward()->xfrm6_policy_check(XFRM_POLICY_FWD) and
xfrm6_route_forward(). Before this patch, it could only match
port-wildcard selectors.

The opposite case also seems possible:

  IPv6 | Frag(0, M=0) | Frag(0, M=1) | UDP

This real first fragment would get its ports decoded. The later fragments
of the same datagram would still get ports=0.

Doesn't that bring back the per-fragment classification mismatch that
7e3a42a12c4b removed? It also seems to contradict this part of the commit
message:

  "Leave ports, ICMPv6 type and code, and GRE key unset for real
  fragments."

Would it be safer to require that every Fragment header in the chain is
atomic? Another option is to check that the header the dissector stopped
at is the one tested here.

> +			}
> +		}
>  		decode_session6(&flkeys, fl, reverse);
>  		break;
> +	}
>  #endif
>  	default:
>  		return -EAFNOSUPPORT;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103225842.3204446-2-Jeremy.Jean%40oss.cyber.gouv.fr
