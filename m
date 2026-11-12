Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495933;
	b=HaENfltaEUr5LmdPN3+/Xi78GFSpfpr9yFr2eKIdrrdJMl+/33tiUL07F5cujqhluCNw
	 CriUi2GnGPILYNUPcCeDWHZwJV7GUPN1DSr0uosPNFK60o28Yn/2SQ7U3U2yU+0rJNpZe
	 SgZgbOlN4kLaWMAWsU0ChRxuPLPQ7lb5yEIlHPJQFL1VmuhiepnGOJ7ebS51xiINScnuH
	 bAloM2lMf7l66OC9mAP4aeMMSNBrXBnfSiFUeFUVAugt6+zCJbA1j+ZGP+OM5BxDMoZKA
	 xUzOMetddxrZZhttsK0OqqLymv/GQuNECYqQvfbwSBoIGvu3yDirnYYKtke7RENQzTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495933;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GOqpkyo4LPYyLkLcWc/OmF1B6GtriSScGQCA7EInhEE=;
	b=IIPJ83ZQs0pj4U/ZVGlshiVEcNEAmjH4jEeCbXte3YnQj622lme1P40m5OVfegPDr0Uj
	 EU19AhldJfzIRnBbrls0QhuIDRkeBFQW+/wElxBGlyWswZ75km1TQkrvNhXrp51/8n7Xe
	 QSSqLbw3q6eYeoouK4LFT2qTV2Kt4nqr085KJUo0N/KyFgkzqEO9qpUK1K9VHPUn7xxlJ
	 kchqDn1LVuj6j3hf22pWw26LBu0FUJVkmOz76+d18uEhX4snjpsWlIYry0pR8KPdVobog
	 H5ZeF8SeT3dI5TDyN6Ks79Zfnx9/tadDpO3EB5cbag4wyOH/VQeJT8sNYO8uOtGqxUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ez3blgOu;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="F//A/5n4";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46502606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46502606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ez3blgOu;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=F//A/5n4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794495932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOqpkyo4LPYyLkLcWc/OmF1B6GtriSScGQCA7EInhEE=;
	b=ez3blgOuE9pj3UAeRe62EYaQpHQxYKfuyEdcI5KGCHTfzmtFa+YWyToL95acBtq5VPKC+k
	gmDGMEYabRwYP1Sh7LNqHnaM0Ii6/cqAdbV3EwauoI+/wi9K7EOV09RrcNTdWy2aBSGEQ6
	sq2HXITT2lVYIUjEQ5/eUpYuFLp1H1Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-kZVI4-eYNliSQ2MIijsKCQ-1; Thu, 12 Nov 2026 10:05:30 -0500
X-MC-Unique: kZVI4-eYNliSQ2MIijsKCQ-1
X-Mimecast-MFC-AGG-ID: kZVI4-eYNliSQ2MIijsKCQ_1794495930
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a4654add56so37139225e9.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794495929; x=1795100729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GOqpkyo4LPYyLkLcWc/OmF1B6GtriSScGQCA7EInhEE=;
        b=F//A/5n4pQpDyMCnhlgIVbYdrM7RbFo+BdEuiCYObiEwZSLgVxjUXaSj8siJjlevCs
         vsX2pH1A+BoqXzfHhTjCGYtRJKd/JwEVaZXN1Pu38YkEDBmK5e3p+7hld6U9gjKRtene
         zF6qrpx/7O2oOvop729rO2GJF3Y6M3Ho0QTklkiARvJMLF6tYvJ/BLWzytxrnbj6THWD
         ngbrtqSnAcDV+uyL3iGaAaKxR5Z7M0PoNDy1Lbo+0k/DFjBqrYGTRaBPSQYUfv0P8NbX
         IT22NqA+gBevaE9Qp6Yed4EohOB4oH7QcEcLdJiflhxIU8Yimh/k8KYVUvYJeXSERYkN
         +4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794495929; x=1795100729;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GOqpkyo4LPYyLkLcWc/OmF1B6GtriSScGQCA7EInhEE=;
        b=Xs15DtoxnzQJmLHiFplpAPH3MbIoqrc7BoqOxOBobc+gb7E0sOUtdBcmxQ+MMg5Afd
         g6G+joGvKHyZ5uwx3GnK2NPWsVGEZIN1uq4Bkc153r5XESFxG/eIQxmDkDWWbDFRvVCZ
         BuJPgxb7/AfmOv6o3ZiI2Ea6AM9Lb2U/7Kwb9jqWrfk0bmvTZZXXcOkOXSP67t2cOdzJ
         DMUlHPG/9JY0ajd37fb8blqZ45d9BbY7hc5mIc9vnXECVqrV7SfjUP6BYf3Zw5IxiXy/
         dbtT+3Em525jJfuRR0skIP3Eg2mY5FyOAK7dRykF81VW+n45xXO4fg7I/KaId/qbQqW+
         lBvQ==
