Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795204189;
	b=pLRCiM5migG/Vg9HMkkSTSXnzMtyh5FvuWvu5PCbvRd1VN+29cPZuzmuPb3FtPTROcuy
	 CXSrj9RaKQgWa1HsvY1ZFhROcsSXbKLHjS5zXMceK4GTrvdXmPL8B1Jg7BOiXJtxs4TwE
	 +1YWo7ZhG4MLzb9YMyd1Bg7YnK7CBuNIx4+Y/JEwNNMVpC1nSItuHN9F+qqxYtLva59QO
	 ZWea7ayVOXEn06JoTYIecT8SMq5HVbo7Nv04reNb8wfsFJJy7Tpe/fMFrFnJQVR+Al+gX
	 pA7/+yfake/4TNS63VbbXe40beED2RJc8krzjpiwsqfs46SaoP3q5aNzE84NsDMjIpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qmrspoDYekLGdhjXLm1nbvWqmbjAVLQNUEcJXmCtCSg=;
	b=PIJVAuX4SGSC97zYOqyrlOISDuIoY9mb3IhrqXnjLY5ofPnASYfuMkbKXNBquIlCm2SZ
	 31OEDLErbGKJsSAXRnt9/LH9krcROsf3OSH2rmqMvW06DnFcZaLRHVk4VDqa8F7kzxzkg
	 yM9v9kd+bHa1u7Y1bmPVsTtQMBiyG8sSgBbhbvp43+tV3XmTEtQxnswUKHlfEcR8jo85c
	 O6VOso5NkB+uZ9S6/kiqyKi/lWyf4eoHBFvKKbp0v/NddfRJITyD62zZzrIlidh5SQDbg
	 z9cMJJn2/rX8P3Is5GRcCdN5Pn/yuUcPVYu52LZoG86bV+XXTvQmbbZdMAh7sLEM/Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JDctpr3V;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2D3606A6D3
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F2D3606A6D3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JDctpr3V
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-92134c4592dso11994206d6.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795204186; x=1795808986; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qmrspoDYekLGdhjXLm1nbvWqmbjAVLQNUEcJXmCtCSg=;
        b=JDctpr3V3nwQPzlpYzkU7srT/vZyTxiucugbB64tnhNzLkNdo09f/Lw7hEycEE0geV
         +TFj9MJ1jyanEwy9ASLwHHfSB4TB17SKeD8HZeIAT2WCP+9ijt1JGxC/vkEJTAvCNK08
         L7IEyWdOELJ4b6iQawPZd4m6A4jDcCPzHDBRgrx9zSA7CgHW465xOIYQ5oWyLswUUDJi
         w7VUZaeTDj/IL8cJluZJShJgMEPmWMJ4oZj7M4a2+SiWF9vkT5cAJ/tZJDqSooBA5rSI
         uuihWcwTbJ3TyIbmAKsGguJd0NMTcW2BibpAksQ1N+p+FaVbGER9/3akpioktfizqmoV
         E+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795204186; x=1795808986;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qmrspoDYekLGdhjXLm1nbvWqmbjAVLQNUEcJXmCtCSg=;
        b=1IOe6B7Pq+mhCP1rXsZIzFAm60a23OECPl9KdvpIDZg8QUo9dGStIVRW2vdw2yTCOE
         PnF8+zQuuN443JS4bzjAJxaF6t+qP1eD2mlvbVU6okbVxIHKUv0MCVlQYvX6Sh7Rygy3
         PRmKXXWT7mDzesgwqcbGV75BZWUs7GxH5zvWt8S5TJ64oFvWHuoG4QePR2jyurQxxc9z
         kxr+eIsoQt3xPW+xnoyuGPeLmiklobmayBcuWFl5whkxIQhAeFWshRSh7b8e1hkV2ZJV
         Zym3VVAgs/XeoXKKyzlD+jq4MQnS8Ii8mk6AJQmQwRyh9i+0ig0wKsf5MeZuMB7raSPG
         nnsw==
X-Forwarded-Encrypted: i=1; AL+hErHKjwOfeZnudE7FaW81FT0UMgu/B6JFcS/ZbUAkXwCo2Ccs120wfN3Pg2jaDX8/Kq0lKSBfbAA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4ik2Lfaz7T3unES4rsqD+4LqmIgqGmILoLZlChBE0ozUadLfj
	kD9hgAOj1Eg4JEeRhDWqqac0LDkTUborDQlUPwkawDksiHMaBFTVbMmg
X-Gm-Gg: AZFdTZfoRJQH+Q8lLWmwQTGuqWNUWAn6VJnOSLqNJelXAwkYUa8J898pFs2HR/OiRRt
	PG6l4UPwQc3AlrOuFRlK6FY9F1VulZzSAk+n/bjt6Y/daeAg9ASTQihOlEMyMrat7IRaqzWdAjO
	+AJCB2QEaFFgVfWBr3Bs14nWMh3KnNPhIUrkx41CKH88yd2OXu695odEO6DDrJZPRdpU0kX+Uoy
	3T1AgN/phCm1DCbl4SIEYbcsGsx0zK9sJeZ4EXVIK8ZSN7GlmjqU31H88zrEG6NiPZBSLcFBjOj
	vJPzc2jG1Ok4BMluLZCXMT1TgqQJhL9p82Nh6xxUPp6Wg1GeYXPJ2rgwPA5T2FRNPmVSrfrnttE
	clzWEtiZJ7N/y3howZ102H/nh1JXhoFyAUwwVjQVRV8qj4rHYDL0vlrMKv3oyenZ3/eX1Yl/5ue
	eMb+SvJGw8fq567+nTCuxlyjJ1iX/Mhb2FEcK9xyoE8A5wHYsUB/UxaUrmDMsTG503K0dPbYjt8
	dKeKbKSajG4g0gOzXYSXLcecO5ldZ5sF/Y0dKC8iJC/qZAPY87frqYmAnHECPgUea5hWQR3hTlj
	8HFpP0CKzz9kdxBT0c7KJZDgiyS7AVD90yWRW3ujP1Fqdj4b5ys/HiKWPw==
X-Received: by 2002:a05:6214:5c81:b0:921:10b4:48cf with SMTP id 6a1803df08f44-92134ab9b6dmr64832756d6.46.1795204186213;
        Fri, 20 Nov 2026 11:49:46 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349b081csm33351676d6.7.2026.11.20.11.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 11:49:45 -0800 (PST)
Message-ID: <16b5699a-69c8-4d57-ac71-e61b50846415@gmail.com>
Date: Fri, 20 Nov 2026 11:49:42 -0800
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
Subject: Re: [PATCH 5.10 0000/1811] 5.10.275-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261120054906.397973290@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261120054906.397973290@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/26 21:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.275 release.
> There are 1811 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 22 Nov 2026 05:44:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.275-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
