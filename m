Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085711F3D56
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653859; cv=none; b=I7jLA3Ioqg3H+Iqc0PpiP6JmpkckM6V2srDcGzRbIN9Dh83AbO7o6d1wQ8NAq0Y6bx3cc5Gqj/Z9EcBE8Jh1KZj6Z9GJ68ZozrgiAJNiTX8ndZKpM8jw3pZTQ8ArcLYpAHUAD4wRSmGrCSwTYgn1MYKCRVyjMfY6U2h0WbFzLxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653859; c=relaxed/simple;
	bh=6eidNqkwPlgy1eyK1ErXs4WrdbSONsBgimGthP2xbn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NH5zrvpaG4qFPdMm4lXq/3Q89WRGdHHMe/05jaCy1G6SuzcVpj7XBEu8fNgTxZeqHy0Svtf4vFZTUm7c/HnU5i38jzcdqtCLA8E9uKJDKnqa+tph2sgSSyYHLcmatGZroKuL/mqLC9Hc0zK8Xy1LkwRVjiddF5W8hBgZKBEsAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpCDfjRE; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpCDfjRE"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e533aacf2so451044285a.2
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784653857; x=1785258657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G2zl8WdfYsburxD4Z1OSPDQaVBCCfCCyiW3l2jHNiTw=;
        b=mpCDfjREC+zt1mS9Ow3nNiEHy1ksPvZBgjf8d6NEGZAtpKIumFdFMg+M/i+NSDIzsK
         Y9J5lGIXaM8r0i4gvWYsjVZ5ZM2kRd396MRH5AIAUQLkXx8TTIgCX7PZRLQugYWHJ1MT
         3wEVb1KSvjb2r1B1Zuh1IffFeSE/8fC4+EqCmYYCrTGvbLYisMYiFSKYBCzQoNdjv2ab
         MBkFF4jNNNjjYeMg04H6/dKiWQn/ruLkeANIKnyWFZbXAjGm8l2ykJH+h5ewAbKBrQPU
         9CUJX/CQfP/XiiaGAZYbK+HSHqub6LYbv0hWGwRHIf9T2XI8h6yWoyHFoqGSLoMS3tD6
         Vcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784653857; x=1785258657;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G2zl8WdfYsburxD4Z1OSPDQaVBCCfCCyiW3l2jHNiTw=;
        b=WwK05uthz43RG82JE3KihW57zak5+8uvm3RMjPYSX5ie+UAzGH6anyfTJnBeSoylcO
         uNEB2WbqaO2YNbIsxHU3BdWo3D1TgeV+cs+23Q28BEk6HTCENBb366GyyNglbi6Kx4At
         O4PtDu3xl0235ozRJJUd89s5NPMcu97FaFAiOXeFePSwpA+MPI3sKatq/BfvLgsWI1bD
         Ek1hwz8R84UILUb7H76p/tqds5N0MQ3NDIATdBbDn4JpkL2LSJWpXnn9bAr0P7wto5hR
         OHMP/lEVqWw+01VaxLMjKUXCowYeNPnqKs83zskaiYqwH+HocjKvN6EHCjbpdftm03WY
         L0mg==
X-Forwarded-Encrypted: i=1; AHgh+Rruj+TUSi2Z0e0W+YuaNyy8/FFjaLVVJtwAkoYaghdqALLuRpk0wp0rYW/rb4ov4vyxnv/NgPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzov5u+dXMALTNeOXCbLQyfi6kPaFERICxUUGjNwfT0SoAt/hag
	uTPt2tRVwinNfyIK4+tAoNeDtLumlUdhOCnsHFTU7/o6NUimclC4VaNU
X-Gm-Gg: AfdE7clrjVno8GppU3PQpeOWZ24NOhbPILbyx4Pwa7RFMWhUrRBBXHK56WZ+dvN0ZL9
	2TGKcSlRAVuZk41oi5D3UH8GwO6EYNN3mDK2aKACXWuAACWF8fxzqihglUcp1VetWmvyZ88YcKG
	CyKJO4l+gJixjYPUrHl650NlQ37PAuQHvdCrq4Bu1MgpMkzmDvG7Y10kGhsrbw8pGIKRwoSgJiT
	XlcW2W6yj4YQ+M30pTqYFj87prnWFux2yr4TYC8hCVNZhYAdBeEIZ4dV/wZRV0wdEkbLbUEQBu/
	+0XlWqj6qvsxRqdJRbFzTa8SzBaqrYJc2N91BapILoYWNvuraJFBq5pE3v6B/zO0X0OrrVfP5mR
	y+ioliTcDuPu28fGpYpXPNgRhaXo9SgRtcCJbTEZaf82I8jGNtxThjIWN/HTZxC2/o9N0c5L6E2
	ZVjmqQxGcFRdMv76LSvLiMAZPpjHHH
X-Received: by 2002:a05:620a:3708:b0:92e:e695:d622 with SMTP id af79cd13be357-930b3ea8f77mr1959767285a.28.1784653856795;
        Tue, 21 Jul 2026 10:10:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b542bcefsm1201589685a.28.2026.07.21.10.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 10:10:55 -0700 (PDT)
Message-ID: <e24d45a1-c83e-4905-9593-abed06251c14@gmail.com>
Date: Tue, 21 Jul 2026 10:10:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 0000/1266] 6.6.145-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260721152441.786066624@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260721152441.786066624@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/26 08:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.145 release.
> There are 1266 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jul 2026 15:23:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.145-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Same perf build error on 6.6.145-rc1 as reported for 6.1.178-rc1:

In file included from builtin-sched.c:27:
builtin-sched.c: In function 'latency_switch_event':
builtin-sched.c:1182:34: error: 'struct perf_sample' has no member named 
'file_offset'
  1182 |                            sample->file_offset, cpu);
       |                                  ^~
util/debug.h:24:44: note: in definition of macro 'pr_warning'
    24 |         eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
       |                                            ^~~~~~~~~~~
builtin-sched.c: In function 'latency_runtime_event':
builtin-sched.c:1260:34: error: 'struct perf_sample' has no member named 
'file_offset'
  1260 |                            sample->file_offset, cpu);
       |                                  ^~
util/debug.h:24:44: note: in definition of macro 'pr_warning'
    24 |         eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
       |                                            ^~~~~~~~~~~
builtin-sched.c: In function 'map_switch_event':
builtin-sched.c:1637:34: error: 'struct perf_sample' has no member named 
'file_offset'
  1637 |                            sample->file_offset, this_cpu.cpu);
       |                                  ^~
util/debug.h:24:44: note: in definition of macro 'pr_warning'
    24 |         eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
       |                                            ^~~~~~~~~~~
make[5]: *** 
[/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/build/Makefile.build:97: 
/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/builtin-sched.o] 
Error 1

-- 
Florian
