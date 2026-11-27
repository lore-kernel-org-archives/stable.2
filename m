Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796738;
	b=TTXv7+ZQrLKtZVvfhEf5S3r1bU2XQ3p1uUUXHjt6PIPHOt9gPO0QVWum7HjkhDWRjkFJ
	 Qi3y34Rezj8fu9KxqA15nppCRgWX2JyA+26n3K51vKEbzfBBC9NjOwyH94H+T+dxPb+EP
	 efovx5u77GB2Bd97kROwPEI4rbDjtQd+EmsN1YCi52xZS5hBJD1HtRGXmU1zqOb5jyujH
	 +sJr4i3ANqj4QE2Zlbrzm5+7PQ+aW0Bkdj8AMBIk0Q7gHjiLel4Zo+8zaYDZzLkwwFDlK
	 XJ2Bsl40ofZiqSnslJ2eT+whDW7AF1Jt54vdVYLBxu+oWqv8OK7fzFis87Xi3mAB3GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:From:Content-Language:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=EIXXOs0aXC7vNxcQ9zRI2FEBU0lGPwo0Ap3vjJpAfWk=;
	b=F9YKIxpk2zXZ/craXBDu2464J3vacTldObz38Y28HSkVuvJvnSRcGyuYJ0sK4k2daL6C
	 eJEMXAVWY8ozOYfaPOW0ujqq7IG4XSAvMthN8IpR54TryWBr+ktT/sPCijhjHRElWvWlo
	 d5O237BnRzGjwarhbtet3mLJ8TAh8mcPXKTuW9skLG4KBkDWA87JWyV7n8n9HDUAgsRgb
	 JQqKcws5DIdXxdVsa6p/WhaLq5KP71Qg3Tw361Jn93Zeqng95lntU3joEODf+q2gCByMp
	 XSpxJphkHx3HldyAks8MT1kP8uOv+IRL7/HpTUbXHl95FFZ2FS6jRqtFhOtKezuKpiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=6wind.com;
	spf=pass smtp.mailfrom=6wind.com;
	dkim=pass header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=CRsNHokk;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4641606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 16:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4641606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=CRsNHokk
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bbb0db845aso963175e9.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 08:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1795796736; x=1796401536; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EIXXOs0aXC7vNxcQ9zRI2FEBU0lGPwo0Ap3vjJpAfWk=;
        b=CRsNHokkMkackj0u/CvF0dv+hq/DvG+3pIpa8uJ/rsvwVx2cQ1xK0I8NMrdb0caq33
         hSY03/3H5ugsdd5TU5a1q4cVEe7lYh3assKC1KF7BFPp6irhkBC9JOBP4I8DiNVCCn+K
         BHp7je+vp2AS+9hCSmSZI7wJidginq51MUtg7KXbY3jL8Nl/Nl+xRApVkMUpDIHn6PHO
         C4txnQMwt2MQIALQC2flnmQ0jvA/WkloOmfKkVrIEPRsYF1Cz07rkwXRu5qS5HZmi/My
         Tjp2H7DZO0+POAWH8zeFeI2CjEk694916tE4+t+d1wqiDHh5iOyOzpUMmGA0s23zkABu
         ni9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795796736; x=1796401536;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EIXXOs0aXC7vNxcQ9zRI2FEBU0lGPwo0Ap3vjJpAfWk=;
        b=1AwAdzDsfKHdEBxDYhFcM5pGCCBHP4D3U+NvjxPrWy5Ounw3ST/ASx039JcNP7JARC
         U3154+bTNOuDv7wq7Da0Hqh5aS1PMN5PoN2PgYu0iutsSDwESSzTn+XIrjPda2jDVi6s
         4SlGNaO+c4ZLWflb5WLMi3EB/vAUz7USlQT31Q4949mqmE34c7NdH66X0ZxifS1y4Rkz
         jwNb9n5hMjsQmyPz7j5XbjXzsKDKuI4oUQBJn0oHWroV4JuqthAfMsUPvj2W/K71ed0D
         aluBTbx/9lCJ0H+jWE23FnTOuCkoiz56eMLAA81QiIZe9OYIP0d9+v/kZi5gpUo93fed
         iDLA==
