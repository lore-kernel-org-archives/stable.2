Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716211;
	b=Wjnn4kuz/ZHcQJaGj7t1QucaOvDMpETQ9LRWzADPdsPoA0KeosOZTWUdj2TgU40n6gJN
	 n5clZiZkAvtpTOenYiJ4Ma8SNYjwCTOuqWc2XX8507e34bjjKNf49eW8lqTxgapsnAR2q
	 paRrnzWPS9ZT3RJZ0gFMhtcpe+6GwZPZxUs4ElCDMWk7ptc2wobjZw/lsym/2zS5wlmEi
	 tA7CZRQLvfvCR6RuCytNAUO6KfwdfZVmbkA2DvCMzRsf/N96Irabpplec2tByCdEE1P3D
	 I/Pa5uWbKkGt5pryPdoVe1/cmJnJqMoJbA81dnulgVKXCs3Aih7nZGK70BkAlYyO1Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716211;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QZoRZXNiQ8NMox8dMfPzA0JIR2VNAclAv16pLDyluUM=;
	b=I5db1EjM3R7t/TN9Owjb6eKY1dW45b8XwJG3zUWbx2QTranE1I4CckraTPzzZUtdccXx
	 BRwTfJrjpSD09d97mCstPzaZYFb0qnpZhLsU/1/TjdsF6itchKzZXQLO6sY4KPGUyUynl
	 8WzV4o4wEllLG6Nbsk/wJD8G9LLD+2y86tEIl7ffnirF7yuz64yjBaO6vttSbDWlfHnNX
	 NDbK6j9kYWWGh83kJRNzbZpIjebhFvcI65oCw9nSYLq1Baxo6Ry66McJJjDtDJhqcZ4RI
	 PL1vxiCvIP4/MYVcV+P/5AmOr6UUHTWAnOGV/9lkusERxEUvQ7aHe54ll4hWmekfqog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FBNsknNt;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="An/1mhTx";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5627F606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5627F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FBNsknNt;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=An/1mhTx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793716210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZoRZXNiQ8NMox8dMfPzA0JIR2VNAclAv16pLDyluUM=;
	b=FBNsknNtA/R5IgcwfTqSpeUm2FzPxIG7Y4OOVvK1ZTxZ0GfpUv6n+prtfEg2lGU8puxxt4
	QnASUmWwIKL/GuTeQJk+lqqaHosbWezCjysDI8NN4AhFZNs/YAU9s42SRTLjNWgCJNfHIE
	whC2PtOl3MGSbvdKo6OPGzrWcdDaEHw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-9WLoTtoQPQyI4dNJK69cJg-1; Tue, 03 Nov 2026 09:30:09 -0500
X-MC-Unique: 9WLoTtoQPQyI4dNJK69cJg-1
X-Mimecast-MFC-AGG-ID: 9WLoTtoQPQyI4dNJK69cJg_1793716208
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a359b714f8so39102795e9.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 06:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793716208; x=1794321008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QZoRZXNiQ8NMox8dMfPzA0JIR2VNAclAv16pLDyluUM=;
        b=An/1mhTx7o7BX+UorF1AU7kcxWxKNTnW/1oqLstkJkHGs0YlUIwtDLBVA4l8ED+1nj
         jnG76CqHJhXS56Qq/8h7zZXckndGf9+xNZD9u5eBtkYTqhleVHd5TFRsH8SIR2UqA1cP
         bfcldOOYesYBPUbYuLFpH2jxtUCF+fpVGlOPEQp4MjcKHLZV6/9pivT7vUtKlD5aE2C7
         VKAKL7AGuRD+/1clx9Yw5iXqGCSCHaHN8RU4ZFolRoGpYVW4YjA+/1A/7ncE6wC/WmP2
         j30IG7mfN0Rb59udcPLU97fbwCRXJv4WWi52MEx4C5zNrGTWD7TRoSMLpEegMr9uhMBo
         Yh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716208; x=1794321008;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QZoRZXNiQ8NMox8dMfPzA0JIR2VNAclAv16pLDyluUM=;
        b=JkRVZjX48U4eR1r1t0xpFATQ4KHXkRrDy76aYa7b0RB/NHWaBdLv4iKDfi2JQzYVOs
         aVeNm/xAWHdaS2OdRq1jDl+TFY627rg3D/yqnxpzyEQN1FswA7tm5cvIrxmOVv4AMr4g
         gEhGOTBdQzGCKom+73m7V+EX7aU5PEcpqHg1feEoOboOnEiiTJG+4K/g29ftzfv/Q4b7
         5dwlriJyjF44i7ms/bPChtYyaKyEMxzTrfi015y7jtbB8nNZJO34TUvI7s7UZZLxcWN1
         5k7B8tYbZR01pcj0dSrFGRJkg1Ij9/Bg6/fyjZgTSzrXp6WCUSDhQEkWU3JDgxnSebnK
         +dOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwJ/9Y4Yv96sKG5M/u9jAv0FxHdfBfSVWzT2wjJu2JYSjD49Vm6wgw/RvgKO5fbo3p743K6ZSw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wUiFcgd0ju4Y3S2x58m9BGJM/Tswx6MMAe4eEor3IsARfk24J
	8eROJv7odsDVCEm2JoEr3F37Sfaal0H+AJG6g/MCDXBEFeOZVMYSk04eBj0iqImcKPytzkBvl9I
	AhGjOC9uocwItGaBBxWlAvvhIhDgRRlPNLhEu4AVNC1pR2rmRmJfzjBxpyg==
