Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462335;
	b=IGzMXasIMhjKBjm67lb6S19+LMkT9/4vcqGccqsPsTToUJp1+W/xRlCi7WeKocXf6NSG
	 02axYodGqFBvcgZP4KNXdac79XwxqyCsirivO3RxpbA/wwXByMCJiujasewfpEoZHLvff
	 mnOJvlnsuIQ5muPWR11nRbl9Z9UqH6RUcEB8woSsYzZtGt33li35zhAVetWJsJAv3oI8P
	 +y2Eqfq3Ywg2gjy2iNfrig3BkgwHGVnONe/ZtOCfVofR3cTKGUj5KqG3nGGm1zeo5XfoA
	 itpSJRtrjID+g+l+4n4YEzv6obsQ0jQAteZMeE/WIBgRnt2rNJnPTdBZiKlZAjFAk1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462335;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=ZhoRZJWv5WDLgSJ4NW+wzm1D4iqQUFLyqGAdX1OGoBc=;
	b=26FKttoRA5UJ8HuiqhRhiFx6ddt51kRrVkYkUJ8eWlCossANQk1t3mVHxiLVL22PD5X2
	 zfn3wrv7w9bggicr2eO5ymj6ABFEjE3tsPknOHY1dLdALmepRh5qXKplVAdCVVj2ToeoS
	 vIWzdhCj5RCPJ5KFp0ac4CZaimQDnKUyGqpc7RFKoBbWt7UNed5f+BI9fOq2zdVCQ3zZ0
	 gO7mSxQBM0DAg1eUKr4eny+6JalbrFKo7mreLg0bGgDhCnSrCMbKDblqY/j1I8q597DtV
	 471L7oqCNrdtuz4aD3dB6WJjn8mUXyGPsF4raOkx5giFBXmRM0vY1h996cR6gxqm/uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=D8IR7l22;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA50606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 19:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CA50606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=D8IR7l22
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3b44bdcea8aso1560819a91.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 11:32:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795462334; x=1796067134;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZhoRZJWv5WDLgSJ4NW+wzm1D4iqQUFLyqGAdX1OGoBc=;
        b=fX0sp9xkwbTz7Ov+6YYDwa40DmK73pD89Xw5PDq7n9tZBVE9uUrBBvXc4+uPp4/GNI
         Snkwxbhud9gaePh+kd0IrXsssAy3JCC11e+XpD5dAOBKjh19lXWf+odc7odoV/q9PIPr
         bQJBbqJ2INsHxdllBRk+z4lN5IUmHrHg2OpZuDyDbB+mis95jLzsLjo/GD1UAanJpiAd
         eey4IbOfm3VTMm0PZCw7fFg8tsHVHhHHhyN9+VJX0R+HHA/nHzOSqy5dgmC8HQ2Y0Dz3
         +o2A+NlzCcUU/Zh1Yv6VVHNT5hViPRTgYcPReq7uXIG/UCk0Fj1eU0SRNzACCIkTLbhH
         KbWQ==
X-Gm-Message-State: APuU4Z8LUzDAJbJl8C4b+Ur7WFziHx19bG/xY+Hptgi9XXGKz00ljoS9
	7u1QKcHULhl22YIFXUfg7quSfTV+YnW0eoa9JyX0AlfSLbBJ3VWQpQxTxt50ZAhRAYomSECrkB+
	7w6EbYLGUfaFD9HRMsL5wl4CadOAZSGrkm5v0BicJTyt1hQIFj+27p0ih0i890C5+4EfvwQxuWr
	ezyuR1dXTNNPsJe997gpz8KNW16CKEDz1rrlxjkmoXJBhp7WD0BSMD/QmdmRSRzbSgr3WRBIByn
	hWDq2++4zycVkKI
