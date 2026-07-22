Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3FB35AC34
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 04:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784694500; cv=none; b=FroPPBA0wHmlyeybEpssdnZ8ZJetJBOIHzC2S2OyfC2f6qqRKOBCKkOqqOWblYtPJ68QSg6p+lLVYmuQ8gSSGh+On5EzX5B4DJeuZOPM2In9tkkD/RPO5+qQkes7kLNTxLWAKCXIinMPQQ6Tv2k4YhpXXbG8zMd4IobuHXqiRXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784694500; c=relaxed/simple;
	bh=Y4IKPmOrIgUJdzKXKjkJrU/HRrm4Se84EbvgRhy9FYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceq4drn0tPjxaxtQJEbfZOXocCSqKkRMBPllrEULE4RQXqPfj+5G8KBRoQc6sqvG6MMG3NuAxqJ0wUqeD2ybz1Q21E8iIK6e+jgoPZk8+w3mLfbKSipKPIuVXO/utAAmcCUxZPoTnikMVAfcNOqHP2WNtuCKBQURRelYpjGs010=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Vg2AWJfG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Vg2AWJfG"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49550ec592cso18642255e9.0
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 21:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1784694497; x=1785299297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ldbVD4qe6K2K3r+Kf7qw7vwzDn8tmHZoCss8MgT+CW8=;
        b=Vg2AWJfGLuBV+xmg5MFyjehmBIoeKTCTI2kWIF1WVtS8yNe+syHjL9KnU5oAFbsvDs
         RhM5ApTXjaCB3uZpAJ3yNwo7m4H2ahPtZHLIxIA4dBdfiXIOZnO2dtQMUOsDFtoeW0z4
         cs/jtniWhTCwQ6xhdROXyq+Vpvy+Pxe2DTmwIYjP8tZUT7XgG4dd5PZHhV0oYFpnEeqa
         semOeAVxKAWuoQWZ7xoBcBSZ2984DR1k8B8D8ZviYd54tQsAuR5wfGdxBfkD2KP9K04j
         CWpSIJBGN3PV2QtH3agi54szXNmGRuNqkojTFNvWzQnaPDPjDFob8k1anIfHpn36AIjg
         Juzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784694497; x=1785299297;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ldbVD4qe6K2K3r+Kf7qw7vwzDn8tmHZoCss8MgT+CW8=;
        b=AqTbPLEbUM42XpjVvWmZ2yTRnitwdzVX3tBReMddk4n5sM/Cx+2XlcX9iv81DciSSL
         9Awg8nZFmxuBgyn3+IRz9aGw16OYMe0/1AXEoNnzvP3Gt3jzCwgGtIdhESK5jOHSNLc5
         JPOLh+jmvGpybcmcaJkLk7ciLgZfoAsDbfnjXIFLD6EMiQsfx3cr3x8r5AN54ha7P/yK
         6FPb0ejHrFMlQ8PVlbi8wVe/bGv0mZnTRfuuhximi3NB/Cjvapp6+0IfsPcj6mJjQCG4
         deD+thiJ4SXauy+gYhRzNMlwAG+l9htCuqZaRRUsD/ZszkSUeN2IFH+SfOYjb6uKL5Nn
         b4LQ==
X-Forwarded-Encrypted: i=1; AHgh+RoMZAJ+5OvFeo/drm3RSbgobU/l6TztmQUuWMLl/ys9E+9NMisQVH+LQgKoJilMyHVM64bTW28=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyh+82HqKaUChUZ7khXNzU0neYyKiTZUfWxbm1xkJjiGj0/27D
	T9hxrBkrOtqYpUaYMMSALugB8u5GXahLAslcCQ784vDeCANB7lKJkZw=
X-Gm-Gg: AR+sD10EmSGzeMDyj3IZFti6JoSRn9hkFLQGlKkZbkvUhnHOPDZdRooznHbRfacGpKf
	jDg+S5/bp5thinTO1HX/idMSAdFrYYgeI62lR1jQPAVOthwTx2ghHeaEW7YL6ISRWnGT3ObOdfy
	RX/xD1Wq8PSEK82pL0EQkhQkLesDDEAil+c7dcZyDslFypUJnEr9AJNCCnzv5jINiQxaHtQjZ0a
	+fq0UH5NFd3cXLxiLzQ1dMALgQlJuj1vLm8Dfjj7s9RxxBXpynEOGUstXEIZGsIxfnyNeCZEM1y
	SFWCZbX8qClz42oeecApwgsBaO7hAgp4lvcMIDSUa/nnKf1lJbeuxS+lOfnaTAUkMFE/K5soyiZ
	s52o+hjP8Vspn/DrBO0fDJPcIzwAvpE8idC1vSyaSLjz1oe+PpZzq+EQyAlCYJKWpOYxjFv7QvE
	AlW+L2gy1S0ute6eMvvgP/V00q8HCXiZfKe08+IUyEl6Z2dMVNVjXUkej4elkXmw0X
X-Received: by 2002:a05:600d:8449:b0:495:6022:5a23 with SMTP id 5b1f17b1804b1-4956a51d5c4mr27454805e9.19.1784694497026;
        Tue, 21 Jul 2026 21:28:17 -0700 (PDT)
Received: from [192.168.1.3] (p5b0575c3.dip0.t-ipconnect.de. [91.5.117.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a509901sm72181655e9.8.2026.07.21.21.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 21:28:16 -0700 (PDT)
Message-ID: <ccc8ecba-4f79-4fbc-88e4-3da6857a3827@googlemail.com>
Date: Wed, 22 Jul 2026 06:28:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 0000/1611] 6.18.40-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260721152514.750365251@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260721152514.750365251@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.07.2026 um 17:01 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.40 release.
> There are 1611 patches in this series, all will be posted as a response
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
