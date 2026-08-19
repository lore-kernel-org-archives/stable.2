Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47D9420472
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129452; cv=none; b=qljC16/47ThC7fgN6MHzW1Xd8R4gtlbBHkmaqI/B9YQHtARKIsb89c2mG4W5nnK10XZVLFLorUGQ7QO8P42bH79bqSwLLKK3C4s0+voaqjbitaXCrNIV9+mQxsqQvmNT1PA8JUV6Q6Dj7dVNKMWW+G54tRyWNDlcE0OQ64Zq5vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129452; c=relaxed/simple;
	bh=So5IbViF9LFyXxy230v1ixqUAWB4/JrVKy6ngXjevpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JK+Atxl8ryM6t+OQyFzzx+qpkhZt9uWjYYcL5TvwcQX84vYoeP4glwlK/A8nh5Gky9CkoZ3FFL2MofI3DjkhDzqy0AZjPuOhaWcF07v3Jvp8274AxrSJ9Y9RLx23w0dIhzQX6qz5aKgGK+EDr+YL/ApdCNcgutGQiPeeJ/NbNpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E51ubpiS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xqa9pnH/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E51ubpiS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xqa9pnH/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787129449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KzahBh4VmXVQert28d6nftv0k38yoDFZF+6i2Q9FYns=;
	b=E51ubpiSlJtQ9hqWATbAfjx6mW9ik35/7mKXITaDu593m/ekj8G+OHi+YwwO63dVHmRJJu
	g71+0wQBWfcU4iaVEVbUxKx2U6MyZmPhKlPbTtpUjL1vqPJNd4c+10vGMqWH2d/Ec7otoQ
	0hVIJJMHIy95uO/W6QPA+cqr4H8qyBw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-jla2HWcRPDWt4RDzg_WIEg-1; Wed, 19 Aug 2026 04:50:36 -0400
X-MC-Unique: jla2HWcRPDWt4RDzg_WIEg-1
X-Mimecast-MFC-AGG-ID: jla2HWcRPDWt4RDzg_WIEg_1787129435
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47162f83c75so1083028f8f.1
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 01:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787129435; x=1787734235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KzahBh4VmXVQert28d6nftv0k38yoDFZF+6i2Q9FYns=;
        b=Xqa9pnH/2GbvWwRFYzKbelw2A87G0j78gDYC54YVlFL8Wa57nA8j22vJqYREqLvjhv
         9CA8qw1QsYKYux4rS7q1mnNkjCOoSajlgAcmr5pykCFGNQoFdpC5zJ3DiiI4l5a55WHO
         PQ/O+wV9ExpmF/jtEM+YFJCKuPCCrs7AXLRNwdMqqJxkO9Qtg8I+vPXo/SZZS3klAeWQ
         CLFGQ/hbJbk0jr54RdawEvjInrQT9XRM7XJJAPuY4pcnyFC0h1cnO23sj/t1hyw4yI7T
         QH0xpMp22lu3/q2SqNRMWfGG4COUsXsEZkc9gDBaQgl/BLuaQJne/56VfViwxisofkB0
         Amow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787129435; x=1787734235;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KzahBh4VmXVQert28d6nftv0k38yoDFZF+6i2Q9FYns=;
        b=DkltQvsiMosDFZ2hUALYLvi6YZJdD6KsAZTUaPfxOX/uNlyXtwjwvUUkTiUoBSI4uj
         GFV1sbSAYQwQFxag9jey5TBB/nO9l5r1qxYHtkt+L4TidjXqJ5u6IX8KAqvQkWDoXAKY
         IKYMYh84KCtMGav7QjkLtA2u3U9/9RhKnW/j1+wjrF9JCmIjmA5MyEeyBUbLsv8hhl3j
         Los8keOfn5kKKZ8rLNosClhmnK9Oivv3U3K+kbrL0Ef1EJCA290JfmPgu6BMTFQJOmpB
         YU2SaehXIChgxxFt934yY97ma+1jeMYrbCA5sgQGB1pS1izzGd5AxyD/KsPzsR35Zv2l
         PxcQ==
