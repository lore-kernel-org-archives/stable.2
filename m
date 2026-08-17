Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2635944236B
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981134; cv=none; b=b7CHmR5fS1eJlLlT9eXUV6BoJunshPigfq9M3wDchbVOuf9D1ukts6ETj+J1WExeY1sbzT/igk8uT+joRsgdhle4mwkn9vSY8VWRqXBeM2ckfGQOTPXAU5Yl4S50j2GFVZwRVjHvSpdr8wp/JiPhL2iBb5B1kOoPy8GoxqKUNHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981134; c=relaxed/simple;
	bh=oBrnpScWWBrQJQdo/rLjHvow2EdW7eY5TmIXqt2jKak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h83DZc5VQ0R7UpjlnYMlmS+E1R9lvwQ7G13craDM2x9nHxDIWV+D4FlrKOm60J3H/JbIDztdPWNWjffph/ziND8O3byiaroruJWUo0JYqnjHxC1pIFLolCPANAxG8DkpOft6DUPYfGB+55Is3kGFpn157cto6OuU8m2OxQDebtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhZQaeRE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhZQaeRE"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d590f4c291so2021375ad.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786981132; x=1787585932; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ttFNIm5J59uLE19rktxqz0bELz7EGhv91DNjHXA4KA=;
        b=NhZQaeREbChotUbiwxnXBRAKdqpmpACrZlXT/8JPyHSU+sew1AZzbLqVwtwDXHejUJ
         41kgKQvpWQMlYc7kCg03LStHBAZWSCk3DfDqU0fTnxByCrMXenqxIHQEdZRUBBzdVf2r
         ER8nYxKbdPO9jP8vhM4j55IE+jw3PLK3Iid46X7Dad2nEHDjI7wNx3gt4OfAA+8kwdIX
         IJSKqfGszlI3Uk2xnf5rjzw0LXAUBjT6sALDsj2KEuKQ5ckkxu4KtOon4cqiDKhL2acv
         FiVOOjk9KS67vuhBiMUlvbCxBR2s+5Pz63p32WoXZcXhe0vHWyYHoTVHRAVXjYZvrU1g
         BaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786981132; x=1787585932;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ttFNIm5J59uLE19rktxqz0bELz7EGhv91DNjHXA4KA=;
        b=sWgOHn7tTbY6S6ldyD/TEcmQYm3tIH+SQbwpmt1Lx7kmntmx821waK0kr4lsYak4Nj
         AyESWEwW2HE3N0cmdHdHYucdS/SZJD9L9wMiGez/wLyHQgiFHkzL0O9787mK7FE1qi5L
         HKE+/1h47LqYFMtDZQUmWk+boTDNMzwg/ZLSoffIjEbngHidWtUdGIXOHKyfZuKY/QYz
         5r0Zhq8g5Kb/tdCFBqxhQqI74XPVhKCddRMOuZ2/JgFBfWK+KobcKbThZORdtA9EXCpY
         dci6PXkt63LdUPSYwqfdtbBC6lPX+PEUZZRJ1pgqhAAr2RVIbI7OlQRPVNSZrnvfeqK/
         MUVg==
X-Forwarded-Encrypted: i=1; AHgh+RqO0gBZ+z0Kd1iAAekFz8YgIVM1R5TGGvVeRalgd1b5il86omS44AesPb6udWWuwoN9TEzoGDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjCOCWdxx0zKUBkqx/LDhO8eihUhT6U3NDcAloNKTCdXpbYGTd
	V/fxgEvN1OKF8wj3w97EFpj98GdHq79mTHg6k/aGugFLtdtM2zIAzE0x
X-Gm-Gg: AR+sD11Q76Nh0T9M55EElDh0wrP66WdHdmn4IETJIZ9/6R6NW7tE29pF4/l8cvvggdz
	lbCKgcJoeKML7fhiSSPkgV/Ws6M73hWx44b7S4Cd1RrNpPwheAOMef9h/Oi1jFc+TBo/2ruVzgM
	SYckJ2T3Ay8oagnDoH/llVzQeSzZUKi82PoCFBEJKS8nTOjIKOAYTxvdmHe3Szp5yCSuS5kLI17
	bQO6xcI31ei3U1/SBMTr0z2hABDp32AbqUuTbA/Oia4i0cm7LWsGIPi0a+XMmEgPXxrusFzoa2h
	QtVA34efQJQV0VMIivIkKdm+giCOcjYaFOShoXn8BKk6XShwObgHiLxwq3HOYR/kHZwcIE6FfwD
	5/Ga6dRLvilzuIy3+OxRAHzAJYtHLaGUlLn76MywzVKWGG9Iz9ob2+OW9xiIUBnmrqJ/OqE4aOt
	YeRyQVXitwYK6mYdDxsQ7jZjq4DuC98VFyaquuizj8CM7XCuQ5GXl5vlUPay5mmW0PUcXsjgRu6
	YoTiLX6/YKd
X-Received: by 2002:a17:902:e54c:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2d3b0503575mr184872235ad.0.1786981132291;
        Mon, 17 Aug 2026 08:38:52 -0700 (PDT)
Received: from ?IPV6:::? ([20.24.212.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1e54330sm5304955ad.44.2026.08.17.08.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 08:38:51 -0700 (PDT)
Message-ID: <6933d09a-4dc1-43f8-a1c5-bc3db2f6ffb7@gmail.com>
Date: Mon, 17 Aug 2026 23:38:41 +0800
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

On 14/08/2026 09:21, Jakub Kicinski wrote:
> 1) could you explain in more detail why GRO is breaking things?
> GRO shouldn't merge packets with different L2/L2.5 and packets
> with trailers?
> 
> 2) the code seems inspired by LRO but LRO also has
> NETIF_F_UPPER_DISABLES. This change looks rather incomplete.
> Calling it "best effort" seems like an excuse.
> 
> 3) Clashiko has a number of other comments:
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809121455.1745-1-xiexinet@gmail.com

I am currently on annual leave until the middle of September. I will continue this topic when I return.

-- 
Xin
