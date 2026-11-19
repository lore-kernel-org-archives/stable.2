Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090212;
	b=vSg41B7Q5vIBIgG8SLILY8xLV9SkwG3IgaowUnvPn090PyNueONXBbIFzkjUHysLgjRi
	 Jrhfhe1qYiaoNOiYg7Lg1KFXHxSRXi/QoAleUzbMbBL3W3+T3gRkODluQrn/F4O+5L8zQ
	 APtzBmiKeO38hzqqKFHPYteNkMCey2H3A9tr16BiB5wuAc5m/9jBf32Pr/+8vOzgYJ1fc
	 twacSSMecXwtX6bduSX3/pMukniu+Odv3WOl4/EWN1+77Agx4NtuTkGZ+KHGf783bbE3x
	 a245b35hdTaSksKGC311qcB122A0LKTfqs+ZiueAxv6NqzDEQRkTQdVqngJKCGX95xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090212;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qQHDqukiWt3gb3Ynjw1ioSPmavArdSzM8YrNLICeLOU=;
	b=PCmI+STpUWBLw+bweKlD0nQSFdLLe9Ddf012BzgybO5FVkdAcRhRoSdcqP+5PVrUj65Y
	 MF7A6Dix15IiBYEG9vz8xcC6wbQySAqshA98B3s4CwxhiwDpm11ZRyXL6bI82HE3hpf2o
	 z1JLiqKIJ+EpjfQHxpHm+3hY/mlthVmoblQ+Ozs1GZzqhZtGS1XcI/hmEWEleBbDOAW0q
	 n+5kotrV2vQP6Mz37CJ4agaUg7Yafzkk183NWqsBeew6rIwd83wp7YOFRVLpXTXOtcX0l
	 oHK39jl4iSe7GGEusIAXV6bHNGPF0DvOWQ4hjVsXdhGgo5Dcj6+xVdJucsK96vvV6Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Lg5/SkeO";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=enT6gHyi;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA17606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 12:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAA17606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lg5/SkeO;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=enT6gHyi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795090211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQHDqukiWt3gb3Ynjw1ioSPmavArdSzM8YrNLICeLOU=;
	b=Lg5/SkeOimkPIj9Fmwp+3GdONO8LMzytwBkUmBAw3hXxRdf5nQCIXwPpYrpkPdXG0tp87T
	5Mmg3F+p8+3w96b5kiOq+cVOLoeiWx5cmfZS0Gh/w3VJREu/75riz6+qlIMiesnfeIHwjk
	MLsUjMsMth8WrmQqPbtVOppjwQnGsTU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-RHxEZPYkMJuwznyUrQvqyA-1; Thu, 19 Nov 2026 07:10:08 -0500
X-MC-Unique: RHxEZPYkMJuwznyUrQvqyA-1
X-Mimecast-MFC-AGG-ID: RHxEZPYkMJuwznyUrQvqyA_1795090208
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a20e41008cso15436425e9.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 04:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795090207; x=1795695007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qQHDqukiWt3gb3Ynjw1ioSPmavArdSzM8YrNLICeLOU=;
        b=enT6gHyiTTDIHuEHIcbXbD6ZRAxu0Hr/IhGwQiwoPz9ukkQjjIIz5uwjM8vD+ayo4J
         5miR37R1Sadsm1g5TOCeQovmAxqokwhtl1KLvTztN5IBJK03JYYMHwanzKA6VHQo4lCc
         Ui40cBSKauDvNYUvKPRuD5aTxioMQedVh1WgeH2gq0bxeINMBrp3c0qDFoCtEEBplX7z
         w4SfsjSqzEF6SD/wWCBXre/eYDwe35JLGVVEVMuc7Ber626h4Pw0wbSsl8YCUhe2dPv3
         BGOfbvFv3Qb27q+V2IbJv2tBaBDiuNLycSLWcc6z+Giyn3e9DCOgc4NVGLPqcD8m/iSE
         bX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795090207; x=1795695007;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qQHDqukiWt3gb3Ynjw1ioSPmavArdSzM8YrNLICeLOU=;
        b=ZqBb/O5jIGRtARI7GKRQy7jpaeqWP0aoF5xpzjTEdtTBZFSvsV+J+9UkRjyRglpsqi
         YSLzezu/zWksH+MwlkHh4ZXk121Cvlgj9GNsdxvSTDecAet72i/UCsfIAZMKVI3RsLUz
         iMzUbSvng7RiDq8Rs66/oNzwfiOUOP4zGVmcCje/N0bR/yOoi8e2KRor6XQuSAbia0Gd
         CNe5Nxb06NcvziSh4IYMvE2VDiAl3pfT2tIWXUovf7ayK+mfyivTMXghZWFDoWPiALWs
         uUSPvRodW9jp5saBak4cRcSWuGflPYMnZ4CXjArcOvrAe51FX7LFmJ4WDr+Lbw++Tgox
         ibnQ==
