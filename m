Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609501;
	b=Xlu/9i72uBUdgCh91m6wINCekl5TyLPCXdvOtKQshvZwZLTRzixOtciYF8+tUwQ4uZ9H
	 M2slPG5ToVglafxr3hTZBlzOoLQZzjFXUR0QTsi/eB8b8TJsdYIu3uGAmcwjKYYE8zo2n
	 ZFiu4Ib89rTBqs7kOfNwwEZej8xxbUXOj6WV/IV0I8LYcsoBLCC9Vb3GrZx0TlVhVKdte
	 M62HVFIW3ixeqTbzn1W7fpYARG0x/Hilo8AC7vLZ1ciaNm7G5BAZfLiIb+/qZN0/DMUaM
	 cRNR0cSmVL8afGAaXYQBm5jhsZPPUPloQQysYWqwQlCfsY/kqu2iyXJx2BkTbRMynVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609501;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=k5xzegGZPsdIxHP9LJiqbW2AnSoxon5CqIeHJswRAEI=;
	b=PFdsMxGetdE96Z9D5z19FJTT8tG/1HQF5Cg7MNx7aPAqYi+WKgRe5r866VCiRXZ27oIT
	 1a8flLiwKzNcQG0aaIckjh9NMHf/3zgzFQbwZmdHWFHvYn3X3MvvkFgmA7OEuAsc3NQIT
	 UiU4UYeQ3g3JJGiMNk2crTCAyuJ8VjPsq0zhADbf9u2z1RbwUQEQ2nNpW9vbFXpPMjamJ
	 uAvkDiveAwK2eGfiJE1PxkB0uzjUU77MvxiOFmNcuBBTbWj3VXyCE6Eg3x5ik2NItt+g5
	 nvKXsd8eqTjBEI5jfqVD9Ozy0W4tTA+Jbj/bImvjL2rqbk7R5rehf87vKevFc3JfZ3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FZJd9z0Q;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GDXkEAz1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C86606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71C86606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FZJd9z0Q;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GDXkEAz1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795609499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5xzegGZPsdIxHP9LJiqbW2AnSoxon5CqIeHJswRAEI=;
	b=FZJd9z0Qn2ANrB2Xp1n3gLSBRtR+4K2MSCNbDjmXJoX//FxCPOXS2VnML5nEHs5whk7M/Z
	YC+f0vzQ/Fr8AHgfwr15OiMXrKaC9OVS1E2Vdcln5CDlT0TTrBJF4NLVCeJwoO7TTI14JD
	JjnOqI6XfSW/6A6o0npXbsJEb2+UBf4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-H4tGpD2lN0ei_ekjx3uCog-1; Wed, 25 Nov 2026 12:24:57 +0000
X-MC-Unique: H4tGpD2lN0ei_ekjx3uCog-1
X-Mimecast-MFC-AGG-ID: H4tGpD2lN0ei_ekjx3uCog_1795609497
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4bb66fc3aa6so48916415e9.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 04:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795609497; x=1796214297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k5xzegGZPsdIxHP9LJiqbW2AnSoxon5CqIeHJswRAEI=;
        b=GDXkEAz1WFfOodu9YtuZFM9zjDnaJt8auG6C4tmZ2GCiyj47hLeZaB6D+sIQM1hBsG
         aPAiWnuCoyHu9NiymN+ZYE4gv8+pg1Nv7yMwZANXRs0zh+Xy9VOvUBqRc8kU35IcASBG
         DZF4adsuxPg0ehojbKQDqeVA1x0YavY44Zu6dPl6p7IXiaJ9+lRUNP+3RgMfjHpTFknV
         uzVqVLUodGAmOalUEAogybU4yoWEKSLONA7bDSrCiBnT7zD8N+iTeiItq2N0zvRTNA7m
         6Cz+rrmYe9G6n7ti1Z75qfKJ2HBKP/Ay6GbxdDW7botTO32FYtoeRs7dTrDCtsuqbSOJ
         tMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795609497; x=1796214297;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k5xzegGZPsdIxHP9LJiqbW2AnSoxon5CqIeHJswRAEI=;
        b=XYaTM72zdaXhRzwPtoRRqOFQ5j5FYmX+UjmBQIw03ir6OypB26mnjqQi2r582eeBux
         kBsPWxPic4eSbvcaWMjOwUmDSiTk485K6IkO3Mu2MhWCmAV2OCziZNADX8wC7ka38kmM
         xGMddTC+nwx88/HKurE6eaY2L7+BA7YBQ3tHUA+ZDDtKth/yc1LsefUmZRTAtTwnOT2Y
         dDiwiW7K6/dp9QBeWWsnVt3Onl1+pZcVdMsw/j1CxTFVU7BsrErPPiduaVKRlXX0NYGH
         WehfS9up6WXX+Uq+0/5dt+8XG6MOtBaeRt0dXmDA+5WLMfjWSn2NabcGDSpmo2rwmwo2
         7OUA==
