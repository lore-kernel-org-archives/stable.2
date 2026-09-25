Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E49423E98;
	Fri, 25 Sep 2026 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790319189; cv=none; b=YQhqL1S5xq5I7R6Nf5X+B5wCqdwfK2S13r1+V3aUjuRf9QO+NEZWv388o7uZK0lO3FW+kBnPeCBimquAKMGa+GQfzSRdqXfqIdfV8l6N7WewZAZb02kGp9l+8xAJTUFtb/ROWDGWurk6OT0VSnt/uHBYl2FXn8sVh59TSygQa8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790319189; c=relaxed/simple;
	bh=NlyTShol0nlOoyUoIr+8ayl0Q3rfL333ESYyU7ycezk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ToB6LtuztikuUzzI6LdclJSjtZZWthSeJBCWSKQsOGG2l+MWh2hc8vr5jQ2BLfU/C9woxSLCRZqUi4hH+feuM09omKyw3p6TGMXzOFZiPHJVwtabtTMVtv55y9nDilW6/fxmyAoT3EsDvRH0i9/OSJPsXof+MOxScIJ6c9ZVoxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dODnnSTJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dODnnSTJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42311F0089C;
	Fri, 25 Sep 2026 06:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790319184;
	bh=Pg8+wxqefBf6R9s8pjoYq1HP8XsHZ5187K8XLrfSaqA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dODnnSTJjk54jUuwXmTWGB709B5PSCRZO6i0A6IJ4m0/yrB0ikRL9IKQvYxo+CaFc
	 Sda42uPTXYlIby1TZSNMuV+wCCPc6X6Vw9pu7WzYdAKWocgfsBQNEJoeI3UeIuDgoD
	 GzkbOUSt+d8TITQqDi52rhU29zNbqSSaengo/GRndjrgyZzUYYeTZRuub6X9TaBr6R
	 u9pg2BvudSSnO0XgCSJQVL4FCZSgYUfQKDIeHDvfoLQPew0fpB+xyr54uYBJ+hAf9G
	 si4ifMkO+1yLJp3ACQFzpIjlTXHaYU55AJxUBML/3XqoNgjWcYgPax+G2GNbhg8wqT
	 UkRtcnJ71FKsQ==
Subject: Re: [PATCH net v3 5/5] gre: do not read inner frame as erspan
 metadata in collect_md mode
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 u9012063@gmail.com, stable@vger.kernel.org
Date: Fri, 25 Sep 2026 06:53:03 +0000
Message-ID: <179031918335.2160803.14092450934065395017@kernel.org>
In-Reply-To: <20260923035217.179102-6-edumazet@google.com>
References: <20260923035217.179102-6-edumazet@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix is incomplete on the IPv6 side.

--

gre: do not read inner frame as erspan metadata in collect_md mode

In collect_md mode, erspan_rcv() and ip6erspan_rcv() could copy bytes
from the inner Ethernet frame into the ERSPAN metadata. This happened for
type I packets and for packets whose base header version was not 1 or 2.
The patch rejects base header versions other than 1 and 2, skips metadata
extraction for type I, and makes is_erspan_type1() match the rule in
gre_parse_header().

> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index e61cb10b50dc9..774975955747e 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -503,6 +503,8 @@ static int ip6erspan_rcv(struct sk_buff *skb,
>  	ipv6h = ipv6_hdr(skb);
>  	ershdr = (struct erspan_base_hdr *)skb->data;
>  	ver = ershdr->ver;
> +	if (unlikely(ver != 1 && ver != 2))
> +		return PACKET_REJECT;

[Severity: Medium]
Can a 4-byte ETH_P_ERSPAN (type I) GRE frame over IPv6 still get past this
check, so that inner Ethernet bytes end up in the metadata?

gre_parse_header() treats a 4-byte ETH_P_ERSPAN header as type I. It does
not parse an ERSPAN header in that case:

net/ipv4/gre_demux.c:gre_parse_header() {
    ...
	if ((greh->protocol == htons(ETH_P_ERSPAN) && hdr_len != 4) ||
	    greh->protocol == htons(ETH_P_ERSPAN2)) {
    ...
}

gre_rcv() in ip6_gre.c then passes every ETH_P_ERSPAN frame to
ip6erspan_rcv(), including the 4-byte ones:

	if (unlikely(tpi.proto == htons(ETH_P_ERSPAN) ||
		     tpi.proto == htons(ETH_P_ERSPAN2))) {
		if (ip6erspan_rcv(skb, &tpi, hdr_len) == PACKET_RCVD)

For such a frame, skb->data points at the inner destination MAC. That means
ershdr->ver is the high nibble of the first MAC byte. If that byte is 0x1X
or 0x2X, the new check passes.

ip6gre_tunnel_lookup() can then fall back to collect_md_tun_erspan. In that
case, erspan_hdr_len(ver) pulls 8 or 12 bytes of the inner Ethernet header.
pkt_md then points at inner frame offset 4, and this copies MAC address
bytes into md->u:

			pkt_md = (struct erspan_metadata *)(gh + gre_hdr_len +
							    sizeof(*ershdr));
			md = ip_tunnel_info_opts(info);
			md->version = ver;
			md2 = &md->u.md2;
			memcpy(md2, pkt_md, ver == 1 ? ERSPAN_V1_MDSIZE :
						       ERSPAN_V2_MDSIZE);

A frame whose first MAC nibble is 0 is now rejected, but one whose nibble
is 1 or 2 is delivered truncated, with metadata built from the MAC bytes.

The IPv4 side now follows the gre_parse_header() rule through
is_erspan_type1(). ip6erspan_tap_validate() only accepts erspan_ver 1 or 2,
so type I is never valid on IPv6.

Should ip6erspan_rcv() reject tpi->proto == htons(ETH_P_ERSPAN) &&
gre_hdr_len == 4 before it reads ershdr->ver?

>  
>  	tunnel = ip6gre_tunnel_lookup(skb->dev,
>  				      &ipv6h->saddr, &ipv6h->daddr, tpi->key,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923035217.179102-1-edumazet%40google.com