X-Forwarded-Encrypted: i=1; AL+hErHf+7d6PtZJqsueYPAk2tMaekdcJDdNIksyyuZywH01wzbz/EqjaXSV3YLNe67mga1g8lg+z7s=@vger.kernel.org
X-Gm-Message-State: APuU4Z9djkn+iXGTusCJF1k81dSVbPnC8BDiHbciXmzQ/X1PL6xWivBH
	xpwfEImDC/dlze8GKw6SMVMCHOSI3kRrkjGN/0KCxsUygcPX0/6cIr2CNbTliHWQldYihNPCrog
	lSHoa1pULP12cFLizuYE7jBy+ulyYcSRUiaYJzV5igZQPby/L+oTwZGiO5w==
X-Gm-Gg: AYBFou0CEGvyyVZc/vXjYXLt33uCgdUhwrVM4CZcbkp8VJuSHgGxzTH2NDlYRULJhOc
	ctenubEE1NuaU4tlHH3zjjLjZzDtWwWvE6YW1usApWS1e5GMqc67EvFtnHF83lgIaIzHtR36K8S
	XwX6tKYV97r4kDjVnlp/nBSg1T3JLPPVp6KYXCbsicJ2Fx72NUNFhswDghUnPNEfty98xNlNP37
	3HNlPKn4mEOmrsX7jOkgQDIshAaPlWu41udlqatd8YlrzATZnmC19DaZvm9yy0u83cz+u+nEJFA
	QtRYOJ8uB/2qQBqX2szONWrXb1S6T5a5yqJyUJUknbss1CaRm6WAxD2dVpKNhGf+HmqiAgwk1DH
	nBux30MlPSgdvLUa/REbJWwYMoUMRWHPOOx9CjVHXpN79phXXm4IxihyER3GvdaOjAAFA+dNpye
	JbBz4Z5vi6Z6uHcikkWz9BxxE242WMcaFFgpB0jpUsp7Ok
X-Received: by 2002:a05:600c:470a:b0:4bb:6fd3:5ac0 with SMTP id 5b1f17b1804b1-4bb7da2b98fmr114021185e9.28.1795090207491;
        Thu, 19 Nov 2026 04:10:07 -0800 (PST)
X-Received: by 2002:a05:600c:470a:b0:4bb:6fd3:5ac0 with SMTP id 5b1f17b1804b1-4bb7da2b98fmr114020285e9.28.1795090206926;
        Thu, 19 Nov 2026 04:10:06 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb84e4df2bsm30559485e9.3.2026.11.19.04.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 04:10:06 -0800 (PST)
Message-ID: <a1b7a992-3bed-43ef-80bd-a76cc697f58f@redhat.com>
Date: Thu, 19 Nov 2026 13:10:04 +0100
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
Subject: Re: [PATCH net 4/5] sctp: use skb_set_transport_header_careful() in
 sctp_v6_err()
To: Xin Long <lucien.xin@gmail.com>, netdev-bot+sashiko@kernel.org
Cc: edumazet@kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 willemdebruijn.kernel@gmail.com, marcelo.leitner@gmail.com,
 aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 daniel@iogearbox.net, justin.iurman@gmail.com, linus.luessing@c0d3.blue,
 sd@queasysnail.net, sbrivio@redhat.com, imv4bel@gmail.com,
 netdev@vger.kernel.org, linux-sctp@vger.kernel.org, dev@openvswitch.org,
 stable@vger.kernel.org
References: <20261113124625.4010206-5-edumazet@kernel.org>
 <179484404697.3136.10852363970744263229@kernel.org>
 <CADvbK_dKiTF4gSjsRuVKUDVTJn-EVVvunmhOOEGyG7Bt6jjeVw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CADvbK_dKiTF4gSjsRuVKUDVTJn-EVVvunmhOOEGyG7Bt6jjeVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/16/26 20:20, Xin Long wrote:
