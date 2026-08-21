Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADAD2E1746
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309347; cv=none; b=C28225G/DAUuXWj/SUubE4Anvfo1aoItC406aVR2Al+zSbJB23mfTo4gzv52mymxsa2AulhsXT9OkKEWCjNubNktODxTNxJPElSQJAr4pPA5tkS6YNvEzjq0FA/Jv4B8Je0uz/9HyIS6GLoun7QteNKrHNjIpZq9I9Aouue8J4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309347; c=relaxed/simple;
	bh=Cj7o51EaSzEwu4JFr8d6SDAAvRps8jIHBICb6cVfjDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AL0KeKZqCywFDX+PX4jpO67Oua/p9fpk8SorKiDGv3wAkQUArCCsZA+R1QuXUssZI7zxftmTqYZG6flfMmHjDaIprLJiBzGSg86QnfJHPhYhtYoFNnOT7W2Q20B7EZVlTCyTHOymcQSUuJU1Lg788EDXczSKpvZFVkxxCXVNxMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=L8kuz+6o; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="L8kuz+6o"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2074710751so156417666b.1
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 03:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1787309339; x=1787914139; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iJo7o/2ldLGTY8iHsFqVt+7Uo/Z6Cmf/028aI3xQ6RI=;
        b=L8kuz+6od/V7csVobRZ7TpZEqf/XCKa9/Ur4S+KxMGFoKm71zC7fIujJG1OVOvkgON
         zaskPYc0H3tAuWnm9UlpkMxI2jZHjQ7E3AP0qQRc5i/lWpT4u9ZWCTNgC7IJnHxHIfJ2
         b2B3XGXDG13nAQT0uyA2TNJFQntFfuzTbk7cPZDllKg8i2aGi1UHaveetoo8x+FW8i4l
         U5Yf4v4FDum9wxNJ2EgAP+aTGH6r0gzwk43G5Ra2I4bMPrpxQP1oTjuxOiekj7VIKWRT
         yRrBY2fg9LRsSSI9MBPnU2lj6AKjR6Y/VjOARa2wWOwv9L1bg47T5lanamQDeOz118GO
         sjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787309339; x=1787914139;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iJo7o/2ldLGTY8iHsFqVt+7Uo/Z6Cmf/028aI3xQ6RI=;
        b=p4a//4ERBTEFM38p0qh+dOVEwxasKy3t3VzanWPa8wUVbv3Lq/3ixh+VKXH5Za0pNc
         Z6LWDMbwlUF4L5VW0YSPMcD8zNhmL9Xd2nqsEGXB9/+K4W158EQLh0Eh9QIJmsPQ7NN5
         WPNuZ88QOgVDTYpp94vq4WhP++NA6FAc851Y+8KiEjWwevclnqWfcfXEmg8TiJME0+C2
         WAJeI4wGIYlPo0za7CHs1yoBAykumrc/yOFqxijXWJJF1yFtw777CtI5D9oHN9EZ2PwB
         Ja3XUYAQOsK7674zFyuDaTeSIavz4Ub3AZY9VoghI7H/NW4YCGbZTsqkaLynpXj4uiq/
         CRyw==
X-Forwarded-Encrypted: i=1; AHgh+Rq2dKaYbZkOFjE7ZG6JwdmVWDJHhlTIDlP8lCeXcVQTE72AolNLRmReGGetJwt+ZXV+mdUqaiQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lPq+MELl7syLyG46WdK6rS7Di5o0lpDOVwqZa/4FYSWL+Ty6lX
	svR3ad3GiLsF85VNrdPUwq6Krs41QfacDvBkLBnHCPB+Ql7Jy2E2Ik4=
X-Gm-Gg: AR+sD10VjzIimE8XJSVx4Rd7C0JUw/c11Eu4KwDy0t5c9J3/LRqB2HOwKzEtwRG9mq7
	p5cJdoAAywodbvztd7ZTigNt2glC/piLTFA3YjQbKcR1TAzkjPWsDT1gAhAm6U25Ys34c7SBJIw
	U0FFXfGkue+aZ3nXY26Y9PWOMi3aJBNqK8VRfq+4bHacf8yOWhL0mf67iNqwxrGevXclSj8soal
	qWxkblwhyChFcWSNJEq5Y1lTmMzFy+WYHUM2hHDwd2yRnDJ6SlfBmChJ6BjY7C/08pYssqvOd9M
	e6pOwBvKLYx/uSmb5dAD174B05haTLiqz/gW0nSBJKNL0P5Ts2c9XSyVLEpR8ACEUDry9ONedZ5
	8SaUPYvbE4Ykmkk6ZEQbHaRIbfd3hPoXd+TrHxw8osHlYfFWfTzRF3A9Vf45GAHYsdpca1r8LOO
	ORSnwpBC/MZ3uCLxtJS4l4UH7YiVrfIDTBTeEQ5LGdhugiD4pe0/w1Wanlr3r9bnUuIP0bwpZsi
	KjowErNWwGV5fvWcKqN/kyqgkbrm6JwMpy1FEsrvw==
X-Received: by 2002:a17:906:c146:b0:c16:66dc:3ab7 with SMTP id a640c23a62f3a-c246a6164fdmr568353966b.10.1787309338929;
        Fri, 21 Aug 2026 03:48:58 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac6d4.dip0.t-ipconnect.de. [91.42.198.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2459198d59sm379213066b.35.2026.08.21.03.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 03:48:58 -0700 (PDT)
Message-ID: <48181d0c-bbb4-435b-b910-93f5d0b18cf4@googlemail.com>
Date: Fri, 21 Aug 2026 12:48:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/303] 6.1.184-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260820145253.200766705@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260820145253.200766705@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.08.2026 um 16:52 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.184 release.
> There are 303 patches in this series, all will be posted as a response
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
