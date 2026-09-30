Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7681E51DDFB
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804602; cv=none; b=qcbb/9XpBumQ+6Agu57/Y10imE/A1PI03VjhC54nFDFz3jhviV0sqcTAzPnKDJeSkbU/QRcMHOwWZmvOBbrnRvwNRdkF7q9bfGO99jU+w7wedwr0S4gsc5tWvJR/v8QIXc87C1C3TKZQBOyN9Fogvchw/cABD81SNabnwU9UnVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804602; c=relaxed/simple;
	bh=bBR8nRQ8XAmNXA0T6elTngU/deKR9ybB3YQ04hMzTJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8hCC0J83MeGm50NQz3YJcC7qomL02NrEr+nZHOQoBqcDrpKeXHTStFyj6JHb+6dNqHmA5fOrffov5+82VzrE7iQnKn6zdC162xu59zRgWhUySQaHi04b3yBAyRWyVcSlowsffp7xyP9uNlITYFT8vJ+ZIribj5sYosm/QfP1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faaUXHNR; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faaUXHNR"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c0d931083so2220169eec.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790804600; x=1791409400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8lkawhUgZ2z6Rbax51KT4StG2qQ9CPt6IcVwt464ZjQ=;
        b=faaUXHNR4L8nRJ8vO/PYkNKPq3hSFqNds09T+IV8AWwxGnvjPxRB86HwDtkvVFPw+t
         G24ffAKJxiI31zp9T3WnqZMPbx76R9PMm0VGbK3Njt8qXaM8naWrgd+Gr1CIQP3E9JEf
         nN3JLJ+JBtUgtvqf5Wl1pIQkL5GC4q5wA5kj3wJSp35tuPtOqbYtdB7Iok5/fNfCodUv
         f7AjpRPnKL1lXWArkdfOwqI1i2w//f5BZp56Q+eIw47zcgFoeQYr3DI2wzI3NW7UK8ir
         mPUWF6ZexkkrBWuV1fDSsDqGcttQGF63mltpCKZNIbDTPUbowbuFCxFVjORL5EnuLNEi
         5a3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790804600; x=1791409400;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8lkawhUgZ2z6Rbax51KT4StG2qQ9CPt6IcVwt464ZjQ=;
        b=yQE9eDsRycihhbFNlJz1Ln3Qb0KAIwK0AcRT1Habg00ZSS96Wuy1hFHsBnDbrQUQhr
         gKf3jX2BjSt1ctc32EUamLtVx/W1Wn4aHVTzq2/TRr8xd1QfiT/e3qMQXg8SJmuhIrEi
         GxNFLRYfMxGYEZg6Y4hlEG4e9VbOEv2ZjGh3+5J8Y0NldyRs5xltLed2rr9RWRI80SwE
         YuimdmJmT08sVj+Lfdj2Wfdmqtfvl8jCn3ODDg9186I5wXV4pkyLttOOG1OkSEJdLZ4O
         ypxg503HsxuQFdz3X/Y3uohxBY1K5yZukJP9owHPPNfRiwgCYZetEAgGi1EnJN57UA+U
         kOUA==
X-Forwarded-Encrypted: i=1; AKwUvBxiHBmyG1fubr++1fkjF5hGwAYjz0bzjGYf0nI5A8DQ1kQSud9XP2Csef4cfUDT04VPru/0cdU=@vger.kernel.org
X-Gm-Message-State: AFuF++kJg810x4sM2gkbhDNFPGSDrWWe7AFmP6n7H3seH1P74rziP//0
	oJm6hHp4RjhQ6IMY8c8d373IAE/dVrEGGSywFoaWL2QzD99rstM7/nGCWm1A0w==
X-Gm-Gg: AYBFou1/ZQ2yaIYPHgJ1kNvz3+YXniZgFnwAoEzsBXymukCN/zfhpA0QJ4bC9aXSOIV
	VA+4ge4z/rTZT9MhqIQdOJibjaegYFE0+KQmwnWRJyHhuyS+9lBraAxhe8SH1OdOBF6J7KAcwI4
	IPzQn9L7nWH2qdFerxO/x+m2nlxJX4tg9XgXIex/u+Vh5kYTo+J5Hg7jbkC+JBkBDnwEn/pfu+F
	UqRQFWlfCtS9Q3T7iI3KlyZMUbnQAvDgU4npwJa/Dy+qPMGgcTtpoyWLLOs4t9oN23mf0AXpjZB
	2v6vrECPeuWa9KnVnzurwH4DYfxGCuBpV+2RDYCn3iGUDJjcuzDWwb4VZh+7nI1fzN0Qwuj7Jsm
	wpAc0GItclw7rebXcE/3p7nfX1gJNqorHj6LJd62AIkcVDpA4zKAdW5VdRv2WxEfb5LF+QfTJtt
	uhfb81kv3cf1xIxHJpj8vZtPPDiGUl5fKuv059tiClKD5pZxaQ/s8yPLMhgnR4jM3tFURWfVsvk
	mQdx5HT8QvbWss1IsAvgSaLfce/CoyTHDh59j0=
X-Received: by 2002:a05:701b:2914:b0:147:9ad0:cf15 with SMTP id a92af1059eb24-14dcf494d00mr686116c88.22.1790804600394;
        Wed, 30 Sep 2026 14:43:20 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14df48c45cdsm762620c88.16.2026.09.30.14.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 14:43:19 -0700 (PDT)
Message-ID: <d7429656-810d-4146-aaf4-4c6997c4f030@gmail.com>
Date: Wed, 30 Sep 2026 14:43:18 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 0000/1193] 6.6.158-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260930152434.301151190@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260930152434.301151190@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/30/2026 8:11 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.158 release.
> There are 1193 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 02 Oct 2026 15:23:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.158-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

