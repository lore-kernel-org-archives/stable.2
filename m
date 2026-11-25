Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609366;
	b=14DJ6wEgvmrmOOywmNjrZuZM4gpiPPKw6/xnRRb3Aet/c3pc4zrRN3v1jg2czPirb+j1
	 mrNOLHFIglU4J/tB0EBdKtQgdE6ut2yLXu48No0YgKYsLKrR6mkL5QZaS2QSUWzX5V5Ed
	 qRPDiwJa0b6i3oooy7/pzd3mhlitPfU3HtUPCu3y0TxiBGZuNEqihxNyptzd/rIiRt39K
	 fnkUVIrC/70xhfbhk2pIz6Lz5TjBm5znQX7ZnTF8UHaL/OIWx/YkEIk9RCZ48jHZhAVBs
	 DEfqTQ84jmtMqJykODZYJfM02U8KXaZrHFKAvS1qdZqElz4ls31WyC0/kcfrE7CKQQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609366;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=CZV5eO5AZ12TcnUy3EmQ/L23MOch/Kx8q4CcdxzUn9c=;
	b=knJOMUuZulQ3dNImQ/y6cDIS1RI/J48hGhJeImZxYNLY/zuvLC012ANysUVZHcfaPwEz
	 frM9+Qi17N+fuXWV7ouov8KFJptO4T42bUuuhgl/EsTtVdH3Zl5SXfJ5NBl0vbJLFGCcu
	 UawNXnU5tGisJ2+O39mjjHdeO+8KKPN2qnXLldo0JLEWk1Bl+LJCUJg709L8h4jfeb2J7
	 PPbpLYWMHVXZuNZP5YDV1ZqxNo/oWzpo7X8YVrrjO+fyuZ97oVL9QU6DWFWwSN5EfmmBN
	 Xed4W4EsRsozp7G+52Qy/jZqYv9U+7fQ3p93/YE78zvNs3iOQ4ax57EuMCTtbSxhgkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YUdd4OHY;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hG0VIAY7;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FFA606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52FFA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YUdd4OHY;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hG0VIAY7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795609365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZV5eO5AZ12TcnUy3EmQ/L23MOch/Kx8q4CcdxzUn9c=;
	b=YUdd4OHYyXuF3XZ1lqbyV6NxOtG3Mgm+VxbEtoYM0w6ABc2plOIz4I7Q5zeEhAci60LzUr
	JytDj+skCxJhhKEu5ecZK5P1SytqEak1zoZAwZH+B6ohaYI3fwr8WgoSH4CpTJulAisfbQ
	hXHhooJUwYTGtCrcA/gUN1FN9ZM4iIQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681---1BF1MjMbmsvq64v0R93g-1; Wed, 25 Nov 2026 12:22:43 +0000
X-MC-Unique: --1BF1MjMbmsvq64v0R93g-1
X-Mimecast-MFC-AGG-ID: --1BF1MjMbmsvq64v0R93g_1795609362
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e0461e040so4500827f8f.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 04:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795609362; x=1796214162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CZV5eO5AZ12TcnUy3EmQ/L23MOch/Kx8q4CcdxzUn9c=;
        b=hG0VIAY72+57Foz+yeCF7uxl5isVyplN/asAJxrDoEajDwbTu58Dj1L3TMw2pwTXXS
         fluvd+Nt14nM/GIsNOGrG9CFVU/YOzThRQxALInxci3cfC6qW8Dp36uryBIc34Jxwb/2
         xj2VTTH9qaf07HAYy/76nrPGBItaYEhVayIvbl38wJi4z6sZdt7M12YkJCEwP5MxDG9p
         Y1U4rhxFrJ/pacdTotJUv5My8ZCXPkjtffCHd3ap6KnrGbbt1N6qlD4F71MnPz6MqaOp
         7fQkHRbqqC69rYdjwH+KX47z9q84O6cNKIf9S7bAtqJZy8/Wyes2ResE/GlLfwrBUYr3
         LgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795609362; x=1796214162;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CZV5eO5AZ12TcnUy3EmQ/L23MOch/Kx8q4CcdxzUn9c=;
        b=pU+iG9q6PtY/xp6DJA4+f6CJ6I/1KJfexDURq8avP2Wqr6ADJ16HevHbhEJcln0484
         RACt61O5M8ysF5fHWX0YpoWwoVEFuzU9nDDfwZl93SHMFn8wGXAzK8O3hDCs5YAeCrHm
         urx2zPYF3SrFkPdAgJYVMputsFn5yrIPUq6lKbdLdzZgbpMsZ3pPwQPVJQqJaavm5Nkj
         z7MnGjjGy9DJNX6ll8Kbg27kO3SAKRXCj7/68bH7cc36XEJxe9t2abwTFzDIfKkqu4Si
         Vjhy+hEdRv1lJvkPE0WvVM+QLB5kmUpS50RKAGog4TIFFxzduC3z/16ceb2/8OOSNJYZ
         dnlw==
X-Forwarded-Encrypted: i=1; AL+hErFov+uD/QwEGKhnzIn/hxjTq9fCDaa7fWGif8UVJWX5Q7MO4TNST/i3CILbAHU3DoUzdU7RI80=@vger.kernel.org
X-Gm-Message-State: APuU4Z/su4+OHch8RVrJkpIDo1+8IlL9ZQApxL6iJK6HzCqwkfftQdGu
	9KRglLC+mz2xGs+4eVhhl/Nn2Afq1/BAgQ6KcSStQIIricUDJfHuaDFDJ+My0tyT5ed9IgPEvUJ
	tHCz/NIaAkvGwDUDKk1DOxA7jGPsAjTB/eECRP1chK2PwVuLp7b9CvsCZJg==
