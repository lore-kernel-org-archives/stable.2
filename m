Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9605E4854E7
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075216; cv=none; b=sr6Kx6Hco/I6JSZ+ZGYFtpb/uGznmcQnQGoUgR6Ze5tg+I/hDPw2wmMAZZJPFPd1H0XMAgz3hQSNJJcQL2if6rblFZMFPVy3pRVCULXwrOu6OSEPnk2sARra0844IyKCHucyMeyssBYzXMzMa/ghz82YyGH+Smx8ddWiz+KfmGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075216; c=relaxed/simple;
	bh=J4UYv6fAQ4yuFzibg1XU5+BNJKmYJenjsold2tAx7Mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKzadQZg51dp4eJ+gslNsz7i4K2jfH1ntn0azZutxngnU2SICkC8YTs/pZLA6ERS6NZ/cVQGAR8wdmIOP6Jp07r/l9RXyuTmq6UAFM6fqZzncvZEhBRjJOohBhSHG7IktS6J0xYeBJB7rTSyKLvHv7vVj1da5e58Oz8W+Vn3WR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GfOtXK7A; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GfOtXK7A"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb61bbeb25so76165a34.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 10:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787075212; x=1787680012; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IW38vascXUwMCh+f3xoc83fPD2z4l5Xb377VD6uPgco=;
        b=GfOtXK7ABWx8QRRGir5AUucvJ5aIor05i/x8CYuwei7oyJ1j0OpOQb5mOngnOVv8Ug
         hEwvUzqCUmRP9HmwQDjC/Q9asqmVGNyZbqwGRb+SihejFWB4i1hT31j0aM7otEzjo4uE
         UcLPc1A1RTJEew9X+1hREvv6l7ilPf8UKBheQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787075212; x=1787680012;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IW38vascXUwMCh+f3xoc83fPD2z4l5Xb377VD6uPgco=;
        b=GqpEIz3kF9TS2t6IfV0Y8fXQoPghghouVLOqykxs/E04AkgqBoxQ6+ZQXijlGHhLgk
         cnRrnZs8RgFP6cQY9aTZIwlYlsOIFSaEyTBZnQoFQjMqjpFxh302OPVXCNVH7iMRJZuU
         wLkvUcezm5GaotDaHD/Kjlkrg27strpKTDgJIJixfMwcV+qcSidG8eVtRA7FUKmRi1Ad
         2/ktleoFidhSLzftVuAzonQGz5htNOxlo0TuxXSXzd8vhq6H13+yXv6DMpBQ+7Ko3yI7
         hDymeB+GUaFBFFL+AM6BuNhCLRZBt8HnnfEA9BKQtedtWJDweT+id60XxiznuHA1ko3n
         pfLA==
X-Forwarded-Encrypted: i=1; AHgh+Rp2xIKarlL5vwOM0PW2CAJhXhbKWBuwWjlY3jRqIQvl6eT1RqQGv8aoT93J8BroYwYbLVfMBNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw95Qo9Dl8NIQit3HvCiQcHj87uslEhbNRyzkO4PPvDjkJeNVP
	ntb1vrOPDMGCzUJRfiW3WRJgOcFiXLxv9SEKJLjF1hfzSAPqn7PKsSJIrxGweDrxKBU=
X-Gm-Gg: AR+sD12qEgLNExZO5cYmt+Nm3kJ0cVMABVNfDXZD9GdbxTuddejA7TN6bW++3/droef
	XC8hcvw3Hsc/wDyJw6ndAJKmJXlXE8EEsWCcCE+/222r6q5YGB5v6qnuT/3SBub2Fg/1hx9fhfw
	tBqHhCNcym4cCwrI5QK4m1PbWUIAvxdwCRBpC1hpEJyPtmCiWCqncYqaWlIPwmrF7/vVSW0sP1F
	F61cf9h6D4FOLnNVSKoe88JWn81T5PdqSTu1VZ1Zc08CTjFTBi/WO9yapLSIBZlamnNIzzEKbYD
	+xACWI9xCyl8m7vALEXlOugLXZxXxG5NCx3A81pvCOMOdEUR7InXIkrO4QzahfKIvHUs4fysCvm
	vMRZHqsAdrES7lrClTuCFjQi+/8NckAd/E/K/03dvwGfWXhL3b/q5+vUxNMX1c6DuNJ1GeYHD5k
	O1miTkh+JyC9fbWzqlNSui8rxO8g1LaQ243bYwtKwaTvoUQRtgYDJ5sHqmKD8Dw8AHXJ2UdA==
X-Received: by 2002:a05:6830:82f6:b0:7d7:ef0a:1ce5 with SMTP id 46e09a7af769-7f3de631a8dmr32652444a34.9.1787075212385;
        Tue, 18 Aug 2026 10:46:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f41c0f6d05sm4802639a34.24.2026.08.18.10.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 10:46:51 -0700 (PDT)
Message-ID: <cd49274c-1bae-45a7-b187-7831abc52849@linuxfoundation.org>
Date: Tue, 18 Aug 2026 11:46:46 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/181] 6.12.104-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260817132535.394764707@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260817132535.394764707@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/26 07:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.104 release.
> There are 181 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Aug 2026 13:23:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.104-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
