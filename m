Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166449;
	b=VS+VQ2J5mGiZwAEVk2/vums5SmlwZs3qNKvW2exTGoKhvBIn6mEcATQPlYRmECM3a/P9
	 rY1DfvG5Ig4iRTp63Jfkq98Xsv+kYr0JmdrrLNByfrDLPk3DYsG049oBEHb+XorhXbFE+
	 9Gv2BGFLRfQfnGH3zVpBQ69FHUv2cS29Ff6+dZdk3XqcEMElNt9Oey4lHrxsZQ0dmhBe+
	 ERZaT9wH0rsBCYqGwXIzwHhaSeRR/i1k14HjIWo6Y6qz5Yi/887h8LSOll/EzhmdDIAue
	 cCbVSuE+V7dWreBKVEii+px1cu2w7NhUeH8/cuz4bblkRquLDZ8u+NtzinLjDdUC0gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=czHZiY+9BKHvkt45mR1YoRXSRAiRq1bqN0SePSnojIE=;
	b=FqUVPsVWSxBB18HpeClll0e0soAmKsiFSeRkskDsKxNiU6l0p1P7tQ7wVgOXVmbEYWq+
	 mtTuYYUBblZlC7a6V+AUHEEvnb2jG2LRDV0FblN0hmpk78vftSZctMq54OWQGtredS8eH
	 azelHIunIqAQIWGE2w2od4UoivjfED+AgXcfVHi1vRWt85q6D1SW0Na3scBBjStRSwtr+
	 liUXHpVaihz9YhRyy4DTccE4wnve3zF3UCIiKUw3KJZb00ZqVl/7fikHVHO2bmAxxnOiX
	 eeWb8VeK5TLpE8o/UBM1J3kTBklJxRWRluB/UgyxVr7HYZOGrMQCqiTNy3uS4Ww9QKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yvTUcfOC;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E347D60A2600
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E347D60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yvTUcfOC
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e9d7791b00so5858635ad.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 01:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795166448; x=1795771248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=czHZiY+9BKHvkt45mR1YoRXSRAiRq1bqN0SePSnojIE=;
        b=yvTUcfOC31qicbyqDhv4SOlQIQxOgg7X9RJyqWyAV/bQbKf5F6FZuOl8Etrri3HAXc
         2gNp9QqurRA+4hLJrZRM+9T3tH+et6DikIwDxsAhpTVh5pVTus4HQAutTZTMrnZ4Op+c
         kwPEbYxRE3LVCCMglC79plzpZXLqnEAfG8pF04T/Ks3eoumGVIZwUHVweH6Wk8FtyPLO
         5seqfm4T/InhIyzG6c7aVWea8xamYXwwzW3ahz1ASojxVu7z/EBBDbgybqwkc4u1LRg/
         MOfQOti+EEC443RVfXTVRo9+e40lo3shGkjzTe08iXODBELU8g1l3r9BkSIUyC/RdUVT
         yybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795166448; x=1795771248;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=czHZiY+9BKHvkt45mR1YoRXSRAiRq1bqN0SePSnojIE=;
        b=BVAT2aNLTWCzFzZoebGMZYyUuXnfg0ZTolMIqxn6rwttdw3yfjkb73I07TfqXTcgQI
         XQl+OHvpXA8+PYX0j6alQDy5n81VRrHADu7gIaof6UHHznI1HVjDkyjTVmnTguyJ/dRe
         UBku5PwfYngShhEaVpwtc++zKpGatF8Q/XL5Ae/TMH3PTCJ6cg8v7tEOQ2Lo111Jxl0O
         jvK0CkbdhsRhZjKhfPZbtawVY+D97bpdo6fUwyGgoj3lC1gORMe7n8TTypJKcxq5H7lw
         qWpWT2rqcuEKvqweCqJ0UUj4gqLJuE5wqR0KhPHRvKu/hIHW9UiAv4bwrGZkd/YqAd22
         1nDg==
X-Forwarded-Encrypted: i=1; AL+hErF1C/70T257omJr9XoCi841yQXLSNCWIFGzIf5zmxmB9LzsguhlMjycws/nk9KT77+yMGhxUFY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dPIUAelxfNm5CpnBNThjqbfUWkvEDtws+PsUJ/WKLkfvuejQy
	/PWwWE8zdkQc17hcoXFJZuaYFyU6/jZJT6VWNz433685XUIqiVb8Ra1N
X-Gm-Gg: AZFdTZdd6BuUxpPMIA00Fqvd0VTmF13GkcyaV0bFgX0mlZFhoZqptJhDyQJSImyvVQT
	l81cYNyLJI5Pf+daGQwfNJhbB6960ftqbn2fuYqyQ7ncC0FWeAU85pFrG9Caf0SJ6Vkpxf78D04
	naNkVjiAcSdbs39bLlpeQ9HTD2SFif2HsJLWYa+F6ru25kbDnSnWgD8kEIwb+x57mgLoo/3J4b/
	GpK1AMd3LZKSk0NvvFifssPttIxXDXBGAxblMIUfkx6e/zHUuQKD7kyDtFUaGQz18Ul+1e6dE++
	gjDN6xxpQbQ+l16RywxoJZREgOkxV5k3kw8Z81EMG7+ooDKEWpgpKKvzIlcuetGLsUq2Gol1cGc
	3xd6Qs2lwG0w/+seiOZwPY0bcZluQ/VzUIY7jFcqmO/FLwicJ3acl1oZ+vb5nC60FCskmhE/3VL
	uQdywfPJUM0iI04KZL4ZCbD96dzQ5s0MfYtK2h0R06kg3tsayYbDZAQavfxXgR13GFkxxF5Up9j
	4Tcyb4xS8/K0SjRG1OsGSNb0qb/vZkj/x1oFklvzLNxaHoXZ4bQd4agt7jMkrj5dWVwrD0Mm0vw
	G45WQKx8Ce/yJcEbpWFKbhqcgZUu8UfMof2Yh/23mUkKGuCvnQ==
X-Received: by 2002:a17:902:d54f:b0:2ed:21fb:e762 with SMTP id d9443c01a7336-2f03f118afdmr24187105ad.12.1795166448218;
        Fri, 20 Nov 2026 01:20:48 -0800 (PST)
Received: from [10.222.1.82] ([59.20.222.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dbe86sm11689635ad.32.2026.11.20.01.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 01:20:47 -0800 (PST)
Message-ID: <6c7d8900-2b68-4431-8599-527fabfef882@gmail.com>
Date: Fri, 20 Nov 2026 18:20:43 +0900
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
Subject: Re: [PATCH 6.18 0000/2144] 6.18.65-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261120055114.182757740@linuxfoundation.org>
Content-Language: en-US
From: Joungmin Lee <leejm516@gmail.com>
In-Reply-To: <20261120055114.182757740@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/26 2:58 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.65 release.
> There are 2144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 22 Nov 2026 05:44:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.65-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


Hi, Greg:

6.18.65-rc2 successfully built and booted in my system without any
notable regressions.

Distribution: Gentoo Linux
Architecture: x86_64 (ASUS Zenbook UM3504DA)
CPU: AMD Ryzen 7 7735U
iGPU: AMD Radeon 680M

[    0.000000] Linux version 6.18.65-rc2-myllvm-g7e0638af5322
(user1@gentoo-zenbook) (clang version 23.1.6, LLD 23.1.6) #2 SMP
PREEMPT_DYNAMIC Fri Nov 20 18:08:46 KST 2026

Tested-by: Joungmin Lee <leejm516@gmail.com>

Best,
Joungmin

