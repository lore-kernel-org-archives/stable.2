Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794838207;
	b=2tC6aR7T5Ocxb4udGRy6YlOt+pvkZ4i0o8AAsyNv8BvkxIFHYYE+d8izAVzfrAIK5xHE
	 l2kDs9hrSg37BEKuS9vg/lDgpTbROIv1Kdf9wFmXz8Az+qCnyJw2sDC99X8EP4I5sX798
	 eyJ2cDbfRjwgrxwf6Y3pevYbcv1fxjTMfwqfdHEu3pIALKYvJ+qtRQy9ErQcLN5uj5AeB
	 Rq+xl/v3g9cssPGAbXXi88A9fQaQQ/ydZqCrag0Ir2axraVn4vEEKUtlH1rHJRznnALg3
	 slN+QUPWyLo3OvXYrLypnbcPlacxMSKIZ890/1T12ZBVBnpPenB4BPV5fBj05qD/ejg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838207;
	h=DMARC-Filter:DKIM-Signature:X-Forward-Email-ID:
	 X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=wwcoMw9z6tu5kf8Ai+tMBLjURMN0gJoh/na9XKBE2Ak=;
	b=HAXUNVHQsann9hu1xuGVxj2N4+Ind9bWKh11LdRGcq4FQthWneLTccGC+bUnvnqAIPt+
	 JRspZPmjomj3M29v+Eqett+79KbMzW6eMlPcaomJFXm5FFxijf/MX+I9Mu553YBU4TNz8
	 Tt0kxb2coFP+qt+9OfTihfmcStzkEWhZdDrXpl8W0/86HlOYwVu8I9zj+egFIFZvhJ8QJ
	 EagL9XMfZxY86fMI5uAeUeKZ9Q8XOsMobf2uORvqxh/gDfxxbTS0/cXaUVfgKgkLRhISs
	 T4sVWE0P0sjHEgh8r2Zg95eZ7ZHfp/1Bfc+pQ/tzt4cHqdZX+Nuy3g9AmP4I1EifAnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ovn.org;
	spf=pass smtp.mailfrom=fe-bounces.ovn.org;
	dkim=pass header.d=ovn.org header.i=@ovn.org header.a=rsa-sha256 header.s=fe-13eddc7e57 header.b=J3jP0yVB;
	arc=none smtp.remote-ip=149.28.215.223
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2DC606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C2DC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovn.org header.i=@ovn.org header.a=rsa-sha256 header.s=fe-13eddc7e57 header.b=J3jP0yVB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ovn.org;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: Autocrypt: From:
 Content-Language: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID; q=dns/txt; s=fe-13eddc7e57; t=1794838201;
 bh=wwcoMw9z6tu5kf8Ai+tMBLjURMN0gJoh/na9XKBE2Ak=;
 b=J3jP0yVB32IoI+/+smJ5J1JNgI/a5QD0NZhhL/68sTGSf7m454IKnG+JeRmWifPwAa97PMQRo
 Wb5XcgEIjpXXkxzr6AhnUD0dw16CDRSx3VG/H5TuYPANw+Bgs26Mycl+ScccpKtxxt4+UM6mueT
 vEE0JLsAroP2vY6wqGjVZtU=
X-Forward-Email-ID: 6afb0eb57cafac71428bedd7
X-Forward-Email-Sender: rfc822; i.maximets@ovn.org, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.19.26
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <32ccacbe-e0fc-4cb8-a6c0-a0446b4f7ce1@ovn.org>
Date: Mon, 16 Nov 2026 15:09:53 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: openvswitch: make transport checksums
 writable
