Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866825;
	b=qfhtp9MuqODbAxxQvoJCvqcdSVNXksGNZoZ08Owzkzt9nYcuYHnhiZDXrf5TgthdzjBg
	 5+1F0xWSQDlvPmYbb2XJV63lRboEJw8R5k8bAcrII5UIcPNwfsiQiL/aSZUr6qr2jUwPV
	 1wV8A0/SFfLAnBg3zqDvurtQ9G4X9Z4RWMlu5jXQ/CvRL9HyRYe0uL/v6JGANsMUhAbhk
	 dV9PhLeNA0Yh+Ri3a338zIPjvpeVFKTfit1CG7swW/1gIccKgrL4qIHtedI4byfoKxBHt
	 1hPRKnh2JMDQmv6bejRKjaEkyhBRoS5F2ADggSKvrY/0+R268r0fizBvZG74+drB0qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866825;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7SqvBtUFCpw5NHA+FIMIJmAFl8K9I4MkTlXE+t2fvpg=;
	b=V2xZdtkuCpcKN/P1Rpyk6EDrpxAHyDlBfUAAifKSOaNj2wpfQ0Y5Ogz9KakHac/5XvfW
	 Ga3m13JxkyNtTLcr2ICSMZS9yhu0LYhgugvhw11VAFohIBCqYtTSktg/3fl5UZXIAX7vy
	 ZO5rgGHBI6MDfWz9HNk86jl9/gf1btOR6K++WyYHx31C1tJq2Uu11SFZnSThfGc5DnznG
	 IxRhcEz4+S2cj1pSrpNYvBqbmg3Whj8q2RnqlJj9dvsciwfigF4Q/8pWmptV2DYLv3EHf
	 wqwtR9W6Kz1MhqJspsCymJ5hhoUKWqDL2es9wWlJPmAdyPfySXJaaGBs3tNFFEZeDEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vg22TDiB;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ERqhG0AN;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADBC606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ADBC606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vg22TDiB;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ERqhG0AN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793866823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7SqvBtUFCpw5NHA+FIMIJmAFl8K9I4MkTlXE+t2fvpg=;
	b=Vg22TDiBJDnhHbZ7Pl+180HoaGvnB6m6FJ/VAyyBrGllE5U9k98zt7uvvlaS9OHHnC+fHJ
	81Y19u7SE9PSwNqNOshnxrw5OSv7DPCenc1H3pRKFQX6Bze60zQIj6RMV+PrbJAI+QGZ2I
	B5si15YiNPV2taO1ODQFHgNyEz6Dtr4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-Cu7D8vf_OlKPU-yrwuKoKQ-1; Thu, 05 Nov 2026 03:20:22 -0500
X-MC-Unique: Cu7D8vf_OlKPU-yrwuKoKQ-1
X-Mimecast-MFC-AGG-ID: Cu7D8vf_OlKPU-yrwuKoKQ_1793866821
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a2063be13dso16397015e9.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 00:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793866821; x=1794471621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7SqvBtUFCpw5NHA+FIMIJmAFl8K9I4MkTlXE+t2fvpg=;
        b=ERqhG0ANIDuOTgPfookFk2oMxGQOH4n7cdFFXkfT3zus0ZW3ZegBiBZDWA8JU52AMC
         LbWP4UAqvKvvDB9FSWz98JXI2uaIojfUamIG0nkq+ctWfbf7pD6WDG54tTTPv/TYR3xC
         cfIjZYSsgspQuVAzv5F23bQHC+o+PUE73xLOuBKhMlrDwUNpMuMFetGTaGGRWYpmDJJr
         qlSCCIqBy+kc63NOVVJYzqGC6Jm2g0mjftQrZ/lk8JGffS8Hd7dRWYG9cXFXgFjBkHuR
         tIgTLqfniAgAfw6qeUtfJS3Q8hv+xYrY8e7H1Ky0y/RDDVgpX2tLKprcibvix2o0jBOE
         hCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866821; x=1794471621;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7SqvBtUFCpw5NHA+FIMIJmAFl8K9I4MkTlXE+t2fvpg=;
        b=Rr9Olu7eotdLe/DsQFSIDepiIbIR4EqLzyj7ujCjHlA+SuQGYZbzA5ABms+8c6vBXO
         XdJImrsWsj9i3NvFM/oU6u0qZUsBaWa28y4AphawJuZHv1KvENk5pfHjzWqQU1HikMmB
         NVcIxh2gMJMxPEIFv41DAFNjz9+crEobjPwgLoHb6aHkNVRufOIVPMU8JwQ3FqiIkNYK
         a5TDb4vKThbkDnLDmAUbkGzv+GdSZ7Y3qiwAJaARV4q13+sR5hMppcr6lc0L+KjmYqhg
         s3lniRAlu9rAKgMxpOTorL2ihL0E0Whd+IRT1m6XqGQi2h5UCopvGbhaVqc8JDCfeG7s
         o+wQ==
