Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288277;
	b=cAwIPJgJGzaNQgepXsp8cYCPQdaGv+N5ntVPWm4yWQ0zmwfjdw66rf5+YFsqFG4rvckF
	 dhEg1oZjOjlcdhPv2zNaRewYBcdTDPKqbEK2AIRxwoawng63GGR/vaXeACNIP28nQTtvB
	 xFRDFnq5s67MGJCgmvGjh1aKnvtlmt/oIT0eOKTh+sGc588/mslgB0XN5maga/rz6VzFA
	 cmZJAR+p8jULVaBrjWlFVxV721XvaMG7QCuIivoiL7HpRZrGgEv42jeP/zPWrUh2Bo6Kn
	 vrqdS3zacbzg+Wss2h5Cqe6MEZrKYpNrMQQ1B0JcyW1WbUwTD85MTsg9xxN4RVFBA4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=2V4JLnzK67IJcCHq2My/KdT+6D1UK3FIaHGDhvNAL2Q=;
	b=1U1tKscoVAhcYBMKMfx17NtldQLrAIJSMBZe5PMp/vXcDtf4JXKh9PsdOdspz/kRJAHD
	 XG0LFwJqCOQvCsikb0eKx2IH8lSqN/ZMyShr4dFk8KMcY1xhwG+Q2utcckK8psgdYwd7l
	 nRzuyAdcokRuMBqlvIWl9reL26nq1JMwoA660cMtOfhca7f1ys7gquUZQQFZUnivHzoeW
	 BXwTofnM0I52FE1wDhuIZUaBce+w37Hghyzgvw7hhrWfjArYzGUstStF7Lmi7yvGsJrad
	 Tu8eb+3vuHBtIUYKW6BPnkPnOA7MGw++oLP5Q+H38SDUWJdTCT5g52WJJwVJMvLfryQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=a5b5fqfb;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2A2606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F2A2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=a5b5fqfb
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2e8c710847so325983866b.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1793288275; x=1793893075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2V4JLnzK67IJcCHq2My/KdT+6D1UK3FIaHGDhvNAL2Q=;
        b=a5b5fqfbsM6YQCnbgxPKayZv9HBXtdBbkQ5uP7WiwYd/FTVKTaChh/k/qTm103PiUU
         adAkhwfWNJgdrCwUs8m1xhYF0kP9zMP5DbmTiieQq2746Vh24R8U2JOyAuq5v3JHDVtR
         0Hse91EQGwWg9aTMy39xg1F3OXlIZD0jQba1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793288275; x=1793893075;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2V4JLnzK67IJcCHq2My/KdT+6D1UK3FIaHGDhvNAL2Q=;
        b=pr7eV9LTeV2NXru+WtJ1kSu9IqPL/crvLbjVgP/evaPi1ZNYa7Pw5LlM6LtDEVzsv6
         KA6PUWza1kRSegqTdy18DODfEf721dy07zpHZY0bml8rgW/Tkq1SGdFP/uUffWWj9zio
         WbgFpC+fu67+oqitJIlt/E1ToPEXNG2dG8i4Z2NRlWNot2UqrDIpzCIEHbRJjCbK6n6+
         iO7ihlNH7VWdzZ3H1iYsGmNAAXgsK8IiLLrLkELkVTsi2TNxgBRJimwKRrLB8h5Ciqhj
         btHtz4SyMiEe0uZbcOpVESwQn6n/4rUc9vMGhCtfJCdKasy20vNSBDxD5Kx0IpAjLYEj
         ZyYQ==
X-Forwarded-Encrypted: i=1; AKwUvBxyEamY9GdAh3WwY9WaQ0ADtEMdbhS+TSocQDgrXCb6ipN/Fnoqy/1gWoP3oBmjqNrVKhpgPXM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEo2KM5X+miqWyVE/Di4K/GSbpUXzhlQCyBATwfXog7uhlorv2
	xzrmNqeWZrnDMor5RjHJyPvyQ2lGH6sziyk83P2fHPHtFE0uTJOX1Qrr0rPWTQqtPbQ=
X-Gm-Gg: AYBFou0Dh0x5u07ggO2/oCOZwNLdo1nPJDSJhtrH0TcTz3G8PHGoF4Jmaeb0BDsU/1m
	JgxWvwyluDrDrtEfwtxeKTVAU3TmeisNnc2iIqdrWw+/AQ6yQXsYY6aSuB1V2T+gPuU5KZ4UTC4
	WQwFb23/+UNnW8cxbGj4XJTnMQLb3nOkArGoXjKhAfTW60l6YG7N78kbhL3/muwj+qpebWsocnw
	MZw69Ur0R1Rup+7LrC/QBTJLdeRlFfINW3DIzL8S6sXa8lLwPncBMTi8sRM52+wp/p34kaKBcVa
	BlFvn9buAKH21bU8749yB9nJB+Q/qwS7Ud5NFUxJ8vnoBqUImQMJ1lDB6U4r5J50dDIlKby7tVz
	shQALF2OnxaLzPZ3U09BbeDS8jzTahE1yNgh/QLcCErn7SktsX/eYcAMj0Qmpv153KOzTDs8GxL
	DeyRxohIDsx/G1UJb/FuDAYhn1O25v/Z5/qiSIImE4uPW8C5KhfWq858DQpdAdWl70OP/eXor3D
	pr+8Iyvu1keORFVzUuTn/3nmns0e5dAH5VKvCeRgS4OZLoWlZ3R7neK2zxrtXKjR8DntooAuvYu
	kSJvlq/RBOfFXuwbAESFIv3myGFcrQQvzCw12A==
X-Received: by 2002:a17:907:3f88:b0:c40:80eb:c54e with SMTP id a640c23a62f3a-c49bddac533mr513399766b.4.1793288274113;
        Thu, 29 Oct 2026 08:37:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4ca26498edsm3437966b.21.2026.10.29.08.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 08:37:52 -0700 (PDT)
Message-ID: <5ad973b7-4e0f-4122-8abf-5c5d59b51ee6@linuxfoundation.org>
Date: Thu, 29 Oct 2026 09:37:45 -0600
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
Subject: Re: [PATCH 6.1 0000/1887] 6.1.191-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261028170459.200466217@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261028170459.200466217@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 10:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.191 release.
> There are 1887 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Oct 2026 17:02:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.191-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

