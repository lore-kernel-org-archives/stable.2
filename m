Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665536;
	b=kVtdfSF9rm+ZCpz1YBdlJnBlf+qto0tDBd4hAGWJFIcbeKePqAAg730oA2GiiHvg/B3N
	 V/76SdHQ46/7RHerx7Q1pEuHcaaMtc2ua8x2AN/k59z9YihC0A9J70AjSg1EHMq3zqqy8
	 6VSTJlUK7yDLMo/0N1nRxr6B7FCkuIpHYG19bEHKzan3qvkCIOH7nJq8hOGPCwAl+m6hm
	 x2t4gMBXt9FvTF8+hA35X/ABeIYla/75oHaLBJMF4AecoyNrk4zEaVK3xB6KWeNQ2rNZY
	 TqPbxdK9qwR5NTBSXFIly2YyMphSzzwMlYYUYjyTWwCyoBIwPLc56Rs8biAv2etniJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=JukNCv19tRLo1eRg8w/7wwr8tQYsc+7QS+KjL2U2X3g=;
	b=P5aWo20u4XwT22e1Wqpn+P0GW7jtPHXvQUOiSb7z5dNMzsYuIxfl2tvpY05KZ2KLNst8
	 3Q7X9u1T1cyqZfKR+dmtXaWUgR3nl/ivkwEWi42nil3EMnHVkey6bM3saUWNiONvCshIv
	 idk/Imz3gEUlmZXlFdqd0qn3EDM30aKid4V1tMG+gcBpd9TFIQvCdDwkBLF7sXhOb+wmL
	 fqd+WlPCVpBlvnlm/8QxiVUGNL10V4uR+UFbV8ndonSRsZFQMS+RFH5Qli8iLaaxtSLj6
	 RhKQ4Caa2Fx0BZgBfg/GUaRQxgc5Y6UVQDqy/gEWAU0riyc27Q6LROEnYUAfZiQDJ0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vkq3p6G9;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E74606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06E74606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vkq3p6G9
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-385c497bf94so4512346eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795665535; x=1796270335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JukNCv19tRLo1eRg8w/7wwr8tQYsc+7QS+KjL2U2X3g=;
        b=Vkq3p6G9Ih+soPdA9g2L4Ao2q3l/fvd28otdHxXQv4kMssxkLPAvKgZRXDJyyQOLmC
         AXpMY5ckG5atNY8lfIRMpAJU9nNscG2Ky4dkWlPX+lOGXfrdPux1Ts8GOB2UQTYlukQc
         41x9wo8QDndovSJXbxxPxZcjLoZHc9fwAruDpD3XmdrFMbh0SkSbKc5tOHg5MsHHfMbB
         7pkIhSrt6jyjX4qGtR5ZoHN+2dKgM9y8SeaUpDUtksq5lIYeT2yy4itDV8JjHhT561OW
         BAnnZYYUl9bUynoz8ALSj1eYNcNiSPljfTtu3A2Z4PoGLeaGWEkXYxfECziSB5rxvNxo
         DXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795665535; x=1796270335;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JukNCv19tRLo1eRg8w/7wwr8tQYsc+7QS+KjL2U2X3g=;
        b=X3YsW1jfZCMI3zNwR1JcIFqInvt+j16ago/QbZcDaZUoRUhkQQPfqa4RlNwraPgrVr
         TM5Mjs9vehaRyZijqnu0s2aK7nmmWwkJRJgCzkVYMXu2d93oUp8e8IbG5/1bNqMlm1We
         ltmzsbrojbg2MQt8em2Dg3ujMgh7YkLx4KBlVG18b+bOJ0ekbbJdNpwkuRbyPb6ZNpnN
         +17VzUZX6O51HGa+tNA7OF1TQkxqahvY0AwRkgsJchar1dsG5qvyVnIU+kGTciuGV/8f
         HTd8fLVplndZeZIfSQm8YqvqQmAbdj4lqR7wkfj7uZFQ1Re8j8IA7QQqG0YPHEIef4Jn
         AoLQ==
X-Forwarded-Encrypted: i=1; AL+hErEslmmBcZBUKz1RMFhe1m9yV6q11fD1tujkk9CRsNtg1JVNYVAp4H/EyIutvQqLYLXqn4tUd/g=@vger.kernel.org
X-Gm-Message-State: APuU4Z8StX9J6KNCnXqf3QyeVDBKyPxtzvAK6rhP0UJ8TPXLhXD0j7y4
	uOwJ52+E8HBzhY7Y2YaPD4tVxrH4oHZ2fRf530rbNCuhPoeZ3F0NNj6ZVZ3ghg==
X-Gm-Gg: AZFdTZdjgDye4lZKHPM1VA5FzIH/igyKKoD8QB1TeeBMUvEy9JFq+sZAshnkzgsTKic
	pzsdMd1ldY6/cIzNF+c3QafbsF84QitjX/9KgtkPVFVgviyJXPgynSHmXpUd679M3Ya+WHtB5ob
	x0zYCUqd4FEeJhCTe2B0G9hiVn0sd1AnVRJtHqRcscSJKvsju0Ey5UikZ+6mHcO4NpBVrRM7SP/
	dBMbz9oARWjmUDEMAxxUxJyGSlffIJdPG5/2q/9bbNqhzgRbPpfo+2cyY3C2DdFjFNUWkvzRz/5
	E/9xd2qXw+pM3sYZXDdV/gaWW4DtK1sfMSkNk2P5Vpb7Dg/qN28mEfBQW3NocTXEANhU+YxkVbq
	/OD41vBZaTEzVDzY697wP/lp0WbO6YqawWXXuolyERuxbsjWLEz/IQWQTp5bJg6GyoLxOa5bwxF
	XDo8l9nOCJ3f0KXmWh5HVJ3e38J+XRS35kngj6KZSkbLKpFmVYkXnpBLPkrx7W7Y0uknD6TTc8n
	fuYWlNOS729g9I17aC+8oLj9l6+CPK9V9g476vCIO//8nf58X7m5wszBxW7402BnLoU7cxor591
	xAwm2yC3BwA9+CZvRVtcLDAptxAHtRnxXqkAhJlthLLGFbq6AYkSlwl/WW4ZBJCfOJwCF3bQO2u
	J
X-Received: by 2002:a05:7300:1899:b0:386:b6e2:9fa1 with SMTP id 5a478bee46e88-386b6e2a02fmr14756733eec.34.1795665535054;
        Wed, 25 Nov 2026 19:58:55 -0800 (PST)
Received: from [192.168.10.3] (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b1965c02sm27050486eec.27.2026.11.25.19.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 19:58:53 -0800 (PST)
Message-ID: <57b6b3b2-a7af-4b8f-999b-9e646ca7fab0@gmail.com>
Date: Wed, 25 Nov 2026 19:58:54 -0800
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
Subject: Re: [PATCH 6.12 000/816] 6.12.120-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261125143849.205329330@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261125143849.205329330@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/25/2026 6:25 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.120 release.
> There are 816 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 27 Nov 2026 14:37:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.120-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

