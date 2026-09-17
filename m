Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8CE4D4881
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 19:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672273; cv=none; b=mNpZKTMwKfOmljMFRX2GwddKnr5+CYuvRiv3VNKgtbYfjg++yIpkNBOWWowgrkTtcOccpkThsXrRk0HY1gU4GzTSboDA2L59Vd3Arf1qJNaAYkYChN5NdJDi7n78NPXCkZafPqES8ZtNq3LZbGfKfbn9HzoXIn4i7CP/bpS05+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672273; c=relaxed/simple;
	bh=l7nRAvELSQ7CH4sn1sUKhn7MjAfp8cFsE6F+w5LoQAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmoeusJNngjUEENXftnrCCP7DS/m9c1k5eIfLVMDXfGnB7+c6UcWgubV5FnsQdOdb3eVZRV+7xEUyC8ByKEsvlesYy9EbAaG/F1cP4oJilLU47C8DWbKa1aXPYTsMV/cUW83ObKw4Vsr2QRHQWBcYF1s6csIorIl6ODo+vDMQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Z8iRZy1F; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Z8iRZy1F"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccff31419so10135585e9.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1789672269; x=1790277069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DFtQ+/AhNQvesI5lh5NjwE0BPDgyrgIywXw9qcn7r/I=;
        b=Z8iRZy1FdP+6U3OfundcG3BaclniCSExaK4+AHN38Grgmi/ZEEDurpuuUsRWg/HnAs
         SQL8xyKnYPs5ukrIQ90CTmGA3GRjVOmynJV6wzFbKGoe3OeP1FNzY2pt/MaG9YLzpR/X
         GxSAlytesyjc7QoI0pfnVUUPM5j1mxWeD60DpElTyaPxLI92jjaRTRGCoRLi/KSoEsf6
         FUwzoKwFC51gir9co1GeZEqkzM5y1t+NS3KLpDEGh3R8uFB9ffKx7Nc4H1UIEbdd+5Yw
         f9yUeqW4/MqsNUd8Rz8+xO4LPfp9rnLtn6oW201NTj93QlBufAHV9JHkNnNzRdg8a+Ih
         RILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789672269; x=1790277069;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DFtQ+/AhNQvesI5lh5NjwE0BPDgyrgIywXw9qcn7r/I=;
        b=knGp3WW1HGO+dT19tq9eA0IbhQ4IQRTPcl+lU+uZ2znwjp8IHhggKJzBPJ4sJqPsZ6
         9wgFmfhg99M1IndY/m2u6mX9kWpUGQJL0VYN+ZoXyqN7fmkZkVuybsNqDsVrXP5lUrDb
         CRabrKoi87x6JRCEO5+OVbF79APvWKDHoUNEjlP7g6mZeQIohCLHGYkwYYRfGO1pdldn
         M42BqPofd9zfptXrydoiU0CLM4bqOBcjF3I3jeJ4H4sTZXOu3ShmghaefHT1Be6Kvkve
         fLDegZ/34SUSLYOnfpLC72rP8fVn16y+247Q+uswQPMmIiw/7vDxdGv8+2NeYg16BXMK
         8M3A==
X-Forwarded-Encrypted: i=1; AKwUvBzo3IRl+AERWFkwFwmwodW8XbTHTL+oAP3Z1NNpq3QhIdRgCRBsF7ustBrPZDpLBGzrbOeaQd0=@vger.kernel.org
X-Gm-Message-State: AFuF++lhtcNmUusF6MlqoSVkH/hPJbxwKEG6F/sUhn7dFmdcTQxSgwkb
	a+VFbwF0zhcmcBAGpZdbG7QpAlyPCjkl+dICPnK289WGxZeJuyKngbk=
X-Gm-Gg: AYBFou3hMq3ZTHCZCcBYLy89XJB9dEiwRpltJ3EiSx0yaH04+/k1lKEEPJ/22WlVvd4
	lpiSuMkaXQ9mpAxCaa3zSF5lz+U6WaM6F4O2Z7nh7ViYLO2KGFWHb3+gUO6ZnOW6wypoACEVYiN
	mDRrMzR7XpSdmu0OIzVHBSwLpzm7FJnx2x2Ti+N4TLdmZnWH1otlc1UWBofId78T31JlaApafWl
	Knu6EHahr/E78J/p+IkN4chQ4cqEfZXTzbbxbjD+qSKzWxXEZ2hGTGK8pMmsuCtFT/pzsLWBPsM
	V6PXSFtKztHGVEfADkLoEWEn8l10X9l/3aySZi6iazb5BvR9g7gVmLUbaO6JIhaEOP6oe8yIEeD
	xnKTezO79bGEeHmW4zNwkW/nTCD1dZY5rV7yAmJu6xbbs2o74hl0lEJ4kS2kf/1HyLsqVnag4k2
	hkbbY5oFirJqQpE0TaOln+x6mMJLM7jQ9HKzoVwkk6kkdFBOgWsfXeG4y0as73hx8N6IRcIkwT3
	d6Ww6ie/d+sKYpNLyN1+sgwxtBsBeZAWed6SdnOXMzneIw=
X-Received: by 2002:a05:600c:1986:b0:49c:d019:70c5 with SMTP id 5b1f17b1804b1-49ea528e2f5mr105489295e9.0.1789672268824;
        Thu, 17 Sep 2026 12:11:08 -0700 (PDT)
Received: from [192.168.1.3] (p5b057001.dip0.t-ipconnect.de. [91.5.112.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd23f4e6sm117665585e9.8.2026.09.17.12.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 12:11:08 -0700 (PDT)
Message-ID: <dda6b1b0-5c9c-4417-976a-e20c4ee59ef4@googlemail.com>
Date: Thu, 17 Sep 2026 21:11:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 0000/1102] 6.12.111-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260917151539.408551884@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260917151539.408551884@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Greg,

Am 17.09.2026 um 16:59 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.111 release.
> There are 1102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

This rc1 kernel crashes on my 2-socket Ivy Bridge Xeon E5-2697v2 server when booting into it. Unfortunately, it does not 
seem to get to the point where it leaves something useful in the ERST, i.e. in /var/lib/systemd/pstore - nothing there...

So the only info I've got is a cell phone photo of the crash screen. I have put it here, in case anybody wants to have a 
look:

https://www.peters-netzplatz.de/download/IMG_20260917_204118_HDR.jpg

I have started to bisect between this rc1 and 6.12.110, which was fine. That might take me a day, though, so don't hold 
your breath.


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
