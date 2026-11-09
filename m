Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794223343;
	b=ZytHmLuA13rwIiDQGHDOLDwPEXJms5rbCLyl4ma3tT9Zkq7OrVsJHKF3/ueJvAyzlHIi
	 4fuD699ICQV30p5naFPJ7PVarAvNeJUsctWs99NvhGXcT0aqABfrqjsbORNjlgD/XMrHO
	 2UtDWslAVVsIzib6ItAK02rbPVfE5YpApGbAiPIoI1cGE6fVdYALzy0C7HQOoW0eiWbR4
	 8lHZltIQpM9YVHwBgilNR3vzClVA81DIRSaXG+lQN1ALtVIZ45RAHDrCFNccgALLjWj+J
	 S+F5QtGXcb58EM8BgjgnsnNpS5bjkx2IGGZc1BdCIFQKcuPPZAHsIFvl7/FLFE/zHhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Xs5F7SiyTqAcRrucFvs27Y3YEdp5GXJ0oQ8KE7Wc5ME=;
	b=4I2E/NRLnig7KQc9sEFk1pfxcpLzytRWNa+qQ0FySdmE+uK12APO5RtE0mTaAutmS1bQ
	 r/0aGUvncMMOVjXpw50pX1FbLxV9gyuHthLgVoBX5eZnv9tOR5kwqsDqJqz7LF44L2pFy
	 QUvHITf9i00oEddwGFPhZvpcMq0Va1JS5e39e32Iws1ndmj6W2pWydxyDOc+Uo6RT0GJV
	 scwu59NxRodbsFeNR2SUSE8rOUFQ8Zw8QnJXPO6ZYipWdVNTqZfp6ZghI0bcDcwhWvti9
	 FN0kU/+1P0FKtoKiyXsiDDem10BTVnrNsXiEL1LH4zngCgislqsVlGEKCO9YeRpdBaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jfCMgCBl;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2129A606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 11:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2129A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jfCMgCBl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so6924685e9.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 03:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794223341; x=1794828141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xs5F7SiyTqAcRrucFvs27Y3YEdp5GXJ0oQ8KE7Wc5ME=;
        b=jfCMgCBlY9RopVhaSNRGgRHB2LGNqgbKO3lacuno07E4l5GQXAsyg1vIl8S5+G2Hib
         WTLw2oluK8WNJay+xGNbCFdu6rq8+RDVil/5vmziw5ZhveSVb8Atdc2u5pvDPCBvRp7W
         mDSeD4hJWBHULWqzSZckEGzQidvexDgEHLApAeQxwCB3A60sCys5acrGlV0L1jCdpgJl
         MMG0JYRz5npQt1V8W9XihEPoF8aXciUcRAkdAYSPy/CfMcTwM7WcyYwwTKIoBiPVWx4r
         /950l0jX8a6fWRBfhoEWuSpzXO5jPFNAVhZuWSXgV49epv0XwFNSUbjMHzqeZ1jfm5J7
         xMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794223341; x=1794828141;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xs5F7SiyTqAcRrucFvs27Y3YEdp5GXJ0oQ8KE7Wc5ME=;
        b=eeaiSOWvNeaGgcOCsK1Oufe44P/z5UbhHfX+etqbZjGbcRLdeRHnzBFuwTGtyWMd16
         7iqTFlE2McGc0qks7zXtR6cAsafmRHflbZMxKuQZXG00qxCE/itE1ahVomlN191ovguG
         rt72DPOB7F6wYYOGXbBExKB1pCdWV7TmcsnpYW3EvPP8OgXAGoLWLxJvwvufIgIYpc0D
         vXm3IUm13IH0PyErf87fgKXMR5qS8BNVvZerKCxE309DpRZ/6A+ewClL5Xqy5BK+ouYz
         9Y2+rx0QMSM7AZituu+tHngNX6I8q6JlHKdRv0mGN7mh4X4aSZh2ln3rfFe2IwZQzS04
         h0Bg==
X-Forwarded-Encrypted: i=1; AL+hErFCQjsbP2RESjfbUx6B9U2PAnwvF5zEzt6c5Up3POdU0up4PB2zBRgR8fjvqPdvmw6sirmVnWo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9V6aLMw8P0mNnXvSUnQCNV7Ej01ZL2+229CK6WbN26tRUH7J0v
	WNodk/jyvpiWV1teklzNAT/G+BLusNRXiin3+WzOl04HBeitURG5sMnJ2IFcz6MRG6ZVg8GbCwt
	s3jM0
