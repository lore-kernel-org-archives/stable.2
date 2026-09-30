Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30583D9DBF
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795312; cv=none; b=X1II+viXOg6T0eW2evUtLci2dtb/smIkP1TJMD0Cqfcpq1kGrm5WCjxczggXdNJi5b/xhh/qqmJwKpH2t/1HNmMBn7divDP4oTzBVOKqz4FZ5dQDH9S+Pp8L7RiuU439ag/zxS0J+FU1t01TBQvgx/SpIaRqW+SBZA/WzrBeVT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795312; c=relaxed/simple;
	bh=vqOV2uF0Ci7vXHGhVG0nXnSb9mu5dZuiChUCnPPFeKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4AHJXPpP79I6TdbIZvyLfHNrHhjkG+7fEUm5i28FgxXpTjildDabKQdBm2vqOPnEMti6+Tk9pliN607AgeRAmfkPnZy/qXPyzdqk4PWF2vsdkuswcKSttaMoFcHh25+293G0Ok8RApkcPMUEIFBur2c9EaE0v1xQa5AlSeTYgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aj49PHtq; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aj49PHtq"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-144f79153f5so27175c88.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790795309; x=1791400109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d+JAldsdHwPu3ZufnjHdhfOy8fAoKYsgi/utsa5zT7w=;
        b=Aj49PHtqiWX3cSC51EUQelc6hrWLHGBYxA+5Z+aXsyLFn9JdaTpxQnUrO5PUvAAYTb
         PIX/MrKSzQSeeLOKC5fT7lM2HKWGDoz62VkESNNZhLCVAScdmG7DrVIyIngClS5nYekX
         Rz+CO+uq4Qrh4cREmRaFPc+QmPd/yU/zap6gjZEKvRN5zNM0XmsSd5p/j9z/FmskClJC
         S3ZALSBvNEGmkhjrtFtOO6ntznuIf2mMQ3aRqp7PBqGjHguoqbOUhxlxbvL7m3jHX5vi
         oAjmJYhCbs0GF3G2lItBTaruHno6AwgtGmLdhdOJryPomEediJvbQkieXiIP+kkWBh6X
         2unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790795309; x=1791400109;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d+JAldsdHwPu3ZufnjHdhfOy8fAoKYsgi/utsa5zT7w=;
        b=b2pP+nZzI0GGWdJq5iG0XmR3N8UXj9bpYRewkU4ObsWzT4DWgnwlC0qjpTwItSmGjE
         +JQneV+D334i4sHYVsMqmvKV29JW77swAdEUsDL8bqAsYSdXhpJPGpoQqVVN0idnVT90
         buFI0pltCEf216dytLsAAaYmwCbpS4GGs91W1011Sxbfl83jh6lu0PpvCaikUy9frDkS
         fBOR07seq7dNi9G64H0n8Q7nm4TBaU7HO1dtWeCk6tsP45XOrzsnACyQWRlvHaK37z+r
         F7V8bsB3bjRPhsXkhz3hx05Hu2rt99JEYbsM/bVvvhShOSyO4kpwcmzRMNYeO+qMeYK5
         gIbg==
X-Forwarded-Encrypted: i=1; AKwUvBwJ0SpIigSowGz4SfMH4V9v+iNipO3ERz7iPyEQpj1P/s5CbumvoL1jsWl9PGpKH80KmgnsmjI=@vger.kernel.org
X-Gm-Message-State: AFuF++keROqjBdg98Nx5Mpme76fnQOwgKdmQN2Q9925Z/LBnYc9HNrHk
	A1sAwC0TyYltsN5kgxA9HVg1pIibBwI1rAIznBbyE0d29Q7EM5t9j+Qb
X-Gm-Gg: AYBFou1QX+fE52HdQ3oj5JxC8Da615Pl5/7O6N5A3OJPmRu/p2nD9BnZGnyP9Q90d4h
	ap6mZdHQpilZdcpVa34GYuttxY0pJttbcahRj0SSvPX2WQIg2jhbHwQllz0pbJXFNZpLhYdvz0F
	d++e9toazaAh9mQsRWprROOQOznoNzjt+FejxdcMfjRwQk4nvaIDsKCjh7nzGvPpOhv02Mz267w
	qaaJLrmWrPkWtPvXPXX5nO/ESh1qLXfb50kG7+ipARSemKmFJUtLBOjDsHxuygjPEbyN0vugF7x
	F2thWOJBbcNrWQGR8ZL+oCqhupkhtAfxzLMP83RDRGLTS1hZa3/b29G/YdkevwGCEpwBkpr8I34
	K/CKKcflyT5Tgw6q5X3lvRnYgB69sVZ/YCcg1WgbW6OrzRXGor6n6mw8SwfiswRvqinUQUEZMNS
	PI//sFjzIMdjWmZxJJ07+BoY7nPR+tcRkSKL0CmlJl5hEPPj7duikEOycQ17W5voSYmVXPYd23Z
	r/PL9SjXUcaSFRG0lALDmyFxQMok5fduC61EoI=
X-Received: by 2002:a05:7022:1588:b0:143:1bb1:32ff with SMTP id a92af1059eb24-14dd129c6bfmr508585c88.16.1790795309223;
        Wed, 30 Sep 2026 12:08:29 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14df359f15asm285867c88.4.2026.09.30.12.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 12:08:28 -0700 (PDT)
Message-ID: <a9cb7dee-2c63-46e1-ac1f-ad996b4eff6c@gmail.com>
Date: Wed, 30 Sep 2026 12:08:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/877] 6.12.112-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260930152414.738996857@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260930152414.738996857@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/30/2026 8:15 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.112 release.
> There are 877 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 02 Oct 2026 15:23:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.112-rc1.gz
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

