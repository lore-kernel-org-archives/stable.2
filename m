Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794917925;
	b=OvIk+yyohyUi57e/QlBhT9RatGGQopsBwH9dljvJXW6NiIZt2h2q79qhdItyNYrM60oV
	 prn9MuaMKtJsOu60Cg2ZjQubqhSFmEFA+qopfPP/sDgYecKqmpyaxf5jK+vcJP9jrwsde
	 528antsMOzzEAAh22gH5Q/pJdPOlEO68W8q+9oOKncoAwzOTr14SJcB6+S2xQIA3aJ6lr
	 fKzeyIH+XymYz8Cl+Uh3Pw1HhbBrzN97nvYkuAVOBIp5vR3G7MfmTeW5cJUmVOONZlcWL
	 QsBOeAOWvjAvcMad0z3RXV0lm9T4hhbWcbjWuLwMNVBt9ekqiqIEotprXZv2kkQLxVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794917925;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Saf3SetBsCoiktrO+qd7rI13GSO6x+2RpySl+aH8Vbs=;
	b=a4zKbfS8gWmqis1h67Nz8EFbi7XkzY8vxZOivxRI9v6W5xq+X81Sc25twpScnoG0S3in
	 mb79qJGDoKzitX4r5LWgd+9NJ/uZCbVtvkqjVMakARohXmasHFgOpubIfRG6WdInpMGFY
	 XsREKqhtztp7XI/wuiuEBLsJDCdkT52WD1jQihtERw7kO8vDpaVeqTUg28yPuZdC+BOU2
	 xI7wAI/An3qk69QuOg2B2tvcNMPWDIcYaZ840JPoK5R/vNNzYjJmpOzW52ANnGKRyNe1e
	 SyN8bVUk7eL7bE2PGAajeLfe23xTT1sOwopEn3VgzUdZoMA2jXeU711aNI1MpBlqLFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YCwEQiFW;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DJte1cMB;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD15606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 12:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFD15606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YCwEQiFW;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DJte1cMB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794917924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Saf3SetBsCoiktrO+qd7rI13GSO6x+2RpySl+aH8Vbs=;
	b=YCwEQiFWTbHWjsu4OneJltDqPuD8WqAFmntn7iNlZdoEcXO1a5+N7SavRmrCj7JpCuPIgC
	lSbQTrCvQ0xGw5Qv+3gxoLAFMfu1mq0rFZRmYbWL/xEwq9F4MI+UBaF3juikYDjpDmalrp
	fBl3FWhHUFUc9QJ6TU7Wfnj6TO3pOX0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-2aTLEYfxNrKDfvqlFbcM8Q-1; Tue, 17 Nov 2026 07:18:42 -0500
X-MC-Unique: 2aTLEYfxNrKDfvqlFbcM8Q-1
X-Mimecast-MFC-AGG-ID: 2aTLEYfxNrKDfvqlFbcM8Q_1794917922
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-492d47f142cso671064f8f.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 04:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794917922; x=1795522722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Saf3SetBsCoiktrO+qd7rI13GSO6x+2RpySl+aH8Vbs=;
        b=DJte1cMBLW/T3asfyNnXTB+vA5G9FF+RNsu4vwogkvGIEHYRHVpKqmVws/WwX+p95h
         HGvglrfAdKzPcUqv2lAAMJfRHhALVdD/odsplvtS2KAITQiD4gcCWy9w+czokKWRl3H4
         ypNtXk6xqSnY5KhxiZsapLW4XxKcyyHbEQsqBAcrVLwPaBgZQgrGNMfWJtjSd6OHHHEN
         AsgDnO+BobaSLhnmWr3TQXod4Lb/GP2zqDVEuUMw9ACS1nzs0kUXrLDiYz8yn3O3vAJy
         2T/7tZnvia9nrSUYyF1UxUxZkEq0Bo8pT31vI0mYahZT+ijuLOkI5khCirO2kqEwd9QL
         Xr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794917922; x=1795522722;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Saf3SetBsCoiktrO+qd7rI13GSO6x+2RpySl+aH8Vbs=;
        b=t0xwi0pyASvAnKYiDT1JPfYrRHoC4mAnrt+UYh5IihhL2FSCs0N5JrYkv6iZp39sae
         fscZe8qa782u9PqH1YRQrzGuKyVtTdWR67QXW2E3HFhz7k+mGyhKirHzs+q0Bye2NwFw
         wx9/GoVPBcEkhduNphhQbRWkSRTeQX4uh86t9DO8dtfF8k5J3Btv9lZAgAU504j0QnUN
         3M8k3I8wZDDncmB2X9WpWOS//Qtuhh4PTFszS8GrM/TmyrUcx0VITuhurRJULMl6x5jR
         ISJ6l01iR2GpeMH/04DdL0VvGY+PToXaOUqmp+DB+cYvsNnabrIVyKNXxP1MYZoE9VYq
         BrCQ==
