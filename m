Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27266336881
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529972; cv=none; b=d+JvxB4vKJSsfhd6hIE7d9LfILESvFTjxECEMXbDR59NIu/RC+LFifIAW+8Jj5Gh/VepJGsIC7Koe4QoRScp+JYjlrQxAg5crYMAMVOeekMKkq0n13Xz1dRsJThF83FeWMhgmNU9VGzdKoa6cvWIInlSXfxT82XOnezOhML757A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529972; c=relaxed/simple;
	bh=q7z+i2UWwojfRh22izSaK9uZx5wRQzWUhISBTanReB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmKTX0x+T2JuPaFoPcJ+4XEwKyoa15VIge4IhZhz8+dgfoQhT34wWy5C6eBymhMg7gopbwAgoeo3OzpCacXD/FHYMIXBbP6K3wsRD+RxsVl+uP+NE6wOx0XWhI7aurX6Nx9jmncO8zWzpML8QQGF/dIoyHzfrSN3vWRKogRn0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w2HHPcOP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w2HHPcOP"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4956869750eso4454915e9.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 03:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786529969; x=1787134769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LPf4HeYAl4NMw83MZeHJ06u2OThCIdlBbBkd+71VTjY=;
        b=w2HHPcOP4fBlIp9lUcBdYok/PGa8pEzkyKYhNnZcJRT4JaB5sVdyNYEWRG0ufWBXM3
         nphRFkazymopUPnbYaP2tphK27pdP1A0s4niTP7E+EorKLpsDHBWwL9sWeoyd5hvpAVL
         2ZWbv39jkpfmeUFN0AX3GXmAhfXvVC//0de+RvzQFpXJUcH9T44KvizjHNUhJE0Kvn5z
         0gKLDOWHcqk8IqcW9KVhwok01r8hvturLxcI6bhSfzvh7eXwKFGtZNP60rAbv9NOJyxY
         eMuX8krU3/oweaSGpSYLygVKTvV2IoexcDvkLCs85KgjYPtiGnjOGrmdoSu/DTAbZqXj
         GEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786529969; x=1787134769;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LPf4HeYAl4NMw83MZeHJ06u2OThCIdlBbBkd+71VTjY=;
        b=Qtojqyb0JQHBHQy6AZiP0MOtXVHbb9qt3Av3rGDst7clz2LPhNUsN5cjaJF5Yhr/NS
         1/k5tVuzy+JQ2/a4VXlLUQKsXxIhnMc9hXYQqf2JbCF0YXBeV7zC4ipqTMJG3LkOchiJ
         WC0vnte29EsZUQqOkHFQZhRYujSBnW9eWoSqC56UKU1y01nUtzmTtiqVCaJCqE6tEOkg
         u1prr96iKLGB1jPG++zSB8PyZ6nE0N1wkKCb91rKG56DIv0dqfqEr5a5vHSIlAg9lQAj
         IAXVKXLfCCX8DpA1/IO56Bzo8F/rDKIAeHmBilPqVR5OjWqnNriSR5+Lk2yXUz2h1mhP
         VYxg==
X-Forwarded-Encrypted: i=1; AHgh+RrsTTOLC60pmB9gSOJr5RX1C86jcWV9AQTCK+r8bHq6yrRNbmFGF1TL8J9FmVwqF6yhD/k/JnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHg0cUugjDIVvpuM09rsRvhmObQ8RuD/fyB4P1pJNVkk00Kk6n
	BtNb95I9SfgooIukBKHG/8uKrf3ZNWchvWt6Xh1AvTnTXmCGgWQU3kROswA0Dnemw0U=
X-Gm-Gg: AR+sD11FrlGWtbacNaT1+1vQzAuaxvH5Df0keGGY0KSdNa3+5+zXPcFU8E5zyxAHx2O
	csyOp7ygMKE2TyeFvMhNMDRbJfWpvoi/e2Wtsw85kDWrh9bmaoGPq26fkPCK6EQW9GtHgE23SAf
	O2bekiH6p0NuS7ibzeiR99juADqenvnPK74DDCPh5EAdgQm9ckL8/Is2OOT60LXS2G/loE3/4Rd
	g766NOFiabmIEhqEzmHVZW12Pu7NjTHUTuaPWtNLnJs2vxYqhpQE857/7H7bWLBgIlO/maiElPZ
	q16O+rOMDMZ72Tb3BcDu3ulRoJYYgBZbeiW2qi0NXQ3+0ctmelHfVHFT05Gh1PxqztoA4W79UyR
	nyJnyRUkoM7ARZq9E4/kQPbBNOioO5IlZ8t6XH/xWOKBrJIBg/xbPZ5+HIqCOEv89m2X0Spl1or
	8YrK7jZJ8NJ+mNJtGgy5gOFMwF62c1sRBg71BREHYNjXlfi0vHH65efiqdyiT6imXEBoIjGw==
X-Received: by 2002:a05:600c:c178:b0:498:1595:be7b with SMTP id 5b1f17b1804b1-4997c0cd08fmr47953295e9.4.1786529969390;
        Wed, 12 Aug 2026 03:19:29 -0700 (PDT)
Received: from [192.168.0.252] ([79.115.63.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997c98d264sm40995005e9.9.2026.08.12.03.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 03:19:29 -0700 (PDT)
Message-ID: <0a15f6e8-f1ca-4945-9bd5-2b64a2802a58@linaro.org>
Date: Wed, 12 Aug 2026 13:19:25 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mtd: spi-nor: use guard() in
 spi_nor_rww_start_exclusive
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260811041349.333176-1-runyu.xiao@seu.edu.cn>
 <20260811083111.403453-1-runyu.xiao@seu.edu.cn>
 <0ff8afdc-7a11-4a6c-9f62-6f8ba712c4ac@linaro.org>
 <56991b48-cbe9-45bf-a24c-d7aa771c55d2@linaro.org>
 <87jypwoha6.fsf@bootlin.com> <878q6coefo.fsf@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <878q6coefo.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/11/26 6:38 PM, Miquel Raynal wrote:
>>> Have you seen sashiko's review at 
>>> https://sashiko.dev/#/patchset/20260811083111.403453-1-runyu.xiao%40seu.edu.cn?
>>>
>>> Both concerns look valid to me. Do you think you can allocate time to
>>> fix them?
>> Sashiko is becoming a nightmare. I'll add this to my todo list, but if
>> someone in lack of technical challenge wants to propose fixes, be my
>> guest.
> Actually, the might_sleep() warning seems to be an hallucination. It
> mixes different concepts in its explanation (might_sleep() is not a
> problem here, we are in process context) and I believe it got mislead by
> the current state of the code which lacks a mutex_unlock().

I haven't tested but sashiko seems sane on this.

wait_event_killable()
  __wait_event_killable()
    ___wait_event(wq, condition, TASK_KILLABLE, 0, 0, schedule())  <- TASK_KILLABLE!

Here there's a for loop where it calls prepare_to_wait_event() which calls
set_current_state(TASK_KILLABLE), setting current->__state = TASK_KILLABLE and
storing the callsite in current->task_state_change.

After prepare_to_wait_event(), ___wait_event() evaluates condition
spi_nor_rww_start_exclusive(nor) which calls mutex_lock().
mutex_lock() calls might_sleep(). You hit the WARN_ONCE in __might_sleep() because
state == TASK_KILLABLE. You should catch this if you enable CONFIG_DEBUG_ATOMIC_SLEEP.

Cheers,
ta
