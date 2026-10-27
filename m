Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141709;
	b=qKbGks34WB32ju9XhnpVDt1BRaPaz7NtduS0bddTFR5Ct3KarsU4OypSn9QCWyslK0cI
	 jAxj/yr54XT0hK8fYL6XPt80Xlzvmn+T2ciWi7WueTJrj7ryhZB9X1NMxTRovlSKTN9BL
	 +KdO8fLyrOpGSYJ/hN5BXe7bCvRcA1UvepnxMRuplQJEtHua4tQnflc00XCWLiysrSHZd
	 TSuay+w18SXaD1U1WQLueRGUfRMoFWPKZQtl+Dx6jDOenHpCNl2ZkYQQLMPsUIGyJAYhP
	 9wrFiTXlS5CB4In8uY7j+3DQoboDyBGynZAdfD5pHJY+X2mJTON5Tk2yAAlwxEZgZ/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141709;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=+6N+Jms6EdQM8CFjQ6BDl0aRKTJSrgGB/6/Z+xj6T4w=;
	b=TOqS04d6DSl3lOHuOGz/U2AwPLxD9dXOZnBmk6pZT/3n1/8Ie3MNF+hd8Jc42WZddjfB
	 FU0JURxWnbZowsuLlXLukNeHgVVoGEcxITYdKtQwHpssDCPiShwIIa5/a2qe8NoB0KwhX
	 Xjr6yMftCx9rBYcKWjG3vDloJoExEbrW+Kz+mu7ak5iLNnJamDOgCwr0hbtzRPZNkhfrr
	 jt1TUXBa4VJJS0PWyORY7Wq4ND/BuM6RotKjIb74HJmkZ4JwyWU7pC9Ocis8FlSRYQY32
	 Imed4gjKbu4U8b4a1Rc3EBWUO/OpCXiTdjXS3ZkFalcwOtpAN+uKNJPNCg4Ov8LZA/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IjKzF6jB;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4762606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 22:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4762606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IjKzF6jB
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so258603a91.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 15:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793141707; x=1793746507;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+6N+Jms6EdQM8CFjQ6BDl0aRKTJSrgGB/6/Z+xj6T4w=;
        b=usdOAh2zqWJZO06RITHKyo5YH7EgGnWDc5I5876/GtmUrNXSFX0TAOIRlY9gzRMfkh
         ElnLlwDmyyouvoxvI4HqoVPNpFwhnkW4TP5k0np64IUVbWtDtbFDrv1xCuBsEkh1Fd+1
         Tw84/sRd2QJr584ld9u/SAKVbypVbeICToeG9KKjEaS1TsFmKszSMWyzrMx6Y2JoLVBA
         CAnq7VvBpGFl+TNsPT+79qT8Ud/r6uOmgXrPJ25L93TM/NrF7oRp11C9Qk6C3SUVNskX
         Q0S7Kwg9y31Vc0V1wvprC7D07I7WqnoefLN9bnhGXJzmpBAqF6iS57s9wNo9756FQoTt
         81aw==
X-Gm-Message-State: AFq9FYLLcZ6kBMDzYxZPu2Q4E31pO4qlsQ62BkHouA6xeZZsKiNADwPp
	W2SAw3swCWZMRaNZhlIfBYAPEzJRY+OXzbxtE9RuThnGd4Mosam4V+vCdj/Hv9r7V3NnI44W2kg
	IfMFDOZudrSCErpiIm7+DCm+PkTaWujyHDNA7Fx6+ZZH8Dbiys+gP5UgUkDf9Hm1M9B6uy6YGDy
	5Qx3uu8sxbJ28U9OkY8rNdLovi8XZGUvHddWOr8GJqnxI6xlBnl/phE7qOZmBNYtTKWWpNB++2t
	hl0UyveiexslUeyyAQ=