X-Gm-Gg: AZFdTZeoZmrS0P/60SuGlXkvsNLZH30/vAgsO7t/TE/tjERmVRXDI54ytUJAHAe5yHP
	Ek+A+CsdonVUMHfeADabr3U1BfhtHbS8e8weE2dI6/PbPyjAfeZDew/NuGwePu6McVmUquBBRtI
	G0jOOfGWALJFbzUmRInVbwV70ydTb1U4c/JPDAevmrokZW1C6G/sWwRzwbKq7CrCfLSA+Y5FfH7
	gu8n6+HB5f3Se2uzDn9mfPlOfWVKRrrGygc53ahSOsjb401Q9AeRiBc0OIxkh9i1WSn+/woO7Ds
	uKbnpiQRmNWHNIaYFizwlOjbsw+QqMuaELry4tXppxtXonKtoxpYLzcG71qZoP4WgJNSuZWHcgn
	noqs/8nxj4pJpmeUtNWR2SX/xvTxwgE+nAGEO8sMD2vbid57Y2Zoedo/gPB8QRuZrG8nDMd2B1v
	BwUbLm9JfxP9RxurhJicvCYOZMC4V/IreWoiGPYxy1
X-Received: by 2002:a17:90a:c10e:b0:3a7:a3c8:8f4a with SMTP id 98e67ed59e1d1-3b41c9080c5mr8196180a91.18.1795462333517;
        Mon, 23 Nov 2026 11:32:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b4062a77f5sm10007167a91.6.2026.11.23.11.32.13
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2026 11:32:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3817a0ffd5eso4542606eec.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 11:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795462332; x=1796067132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZhoRZJWv5WDLgSJ4NW+wzm1D4iqQUFLyqGAdX1OGoBc=;
        b=D8IR7l226jkbPt2XLGzFEHKpeTcJaBjbSqQsPqZ4b+DQwih2VLzrUFRMbRraJLMovl
         HQiaquV5UJtPt5sWGhLWFQKjTH1xYDbOJ9fl76z0bqCCbgp/epo72Jc1kJY/iT4nkJj4
         bltyeyFPizUCr+Qnt1NacASIfizPqZyw+2iWY=
X-Received: by 2002:a05:701b:4550:10b0:1b5:337a:6456 with SMTP id a92af1059eb24-1b55247eff6mr12630854c88.5.1795462331714;
        Mon, 23 Nov 2026 11:32:11 -0800 (PST)
X-Received: by 2002:a05:701b:4550:10b0:1b5:337a:6456 with SMTP id a92af1059eb24-1b55247eff6mr12630821c88.5.1795462330903;
        Mon, 23 Nov 2026 11:32:10 -0800 (PST)
Received: from [192.168.10.3] (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm42340205c88.14.2026.11.23.11.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 11:32:10 -0800 (PST)
Message-ID: <60b6bd4a-c508-44e2-ae22-3f8bcc594457@broadcom.com>
Date: Mon, 23 Nov 2026 11:31:49 -0800
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
Subject: Re: [PATCH 13/13] mmc: sdhci-brcmstb: Handle absent optional
 sdio_freq clock in probe
To: Lee Jones <lee@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson <ulfh@kernel.org>,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261123191703.179283-1-lee@kernel.org>
 <20261123191703.179283-14-lee@kernel.org>
Content-Language: en-US
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
In-Reply-To: <20261123191703.179283-14-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/23/2026 11:15 AM, Lee Jones wrote:
> Standard MMC Device Tree nodes may specify "clock-frequency" on SoCs
> that do not provide the optional 72116B0 "sdio_freq" clock, in which
> case devm_clk_get_optional() legitimately returns NULL.  However,
> sdhci_brcmstb_probe() only checks IS_ERR(base_clk): when base_clk is
> NULL, clk_get_rate(base_clk) evaluates to 0 and overwrites
> SDHCI_CLOCK_V3_BASE_MASK in host->caps with 0 MHz while leaving
> priv->base_freq_hz non-zero for system resume.
> 
> Check IS_ERR_OR_NULL(base_clk) and clear priv->base_freq_hz on the
> fallback path before jumping to add_host.
> 
> Fixes: 97904a59855c ("mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0")
> Closes: https://sashiko.dev/#/bug/linux-88799a75-1ece-4f9d-bdab-eeb713627ab2
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Not sure this deserves a Fixes: tag.
-- 
Florian

