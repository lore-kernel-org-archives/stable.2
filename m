Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA95F53C3AD
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919185; cv=none; b=NwLm3PDOqKs0q/LRP88M/vIkYyOvknFbPmp/sQ7+qMqg5kKgsssEjfkgWV7p+8NySaa3E3csTChT/o9Yvq1IPv+PRCTKAiJt8znf0rqBfxG0D4xCesKmTHw0hhWvbThvvXq/PvF7kPKxzP8TQK/LbFUndDdqLWF8LipiCrfRYPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919185; c=relaxed/simple;
	bh=Q0xoJoHTPOGkBU/ykGam9+aTXGu8sCVurjmTpYiGjKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UaGk57yc88e5EKqK4xdINQaZ9h4dDhpqAZ5GiPUWSpnpIWdK4ucHiN+1F84RDObv2nWfDU5plo3rzEGm4w4YzqG/FV1bcQ+P2DIvQwAAUH2nDp3pmoWljI2mRcUvCABZ7zv3jiJN+U6UKYvNkB4E0jL1nu3L+GwjHtGEoYnMX6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLfz6Jim; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLfz6Jim"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93cc1ab5f6cso400530885a.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 12:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791919183; x=1792523983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pfgvs3MJEbW2BwnwAhjd9SKbBYEufXUXojUMotaCz9A=;
        b=aLfz6JimkR0Rtx927ja30vUnHJfI7IGnPW4knsNAOshj4zU4hnyk60MRNOHWTjXXO7
         tqrY7QbSEy4/LcqbQDykFZCnhB6v1PSDOpU+0JFKxhD++c4Y9sbb682qlPSPHQQXYmRf
         d1Pvctgl0vcEcywr17rZRRj6FoX3acFhm551uJW4QbTrQV6qPA1OFYFdGGGXBuLPwGxl
         lBxmKGCZRf+yMuuJQ8tUvBJEulwmxTsW6BsrsiK2Dy0RUvqVeTU0k6gHauupgDp9qa73
         eooOp4KR+BlAyRtYzg9KsIGT7nyYxl3V3afcXxO2fct6eBKumJ6mDlc/1abg8emOB8t3
         9eQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791919183; x=1792523983;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pfgvs3MJEbW2BwnwAhjd9SKbBYEufXUXojUMotaCz9A=;
        b=P7G9h/qnxvTqlKsQBeW5DzFL1iwzSLA9FAlrTOkWmVBBVvs0klkfhkqUtoX1A6r/Y+
         ARPjokUjNpxbBqxBCNktxC/KmKNJrMRoLZOSZjPIPdyIG4qql6r9EKjAgqFRsM8obtzY
         dW9bnbmthYZpHQUc5Z9SeXg04DqKSdTOYAff6MTjDERvc9bIyif9rPnw+JMHRed7Axl+
         LjegCYQAdMB3Yl+KPVG8CZQEdtEeSWY3bAdNeGt3obm55bMODYNUzGSQ3kSeGS3xMxek
         vUwS9F0QMK7zJdzV4e95+msUOK8I2C+pdL7l50H3JPUiAvBedHQtGhJBJL00tLBbp3ZT
         5HGA==
X-Forwarded-Encrypted: i=1; AKwUvBzEkUAhIBSwcs2/+74hZLKsKETQSMhFCk9MF8cY3w6X6keYrEISLn+ovtFKgXWbivKFpMOmpoY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIm4BFRohzLIwLApH6qCH4k5UlViHJ41id0RMBS3+iTgIaDk6Cy
	ug41j8QOwcokCdBAql/qmJoZ+9Q2ViuTyqRcUBIke7nkpsPVJB7+XqXA
X-Gm-Gg: AYBFou0TTEGiCxNnnCWn9YIXikGO/skw0W5M+nveVZ9aHaK+6Urcb51XJuNM5Odlh6i
	5NQuoCNPJmoJkG/JwHwo2QtoQetyHv9hcxwuQ81IvBeHZuVoF6qBh0ICtBYIKViJ8vdbGkC0tL1
	zG/cvavH78SaxOAbdvz5j4FLmw8HEO40Iboha34dAC6dmj7RM2JDq4nKhmDG66gY3+BlEovrpa7
	bxnMUzvtRxBdvJ17Yulj88heAD23rUrWybP676kW7UbLTi8SojxYBYApkda/pgYgWyX7iintATb
	NfBXFNbcTDyg8kxEHCZ9m/VPYVjGwJVWzpkNEtwV1fbFFpumtOpJCNEnjKYpYsmYOiHUy5rAouv
	vVaHMPlqIk8gRCWDIcLI1VjxO2aK8cn301aE24kT/lWr+TwPQua8OSlAry5dBwbfLIQl/v4zkN6
	OssZ6PGwDwXlJtrj09wDSgScj1YJatdyzruumjdN/J2SehAQHAiMsgE1qpR/pE5I6UtoSNSMH/K
	cu4IXEEiq2MjJtNQllkrnEY
X-Received: by 2002:a05:620a:6606:b0:93e:bcbf:4ad with SMTP id af79cd13be357-93ebd24d7acmr2270223785a.33.1791919183457;
        Tue, 13 Oct 2026 12:19:43 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5009b87sm305039785a.11.2026.10.13.12.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 12:19:42 -0700 (PDT)
Message-ID: <0b797c37-afae-479b-b84e-68bcd8369f4d@gmail.com>
Date: Tue, 13 Oct 2026 12:19:38 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/621] 6.18.57-rc1 review
To: Pavel Machek <pavel@nabladev.com>,
 Brett A C Sheffield <bacs@librecast.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261013112920.855194808@linuxfoundation.org>
 <as4kGIjqjrKzu0O0@auntie.librecast.net> <as4ubep0jWRi-b2G@duo.ucw.cz>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <as4ubep0jWRi-b2G@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/26 06:13, Pavel Machek wrote:
> On Tue 2026-10-13 12:29:12, Brett A C Sheffield wrote:
>> On 2026-10-13 13:29, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 6.18.57 release.
>>> There are 621 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Thu, 15 Oct 2026 11:28:22 +0000.
>>> Anything received after that time might be too late.
>>
>> Build failing on amd64:
>>
>> /usr/x86_64-pc-linux-gnu/binutils-bin/2.47/ld: vmlinux.o: in function `gss_krb5_get_mic_v2':
>> (.text+0xfc2762): undefined reference to `crypto_krb5_get_mic'
>> /usr/x86_64-pc-linux-gnu/binutils-bin/2.47/ld: vmlinux.o: in function `gss_krb5_verify_mic_v2':
>> (.text+0xfc293a): undefined reference to `crypto_krb5_verify_mic'
>> /usr/x86_64-pc-linux-gnu/binutils-bin/2.47/ld: vmlinux.o: in function `gss_krb5_aead_encrypt':
>> (.text+0xfc47a1): undefined reference to `crypto_krb5_encrypt'
>> /usr/x86_64-pc-linux-gnu/binutils-bin/2.47/ld: vmlinux.o: in function `gss_krb5_aead_decrypt':
>> (.text+0xfc48f8): undefined reference to `crypto_krb5_decrypt'
>> make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
>> make[1]: *** [/usr/src/linux-stable-rc/Makefile:1272: vmlinux] Error 2
>> make: *** [Makefile:248: __sub-make] Error 2
>>
> 
> We see same problem here:
> 
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/17139116508

And here as well.
-- 
Florian