X-Gm-Gg: AYBFou1RqppIfBq5Cp3kQT2+N5W19+7aOlC3isQHxR3zKJi2fTTDJ74FUonrhFeKuC0
	Pd2hs+xy+dEI2msPp5F32CDGkZbzCZcreS5UUZpt+Vl5bj3yltSh7ayVKVD+a/hTraevA873/Zt
	PJgUA1+S6ZdrO4I8CKpBSCab3RgAzbqyz0YX8lxiP/H4abxroyd7uczyuTYJh6qrgVboWbbqHtH
	SMBbiFpFMiaJ1a3ljr+cPbe6kbcBViOvxAqvCaRIOtI16oNHeySA8GyGXUfVczImQ3SLJfbqbYJ
	jggFziR6+cTKWvV5fDNiGkrKpJWkOkOztQHT4P7Nuip5Y/NhBIO/cKEJRbqxGqbVmmlkBIOfi47
	R8KatD7Wf8iF87WoxWZBVqMfSQyUi2L5H+pitGlnKYZ0lBptMnlUSpLwc2ymNePOvrHVEazC1xX
	HDrIlNPmNSz23t03ND7cT+KEV0i2ap7TtJp0u+rmUGhKE=
X-Received: by 2002:a05:600c:3ba5:b0:4a2:a6e:80f5 with SMTP id 5b1f17b1804b1-4ac16fa356cmr365438585e9.11.1793716207479;
        Tue, 03 Nov 2026 06:30:07 -0800 (PST)
X-Received: by 2002:a05:600c:3ba5:b0:4a2:a6e:80f5 with SMTP id 5b1f17b1804b1-4ac16fa356cmr365437535e9.11.1793716206907;
        Tue, 03 Nov 2026 06:30:06 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09bcc967sm258052195e9.3.2026.11.03.06.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 06:30:06 -0800 (PST)
Message-ID: <0ce94ca2-e742-4b97-b704-1ae24da7b41f@redhat.com>
Date: Tue, 3 Nov 2026 15:30:05 +0100
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
Subject: Re: [PATCH net v5 2/2] net: restore refcount ordering for lockless
 socket access
To: netdev-bot+sashiko@kernel.org, imv4bel@gmail.com
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
 sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20261029214219.1035176-3-imv4bel@gmail.com>
 <179365718192.3131.3817815695107204474@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179365718192.3131.3817815695107204474@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 23:06, netdev-bot+sashiko@kernel.org wrote:
>> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
>> index b0239d203f045..860145d810ed4 100644
>> --- a/net/ipv4/inet_hashtables.c
>> +++ b/net/ipv4/inet_hashtables.c
>> @@ -550,7 +550,7 @@ struct sock *__inet_lookup_established(const struct net *net,
>>   		if (sk->sk_hash != hash)
>>   			continue;
>>   		if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
>> -			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
>> +			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
>>   				goto out;
>>   			if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
>>   				     !inet_match(net, sk, acookie, ports, dif,
> 
> [Severity: High]
> The commit message says the change targets lookups "where the socket is
> validated again after taking a reference". Should the MPTCP token lookups
> be converted too? They follow the same pattern but still use plain
> refcount_inc_not_zero():
> 
> net/mptcp/token.c:mptcp_token_get_sock() {
>      ...
> 		if (!refcount_inc_not_zero(&sk->sk_refcnt))
> 			goto not_found;
> 
> 		if (READ_ONCE(msk->token) != token ||
> 		    !net_eq(sock_net(sk), net)) {
> 			sock_put(sk);
> 			goto again;
> 		}
>      ...
> }
> 
> mptcp_token_iter_next() does the same thing: it increments and then checks
> net_eq() again.
> 
> mptcp_prot uses SLAB_TYPESAFE_BY_RCU, and mptcp_sk_clone_init() clears
> SOCK_RCU_FREE on established msks:
> 
>      sock_reset_flag(nsk, SOCK_RCU_FREE);
> 
> So an msk can be freed and its slot reused while an RCU reader still holds
> the address.
> 
> On weakly ordered CPUs, can the token and sk_net loads in the re-check run
> before the increment? If so, they could see the old object's values, and
> the lookup would return a referenced msk for a different connection or
> netns.
> 
> Callers include the userspace PM netlink operations that look up by
> token, MP_JOIN handling in subflow.c and syncookies.c, and the diag and PM
> iterators. HMAC validation would probably reject most of the MP_JOIN
> cases.
> 
> mptcp_subflow_reqsk_clone() already uses refcount_inc_not_zero_acquire()
> on the same msk objects.
Even this part is better handled with a separate patch.

/P

