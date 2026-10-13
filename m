Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D145372DB
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 23:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933090; cv=none; b=QJB/DzDLPai1FevAHfH6wP17OtBaIBMgmtcM91UiZUsSZZIMuNei1YWiXUyyNIj6DO5HPT5+0hCDOu19DabucDjCtjm7KoTxOElUArDsG+umP64P+6zfw8IHWvH5frBZQRY/y3G/SwElRSaT7DBIPCwc1Uo5Azdk/rcF0COKD4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933090; c=relaxed/simple;
	bh=5IBhaLUp5MdLPNUcVu4QR7/5QsLhjzo7lK/mXulxCHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uu8luOpepG9I7LIFd2Di5gjq3Posof7+MqgsLv2AsudqWVuuYilJtiICjLfi1noTDRYeE1oVMrNx36dzOyPPLx7KfEAd9Na7VZOUZPJK5ATT92QvymenaMicBID0gd3aSBiLU4HwhsAvDM3PWdi4PWH/fEGxGt8nEkna5UuLX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cd60tQ+d; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cd60tQ+d"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-8198a3a54d7so5668236a34.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1791933087; x=1792537887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b/a5/AdXnTf6cDcdZphHu5UXWH0M+sRSxBHGhoRv5/E=;
        b=Cd60tQ+dNNPULA1mMHJSfnHi9O48jP+52GArxc38nhUyI7hJHlEa6j44+hQF2MXadU
         98DkdEq57cVskwmn4R7/oK7Kq16huWRvRZr80IX8ITnjvAzfR+prRyC3xR0cYn9kkI3N
         hwiz8+moPHwXK85LvvqodDUKKDPVo3dEDc6Y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791933087; x=1792537887;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b/a5/AdXnTf6cDcdZphHu5UXWH0M+sRSxBHGhoRv5/E=;
        b=HSNZH1EUmh6z+IpuqHGj4UEpTiN6onrnQmYezrNNzsGZqIGRGIxr9IKsBXWzjweCLi
         nldlpUDV4Q90+qwCBSfHfpwBGjL87dasi+zNe7FRDOIerrXUt8HwD6fZgGBHTTc1ld8E
         SUZ61SlBO+RdzX23a2tkxSpwKh0f+u6BJXkdRmieZkTbC2FOy8vU5Bzc4vdoiTDqo1Rn
         /bdgh8oipGbnCjrgLC1rxpAwIiu1eok3XfcvpOcY7mjwB3UblyxICnUqYLs1NxNI+CGk
         T61dQTgX+xuOkEw/azmAChWFWQIxRNSwnADaviMLYQvdg1qslJxslexnvaqhHxQMFeZ/
         m3/g==
X-Forwarded-Encrypted: i=1; AKwUvBzVcsR0wabqs/65S3IlBCM/CsnDdFPHRJ3wBFo1HBQXpBXSmkm3I7bbwwdNkzaB/gJhVU6F9h4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXXFPY90Fbxm0r3f6+IvwIwEWDqnN67DMlINg3x18/FwDYTZEB
	QiRY0ej3FevbfM/OrD24khQnOdwpZfJgyvP9cM5+aO7vYMbh8vltwJgjd1sFh3l84bA=
X-Gm-Gg: AYBFou1z3Yy5D8aByCYMxIwifpOsUu/jitfFhUSrpd2NBmYt9Dwgx6BsFmEiyLX3uSY
	Z1saVJUn1NH8tg7mK7rSNSWfX01cfgKQy2gJlVPoMjhQjBszj0xqTq4T4DXWE8pTCpjpqFFXmEC
	yJ4vxaJqhCo7EQ8thhDOJz6HECmD4cFZQqFZj5YqipYnV6JOulwfgXMdGtuOhMlH7XFiB8gbm7X
	3FMpE59U1AFcUox8BA2NL/Ozslcvy2lGM6ny+FcvkJzsTuYYzcIltvZEiow8j91zGgdW944u+Sz
	e6900NvbSZ6a4NfPoYkzFNaiXtlqH0A44JEonodiVJAvLig1/8CxfaQkPjyTpQNsL1j0TN9zv69
	5GdqGM3zCPZIObQ1NbxfsqO/ZcQz6xwr2jRZKFlYgVoURm0XJXDp3XcmqBiqpysw/Hwn/1L3IhH
	RqJpTuZrgYVujiIO96laifHiAq0d1yBgGufsjMvWq6KVgH/Tb8n9VN51hBVMlfhUkfqt1nLF5cS
	Ql2R4w=
X-Received: by 2002:a05:6808:250a:b0:4b8:4703:db91 with SMTP id 5614622812f47-50b621adba4mr10283311b6e.26.1791933087183;
        Tue, 13 Oct 2026 16:11:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfc44a5csm860681fac.12.2026.10.13.16.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 16:11:26 -0700 (PDT)
Message-ID: <6f18fa43-9fda-4787-9e2f-63eec412ad9a@linuxfoundation.org>
Date: Tue, 13 Oct 2026 17:11:21 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/621] 6.18.57-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261013112920.855194808@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261013112920.855194808@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/26 05:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.57 release.
> There are 621 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Oct 2026 11:28:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.57-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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
