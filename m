Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD0E28373
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 00:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788480475; cv=none; b=npu36kw3/TzRv8H+t4TZfuDrX5ar/K1xQivWCtDmgsCfLOwU6xLNvFAS9eulAet5GxLveh2aRMqO0YJmEMkhcVFdmpCfdpDPjXz2oZkpKJUlTh2A2/w1viNrKKyNp+G7L7QFiJ+vQTL0pkACw/xLA6+QcKQ+uSMfeZobacWLIRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788480475; c=relaxed/simple;
	bh=H+fZmEsF6TsKbgjAodR+NZGLG6wM1xn/tG+HOjsVcXM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bdAFJwCJSuPHAH1po1r8DF2EvCOimPVO3cr4zJyj6JKGlVWuQTDw7a0f8TIYEftVaDRFxSAcPE2cYzy6p1dgeRdKlON+uZ/1lvVA2ftQZ6/VwcPx56kVCYFuSBFj6kjh5/JlyLcLr+yR2itFCzXspX/iqdTX24tcmxVDJXF8hh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y/CeGJvD; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y/CeGJvD"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-381b831d535so673433a91.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 17:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788480473; x=1789085273;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1171+620Uni6LYsowo3sTBNaSgfAEFOQzAIxl2YazcY=;
        b=jk+DUeQFHnrKL1xbl9kcDBRp6LOxajgTFf298xk9Bhy4TgJB87qTwE9lddJOhp1gqG
         W/pkgmOWPLlTd9f5KuuiHb+t7KDn8bVyzRWRy416fhe/OGz7hpYndxmECif/NZ1rZeWD
         /0QK9eDv+w9PHf5bQvTdmkjtLhYfAlwg6L7hzCiztkr0Ut/6RlSc5SJxtdvNC0hsv/It
         p4xEAamJku1OhQwJR+5PyNag7tYdrd3KyqY9nGxdNXRbzBAKl0eMOuwU6PnSJ4gVEgUL
         Jz8B40nggkrGT7j0rrD7fwb/CbEwKVUL/CuFir9DeH2Rg+JX2hiBVeaRRyBU4fIX+HP3
         bddQ==
X-Forwarded-Encrypted: i=1; AKwUvBwU9sfWKG3vmdSVPLrU56r5PZ8E2+QMKUK1ytjjP/I6kWKuyZiOwwIUuCYHUtVGVrVDvDlUVPQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ndNjKQli+KG7TxqmzmcBE+RpTqet6lOZWtJOQXl4HvdHlmsLFJ
	/Ny2ibJsp870j+X8Y+j6kU6kXAAYkOh2g/fhyY+yfRpenLMuqan3t/tyftzHzo1WD1dFYkfjFnj
	YIu7P4vh9D+3VPtWU9uOCNE6wGMD4MX+5WidBf2DDqYA+Jhwlr9xu1zeCT7VPN9lxSXicx/AjUJ
	OkfAyqvNVBv4qpBh8YD2WYen3+W8dFlica7YhWsp7zeZaesFhwRXSkaY+8RkovuDVqym9VNz9qJ
	EzutKVwtOVymIv3
X-Gm-Gg: AYBFou2lIsuIoH3T35woUcrYW7bWpWI2Iz57Uz8a5I67vxVG7gfv0XM2DUWlT6TUAgP
	4JPJIvQo8hRnAcRRaHUEIvcIk0xVThaLNi8Ksi1K8qXkfd6CI8Qokyvv2hKx/gL/Ae6HuVn+5xW
	IRkmkBqae+YdlMPmrkSWxgJguRtSuI+9TZpNCvlI/dLYMInKJao6zwJfLyNjxuIZ6yO7gMA0G/U
	2eLNvX/9w1dDckHaIHZqJ8sMQu/Bk8IKpUsNWoeg4kKVaM4xRjjXlktpk8uynbmiswcepU38/AI
	qwJKAylECr9NFmH5SNd+CWoGS3et9hVrVqdQdgmezzRCX5+0JqWnAHrF9g7LnHY17/LDO46Bfpf
	XhxZUn0FJ3PitxALAoHeOClVSKqjI5Y/jZRm3RZ+POj1+mcegY1lSgWm97YIrm93sfeATYHX5I+
	3H74BdwQekTEr/J2NlrWCgYhNIRBsT24LYRaeaFeE+