X-Gm-Gg: AYBFou3XUYEZZJC8NPONU8JMWLeCJTJt9VP1OEc45eRDrN7S1CM14kB3/WE6XUfki0O
	ApzOR3pB8PV90syRw4yuljEkAYUi2MWZz/iSyFa4riQtDbDavtxbGxVcyt+vKpbXT/8YZzHC8zt
	ahTYqDBqarLKuOdnlh3Yyoxn+rUebQxUg6zo+/KvsJiG1f5IryBAmC01Vg0AkNcIjrO7rh7kNQ+
	9DlM0L/KD2OVo49JOvlIJL7R6eCrN4XSAk8ORra5IK+Cxj7fgftEV1HRSAOw1P+mGkobUzau+Ue
	bk9fwO3+cbNomcWnuR9J2+lycOa6+cwUw+bZsfDJyl11JNXEPLvzHib7GKNbXM+dewzFUGnr7A8
	MX3wTL8V6lTgSgvXaGnxQxIb9cC05TCKUP0lwXfV+VxZBIq+ZYeN915yJtHBTZWUsTqxNTxng3g
	WJRFOOcn9VHo/Lit+h288QDOulL4pwcdE/7BD+5EDBJ5M=
X-Received: by 2002:a17:90b:564d:b0:3ae:533e:7e3c with SMTP id 98e67ed59e1d1-3ae58155bfbmr369745a91.35.1793141707153;
        Tue, 27 Oct 2026 15:55:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae5ac44609sm119668a91.8.2026.10.27.15.55.06
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 15:55:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-14373747468so339791c88.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 15:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793141705; x=1793746505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+6N+Jms6EdQM8CFjQ6BDl0aRKTJSrgGB/6/Z+xj6T4w=;
        b=IjKzF6jBzFiCVbTzEGMyKw9WUZurEE0RXHusuT/uO0ZOp38P8RLGznU6MPAO6nrXQr
         CXYHI8aGzDk9NShPTQV0QZ9HGQYzIw6Q4B7m4E2+mBPAznCsuAvKph29og4IB0h6qoeS
         dBmw5EFurzXwBASMQ1RlDznRRNSsKRT8m3p90=
X-Received: by 2002:a05:701b:4288:10b0:136:b50c:c0e9 with SMTP id a92af1059eb24-1a6ce9bba59mr860587c88.21.1793141705342;
        Tue, 27 Oct 2026 15:55:05 -0700 (PDT)
X-Received: by 2002:a05:701b:4288:10b0:136:b50c:c0e9 with SMTP id a92af1059eb24-1a6ce9bba59mr860547c88.21.1793141704694;
        Tue, 27 Oct 2026 15:55:04 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a6d98c8da2sm1105224c88.14.2026.10.27.15.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 15:55:04 -0700 (PDT)
Message-ID: <50fc3275-863b-42d0-863b-d0594d7779ca@broadcom.com>
Date: Tue, 27 Oct 2026 15:55:01 -0700
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
Subject: Re: [PATCH] gpio: brcmstb: fix UAF after IRQ domain setup failure
To: Guangshuo Li <lgs201920130244@gmail.com>, Doug Berger
 <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Gregory Fong
 <gregory.0xf0@gmail.com>, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261026115227.41779-1-lgs201920130244@gmail.com>
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
In-Reply-To: <20261026115227.41779-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/26/26 04:52, Guangshuo Li wrote:
> When devm_request_irq() fails in brcmstb_gpio_irq_setup(), the error
> path removes the IRQ domain but leaves priv->irq_domain non-NULL.
> 
> The probe error path subsequently calls brcmstb_gpio_remove(), which
> checks priv->irq_domain and attempts to access the already-freed
> domain through irq_find_mapping(). It also attempts to remove the
> domain again, resulting in a use-after-free and potentially further
> memory corruption.
> 
> Set priv->irq_domain to NULL after removing it so that the common
> cleanup path skips the already-freed IRQ domain.
> 
> This issue was found by our static analysis tool under development.
> 
> Fixes: 0ba31dc201de ("gpio: brcmstb: consolidate interrupt domains")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
