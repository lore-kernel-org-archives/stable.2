Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155114D598B
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556855; cv=none; b=qZabDmj1kd4nieYoPxd3T3eCE6vv40hsdhM3SGE2349g23p7ckfowXOjzpzXJhAp/Zt7o7M5wIRnKjcnxfj505NCb6rAXnKrJwsfdzBogSU5fyKQZ9lgNniu+TT/JizEYdyqcTVMUK6TRE9PRnw0oKS/YUjCfPyj9tJBMmaEpHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556855; c=relaxed/simple;
	bh=iQapXPqyzCyW0yh+hLQEmt32QweFEdb0Dwc5kwmIrgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oeoJ1uFuGmFlNORDltob8X4GHd13iiZ6sgw/V7rrX9usjryEpTfmmk/TYE3rMbM7Q9AXbjEbUo6Zmi+2Fi3h4K3edgN7KlBSpCnOUTBmNPFIkPoNZ7+ZNY0op6IDOL2rqq0PI/JHuuk9c3oeyiIRC0lLYEWLKwZDylRZgoKeSCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Hk6VkITb; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Hk6VkITb"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35115b52125so5699138eec.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 07:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791556853; x=1792161653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E8pCZ9jzEXeu3V91z7yTFHUowpIkdOUOpn2JEuBADS4=;
        b=Hk6VkITbP++OIKKGM96V5JWIPH2alq8yYq+kvdhRa627RHSFbdlVAfDETgZLVhsk1V
         /+1mFiSiWczDfcdg1Hoo8Qr9vTt7XcBBqD8tgw62N5mwYIx+gSHcpIOGd9OvLn2oMidV
         gTaAWkjK6RE7eNvieLP+xzwd19d+lQV2gDcQvXIGI8MpVS7LRu/CxoZJhq5AeyajaLM1
         LRjXR7AvPuApZ4kuq6iMvC6dwPgZexvkZNOP1Tuz61hYYXt7t8mSmkyJM0MQrLjn2SfO
         8svGStNVGSR0/BPgIPpFya4P17AHN9+jcoTXEa2IMWvFg8KOIO9SnC/u2cLi8t940JNx
         pVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791556853; x=1792161653;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E8pCZ9jzEXeu3V91z7yTFHUowpIkdOUOpn2JEuBADS4=;
        b=YxttbKwqDvmPKJa9UIDPkZ7q60vEgDM7uLBgychMoW9fMthedu/OPqN8Jodg+Ta8tH
         Teke8mWPekGq7RTj6IQH25SWxSsMMiklMCgebyu92V9PJnwdxgBDXBkwLRAoC0KI3/la
         whnuN2sBJU0nsj0F0ge2Djti09uIMejEeYpRfHttXxVRPnghHCZLNUfM3TFbnxoXVcHv
         PFwGnFnc8XSFh5N4+VPGdJY2pProXn5pZoja4J3zgUZ7RN4LLCR3MrVJB5MM8fbP+D4w
         zrb4fZoS52t0G3grdUBPrnrUhEd88yhVo1PGNQEqIpvpnoqfPDACCNo3luo+ttNc4JzY
         wqMg==
X-Forwarded-Encrypted: i=1; AKwUvBwexUapF+1naw/T+fA8rtg7su/rD41PIvaFxMxtIRExwWcHoqbbDI2us9TOm45t/A1nfwoc+cU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4iGU4ROYP3roA7bAup8J16Z32W6Y6bXL203EmeL204ErhkwNj
	3nqtdnj7CfwUhq0bkDtpahLq+GBTZSoq5KizufUT4nmZUkW5cpirGH9m4FsA5pmOXAE=
X-Gm-Gg: AYBFou22gsGsSZtACT00HoDa2+KJ7Flnca13bo0wOWKGlqfZbp9ldWf2rQ7qXkN2fRi
	PiHNhm1gjnWjXS0WFx8DLiAFXCmEqudYVjvjzlzcTYn36RBtvvz2Ycx7w2vnSVKcNbuFLq+MP9l
	9x0s2aUth5x5gHeBfzmuuyRO+InOOyn3IXygQ261aq1oj3IUP7Q/n60cg7XkcP1bCoMJAj/k1An
	uf/3J5+4yNsUURkyfhn7tVKlRlClFap5FHN/X1vqjBGebiYLD7XIqy0EQAMSw0t+BVxssqObn8v
	RMkrjCgQxmUsNVXMByDuLdPIZOnArxJI19OlVEPruIOZ799ksp52/34zR82PIFVp1JoUiNiEtQX
	b+gnu3nkRjNZZNNL2TI0vX3QEudu38PgkKWPImbfB78PrhO1MIqjbvVt8lGYuCacUx/Ca2mh2Db
	vfQnxZVql7UYzRMBn83ydPnr8HbqVvrj3v0hssj7niTK6dRww6qVmfFQLPAO5m6QBOwAgJu4Vus
	hV/MYHe7foqHpZliIVxZoVNRxdkDERCW8cyIx7Y1o2CWG2bwcVzTF3bbCIuxEvVfZuT4s+ifeaN
X-Received: by 2002:a05:7301:fc18:b0:341:2466:2d68 with SMTP id 5a478bee46e88-3537e0cf2a1mr2938047eec.38.1791556852849;
        Fri, 09 Oct 2026 07:40:52 -0700 (PDT)
Received: from [10.61.8.29] ([155.98.132.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca0e64csm7578272eec.10.2026.10.09.07.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 07:40:51 -0700 (PDT)
Message-ID: <3b0edaa8-75e4-4282-8310-0dfb878484be@kernel.dk>
Date: Fri, 9 Oct 2026 08:40:50 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aoe: pull in the headers each received packet type reads
To: Christoph Hellwig <hch@infradead.org>, Josef Bacik <josef@toxicpanda.com>
Cc: Justin Sanders <justin@coraid.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261007-b4-aoe-short-packets-v1-1-db5155f7bb9c@toxicpanda.com>
 <asdpwPEpGFxfLDNz@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <asdpwPEpGFxfLDNz@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/26 4:00 AM, Christoph Hellwig wrote:
> Can we plus just kill the aoe driver given how buggy both the driver
> and the protocol is instead of playing whack-a-mole?

I'd love to, but not sure it's feasible. I'll have to go search emails
for details, but I know there are people using this driver still,
unfortunately.

-- 
Jens Axboe
