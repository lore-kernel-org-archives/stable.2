Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574720;
	b=o1KIg6OMY5tB2hDLXQZ80m7azkhyvL0msklmOrp04LLuEjv8arzBOagy79G37BLh8y/i
	 7r0tpECvAFApl9YYjLb7BIOMVxcuS2dBLhczLayFZB7zmWi7smNQYRfLV+b1K6jT6JC1v
	 XFUdkquLWrYiv+oryagQVMaphT/VqxXFajB1iClutIJa5WpJsud/jARMv1/zFNYbhDQkU
	 Ie+c4RqfsBQJ9q6wWbOi07g8tWWnxXgIsOAVENJCMnwqTyNl78ZpodbzjF0feyIQWdnDB
	 o8lq128WCqvKO11Nt1uENP+IdJeXd+zmS8tXTPwzOc878rSnoujxY6VD4ZDwFyN6RlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=HbPJR8S7V/lAdH8GEImzC/9dsJwbaq/ITvmKn5PwyDo=;
	b=Lhylza8R4G9yBdq9V6x3ihSQTN3MLDl38f3oeDRTl9BqpadebSX4ApuYCuhGpvftWVq+
	 BAe67BiRFt8TVpJpguISzTbYRlNH1gSosp8DYmVAo2cejb2OliZj48oqKxiP9RRDI6kNW
	 qq75OZjN1Uk36V1/ne4i0Kaz3Y2Bc6cxxCxRkMh60A3gv3W+ORZdOLqlZ4kIUDnXMhdX6
	 kGVGdWfmt23qMtsKx6TxL42D5KRGrRbK5LyoA5PYMwwP/GFOTuRQ+o3aiZtLs9w6lOGLi
	 b9Elvvn0jr6bcTuMwAJQw2laJpoeKuyflIYeXInGxrFgQ15DOhhbfUI/hLkpqQeN7ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rcx54Hjr;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088D606A330
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E088D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rcx54Hjr
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e95bd1c14cso19075665ad.2
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 04:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794574719; x=1795179519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HbPJR8S7V/lAdH8GEImzC/9dsJwbaq/ITvmKn5PwyDo=;
        b=Rcx54Hjr2g/nu/NUW5elGTukc1iLZ+5oltNqc2lOWpk6GuB3Y8pB5AC3QFUIsqmFt3
         yiefb9JeD4rAM3/InTQ8OmV7s6aVyEMSnht5LtgpC6hUef677ASWreLi6Xw0tiX7MjBV
         RTlsRydF2lphapMMNssZY5wi2gP9u3H7y03GUewD/1iw9SnjZG0WEZbnYO6OQ6dopwOl
         jRvsZ1+H1VN8tDLbxe/VN4Cb/4uqQs47AfCqySFa4O79V7k2ehIZk9kV2U9QshpUn9rf
         TNU39j/DYfJgY7ikXiIx4L1pqsBHib57dIWLyt9DTpy0pPIjdTIcUcYQrnYTiflfDnbE
         svBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574719; x=1795179519;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HbPJR8S7V/lAdH8GEImzC/9dsJwbaq/ITvmKn5PwyDo=;
        b=Huddf7/4d/fNZBHgvZNB3fCDtk03tvo6c2dv5lx0PNVplkTGqOJrg4AUG3Dpio+jLK
         /CdYrnyFhqfB/qn+AY19xFZ8DQ7nw0Idy3cnraY92mXoZtbyTaD5DJfDXYiorTpVJ2zm
         04zv4J6bDi91rikFNp5fPasKkZK/qxxETvYZu0Z5Xg+EptDV/A9tm+TIUYv2KqhHY1LZ
         0Mm2YxYa93x2KYpzmu2hIjj29B0xIpmXWg90SrzcD1givMEs+2MYSV5rxGjhHHqj/2If
         2YoDxw8Scn6Txkj201NdfjGwV9wFswot/bvquWAjHx8zm7YPXXhoYGzYbURJth8KKehR
         5RqQ==
X-Forwarded-Encrypted: i=1; AL+hErGZtRj/LkydGZ2WIxPXiYTM9IVCByji4Y1GQ1rBd8l5L0zeYYMYdrRohEbN3xVyftKUHAuIEZU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cWkunhhPKZD+N1b6JnbFklm/TdBEjIHe56CbVtceTX0WT3pmx
	cLhOWiGKt9zyfMgWx3loJ+kRPhppiO1w0PCqgCrIySPWejyWkATSgkry
