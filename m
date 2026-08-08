Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62EA32E13B
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786211226; cv=none; b=bDc295S9xY3JJ0fBPBVi/K6kMXSpwODIRS2P+fmBk4pFaTi4ntvpAQqFmxjjhHOeKQpUDbVFk6Txi4LdDUaHz+s25Hu4acFNTpp0+HSr6XJ9qJSbfIB8dWQSA4eqHO2UDY6E6kka64jTQEfCaBrS70G+2qAx+NQmiTiGXR9KfVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786211226; c=relaxed/simple;
	bh=hoDzowH9m9D/lxk1FPWoE0ndsBBYP6tCemVjnlxWSl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mw0ZO6Kb2kePmhTQzd26UAwREZnSRBobttA0I54s/IidErhMbC60I1n13LVQkXhnt2Ab7I0aLuxA6HvPTl9qsVdAroidXHinKJz1yKFRWqmiOEAsPYXAW1aRPaeloTG28yHF7x+AVWL3JZCuuITc3+KY3KqdiEVxn5iKNPttTIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Lw6QnLLd; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Lw6QnLLd"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f71156e1aso187481f8f.3
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1786211223; x=1786816023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c83vyyP7VTrLntrF65mKEgjXNcKXt6fz922KonX9hLI=;
        b=Lw6QnLLdC793MO0KyMI7V6RK8meAFeHPUNCSFd5zwPq4SExP5wvQ4EXEXnGS6xtQzu
         FcKEmJko2jzQpEtV/FGZhUTrZCdmLsoROYJ8wbmA9mYdxpBD/k2/aceyvIY6yRF5d6fK
         xu994JuQw6hrCcN26tap7oK2oHuQfhG8QcnfbTjk6yEAgoNlrozWlLsfOWW86o8dgRfs
         LKuMTbQwOI4iA1+g/AvXRgrHtkaTLjfPYWbuYXauIdOW+AWBjYIxIRuAwHfdoWVSbgnZ
         dXCjD2RkHXt9qkqraCYkHbdelCaqN38oWhNCNlcBgGudZDaRptcx95jcHRhq8BI3o+aX
         ZeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786211223; x=1786816023;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c83vyyP7VTrLntrF65mKEgjXNcKXt6fz922KonX9hLI=;
        b=agNS41/O85zfyXu5LUJu9cJWRpG22S97vHJBxGtb6T3U+KUOhujf6LhujqKC5eX0nH
         3enzhq3LJUVRtZqr+qhNgRehF6ibBCQVfgc8fCL/MY2VRfcsMFPVpaxte8rqX4wfCYfD
         EIaYMr/QLZDWz0z30nuyOD0s3DpkpIIky36tUTDG7rRp7f8NwR4uCgG7bQOenZcdlIGy
         D6dl/DO+2oGl1chmMSbdUb/REuRiWleQ8u3O4MkIyOG5vo2JKDNZTBJkC2zSVIcCUnkR
         Eb8bcgdy0XcRf3vUvxCXQmWfYRCuBm84+yPUdL3xoComg7LTUJi+GHMTKod1qUl2H2gU
         L5cg==
X-Forwarded-Encrypted: i=1; AHgh+RpbOXZQ/RzDWbUn3HmkL1CtOu6gXVNMzJ3rpiFF5oVmavu0S6Lgkh7+b0q4R+WR6wLoyoAFN28=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtzgaXcgoXu1WTn4TZytU0PPBsPJfFH21HxcDbTvuO3hH8Xcr6
	3HT4AFhac3PWKODz7QISGcwZau6y7w/D4OxWCM9cGXTFp+kniUJ1MPQ=
X-Gm-Gg: AR+sD111v1gXWXY33FMd4vg2FvoReNwJgOVljAasH46RIJvL+GxsYmnuUpls+W5yKUT
	Mjlg4nPMjWS84gSOLxkg5PaJ4+0gDKkteyafZ6VpHwItmAgTbqTctvCnQP5yml7T0c+BTrQ3xVm
	gUGDH3ivOPO1utTapVFCkosS4bxvwUCsGaE8kDbAqMg3g7juGcskXxSG6Q3H7fj4ITE4WBzEawF
	8mozzMGrizN9lYIsx+JZiCPiCtP8KxZYZn9tbbTij6UhxugqlDgEEuToYiSYBcPbtK40STRR8VI
	EEMJlT5xi8B3xO8p4w1Vw45zwQTki+L+cZDjBU7N05UX1mYuUQwAkYfCgagROcfn8vYlKYh+OnY
	pbT713fcLLxWPVwWsOeY3nCkzgxcCAyOmZcSlgF/PQRTmirejSVSbqfr/+QHIKdqwUsPVi2RiRJ
	DqjIpL4VoZVNEs1z2CPOCJlipwr1ulXMs6yQlUsxm43BS+W7oTL+GL4fAx6xux1C+WW3iyCnEEU
	4NDHLQstbj//9iauHTM2lR14Oz52FmzNYldfYt4
X-Received: by 2002:a05:6000:1449:b0:47f:d072:87d8 with SMTP id ffacd0b85a97d-48130c287d6mr11952692f8f.0.1786211222870;
        Sat, 08 Aug 2026 10:47:02 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4d93.dip0.t-ipconnect.de. [91.43.77.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8c5asm18133982f8f.18.2026.08.08.10.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2026 10:47:02 -0700 (PDT)
Message-ID: <b6881519-230e-4d37-ae1f-de46c3d41c24@googlemail.com>
Date: Sat, 8 Aug 2026 19:47:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/396] 6.18.44-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260807143424.272339768@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260807143424.272339768@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.08.2026 um 16:32 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.44 release.
> There are 396 patches in this series, all will be posted as a response
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
