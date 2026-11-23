Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795403830;
	b=oyPBxbBH2rDHdA9jbJ97w3gg4NinwuqZre0bH3qodIbAkhgCibCplfCJQ3uMy8NsfsnW
	 x8TTaRcSGfjp2T4gnVj4Jcl5QDhbTsXzp73lS44EoSRoMSDXYdj/OffiezCnJ+u3PDv94
	 +XvFYRLblGkr012KWzcJ3+oURB3ONR0dEdaqmi3u23iOVvPT2eK9wyk+aw5UYkFE6JwTW
	 5iUywyAkuncW2/jAq5cekdN/zZgdsxoz5Zk3JTp8MoMkCfe7I7su5C64feLTpmfws9GiF
	 1UH/cWQDk7b+I+X1ln0L9aBrayI3VBCC51/edjhm35HzTrq044o3k4xENQsHfptPn7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795403830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=pWFmMqdiUBIDsbICVgq5W2a/9yFA/N2NGvzbuzJhY5g=;
	b=LAfOGzFuR5HEkCYTfQPkH0/ylWrn0oubvI+ZY9WyFulldeKgwJBmwSzqt7mwBqdivX00
	 vpu/0UiE2xI9yN5rTdBkMLhRxmLpHsEn7egZDAW1bBvWahZjf+nO04ZYC6pZyOXZ0GlYR
	 1G5Uf806WxdW7THeJ6fbVO+1CZbZLbvp0fAtjWQXv3NUqmJZVP5imX2WrPs2xyKZLKrL5
	 zNr1KEq44BHGJ5Q/3Tw4lZc4sDx4c3QFT8/r+pSdCF6tBgJU/1U5+AyOguh1UbOceGiRe
	 77WsyHDv6ukohsylQrBjl8JpxKVH9JdEihrbsG5OBCh+rGl8oo25CVgnz0+9k1Hp14w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eMmbiF6Z;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11711606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 03:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11711606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eMmbiF6Z
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso1338728a12.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 19:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795403829; x=1796008629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pWFmMqdiUBIDsbICVgq5W2a/9yFA/N2NGvzbuzJhY5g=;
        b=eMmbiF6ZxgPuFDAR4rlJBb8nL1IkFTIG+dWHkPERXKufQxZAwXVwd/UTn3yWR2jef9
         Cjt5IC8KHU8BoFGmSvhQTBU0PYqiWEwy7ahy5Kk7ieOGSeaQjk7e5fwBDHoBsZPwuvNN
         BTDSDUlmsa/MS89hkSpKYnXEg8jT0obKDJ6kAnRGJuxn92/4l+6iD5o0ljTshq1WWhGV
         HV670sCkbQxUHyGU+dLLzwZ6GiUDmJYBFXUj3WcZQd+GwfeE7TBrjLqZwmdTl2kr0uOv
         Gax3ngbZNhP60Y2XRqwHDsYiNqfFAc+lhjGuQ0bt58HVOk0L0dmwaj+X8/JEhOmA1a61
         Gh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795403829; x=1796008629;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pWFmMqdiUBIDsbICVgq5W2a/9yFA/N2NGvzbuzJhY5g=;
        b=jGiJs4FCsHv/IOivXZzRcG7U4n5fO7rLNl2mQ1BW4O7fPGrSKq7VLCxmvAtfmGKvcy
         noZObjRN0gvZu/lKR4ew9JFQTdfDbtZ8/p3EbZMS39NbK3FmA6QVQei1Bj7lSusGMeZk
         IJMUh8buOpf4PdCpgkY4bl2KTTdOzT+qE4tEt/aUM9oJasBYykczjHLV27omQab7ygRl
         Rzo8aOWpN+s1bl5KoK9UDYyD/ikVq5YDdtRDyxWw2qa+4OSJtn+QwOh+fpj2CRQZyL5g
         jOCDeLihxLyGaI/LTKjvxo26/2WySr6ax00/K3QtL6oiMcQqWtazYy54e2z6NWZsTb3C
         WJEA==
X-Forwarded-Encrypted: i=1; AL+hErECBEn4xyJCVZuZBLf/iNN8QpAlmDbmZi03i1a5QgZkcpCZujhGYTNoT1z0tLvoeByCeDo/38U=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Us1gtfi4yNYHVb91C0zGi/xcuW7f7TR4w/wuC2MStVWv7uKOH
	ryyn693emi+51BxFpYbYEZarQYnrnrF9cHIaik+2ymdMLUNA3ZOuiiC3