X-Forwarded-Encrypted: i=1; AL+hErFN7Df9MumBTk9JxLtBSHmWMq+gvK48ABkBQIkp3LXy0PKv5q/v6cEzSBZEnB8kf/Avwi+7dO4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qtWooug7dq+AIExVjSMvAA7K80uWrzYlyBKIzKyfatERMzHAQ
	Mtnme+w5qTNU6S8vRCmlxSHY6eWv+wdVnAnmezkQaqmAkzULzunYQRKTEJ72ZY2DQUQRwwMKDl7
	nvLIVZfBFGABVbYaL6ES190zTiulJiQp0fXNw71ugITKpF7rtVC3pJxR5vA==
X-Gm-Gg: AZFdTZf4n6umtyKap2Yw8074DpAZX4R19HyYcgorgS7iTxr1mxswYrdnfcv4RCC7eN7
	2EkKjv0lUwJZYmTSb1wwY7bTHxFDQkgP9jZpuBRT+zXU0w8AqUP42wtTgPpfDR/IZYQDjdB09bs
	Ac+umCZt9HhuRKUSEjAAZJ/6e4jIwfNpH9kpGLQyBR2WaxUP/P7KCpQuJJU2KSzp1HlKmPM4Y3C
	QrYj7YYZgW+B2sTbxVqZsgKqXJL+vYQ+8hgwO4oPeMJNpLLmb6hGGBkalYArGQzA/N8dWaAb/gL
	EYL0ceMtHrTRXQ4OJHFfumPH5+E2cmXU0nlmhUqYb7K8zpOrHy9zth/+eCA7aIjKtqXpRy1qVgq
	89OjmoriBfHFNSlw6PH1wOxBO9nVQA5zDccDlAuJTbQhsxWFzolRGPCyjnUb0syEVwE2060O1Wq
	d7bBaIc8HZobNg1xvJ9ZalyfAjECw2ACBiYyBeDAJF2EEG
X-Received: by 2002:a05:600c:3ac9:b0:4a2:a3b:7aa8 with SMTP id 5b1f17b1804b1-4bb887e068emr376564025e9.3.1795609496618;
        Wed, 25 Nov 2026 04:24:56 -0800 (PST)
X-Received: by 2002:a05:600c:3ac9:b0:4a2:a3b:7aa8 with SMTP id 5b1f17b1804b1-4bb887e068emr376563285e9.3.1795609496095;
        Wed, 25 Nov 2026 04:24:56 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d55sm34078929f8f.5.2026.11.25.04.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 04:24:55 -0800 (PST)
Message-ID: <116dd5f4-490e-477d-a5e2-30e3e12d6a41@redhat.com>
Date: Wed, 25 Nov 2026 13:24:54 +0100
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
Subject: Re: [PATCH net] xfrm: interface: drop non-IP packets before
 pskb_inet_may_pull()
