Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B2421D596
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781640859; cv=none; b=Zxs1p4rvLna8Tzmxwym0lWnHvi66EG2i63ghyXqT7iwc58hzvRFULQ3fNzLsYVvH5sl/JeoqXiqYit55T8jkMtP1QRLoEMT6pkmkR1W9rCvqk8aMy8p+Aka9HmQjhN6Qpu0RBFTDtWsR7lXrumr2/bkN5ymqMmdeD0b18VgBlZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781640859; c=relaxed/simple;
	bh=Z4buY0yxNSj5ughbZXoco5xIDW6nysocSW3jyixQZKE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nmD6MfojKZNocz+0+AadsxjlgfyFlJyLG6cGmmXYtGgKZFOoQ/W/P51jdqtV9h6lr99wswTsoiXm0g9vXhgUPRKbJJllwS31QGs6XT2lUIRdo95C5S/AOF4ewbMJLfboWvW7cgrIRmV+qLFz1ffL36zLRBYxmMs5wjMpko6Sk0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/VpyMbB; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/VpyMbB"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51776b4de37so43473371cf.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 13:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781640857; x=1782245657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GB1HLk2MsE4YXVeU3KtucQOegECld/8EB1fgDTQNKH8=;
        b=s/VpyMbBO71TcL+4iIjw9lOyAkhtJZ/7S41z2n5qM0HK44L5NBkOrOaLqex3CDIl6C
         Cnkedpx3kSbW2oP5VDLHkq8VmCyQZG0UhtVOEGnc9a6raOk7DqBP00Da0jpPdO+o5o3x
         oUt8rhWbpM8g3sSUtkJEeS4rdsZ1bk9TeTVAom84QCfTpq3ofPEJnTDoNiLe81yjex9e
         NRD5FKbh9XYXh2L0/KIXOkWarJEIq8PCpjdHM7EKfPRRd0EdcIh5oqAosv5H5oaubi57
         34zLFlwkglfEBm3hegLDQfm+F8TUV3XPpClcnnNmoIfBiUWFUHz7tS3v5WE80Lfu3bTb
         piqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781640857; x=1782245657;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GB1HLk2MsE4YXVeU3KtucQOegECld/8EB1fgDTQNKH8=;
        b=p24byEOIyeFVXMbtSNY8vvsb6b8ksDoUF39xoKkx3knD4hVudkthFAQZTjOK5XAgCh
         Bbo5/8dQLXNgD1j/vrdFEta6Bk11mixOyoalT06K25KbWzsFZDF2ttXCVNZ/2K801Txh
         P4e+01eMHZIBxpKtFmQww2lKLf8oUWGH90B+6P0lArqR3tr6Bu+iN7xWt8QXxokrHneO
         msNKeTfZFZhEtDNGRUyw4ePY4kg2WcZSiRnuOywvYnr8F67P8InVkrmOaOAEME4Ni0PI
         CF5L+J0IzDsoru0pPFJpk1KRakVpsbiFYGPgvqn8WHk8rI3OOdpV9sa/I4tV/sgB7j+v
         eiaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/yOpLBr6nfsTZdqmhcZLclhi7A9zdQNaUvBC+diqYwGnwD+a5RbF+gsIC5eabAdNMV2BVKLWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Ap5Q0P1H2+UGJf3W+pqvp+RW2dK80/THe90zUVL0bewATDX8
	wqCeBgf2RhJw/kFVOFEiJ/AI5TV5GWhaiDoghONUiI5yPhUpvyc65Us=
X-Gm-Gg: Acq92OEwZTzpOfWudPiimJyTLXoOcA9cMYd08I0KS2uz4cPNsCGd0QVWHQwDn/aOvnb
	WzlBjbI+yi8R0lzygst4msTJVRq6UzE+DPzkVk2rQDsJ8yld4Ayi0v59VitbOj5+zJavCi5L+q7
	ODwoIo+NCcc046T6ixvweuCSYtF8NF3X+jZMd/CVduGxeoogc5BNrufWC4vNAQMFfFIVC47dELC
	wHmWB5/veCgA4lrIny55SDENhZqSwaotAAtWIApm6YdXx0p74gH3G+7PBBxQIUoxc+RyOByUAsB
	VQRGqP8EvtiubcaMq0qvGSB6YEQ/hqAORaB21cW8XkUbE3gsMrKPZC6lY8j2R2NUe25HxODGnNf
	7hPHTJuMV2Cu/6iOhG0+pGJ3cD8pQfYJh1hZYMR/cN1YP1301TSk0/XJaBlgGYXA7ZNGxqmtyNi
	6PyLUjN8fLMXYuzhCMx55Keyn0lYHk+ug61V+/H8He2ASN7ka3eBM=
X-Received: by 2002:ac8:5fcf:0:b0:517:89d0:b8a9 with SMTP id d75a77b69052e-519a8ca24d1mr16762201cf.9.1781640857211;
        Tue, 16 Jun 2026 13:14:17 -0700 (PDT)
Received: from [120.7.1.23] (135-23-94-154.cpe.pppoe.ca. [135.23.94.154])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7dacdfsm156361931cf.20.2026.06.16.13.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 13:14:16 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/342] 5.10.259-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260616145048.348037099@linuxfoundation.org>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <88a6a3f4-7e7f-2818-1eb5-145838b9a957@gmail.com>
Date: Tue, 16 Jun 2026 16:14:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.259 release.
> There are 342 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Jun 2026 14:49:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.259-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
Built for i386 and booted OK on a 32 bit laptop.

Tested-by: Woody Suwalski <terraluna977@gmail.com>

