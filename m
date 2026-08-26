Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3993955CA
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785667; cv=none; b=Vym/Lo8IfDHgWI/JTrxOFpFkyL/ODMkBVFSBp/pQPFCfztunyqe0t6frb7+mjS9je9u//lZFrmMPk/bIOM2Sf2SajVV4UAY5Uf5RA1UMxskokDdri0iD8nEFF55rU3sXPNnsBmxZIMyKnb58cb3u/SJMh9QV2/GBAMSF8gsF7A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785667; c=relaxed/simple;
	bh=Cq8W4DBJfQRK4/SOiJmoUruPGW2kPce5PpiN31IZ8gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePdyv4STi8vqbX75PzuLcc7LJwSzCF1WJzmzFdVLqfP+5HBs8X1E5L5+FzjVUTbZKOsm6P2KHShF5m8KhE/0f54oxhX/eJw40EMsR1hWqoWMXWu4Uo8sGeDxWgWuHwRuWIXur19ZZmaaG/x7tr+UZWsWL+magR4qybqs/15AJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Kvk5azJC; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Kvk5azJC"
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-74a9ac9cda6so1052086137.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 16:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787785665; x=1788390465;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=q0gJbLAjrAkHetISJ9E7BaKmcamQMw9Vv0f9TbXVRXo=;
        b=sagJj//deMqJMh8iivKuvA2fwFi5mEeQmuvp9rpshoHdcjaAghEgowFlRkUQcMb4+X
         zlmEyKlWdVIl13dyDp2D491Z9FWkrtA+vYnhQSEop3RYjLxni+zE1JlhnTfLFuTq8Qzy
         eV69LLcDLI8uGP72pvUNVBJcTSHdM0CU08t8faiHmlZas3UAD4PNlhft0GpftjxLi52h
         O6x1chrdH7OXQBIY7wBW6KXQYARFXJMjU0WjChu3IvsGwFTtvV4zjCw4waFrlupsoWHN
         wd6zKenu2LfZrfkvyOR+lVA6d64Caz84EvZc8ArnVJj7vDe/M6dWUOOrn3rB/VmlAk+K
         +ZVQ==
X-Forwarded-Encrypted: i=1; AHgh+RpTtUAWAaYBmXoyWkUkPwmBmfGJmg/YJvjc4GulNSQqxNOp1Id2dmdH0kbP0G0zo7alrwbZUAk=@vger.kernel.org
X-Gm-Message-State: AFuF++kEXY5ZwbCCvEQWvaeZcx6aG3+RJiYNqLlQiZoZCCPgZ6I/H6mb
	SZmOS9UHgxGhN9aYR9D4VvxAZcMHFshwIYwgAhovM85Ul+b8gwHjgOyhAo6/UWULcPwTB9NwpkO
	ZNfS6Q1TxZ2H0B8sD4IAaK8/1FRMs1mYgT2QLg7q2q8ixcpxPiCdpv7Pslkjdklt12nulrSivps
	78zXhL//UgfloGFt8o8RXyRQqtpyjkxmG1iw4QeCSXs0nSh7sCYxqoti3c1LeNHmgkOpyGV1zWA
	Eoyn49RFa/Nwomd
X-Gm-Gg: AR+sD11dCCm3uBV0ouK5zg4spWi1XEDIvz2Tlk/Clf6NxagO5NuJv/3JHV0/Dg3/dU+
	O0tN6mQPHWjGK1qz+DQufh72pSxxsJzLCu2GhpPBuTTsPVNNCxabK64Pe1Ao7HFPUaIqAANoUE9
	0XLsxjPGDCYQmDilhjiewvG7U9lKdw4rbfzzsptKMCe1hCJh68uQh7GTok6ZGzD15LwyH4KjpTN
	4MyaNEnFfTQLuiS0XjofpBEQkgbvBr5wjCCq8Bst4K3BIfZ5AAns+4WrUFUXsWC+6asOyjkqehb
	1Hmf7XZodjXle+iyrjlxudI8+iBZMJCRFhwg5Zk1WXr8qQHlnwKBsi0ghwRM5f9gBTrN35pDMoF
	Kr55GpkduBPNo1QUlLyCgt3WX1y7k3zn4TKFM4fwQQC4KcwU8QP2yRf6SHaUTMH6zrIqju2zqUM
	siLGJO64CATlQhi08uBXpUEhAmtx+oKb+mJ16F5x20
