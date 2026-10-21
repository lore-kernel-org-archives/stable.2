Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792553732;
	b=2I0+X3kGW1yzDeKepAPqPr9fuLUFmyLQZH844hI9GX6MxOpUK/lN2j4cB48tM7/e3mpA
	 h2PjFluFc3bwY2j75MDkgd49vwGUiBBHs9ig8fd+0Wyt8eGW0xl9SfXbNexuH4cRn+wgR
	 ltELMaOMZI6iXDtOz2CVZ7Wc13T8KJ6MRbfVgF9EE9o1zD4EAbfoU/AuVLw6SFKKun9pd
	 yhMVQ14Xh6MGXk81K00s3Qut+HO0PSPMaC3BTPaFTzk9XhuVP0CSGzHm/OMuHN3V+BVBK
	 EKF0riGHPNyz+3em+flnKb8tdrQlPOM4MpDbUUr/KjSL4DRNrpxmv0OF+X57XKd8BVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792553732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=oPLe3JqMkwYhFYfTROnA/4YF+cUNwjTAHP+fO6fqRl4=;
	b=vhKpf7BG/+aVGxauYmZcgxlhroP9+7jc5O6svWh2c3KLkg9/0RBDAM0U1s5+3i20nJFg
	 EkoQY0DJXEs+HDPbVfh2A/FB6XtJHqgPhuHDtN/50pye42xoqZZQlEeS/gBTajmNC++oT
	 hev38Vt8vDOZAxB+CPjko6RMKN0RNBa9h9GCXFsPtVT8/Re1GBXxaUpRcwk7DBgQJwtj/
	 HYsrhF8Tg4rZEQDPsqpDaaHgv3cX0wEGVPw+b9or0GOjwi3WvJTB8QhUSSxVnrKykxUg7
	 PnIJXAJmoZpfxtus08yKhwn81eXs6xsYaQHduMNXvf+l+c4O/zNgaLhEW5fT9bll1kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TVpIvV4n;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A12606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 03:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99A12606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TVpIvV4n
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f1f8f59a1so925185a.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792553730; x=1793158530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oPLe3JqMkwYhFYfTROnA/4YF+cUNwjTAHP+fO6fqRl4=;
        b=TVpIvV4nlJDTXMxKun41kRC7eXRkav02KYDYRyX/LvrY7eBqI5T5cJXj37c1DndobH
         tjZq4JEpHfW/TqMqCJuraJkUf+T5mEGgF8YaqS4YjZ+/iyyZZjURaU7R5yrFBSDswETB
         4a9cKq4vIcn4KeXk0tk8GzpZ54x2CJfggRatQobDXg0f4qzPblbYPG/7vdhDnxJgnGoB
         XRDbrhuG+QJ5AgUoy2+rUBxHCNDlinTFset/cqzuSFRvdgf2WfxVC9jU+BhJ5FWKy0d2
         9oifpUC5fdq+1d2Zq/RTfUreRrJ9CDsm/5zGzYM7/FpsER3cN9O9FtYzQeLTDCga48Y4
         CRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792553730; x=1793158530;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oPLe3JqMkwYhFYfTROnA/4YF+cUNwjTAHP+fO6fqRl4=;
        b=q/Ryus1hZAy/8nehYSIGmtp1lw1p9Uopm7pDhVDyxNKvJKIc25cXauG8x71qXQ0+aa
         gq2m4fnxY/PY1sa6KSI/JMpbFAVEuEhE/+wDsuUF4MAOjJ4wveCoOMpfMsXDsC+A4T1f
         4XPnU4b7N93wwnedAr8D3MMmnheGXcOp79s5iPqwkxJ2SxBKzwLfva45sB8Vp9L2h3Cu
         G5YV1jaj/W3LMbJc+OlxhzkGuv2RaXOE/osZl7KOmV0WkxN9gi6L9/FBh9UK0AG+vBKs
         7ClDC/Uo9Y+cQcMPZHCuKpRPcoub9gHAr+rn3Y4O2iqXz99Wdmdya3pNclaPLAMgaxiA
         BmNg==
