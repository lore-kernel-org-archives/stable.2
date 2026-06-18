Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6FF3B2FED
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781780693; cv=none; b=JqL5Kc1F2duN0a/pWV3IxmPZYGb5j9gVok32ktiBK3OS13G/1akHyeCVhEH4c/UcL73TvW668hg5IMg5nUuqvq6mCKs3X4Fk7zHtrW/eoHxXL0XQitUDOOK04bJ4hMU1sxOV1YZFcOu3VeDCC60Djd3gOn1eG+oYXU2LKhB0SuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781780693; c=relaxed/simple;
	bh=8zFYWjXdYiGvx0RH9yT9mZEvjJjd6Rtna/2LMh1peKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chfsMHwBWLPmUqL7wj8ytHG3ZNBZj39tOyTpbILGBx5GSoc9Fks8hfjSWU3NJNcgfiHsY6/+lG4FlPOynWL9uz+qUjqahIGye8FPXGBcCsuywC6pcgaPhgRZiL2F52MkAaa67r5XsnHDLG7IM8JJq9nZ7PyHzwkitzZDHnRqwRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0Ss1vCo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0Ss1vCo"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490ac357c55so7051335e9.1
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 04:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781780690; x=1782385490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=khbR9A+QxbHPJVF0qK+zhaccvVI4avoOke9tLCAjmL8=;
        b=G0Ss1vCoRQFjanpA9L/5RhvTaxJZk9H3biiYOJtyhEVElxyzkAvLcTblQgZkUcx81v
         Ejung7hxdUcSfyjaVzRywoXocuw3U2NyJdcpLmmvfNvp1MCYAugcBgj9g5l3RfNxB/yr
         9xh4Mhx/xwdMiskTJUWFSpV/oaPTIJKUEqH3oKLGm7jwcU4Jm2WMLwL+Yj9d4MHoa/jd
         aIGV3FX8VESoPqYirsSyl/4KvIN+OaeMlFg1EkDz3nyx39NTn7toJwkgRm6pB9NPALtO
         0vUs3dl/uozzHXr1bcGpLqThx+S2R1e1ylPZRy3lpSHF0MFyg2m6+Rx56EwdotfHp/CQ
         +kPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781780690; x=1782385490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khbR9A+QxbHPJVF0qK+zhaccvVI4avoOke9tLCAjmL8=;
        b=rpnDUfzz1OT9loQYxoSiB5laWmz7Zq9ozw8MUYe9AVjqfwagEwd6Z983I+lKHNL4lE
         8yfnMmWYxlrBWLI6P7fxmbpvKRYdytFZ8PPYrFf2z5dM2cnvyvFFbkX70yO4u/q3h7s8
         g/+meRiTN/fdV3F49ynfaSmVhe3o/FTrntxkB4AsOY+tC8Hh0APDqDnw4g+CvCm4YqvW
         Wu6EreC4TPUZzwTwx9Vz3oBJK00bv4ueVLxZBbi0k3s8N7d8fPCPJrJnQFSHERZunAnt
         XL3EiD60+BIy1i2qSeRhroGkdxPztsVHKeBk/occ3SLFUAxyqBqQWa8CYoXLyuF868R/
         uQ7g==
X-Forwarded-Encrypted: i=1; AFNElJ+P1BkyJfD2FQ9jqPDoCNQKpXs/5Cm7JpZbTxkWbIMo6dPUPuSNbLpVsSXYu09AbScGyclXklc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEURKVKhDU58VYhepUTw2NYbwYZSFkMLoZzr7zmRkdk8yiY8Vb
	5F9kz9h7a4lZdgtq7feJm4FwYPeZOK9QfbtwJeEPL6ttphwjWGj1j0Ic
X-Gm-Gg: AfdE7cn83MBsLWNzpS8g4IEEbFTnGd2jsli4j0SOYXPrfSkcQm4h0R39dp776u/Df12
	Ch1unoXV7SNxK7JWWhAFb4FyTknHaaDqrns+9xjxvPYkq0WzFBksMDY158/o4EwyIgNeTjMcZ6W
	fGGioA6aht2zVuuV0JXZO3KRVs7lpyqyLmSe4EFPoEtPtV1nHJt7vuD7rgQYIgNiUIQYiB7fmBX
	mNCBshE2/80NvXWFoDmQUmp51riDwI9CZ6cvC/gXk/twONMW67Tnk1ff0pl1xxMOTtF5LOOt0Vx
	h7a9B1rJr1Lc0DGCvRHG4InUTF2+0vOh9JeG2BkPiwKUSMW/LRA/HPPrY2vXQbF+BWWo742BvM2
	muRKilGxqD0lSA5rmg5UHQ97o5rPKm/+7k2FsmJNk+Qw306t6WX8RQmZ9QTvH/iHTsFmbXdbnjg
	iWcStDAaDAflPOl/YKVBK6m0J0+Xuswg==
X-Received: by 2002:a05:600c:c04b:20b0:490:a298:acf7 with SMTP id 5b1f17b1804b1-492333ca341mr115712445e9.17.1781780689705;
        Thu, 18 Jun 2026 04:04:49 -0700 (PDT)
Received: from [192.168.1.21] ([41.140.50.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f309sm57289428f8f.14.2026.06.18.04.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 04:04:31 -0700 (PDT)
Message-ID: <d4980037-ceba-4bc5-9aba-79432d6d6ae4@gmail.com>
Date: Thu, 18 Jun 2026 12:04:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/342] 5.10.259-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260616145048.348037099@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/16/2026 7:54 AM, Greg Kroah-Hartman wrote:
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

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENEIRC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

