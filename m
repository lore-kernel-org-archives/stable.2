Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153D3311C07
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786212136; cv=none; b=SQfXVWJ7oFRnQbDt+UA8jBUVbatVOIwPt04q6IHomm28g2Ll9GsezagfuQYbDBCL02UlkSNiVWnOPfg7RzYRhI74q2EjqeaVP3algL3w1XwDEoez3ghwFlEUKeuK87xJM22kQfKWMu50dT2wVgvTzzbs/tXI5ow3o3z8JCYlytM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786212136; c=relaxed/simple;
	bh=JwHp+4Apfr3z53eMpOYaq748p1NV0fmJMKuXfD78Vjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mag6JlHa6HRpZJ9BDmEJbanxwjguY4jOWQHfo4Nh6fYooP7YW/i6DXbaWL2Fv0lhkbV19oKqnSBBnIMNl1Rfic8sZq1YkoFoi28GPcarfPMKa+1Mj7XbFkE9qn64H9iuXKErMW8gN+/0S9qDRn8AuOftplm2ct4BDjhjAxwQBkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=MYm/XKiQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MYm/XKiQ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f703a9d05so336436f8f.0
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 11:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1786212133; x=1786816933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rf0bfYJpwFLd6Bf8C2FBafT9wVSh4J46LHTstg0yZPs=;
        b=MYm/XKiQS4dBt+bLSOD9kVIL9w7+zf5ijGFCHwngnBIyhGupnz44nkakBg2mUI4KHZ
         7u+Dq4kBhw/VA2ivBCzxhZVGpObTNwxhYdRivVkL0NpX1xtd9trNBGt3YPr8fsvU8NYA
         Rb7LF/YjRX6uIFnsHdnY22lqbDvSww7/ewDF9O7O0hRzNHvl091TdSd+3DeVjiu/Klj9
         mxc2PnFSgEPAX9yE8q5oCh8CYWbOHIw+Cz279iufaLMHuUi7ewe9c+IpYD/PxSwfXMug
         lg6gMvPJj2tKOWM0rpAyCIheNbIhWUhE64GGcc1Rf92RcR2YGiE3dNuAoqDIzhES0rk3
         1OVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786212133; x=1786816933;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rf0bfYJpwFLd6Bf8C2FBafT9wVSh4J46LHTstg0yZPs=;
        b=GGocr6iBy88ScWWwx/SRF9MK+2kVCxYpqQtMbbdwDY5hryBECrvefGaoddCqHE0ud8
         NhuacUReZQ8T1Vgzdkk1hK+vaVUGYAPXcogW3YDqEUDflIlkBnky7YxiTK8CCiYsnwKh
         z/e9P6JrHleQ5q2QlTe2FRjIEky4eNGOiaZqClvvRB3xlRAMkaRP2as8IvQRu8WjcuLf
         VH+xOWTgsEqWkkSFhRX3f+Os8X8AjyYwbg7yHwVXbR0+wa9IyeaV+Z57RmD7gX3zNKrp
         ijnsZSifLuNB/4+fjAQM4wRMItQ5NZVaoYgKgaU6m1cTLqLk5zthqFLqlpw1awbHISbI
         9T9g==
X-Forwarded-Encrypted: i=1; AHgh+Row0flxXFhZDWntmViczD/Sigy93uDviUjLHyG0RwB3KG8zzT1Z6/DP87ICHzKkbx8G8PoApMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIAld3MtzLb6EzY+vvIsG+TWZRpzBN+blb58J8nUGWqFCuXx5e
	mpwGq+WLTSq9henSOJcOyL84rNQOgTr+Lrxh0EIe2Nr92yMX28LLTTE=
X-Gm-Gg: AR+sD11bG+rKP1wVu/4RmBUSqqS9tXD/dxC1nw1NUln+stVLNmDKMINIVA2LAU2BsdS
	RhIlGQhGAo1wzLFW4UNjc/866NbrGxN4QXP1gZ0/3xT3Sf438gQzKmj6NIsKpwgDBfEVkH5U9JP
	aqot8B5flaZEiQU/kukU3hijlRSiczR4/Q07mytiJck4YSDeT0OkrgmjcmiT+tr9ojL0a4dj5DV
	20RQ3g1PQcYZ+8VbS+luqTnR3maLaksVTYabp7RZSyGM0XF/On7v91hZbm+PZnTXZMyxMvIQrH5
	6FqZp+c0QbeAlwG5twxH+CV0bkaY4JTHDElXrPA6KCWEoZpUXDpPuQ6QEqbK6fUXWYWH8qLVac7
	X+gju8Zq5eeGE5BFN5qFvZLDJBTwWIQCYseU+dd35A6/p0XgEcJEd3Zj270GekYbOKDfKqEd7hu
	Zjp4uYPFY5Uc7tBz/bHi5n5i6pCj+tiwnrtKDof9sVQlH7Nee+juyW5z75T6yGqsBJBNgmUDd/B
	eFRl9taBh7p6zrfWZmFpcEirKOW9rc+MPWGZW/L
X-Received: by 2002:a05:600c:470a:b0:493:f318:3bc6 with SMTP id 5b1f17b1804b1-4995e0df176mr131947075e9.13.1786212132897;
        Sat, 08 Aug 2026 11:02:12 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4d93.dip0.t-ipconnect.de. [91.43.77.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021ec565sm16065065f8f.22.2026.08.08.11.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2026 11:02:11 -0700 (PDT)
Message-ID: <f4464eb3-87a6-4ddc-b44f-74b9311d557d@googlemail.com>
Date: Sat, 8 Aug 2026 20:02:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.1 000/438] 7.1.8-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260807143428.008222056@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260807143428.008222056@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.08.2026 um 16:33 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.1.8 release.
> There are 438 patches in this series, all will be posted as a response
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
