Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B84B4052D9
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 21:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791237086; cv=none; b=rm50vDIYv/HRNw6p/33HSCi4NpUkHM3h1QnLVS7dICouaOf9I5YrVqyajEerCnoBU1ZJd/dZ/nXtc/3v+Qm00iKIw1V3pwlIPRqcPHmdO85lhBUBv8FSGRDUaUwksh/chhXBUT//nnpFkEwoDzMCchQIhJeBeZ2shnaPkItYxLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791237086; c=relaxed/simple;
	bh=SRfGe8YUi4yesi7jAbLB72EfeA52rGM0mBJDk5EvxiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CspPu+cOZISyRsVx15b8kHeDkILGlTlzSVRYcx9dJg7r0p8Q3pmswsOlcZQOmRW4j2Gdtrik0bsBpnOfXOhi+bEcZ75uR3GppMcahqZc38xk/DKznEpsDLkpf1GFC7zBo5Zo9B67j5lnP/PtNkJ6RpPxQKkqP+Fz+Nw3mdT63II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O4RB7jFa; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O4RB7jFa"
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-8a83d2706fdso18685527b3.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 14:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791237083; x=1791841883;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ok89UhJOJlflXXvwPm7JXDB/KV5PdIv3y4CRaPBGxRw=;
        b=z8t0Lv0hVWNpG0uADKV9R100FthOj1SY0VuRgk4ktZvx5HH4rB07AKCYA9QhMf7uo2
         tyBP+EeoSpMWDwTJi7RN3V2UwBKFNkjIH4B6npDz5rl6sEy1o/G8RrioAnP3uDf+iv10
         3K6Visekmgu7mAVWISUwMJU2+QXgfOzrPG1ekAWlFdSbh7TSBTyOorXfyx8Qo/p7a7bX
         aOcVy230Q2vjsb0d/wiflOZq3XkWQEhBNo1rAabC3Z1MxQ8zCUjhsJOkdnFADM8bD1Wk
         GfkpVObfwzvCXxzZ2yFsKX6Csimi5xSP+naFH4GJZlIf9a12OW7E7Dg0bU/vpCGurICl
         dGdg==
X-Forwarded-Encrypted: i=1; AKwUvBzEjnvseIYlrRLi2Da8rdCTu7s9daLQZJddygAt6fqjM8p5PtnPWdSzaBO0g8AXDVobD68CQTk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL39DSWzX5S6XQHBLLfxxgcXINCkjbWq8ajmQgoSCXUfGiwVL5a
	TwzdsR2/KM7T6Y8MEh+Ft6ncCGcO4+9k0relddPiPxmpZOBb9/cv8qWxHk+y+E+D0uxXqTpBdlL
	0pJq6EiVNaVqcnYuwB0D53R+KA1c4NVdWbeBptEZ8fiyueuyKeoERo5rxyr88vnMpe/k7C75mam
	DRxGdvOWnTh8iijp9fC46v2169VjiFwHIhoz8nVDZJFsYwEfumVMqKGeIRmvmXU3/YXZhCyN16c
	DthG57gJ6Z35Cbq
X-Gm-Gg: AYBFou2Gkd/NUCd0zxLyHjd/XnO1QN/5jwWzOElgcWe+mRqR04bA5kkWfIMCmjvbuhC
	pS4oD2cmhToa4ElPJDK6PS22RT0OWFbn2tpHqq/Qw5or4VNMDGKKgGWcz5QZFXk6MsyqAoS6ckw
	GQy9/4GGdqMb8bI/7Q2cTUldR0Ewbwot4rHTT0GMbOrKItnP5lffsij1pTjMVFs14HF/339mDIa
	JLbx9PR0YCPYHHyaj6JjAZJjQtNDTDSkCHtbnUt6jJAQQBVqA4JTDYiCch0PbTy9+Zr/Cdmfnx+
	SE8QbTAP7HGpAQDKNT0/4qs+59B5CIAd1LKKJIEkeLC243agjDU0FsNMcBL1d8xaoFpoWEUT2Hp
	fc/QG8x/suOnFLwwmDy1V+K/wfJfovZqRjrLLM8LLXoy0X7iHa4XS/xDTo+n3Uw53G/3cCyNDT3
	LIQ0dG/cNGv/Jy2qJ/4NVvACdUoJWEvASHh1Nv0ADP0Zw=
X-Received: by 2002:a05:690c:39b:b0:8ae:843e:e0ce with SMTP id 00721157ae682-8ae94ca2e19mr28976507b3.31.1791237083248;
        Mon, 05 Oct 2026 14:51:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-677c1ae867asm1506222d50.9.2026.10.05.14.51.22
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2026 14:51:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3510d0baf63so4247722eec.1
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 14:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791237082; x=1791841882; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ok89UhJOJlflXXvwPm7JXDB/KV5PdIv3y4CRaPBGxRw=;
        b=O4RB7jFa1Zh/Nt4uVetOSiozJprarNWu8hy2IIOTDg9bvfcC0xdojgsMd3ZtJtMRDX
         ehu1Md7jEwsvyGhYfj4XTH7eAeIDrEtnewHEvkT8a4i50x0X3glx/WDYNL2XVUH4Z6v1
         /Ncfa4bGyQ3VRvemQldHNwrOIze5LQnz5baeU=
X-Forwarded-Encrypted: i=1; AKwUvBzbP32cs+HwJB11e30XIz7QOF4OjhYNeQCrQbVDLsbmWELvaQDu554ASvVY29nXOtmyG06gbjE=@vger.kernel.org
X-Received: by 2002:a05:693c:8803:20b0:34e:f726:928a with SMTP id 5a478bee46e88-351111bf78amr10545508eec.3.1791237081790;
        Mon, 05 Oct 2026 14:51:21 -0700 (PDT)
X-Received: by 2002:a05:693c:8803:20b0:34e:f726:928a with SMTP id 5a478bee46e88-351111bf78amr10545470eec.3.1791237081128;
        Mon, 05 Oct 2026 14:51:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35146b5ee6bsm1595026eec.30.2026.10.05.14.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 14:51:20 -0700 (PDT)
Message-ID: <1acb8eb0-3443-43e3-ab66-5328b98a6143@broadcom.com>
Date: Mon, 5 Oct 2026 14:51:18 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: netdev LLM review for backports (WAS: [PATCH 5.10.y] net: sched:
 cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode)
To: Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
Cc: netdev-bot+sinfo@kernel.org,
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>,
 stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>,
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
 John Fastabend <john.r.fastabend@intel.com>,
 Benjamin Robin <benjamin.robin@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>,
 Pedro Tammela <pctammela@mojatatu.com>,
 Simon Horman <simon.horman@corigine.com>
References: <20261005-cve-2023-53733-v1-1-d716b944802c@bootlin.com>
 <179119639380.1402591.2155637888002963@kernel.org> <asOtjgd0NMXMjCCZ@laps>
 <20261005142128.30f80c5b@kernel.org>
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
In-Reply-To: <20261005142128.30f80c5b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/5/26 14:21, Jakub Kicinski wrote:
> On Mon, 5 Oct 2026 10:00:46 -0400 Sasha Levin wrote:
>> I started seeing these reviews on proposed backports of net/ commits, and while
>> they are REALLY great for upstream commits, I do not think that these comments
>> make sense in the context of a backport.
> 
> Blah, sorry about that.
> Let me add a regex on the tags to exclude patches with 5.x/6.x/7.x
> 

They are useful if the backport does not cleanly cherry pick, because it 
is possible to introduce bugs in the process of back porting a specific 
commit. I don't think sashiko is quite smart enough to be able to do 
that however.
-- 
Florian

