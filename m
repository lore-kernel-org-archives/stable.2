Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098CB305682
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509250; cv=none; b=YMiKQH2HuyYH3VRMTdBT7CpLpjdC+KehMxqUyBCskzo4tbn1Qob6TZRAj10Z4M4fDUjEuuzpLfe4//cHbrwjFnJHdUzhYZ6fgq/mzC9XvJPeZS0/jMeTGjCR2T9Jir/2qorCE3Hcsl4x/WTxciQ9pLfwU9f6tgijSlyLoinjHZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509250; c=relaxed/simple;
	bh=7gTGoROcY88FIx0BKI9qz9m4P1KC5KNO+9LCkMExk6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epfk81Km/VWft3oq6bNIEMlYdTrCmg1ppBawAJ268fvgblZsVLcuZHjRfHLhZzSypRtltbSdMTfTcE6QKkF9oTc6ex9DauSpto5ekequ7s6obbE2vbRAEAe/+fh84Kaoqg5rZU054q6G4GOov6dtLARuMuctUMtQWQOqwW+8Sdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWp/+HCa; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWp/+HCa"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-beb2a97cc9aso562350166b.2
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 00:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781509247; x=1782114047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gTGoROcY88FIx0BKI9qz9m4P1KC5KNO+9LCkMExk6Q=;
        b=JWp/+HCaUhyEnt2o/PJZ0btNxmB7yrbB5dHGBysqFYgc2VBD60QKSDWlMKZdI73pmN
         2FEqtzYk+DAU/Ns/Hfgp/Fgbzap7TfDGfXylG7kqMhbWktryZ6U0j+DUCrhxLphbhWJG
         Rk3t27QhUM4IlXtzP0BEgoBntsSwFS/3IKw6uaDUUQjBfQ4hH/lCjRuX12jrndjG7Xo0
         +UfCtGpXOSO4AgJ1rGR9a/Smv/NP2aTLYzuUp1bWzHnwV3hTaV/qaArMVdVmxqekd4g7
         xfX5Y/0Z30yLbAqKt1glo/cj0/gBwv72A8CJ6MN8YIdukyBlyYbbQFcBqo2VlYJ2s3X/
         DtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781509247; x=1782114047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gTGoROcY88FIx0BKI9qz9m4P1KC5KNO+9LCkMExk6Q=;
        b=S/TWenYQ0+AoRAT0jt4TBLEquL0kVpGajBLaFkmSt/ahFz39sN2RGaZnF4PmrxmPSK
         1YMdUuogjg0JRFo5FB3dbF27mH238icKv5/6Z22g3IGzoWWMdNaluDyt6J4URkKBmCdb
         R9zrN7c4O8vIfvhQ6gMaoLjz3AoD2JvGYN0rG68SoHLE0EVv2hX/u+pigAOtgVLtTLra
         ZZX7dt3oEkOF2Qb+u0VcqE9aR7AnmTLNm54tFInGvkW88fq7CX6zc6s1s6Ni40DiysHF
         dprolpzA0U0nWx0X81DuWnKqYeHIOxWgVHzIShTsCmQRL4SdSV53xFAE/c95pJQvos1D
         k/Gg==
X-Forwarded-Encrypted: i=1; AFNElJ/AYbLganq2rOlIGJi6pBqQ9Dul+5tR9QvusdojglcO8HjEfipleXY7tuH7p/7seyO4K2orjWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKZJaq99n8oaqx9kJp+TtX4nMrpznDMLPRxhBUBPtq/AgF0jIx
	aoCa3jimW8O/l/juc+gK8W6glZ2c7HwTWDp9h9HusMO8cbnjn0AK9vYs
X-Gm-Gg: Acq92OHqHASxfC5ZdZrotiUYJ9VDirDClyf5S1HrWz4d/WkA4WSQo6zdO/nF9EvfT3P
	wIX7hSrbxWz+0lCw9pas0DlDdTD1LsLOhJOP9ueUtSgajMTLnJ9taZEOowq6CXYEgkLbslj7xP6
	QthaTKaEgVBc8voxgfkWKIzXb7hMkw7pQ0ng6f2kD/4XMJFm5TVg0LrHsrjg8zIBveFpVVq8imT
	Q2klmufK02ukTcyD/iTyHM/UsmzNYDN34a4WQgaMIPHjmr0i4CmpQQ8zztLh+Hb5ngV9sw9vwaB
	d0VKBJC0gssKEp2NRF/bpHwmC71jmL/5kAIqEk8BWfE116dhsFLBBaWuYKNUBk0xxjvqPV1gjJ8
	1rYcHvWRKxNPrRzQZU5GfiL9Q6gZrT/dFYvJRY4hK2p7iB/KwmGd9MBeZeGqzKBSkwXI9FdgSVe
	kGBquyNI19rTfneqiTc3AN1WOQxibobaRe20GE2Ce2mS5S4+GwXcf1JzgSazvqZRxwaodaiXNOL
	k5ZVcHBVnd3OJyuNGfTjGkatg==
X-Received: by 2002:a17:906:ef0d:b0:bee:d554:f332 with SMTP id a640c23a62f3a-bfe282fb76cmr579858166b.16.1781509247059;
        Mon, 15 Jun 2026 00:40:47 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f12e:9401:c875:96a4:7b6f:72fd? ([2001:9e8:f12e:9401:c875:96a4:7b6f:72fd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb4b22544sm413400966b.14.2026.06.15.00.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 00:40:46 -0700 (PDT)
Message-ID: <9cd444b3-aeb0-46bb-a8a3-1526aa8f191a@gmail.com>
Date: Mon, 15 Jun 2026 09:40:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Content-Language: en-US
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260608093729.12111-1-jelonek.jonas@gmail.com>
 <CAAhV-H7vJ5YniUD8HhFWBbypNyWTo73M_vzw=Y-MZtR-b_RNfw@mail.gmail.com>
 <731bd6c4-0f70-45a2-8480-8fed315b82b4@gmail.com>
 <CAAhV-H6Va1VzpvdA-w5fX9KrZQArdX_Bjpg6t+4QNn3jHfgjmA@mail.gmail.com>
 <e9696d4d-7cd0-4d7f-af87-2b4631549475@gmail.com>
 <CAAhV-H5psOJQey+frswdc5Q76UnhCkrHJ_jtqvxHsfmi-dskyw@mail.gmail.com>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <CAAhV-H5psOJQey+frswdc5Q76UnhCkrHJ_jtqvxHsfmi-dskyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.06.26 09:30, Huacai Chen wrote:
>> [...]
>>
>>> However, synchronize_rcu() only gets called in the
>>> IS_ENABLED(CONFIG_PREEMPT_RT) case, so I think your configuration
>>> needs PREEMPT_RT, right?
>>>
>>> You said this is the default behavior, but PREEMPT_RT is not enabled by default.
>> The condition where this is added has two parts, see [1]. While PREEMPT_RT
>> isn't active for MIPS, arch_irq_work_has_interrupt gives false for MIPS (since
>> there is no implementation and it falls back to the generic one). This then
>> also calls synchronize_rcu.
> Sorry, this is my mistake, then what's your preemption model? There
> are too many config files for MIPS now.

I'm using PREEMPT_NONE, apparently default for all targets in OpenWrt.

> Huacai
>
>>> Huacai
>>>
>> Best,
>> Jonas
>>
>> [1] https://elixir.bootlin.com/linux/v7.1-rc7/source/kernel/irq_work.c#L291-L302

Best,
Jonas
