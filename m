Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B79841CB5C
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885167; cv=none; b=eLIQVnC9WKhzcnLgSpNNcYWkVz0O3mlC1ZUcW5QM83GdeirztyzvjwHV9DEM/tLpM9mg0vRmf/uKPkQbFBX4AhVAeu151aZuBoUGWI3QIW7LapF/7OVvfJQHGnEEUyvbb57GoGaLqRY61WeJWeAfHj/BFWjaITzTgxIOEhbukfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885167; c=relaxed/simple;
	bh=l6PN7eTClMmQz8WdVrL7d0xSZ6F8GlKd+XTA1d988QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oM2Fpzem/WU7MZ4eG+zyiC5uqqN1XyQFt9yNPXWLbigHPEQOPwpL38deBVJUUjorhAqjV4Jtt9uJFj6FRXZ066rOH1LO3nQ5ij7L/vwl0ucJt6MbXWOs/mAt0+FPtxJPEM8vg4jX2uHNqgdQ6QOyi0e/dvt9t1Xu/xFi+UaoYPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QV6S1FhF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QV6S1FhF"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4957eefd361so1952815e9.1
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 02:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1784885162; x=1785489962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ZHKMMt8oTtwJlTUsjbOEuseImGiJNsLoeBqzOce+qk=;
        b=QV6S1FhFX6dOJt0D0T8g/4G5+uIIZA7/yQnR0sCzT+mE3ueq03sQ+iNITc2hvkFCD3
         z293VCY34ut+kIaQcRZ/tq5jOhROHoqogl8qnOzPgFDPVgb7K2yAMEQvP/0RIiFXDK8E
         9x1k0d8vj5gJ6pluVz+xglY/iutcs2QETWcjhWu4EuZpSy0Y96LMPfSof7jrlSlcbVb6
         TlC+R2r5swKP/zlfC7XrOID3omj4opF+Uz2FOxAOGZT5PcYnvPWUIJQD1RoSfA4t+lR8
         93pTuln3RF0RqI+baoGAv/p3NDYFmBbPek7FNxp8pJQS47L4R40GilhK6Pbyj82G7TEq
         6HZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784885162; x=1785489962;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ZHKMMt8oTtwJlTUsjbOEuseImGiJNsLoeBqzOce+qk=;
        b=e7xLH8F5M1WtFOejD1tZCcqunEkI0Rj5svtVAUd2Dk+AMC1uVV253AsMtuB6UmHJxv
         5jBYgGSwLhy9t3cnc6wfoOnupW0/v548plKDk1QF0JaENPAOJCeu0rebBIS7aQksKbj/
         q+hhN4T2Q/pd+/aoX/tlt9flL3rj98Ypm2A9V4s4AuldIkP1euDr5QYznviTK7DEypMH
         LFaKtNgtkIuddKtAheWVYiH8ABK1HJ8ofUhgw9NfDB3YZSKTdUm039nor2WY5lZydkKZ
         XG028J6uH/879sXbvstVctN+A/c2ay0RfUN+l9TNc3gHva9qC+rg15VAckL1RkLlXZ3B
         xuHQ==
X-Forwarded-Encrypted: i=1; AHgh+RpS63eEucLTjUg/IvAVJCexv2TQNFu8chVTKRe0AAg4+0B8LkMVyKDSugcBUZZC4sGHra5DmZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwntZSkl6eOaIgs5OTY0RnQE9yf8dhKJpizTl5LAqPu0kb6ARmz
	5DTXTTb4m7U0ZApgcPBwDsH7zj09maZdZ7m9dDUGo1G+dMYaBPAscdY=
X-Gm-Gg: AR+sD10sbW+8WbPE04zsk4PUiQyvo6WJCF5d87oCDbnZppptA1xnU1nzhnJW55LRKDX
	J3+OMNqKEzselLnPSu8HGCuX7aBAbqmBtmhLsKTD0WL5d9qlqJZkgjzzSCesTS4NQ4xNDMYFcO4
	bMMbrthZ+Gidu+oNpUDwp+ZRUT/2MSFt3LvaBTA4dmYpiPpwdbyVeEizFKeSux+p6kYy8120LF1
	seNZga0S+m+cWAuBhd9kEqDRyfI7u22Tp3a7m0dFQepRIuHTJ/afW079HHnkQZaN97ZpE607YXG
	yWEqN0jbQHBZ2RMXUU5XEfri7kxtmmDf98XHW+K5FPaaB20jpfMYyshHcLwqBWiOuLiv7HTcF7M
	XpjwEvLi0x3IE+cXDMprbRpmQ8kpZK9agE3zk2MmwFAUtihd6VvGKMobiPASd37/gmbJCJnSbjd
	d4/JsCxkL/nMJprqL7IDu/0L6wFL6H/GRnA823aj3JQ/J1YgO4zIFQ969OtgHV3isw
X-Received: by 2002:a05:600c:2d8a:b0:493:f318:3bc6 with SMTP id 5b1f17b1804b1-49573c9d709mr48196465e9.13.1784885162143;
        Fri, 24 Jul 2026 02:26:02 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b42c8.dip0.t-ipconnect.de. [91.43.66.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957af89be2sm66856525e9.12.2026.07.24.02.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 02:26:01 -0700 (PDT)
Message-ID: <55819d9b-7eb9-4ea7-b100-7628806c6d15@googlemail.com>
Date: Fri, 24 Jul 2026 11:26:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 0000/1226] 6.6.145-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260722143258.264584003@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260722143258.264584003@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.07.2026 um 16:33 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.145 release.
> There are 1226 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or 
regressions found.

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
