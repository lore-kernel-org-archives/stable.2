Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866222;
	b=i6/iIWVlAh3RUiXez3B+VgC6mGw06s5q57cIzabgTS16FEgb/tzPyQTIbPxf66KOBGfJ
	 VJDe3UAvCqe8vm+dhN1Kb3J8CqFxaZTRoOhs7WiqRcY4T51rcxei0o4657pE2VP2o9SEt
	 RI2VxlIWErgOjr6K9XI4uNDtx26nZPMMoePfA8cE48a7zFVJmVV2EqB9nz+/ZNGSM3UuS
	 kLno+hAFkv8yic9tQGfeG6wh6QjMAPsdeWv2gP1IVRI99f2Pnoi/g9RzUKk0mPmOdEhXg
	 4TwT62AGImc/d6r2wm9xa4PdPxunKRO4SYgnGxqHnPQUlFCpRwSHJ05oQPotVLpfY3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=eBh969nVxZFFTO6fmYWdYNz93+AyKv5QmTP2TTDmML4=;
	b=f8RpsGMq4hVdWlJ9dg+Y7iN830K8U5/ukDkYMp2ltNA1zZAZXBeeuYiifArhbU2/jV+B
	 hesS5yV6rwl5VBSy2jsE2QVENbpO3kqTK2NzkDvlk9Jcc9H5rfkrw1avaulVuWlnPDwCl
	 5AHROCgYlGv7vmFZam0JG8ikbloowkax6IrtCGgPLjpwNinPHBg2xkEn0A2Z7u+0CvB9n
	 6LafzTYkQyMBwdw+GgwmCV+1ywrvI6bGh6COiykDCwHL0tV+xpy7U9bNNyhjOgHT1LW68
	 HDxPlro+tXvYfZ1Ryr9COQfU8Ml1ABcAfNd1EGhj9teVQgoGlJ5meKk2Q9VtiRmtmcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=Z8MnDae2;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9590B606A32D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9590B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=Z8MnDae2
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso11442135e9.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 00:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1793866220; x=1794471020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eBh969nVxZFFTO6fmYWdYNz93+AyKv5QmTP2TTDmML4=;
        b=Z8MnDae2Fsn66y+fSPyhIuqVEskaO6qb9N4w+S1WzyIZxbKvRPUaH83NjoqUuRdMlQ
         +55mICaJ6Mx4r9o4hofBCQXICU1dZRMk6ZFp69lam3+EG2p/B8tv3geUffTwhQveCz15
         CiJ3AJX+wQRitZ5yRXE3IpRddVqAtBQA+LFpuZnJJlfMDbJ647OrTyhsZsYzMxcheuT7
         kDqst3oFw40pV5MPPnyS1I07Qb1DjDb2+tfRvbNRWPLCqOp52ICk+qV9dTDFL7B3EQyl
         aMoXwSy08+l0EzHmmZDL+HcgI/PWt+WPFGN92vN4ylbNtBCitkfiE8D/rx1t8fVhAf2N
         pkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866220; x=1794471020;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eBh969nVxZFFTO6fmYWdYNz93+AyKv5QmTP2TTDmML4=;
        b=E10lxifuNsnQAhoDFdPQ4AhF93QrEinCMcF+ZRUTKQky8t/5sCUL1NyArv2yNiB5/Q
         64BaX+zKpTwIeHCiGRcuuLtttcG5BHz2fjevUrtwcyXYkOc+yZFEsR1jPpbux0X9nNhU
         g1CvFdiGUHYga/1FRNdKudOFA59wOAZydOoKSuPsZvHKy6uqAqmGD/9qj8oHPlfzhJKN
         kodYoFReW4ZPRXZ7sDnXVtzBTLPBc6oPwfbJySNpvrw/Gjg6j2Kf7UnQb+jVZa50Oq3r
         Cf52OhDp1VeSOY1gO5Y67eBm2gc8sDjIljQvtrkoeGg1QNq2BfPzCm0F/CGm3iIG4syK
         yXww==
X-Forwarded-Encrypted: i=1; AKwUvBwBLkNC9Wcr4cj9vXcdEn1uNL33nBAsvTl3TGW2D/ncrhP/vMlSsCB6Nf8m6KIM3NsyhUOmvEs=@vger.kernel.org
X-Gm-Message-State: APuU4Z81Et5AtwrCcKE6VHLZGufW1PbXTBFprH28YUN0vSXls6PE2RWv
	Ov2a+k6m/bz4tgFnD1xeAS/hM8OdVBsZK/JEboun3XyLo1BhtzQt7h4=
X-Gm-Gg: AYBFou08+tbol9dAu4pSJCmChuWi5leNDuagZTO+A3QvUKQcP5rzVOJe7/Z5SMwl9qq
	4Z2uPGVxZiqwWGv4tsiIJlLKr410Sl1QT3b8cNuaE29MLvJMWqrHVRiyrvsQok9dgdxevAnOY/t
	BWTklwGRFxCdj4lDIWBj17VyqjSfJs5BcvzHlsPixmieN6Nda8gbc0JcOalfywY8bE5u9Vw/OM9
	l08MYy8vvbc11jecN60giOhd5vRUNwKmpura2NYxqXWyDte6TbMXLQs2w8E451v2M7wwLK2QFeB
	Pi6qL2M2FQdQZKlm676/i0PRB81H83OxmjyEXkf4aVAdX2kGTpEZkWS9OByaKyo/Fw/Vv564CTa
	IGLNEVqvMXdu8Q2u1POsBcd475+9xYk/JbDHpbfT3WqWcvIlBDViRfZNgdWJ05iMCTIW/Ui1MgU
	YHaTySekkIJMC5zEKdXB1WJ0t7JUww6Vj3iEGV0hxVp0C5TRAa6ni2RRJQOdo6Uz+1Z44Chqzbz
	SBy9hRChDwE2pU9ez7ks3NPPbc+CbpUZ4mUbHJygNL89hYZPbp2iTpRGXgxUnCVqUk1uJSaLVTR
	o2QAO3SEAyEhmivIRMdTlsjRSdpytC0zpfxSL4C/wJXAHQsLJZQ9RJ2MvsAnD9YyekZwIx3ab4S
	atrc=
X-Received: by 2002:a05:600c:4585:b0:4a7:8fe8:130c with SMTP id 5b1f17b1804b1-4ac1889d5a1mr393620925e9.28.1793866219820;
        Thu, 05 Nov 2026 00:10:19 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4618.dip0.t-ipconnect.de. [91.43.70.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b572bba207sm43172805e9.10.2026.11.05.00.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 00:10:19 -0800 (PST)
Message-ID: <2d666e39-816a-4f38-960b-3e537189219b@googlemail.com>
Date: Thu, 5 Nov 2026 09:10:18 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.3 000/547] 7.3.2-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261104211038.406938024@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261104211038.406938024@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 04.11.2026 um 22:03 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.3.2 release.
> There are 547 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697v2 server. No dmesg oddities or regressions found.

On my machine, I don't see the issue Ronald Warsow reported.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com
