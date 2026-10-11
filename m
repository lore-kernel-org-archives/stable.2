Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE7E36194B
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791745087; cv=none; b=ZJ7+6L9QDLpt87V0Apcjs1NzFjPYeNcVsCmJBhdznmYiDVcxQ3LNnRmWURmvzHAsC9ECYSvveoTVywlPS1pNSYRNfaH6Ywz41LlfGqJ7tYF5blflp6K5MBmMQR2YBZGFzAcXchdik9XCpcFRpiS0ZNfXD0/YDZxB7rG4QDdj9jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791745087; c=relaxed/simple;
	bh=30vIfVs4KGaKJvtrndZP8P9FN0D+Uu8JZD/JsQ4gY6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RcYcxIZcZHlbxXZaCnXRUmNgchhxoDh7lH6WtyOfnJndErq4AwoB9vZq00H6F32HtxDuJOt3bxrHgjEpTSYi129Kw75Tjx2zntbD0yNXp5Lk/8i4LO2HSRG4jrzlbTPdY7f+e3oyUQH5LDQhp0qPMv5MTzKxAjvOW6135ExSh38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edx0aHYv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edx0aHYv"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a172da1049so562825e9.2
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 11:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791745085; x=1792349885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=30vIfVs4KGaKJvtrndZP8P9FN0D+Uu8JZD/JsQ4gY6w=;
        b=edx0aHYv611IcIA3wCr9DZZNqzNZv0g7qLB2EZEJHY8Nyl3h9MnUO8VQhqp2KZj2VQ
         OvOgfOdQaUfArxyop6uhgnHRhC1+m56EQ7ouiamEmNNUgDUo+MZDAG2CF+H8yRF0nPZx
         n2SoOt3Oy9h7mA+IowVH+zulS8b54C1bEoX4cfQMs9SpNJjrIyjXwte4IMM6fFiYubHQ
         Y/ABzwBlZFJhY/MDhT0Jstuxxxy9IiibiC0+lm2SnPTRcsz0B+MV2KWlI8vDirs0Zvjd
         wQxkHDSo7bEWVOh9Vsfr6pIhZsS4trpANJu4i893rx9xG4lt0q7JYF8igp8Wk2Wc4BQp
         bFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791745085; x=1792349885;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=30vIfVs4KGaKJvtrndZP8P9FN0D+Uu8JZD/JsQ4gY6w=;
        b=bF7tWlmfKCpDWCxBhrqzsBUzoIoxwV3rK3Ldfxhx2hb7XzGu+4K68/GS2eWZa4pyKB
         aVGM/8PYosVohrVbcLM0IGmhkEnme5tOq21DD58KlV0r3IBuNQ4PtILc1c0y6fO+xkOn
         khNXX6Vqex5Jo//1qNeVavr5lruygEkar9zb4J8DCdAGzcIeyh/D49IQZaFyTJxLygef
         HrnnMZNFXUNlKj49+gxwVMJ3+6VD9ziFeGVMSZuFlYLjVlQu32Jjroq8mUefsuLHLEZg
         Piez6mV1/MsXgXFx5QWQ5iiauFhKLOWJg/o5i6sIrn4TTIT1obGxeMn3cbqkvn0ZwM/y
         lbHA==
X-Forwarded-Encrypted: i=1; AKwUvBw9UEIR79VjHfwkuTmfbe4SZ9Aq555dGUlv2/uWV03jfBKeW+LaVD20EzXm3op9Q5gcLSfLS9M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCLu/GXGEVeTh3U2mIuPA9gVvePu5WB/qxAVrflbyb/O7DQLH3
	jcoRq34JlsU2yiZO336/m3bIDEqzuJ4DXrcmIrJBzn+9mTRzJji0olc+
X-Gm-Gg: AYBFou2ufThULzBUMFQjdm3vnhC/7V8KHNKZaJHMVViq2dTevITgsyvMErtNbbMYBUf
	vrXwsoqJpat501yjRmmQWFotBLC3lG8L0dKlxhe6pkh2GVgxXTu6Hgse+wqur6fdLvl9uohnnHl
	vm56vu+mGKI7862YESavT6NCQJloaZdeyb7RFxi+UlyOTTi9o7nI20RDiQ9Kk4E5gk+8ba+UPMY
	JfAJmPc1SlqEv6jLwSfQb143MOy+Ityl69dobc0N6g4Og2GQk1xif3KSB7yjBod7hdlX9KWwRGY
	BrgB1Qca4hBjGJNRoB4xXfjEVu+pFuyoPJIrABGpxv4o145ejJO71xH7wColxKZn6BOIPdPYHYh
	LVPtU7aNLxa4g6Jwo6g9BSrJOzeEVkP0NNkQcPnEbeUyLxBQxe3CwYkCOqLURGdHUUEuN8VXhf0
	nKOXOS91iXn2lZikm+1F+24VBXeBJv/o8UnFCV6MeyuFlf+MnIxroBMrizBFS5UmYEuAaUpVyji
	FN8ug/BAOjZRDih9hDLxJqMM2O2sMs/iWdwtWDgkzzTusHOfuTdLSFcFE925NuiG4QFyV4O2iwM
	8ATOZdrS14tSZTFV7LnoWIoK9kUhKFf5EJulf0g5qGcmQ4YAsTYsNj9PeDU4YFerQqfxRLdgBkj
	vMPGaEHipm4dabCSZYWE=
X-Received: by 2002:a05:6000:2289:b0:487:1488:d200 with SMTP id ffacd0b85a97d-48dba9dd862mr12678838f8f.3.1791745084567;
        Sun, 11 Oct 2026 11:58:04 -0700 (PDT)
Received: from ?IPV6:2a02:3100:5e07:d2fc:e857:e0d8:19e6:f391? (dynamic-2a02-3100-5e07-d2fc-e857-e0d8-19e6-f391.310.pool.telefonica.de. [2a02:3100:5e07:d2fc:e857:e0d8:19e6:f391])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9aac6a4sm15508639f8f.28.2026.10.11.11.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2026 11:58:04 -0700 (PDT)
Message-ID: <3030b753-eab2-46df-b936-8704c358f589@gmail.com>
Date: Sun, 11 Oct 2026 20:58:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v7 4/4] selftests: net: hsr: verify GRO policy and
 ordered forwarding
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 bigeasy@linutronix.de, xiaoliang.yang_1@nxp.com, skhawaja@google.com,
 liuhangbin@gmail.com, stable@vger.kernel.org, sdf.kernel@gmail.com
References: <20261009201324.17-5-xiexinet@gmail.com>
 <179166359775.434549.12356274501362124625@kernel.org>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
Autocrypt: addr=xiexinet@gmail.com; keydata=
 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
 sNySbH3veZ/55EtlXA==
In-Reply-To: <179166359775.434549.12356274501362124625@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> [Severity: Critical]
> Can this leave veth's NAPI state out of sync?

Confirmed. veth decides its NAPI lifetime from wanted_features in
veth_open()/veth_close(), so an attached veth with GRO still requested
can disable NAPI twice on close, or enable it twice on detach. I will
fix this in v8 and address the reports on patches 2 and 4 there too.

pw-bot: cr

--
Xin
