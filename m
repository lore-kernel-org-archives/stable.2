Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A89513573
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788547182; cv=none; b=gb91Zc4SjKYz5nrEZa401vyWl2grnjifkTAtxcvvfhevJZTiBUItPM7SQzK9PrJgznosKJwwyiCoVMczZj5oVYGsWqecNMrMdFdaG25OQIzAUS/AM0kN6f6LL2VSpHujRbrLhruit1KomJEvcIInFmpj35PayikkBq9NpRw9f0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788547182; c=relaxed/simple;
	bh=qzuJmmCKxKcudgi1H7ZBiGEMLDywCJExgfmFWxLixqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWqdWGCxg2hSLRaUaLVHykpxci23MBh1MkUgdOjaJOMoKGKatqZNFLkaHiXkE25wgJF+1MmrqchED/I3Zg+5dwOmnLrvfTaOCu6tGyzzc9i++Fg5Xccg9Wlg3MZv+MzRjU44j4SBN1ySdedVHMP58B6BznozzGGcrKtWNPjqhnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OXD781sL; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OXD781sL"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1059466a91.3
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 11:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788547179; x=1789151979;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=71QSGgRkfVsMjmRaBzyVJ6YcTh/AZY/+5LuW0Xkkm5U=;
        b=Zjok77JdCkWHTbrPn2I8o5VKxlrUq1abSzxcapn0nA0zDzA11FJZPRrapdAGwC0kIh
         j+I9n8j6TQyRftYybdPZqcCgrVuhQ0I7kYTAOGVz62nxP42/6wQyhD3fBsq0fF2keB4m
         h601d7HpPXNcV+ZKdmxRlYjbWae56vlzpnLl5n+PSzSZzFlvCNlhyCPTKv8jmgqFd70G
         RsynPKcxlibea/CThVV6h2/br2rHUjT/G8D/UHKfRwmHtOVHwuoOX6FT22x0gsnUX8Wo
         HZDc/LqoW5e1L1Knrc3r+plOsb1POHJqe95vyjCcY9QPzj/vb67BFnQM4Uk6tdtPMvvb
         uBXg==
X-Forwarded-Encrypted: i=1; AKwUvBxI0aXbfMGSpy0JsIuhRbwG7JLcp8hcEMFeKZ6bFuBSY7pz/w0CEUNwBH+TarlrWBGOnw53oJc=@vger.kernel.org
X-Gm-Message-State: AFuF++lyCX0L6ssE1tWa+IszDLgYhKvEefX+hfjEKcKKce6TVIjerTSL
	0jcRnstyWZzKDwmgl0JcCvzWx1Jd28SocGwfKwTbb/FSnxl4WH1LlA/047Fi1ABltn4UVKTwyqZ
	+KLkaDVllSGM2xkuN12klvd2ZEgG+HFt50QDpWClfx+aBGQ8W3POaOBIf7hvTYkJOTB6Me95Xcv
	s+gf97QqCQC6ujZimZJactj2ut4Xp7RLYu3ku6RpHX9qA9XuzPoylMMOUUJpNVNFk7vX6m8udHW
	DQbdAJG1I9K2bNl
X-Gm-Gg: AYBFou2GcKISw+9WyKo0yqgN0WQKFq4M+QoYDKv4Xw+QDeT1s0VnEAnQQhc1qcsbZAP
	CGhdGJGLnTHO1TkShqQVKaE0zlpR6+RQsjoBj2BdOFIkV6rpoq/z8UV47N9AhAWgII0YeW25FJ5
	X6GFL4JsANQBFhDXuMllYzbeFUA6j/bZ9W/XWEg0SH/m8tDUELMubndE5yLiFlXV60fs9dYi6Xk
	jOIkP+Kil2gA8hvzasPGv3x7VAjcf3at2pOBfPeQSpvkHV02mZ+Vc9s70sc5OgFVnx7h/Tr2U7K
	/8yi8t7ZjekXE7EBdhYSRU5aDNLt8BfjAeXIA5OgVmb7UJJjLqvI+YAHatrho1sTFRjiQN8vbLu
	sem0E7EqO8hPK1HpY+7+VFFXDuZmHi87Rs45ufHObq4WiuHljsg+yOimkvceJYJbr1gFeim56wM
	qfrHJYO2RNcVjYtzkCEKUbCpYW8VG36/zTfGfWWKtU