X-Forwarded-Encrypted: i=1; AL+hErG0zLO0Ven4JB5rsgqKcwumRfFqn6T7GLBc4bpR915zf3AqRC9dPb0/VpS69jE+as2e3oIj75w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RP8hVcpuAZt6LW1TSmi6oWZ67aWC30cHk2YuVS+Vsh3/cNQ1L
	W2eY6FVvdF9TVfl9/GbODqAEWp3TyOkaRvTFrNHEZpqQ+2M9eIKJJedG2q3pRn78s4g=
X-Gm-Gg: AZFdTZfJ9yj3Dp2D3JEX3BMdEqcP0liVjyw6Nh2M/EOQ82HMJgQF50U4eG/nb5MMmnI
	BW7onkOGWgI0742/hdSK/zp4yWt1NWIyANUCuZZlcvJVjETfQ9CthFfNkRFgXnRNU9ykV7rt54J
	mjgkY6T+YV3wQn2TKXRAZ08XJxSSCxUTYYIRaI7fDmS3d1x3+LJy+WodlbOz6GqDnr1FlUcO4Bf
	1KW02/52fU+FCzJGBdxt8r9ul3qMW4AGBmVgENd20yM2c3QEDy1BC9MnF3vfp1YoRAoR2pVfQiv
	s2J8B/6nexeeskSOLFa2DuiAuLKyWkl9cyuC/2coykvwHEQQK/T1013HvvPSHgV2tA3VDWi+d+/
	ifYlmOo1GSaJlBQJnmHpE2UAdN8FbBZjHstmQYXHanPbcQdtPzhAdKpQdisC7wrOhNJsm4MGKgR
	is7ETHwh/+f+xrRKr5NhgX7NwvYGDSbL1fWRK2cTkRFp7UAkdalrXzZYLydZAEEVzSx/Oi76uob
	fUI96V8VHSz4nLnbj63nQuiH+EiM/RPGUXoNy3J1rz3gR/GfSRCwtqYb4IRf/fZzwJBKJ//KTsi
	T2+T8kqjKzvH1/tva7wOuHx6PskEqNWdBBj/p43t8W9cDHRMNNqLnU3nTTGpIYqy5WWdymMezbI
	xWGmx2hnMxkMR6+/35wMxK2zRRNk=
X-Received: by 2002:a05:600c:8284:b0:4bb:6c01:de9c with SMTP id 5b1f17b1804b1-4bb887f55c1mr455686895e9.2.1795796735914;
        Fri, 27 Nov 2026 08:25:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849247asm719577975e9.7.2026.11.27.08.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 08:25:35 -0800 (PST)
Message-ID: <ad7b2465-6e15-42d5-bbb4-ea96e4f2f009@6wind.com>
Date: Fri, 27 Nov 2026 17:25:34 +0100
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
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net] pppox: only wait for a grace period for lockless
 receive paths
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 James Chapman <jchapman@katalix.com>, Willem de Bruijn <willemb@google.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20261127152822.2098330-1-nicolas.dichtel@6wind.com>
 <78e175b3-7f97-422a-928a-a05616f9c445@linux.dev>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <78e175b3-7f97-422a-928a-a05616f9c445@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 27/11/2026 à 17:08, Qingfang Deng a écrit :[snip]
> I'm going to remove the serializing __sk_receive_skb() from PPPoE, then this
> issue will resurface.
> 
> Please consider either using the non-blocking call_rcu(), or just dropping all
> the skbs in the receive queue.
Thanks for your quick answer.
If dropping all the skbs in the receive queue is acceptable, I will proceed this
way.

Regards,
Nicolas
