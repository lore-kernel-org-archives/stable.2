Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794085573;
	b=l2PfpjN5xt2ZiAVp+gdSb+W9Okc+iIkd/WgopYNMo+lxZoBsJLL66yQ86wvfx5ADWo0w
	 li/AbYF52aeyOthWtUVvJI5OX/pWk6ROxxgJkKasf4vnGdt7u5X+L+3xWNBDHZDtt+xuu
	 uU5cL/65YKruJMlQq3gfKNAoTUzYklzVppoxBX1FfmDD+AkCrjMdyBuxddPv7rLA90MTN
	 sIOp/h0vLUjRNpp/Yp+PESKd3mOTBAQdNS5LiKUM7b7rjN+71BiIzcy5W8+sesVQ9igDD
	 1KFKcFNs1MeW3K5zF5L6h1o+9yPynCVGhR4pAbmTMjUavGbEz5LLF1JMQY10y3P4KHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794085573;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GXAkWtV0fCcGEA/twUd5fTTQKgnBfg+V+HOTAGhnJcw=;
	b=GSOknX/lz/WBT2M1ifdt3srF+wy9DOjb82LlQpzjEDbuw9gJ9lpV/iMAHEdVIltouXI5
	 TmuHLmSvOvZJhxbIIdunH/IiFt8ZvxI0VoBmRmZy7wLErQDBt3MurkzJjZ2FRCpzxRIDk
	 9eZastSmSpmeVMWt6SHKcGsbO5Uz1yu/hgfbS7Gpq5Uodxq32uLdbd0Tllw+GOR0ube9K
	 dv/0i7x0vr/7OfA3FHUy3L9OGCYCTymkotISFkkPcwKN6loV2RygLDNWGraX3UWBkp1cj
	 NQv/N2NKzV9LkS8N6OECXfvmyiGx+51gCFmEUYXMffevOWqnP3h4+MrQ42ZrYgF7a+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YeiL4vYX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF35606A326;
	Sat,  7 Nov 2026 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YeiL4vYX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAB51F0089F;
	Sat,  7 Nov 2026 21:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794085572;
	bh=GXAkWtV0fCcGEA/twUd5fTTQKgnBfg+V+HOTAGhnJcw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YeiL4vYXBQfRq9SSN60+Hvuvqp8PneRDdXdJ0a3jAp7CwaRoCpMIMYjQUXHHqBquU
	 asnHVbI5D5T1hJcCshOJl8U66G67JkbD9ptyLzoefXHlCoU7Xq3w7HSQ7FjyPDl+/w
	 iZz+jfFLje3lL6ZEC34Tjrl31AHQv/VZq6BQ1O4erd49zyMEh8fxpZtfxC75d8COvd
	 pLkKb7CS7AsvwKzn7TgnXFQNgHmpOgAog03gUKzG5/AKvenHZqeKxrEQv/duJX1EDv
	 Pwm2Odrx9D0i5k97/KEufQHicFa/GLET8z5nsHrCGDdnZPwsylNsMNwo4Ds8HZT7v2
	 CQR6Zhoka3ERw==
Subject:
 Re: [PATCH net v3 2/2] xfrm: fix selector matching for IPv6 atomic fragments
From: netdev-bot+sashiko@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, dsahern@kernel.org, idosch@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kuba@kernel.org
Date: Sat, 07 Nov 2026 21:06:11 +0000
Message-ID: <179408557152.994134.2903061781051597708@kernel.org>
In-Reply-To: <20261106202910.723098-6-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261106202910.723098-6-Jeremy.Jean@oss.cyber.gouv.fr>
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix does nothing on the local-input (XFRM_POLICY_IN) path,
  which is the main bypass the commit message says it closes.
- [Medium] The new pskb_network_may_pull() call turns
  __xfrm_decode_session() from a read-only helper into one that can…

--

xfrm: fix selector matching for IPv6 atomic fragments

This patch makes __xfrm_decode_session() recover the ports, the ICMPv6
type and code, and the GRE key for IPv6 atomic fragments. Before this,
those fields were left zero for any packet with a Fragment header. It
adds an IP6_FH_F_NON_ATOMIC flag to ipv6_find_hdr() so the caller can
tell whether every Fragment header in the chain is atomic, and it pulls
the base IPv6 header before calling ipv6_find_hdr().

> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 4f6a5b81e3b5a..b7deeb03276e4 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -3530,9 +3530,24 @@ int __xfrm_decode_session(struct net *net, struct sk_buff *skb, struct flowi *fl
>  		decode_session4(&flkeys, fl, reverse);
>  		break;
>  #if IS_ENABLED(CONFIG_IPV6)
> -	case AF_INET6:
> +	case AF_INET6: {
> +		unsigned int offset = 0;
> +		int fh_flags = 0;
> +
> +		if ((flkeys.control.flags & FLOW_DIS_IS_FRAGMENT) &&
> +		    pskb_network_may_pull(skb, sizeof(struct ipv6hdr)) &&

[Severity: High]
Can this check ever succeed on the local input path?

When xfrm6_policy_check(XFRM_POLICY_IN) runs for a locally delivered
packet, skb->data already points at the transport header.
ip6_protocol_deliver_rcu() does:

    if (!pskb_pull(skb, skb_transport_offset(skb)))
        goto discard;
    ...
        if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb)) {

tcp_v6_rcv() and the UDP and ICMPv6 receive paths run their own IN checks
from the same position.

ipv6_frag_rcv() does not reassemble an atomic fragment. It only moves the
transport header forward:

    if (!(fhdr->frag_off & htons(IP6_OFFSET | IP6_MF))) {
        /* It is not a fragmented frame */
        skb->transport_header += sizeof(struct frag_hdr);

So skb_network_offset(skb) is negative here: -48 for a plain atomic
fragment carrying TCP. pskb_network_may_pull_reason() then computes:

    return pskb_may_pull_reason(skb, skb_network_offset(skb) + len);

Because len is unsigned, -48 + 40 wraps to 0xFFFFFFF8.
pskb_may_pull_reason() then returns SKB_DROP_REASON_PKT_TOO_SMALL from
the len > skb->len check.

The && chain stops at that point and FLOW_DIS_IS_FRAGMENT stays set.
decode_session6() then still leaves the ports, the ICMPv6 type and code,
and the GRE key at zero.

Wouldn't a plaintext atomic fragment sent to a local TCP, UDP or ICMPv6
endpoint still miss an IN policy that selects on those fields? If so,
only the FWD and OUT directions actually get the fix.

With CONFIG_DEBUG_NET, wouldn't each such packet also hit
DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in pskb_may_pull_reason()? One
remote packet would then be enough to cause a WARN, or a panic with
panic_on_warn set.

Instead of pskb_network_may_pull(), could the base header be read with
skb_header_pointer() at skb_network_offset(skb)? Another option would be
to pass an explicit offset to ipv6_find_hdr().

[Severity: Medium]
Could this pull leave stale header pointers in callers of
xfrm6_policy_check()?

Before this patch, __xfrm_decode_session() only read the skb through the
flow dissector, and the dissector uses skb_header_pointer().

pskb_may_pull_reason() calls skb_might_realloc() before any length check.
Under CONFIG_FAIL_SKB_REALLOC that does
pskb_expand_head(skb, 0, 0, GFP_ATOMIC). __pskb_pull_tail() can also call
pskb_expand_head() when the base header is not linear.

Several callers keep header pointers across the policy check. For
example, tcp_v6_rcv() does:

    th = (const struct tcphdr *)skb->data;
    hdr = ipv6_hdr(skb);
    ...
    if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb))
        goto discard_it;

    tcp_v6_fill_cb(skb, hdr, th);

The TIME_WAIT path in tcp_v6_rcv() follows the same pattern, and
tcp_inbound_hash() is passed &hdr->saddr and &hdr->daddr. ip6_forward()
saves hdr on entry and reads hdr->hop_limit after
xfrm6_policy_check(XFRM_POLICY_FWD).

If the head is reallocated here, wouldn't those reads touch the freed
head?

A concrete trigger was only found with CONFIG_FAIL_SKB_REALLOC.
ip6_rcv_core() already makes the base header linear for forwarded
packets. On local input, the wrapped length fails before
__pskb_pull_tail() is reached.

The pull seems to exist only to protect the ipv6_hdr(skb)->nexthdr read
at the start of ipv6_find_hdr(). Would a skb_header_pointer() read that
doesn't modify the skb, or an explicit start offset, cover that read?

> +		    ipv6_find_hdr(skb, &offset, -1, NULL, &fh_flags) >= 0 &&
> +		    (fh_flags & IP6_FH_F_FRAG) &&
> +		    !(fh_flags & IP6_FH_F_NON_ATOMIC)) {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106202910.723098-2-Jeremy.Jean%40oss.cyber.gouv.fr