To: Kyle Zeng <kylebot@openai.com>, dev@openvswitch.org
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261113232158.61174-1-kylebot@openai.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20261113232158.61174-1-kylebot@openai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/26 12:21 AM, Kyle Zeng wrote:
> OVS can still rewrite an IP address after transport-header extraction
> fails. The checksum helpers check skb->len, which includes non-linear
> data, before directly accessing the L4 checksum. If the transport header
> was not pulled into the linear head, the checksum update can read or
> write beyond it.
> 
> Call skb_ensure_writable() before IPv4 TCP/UDP and IPv6 TCP/UDP/ICMPv6
> checksum updates. Save the original addresses and reload header pointers,
> since even a failed pull can move the skb head.
> 
> Keep failures nonfatal to preserve the existing policy of rewriting IP
> addresses when the transport header is unavailable. A failed pull or
> unshare may leave a stale checksum or CHECKSUM_PARTIAL seed; the receiver
> may discard the packet.
> 
> The issue was found by an LLM.
> 
> Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
> Fixes: 3fdbd1ce11e5 ("openvswitch: add ipv6 'set' action")
> Suggested-by: Ilya Maximets <i.maximets@ovn.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
> v3:
> - Select source and destination addresses with booleans instead of
>   calculating offsets. Keep the saved IPv6 address across head movement.
> - Remove the redundant IPv6 fragment check and correct tab alignment.
> - Move testing details below the separator and clean up attribution.
> 
> v2: https://lore.kernel.org/r/20261107040238.27606-1-kylebot@openai.com
> v1: https://lore.kernel.org/r/20261030042304.74291-1-kylebot@openai.com
> 
> I have a reproducer for this issue and can share through DM.
> 
>  net/openvswitch/actions.c | 77 +++++++++++++++++++++++++--------------
>  1 file changed, 49 insertions(+), 28 deletions(-)
> 
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 12e339cbf791..3b10b3fbadc3 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -319,20 +319,22 @@ static int pop_nsh(struct sk_buff *skb, struct sw_flow_key *key)
>  	return 0;
>  }
>  
> -static void update_ip_l4_checksum(struct sk_buff *skb, struct iphdr *nh,
> -				  __be32 addr, __be32 new_addr)
> +static void update_ip_l4_checksum(struct sk_buff *skb, __be32 addr,
> +				  __be32 new_addr)
>  {
> -	int transport_len = skb->len - skb_transport_offset(skb);
> +	struct iphdr *nh = ip_hdr(skb);
>  
>  	if (nh->frag_off & htons(IP_OFFSET))
>  		return;
>  
>  	if (nh->protocol == IPPROTO_TCP) {
> -		if (likely(transport_len >= sizeof(struct tcphdr)))
> +		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
> +						sizeof(struct tcphdr))))
>  			inet_proto_csum_replace4(&tcp_hdr(skb)->check, skb,
>  						 addr, new_addr, true);
>  	} else if (nh->protocol == IPPROTO_UDP) {
> -		if (likely(transport_len >= sizeof(struct udphdr))) {
> +		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
> +						sizeof(struct udphdr)))) {
>  			struct udphdr *uh = udp_hdr(skb);
>  
>  			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
> @@ -345,32 +347,34 @@ static void update_ip_l4_checksum(struct sk_buff *skb, struct iphdr *nh,
>  	}
>  }
>  
> -static void set_ip_addr(struct sk_buff *skb, struct iphdr *nh,
> -			__be32 *addr, __be32 new_addr)
> +/* May move the skb head; callers must reload packet pointers. */
> +static void set_ip_addr(struct sk_buff *skb, __be32 new_addr, bool saddr)
>  {
> -	update_ip_l4_checksum(skb, nh, *addr, new_addr);
> -	csum_replace4(&nh->check, *addr, new_addr);
> +	__be32 old_addr = saddr ? ip_hdr(skb)->saddr : ip_hdr(skb)->daddr;
> +
> +	update_ip_l4_checksum(skb, old_addr, new_addr);
> +	csum_replace4(&ip_hdr(skb)->check, old_addr, new_addr);
> +
>  	skb_clear_hash(skb);
>  	ovs_ct_clear(skb, NULL);
> -	*addr = new_addr;
> +
> +	if (saddr)
> +		ip_hdr(skb)->saddr = new_addr;
> +	else
> +		ip_hdr(skb)->daddr = new_addr;
>  }
>  
>  static void update_ipv6_checksum(struct sk_buff *skb, u8 l4_proto,
>  				 __be32 addr[4], const __be32 new_addr[4])
>  {
> -	int transport_len;
> -
> -	if (l4_proto == NEXTHDR_FRAGMENT)
> -		return;
> -
> -	transport_len = skb->len - skb_transport_offset(skb);
> -
>  	if (l4_proto == NEXTHDR_TCP) {
> -		if (likely(transport_len >= sizeof(struct tcphdr)))
> +		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
> +						sizeof(struct tcphdr))))
>  			inet_proto_csum_replace16(&tcp_hdr(skb)->check, skb,
>  						  addr, new_addr, true);
>  	} else if (l4_proto == NEXTHDR_UDP) {
> -		if (likely(transport_len >= sizeof(struct udphdr))) {
> +		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
> +						sizeof(struct udphdr)))) {
>  			struct udphdr *uh = udp_hdr(skb);
>  
>  			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
> @@ -381,7 +385,8 @@ static void update_ipv6_checksum(struct sk_buff *skb, u8 l4_proto,
>  			}
>  		}
>  	} else if (l4_proto == NEXTHDR_ICMP) {
> -		if (likely(transport_len >= sizeof(struct icmp6hdr)))
> +		if (likely(!skb_ensure_writable(skb, skb_transport_offset(skb) +
> +						sizeof(struct icmp6hdr))))
>  			inet_proto_csum_replace16(&icmp6_hdr(skb)->icmp6_cksum,
>  						  skb, addr, new_addr, true);
>  	}
> @@ -396,16 +401,28 @@ static void mask_ipv6_addr(const __be32 old[4], const __be32 addr[4],
>  	masked[3] = OVS_MASKED(old[3], addr[3], mask[3]);
>  }
>  
> +/* May move the skb head; callers must reload packet pointers. */
>  static void set_ipv6_addr(struct sk_buff *skb, u8 l4_proto,
> -			  __be32 addr[4], const __be32 new_addr[4],
> +			  const __be32 new_addr[4], bool saddr,
>  			  bool recalculate_csum)
>  {
> -	if (recalculate_csum)
> -		update_ipv6_checksum(skb, l4_proto, addr, new_addr);
> +	struct ipv6hdr *nh = ipv6_hdr(skb);
> +	__be32 old_addr[4];
> +
> +	if (recalculate_csum) {
> +		memcpy(old_addr, saddr ? &nh->saddr : &nh->daddr,
> +		       sizeof(old_addr));

We should add a comment here or maybe at the top of update_ipv6_checksum()
function saying that neither addresses should point inside the skb.
Otherwise it's not obvious why this copy is necessary.

> +		update_ipv6_checksum(skb, l4_proto, old_addr, new_addr);
> +		nh = ipv6_hdr(skb);
> +	}
>  
>  	skb_clear_hash(skb);
>  	ovs_ct_clear(skb, NULL);
> -	memcpy(addr, new_addr, sizeof(__be32[4]));
> +
> +	if (saddr)
> +		memcpy(&nh->saddr, new_addr, sizeof(__be32[4]));
> +	else
> +		memcpy(&nh->daddr, new_addr, sizeof(__be32[4]));

Can we use size of the fields instead of hardcoding the type?

Best regards, Ilya Maximets.