X-Gm-Gg: AZFdTZc1CekBnOCnGK++qTuzDDATrMwtP0q2hrD1nHvxn6eiVQwgsDdUuQ03sPTZmDh
	SALa4GyzwyYnDFt02op1gmJheqoZvJztYcfyc/2hj6N0EiEzT/xfLxLxRM2MDhKL+d8ItirH5of
	LBphxwOGyY9YmeqS+m+caaqUP2cPygVaOV9rNME/7ZO8rQAyIaAEuN1vTnUO6r4VYdiRFiG0t1F
	H/qzJvjPcxQZtfiOtW/LdO7+4iQEnhJfe2rNAcMJc5yGgANgOwJ/SCJozGamRMi9gxpaWgd4GW4
	gqd1VBw7Bs44qlQYezrSkAdr55l3+kOfzpSC3mSX5MtIe3Fi4rFW8bx1UsEW5S96jg7gnL22z9m
	uRAhJxez/CxP+03S1zixU4fNMrud/5Unl3OJzZn+Np6fWkQFFFfZOVIwG9mDnDDNx2Jr6bIzjCJ
	I3UBxn+6aEk00FiisSE2pRIawJAjcCfxTr/dkz8TLwOQmN
X-Received: by 2002:a05:6000:2b8e:b0:491:45bc:d69a with SMTP id ffacd0b85a97d-4abb3f158c5mr23350972f8f.44.1795609362102;
        Wed, 25 Nov 2026 04:22:42 -0800 (PST)
X-Received: by 2002:a05:6000:2b8e:b0:491:45bc:d69a with SMTP id ffacd0b85a97d-4abb3f158c5mr23350937f8f.44.1795609361608;
        Wed, 25 Nov 2026 04:22:41 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa3c4dsm28560787f8f.46.2026.11.25.04.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 04:22:41 -0800 (PST)
Message-ID: <f38e588a-91cc-4ded-a0fa-08f129b1c920@redhat.com>
Date: Wed, 25 Nov 2026 13:22:39 +0100
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
To: Shuai Liu <847807867@qq.com>, netdev@vger.kernel.org,
 steffen.klassert@secunet.com
Cc: herbert@gondor.apana.org.au, edumazet@kernel.org, kuba@kernel.org,
 horms@kernel.org, q.h.hack.winter@gmail.com, stable@vger.kernel.org,
 syzbot+d29af9ef5c96a3f5e96c@syzkaller.appspotmail.com
References: <6afdcf01.ca6cd63e.174a34.0001.GAE@google.com>
 <tencent_46F20906773869221623F9FA26275C133107@qq.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <tencent_46F20906773869221623F9FA26275C133107@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/26 06:08, Shuai Liu wrote:
> AF_XDP sockets bound to an xfrm interface submit skbs with
> skb->protocol unset (0) and skb->network_header still 0 from the
> __alloc_skb() zero-initialization; skb_reserve() only moves data
> NET_SKB_PAD bytes into the headroom.
> 
> Since commit 86de3a1118a16 ("xfrm: interface: validate the IP header
> on xmit"), xfrmi_xmit() calls pskb_inet_may_pull() unconditionally.
> For such a skb, pskb_inet_may_pull_reason() selects nhlen = 0 for the
> unknown protocol and pskb_may_pull_reason() receives
> len = skb_network_offset(skb) = network_header - data = -64, which as
> unsigned int exceeds INT_MAX and trips the
> DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in pskb_may_pull_reason():
> 
>    WARNING: ./include/linux/skbuff.h:2856 at pskb_may_pull_reason [inline]
>    WARNING: ./include/linux/skbuff.h:3286 at pskb_network_may_pull_reason [inline]
>    WARNING: ./include/net/ip_tunnels.h:483 at pskb_inet_may_pull_reason [inline]
>    WARNING: ./include/net/ip_tunnels.h:488 at pskb_inet_may_pull [inline]
>    WARNING: ./include/net/ip_tunnels.h:488 at xfrmi_xmit+0x1844/0x1eb0
>      net/xfrm/xfrm_interface_core.c:534
>    RIP: 0010:pskb_may_pull_reason include/linux/skbuff.h:2856 [inline]
>    Call Trace:
>     __dev_direct_xmit+0x4b6/0x730 net/core/dev.c:5164
>     __xsk_generic_xmit net/xdp/xsk.c:1288 [inline]
>     xsk_generic_xmit+0x27d8/0x47a0 net/xdp/xsk.c:1344
>     xsk_poll+0x326/0x670 net/xdp/xsk.c:1472
> 
> The packet is dropped by the pull returning PKT_TOO_SMALL and hitting
> the default case afterwards anyway, so the only visible effect is the
> warning; reject unknown protocols before the pull to restore the
> pre-86de3a1118a16 behavior of dropping them silently via the switch
> default.
> 
> Reported-by: syzbot+d29af9ef5c96a3f5e96c@syzkaller.appspotmail.com
> Closes: https://syzbot.org/bug?extid=d29af9ef5c96a3f5e96c
> Fixes: 86de3a1118a16 ("xfrm: interface: validate the IP header on xmit")
> Cc: stable@vger.kernel.org

The blamed commit is in the current release, Cc: stable is not needed
No need to resubmit just for this, I can drop the tag while applying.

> Signed-off-by: Shuai Liu <847807867@qq.com>
@Steffen: looks good?

/P