X-Received: by 2002:a17:90a:c10e:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-39b2622b3afmr11401780a91.18.1788547179049;
        Fri, 04 Sep 2026 11:39:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39b16055f3fsm3141099a91.6.2026.09.04.11.39.38
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2026 11:39:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6b34e5453cbso1276754eaf.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 11:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788547177; x=1789151977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=71QSGgRkfVsMjmRaBzyVJ6YcTh/AZY/+5LuW0Xkkm5U=;
        b=OXD781sLssQx+Hn60164AyNSMoAwJbbnfOce6wjUx6UrisArKFdtF5TUkzCwNjSiYs
         xNFBPGV+GRhkzZ+PFC15HImgZJfRJ/45WBD5/2syPoGm9OkfZM6M9NiAnvPu9ASh+f41
         sJW52/Q2KxPn1MH+4P2c0ehh6nvqAUAWUzzlQ=
X-Forwarded-Encrypted: i=1; AKwUvBwEbjMz0SVnB+1o1KnpJdXNUFHlL4GYo61euQkIZLJbjPnJG2du0+b4ZQYinoOeYBJbTu9rcCg=@vger.kernel.org
X-Received: by 2002:a05:6820:2012:b0:6ae:c68b:3a7 with SMTP id 006d021491bc7-6b6fc6d1a4dmr6180594eaf.16.1788547177566;
        Fri, 04 Sep 2026 11:39:37 -0700 (PDT)
X-Received: by 2002:a05:6820:2012:b0:6ae:c68b:3a7 with SMTP id 006d021491bc7-6b6fc6d1a4dmr6180555eaf.16.1788547177128;
        Fri, 04 Sep 2026 11:39:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243a9388sm8100143c88.10.2026.09.04.11.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 11:39:36 -0700 (PDT)
Message-ID: <b0503a89-aba9-4db5-928a-e8d334a21246@broadcom.com>
Date: Fri, 4 Sep 2026 11:39:34 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Backport fixes for CVE-2026-43198 into 6.12.x stable,
 CVE-2026-43198
To: "Atul Joshi (Nokia)" <atul.joshi@nokia.com>,
 Matthieu Baerts <matttbe@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "Joakim Tjernlund (Nokia)" <joakim.tjernlund@nokia.com>
References: <AS4PR07MB8827D3A807C2D7FEB3EDB06682B62@AS4PR07MB8827.eurprd07.prod.outlook.com>
 <f54728ae-c3ab-41b8-81f4-6bde4450ce8a@kernel.org>
 <f13d81f7-5019-4376-a77a-67c2cecdc2cb@broadcom.com>
 <AS4PR07MB8827D88BF7A373A0B5EFEF1982B52@AS4PR07MB8827.eurprd07.prod.outlook.com>
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
In-Reply-To: <AS4PR07MB8827D88BF7A373A0B5EFEF1982B52@AS4PR07MB8827.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/3/26 19:15, Atul Joshi (Nokia) wrote:
> Thx Very Much for Info,
> 
> May we know which release of 6.12.x we plan to put this in.
> 
> As of now we are on 6.12.107

Please don't top post, FYI.

There was a build error in the DCCP subsystem in v1, I just posted v2 
addressing that. From that point on, the patches need to be picked up by 
the stable team and then scheduled for inclusion in the next stable 
release candidate. At this point, it might be available in v6.12.110 at 
the earliest?
-- 
Florian