X-Gm-Gg: AYBFou02jYsNB0cNH6ZywT9fOqV77inRNPcOJk4ztyGiSG7E6+1Vhdm1Hdv9C7r7KYe
	HmtVC38csq+5w8UeK/nEsprfSP1bMwDszsG9AVFksYQFaUYzbTwVbKak+rjr2QsevUnHD0pki9g
	3aHQdT/IaPe8NUZsPetByYxLffAr7ehmfCroweNPVFI2TmtxAxlRqcgozoZOpmRKy9LbPdoKzxY
	I8APAwa0Ta+XiogegGDJanSZr1JLVQOJ7MI1Id3iKefOz9m4yktVXuXLAx7IrIngNKeKkVD6QoT
	nBgWDehnRIgpQbpdzoRDQrhSGef4PylgyVglJZNJATN82bLtvAgKhX816bSMKfQjyfRZF+JUpuV
	iplDn5YhG6IXjtlhkdkdfNDqUFZWl/pwWP7onQtGVfPhCOd6qqgHV5xHwtDZLLasC3yES7ta/Fw
	b7TGbmYJGl3/XwMk1WMGCtJGIJmgqdr1cDAe1j38Xh4TLHhZJl7vSJHrHq1fdxaWAYTu+9mf4wQ
	b/Lx4WTxme9oH6k3YvyJhSwh9Tqg0ObYs/Y1INJkUjX/nqb9jeSSfLdnnhpTcWtSJQVOVdoIaPI
	BcIR/dpBNoBc/Y4zBn1DLmaR+b4egAFcQMNoH2+mTAUBMdwjkw==
X-Received: by 2002:a17:902:db08:b0:2ed:3be3:c648 with SMTP id d9443c01a7336-2ee0dd9f13emr26553385ad.22.1794574719245;
        Fri, 13 Nov 2026 04:58:39 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7e4e47sm9461925ad.38.2026.11.13.04.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:58:38 -0800 (PST)
Date: Fri, 13 Nov 2026 21:58:32 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Justin Iurman <justin.iurman@gmail.com>,
	Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stefano Brivio <sbrivio@redhat.com>, netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org, dev@openvswitch.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net 1/5] ipv6: gro: limit the number of extension headers
Message-ID: <avcJeFcatcigXekZ@v4bel>
References: <20261113124625.4010206-1-edumazet@kernel.org>
 <20261113124625.4010206-2-edumazet@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113124625.4010206-2-edumazet@kernel.org>

On Fri, Nov 13, 2026 at 01:46:21PM +0100, Eric Dumazet wrote:
> Hyunwoo Kim reported that a long chain of IPv6 extension headers
> can push the transport header offset of a GRO packet beyond what
> the 16-bit skb->transport_header can store. The truncated offset
> is later used by gro_receive_network_flush() to locate the network
> header of a packet held in the GRO list, leading to an out-of-bounds
> read.
> 
> Since commit 3744b0964d52 ("ipv6: Implement limits on extension header
> parsing"), ip6_protocol_deliver_rcu() drops packets carrying more than
> IP6_MAX_EXT_HDRS_CNT extension headers, but ipv6_gro_pull_exthdrs()
> was left unbounded.
> 
> There is no point trying to aggregate packets that the stack is going
> to drop anyway if they are locally delivered. Apply the same limit in
> ipv6_gro_pull_exthdrs().
> 
> When the limit is hit, @proto still designates an extension header.
> Extension header offloads have no gro_receive() callback, so
> ipv6_gro_receive() takes its existing "goto out" path with flush set,
> and the packet is given to the normal receive path. Local delivery
> drops it with SKB_DROP_REASON_IPV6_TOO_MANY_EXTHDRS, while forwarded
> packets are simply not aggregated.
> 
> An extension header being at most 2048 bytes, this bounds a chain
> to 24576 bytes.
> 
> Note that offsets can still accumulate over nested encapsulations,
> so the places storing them should be hardened separately.
> 
> Fixes: 4b0ebbca3e16 ("net: gro: move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment")
> Cc: stable@vger.kernel.org
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Link: https://lore.kernel.org/netdev/avTTQNyvwPP6LtGx@v4bel/

Tested-by: Hyunwoo Kim <imv4bel@gmail.com>

> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv6/ip6_offload.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
> index 700f1861d8eb..01642900c0fa 100644
> --- a/net/ipv6/ip6_offload.c
> +++ b/net/ipv6/ip6_offload.c
> @@ -26,6 +26,7 @@ static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int proto)
>  {
>  	const struct net_offload *ops = NULL;
>  	struct ipv6_opt_hdr *opth;
> +	int exthdr_cnt = 0;
>  
>  	for (;;) {
>  		int len;
> @@ -38,6 +39,13 @@ static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int proto)
>  		if (!(ops->flags & INET6_PROTO_GSO_EXTHDR))
>  			break;
>  
> +		/* Same limit as ip6_protocol_deliver_rcu().
> +		 * @proto is left pointing to an extension header,
> +		 * so that the caller does not aggregate this packet.
> +		 */
> +		if (unlikely(exthdr_cnt++ >= IP6_MAX_EXT_HDRS_CNT))
> +			break;
> +
>  		opth = skb_gro_header(skb, off + sizeof(*opth), off);
>  		if (unlikely(!opth))
>  			break;
> -- 
> 2.53.0
> 