From: Paolo Abeni <pabeni@redhat.com>
To: steffen.klassert@secunet.com
Cc: herbert@gondor.apana.org.au, edumazet@kernel.org, kuba@kernel.org,
 horms@kernel.org, q.h.hack.winter@gmail.com, stable@vger.kernel.org,
 syzbot+d29af9ef5c96a3f5e96c@syzkaller.appspotmail.com,
 Shuai Liu <847807867@qq.com>, netdev@vger.kernel.org
References: <6afdcf01.ca6cd63e.174a34.0001.GAE@google.com>
 <tencent_46F20906773869221623F9FA26275C133107@qq.com>
 <f38e588a-91cc-4ded-a0fa-08f129b1c920@redhat.com>
Content-Language: en-US
In-Reply-To: <f38e588a-91cc-4ded-a0fa-08f129b1c920@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/25/26 13:22, Paolo Abeni wrote:
> On 11/19/26 06:08, Shuai Liu wrote:
>> AF_XDP sockets bound to an xfrm interface submit skbs with
>> skb->protocol unset (0) and skb->network_header still 0 from the
>> __alloc_skb() zero-initialization; skb_reserve() only moves data
>> NET_SKB_PAD bytes into the headroom.
>>
>> Since commit 86de3a1118a16 ("xfrm: interface: validate the IP header
>> on xmit"), xfrmi_xmit() calls pskb_inet_may_pull() unconditionally.
>> For such a skb, pskb_inet_may_pull_reason() selects nhlen = 0 for the
>> unknown protocol and pskb_may_pull_reason() receives
>> len = skb_network_offset(skb) = network_header - data = -64, which as
>> unsigned int exceeds INT_MAX and trips the
>> DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in pskb_may_pull_reason():
>>
>>    WARNING: ./include/linux/skbuff.h:2856 at pskb_may_pull_reason [inline]
>>    WARNING: ./include/linux/skbuff.h:3286 at pskb_network_may_pull_reason [inline]
>>    WARNING: ./include/net/ip_tunnels.h:483 at pskb_inet_may_pull_reason [inline]
>>    WARNING: ./include/net/ip_tunnels.h:488 at pskb_inet_may_pull [inline]
>>    WARNING: ./include/net/ip_tunnels.h:488 at xfrmi_xmit+0x1844/0x1eb0
>>      net/xfrm/xfrm_interface_core.c:534
>>    RIP: 0010:pskb_may_pull_reason include/linux/skbuff.h:2856 [inline]
>>    Call Trace:
>>     __dev_direct_xmit+0x4b6/0x730 net/core/dev.c:5164
>>     __xsk_generic_xmit net/xdp/xsk.c:1288 [inline]
>>     xsk_generic_xmit+0x27d8/0x47a0 net/xdp/xsk.c:1344
>>     xsk_poll+0x326/0x670 net/xdp/xsk.c:1472
>>
>> The packet is dropped by the pull returning PKT_TOO_SMALL and hitting
>> the default case afterwards anyway, so the only visible effect is the
>> warning; reject unknown protocols before the pull to restore the
>> pre-86de3a1118a16 behavior of dropping them silently via the switch
>> default.
>>
>> Reported-by: syzbot+d29af9ef5c96a3f5e96c@syzkaller.appspotmail.com
>> Closes: https://syzbot.org/bug?extid=d29af9ef5c96a3f5e96c
>> Fixes: 86de3a1118a16 ("xfrm: interface: validate the IP header on xmit")
>> Cc: stable@vger.kernel.org
> 
> The blamed commit is in the current release, Cc: stable is not needed
> No need to resubmit just for this, I can drop the tag while applying.
> 
>> Signed-off-by: Shuai Liu <847807867@qq.com>
> @Steffen: looks good?
I forgot to mention. Since this is one of the very rare regression we
have nowadays, I would like to have it in this week PR, taking it
directly via the 'net' tree would help. Ok with that?

Thanks,

Paolo

