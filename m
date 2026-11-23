Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795407147;
	b=xcC0/wyroBllE+d4koMDyFTMkIMq95MIRW06yoQpJwp29JMXuy1lOqnvpvJgRWhG6GzX
	 8F4Nl2TdYUTWdlYcpOfTx5x3LhnAG6+FrNHD1m6vQR57IULs4EISsq1HbuKQfdAaGkttz
	 TX9UsmYYR0bMBeeAWfzqH+TD8VJ4MqF45rR7RNiplsLkfeKwS1aeUiZUftSbcECm+QUHh
	 uf743rdn56rjRJRrCuXGn3PTpsR/TqDbTTMEpwfV/uylLHJn1x0LzGAcqV+n8DT1pXu0d
	 uMw5bO7FhkAWpkqv4bTKa8qMEsObCmG1ZB6rK3WQcKLSU+CFiCL48Abz94zFWAU6BkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795407147;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:CFBL-Feedback-ID:
	 CFBL-Address:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=fhNl0a2bNDX2xO1fDfY+x8/kfxDi7en+9Qu0kuJSav4=;
	b=ArlNE2Z3351qOikWUsUyievh/L8snfZtIacLQFxw4VUNIuibMa6d1PATTRBKgPfiZVA5
	 Z4TkuRZbUfXOBCZsYnhaZ6SihicSkMqhHhmVhFXWevdehf/09TSwRtH9B7HfKLzMf+1xe
	 DrqnVmgumaTPDQ+CLfrSedMsYQVjEDVGjGNTlxxmhAKYfhPkxeLYRL+wLdluIuMWlelBL
	 96gllCcBjJeNmodEYf+FtMIGGqhqiZtzfrLSg5kvSAJnei3kvcchZzTgR+z9E9GwtjOeG
	 p8q44KOIyivq/4n+8oBUB1luYfjGU3M9dPNtpNznO3pgtQDntIHmJZkLm69RnnvVJDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ovn.org;
	spf=pass smtp.mailfrom=fe-bounces.ovn.org;
	dkim=pass header.d=ovn.org header.i=@ovn.org header.a=rsa-sha256 header.s=fe-13eddc7e57 header.b=nHiGH5Su;
	dkim=pass header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=f74sabTq;
	arc=none smtp.remote-ip=149.28.215.223
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344FB606A32D
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 04:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 344FB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovn.org header.i=@ovn.org header.a=rsa-sha256 header.s=fe-13eddc7e57 header.b=nHiGH5Su;
	dkim=pass (1024-bit key) header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=f74sabTq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ovn.org;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: Autocrypt: From:
 Content-Language: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=fe-13eddc7e57;
 t=1795407146; bh=fhNl0a2bNDX2xO1fDfY+x8/kfxDi7en+9Qu0kuJSav4=;
 b=nHiGH5Su0Q6CFKPdchBdFdJyO4QAotdXv21R4vJ2ws5t09bhCBkzEmy4IQLqPEEMceKByCRkY
 5sS2RnFi5G/lYgzbpud62uOtcvgIsb+kg6G5lNHMqzfvdsH6gxdEtjBQw+F3FRH6vxUj4+aK+1j
 5dAO2EOyztbh51UtP7labTw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=forwardemail.net;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: Autocrypt: From:
 Content-Language: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=default;
 t=1795407146; bh=fhNl0a2bNDX2xO1fDfY+x8/kfxDi7en+9Qu0kuJSav4=;
 b=f74sabTqfHw6c9tg3OLhPAChG/gaVBVJ0Cu6WE7uiBFxESi6XUNP5elSCo7fNhGAp1xrW73ZO
 KqFoY6yfBf9h5fQN8e7Oo3i3VCLOh749dkxThpapAIVnKzFRr8iEcW1oyNA1odBalprNkveverG
 SGlpziKyN5ZVzb45vDXOB48=
CFBL-Feedback-ID: 6b03bd27820b813f2fb1faea:4408a1a079db1d613e8f0abf89aa9770
CFBL-Address: abuse@forwardemail.net; report=arf
X-Forward-Email-ID: 6b03bd27820b813f2fb1faea
X-Forward-Email-Sender: rfc822; i.maximets@ovn.org, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.19.37
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <ccfbd34e-ce6e-4517-bce1-c68e5ac2bb50@ovn.org>
Date: Mon, 23 Nov 2026 05:12:19 +0100
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
Subject: Re: [PATCH net v4] net: openvswitch: make transport checksums
 writable
To: Kyle Zeng <kylebot@openai.com>, dev@openvswitch.org
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261120191115.39932-1-kylebot@openai.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20261120191115.39932-1-kylebot@openai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/26 8:11 PM, Kyle Zeng wrote:
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
> v4:
> - Document that both IPv6 checksum addresses must be outside the skb.
> - Use the IPv6 address fields' sizes in the final copies.
> 
> v3: https://lore.kernel.org/r/20261113232158.61174-1-kylebot@openai.com
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
>  net/openvswitch/actions.c | 80 +++++++++++++++++++++++++--------------
>  1 file changed, 52 insertions(+), 28 deletions(-)
> 
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 12e339cbf791..7691f262294d 100644
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
> @@ -345,32 +347,37 @@ static void update_ip_l4_checksum(struct sk_buff *skb, struct iphdr *nh,
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
> +/* Neither addr nor new_addr may point into the skb, since
> + * skb_ensure_writable() can move the skb head even on failure.

The 'even on failure' part is not necessary here, as the values are
never used on failure of skb_ensure_writable().  But it's not worth
re-spinning just for this.

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
