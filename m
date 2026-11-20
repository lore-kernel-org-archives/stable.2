Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210381;
	b=cFR7A99s4n5TfygKa18qcDL/ITjCqZx58JmIb8rHUFKrDOfksc6+9BHqajNrnJK+N+yu
	 5z9FiPN9eE6cBQPiQkPABefmr0gf8vT+CLUbM5E4p6j1f0IyxYRe8VBEnCHJHR8TAvjib
	 Ua7shO+r+l0Y56C6fLrBziXAAVXsQvDf0BGKX9OP4dRiPnsMSATPIwGMw+Zt5dGoLhXxV
	 otK3Rp10zs0byX4xpvOBzH5tVpfTccBFkEV7JXxjUAwMxvtgyWGCMr+8lzHTixT8Tm7DL
	 0PGUtPZmkRYgaXedG4eW2/j5BjGEcd7um6VAwRtRSmLvhdgmLCR8JCasACztJMKxDLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=yPxtvilWekrlhitAc6HbDf16H9GXc7cY0OGz5zHiX+8=;
	b=Nv79u/SuJTgl6s2rJXVG1Gbgt032x7JExtQdqlZzMSBpFLDZpzLwgM+Mto6Vt+6xxYzY
	 zO2fxruZshS8kSQxs3jbxyBsWnHFWDWFowvazLEMU1xktZeQAOIMWw3iZYY6fGJoftf61
	 WwCrdsbV/edwvB963FOxJNY9KKoqKvheb2Y6WkVSYx5Oex0+HIsJBt6p9YOl7eGeQxt3Y
	 Y4OZN0OWLi6aHWMryI4NoQ/omH87T0Dsg8DC2f2Tc6NOTyzEuMX5pUDyCQpzKpQVqCRkp
	 nbvcuWvNYDqzs4xEvjChSbOhGzFW+SRriqazIdNL9pBxyGiFHQAhSDojSsRWyGlMTOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vbSGEmxu;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD44606A69B
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 21:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CD44606A69B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vbSGEmxu
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-385d8a00598so1592704eec.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 13:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795210377; x=1795815177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yPxtvilWekrlhitAc6HbDf16H9GXc7cY0OGz5zHiX+8=;
        b=vbSGEmxuFCB4cGAkQjKefKgfH1Oe3WXgNV4pI2zAH7KdstT03s2VfeXr+y+qO9ht1J
         QivG3vYtMS41g76Jx1lqLPnP3aAmaBBmOTthSV6/1En+ZxigF2lSU54Je9iujqQ6brUs
         q7mv7Qz+v3gTXYVkXpoi+gBNzTA8GgiH46OTkrvWa5Flr3LEWL5Pm85fSSMRcyLzFC+M
         UXjkwNv5KPplyaVkEmS6ikAdb++WzwKYoqfH2xIpqgslwFqUVgl4eoovU3TNEg+GsauS
         wvpzstwHUOyRX+Murhb9Z452TXi+qtHiZo2o9M5a6MJ7y/S7lgf+AyQa1WA8lpms5XL2
         fCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795210377; x=1795815177;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yPxtvilWekrlhitAc6HbDf16H9GXc7cY0OGz5zHiX+8=;
        b=tjrDC+7Imu4DsOFnn3enbFuiqX4WxrseZd72vG5Jxv/Pz5qdKHtYG9BkqBgAf6diaK
         UiLKWErFu/mADuaoUagWPRRVZNHocLoZTuEhpckhIE0tcwkTsgxFk6619sKyfUJHFBZD
         XmkKcutN5/Odj6UCDR8EWp8FcmNvpxLGdHdmgTu7AzMi1Iw4Qhy7A0TPLQaE/KK0XdWk
         IoZ8vAtPY+7FdtzNDaJPBL4E0UdFLDgWm4gMGp4EFvyWE2nqUFHBcHWZmRK+Fzg3LL5q
         A19STGq6SfAsHne8zjsVfVbob301ROihoJv+nOb09CfBojZZGfukYpHznHxBcUInX5/0
         aYOQ==
X-Forwarded-Encrypted: i=1; AL+hErGzFlJE4mSQVSAjfkbgzYLm8M2ed/wskiwn5vAuvuXdzpoY6nTwZ9DnL/WewH/Hmx8q/I1csgY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8s7v18WSLqe5VZDg5XcCuFjm1LRji59PV25H9OCS4GxCVt03C4
	ffxZfCaQ18LpZbw6HwBmMYo8KwpdXxjgjZbSuNbHSJ3YPju/TLUrAtot
X-Gm-Gg: AZFdTZfe7ypHWz16Ez5D+wAJroEWMWhvlLFeC4CNNzvSlZmO/Ls2IxnoyRzH15JnwvC
	vTDDwuABwSOBftHQJz0E7N8Xfh8qyFTfprBU6uTUjIgeWWdAbciqorRonxg9SLcMd6EnlE5f4Fw
	n1vLDh2A3ExeaUSujBwWZl24mVRdv2b5m9KK0TuFrLH4qcdMblmxSoyb8zL/zK+MzQFHazH9rzZ
	msQdETY84GfzFpMJ72nXJpZZ4t4u8Y92HTDbMu6O8it+EiyzUw8aFnShEKbOCzLpXfDfavPu78O
	CtFX23OFAgVWQDyDu6qFfyuOv54Z6EB0A1zg32GhqLe3lfrk8tth3RWqLiSLl/wqaYHZvb59tL7
	p1t/us4VPZk4wIHMCoGSgVHaxM9z7AMc3aDm+ZH7I8n4O141iWbB1xS3L4d2xq0d5mfhYlx+ZbS
	gM6YF8Xt6r/XNdATqJplwOBDrAXdmCsqFnc+Vhz2eRKiYgrWDVQVDUuVgdRN8t8boo/ACu5CbJZ
	b06wo7zE0l8gIR9hqqdbWu1kfrv27Fs2GlC/NnuOExhHCym6yOVHveaZ96KnjDEsNv2ZNBmPHYm
	+3GdKs1HvfrLbs8n9dmLZ6aSzp/MAP3ANseFircuChnk3NX4ByZy8huu
X-Received: by 2002:a05:693c:4015:b0:383:5eb8:d284 with SMTP id 5a478bee46e88-38570845980mr4272504eec.33.1795210376751;
        Fri, 20 Nov 2026 13:32:56 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm10283664eec.7.2026.11.20.13.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 13:32:55 -0800 (PST)
Message-ID: <b4ad1591-28bb-4431-a206-de8069b30b00@gmail.com>
Date: Fri, 20 Nov 2026 13:32:53 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 0000/2812] 6.1.193-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261120055200.707545519@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261120055200.707545519@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/26 21:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.193 release.
> There are 2812 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 22 Nov 2026 05:44:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.193-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
