Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8F13BCD33
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402821; cv=none; b=h6DFcstox0P+OxrYEkV6PR9xNm1JfO/fFEDHuPHKs+gCe3BY0RDuVTYvf6vswDbfCGxeVRVVfKLhw9pEG57zO/i3U6eKh8TmsDFmBYk2HUlu4UBAwGqsPvj6le/ybvnQzdkZhO815NACeyBFyBbLG4BM3W090CCafBstCD8JZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402821; c=relaxed/simple;
	bh=AIffyatO2PMrnjuXzFz/fouBCJubWOhn2zUYeUzYE30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYzRZr/BYnQzDSMRM8Hxo4iURRj2g8DYoGIqz6SWOlVRVHNSET5EbcFu8iCCCqyiUet8/rPSzCSZ9lv4gwfqLXxDVwkitRFH+djgnpfUL7W7/Hiwlr03Bfkve0ECjlJV2ysIP/Yl6petGfMG4PGRmDqaZFW/iDl8gCFe5E9cPCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGCqC7vI; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGCqC7vI"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c2a449c57so1704611cf.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 16:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786402817; x=1787007617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=blLJ9/tIXxSZMI1TcmSIhA1UYbC8d5RJ38svlmIf2cc=;
        b=CGCqC7vIV2FBIawNSFT8iyLiYw3eLlevbhqPRlbnJQeB2mAkkFkX7qzzlJraA2D3eg
         OTABtagvVblhR+hB31HayaxouawWB3+ECLtFPIAmWrrTaEJLYFDZ9sPTl9o/Hs8Dhti7
         /1mHMeptrP1bA9BxaC8iiAHom+5FLxPBe+4iYiPKxRe+MryWz2pbcjw2EhIh0zKIN36P
         vBbGJseJBSEgWpXfdOkTACNXh94dbx72IzGai55gpQj6/Ytp1mcNog9hEe3GF4Ebsq29
         eMjTZksGlQ6oYdYbu/5ydJmBrqzDQ5I+QyFojr55KyHc/POH3BO4EH5e0LIkWhJU9SaM
         NHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402817; x=1787007617;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=blLJ9/tIXxSZMI1TcmSIhA1UYbC8d5RJ38svlmIf2cc=;
        b=q+T5vR1pmNf2/QdSsUpZtVx0PL8tJoeaEEkVU3aZ9/ud0t8FWoO+WwICBiVcVoRpTB
         4pwkRyVIxoLus+uv1kVFNnYrRPMT1l6GpEG7/qHU4fVnU+OutBwDrJrrB6HvUYxikIjL
         nB+O2MOwLF+A9LvED/lv8L+klU4QXw+v4b8EorJ6SS698tvdXeBbbzKSY4kKmQLH2w5N
         uy9ZH+FayXO758jG/xoxrOnul6y/NjfJkQsmdoYvD3Ami9bQvFLOEP4fAJkIZU+UWZVE
         DgPl4FNC1y7cVEOKmcn3vrGTCv0lyPo211munzXhx7sm8z1ai5+RMB6Gq0JoK9aICAdf
         KVLQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0aqbTgjGbsPIxLC6mOX+zaIa3LaZDgwhKr8e3yjjSrlYC2JajH38E9C+d8xHrKvs4twgf0yY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/172kzOJ/eUaYmpSFguAcmYpTF+EoYRXnwilih48pq3piutFK
	PhVinqbeYuoUadU+hjFidxaauucVhf7FSR0CvOFrZ44KvJ2NicZ3cHNg
X-Gm-Gg: AR+sD10TA2rHcCb3UfsAagfFY5qwGgaiAqz9Fwg6keFFk6l2gQk/GUPn/jGHpFm0+n2
	mYRuw6/0JU7MoOurBFvv2UtHQNjR4K3Rv8nk80Latt4wcCA/iuLQcG8dd3Pq4Rwo15Rbr4deB2M
	s7+ZjaGpyxrWvfeUg+QWe3ciJEHUQ208ejG0l4rQ1JiGklYo1aic8RVhiwQv+xPmNfuMVkAglil
	Bi1WE+CXdeLtEZrpPVXd0I2zrw15f/36blPhY9e4d3174up3m3qiaQtVeIb5RG80bg4Tq4vsETr
	cZ1QsC2uEueyT3KScQSBhPXYi8YIDbwnd3TzwYJg/jyyVaH9z82jz0qzXQu0VHyhoH8PpDQU7k3
	Hfip849P5GF4dZFR2QAK3sYTxaLFO0OYWBdUq9v2u0E8+Yu4sR0ic6XuyO7DWSFsjbP8ilM91qw
	AV6n5avHwQOswE8V+uO8BCGSNJRXUgFBVcwZqeyuWCmQIS83tw+I93VxhlJA7G2+bci8iZjaKd5
	IkgEjiF1pLd8bc=
X-Received: by 2002:a05:622a:593:b0:51c:21d1:3852 with SMTP id d75a77b69052e-52ce5f63740mr483994001cf.5.1786402817492;
        Mon, 10 Aug 2026 16:00:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e22695bsm889897985a.25.2026.08.10.16.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 16:00:16 -0700 (PDT)
Message-ID: <90831f40-dc9a-4255-a611-7f59e5685f94@gmail.com>
Date: Mon, 10 Aug 2026 16:00:11 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/438] 7.1.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260807143428.008222056@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260807143428.008222056@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/26 07:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.8 release.
> There are 438 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 09 Aug 2026 14:33:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
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
