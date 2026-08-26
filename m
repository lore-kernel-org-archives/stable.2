Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C7D425872
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753655; cv=none; b=qnDDEHp++TM7gqKEZjsmTUbPE7WXg075bHHxDHd5+9kMkl7BEJRqEWcWXA5bTCowBlSldCaegckPgS2z55czD7ooLb9khf4FebkPmLMrrp4c8fYIX+zcM+mAe/iNQiwXm4cAZf5dfd4u2YNqhSh3bxkC+m13IviI7DudvCjeqpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753655; c=relaxed/simple;
	bh=7VaVSmbAIKeSdzFb/kmFo/elSfqVEZgtkpl5F28SgLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YT5O0lQfp7xOV09wlcldsUUW2Blss4fyPWjgRvQ9cX21/64e3VXZ7ITsEO8UFT7eH8vLMWpOY2r8AOLtAGek+AAVaJ6x/slJpEAFNz1hvyOWWD+XFM1VbBF7qgHQU/D6kUv4iton/Abf5dsKV3VZRM0VFpwJbhf56t38rE63VU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SfXQoK8/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SfXQoK8/"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1677c91969so107563766b.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 07:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1787753652; x=1788358452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xYjyxtMvSao8mYDot9PzKrn7HcKiXU+v6QRh0L40jjw=;
        b=SfXQoK8/DTn0d+rFiRe/PA+ro6kzgekTDQCuai8t7VbejTe8x20zyd4/D0trFri4Pe
         00NLhvTwyM8+q6EZpjvPV1v+oH4rXOEMV6lBWPP87aOxw16AvUDyMwKcc4yfHQEh5WsN
         /t99L/zcmFlth3Wo8VkUlkyKiV+JH4J4XD5PIluz1Sls3+bIjwBJ8f0OHkelmYh81A4E
         AJI5Gq+D6Upm/q9haRX3Q9Tf1N3/UbC0vxehvA8yD6JRTkCAvVE3ErPTy03DpRl7sMOB
         we1o8Nqh7exxgMYMM6KIuIR7rnomrzHNWZeT20uhappaMZ7Q9Sraj5b1kIEBR822XCVB
         QnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787753652; x=1788358452;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xYjyxtMvSao8mYDot9PzKrn7HcKiXU+v6QRh0L40jjw=;
        b=G5Ra9bbcCeOEPcCKbXqkfEjRw4Cwpu4VdoR1M0rCuzi0MvpP5OFwPtCN9z1xlMXsmm
         16V1xGjXMkkq2TIozcfAMPa6RvuKEA4Nbkw8EKsv/4Fc+SJptJwfx3FGpJ9w4jdiw0ro
         J+a20erHFSIj/fQ7SnrBufqD5Cf5in8l692nOkSF13MM19Wmgpr9Z7NG+zlvGfqnLWaO
         QppMpdkweh/tGK3b1bO9LUXFL84f8nBdvQbQxikxpuCsGCh2njLhoJTW/MXUXFY1eAVn
         WxFhWL6pQw9uyYP0bFZnLrvzSnJJL1cU6cp6OcJa9XQudIgAtTkSCkquW39TZml+9ipN
         aVww==
X-Forwarded-Encrypted: i=1; AHgh+Ron2M5RFfEhUimXk7Y7PGrldbSTa2epVTIaX7RXYYmCZZv9qzsalXWKJU4fAVKguGEBYAnxSqM=@vger.kernel.org
X-Gm-Message-State: AFuF++kdcYSBNByh5YUgMkQBs0tYympa0O9g4DNuIkD/ZCxBHXbSNixI
	N3tZ02gaAaNw2qlep8swrFyf608gveEX0FWXEMuBWG6fXRMnmihAre8=
X-Gm-Gg: AR+sD12wr2c8HM/LKf02nxHJzljGs7NZkv9WmhtG7YnvqTaDXzt3ehU8OA0IzzQp8hO
	zbeap93ZXHGt23Ky0jv2OUrSbUNT0PPA94YWrcbyvB4Ys5PQ8Jcdi5YmRwPSRnuqcNtQS0a/aeB
	/ysrDg2nMukL13VC+pMWmm9mDWszftryrzG6vfmOXhkrXHu1ERy3qLUh2ZWxKWE0K6jsZ3JmmTd
	nytc0msU3Ch18Hy6wFv7pZnvNOGYaEtKf1A0t0T3cT0pqCRPsoujxvxHXfnkypi63P2zNdEeVca
	IwQ/k/ysCejcrV6rmvobrbmggL5au92ksTvl5DryCXr+zicKAS205xCnPnpRKdMJ/VH/4bN9XqY
	+hkqKRS/DsAgG7Nj8BmFA7ARtP58BxMOH9qxLs9LiU3W0HWnKMsRNhNwhmaHCrW3pCjeTEoXsXQ
	7F12Q9cFeCIcGNncOyKAPI8IxTrLL9s01vQ+INlCq6CArFsfBHlTx7Oj9MEKuCnz5zS6HRmAaG6
	zlwuxugJSHJaaKS1GRNAk5qcWW2BzCG1F44X8g=
X-Received: by 2002:a17:907:1888:b0:c20:23fb:bb05 with SMTP id a640c23a62f3a-c250c3089dbmr1012549966b.15.1787753651849;
        Wed, 26 Aug 2026 07:14:11 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ace5e.dip0.t-ipconnect.de. [91.42.206.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9b28basm377102566b.46.2026.08.26.07.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 07:14:11 -0700 (PDT)
Message-ID: <be9cfaf6-7188-480b-950e-22f124bf90a2@googlemail.com>
Date: Wed, 26 Aug 2026 16:14:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 00/94] 6.18.47-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260825132541.887883084@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260825132541.887883084@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.08.2026 um 15:24 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.47 release.
> There are 94 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com
