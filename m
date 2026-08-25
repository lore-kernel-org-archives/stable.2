Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5223D88F0
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695197; cv=none; b=KsN24l21dUrnYdwEVtVEt0Ocu8mIu5XKFQj1cxMNId7XFKmNg6ojQYOOLhCsUYrQIWFw3aDqwBix0rhPXcfGs7H72EhiX5Tw4eWBqrgSGWPTQf8PqQJLwG4y5reRMYUzYrC6Tov2mRkqdTf1OV/xAXDf3YC+izGBW8KkBjW5JPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695197; c=relaxed/simple;
	bh=eggbiwEDWPBFIyUTkcJelYeKliQMWKoa31AxhuOodWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1I96eQSXiJ6S5NA0KXQAer4XOq+j1MjwvnkgD8jIV7TG7exS7Tup+LWqscHjpyNRIf4tdUO/nAbs+3VI5Lj6tI+beyX6sRqtKXwuzpNeQ78RYCp62opaE0BeXrI/PK7e0EGQlauzo+ABnfuDgIZEnnLVeFyiXUpIAi71zYQyPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9FKRV/f; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9FKRV/f"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso4612615ad.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 14:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787695196; x=1788299996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JmqLyLgU5uXQdZuwEx0AYCIdO1NJyt7iU2a+eX5wWCI=;
        b=E9FKRV/fGBcts2oZhWmjj/2E+mcCTlYHaOy1SJQfj25LcJzp9LRQHkCsLg4lUyfkgV
         GMFOET6PVizcn4RQ14TzUuAS/X3BGQXea5Ux2u/qJD6z5Z0oH2CSLLx0unC2weJnnC/u
         +y1/vp2feK8DoLuNkiM4BNQxMiU3UAqEieB1MW1zD2Ys8vFu0Zjb0OdPfgMiwxsXAT2w
         F+Exo8p2v/qzxnw4JFCN+GB8mmw3dvUQ8RO+TvQvcj/toBnyZ0aFjHD4s7UzUfNuUSWp
         CtPOo9vBBJqAHvQgY940HdTTGGHlQF/k3Uap6mYhnqNW5+4MlttCRiPLiuIHeVlZYc8i
         xmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695196; x=1788299996;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JmqLyLgU5uXQdZuwEx0AYCIdO1NJyt7iU2a+eX5wWCI=;
        b=XzzLOT8bmlJ+mxnzyNeoupBUcUX1wDcFCYv0J1cDaHX0jk0r7w7meAcuNq6cD0D2B3
         esgXpBJdOAmC3o6TCy1eysF20YHdjaF2Bwguo8GZ6fVmrp6ouCWhCEVsKFGrBok34STs
         RCaar0aRLYU1sQfuofC42mSOcBYg/xy/SuJM2NaquD6QOBfQso838S6q7ppCZDfphR8V
         yN6tBqZkW0Xz7iHIR9JtxeR3NTOdkeifnXrfmc2ysCCTpQvg6X4kDppqoHs6Gx1Snn9l
         0na0s2/YKAybxxAnlfY/qDAI9hTIjGSLnkcstB9gjPEulMTIYjX62YuFg5DL94c6Dfv5
         YKVw==
X-Forwarded-Encrypted: i=1; AHgh+RqJViwkArtvCJVcEfLzm90d0YtmPGPVeDMUG8HryXuHvpsO8z0tMNQHu6mDgz5cFUH+3gAntRs=@vger.kernel.org
X-Gm-Message-State: AFuF++mZC7Jg/PcHnUzdOV3DKlElPSUhODYcrEkna/BGf8hXmse4+w7E
	iSJ8HZyo2I61FS78jbMKvN7RlBnFCR7QViH3fNQWcF2ViTTSyfobGOM4
X-Gm-Gg: AR+sD13G+tg63XWO9+M+EwaC/sYrAs7O/NcBKlgJ+yC/ezpkFm6HBoGxGOX8GHdCAFc
	KEH/i3D7Rf1Abgfa5ac/QgxbVnX6HnxxkMWmNJr2SZQRLpR/ma722FFa5zy+rI81vM7BcLxGTmK
	b0XrZ/KDgXeFfLrs9FO+nqbWjZQ9q1hTI2RQccMvdDfQlg3O+SnHqbPiJVJoqui1ejM/M4G7soC
	vU0GQ1M0OHWYvpzq2GDmF35ysJ/sMBpXC8CtNQtoDcTyuMA91BqQYKOyUSZ5h4LWnh8R2dcgEVx
	xfaztWZebd8M8ECww14k5FeZbvGbtqnL2ewLgWbrtEOBco05sDqvyf9k8ZfR5szMcX3SEmsKz7b
	s/TwXSdJ7mik3kUaAX+YABCX+ETj2jaJzJpdYtfxjqAnnkIckHEH24WeaDeatDOFxTa+CoghnvG
	KFkJDuC6zfsCpJZu7AKXg7AT5TrdMbCIjOG+YPBzQaI9WCTjpEonajKMguNCeSSCbTjiFOMUsI3
	y3CZYSE9BJ4Q10=
X-Received: by 2002:a17:902:cf0e:b0:2d6:fea6:fe28 with SMTP id d9443c01a7336-2d707a8eb67mr25538455ad.4.1787695195755;
        Tue, 25 Aug 2026 14:59:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283fa89e8fsm1840296eec.8.2026.08.25.14.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 14:59:54 -0700 (PDT)
Message-ID: <3a323ebf-6485-446e-a0f3-25be37d0bedb@gmail.com>
Date: Tue, 25 Aug 2026 14:59:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/87] 6.6.154-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260825132541.813800447@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260825132541.813800447@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/26 06:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.154 release.
> There are 87 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Aug 2026 13:25:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.154-rc1.gz
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