X-Received: by 2002:a05:6102:448a:b0:77b:4751:76aa with SMTP id ada2fe7eead31-782bf9b9609mr4569829137.2.1787785665363;
        Wed, 26 Aug 2026 16:07:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-97cbddfcb66sm842078241.0.2026.08.26.16.07.45
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2026 16:07:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cee1ec30f2so21326345ad.3
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 16:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1787785664; x=1788390464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q0gJbLAjrAkHetISJ9E7BaKmcamQMw9Vv0f9TbXVRXo=;
        b=Kvk5azJCojfz7v/f7d4JbxTzKWcIeSmCKDlJoJA01DS/8IZE5VJGu9L8eVaW2Z5iSy
         8E6nS37MfoV1y1jcXE40y/trhaAD8UULnfTi2RjRB7NMmgZjcTNi4SNILLg90DEHxFnP
         PelQzO3atMWxAJTytUl5eEfvo93HcniI5M0Xw=
X-Forwarded-Encrypted: i=1; AHgh+RoeMVCMXJWy/mOGPY1Ua2lno3YdfUKnLmF+t7gWBQiM1ya4KlD8UgYwJ9XLj4F/6YgBqjwTESw=@vger.kernel.org
X-Received: by 2002:a17:902:f689:b0:2d6:dfaa:c26a with SMTP id d9443c01a7336-2d707aca9c0mr173322975ad.8.1787785664208;
        Wed, 26 Aug 2026 16:07:44 -0700 (PDT)
X-Received: by 2002:a17:902:f689:b0:2d6:dfaa:c26a with SMTP id d9443c01a7336-2d707aca9c0mr173276045ad.8.1787785628341;
        Wed, 26 Aug 2026 16:07:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d885fb6sm11957547eec.14.2026.08.26.16.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 16:07:07 -0700 (PDT)
Message-ID: <f4b6ab1a-44f1-4e50-ae43-c55b080ab327@broadcom.com>
Date: Wed, 26 Aug 2026 16:07:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] memory: brcmstb_dpfe: Fix out-of-bounds access due to
 DCPU offset
To: Danesh Petigara <danesh.petigara@broadcom.com>, mmayer@broadcom.com,
 krzk@kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Justin Chen <justin.chen@broadcom.com>, stable@vger.kernel.org
References: <20260826201500.3000125-1-danesh.petigara@broadcom.com>
 <20260826201500.3000125-2-danesh.petigara@broadcom.com>
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
In-Reply-To: <20260826201500.3000125-2-danesh.petigara@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/26/26 13:14, Danesh Petigara wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> On API v1/v2 boards, the DCPU coprocessor can steer kernel readl_relaxed()
> and writel_relaxed() to any address within 256 MB of the ioremapped DPFE
> dmem or regs base. The DCPU firmware provides a 28-bit offset which the
> driver adds to the ioremap base without any bounds checking in
> get_msg_ptr().
> 
> This allows a compromised DCPU firmware to trick the host kernel into
> reading or writing arbitrary memory-mapped I/O registers in vmalloc
> space. When combined with a root-writable sysfs file like dpfe_refresh,
> it provides an arbitrary MMIO write primitive. Similarly, world-readable
> sysfs files can be used to leak other devices' register contents.
> 
> Fix this by recording the resource_size() of the dmem and regs ioremaps
> at probe time, and rejecting any offset that, along with the largest
> field accessed (DRAM_VENDOR_ERROR + sizeof(u32)), exceeds the recorded
> mapping size.
> 
> Fixes: fee5f1ef6cf7 ("memory: brcmstb: dpfe: support new way of passing data from the DCPU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> Assisted-by: Gemini:gemini-3.1-pro-preview cursor
> Signed-off-by: Danesh Petigara <danesh.petigara@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
