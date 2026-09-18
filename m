Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B015744E041
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 23:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789775202; cv=none; b=alb/otX56DHwmspIz12Dm7cX8j2ejJwjbPbtL+mBuHFnAdKUWGuoIy8DSxBEJPmeDXSDm/pCmk02J/t+zze4KA+l8iJgxInYUydOomoNorQgixDI+6MjBkvXzbYyp5l+vJ/lIHgoywxtmSrJ3HCmzQdwFtVEHSr5OdRNB1YUBSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789775202; c=relaxed/simple;
	bh=WITBwmjQ6YgkJFK36iLqV9GnsUYX+fX/wU9MGqkhguA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8r2IVlhQNU3jmNu4SdcKFDES2ldKd2xo3fLW8Bpb9eLCFEZSaI0ZHj7a4UQGGIm8iGNZ+Ws4aU5FmpsYW5lwwTtmDMQlr81rALUwtqQ+cJb8YZAkW63FJFJqvSBtBQ9JklTpU3jBqUdxMAyXZZbb8Pk5x6J87FtvygWbdcME9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZjP7GYQ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZjP7GYQ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71974de4so578115e9.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 16:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789775197; x=1790379997; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XhFK29n+MC5nuBbvPBOhbnlgDf/9/2f5NLz1t43GcV4=;
        b=bZjP7GYQ9TRybeVTShJpqereBP0iHRakc7kvmuS1vXRyw6uovMvdpDUqjoLZh7HMUA
         TZL/hyFCFpipRJZAMVzzy+ICXEv6QmpYYETgGDpl9ud1V8Uir5OVYBBrPq9WWjOQ2oPD
         H62E05W8TysdgjxwWApKJ1XeO1OaPxw/s3CEYzq09/e8wXf8VbZaLZgvGr/iaeQl8tLA
         4u4b57ZSmmdNFvAnDVCWdMTyMdWMkQFDoGkMOshVUhoIYQ2ftEC+Uqqy67QYv73wcP/l
         q0ImsaF4MT1P0qWDsDDCQrLcyr3JAfS17b758d8LDpBFDJ4/7ZjbVcsNIGgcMNND/krZ
         Rk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789775197; x=1790379997;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XhFK29n+MC5nuBbvPBOhbnlgDf/9/2f5NLz1t43GcV4=;
        b=zq2nkF7A3dON1vODLK91clWFNWIBEPuU7EbYkDNrDhkxlwi0bgocvaP07l0wZey4Ib
         7kddRxWKPei3X2pYfumw8glD50OieOozjaQVOhYnTH2l+YZY4nG2+gb3FnUJgnMT2f9s
         LfbVzBzPC3+g7qRfZwkODhJ1zjVZJDhO0BK9b57pm+k/ua5s7sdFDqUzyNfQYpARp6Z1
         RoTpaBNT1GXmUPLbHE42iL6fXV5tBHVS5wWN882pWDZovh6TgrcclBeu3Tj3yP4NDXhJ
         1rGMX0n6sWg+Z264ovnj1CRj5lTx1jx9yVoCvRrIKhCc3Nu4/nlMTXzhywyYyQtZpmCU
         7HMg==
X-Forwarded-Encrypted: i=1; AKwUvBwhWlUg/3HWN+aeV2GeKCdNmi0xuABKMZ4nyiD1LdbKlckEk3dv/hZ+etHMhr2V+G6wSDoOovI=@vger.kernel.org
X-Gm-Message-State: AFuF++kF/aReOVt6VYZAfRV1rG2Hhqz5WnlYXVcCAAoUra0U2tNIhJ7K
	aqnDRv4pUlSQLhT1e49kqNtNe1TYfOsQD8SLUPhWYru881RAjBOtRTrp
