Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB8819F121
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281048; cv=none; b=GJPIODqC6nsNBarmxlHCV0Gtqd/wSSG/0y4nDA047n0lUcROBPw0tpN+/oEuK6saFpvSQoy4ytmRH0ZQ4iUCz5xhMnhJV4bSnomR9xLhy1RTNH0dKvGIfClOhjz5rVJBtsywj49cItzEZof+b6iNxanHUkE/QMXsvVKEOiJp5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281048; c=relaxed/simple;
	bh=lBssdOL4h0dDqyFCQ04Yu5KOZOoreuzJ9iq3r1VKZ/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3elXK38WmrYRPnwG3z6EvPYkmm7SuYptWAytQ9Ht9eAuGx+MWsYZWM41TaEZN1lASjyVAAN6lyhmk2FE2zEGdJOwVuvirwLtOjNTIUUiv+LmaQMvKCgs9mKrtN/3oD4ycT0yQUTNSN7wzXeW1Tnnb+A6sncEFGQUZXOEHvE98c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AhPYUvVY; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AhPYUvVY"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4b21f09ea42so50475b6e.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788281044; x=1788885844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OKR0Q5O9wNc6TWb0BqTKUYLMLU6iV3p1EeGlnxaUPrc=;
        b=AhPYUvVYsqMkZ4HsqFsnVlFVDP/HCwkPc8BSK4/2oKEtDnh+YNeXqg5Gj52M1eC4nD
         6onFp9jt0lTHJRmiA8wbPesGxE2DBYzSjUc+1K04CY6kOKuN9JAdo5teXkYZSlcSFxlH
         LCEHxfmKyGrlK9JSLTCPPGgxL+MXak3kYPvSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788281044; x=1788885844;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OKR0Q5O9wNc6TWb0BqTKUYLMLU6iV3p1EeGlnxaUPrc=;
        b=HqEcips97OidWfpCKvw1VypDV4hq9dPM5HCoV4Vclp5mm0xvExwvwWm/VA/GMbzYSo
         EqcUp0o1kboSIBtK9aiIE6WmQ17ejxV7Oyc3G5LWloqoqWFxyxZmTPTsvvBpQm4zN0RL
         Q6XQ315c8nzJ5l3EgeLR+hbESIcih+FWOeS79gna932Uow8TRZjUzfA9Ay3fScAXPTZw
         uMJuVSo0462/58Lvv/sHJ/igTKV4yXKQCHJ0pWPFvC3bF2eXwiWg2wz6hduyQE3z+AIl
         /6KCDZdgbwVckVWsCqoHUzAFJJHM+HVzEYwRwjKbSpxWdQ4mEmusPjXTPth16w4tMj6B
         0ztw==
X-Forwarded-Encrypted: i=1; AHgh+RrVoICFxD4m5MIiMSF0sk0wUvT+UWYuVu/hu4FbXe2H/5nzA+bbH7tyvWYlFmir9aBcoEATgjM=@vger.kernel.org
X-Gm-Message-State: AFuF++khTA10obxVvetTXdY1axEqX0Zgq5dMoCdKMBXMecqyj/mnCZVg
	UoUc0z/YH6aUkTT606q3pznVGUhnoSFqZX773reA3lrFBKM6dTp29ao+HvciNCv4zeQ=
X-Gm-Gg: AR+sD13KXzBtiN0WC+lh3NY9i66HbUvP5ZtqcH+zYUp0KBEg7rBBEE4xa3AQGhphx5/
	nbprkyQIqDYL5h/qXv0p/noQi8wqUEOtfrz7rWkVqFH1twYlqddp9AIIErKE9n/JhznC6+rWwD/
	0d/oyirykbgoEf8hPmVLWqW7ZZKQZZ8DHHGCyqaTTAEa4rLK//0qm1d7tkWRWBGYvrG1sKhvC1l
	Iv+q/MIgQKg3py1gBDOUKY056M8/10AbbE/hstzzFk7zx9FvbHbwot6+Ql1ADuuGC/p/Q9WjT3j
	F6Vc9I2uQDqpDji/1Va0Xv+XD8N31wN+Gc3/n78PS+nhSj3+GoQEX+nMzCbFineo0LEFyIC07zk
	UlOp9VnISUYT3xtFhce46gl/lOjNuD9UtbLqnddVGYTwYbXdpi1lrKN4L45QvTh0CwFV+Pcfk42
	+CR/IUZ7aDxjiCpgQIMIhzqD4bvv991tAtseusOUOa8j4wOU87wnTEFVRa7Ca5+pzqMqftTA==
X-Received: by 2002:a05:6808:bc9:b0:4b3:7b31:8df7 with SMTP id 5614622812f47-4b39824817bmr35286429b6e.14.1788281044022;
        Tue, 01 Sep 2026 09:44:04 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b3a1995f2fsm11396298b6e.11.2026.09.01.09.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 09:44:03 -0700 (PDT)
Message-ID: <58e592ce-3354-4165-bf7e-93fee744339c@linuxfoundation.org>
Date: Tue, 1 Sep 2026 10:43:56 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 00/71] 7.2.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260831133359.055927882@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260831133359.055927882@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/26 07:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.3 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Sep 2026 13:32:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
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
