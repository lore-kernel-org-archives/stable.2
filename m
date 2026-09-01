Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598BC442385
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281198; cv=none; b=bV45hXomucdzB8iJpZoFy+aLjGzbhjG/e/3yjhB5VlWWTHooc/N91AHskm98M3CY3eLDIdi/7NUWsFWZbPvjbE+ZDKpoId9K0rILRwaGnw3TKPvDZVLxd+ujGSuy07V6/OYGX3NWTTEcUb0C5nAqUHhuPFgf2gTn8tbo5Sn9z+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281198; c=relaxed/simple;
	bh=vx6IVAIfvGi2YN6wuW2bjqrtH7e+yn11t53xGem1iAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sz3CWecUYrzl7Pzx6wu+3AnTCO6cXftmwsVuGHSQaAm9xJh4djXsd95JXWkHe3DjX9Y+8NmMr6tGxtEGmErPqyeTHQq2aazD5/ACjmTUEJXF3hJEyz6RV/u8OSEWqIg9lVY9EPmmBpK85rsLr28CW7UtKaY9ohn7XhoPCTzk6GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NgvX+Qa2; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NgvX+Qa2"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6aa9606ddadso30177eaf.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788281195; x=1788885995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gQ+8Eg5A7HAboa6Akxc2ZyEa3pqY0HjMm6hBUa0qhPQ=;
        b=NgvX+Qa2DLcoDbMTsIEqcZq9Kiu4CrROWhj8nICP/2PJ2h6n+2ZarS/BsYh6O8tZOo
         RrkZil3RIP0J/54NjI64bOz4y723DvPgSugeMkZdK7lPD7CAsFdVjumpAiGnRnzOsPUr
         3OFQVK+yEasjpdRCxrnPRPQghNlNx+QC1teRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788281195; x=1788885995;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gQ+8Eg5A7HAboa6Akxc2ZyEa3pqY0HjMm6hBUa0qhPQ=;
        b=PFQ5U/BkG9ckPjwcNlFKy5z6/Zel3cUc3L+kDgI/IX0bR4thdUPVKy+OePP2jnc2Qs
         VK81tKPXtCc59sY83oO5Vj88c8ftgf7Jl+cZtCtW0izKBNjIzVckxuVT6Q5P7Tfj7wRq
         yUv/2lx6BWdavnXG90PVJMLlSUTm17/ztPxpLGiv/cx0Z5hAzPzHEx3k1HRlhcsibZU2
         66D+0mFGqyUOFC5xyB3Bu5EEcJNa6+rQGUklkifU60cundxE0+MRKMGZ00hUlq/lAGcj
         azMV9QCf27pqGmYXc8mwOw6kVZSgeVi6d28POKp36RejEqS7usIx3mrWyvVpVGjkIiqp
         aHoA==
X-Forwarded-Encrypted: i=1; AHgh+RrytEw+W5uoguLdj1msH2FH9P1fHL0rjUw9QbmUSSiYYQrsMoCr7W2PvTF3TThMFN4+6Uethgk=@vger.kernel.org
X-Gm-Message-State: AFuF++lE3TCcXBhO9o46oLJsK7bo9YwBY0+jy1bM8qvM1tZcKQ+8Hokc
	bewqgMxsVVB9Wm+inFrBfRYMZr7i8AHB7uhokJ3iLphMOyP1hFoMyRJnc57znwugB28=
X-Gm-Gg: AR+sD12lllEvELKuTWj01eYYzP7CXq4qlD3u1wGvmWN27T59lapVZSqoW6r0redXYSL
	FbP8H9MRYtqv6d1lLvbAVwf6OeZ/ZigUJwPDLs5NGy04L1fbMKj1c0kZsOO54mr19E1eKWO7b9V
	IL3gILvMU8FDMtmeVLzvQiLalWWLzHby6jYhoX0pQeDLGIbEUfrQWkB1EX3of17GnqsB7m47OZz
	Te5nQzqBKtg7763/lATmKO8rpp1jt8AQBBklTV1StZegnDZgNbuG8CJ+GeTBotWlQ9/OpaOIrns
	QA1kmNBgtjiBXlUvr+/bmQEr3kZXJqqMXDNwZgKY8fKsVYWS8lpX9FVBWccd4BVcEANdrhDZtxw
	CZc8OBvmdsLJt8n/vkRI/zIz7v6dFOUTbntKKqUjmhT0rHojFNHKA2Q/6sxZeDLJSqt75U0dLTJ
	DP9hlY6YF+YwKkoM6f9bxBoAqriuhMundLwMOzono2mgB+vKAwdFj94C4dzfaqws+RGrSlPXwJa
	9ZEgvxk
X-Received: by 2002:a05:6820:995:b0:6b1:3cb7:f535 with SMTP id 006d021491bc7-6b1c638112fmr34990759eaf.0.1788281194736;
        Tue, 01 Sep 2026 09:46:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46f3046b139sm221497fac.3.2026.09.01.09.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 09:46:34 -0700 (PDT)
Message-ID: <bc7fd0f4-d2ea-4d49-9b5b-ff2e04236878@linuxfoundation.org>
Date: Tue, 1 Sep 2026 10:46:28 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/91] 6.6.156-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260831133359.468089036@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260831133359.468089036@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/26 07:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.156 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Sep 2026 13:32:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.156-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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
