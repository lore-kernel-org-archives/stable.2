Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218252;
	b=zpw8VTanzzMnSM0UjzSy2X2PAYjqLILWJjOr5cj/hBxZ3EP91h6wsLTpwBIhtBX+JzVB
	 bGdG7EzRf7dgD3AsxClBiFhwtCQ4qU/ob1Sq3Za0uT0LYKNJsGsmiyQ8JOZqGnYhGvBlo
	 YxWKUlF+mLurQPag0Aet2YcHwwQT81dAJ3gJCI29d/1/K+0tUdd8O94obS9dmtaeXlXRM
	 IXNic5fcdx9B8WpiItA6WPNmvRsZpSaq/AI+Z52zqu+Uqb+zgdkQ0kq1/JzWYZHP7dA/4
	 Mny5dft+TbdohfjyY1faEATzjnSaw3+fgKCFE/EX964UDQBkxEk4Y+gEoaDBauxpW3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218252;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=DJJkwQwsQqFHSilUWPgl7tCVXZq2EDaUDPQ0ilQUREc=;
	b=TgRJQ9dTR9HPY5LqtIuxOymS3JhVf9zVWMC5/YkJux2ygobWKlSa/e21+QPfZLIEMyXU
	 QS+4JJ+RPDJoXIfLCmC2wLe6iM8iP+xNwEaIIvJQq0l5d4yYrveuVUNgCbVxiKBRtHhI2
	 j/tQStgwHHhJrxspdPKRssjEZWzaO90AOCsQ95tB8ZsoFqlQUS9Az3YssPs/9078ebpr3
	 1IZ1dWFZfEs62EE3SlJFQQMuomBH8ImVkxMerOuYWMSgZt4Svnwq+cKnS0GcrVavs2fOW
	 buQPcZKYlj46jv0AIu9jxRqlYBI6CHavZYElmARkofFTxKgy6o/PO9fOQEYyX9DELtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=KtsWDPmu;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F72606A31A;
	Wed, 28 Oct 2026 20:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23F72606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=KtsWDPmu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=DJJkwQwsQqFHSilUWPgl7tCVXZq2EDaUDPQ0ilQUREc=; b=KtsWDPmuQrLtBrT64PsJoOYTsO
	Mc4fJS8kjaO4ID2MFZvWR6syYrFcDjwqv9bvN892C6sQcZxLhl7XxNMdbFoQOJ83dnbB4qdn+xqan
	bFUYFpuqTnIyF92aozB4/SeszQsbM5nwzpHQx/OFKuC21cOPaB5KEUOH9lUxGdcLDd96NH0fy8pI0
	IAlkNcWmHVpf7T0WyWzhR3xJjB1Pp5uFbT+Wx1lMC1eZ5jMMegfWWnvcOOgPyIFZ97cGKbTw4AZ9i
	luTze+2miwAB2PR+kA6GvcixlLLvU9klJdrpGswzlNyBAlj0Tm9D+vSFCtMEgLfvohLB770pBxd5+
	US+SO+mg==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xM9yn-0003z0-0T;
	Wed, 28 Oct 2026 21:10:37 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xM9yl-0004ez-0K;
	Wed, 28 Oct 2026 21:10:35 +0100
Message-ID: <09a5f09a-ef47-475d-a5bc-011d3d27214d@iogearbox.net>
Date: Wed, 28 Oct 2026 21:10:34 +0100
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
Subject: Re: [PATCH net] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
To: Jamal Hadi Salim <jhs@mojatatu.com>, Eric Dumazet <edumazet@kernel.org>
Cc: bot+bpf-ci@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 stable@vger.kernel.org, ast@kernel.org, dsahern@gmail.com, kafai@fb.com,
 martin.lau@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, victor@mojatatu.com,
 martin.lau@kernel.org, mason@kernel.org
References: <bpf_redirect_neigh_short_linear.v1.r0.20261028033717-1@mojatatu.com>
 <2a0f5ff1d8db81b07fc4b344b8e68e3505fcbf36f72a471d1678b2f1cecd881b@mail.kernel.org>
 <CAL4WiioEQsckFKbLz8mnZdK9vG93qEj40Ft8fEfqaNDHyB7DTg@mail.gmail.com>
 <CAM0EoM=ETuLerW3nd85zuEjwqydrd_9E4r0TbDekYyUZnEBSpw@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <CAM0EoM=ETuLerW3nd85zuEjwqydrd_9E4r0TbDekYyUZnEBSpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28167/Wed Oct 28 07:24:17 2026)

On 10/28/26 12:53 PM, Jamal Hadi Salim wrote:
> On Wed, Oct 28, 2026 at 7:40 AM Eric Dumazet <edumazet@kernel.org> wrote:
>> Le mer. 28 oct. 2026 à 11:19, <bot+bpf-ci@kernel.org> a écrit :
>>>
>>>> bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
>>>
>>> TL;DR: The new skb->mac_len < ETH_HLEN check in __bpf_redirect_neigh() may
>>> wrongly drop valid packets on tc egress and netkit, where mac_len is often 0;
>>> a regression that would reach stable.
>>>
>>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>>> index b7ac145b68b1..95a8a728a71d 100644
>>>> --- a/net/core/filter.c
>>>> +++ b/net/core/filter.c
>>>
>>> [ ... ]
>>>
>>>> @@ -2451,10 +2451,14 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
>>>>   static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
>>>>                                struct bpf_nh_params *nh)
>>>>   {
>>>> -     struct ethhdr *ethh = eth_hdr(skb);
>>>> +     struct ethhdr *ethh;
>>>>
>>>>        if (unlikely(skb->mac_header >= skb->network_header))
>>>>                goto out;
>>>> +     if (unlikely(skb->mac_len < ETH_HLEN ||
>>>> +                  !pskb_may_pull(skb, ETH_HLEN)))
>>>> +             goto out;
>>>
>>> Does the new skb->mac_len < ETH_HLEN test drop valid packets on tc egress
>>> and netkit?
>>
>> The bot is right, sorry Jamal, I missed this when looking at your
>> first version.
> 
> agreed - i will send a v2. I will also test egress/netkit path.
> That was fast! (in 7 days on the sashiko nipa i dont remember the
> context given the number of fixes)
Lets also add a BPF selftest for all corner cases to make sure things don't break.
If you need help, I can also take your fix, add a netkit selftest on top and then
we ship via bpf.

Thanks,
Daniel
