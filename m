Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88C463B98
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054253; cv=none; b=XbLLWbDdJWqMQ3kVw+1OFtu/Z6zDustbsugWhyv9Ja1MKLIbGdUMbdq9DM+4wZi61L6VkONkLKKdr7gJ81kuRelkTVjo4wuOmkiE+bOB0M+gkiBqsh2qpvClC95/kE4mcBdZ+mlvMUiK4YagNLhIOzGQVYSdgQ4QGwkrl4VuO4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054253; c=relaxed/simple;
	bh=9ptTQiBje5Y6Ly+9PCotPYO3IXdqeFHugUToRNIuPlE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KpPUB+M1126sv9a66RoqIEH/37kZ5V3BGngfab7t1kP1Ap99/l6JSwI9f2HjAHmBTNA6+pnC1Nn9sFALF8oiRUewbKMkgY/8Z5f7B99Ga+OJFslxAQa55IgT+So4iTfZWJiymG03a/jewu2Ko66PsN2jtuE8YZdB7z1LxGbVofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tLvbvb5D; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLvbvb5D"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c928bf172so28143481cf.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 04:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787054249; x=1787659049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CGnWARA0pJpVSqn4L0M3VW7HCuNuG1CRz9WCa3eaIvs=;
        b=tLvbvb5DEcfDKgL1WxK7VzHCLzDhMqwBdqyTVcNqap+lhxMVNefemfzMInX0r3cxMq
         wRoz1270DtwNULi74Qb9iQtFRJyhdbNnLHXfWgIYgRF6loOK+B6jdBT0KsyBECApKSZX
         V84Uv97xckTxxk39jfuQuydFG24M2vHYy73hldBuS8lHxOLpzdImbGhQ40LJXivNX2Zm
         MR3bsh3IBzrlfVXLwNG8e/1m2yXq336UhSJAxL5A0S1sKZhUEogmr9A3yFewDrnZLrgF
         ydyTnzt39+pnEtOmocNqwpWCOXh48ZabH5ajOLP8gncKCBaWhanHJFqUYr3VKTjgtsl+
         Cd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787054249; x=1787659049;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CGnWARA0pJpVSqn4L0M3VW7HCuNuG1CRz9WCa3eaIvs=;
        b=bRAe89Uh0ENu4XzujlHjPdnXpuHGrgZ60YSXjYHOGIGjKIcV2lgaWBkTiq5IRtpZNF
         tnLhJpfxBXIAt9sXX4qIXvIMF0hCs3yH0DXM7bJ+66V8ciFcXDHABDvEriIhTa1+DPXC
         MmxG1WJIvFoDEj4bZflmZhM73dVVLppzFrTwiq9S5rFSklOBc7O5e941qihTJSam7CTh
         xc3huv5yIso0ZR/sQbhM5I+quvcLwLAEh2IHZVxSv31aBDdaoCZTSkATgGSKFDVLTYw6
         iYdAEjGFOee/n4Pu1pIC4Y8UoJ+emcrirHXxxJaE+bC6u906d5HdV7hhWuhh7IOnr8tz
         nGcg==
X-Forwarded-Encrypted: i=1; AHgh+Rpl8+cXnVxumNdgkZ1U/XLIqxiyM/uxQTmib7bM+3n1OPqaOBqzMtUQpHEeRh1XbqFuuWOdjU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC3SLiZlGAxiWLThLCn5AWgwTvyDFJKDopFHRWLIXhzALDBcCy
	KmIUHq2Nf/yO9mWrX5vIL64T21HlMGGVloRMThdH9QgIkvGHX2M29ac=
X-Gm-Gg: AR+sD10f+f2uZpbKarxYDpJai8M2UbM/T57Mzo0TTPK010mHkkodyan1HBzV8LREcFq
	Sof5p+XmI7IMiB3Q90s6jWHkoUMVfrYVaCXRrLxZy6mLNhiPJjhvIiZ7kXGoXf18w/Ama0oABWP
	rj5hizlStJRF4l6L5i55W7GzDEkynGtW9DrWI/zSnOT8sXaE1TaKdsZtVnmK+v68xpLV2GGHQYY
	H/s5ExX9TrHrdlsDEsD+vQ5DRhqoSHh0C7xuksOPa8+z2Hcw9/xvp9ZPd2uR9IpFnw1D794ueXV
	/ULe3BnmR0GOlZlO4MBUgsLHaW500/iw17MBHYu9gMdaMssNOqydI4WYwz4hw0xUbGSQ/YBtEPr
	A/c0t2C31eoVKMmfE6brr1aSXMIkC4McMnpGupaWJgGqRPeY7LNpudMBlGI1a0m+98qW5iVBAoW
	Q6uLFx9kp6Mknx37bQJBu9LUSoSl2r/3UWdul7u9ymWmhe1kJH9IfMpLumONtskIfR+IwqgYZKJ
	ShfXafgcbJzHQUe
X-Received: by 2002:a05:622a:191a:b0:51c:c6c:9d65 with SMTP id d75a77b69052e-52dbd62307fmr79108321cf.1.1787054249506;
        Tue, 18 Aug 2026 04:57:29 -0700 (PDT)
Received: from [120.7.1.23] (135-23-94-154.cpe.pppoe.ca. [135.23.94.154])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52db610b491sm37147661cf.8.2026.08.18.04.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 04:57:27 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/389] 5.10.265-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260817132538.796021292@linuxfoundation.org>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <253278cf-f171-81f7-2a34-75d081ddf352@gmail.com>
Date: Tue, 18 Aug 2026 07:57:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101
 Firefox/140.0 SeaMonkey/2.53.24
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260817132538.796021292@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.265 release.
> There are 389 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
>
Built OK on i386, rested boot, no new issues noticed on 23-bit EeePC

Tested-by: Woody Suwalski <terraluna977@gmail.com>