X-Forwarded-Encrypted: i=1; AL+hErEpvw8xFOvlvoYV156/bMNd9+GvXMyU7VBBdp1P72Njo5h3r80VtigNRwZL5k0Wt5B1nDnm4uk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HHN3UHqnbqr2eLCD12a7QWNlJC1HHhjUqB/eSyZVGTyu+mBPz
	nK+Uv/zQ9F1tbmm6a7QymE2LLOlGQDKwZJDMQ/yPF6owDFYfR1f8Y6ss7nyMecb78H5T7CJRxNo
	Gn82iGa5iTSjKUuHMfTMLB1SGkPYiv2Ie0w3IK8+S8t2NI3rkJwnDSTlSfA==
X-Gm-Gg: AZFdTZfTzY8VLpr3WcedAlJok4b3cNO1T9u6x0XrYQfyawm5xEPWxTtJB7gAzcVb4D0
	5zsHjaVv9iSOv1/rfusO+uvHroyVs1PZANjelRxrI4DlQ96lCTIMLmAy62KPGy0sSz0qk+L5+jS
	IyUyNDs5Xp+Z+lof09MysdXclAXC+e4zmyCX1qwnqARWFW3zaxPFKsnUj7kMrtGneb1t0er+Yi/
	nwEl2PWvJzws0PcjQK98tWrrPdBbacpxgmuFrB5gK6Eh2T5EgM1VJkbhS7qAIBViubRBXLtSU4u
	rfybIrEcquFVU3duu3l05kxs0DoLmOuTIhFL9eKaj8RjBgKZDxXRj1rMH93jjeYyfwVSNoNX1tJ
	+7hKG5CwqINSZthls9Fzy05S+dSIPDVRLpYA2DbCtojcfw8OsVrcgSvVWQm0KvOMpL8dIDtX2xN
	xUl9zepN4rUinUwyUNmUqR1wB2L5VQDvoIlpOY+8S5vxV6
X-Received: by 2002:a5d:64e6:0:b0:499:527f:ce55 with SMTP id ffacd0b85a97d-4a377c71e8amr6033014f8f.27.1794917921215;
        Tue, 17 Nov 2026 04:18:41 -0800 (PST)
X-Received: by 2002:a5d:64e6:0:b0:499:527f:ce55 with SMTP id ffacd0b85a97d-4a377c71e8amr6032937f8f.27.1794917920728;
        Tue, 17 Nov 2026 04:18:40 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60f8d615sm28246035f8f.56.2026.11.17.04.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 04:18:38 -0800 (PST)
Message-ID: <f781b15a-a731-4698-8161-d384af5bb535@redhat.com>
Date: Tue, 17 Nov 2026 13:18:37 +0100
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
Subject: Re: [PATCH net] net: wwan: mhi_wwan_mbim: fix dangling links on
 registration failure
To: Xia Yan <yanxia@cmss.chinamobile.com>, netdev@vger.kernel.org,
 loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com
Cc: johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, yana06070@163.com
References: <20261111113213.280066-1-yanxia@cmss.chinamobile.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261111113213.280066-1-yanxia@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/26 12:32, Xia Yan wrote:
> mhi_mbim_newlink() adds the link to mbim->link_list before calling
> register_netdevice(). If registration fails, the caller frees the
> netdev without removing the link, leaving a dangling list entry that
> RCU readers such as mhi_mbim_rx() can access after free.
> 
> Register the netdev before adding the link to the list so that failed
> registrations do not publish a link.
> 
> Found while reviewing newlink error paths. A UML/KASAN test module
> using driver wrappers and a fake MHI context reproduced the use-after-free
> in the driver's RCU lookup. The fix passed the registration-failure and
> create/delete tests. Both UML builds passed with W=1.
> 
> Fixes: aa730a9905b7 ("net: wwan: Add MHI MBIM network driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>

This is not 'net' nor stable material.

/P

