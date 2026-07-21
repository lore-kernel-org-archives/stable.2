Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0A9415F0C
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656464; cv=none; b=AUWGNGS5owWUQfesJ150KaeeuYSSDqkKp/OMBkkEzjprOWu7slCVVkF4JQm4PwF1/YoXdyZ3DTH5hWNFWQ5zN3G8Ca2tiDscjCN5Mdl1Trk3s3s4L7gHdYszttFYlk+UFsRLcDTLoCkcFvTw6xMlYc095LxRYM+sLFdcKKvubK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656464; c=relaxed/simple;
	bh=d8T2drburGT8ZRqsnjGbeWFfC1IVmLbpFKZf5s8uS18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tU463uVy0I6feYA+wrTmaniYjxe0xLnmY/bhaWZujotzOUlbiYNw5G15PZA5IiZ0H7awQpFuOX27qKb/DFEz/FIU9OpbHNfA4NAS8StUFNQmcDFFwyzyG1updAPXQom+dt5CkktFGBsTVWMUKPePO77M/ur0v1XvV1Kuecub9A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=et5R+665; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="et5R+665"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92b21f65b60so487880785a.1
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784656462; x=1785261262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CahcOb8/acligSm7Jfk6afmhEu+yqZFrtttA/Gjj7RI=;
        b=et5R+665K8UyL+tqA06WeJ82uXUadvIIlpVZvstYc0Z7fYuQKg0mhoeO+MYI0xikdw
         01oPm8Lb5fT7c0wSTTFHYVdi0Npb4HXnnpnrTcsvekpEzhDrQtMK8gHb2yPdcoyzSiJf
         B2HqGVbOYv9jrrIhrCHWxS352NDQZrFKUTek3NJEMUSrk0v0sYdEbwCXlf9E8l92dqmu
         Eucx9Y3h5GWFrYRMSKhxxlEkacyEeZ7SBM3IO0+m8cVVpF0Cdw+hAiq5QtgwTwxZ3v3t
         1gj1nk8Lg04tWv9MX5AknrN/1nUhX+IZvgBPsI3QAqmvFbjAbAev9rgggiWbACUJlYPP
         PkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656462; x=1785261262;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CahcOb8/acligSm7Jfk6afmhEu+yqZFrtttA/Gjj7RI=;
        b=bFYG+/eNKWD/Z1dtj30cSUgWo1zM2TEoaGEyoRoING5iS2KbyojrMBK0jJGlRKASJz
         EbReq69T9wt3AtfEmywjyHTA2CYb1q2JzjwCKPlVSHvbT2vr8UF8dbhLIEViqrq5rR0J
         r283K5z/wvlHSdoM6b5dvPFeqUYe3lr+UMbjfPAJWESpqPOr3zDjK7pk5XqIK4xbMynQ
         NbUNOKFeAxuyOkpFuXEotu2I4idRjqEl2pVdsbV1t/RQ06EVr0GJWzEzCfd5rOpqd4hH
         QRjhsqtKCDzJoHrmuKoKUIhhtETe1AC0K8l3112zo1sM1EO7GiCz+1KtlBrCGSTa5MEo
         WoJg==
X-Forwarded-Encrypted: i=1; AHgh+RrqCV+4/ck4QpVpS8vXmDoFAcJiP0BLmwKNJW8wnIhanRSZWeNoF/YEnHmWaDpUHpbN2ruISSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz971JYaZsIQBIdIb+NJsE+cNzPjpAVzVpq7lcUE9AzkGZstVnG
	mCNS5Y3n2b1BoBWoedHkEEwHY+N5raG66DmvL13gZJWNIFJAl5JgEmcbOi0JUw==
X-Gm-Gg: AfdE7ckaDDfL9TYjhYd+GtLKKEaT8vBUll15P4oQaRbWFQC8teKu8Ht6aAhDr8/bKx4
	aqCXrLQ9aJqhqa22JHmUaEssd1GyjJynMJlWitrYI0AVpCGb2IL6UVJitaOqDuId6Ps3mwHDbYO
	E+paEeA0eiUaUj7bl0izBgZQOyHHE4tGzd+iARn2U4qk/YfWdzgO3eC1lHoWczslsQolcsEKGLE
	OaDXIBp2ibe2G8EXbXp5rH0UNIU1POz58glnyAQ7Dsrfb70so744o0rETIezoZ/s1trevrP9AFD
	rINaMC8RVGYnpBsPvgEijXbdajmz2tDOVqVvijkwEJOegOhZGomZ3nJ3WZx+0sBKTdxp3tM8r7w
	bEvTHJYSA/B0Y0I27Jz2FFpv4ZuRpqX7SGpvMjz20Los5aNwMDHI3V7O0vDd/ag5RjUwmb6gSw7
	3PSCBOgnVps8QpdajY3OPEfvGkzrZc
X-Received: by 2002:a05:620a:8130:b0:92e:c0ac:aeb7 with SMTP id af79cd13be357-930f3021f9fmr64808985a.41.1784656462322;
        Tue, 21 Jul 2026 10:54:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b5493cb0sm1171228585a.42.2026.07.21.10.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 10:54:21 -0700 (PDT)
Message-ID: <b7e241f0-2604-4609-ac21-483b95757e10@gmail.com>
Date: Tue, 21 Jul 2026 10:54:18 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 0000/2077] 7.1.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260721152552.646164743@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260721152552.646164743@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/26 07:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.5 release.
> There are 2077 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jul 2026 15:23:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build with:

In file included from builtin-sched.c:28:
builtin-sched.c: In function 'latency_switch_event':
builtin-sched.c:1196:34: error: 'struct perf_sample' has no member named 
'file_offset'
  1196 |                            sample->file_offset, cpu);
       |                                  ^~


which is due to 6018a2a9ff1baa45426f7a52f8ec4f7d32fedfce ("perf sched: 
Replace BUG_ON on invalid CPU with graceful skip"), we need to backport 
a490187f22b4bfae7ef752edbe3fb13017ca11c ("perf sample: Add file_offset 
field to struct perf_sample")
-- 
Florian