X-Gm-Gg: AYBFou3lsovPTnLDYxmo8VMGyvU0whZyhFTJKc9JtC5n+PP3N5B8EfLCL3TQ4DJFCIs
	d4QxBL755QLKNnIiPsTpfx3jiDzCkSu4UOQ6t4OthLOKElxsSkdax20wxMvgh78yhBUfTtPkERl
	o6LP5qLoI1m2LmFzNskg5kg/sgCG0QrsCTQG1Cunmh3XQEoo4rl8E6F+qzcuLWCAkKCkjxGXoZP
	WnkpV2GYWIY5pPlfuD8NZ5HR1Yzxw9NNo84VRtj49bktMXsputibeCF3o1idD1q6RB7/cVZftVY
	DNOFJNBls2b9Jo7k0N4owhFIMMuAnW8xamN42QuNE1ZR8QZSKsKOfQ3x+3U9O1SLsclvg5BtCPH
	+ogekV/A6zgoNIyKIoxXfuY4ivjF++DY+BtBIo/Eji9bQQUk9/R35KoQcxzpxGDHYkbffs1VqQD
	DmS3sAALTk3PuzTVYJAXfgqSGT9neXWFYqY8tzzOo9UTvoXREzgYkJny0ltQrnd+36DGbUqn6X/
	S+GXSlAi7ul4swBmbKzTYLvPq3J30ozywBdXbSdqzi3BctGK3w2k0hRveq6/Uqp2pOlLxoOy2Dt
	8wV1UeNvVYsvfyKAm6htYtGdGyG2dsdBhXqmcw==
X-Received: by 2002:a05:600c:8506:b0:4a2:10f9:37db with SMTP id 5b1f17b1804b1-4b963c664fdmr72108245e9.7.1794223341348;
        Mon, 09 Nov 2026 03:22:21 -0800 (PST)
Received: from [192.168.0.167] ([109.76.74.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7da62edb4sm272724515e9.1.2026.11.09.03.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 03:22:20 -0800 (PST)
Message-ID: <7a2e44a7-41af-461a-96c6-ea91780bf524@linaro.org>
Date: Mon, 9 Nov 2026 11:22:19 +0000
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
Subject: Re: [PATCH 3/3] media: iris: Fix use-after-free on unbind with open
 sessions
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hungyu Lin <dennylin0707@gmail.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261017-iris-handle-unbind-v1-0-7809148eb90f@oss.qualcomm.com>
 <2rWHCgRwgvQ8e4bhpYnYDjIzh1pjQNSNjdBFELmGe_h6iZzVLuoQDpUPAD64feN0mYHgyoDf3AYwIu-5ilkZdA==@protonmail.internalid>
 <20261017-iris-handle-unbind-v1-3-7809148eb90f@oss.qualcomm.com>
 <46e9506d-1eae-48d4-803d-d731d85fd376@kernel.org>
 <831090d5-57c6-46dd-559a-bd6abebb982c@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <831090d5-57c6-46dd-559a-bd6abebb982c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/11/2026 05:08, Vishnu Reddy wrote:
>>> +static void iris_core_release(struct v4l2_device *v4l2_dev)
>>> +{
>>> +    struct iris_core *core = container_of(v4l2_dev, struct iris_core,
>>> v4l2_dev);
>>> +
>>> +    mutex_destroy(&core->lock);
>>> +    put_device(core->dev);
>>> +    kfree(core);
>>> +}
>>> +
>> What you would have here is an admixture of devm allocated stuff and
>> hand-allocated, refcounted with custom v4l2_release() which might all work
>> but, it's not obvious to me does work i.e. core is hand allocated while
>> reg_base, response_packet etc are devm() managed.
> reg_base and response_packet are safe: after iris_remove() the IRQ is
> freed and the core is in IRIS_CORE_DEINIT, so nothing uses them. Only
> the core structure must outlive remove(), so only that is refcounted.

Right and you can confidently assert that for clocks, regulators, power 
domains and ICC ?

TBH I think this is pretty hacky and unlikely to be safe.

Another way I don't think this approach works is an ioctl() waiting on 
firmware do do whatever. If the ioctl wakes up after the devres() 
removal - then what ?

>> A much simpler solution to your problem is :
>>
>> static struct platform_driver iris_driver = {
>>      .driver = {
>>          .suppress_bind_attrs = true,
>>          ...
>>      },
>> };
>>
> This was discussed in [1]. Dmitry noted it is a sign of a badly written driver,
> and I agree: it removes the unbind interface to avoid the problem instead of
> fixing remove().
> 
> [1]
> https://lore.kernel.org/all/ 
> CAO9ioeUvV+3sME9P1bJTpDOSty=uojOKak659XCf337++vPVNg@mail.gmail.com

In which case I think you need to do more poving/reasoning here about 
admixture of devm and hand-rolled allocations.

Like what's the use-case you are supporting here with the unbind exactly ?

---
bod