X-Forwarded-Encrypted: i=1; AKwUvBxvy4JEkx2gFydie/gOxapKf+e7ptdgGTbeL4pQ23mN4j9R4CTGH5RLlFZ7C5CWrn43Oh+qQFA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FaE8u/QngutV2q9crsIFH5y9UTOq/Cgre25CR1b0R0a1wDp5N
	ltqZj85NxAtFCrNg7OkJUQLtOUZvzBt0onhkCulev0disBoR9KvdDKCMviGZaFEH5sH9vxTgPEN
	aA1dy3yX5HNBlpOlcp4gREXt3OSBtCw6de9j2Pb/HkZ9fS33gDZfKfqo6SZ1OHAjZJg==
X-Gm-Gg: AYBFou075WzuHZpgzgmLMVo3vqBCQOVyPXBRpTNew0Y6DNK+ssWqk1hXC//0xJXpUDO
	Nqii0W19oaXdUbgM/y8aKAFxVkHHNtDEIauvSYg/r22N7ovcaT05vZvJ/KjVbkaT8jXKv2WRbGI
	5xaPm26HkB8xEVwxjAZ7O9SWuIrmlmur4PQa4CBHyK/nGWFJ2hh5kzDUzgxTPRMrQLVdvB9PTz8
	7R0vI+jFGOV27RUoTpjLRgq9oI1xnNWWZMOHfpNIGvRHjAdUktTlKFp8q0yjCm3rvL3lVYeUrTm
	HPpFGri/u2uNu9wJCwF0/mtH/U+WQuBpwUTCuovXfhn7wTW4mFXA55rtI7l4OmWbQqVvnTaQ616
	H6QPNmx5nzPjje2SKc+cqp+6Z1WKazKl5v+ynh6wUy2ipf/oSNhHwaFjbsVyUHD+ntJA9n/V/dn
	/lfbXFXijo2Sj69HSKMI3nHmQSQ9Y9wg/eoZwHsTDpzPE=
X-Received: by 2002:a05:600c:1c0f:b0:4a2:150f:1601 with SMTP id 5b1f17b1804b1-4ac1709a7bdmr421751155e9.12.1793866821333;
        Thu, 05 Nov 2026 00:20:21 -0800 (PST)
X-Received: by 2002:a05:600c:1c0f:b0:4a2:150f:1601 with SMTP id 5b1f17b1804b1-4ac1709a7bdmr421750595e9.12.1793866820846;
        Thu, 05 Nov 2026 00:20:20 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fece99d67sm8729801f8f.24.2026.11.05.00.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 00:20:20 -0800 (PST)
Message-ID: <ca189d78-e981-4e05-877d-8b4e4857c4af@redhat.com>
Date: Thu, 5 Nov 2026 09:20:19 +0100
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
Subject: Re: [PATCH net 13/15] can: dev: can_fill_info(): don't wake up
 controller if interface is down
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, liucj1228@outlook.com,
 s.grosjean@peak-system.fr, stable@vger.kernel.org
References: <20261103204305.3211144-14-mkl@pengutronix.de>
 <179382521036.488856.13184139645230625670@kernel.org>
 <20261104-prudent-mottled-gharial-1bfbfa-mkl@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261104-prudent-mottled-gharial-1bfbfa-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/26 00:08, Marc Kleine-Budde wrote:
> On 04.11.2026 20:46:50, netdev-bot+sashiko@kernel.org wrote:
>> The commit message does say that the attribute is no longer reported.
>> Could it also say that this applies to all CAN drivers, and that it
>> replaces the per-driver support for down interfaces?
> 
> If we need to re-spin this series/PR we'll update the commit message.
No need to re-spin: your replies make sense to me, and my understanding
is that some follow-ups (on next) is the best course of action.

/P

