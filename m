Received: from mail-wr2-f42.google.com (mail-wr2-f42.google.com [74.125.225.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79441420480
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804455; cv=none; b=W+e1L1vzRJMvn8fOM9/bRHcynjaZ3m4X4V5eIS7ionjonp7sJZmvmSwSn9ZtUJMGDYcL3yOxO7dprtjQD+pTm74mNVHOdtihjoi2Koh0FUElio+hekd/LDtJtZ9a7Te2mn9kzydnM79KpCM3ZPPN9NHm9b4GTyBS02pExuU3Mdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804455; c=relaxed/simple;
	bh=lu1+SJCXQ2EpuIPYLuobvbha9EEZ2hsucDtrScwJEVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3bxJuaaf7kH5sVaWbYUlZ8YRH5ThlaesYDXqrKjdXXuLamgb6aAn5XqORgbVlvlVj8lqcWosLReJZ8cUbAblqhOzIPJv3+o+r0B49Ouou09xBlIcviMqFh4Z26WBAfm9EkbBdcVfObgxivNka6qLmV5gaRG41UaxtYPTE63zC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=MFg5OLDi; arc=none smtp.client-ip=74.125.225.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MFg5OLDi"
Received: by mail-wr2-f42.google.com with SMTP id ffacd0b85a97d-48b0622cc90so201724f8f.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1790804452; x=1791409252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PGfnmzZ1b/kZEE0OkLpLBVu8C0jcPTvby9i4SQKX6jk=;
        b=MFg5OLDiKj6uOPQe16pR16HT37eJMisIdBUIE59EBRiqjCNFCRYruzkB5HGJQrkMuh
         WqLSJ+syPOemkCB7Tu5Rzv/ALGzmpMNQw0eGmcLACkyeh1LQerxlFwIJQ69IBMHaeXli
         IVCbLT1sZcfyyR3i/jzRsnAZejP0WZNrvwyMLGLwLw1uZGZEgDCK8z7qTJSNmIwK5u3I
         ccFpR46JruT9Xhdw12p5yX515MOGnIg7tb9ECdZg/cDzD41cuLWgUkyRHi+7p+QxHT3K
         JC3pDsDvAh+dvt5AmuZSUunCmv5Z+xKv3dn8lYxXKcPHQfS6x0o50QdHFardk/ZL6dQt
         ZK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790804452; x=1791409252;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PGfnmzZ1b/kZEE0OkLpLBVu8C0jcPTvby9i4SQKX6jk=;
        b=Qh19offrzHsqxPk29WCBiIv2ucvK//Lxe+DAJBJcPVaNlaNSPdR7+6Qh6Q2+h6IsSu
         3AuSwWjbIWvsQqRDZf9nkB+nEkw8Scq+9qGoA27Df+Hsgp1JUb924rdnqXwCJXX+XxjY
         6W9GT+jcoVRXyXVR80QpWDznpvWivaUw1QFFLiRrvsSiNr4/iovz70d4ZgK3AuCFo+/+
         Il6oPea+Yp2kvFJGK2aE3DXVwBbDtKGdp4LEB/960r3D2e+Gju/2eSq8kT3rqVX2753t
         J49lCaFtxRUzdvc395FvzXsFqojb5fi98rc7x/r2dgNb7KPilLi1ADl8R+RI53edy78t
         Xghg==
X-Forwarded-Encrypted: i=1; AKwUvByf3EuIDEiRq7ibX+XgkoOYCuA9J+lbYDrXrp9eFVNvIsAL3PmJvjcJTPwo2gPR/S1/yccVfTQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIt5t+q+AEaIwsoes7+XC+1n3jAuXh70+TEVbKHshaiv1esjE3g
	jeSJ3BmLTupEHdsLVxd2riqH6nUtg4b1XaL+VEJrtW1vS6PGx2ajL/0=
X-Gm-Gg: AYBFou1bvkMeNDwf/bA8xIb5+pRvYpXMz7v8zU5uTPHnflOIop2yI2JA0HOgIQIOMvS
	T8H4eq8qrI++3CH1R+OqF11lDXCxuRmyZvwqeePl3xgaq3AtlETxEIpW21vcU8cq1NcJk/t4NGz
	/dehEgBOPd+y5AHH9zOvJFkx33H3utzdek126Q1SNIXTK9HdD5BCIS0TKRVe9g6+2l7I1QfC0md
	C8PXn3khcraGGnz5C5hhm7sPUoAbzbLMlb+3fZy1ot29h1BUvK1r1PblSWmI+4Jr1izXdebyDU0
	t6VlZZx3ytlu8ipJ2mQwbJYjxqmKbyH1qIX9c747zlQhCiNTofYbv8k8TPVO5DjNZgMNqPtXdlg
	UdQw+2wk74h5rU7KrZdBvjv77m15USaWNF6Y38qe6bHiOZg3viTd2ZAr4smRbqapyywkPadKHSt
	WcLdrXCRE2KhobYK3OKB7JJDktk14jr6WhDp24/1fezCJlbhTLW6vsUKroW40tqXve8Tc5e7PWh
	pPeqTU2LEIcCtvByaCAb16Ha7paYfUj09uxGHUVgO2AT3W5w0M=
X-Received: by 2002:a05:6000:1ac7:b0:488:823d:5060 with SMTP id ffacd0b85a97d-48b02544bf6mr4972784f8f.48.1790804451479;
        Wed, 30 Sep 2026 14:40:51 -0700 (PDT)
Received: from [192.168.1.3] (p5b057568.dip0.t-ipconnect.de. [91.5.117.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b06a2fc98sm1736606f8f.35.2026.09.30.14.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 14:40:51 -0700 (PDT)
Message-ID: <b6209a1e-953e-40b9-a893-64a54e475728@googlemail.com>
Date: Wed, 30 Sep 2026 23:40:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/982] 6.1.189-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260930152416.775402466@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260930152416.775402466@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.09.2026 um 17:12 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.189 release.
> There are 982 patches in this series, all will be posted as a response
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
