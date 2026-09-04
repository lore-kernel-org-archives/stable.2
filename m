Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9667151D538
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788547074; cv=none; b=mLtQd4JrezHNixf29/gWR3kdBA/rDj6WwB/u0kniO0oZcVmH5kfHfcF4Pxi2W+AN4Algqh7fq974f96LbFRl8fcKaz81aCtUI63HQDZNb1fZ24DiF9juB+ULC4iiXnn8vDv3JG0LXW+eZOsfpOQl6krCiaSLMt4JShf5G4dl0gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788547074; c=relaxed/simple;
	bh=TQ4n1490RCKrkhHOTSyW5/HY8ZHvQ8HddSTX7aIfSag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3/Z2LcLosa7my9us4ugVGVPVnWKsP+FeS7lE0q3x/MIlrZ9f+t3IdfHDoAsbFm87epFJeF60+PZnooEBecLghSkgibu8exlQEMyLWwQgnoth6VPGKV+HBNJHOuko7Nr3knt1EoZwo1xEGjdUgZ3mdCpxs3ldcWamwyVy2rQCF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OCS/1oNO; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OCS/1oNO"
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-51bfad59921so16537951cf.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 11:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788547071; x=1789151871;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=S2GxLwSx6EjqP7uQ/lfwQxaK/gh/FTk8wuqSuVhY/wc=;
        b=XEb0uo/w7EsAq+NOqrIwmCBeZ3rs9i6IVgoITh7fkSpNNoRIteGPr5n6cuhAmxpb1R
         ebBV+D6+C9J4UVcNKikaWF58FtDPmgjUQ0b6VCljTzKgh7Drm2zzJhV0c6xFxIRQbuR2
         ug3vcAKXRE+/VNdo46Xu0KHQdDH2DNs//KEcMPRPQGrQPGLfg9VbMi3yO6IFe/b/xqc/
         iARkm31oVOkEaCTUbHVT0eD/PNh4lrgYdQZFPnycbSUg/i1UUMI1SenvHYAFye8GhFVW
         CTNjxzoFmhdrhYhnj6/rYuIuO7jMoOGrKStaqtnezU190Cr8lRNtHWJJfYXNeFwtJln/
         ntjg==
X-Forwarded-Encrypted: i=1; AKwUvBwVJP/3iAT0iGLw+w/jVWfHs0dLBQktV6k+zQ+RirsywpH47LrTis6NHjEGFTQsYQNHApuvIaE=@vger.kernel.org
X-Gm-Message-State: AFuF++l1gceo12lCRz2BrucBncQmSNCAXPBaOdEbfPB7U3F51k6GDg7l
	aXHnQv/cDtGyJMThoQ52WeUzYy9FwePSLSq/eqYIGlRpREBg+p5rDxvrdQV9c0Fah4gog2XiGPb
	cU2B6D0nthJKnN2fQw0ttvc7yEU83obAqCF4MkLgdCXKSbUGrHfM1457Qtvx8NowdI1nBVhVs0T
	ZAqzwa0Gepb35MQwIBEtq7B2zGSj9lpZcJPcFweR/mhG93GZvCQU5M7H4av4DYuCjPiEBQEWztC
	vp3jtVG1jaeqWKs
X-Gm-Gg: AYBFou3BLuuskUqrehKaconmZG4dS3L2GgfjMpu8EOkXjjc/npTg9RcDPJZGz6n0+Si
	D2SB7lM67RvajHqns1aIRkM7hB90kSbCXxSsprXHAeJdqmEJN7XiALgn/pJSljpxrYpn/86S8Xl
	IzA4XgeIxyAfJyTq4gdkdBroWiwL1VCWqwqM8yJPjx1Ex4BggpE79BkKB0w/QB5mp3YuPuqUts7
	tSQhofqKgtFA7JESQ3CEKUAMsNciRfsAdVokVzjgQMxjUGo7SVqpVBBjSO1GaH8H0s1G4CnHkiA
	pukg7wzS50xzfm1HdMW1hdyM6yandUNf+BbN8Hh2sHtcRDVfQLPl4pGxDp4qM8YHfg5GvBIfilK
	pkssWrfC+Mkaz3tVkA3pPJnj3fvZJ83lKK4xDjNtK2Fd4TnL1dHtq7lQP8o4Ai6afoIRpS83JDy
	7geEOIWbIV8cb6lFfuu5Y3F/w8OZw2V7bj5NGqkKh2
X-Received: by 2002:ae9:f201:0:b0:936:9525:e952 with SMTP id af79cd13be357-939804a4ea5mr665917685a.41.1788547070542;
        Fri, 04 Sep 2026 11:37:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93985c2496esm18087885a.1.2026.09.04.11.37.50
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2026 11:37:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so1927985a91.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 11:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788547069; x=1789151869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2GxLwSx6EjqP7uQ/lfwQxaK/gh/FTk8wuqSuVhY/wc=;
        b=OCS/1oNOk2U9ulOoK7DVdJRCAAvzZw+9Hyy0hH2vAXTh3ZEXa7IFmQFc5tlKmACIae
         d1A7At0ISEnN+3escLDAmdeDta20M9wwUKmKrjhQ1D3ZEn7+HpyEPxrkttFoS+vhtOHh
         oR5I4taI+RV8yuJG3rNMwYzY6NNKOqqB3Rx9M=
X-Forwarded-Encrypted: i=1; AKwUvBzxf/5/xUGg8jq0i9MEgKq56SrrccFZIItHhNdgqfspM+HfMFT5etLzi/2KuQ0q2+6dQpFMB9A=@vger.kernel.org
X-Received: by 2002:a17:90a:d610:b0:399:1b08:28de with SMTP id 98e67ed59e1d1-39b2613259fmr11035333a91.7.1788547069283;
        Fri, 04 Sep 2026 11:37:49 -0700 (PDT)
X-Received: by 2002:a17:90a:d610:b0:399:1b08:28de with SMTP id 98e67ed59e1d1-39b2613259fmr11035158a91.7.1788547068036;
        Fri, 04 Sep 2026 11:37:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae62a54f6sm5881444a91.1.2026.09.04.11.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 11:37:47 -0700 (PDT)
Message-ID: <5bd8deed-ea25-42ed-81b4-85afe8d3cf52@broadcom.com>
Date: Fri, 4 Sep 2026 11:37:42 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.12] tcp: fix potential race in
 tcp_v6_syn_recv_sock()
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
 syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com,
 Kuniyuki Iwashima <kuniyu@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 bcm-kernel-feedback-list@broadcom.com
References: <20260903174016.689839-1-florian.fainelli@broadcom.com>
 <20260903-daily-reply-0002-re-tcp-syn-recv-sock-race-6.12@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20260903-daily-reply-0002-re-tcp-syn-recv-sock-race-6.12@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/3/26 19:52, Sasha Levin wrote:
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> Sadly this breaks the build in net/dccp...
> 
Yep my bad, sashiko pointed that out and I just submitted v2 of each 
patches.
-- 
Florian