> On Mon, Nov 16, 2026 at 10:47 AM <netdev-bot+sashiko@kernel.org> wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 0 · Medium: 1 · Low: 0
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your reply
>> (one such reply per series is enough).
>>
>> - [Medium] The main part of this concern is fixed later in the series.
>>
>> --
>>
>> sctp: use skb_set_transport_header_careful() in sctp_v6_err()
>>
>> sctp_v6_err() now stores the ICMPv6 inner transport offset with
>> skb_set_transport_header_careful(). If the offset does not fit in the
>> 16-bit skb->transport_header field, the ICMPv6 error is ignored. Before,
>> the offset was silently truncated and sctp_err_lookup() read the SCTP
>> header from the wrong place.
>>
>>> diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
>>> index 97390569c4bdc..ad5c951efdf06 100644
>>> --- a/net/sctp/ipv6.c
>>> +++ b/net/sctp/ipv6.c
>>> @@ -170,8 +170,11 @@ static int sctp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
>>>        /* Fix up skb to look at the embedded net header. */
>>>        saveip   = skb->network_header;
>>>        savesctp = skb->transport_header;
>>> +     if (unlikely(!skb_set_transport_header_careful(skb, offset))) {
>>> +             __ICMP6_INC_STATS(net, __in6_dev_get(skb->dev), ICMP6_MIB_INERRORS);
>>> +             return -EINVAL;
>>> +     }
>>>        skb_reset_network_header(skb);
>>> -     skb_set_transport_header(skb, offset);
>>>        sk = sctp_err_lookup(net, AF_INET6, skb, sctp_hdr(skb), &asoc, &transport);
>>
>> [Severity: Medium]
>>
>> This covers native SCTP. Can the SCTP-over-UDPv6 handler in the same file
>> still hand a wrapped transport header to sctp_err_lookup()?
>>
>> sctp_udp_v6_err() is installed as encap_err_lookup. It still does an
>> unchecked 16-bit add:
>>
>> net/sctp/ipv6.c:sctp_udp_v6_err() {
>>      ...
>>          skb->transport_header += sizeof(struct udphdr);
>>          sk = sctp_err_lookup(net, AF_INET6, skb, sctp_hdr(skb), &asoc, &t);
>>      ...
>> }
>>
>> A later patch in this series ("udp: use skb_set_transport_header_careful()
>> in __udp6_lib_err_encap()") makes __udp6_lib_err_encap() store the UDP
>> header offset carefully. That check only makes sure the UDP header offset
>> itself fits and is not U16_MAX, so transport_header can still be as high
>> as 0xFFFE when sctp_udp_v6_err() runs.
>>
>> For a UDP header offset between 0xFFF7 and 0xFFFE, adding 8 gives a bad
>> value:
>>
>>    - 0xFFF7 becomes 0xFFFF, the "not set" value. With CONFIG_DEBUG_NET this
>>      trips the DEBUG_NET_WARN_ON_ONCE() in skb_transport_header().
>>    - 0xFFF8 to 0xFFFE wrap to 0..6, so sctp_hdr(skb) points at
>>      skb->head + 0..6.
>>
>> In the wrapped case, sctp_err_lookup() reads vtag from the wrong bytes.
>> sctp_v6_from_skb(), called through af->from_skb, also reads sh->source and
>> sh->dest from there for the association lookup. When vtag == 0, the INIT
>> chunk is read with skb_header_pointer() at a negative
>> skb_transport_offset().
>>
>> The commit message says "Should the value be truncated, sctp_err_lookup()
>> would read the SCTP header at the wrong place". Would it make sense to
>> also check, before the += in sctp_udp_v6_err(), that transport_header +
>> sizeof(struct udphdr) fits in 16 bits and is not U16_MAX? Another option
>> is for __udp6_lib_err_encap() to reserve room for the payload header.
>>
>> This needs the same large skb->data - skb->head precondition the series
>> describes, and there is no reproducer.
>>
>>>        /* Put back, the original pointers. */
>>>        skb->network_header   = saveip;
>>
>> --
>> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113124625.4010206-1-edumazet%40kernel.org
> 
> The new skb->transport_header is used by sctp_hdr(skb) in af->from_skb()
> in sctp_err_lookup(). I think it's better to avoid changing
> skb->transport_header by passing sctphdr to af->from_skb(), which also
> makes code cleaner.
> 
> Hi Eric, you can either continue with the idea, or discard this patch and
> leave it to me.
The rework looks out-of-scope for a 'net' target. I think it should land
on net-next.

And I think the missing sctp over udp call-site could be a follow-up.

/P