X-Forwarded-Encrypted: i=1; AL+hErHMLxcpY0a0JhKvh9cbOVQt1EimIISuIgmudwD9oyNA9RMTDCoNaIiRK3YGYtalENDIudbjUq0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SRgGvj1EMkXTV1BOD4NrMbiFJ8F0/6D8wIUm5HkxZ7VcgYu3T
	uQ9gZaTVgzT9gx/APVP/tup/x71d6X3BGTtmUwLw/Fsb7p8JVGFrfmHGktiYmmKAH0Wy839qnlU
	KeaYWhrgUf0KxYJKDpx/KE5Y97b30Bn/5U9OurUBjABL3TmSlr0a9zWLaHg==
X-Gm-Gg: AYBFou0SySDrfUWKwvE+D8W9di/bwKfivysPcvsnh5oOEo6WC4tkvXvt/64h2Cp10u/
	7tDO/sacp48h+GYJtB3gd7OpxFwlwql08z0XRQ6ToxETmon5QQVCqISEJg7Km9kM2kDOb7Vznu9
	uKHMlIuzM79tAaWxVAE39Z146i0+RfnNo1B7syfVdgcBQr4SPH+WJ6Vvb6qeB5HGNfLNApk3to4
	XxHMZ3C3maukOeVkJU9k2juFT+hbG2AKjxpzxPEHhsircMO3bY9CPVpm6K4GjZbfIH0GhCMhiHb
	CEM78LcDHvI1Ld378VDzFHHBO9vCPfYsvC8Tmct8BEjbf0t8/zr29zV7r64ARogRdd8VdiQ3U9P
	oe5tXJdAy75fYLwwBhPAAGUhWfnkfCe8SoaDhFrFnQQVwzadm4ZgfQSfTAHZXpf5gQcForgeOiW
	YksUgoW2pb/xV7g4I5qpmmXqU8vFKYU1zQuX4FJoChcASu
X-Received: by 2002:a05:600c:1389:b0:4a1:f8cb:7d70 with SMTP id 5b1f17b1804b1-4ba09388518mr111954085e9.24.1794495929600;
        Thu, 12 Nov 2026 07:05:29 -0800 (PST)
X-Received: by 2002:a05:600c:1389:b0:4a1:f8cb:7d70 with SMTP id 5b1f17b1804b1-4ba09388518mr111953325e9.24.1794495929170;
        Thu, 12 Nov 2026 07:05:29 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2842e6sm75067305e9.4.2026.11.12.07.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 07:05:28 -0800 (PST)
Message-ID: <2dcdcc8c-0484-4fd0-b09e-723b32cbacd1@redhat.com>
Date: Thu, 12 Nov 2026 16:05:26 +0100
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
Subject: Re: [PATCH net] ptp: vmclock: keep the device state until the last
 file is closed
To: Chad Aldreda <ca@modelmiser.com>,
 Richard Cochran <richardcochran@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Shuangpeng Bai <shuangpeng.kernel@gmail.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261107150344.3946529-2-ca@modelmiser.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261107150344.3946529-2-ca@modelmiser.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/26 16:03, Chad Aldreda wrote:
> @@ -649,9 +680,20 @@ static void vmclock_remove(void *data)
>   	if (st->miscdev.minor != MISC_DYNAMIC_MINOR)
>   		misc_deregister(&st->miscdev);
>   
> +	/* Files still open now fail, and a poll() in progress returns */
> +	WRITE_ONCE(st->removed, true);
> +	wake_up_interruptible(&st->disrupt_wait);

I think that sashiko comment about using wake_up_interruptible_all()
is relevant:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107150344.3946529-2-ca@modelmiser.com

/P

