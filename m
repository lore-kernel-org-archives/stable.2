Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06561267B89
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264401; cv=none; b=CJm+kQrOfhFxVsb8ZDuYEMeiYLfeNW9EBJ+R+Ff2X+mA+IBj6rJl/5fnHcpIa6q8vjITTr7jJO3QBPdNoZrFtGItKfdEweDTPHF1PwzP5a/gCzISLOW2a3gTP2UHIPU8XkTrrOPdNqKN+AhwpmoNAynY4lmZsdDgahqM2BlIke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264401; c=relaxed/simple;
	bh=5HWcCIL4fHBqWvcmdL83t0KPJjnu5DmgWOGGa84lqjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLe3ofCMKnsU8dtnR2MZOKLmhbEcgXCY2mQTq8WVgY9IsUpL7CcZcwya1qsXDWZhZDijU8NehgGx4P5gTs6IbYcqJDigFzj1hjZqRlhHMO7eqJXcK9AFHLcI2gq2vh718kC0o9Oe8WfOhquQzN6Zcby2I2oL++RFIXycnJu4Ync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=GgzPXLiL; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GgzPXLiL"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c255acff671so657888266b.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 05:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1788264398; x=1788869198; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f4eFl6qx/4E0gORJGZv7Bh7G1mDGrzGno8aGjAChFm0=;
        b=GgzPXLiLd6J8dZ2/jfm61N4IHeHfzWx5HJ+zXJUEDiIC6FGz1HV9lCZULAcaFz+KyI
         pG9u2lzoqzWqr+Cv2RBTcAesirWBL1q8ZoO81HrPcl+qPqJG9F+U5BvsI3WNARBaRTe6
         /oVaua1/iT2wOh/QVo+0SyzuP53pZ9sAV1MrrAf05HrOibG2S4cuEDxG/1QVuHrrt2JN
         WXuFP7dx+c/Xw9R08TXM5atpzoWy8f1YIGdidgSYYAK3mW8Dr7eB7OkERSPfyLD7xWQ+
         M4riTyKgEuNou9/Xm2cvec58N5reg1XK78jpkZdWWKAlpBFfrBG6FsQfXGcZ+ZZvK7jj
         E0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264398; x=1788869198;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f4eFl6qx/4E0gORJGZv7Bh7G1mDGrzGno8aGjAChFm0=;
        b=buV7OLDx1qPn/PPvmbnuQ+k96YvYeKTXSKz1aFkfunvMTUWgx2Vm/CwJiALGqQDLOg
         cYSFTelvET+5XP/dlM9W8oB39R7qwKoQzH9+dHzRyNVt2D7/KlsmuDnDeLbiudzz1C3V
         VTRiyAerl5maZLFY80eAenEE4OWjTB6XfA1HWjg8ovt2QtoG+UuTf6mEDSwX/gNV4E6j
         YfbZR0sUXn5GZHinT2UufnlJJAugba9VK+lB0JTnj3rL6s3tPB9RMYnDzxgFVoaJ0m1+
         0WXDymiAVLnuwMUmF0oP8RreCV5dGDcEA2rjT9vwVzlt42p5xAxAuTds7EO11SypCCcf
         hUVg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5y4M9uaOBruo02ywiprUuNIGtT1fbLdwWfqI2VlPkRhAkDiVIeP2Znm/jKdEysLdn733YKgk=@vger.kernel.org
X-Gm-Message-State: AFuF++nlLRXDGCzkOtzLER0BJ0+kdDMDCtVCTCKIOG6Y/tCD4/0K6ZzA
	YfE8StegdQACDx+bpslPD0jAaW3v2Pbh8wrGr7JZW873CmPQZcxE1/E=
X-Gm-Gg: AR+sD10k5Vq03kPnY/NZ6ZZYMNQdQPN9jTgDLo91keEgAhtp4piMiTZLjbgDR3dQ3/f
	IxrCpku2hcKGZrolWV1NTpDo8zTIsOfAlpbB3xhIRGm4Pvx6KaOG/wuIxnJvOfThJsEgamgK6DF
	pJfxhCwkcXMguMtFQvpqaTqIO4HaWAj9N+AWAbrLLjZ/p3TJuMDyv5PvVOKzN78E/giST+RXa8I
	XUYE0dCcThPce7lExXDTbTChDj6ahT9aCcBAp2CHoBSJHSwK5P6Lp+PAnmPaWOY+mirdk9JcHjS
	bcSOoVCvDYb2MfV9qXei6swhBOCqJ2D5194VpxirYAyyPmXF6366hnCvd86Rpb+R/0AqIrcbwQb
	OdWoiccrYd840loVDQAJGbp3G+/NmTzXR22pEcxccvyUBolsfXtzpn8ivoK3UYamEsVLsjOoDPU
	0kZxazIohfABuVsdSxR+I6cN1PVJUgn93+eI2NLbfNeenlumJkteVf+Bqld6WlCxtsokj1CiOyH
	orFLg947Q2b+fi7RVyPflxm6yc2gD6cpaweP5dt
X-Received: by 2002:a17:907:3e28:b0:c25:192:99ee with SMTP id a640c23a62f3a-c2557203984mr2039838266b.19.1788264397984;
        Tue, 01 Sep 2026 05:06:37 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac7f5.dip0.t-ipconnect.de. [91.42.199.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1fa3ddsm560432466b.45.2026.09.01.05.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 05:06:37 -0700 (PDT)
Message-ID: <37339c80-2809-4dd8-afd2-4a5e5698c3af@googlemail.com>
Date: Tue, 1 Sep 2026 14:06:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.1 00/76] 7.1.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260831133359.185608553@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260831133359.185608553@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 31.08.2026 um 15:33 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.1.13 release.
> There are 76 patches in this series, all will be posted as a response
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