X-Gm-Gg: AYBFou2tN6HdGqBVMIVLYRUnUQdpt0uMXH/urRaQ40Ed7znOS81B11F+kzkyMmZqvUR
	nGp9cWLm7Bnl+MtiKis2NOgn9xl8u/wRgcF0ydRR1110JaE8N9tjly2ga/Mpkiwtza20tVjwvvw
	kffeRwBybTjycvQsdxldqzibaP6YfOe2p3J37d+YFNsUflUlDK1IVpz+YtjYhmIzfse8azDzoiv
	Z8xtT3xHkBU9PSSSuoxqIm5gd4ZH/xGwBtNMLiz4OhBRqVxPWtY2c9uRNgortl+AirPHAdIlQFC
	civB8OUY+4i4c3VKtrHS1HBMvgPgUFuvC/1TBzyFrY2hHjJmrA0h5O0dQUIOhcct3KOHKw+otMa
	4y0J1fx4lwZ8f5O0VwYQHQ+jvnR8Ubyv3IGT57y46lY7FVYI9oLVrGrwh3F3hGIDyNfc2zs6/ia
	IHPNpoSQ5cTiZ7wuDYGOJK8hINFz4ASwwPrpC02wmIwAmPRT2HGROg0ZxjsX/CePMBdXKExKvoZ
	HPMXwQ2YxoP1LXz43/Bh1YZbQgYlcnF3NHYyQwXcl9Dv1w7b6pH1CeJOQBtd51o5Wd2d8xuPDtE
	Rve07zQNhgmFXEKbiSz9bZtF3e1abJ7jEvxButTOrNrE4n6hyk+PbN/l16LKGlbSAV3pOOfiVBl
	W1Deiouy7lwbrgh+j+w==
X-Received: by 2002:a05:600c:1d1b:b0:49e:7cc6:ec88 with SMTP id 5b1f17b1804b1-49fc7e00555mr43611665e9.1.1789775197074;
        Fri, 18 Sep 2026 16:46:37 -0700 (PDT)
Received: from ?IPV6:2a02:3100:59ae:19fc:400:b6b0:efdd:810c? (dynamic-2a02-3100-59ae-19fc-0400-b6b0-efdd-810c.310.pool.telefonica.de. [2a02:3100:59ae:19fc:400:b6b0:efdd:810c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0f8563sm32070215e9.6.2026.09.18.16.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 16:46:35 -0700 (PDT)
Message-ID: <7c09a44a-19d9-43f5-a852-12f5b6579641@gmail.com>
Date: Sat, 19 Sep 2026 01:46:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] net: hsr: fix packet drops caused by GRO superpackets
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 bigeasy@linutronix.de, xiaoliang.yang_1@nxp.com, skhawaja@google.com,
 liuhangbin@gmail.com, stable@vger.kernel.org, sdf.kernel@gmail.com
References: <20260809121455.1745-1-xiexinet@gmail.com>
 <20260809121455.1745-2-xiexinet@gmail.com>
 <20260813182111.088aee3d@kernel.org>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
Autocrypt: addr=xiexinet@gmail.com; keydata=
 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
 sNySbH3veZ/55EtlXA==
In-Reply-To: <20260813182111.088aee3d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2026 03:21, Jakub Kicinski wrote:
> 1) could you explain in more detail why GRO is breaking things?
> GRO shouldn't merge packets with different L2/L2.5 and packets
> with trailers?
The reproducer is plain SAN traffic entering a PRP RedBox's
interlink: matching Ethernet headers, no RCT yet, so GRO can merge it.
PRP then appends one RCT to the aggregate, using its length for
LSDU_size and assigning one sequence number. If the aggregate LSDU
exceeds 4095, the 12-bit field truncates it. Later TCP segmentation
cannot generate per-segment RCTs. An aggregate left unsegmented may
instead be dropped for exceeding the lower device's frame-size limit.
Our wire captures showed segments without RCTs and duplicate delivery
through the two LANs.Disabling interlink GRO raised single-stream TCP 
throughput from 27-37 Mbit/s to about 94 Mbit/s on the 100 Mbit/s rig.

> 2) the code seems inspired by LRO but LRO also has
> NETIF_F_UPPER_DISABLES. This change looks rather incomplete.
> Calling it "best effort" seems like an excuse.
NETIF_F_UPPER_DISABLES prevents a lower's ethtool request from
overriding an upper's LRO-off policy. GRO is outside that mask and
remains changeable; extending the global mask would affect other
stacked devices too. Patch 1 sets the GRO-off default, while patch 3
segments plain, trailer-free aggregates before tagging, including
when GRO is re-enabled or GSO arrives directly. GRO_HW can also be
fixed on, so feature disabling alone cannot exclude all aggregates;
device-specific hardware-coalesced formats remain outside v6's
segmentation guarantee. I should have explained this distinction
from LRO explicitly.
 
> 3) Clashiko has a number of other comments:
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809121455.1745-1-xiexinet@gmail.com
I have retrieved both v6 AI reviews and will address each comment
with a fix or technical explanation before posting another revision.

-- 
Xin
