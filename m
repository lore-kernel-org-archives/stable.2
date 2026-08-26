Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D1E10F2
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 00:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787702634; cv=none; b=oTvDwUgmAucts5W2fpK5OvWMtq/u5pDN4Fysbx3M3XvgIEu6HbHvV0FK3MoGeetMeRLYzikVq5YrCG+g4YaaA0kNv1AG4QW8wlP8jwOA50O2CAz/mB03pR+ZIJEI3wpANJwEDtXdcI1eCKQFsBIXSP8dSwaBJO73qRcyChc+gKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787702634; c=relaxed/simple;
	bh=w2/uO/cTeYECpLmwJDgqE1Jw2x+04yzF1cTArErEmb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILWt+erRzExTitvwKzbSX+3B0n/nlS3Ppj/zrN2rB8zHk1zcbw1PCukGWOpATm+I5rUUEGk4Dm6izzzH8nKsNrGTQxPGD/cr9OvOiBWaXc6QhDVrieW1U2HP88WMi6BIpMLtoc3gyEZKkbnBeSV8VeRDISakzfPHZfaj0aT5TSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CNah5EBb; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CNah5EBb"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f0167e59a3so338080a34.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 17:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787702631; x=1788307431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qhmLvkFw7q4r3BkfihpZ0flMtMPEKt7IofeSWV3ehe8=;
        b=CNah5EBb/K/Ihn2CB8tIW8D6rf7Upze1CbxqK9yg8Vbrqp2vYHG1Rp3LonTE4TULxf
         89bwGOPBoUhgb4ezbBz6Rckj6MxEW3cab6xDBsuPulH4cs2qLk35tDf5JYTnqu87BIs4
         yG8Pi9+r2vIzOrV8g+M2ZFKjJhUJuRRXeSjow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787702631; x=1788307431;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qhmLvkFw7q4r3BkfihpZ0flMtMPEKt7IofeSWV3ehe8=;
        b=LhCGFHl4yEHV8GtkL2lXY9If2bhriZSHdj+zqgypWzpysTg7gP58e5lewLkpRmZICv
         jTdjfAEOXW7PtqeZ41em5yGpi8rP1Dh/oxJl9w6X4Ldi6NrfjzLZqafLDD8bXcPykU3z
         zaY/S4pb7QKGORlmmqpkkXmuj/kkaQFOWEWr2nWmxQP/8b+0kjTn0+aWBXOWb5gQBUsp
         dUKgrCOv41i/taFWPgiseVZRqnK3QnvB3I0SNAYOkoGxO+Xb/R2ajMQ4jVSmDQSz1bMs
         sE0keHuCeH0q5bGqLS4sMrj2pChthq1Z3AjIQ4YW1XLnkbARKspN49HKAJ02/U7OZFrL
         tBig==
X-Forwarded-Encrypted: i=1; AHgh+Rpp1gBq5MoMx6ncesIpY28/UZ/NPc7zqILeHxjPDaHBMA3idulCy5vYK88zRaz1vIRoa3uE7ao=@vger.kernel.org
X-Gm-Message-State: AFuF++kaVYq0p09Q6qYNLbYLWQ7EkkOoy7UGwViZuy3xOpJKeYUX7lmK
	Mqvq/i8d/m7yn3eWdczV9l2MAE9pJn3l5VMIzfrII1YV9+mA9e1uU/PLJqvK7Ng2a8E=
X-Gm-Gg: AR+sD13S0GPfljn9ps9U3dV8GhIDgb6pAr2G4DOFu179ii+PAQbK/vB3scA9Kh4xv+t
	ZTLP8bYibM0sAlHzQJrAmpnme0isLz0nnlg4ENSMjf4VdsufoSiJKMnY/YMvu4oss3SarcJ6KZE
	pikSQudPplFQg393Wn9vL1FR+4zzwYobb1WJrg3hz8YtVKtWySvkXTAZWnWLngF7CBfwVI9a48q
	fsSWicMc0vIcpsgQCzY2rfxENECmTe47HU3wWFwDryWnAihCiMzEUANc7692w2U+IJlmfMeRgsc
	nC7RaIdUje70SHJjYYA333tmH2yJA7YX+j6Pv+bo3uzcqB2XLxpFIyD+n5bCuQIcJ6KvoJFW3RJ
	1YnYJepo2Q5jWuO/jzwZK9Dx4FZwXGrADV4kcV5mGdHs/FFhEWj6lHA2OqeRvGeTxdzUoyC3C8k
	eTvCn8YCG1xFgxHb7QHF3APanG7VoTwq92M5kzIlY8bENVu8DwNEuwWqanGItqJ2Ig+XYRQjTnU
	IOXshrC
X-Received: by 2002:a05:6830:388d:b0:7e5:6c74:b295 with SMTP id 46e09a7af769-7f4c4fa8b3fmr2735293a34.14.1787702631068;
        Tue, 25 Aug 2026 17:03:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4c842ac28sm293745a34.21.2026.08.25.17.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 17:03:50 -0700 (PDT)
Message-ID: <d26472f3-03df-47e7-ac4c-ce0afc41499b@linuxfoundation.org>
Date: Tue, 25 Aug 2026 18:03:47 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/101] 7.1.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260825132541.986300899@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260825132541.986300899@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/26 07:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.11 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Aug 2026 13:25:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
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
