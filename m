Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795850166;
	b=5PI1CDgHZrfFt31YzS5etKqeHBICDs6UBesJsHg2GrooVVXHRKXImqcMZl2aLGKdPJ56
	 +ryROMbU7Al2ig4iM8rXuZnDBjw/HLXg6QYfStnA3TrtRqm7mZwyZUTo3TTbF4uAfA6BH
	 Vz7MRNECDNtg+rFnqVRoU0S0vvDb6LNYAiscVS+g0O3cikel2g/3r2sKEGnU9VmO6vqqD
	 t6SmzTnsUJUdjD0eTD1VZUhk539yXduc0utZDB+Ki9yPGW4O5NYBGeUfJOVKE3dFs8CvS
	 XSCR+MEK/CZPevdwCShulYWEzvDx5jiRb4YNKe+A4QvEr4sV4Ntlo6vypgBdjP6T+Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795850166;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=54W8KTLK5TfZwNOBXKWcoX2SzNwA1huYT2IQox7uzQw=;
	b=bgtVc5/TwwNTWdd7Tc3T6DUVqE2LORuUYO+F/3CD/Iog375JbbeeWDypkQnRAjsjuUM2
	 NJoEhnjwfCP6fEUBmw6rDLzaCFyIZ034ffGgJyuwHMjbRYS20lhW9RLfIcmxxb1eT1Uj3
	 wllUtyHaBVDtD/bMuedrRnC++A9lvRt65j4+x5rt8zjQEHPeHOTojvgLJopPtz6+kpTpx
	 rjjABqo2qRCj1qNQPi7zo58C86OZi0O8FgN9/fDZX/quva0BEyGHrwOu2Keiz2+m2Rgx7
	 Y6xgBFJrOaNEypZLSpaZlOrP2uZU7us9HuCo4jsz/xW94Sugdj7Xbmi04rRBhb4cCCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g2/NUCQC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0969D606A31C;
	Sat, 28 Nov 2026 07:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2/NUCQC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AB21F00897;
	Sat, 28 Nov 2026 07:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795850165;
	bh=54W8KTLK5TfZwNOBXKWcoX2SzNwA1huYT2IQox7uzQw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g2/NUCQCaaCOwM4InyuvCtBdKkzBTCLrVF4mhjcJgAHrs0PLZiWf3iwg/oaP1YpAa
	 uhT2hi/XoUHSA1mZ7ty45SFT6s2rgHzjdx9K/E0KpkQ2R6wkz6FK1NxNyvNA7jFpB2
	 FvRJcRA4g897QzJd/ix1xdGdom6/NKVJpeqThOXtDEc3Us0CIUZrdoec9lc11+zTap
	 f086PKP9V8GHIrgnnLsSo+F6yWNrmb5T/XiZ2Ede1i+m1A/FdDWrWAH2VWQmM36c5o
	 HHS6q3X2TpbrRYRemxtJsxf4DtWgwtYj7npiOlRpfkOskqI9F2E7g8k25ShEOiIZhU
	 XJQplnXOHo4pw==
Subject: Re: [PATCH net] net: ife: reject headers that would overflow the
 network header offset
From: netdev-bot+sashiko@kernel.org
To: bsdhenrymartin@gmail.com
Cc: yotam.gi@gmail.com, jhs@mojatatu.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, netdev@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 28 Nov 2026 07:16:04 +0000
Message-ID: <179585016449.3135.6106864949030175850@kernel.org>
In-Reply-To: <20261127063006.2908187-1-bsdhenrymartin@gmail.com>
References: <20261127063006.2908187-1-bsdhenrymartin@gmail.com>
X-sashiko-severity: Critical
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

Critical: 1 · High: 0 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The patch does not fully close the bug class it claims to
  fix.

--

net: ife: reject headers that would overflow the network header offset

This patch adds a bound check to ife_decode(). It rejects IFE frames when
the total pull plus the extra ETH_HLEN stripped by eth_type_trans() would
push the network header offset past U16_MAX. The aim is to stop the u16
network_header from being truncated, which later lets skb->data be moved
to a wild address on the forwarding path.

> diff --git a/net/ife/ife.c b/net/ife/ife.c
> index 2ddf725d3389e..272e457517360 100644
> --- a/net/ife/ife.c
> +++ b/net/ife/ife.c
> @@ -79,6 +79,14 @@ void *ife_decode(struct sk_buff *skb, u16 *metalen)
>  	if (unlikely(ifehdrln < 2))
>  		return NULL;
>  
> +	/* The caller strips one more ETH_HLEN via eth_type_trans() and
> +	 * then resets the network header, whose offset is a u16.  A
> +	 * larger pull would silently truncate the offset and leave the
> +	 * stack with a negative network offset.
> +	 */
> +	if (unlikely(skb->data - skb->head + total_pull + ETH_HLEN > U16_MAX))
> +		return NULL;

[Severity: Critical]
Is this bound tight enough? It still lets the final network header
offset be anything up to exactly U16_MAX. That leaves no room for the u16
offsets the stack computes from network_header afterwards.

After ife_decode() returns, tcf_ife_decode() in net/sched/act_ife.c does:

	skb->protocol = eth_type_trans(skb, skb->dev);
	skb_reset_network_header(skb);

So network_header can end up anywhere in the range up to 65535. Then
ip_rcv_core() in net/ipv4/ip_input.c stores into the __u16 field:

	skb->transport_header = skb->network_header + iph->ihl*4;

With network_header in [65516, 65535] and ihl=5, or a wider window when
IP options are present, this sum wraps. The result is transport_header
smaller than network_header.

On local delivery, ip_local_deliver_finish() then does:

	__skb_pull(skb, skb_network_header_len(skb));

skb_network_header_len() returns the u32 value
transport_header - network_header, which here is about 0xFFFF0014. In
__skb_pull(), skb->len wraps upward, so this check never fires:

	if (unlikely(skb->len < skb->data_len))

After that, skb->data has moved about 4 GiB forward. Isn't this the same
"negative offset pulled as an unsigned length" primitive the commit
message describes? The difference is that it shows up on the local
delivery path (ip_rcv -> ip_rcv_core -> ip_local_deliver ->
ip_local_deliver_finish) instead of neigh_resolve_output(). The L4
handlers (icmp_rcv(), udp_rcv(), tcp_v4_rcv()) would then read through
the wild skb->data with an inflated skb->len.

The sender seems to control the offset precisely. metalen is a u16 taken
from the packet. The TLV walk in tcf_ife_decode() accepts any run of
4-byte aligned unknown TLVs and only bumps the overlimit counter. That
means ifehdrln can be stepped in 4-byte increments to land inside the
20-byte IPv4 wrap window.

IPv6 has the same u16 wrap in ip6_rcv_core() in net/ipv6/ip6_input.c:

	skb->transport_header = skb->network_header + sizeof(*hdr);

This happens when network_header is above 65495. On local delivery the
pskb_pull() length check in ip6_protocol_deliver_rcu() appears to catch
it, but the stored transport offset is still bogus.

Would it be better to leave real slack below U16_MAX for the headers
derived later, or to cap the IFE metadata length / total offset at a
sane value, instead of only checking that the network header offset
fits?

> +
>  	if (unlikely(!pskb_may_pull(skb, total_pull + ETH_HLEN)))
>  		return NULL;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261127063006.2908187-1-bsdhenrymartin%40gmail.com