X-Forwarded-Encrypted: i=1; AHgh+RqeKg1fkGmSoTWd5y/fHQ2uogg056DzTb4nRh06S8ZaW4z0fAhnFGujiFK9wsUXV3ZuYQqEMKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM6UQqz8q9+ABbGSLuYxIOv5AaTIz53odJne0YQC5VYbTnHIAL
	iA8mcwbRFS6+w9xNbiyHd0nWW+i5Ig2P2FL+gfy4GKEr12jrujkZzcLVlU97qKy8xauWinWTcMo
	O8rxhOoHQPVDVWV3zPkOXLLmHg680PGJ6MW6guHkjBPCBSEkDhVewV6nk9g==
X-Gm-Gg: AR+sD13zd3bF0LizD1fvmad0xsMnWo4Xhj4+ZcUYUNNj9hn9hrSgN9Us3rxiNFLMJfo
	GaB2MOtwh8sIO4DfLjGEDx4yUm8dbK7lRAA/SArLIRqVMjSdoWKQOp0kAfpsrOiBas2jMTaa/JU
	d5TxAfYIFa55CW1hWZhBME+1cQBrrxK+6Qm2kPJVQLXTCazVIzeY/ZV+UeqpgGolflRAFnHVyBi
	67voQitLyoutUmSJFFlbjvSDlLiN7jwGAzvuOuayXLXP5wifctvI1q2Ho95Fu3AeB2Ccb+5jEYc
	zhXb8C4tAQcCUm/dMUo9EPBpNzQiZMQN5ZWdpf9qnzqydjk1bcKxyhWhMOp+VKVv6D5GOROpsO0
	DJapyfJ3m6917gz7JfUUyZmVevAn6ULmBx/IKFx1DneDAKJS3gwFoCmIjzo5twve4qTTfYFFNQg
	4=
X-Received: by 2002:a05:600c:5943:b0:493:e543:1dd9 with SMTP id 5b1f17b1804b1-499aa11e5famr32993495e9.9.1787129435040;
        Wed, 19 Aug 2026 01:50:35 -0700 (PDT)
X-Received: by 2002:a05:600c:5943:b0:493:e543:1dd9 with SMTP id 5b1f17b1804b1-499aa11e5famr32992935e9.9.1787129434587;
        Wed, 19 Aug 2026 01:50:34 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b144173csm4419412f8f.6.2026.08.19.01.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 01:50:34 -0700 (PDT)
Message-ID: <e204fa6b-90c4-4f53-a989-aa4f1843b61f@redhat.com>
Date: Wed, 19 Aug 2026 10:50:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net] vlan: fix skb_under_panic and races when toggling
 HW VLAN offload
To: Eric Dumazet <edumazet@google.com>, xietangxin <xietangxin@h-partners.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, stable@vger.kernel.org
References: <20260811085246.2267779-1-edumazet@google.com>
 <64a0b57c-040c-4703-95eb-886701bdf745@redhat.com>
 <492adef9-936e-490d-ba1e-3d026ff1223a@h-partners.com>
 <CANn89iLdXQGiLRFTjZOiskWhyKq9nOQJkQ_OuLCHhWw5h8W6kA@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CANn89iLdXQGiLRFTjZOiskWhyKq9nOQJkQ_OuLCHhWw5h8W6kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/26 10:07 AM, Eric Dumazet wrote:
> Regarding the reorder_hdr=off finding from Sashiko:
> 
> 1. reorder_hdr=on is the default for VLAN devices, which continues to use
>    __vlan_hwaccel_put_tag() and HW VLAN TX insertion offload as before.
> 
> 2. For the rare reorder_hdr=off configuration, the intention of the flag
>    is specifically to produce inline Ethernet headers, unless I am mistaken.
> 
>    Previously, whether reorder_hdr=off generated an inline tag or used HW
>    offload depended on whether the lower device advertised VLAN offload
>    at device creation time.
> 
>    Using vlan_header_ops unconditionally makes the behavior consistent across
>    all lower devices without changing the wire format.
> 
> If you prefer, I can send a v4 clarifying this consequence in the commit
> description.
IMHO it's not needed, it is enough for me that the implications are
known and well understood.

/P