X-Received: by 2002:a17:90a:e703:b0:398:d843:cad9 with SMTP id 98e67ed59e1d1-39b26226de8mr3657927a91.19.1788480473344;
        Thu, 03 Sep 2026 17:07:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-333fa46ed6asm4666eec.25.2026.09.03.17.07.52
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2026 17:07:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4855e47d062so239994f8f.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 17:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788480471; x=1789085271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1171+620Uni6LYsowo3sTBNaSgfAEFOQzAIxl2YazcY=;
        b=Y/CeGJvD5udcLYFWwpftVf9s/oV8/LEQNq5FhRCwrifoEJDT4zmKfTzLQ1xaJYiL6x
         7FzBSaP5t+UD5PxroytzFWghNDKPQ1BTIE+RKoeaubO/Q1jtBZAcj9R1fBHyTh6C4Jk3
         ktkY761raB32ByxsBIwRDoZ9DCObTUNbcjfZc=
X-Forwarded-Encrypted: i=1; AKwUvByaS/wK637ERZLpjEfeQmTs5/G2wHEHJazaUbjE+AK5FwsoOsWom2A0P5xc/c8slBQ7clAsVpU=@vger.kernel.org
X-Received: by 2002:a05:6000:46c8:b0:482:f09f:b262 with SMTP id ffacd0b85a97d-485872b3f8dmr3274373f8f.20.1788480470840;
        Thu, 03 Sep 2026 17:07:50 -0700 (PDT)
X-Received: by 2002:a05:6000:46c8:b0:482:f09f:b262 with SMTP id ffacd0b85a97d-485872b3f8dmr3274354f8f.20.1788480470380;
        Thu, 03 Sep 2026 17:07:50 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588133600sm2395005f8f.5.2026.09.03.17.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 17:07:49 -0700 (PDT)
Message-ID: <95971966-6bb4-4aa8-8af5-198cc9814693@broadcom.com>
Date: Thu, 3 Sep 2026 17:07:47 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Backport fixes for CVE-2026-43198 into 6.12.x stable,
 CVE-2026-43198
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: Matthieu Baerts <matttbe@kernel.org>,
 "Atul Joshi (Nokia)" <atul.joshi@nokia.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "Joakim Tjernlund (Nokia)" <joakim.tjernlund@nokia.com>
References: <AS4PR07MB8827D3A807C2D7FEB3EDB06682B62@AS4PR07MB8827.eurprd07.prod.outlook.com>
 <f54728ae-c3ab-41b8-81f4-6bde4450ce8a@kernel.org>
 <f13d81f7-5019-4376-a77a-67c2cecdc2cb@broadcom.com>
Content-Language: en-US, fr-FR
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
In-Reply-To: <f13d81f7-5019-4376-a77a-67c2cecdc2cb@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/3/26 10:44, Florian Fainelli wrote:
> On 9/3/26 10:29, Matthieu Baerts wrote:
>> Hello,
>>
>> On 03/09/2026 17:29, Atul Joshi (Nokia) wrote:
>>
>>> May we request to consider attached backport patch for CVE-2026-43198 to
>>> be submitted to 6.12.x stable.
>> FYI, Florian (in Cc) recently sent patches for kernels <= 6.6, but not
>> 6.12, not sure if it was on purpose on not:
>>
>> https://lore.kernel.org/20260903000029.3508006-1- 
>> florian.fainelli@broadcom.com
> 
> Not at all, I forgot to include 6.12 in the script. Now done:
> 
> https://lore.kernel.org/all/20260903174016.689839-1- 
> florian.fainelli@broadcom.com/
> 
> Thanks Matthieu.

I receive some feedback from Sashiko that should be addressed, in 
particular DCCP has a build error I did not catch, v2 coming up shortly.
-- 
Florian