X-Forwarded-Encrypted: i=1; AKwUvBy6LUYEsAWiFQqhnLXlIKLWxdHczQXx9x+ocTky0vVjqBKR7+vjNJi9ZGzTaBwf8NRiNYPvm4w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKK8WuQIRRsBQgfabB30/FgNg08b5ev5rWjL8LKiiw8VMROL6NF
	FVHt1KbgTcy9Fcnz/X+EBVGvXBLjFKND3U5IUFr/SwQncLwqPruNL8Me
X-Gm-Gg: AYBFou1n+rCeFlZF5kFDvXM4hOQmQenIcVd4SEbsJqA4wmIiJ9+aIBdlnpmwBtH9vIV
	/xOme4nyHgUFwygS6UZKNmqUq2qH9eyRvDNKxABUIXiTkL/FCe0+Hv3K7KmuB6MC8GWDjl3dJLV
	kAzzdDTsI6RapVNSUZkJ5drhZu5Nw5hGiaC1IPRUzEg60jix/Cg3CJH5s+nhzwDoZxQieijVFVO
	f7WxdBMWwPdcvD2N3wIKxyMCRa3TwTtFu5aHASEOzalqcWgAqUe2D1V8lXlquo4SAD6yzTG2n1i
	qifAgXqIF23EhXDU8muB7IZF5o5tNP1oGy/7H5iT19cL9HOREI6K4QPmSMR2HkFNa2i9D4KFYhT
	EfmaxQZb0hn2lV1VkDGSJkD1kpmnze4Wg12DxDJAwuulWCBYEI1Nct3flh5vMTQCTFXfk9dv3QF
	tDU+w106tJySnnwGCCNcsjQ5+mmPWVCbaz+Q72JutoW9Us8Mh0OYweN+Do+ZrqLuINcYm7WVoII
	UGsPBL+TpKh3+XQDQmFns9NvNBxqBwl/z3Mf6UTTf2cwpN3ilnp3G3/RxSZ5TnNXpv78uN/R7e8
	2DlvM+dTW+OEHQKG5b1j/J6O
X-Received: by 2002:a05:620a:800c:b0:93e:5a3f:ac13 with SMTP id af79cd13be357-93f57dbbb66mr253545085a.0.1792553730527;
        Tue, 20 Oct 2026 20:35:30 -0700 (PDT)
Received: from ?IPV6:2600:4040:498b:e200:2d8:61ff:fe7c:5d59? ([2600:4040:498b:e200:2d8:61ff:fe7c:5d59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56d98e5asm144819385a.7.2026.10.20.20.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 20:35:29 -0700 (PDT)
Message-ID: <3a043f5a-9ff3-e22c-08ca-0a735b45b025@gmail.com>
Date: Tue, 20 Oct 2026 23:35:29 -0400
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH net v2] net: sunhme: fix infinite loop in
 unmap_partial_tx_skb()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Denis Arefev <arefev@swemel.ru>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org
References: <20261015114355.14906-1-arefev@swemel.ru>
 <20261020124001.655104c9@kernel.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20261020124001.655104c9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/26 15:40, Jakub Kicinski wrote:
> On Thu, 15 Oct 2026 14:43:54 +0300 Denis Arefev wrote:
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> We don't take LLM fixes for ancient HW drivers

FWIW this does appear to be a real infinite loop. There's nothing
in the body that modifies the variables used in the condition. Based
on the original commit, the testing probably did not actually involve
exercising this function. I suppose no one has complained about this
for the same reason no one complained about unhandled DMA mapping
errors (DMA mapping mostly succeeds).

[1] https://lore.kernel.org/netdev/20141031.134354.207893264084946385.davem@davemloft.net/