X-Gm-Gg: AZFdTZdIhI2cuAfWVnTW6MHYq/zPGYZ01HEd/s5q71GzMdQi7X+afPkFIZ7vp6efFiH
	/s/+9fI2HKqyMFBK2Nso2ciQlKOXG6haBz9supqH1/qMxyFSTBRv177yzWnSz29+QlsaubLRS6y
	5YcbM5Vx1fDO87Gm3BPutY/0fz1ovaPxLpKAiKoWYRyw8319mp5deuHeYch7peJcTfeE3esacn8
	as8pm381ZPPyOmHn7dZsieiLgJJCPO2J+siw+6bNJkULoDWITXqn6eJz9SCjiCw/heaHKcIzEWH
	Ebg4GWY/Hw/hGI8T5eEPUcnEIdE21LPF8dRky/+yu2Skx0SCm0B1TOQwr/35ma7hMG1NGqRqU0J
	k/g3X1Jnty3DmMN8tZN+nWcCL5LYofQScrIxp7Ug7aZrzBu7jlcwdOdSPDPT0oIRb9mh4QY0zhT
	x8pKQShBfIllTpKWzKtAipXx8BSqV2ewk1F3DxPrvTXxXqNVvKsmyvff+I6Ty2Uvzq097TJSpN1
	NMKKdztreOMnfMqLb1cSwj8irspDQm1C+5LibGSxSzaBt/t30+eKtrR60+rRVMQ9R3kzSeP8qIJ
	ZMj7chV8yBtQOrC5bYv5Vv18d8HHvAxR2zxBckSUhRo/
X-Received: by 2002:a17:90b:1dcd:b0:3b4:1bf1:988a with SMTP id 98e67ed59e1d1-3b41c975107mr8883441a91.55.1795403829307;
        Sun, 22 Nov 2026 19:17:09 -0800 (PST)
Received: from ?IPV6:2601:600:a482:7d70::b4f9? ([2601:600:a482:7d70::b4f9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b776a14sm5911407a91.2.2026.11.22.19.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 19:17:09 -0800 (PST)
Message-ID: <e011f909-bc90-45b0-9065-e517ffcbcf2a@gmail.com>
Date: Sun, 22 Nov 2026 19:17:08 -0800
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
Subject: Re: [PATCH net v2 2/2] net: wwan: iosm: fix S3 resume by re-binding
 the driver around it
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, nihaal@cse.iitm.ac.in, stable@vger.kernel.org,
 netdev@vger.kernel.org
References: <20261119042714.505405-1-davidlwesten@gmail.com>
 <20261119042714.505405-2-davidlwesten@gmail.com>
 <5651d569-d291-48e1-b38d-8cbdb2c2f0a8@maciej.szmigiero.name>
Content-Language: en-US
From: David Westen <davidlwesten@gmail.com>
Autocrypt: addr=davidlwesten@gmail.com; keydata=
 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
In-Reply-To: <5651d569-d291-48e1-b38d-8cbdb2c2f0a8@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Maciej,

Thanks for the review!

On 11/22/26 12:01 PM, Maciej S. Szmigiero wrote:
> On 19.11.2026 05:27, David Westen wrote:
>> - Entering suspend-to-idle or standby explicitly while the default is
>>    S3 also re-binds the driver.
> 
> I think this re-binding should never happen on s2idle, even though S3
> might be the default mem sleep method.
> 
> It looks to me that the only remaining case here is the "opportunistic
> sleep" code which does not use mem_sleep_current (so won't be covered by
> pm_suspend_default_s2idle()) - but uses autosleep_state instead.

Agreed, that would be better. The problem is that the PM notifier
isn't told the target state, and pm_suspend_target_state is only set
after PM_SUSPEND_PREPARE, so the default was the closest the driver
could get on its own.

Covering both cases would need the PM core to make the target state
available before the notifiers run, like pm_suspend_notify_state in
your earlier S3 patch. Do you think that's needed for this fix, or
would it be acceptable as a follow-up?

>> - A suspend to S3 that calls pm_suspend(PM_SUSPEND_MEM) directly while
>>    the default is suspend-to-idle is not covered and fails as before.
> 
> Are there any such pm_suspend(PM_SUSPEND_MEM) calls in the kernel (outside
> some test code)?
I found a few: APM emulation, pseries, via-pmu, ZynqMP, SCMI power
control and the SPI slave system control driver. None of them seem to
be x86 ones.

David
