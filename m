Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C23A47206F
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807746; cv=none; b=jHoPX8+BgeDzWfe7jQZUdk6eOrQ+ccniBIohI/LIE8pP/vZ03BVnbfPG8IxGjuRGpgjVGEQmXP6sCmztPP3CIOqfL1ws3owtWClp0+ixtUtI73NnHE/yg9fvbW8l+tWoW5Qy467lpgDqJrxuLzSQinTs36gdWtBa8EdDn3MHBuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807746; c=relaxed/simple;
	bh=PPJ7XphEkFX2PI2orleZwG4vWcNUErLobmFaNusq4+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GigNQwemUu2zQc5qUV9tmJU4nJIkRSA6aY9xMi+QO9yemxtNsCiQbaENBT0boVyrRaR9NoAkvjgjc7Lw9UmONAe1jtagxc35gpMs4P6w+DdmJ662LzShg6P/B/Pq52X4nBUmWAfp4PIZsInQ/VyNO3CbMkr/DgH5XkEMGJ8ba9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=DnpyJFle; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DnpyJFle"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so44332085e9.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1790807741; x=1791412541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DFv+6x6IaH2fd0p/1qIAFYVajO1+EzROb2Ys9uN8Cp4=;
        b=DnpyJFleDzkz+oQY2vw9IpOGYWuBmAPht8GIEECjM/jhDtIywIeG7MEM0ztT5gwx2G
         t80zuv0Qmh86ro35dQiFizqACH+hTA5+o2e8dHT/OL2OR3bMQeibprf7xNL3XYFjN0/q
         SBAWlgOTgt7YwFbpX9P227w4s8EQB6eBB/nkbcFRBxvz9VYpowZ/q3HMuOwLO2nJYTpE
         kQ2gX5mYjpeCMuYAbP7UCUt53gLa4qmR1ZRRHjFhst9xpBcN5AaSBqJlFoA5tVHWDu7E
         wBsoI0cOGWQaBZsDFvsWW/lOMPcS0eMJqm4lkRVH/OlceUCoNLBw4x5jhWYUxcgTVn3R
         68tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790807741; x=1791412541;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DFv+6x6IaH2fd0p/1qIAFYVajO1+EzROb2Ys9uN8Cp4=;
        b=Z7+Ay9DREjwoUK/CpioF5/gVvnjHuMKUZmWhlqcsIylCjsh1HqJYn5iI/Fc7Xp9RpI
         PThI67n3h7RVzno0lIA+HTWiDMlErjGBoD1QcuPUIFEd6lhQXOS7PCChnWFtfygE5MoN
         /Jq0FZ1mb6b8DH1vG3r2IDxZd0rffSq9NbVJskQfwz3CWUQNn2mxB+QeWRqhtUVeg/sl
         ef273JNOf8dCcX8Uxgec6+ogL3noyPFAbWmKDe9a13+JWrtskD5ALso5amIlqdcfcyc9
         w30BbrBv/GeYsDis3U4Nz++rDjJKpkz6mhgdkTutaqa1Dve7I/UKUWp8KN6bR4+rWNUs
         R+bg==
X-Forwarded-Encrypted: i=1; AKwUvBwVtr7v+pQbWh8VGNCsHrfxAU46xLD57Phb8TDIQhLscOE8ekeQc3e2SNlvJQ38mvqt2VkTmrg=@vger.kernel.org
X-Gm-Message-State: AFuF++kF0IGhbwfPC2Sp+x02RiNAiX94+xevR9obhZY9k9pQl1Wk1k7Q
	XvDqIN/sbOzxz7UCGtjFg/zOGMKmBFZiu2so1XW2mrd9J7+qXVWrods=
X-Gm-Gg: AYBFou0WTyLdBT5AE/bcVInrctezdalPGCqjoFvPIC6SU75nQJyMw1f7fgB7SmcKCzf
	alOm/9CSZ7YIKo3+pP1XoZaP6GRMyDNtRRCshdZXnCymhiMvAWGhmgWu6Fg79/PVr2wAzxS/niX
	Xuo7+ArlRGP9OJyH9DMBB1r65W6jLRxz/4NgPp/nYdz8Os9oeKK2MZNlga+p+YiU8AZLqk8zRqi
	HXuFOcg5OVXigRVAhKUjsQx1FHRK1FcX8aPZ8DiL+CAnVDmrtDExrbceuTjTDiNOM3fdjfUrEgj
	t6W6c84qGbbdlelam/wa3wO6e5ygYggngILHbhYi3+bRZSWozRi3S5feYIei4NKmoWcEnPj0ZnN
	K2uwVmggEWAmZDuzobLsVEK30T2sX+ynojVvejQgSndnKyPBcGLAVDx/KlO4STLkwmOQa720jVm
	vOEafx/3eKTYqJxb/OHnBjnwFiptgOvIJoztZMf2/ZAWR3DwjZgU1j7VSoyK5K61krYoNekaBkD
	XCaisVAb68flPbAEBsz4bSsCArXN+ljLycW/zNtT6NFZAM/rh8=
X-Received: by 2002:a05:600c:a02:b0:4a0:1efa:c748 with SMTP id 5b1f17b1804b1-4a01efad866mr11709295e9.15.1790807741334;
        Wed, 30 Sep 2026 15:35:41 -0700 (PDT)
Received: from [192.168.1.3] (p5b057568.dip0.t-ipconnect.de. [91.5.117.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f938f89sm14345795e9.9.2026.09.30.15.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 15:35:41 -0700 (PDT)
Message-ID: <8e66c4ee-a0d8-46c2-a59c-58bbba91fd2b@googlemail.com>
Date: Thu, 1 Oct 2026 00:35:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/877] 6.12.112-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260930152414.738996857@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260930152414.738996857@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.09.2026 um 17:15 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.112 release.
> There are 877 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697v2 server. No dmesg oddities or regressions found.

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
