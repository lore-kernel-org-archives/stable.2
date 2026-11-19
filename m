Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795059136;
	b=3ht6XlsyE0Xb5mcGVcRrFaLiaWZRx+nOIilSnsgNxqpMdRnsiLUWemYiLDmRB8jjdw/H
	 jWAQZdwstF+Jn9b+Y6soH+G7FY4RfugRM3v1qh1IU5MZxtxK+Xv8ZLN5J5LPfG49Sq44O
	 thYQQo8gsfv2Xr90OnT/UVF0udG8wHXF3Gh19kbd6jNZm0uqI/eR+YIqDadSmoMgNvDUS
	 jTr88YwdiT5VwkzQEkkrJMSyWD6WlT/nJrUZO3aCh0wcKugaw5AJUogfwmlhL3htSIvO5
	 4AUv8YQAJ6eXZRBiRtFyQ8IIv9UrxgP2U3Bp0fJIVXSgGwQmn97lGEgIWtEpZ751GAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795059136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=pAo0sgsxAqoikRuu4Qee0vGiWqDOqsoV6WEE8Ptn/HY=;
	b=AVP9Zq/2EmKixjdUFslyAiZlX++3m0QNW1F9VG5L/PgGkT+J6wMM7YzkNcP80Di+K3op
	 dhG90K4h/3/7X3xV+Az1TIZogM3wZwvw6rGpiUOba+zyiJvkYRgLZkiNe8WdoEB8fNaKV
	 BaG76fvSHMQ/eB8FBBKzl6PGNwEJFsXvCiPrZRE2FLfcFp5IcLw38G2tiGtbxg+mluwpV
	 65ZZnTuN+xcwqFwj2x7xWidJ35u6UzvEUSMMB1E3vuU//TIGv3GcbVZ1VZiG53VkY3yvF
	 t7687OExWI5YJ7nxUvlJttOk0loh7kg0LirimzVT70OLvFmWI4lhD9cs5jo2ghurkbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=Q9MkuLyr;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5990606A31C
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 03:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5990606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=Q9MkuLyr
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so13849715e9.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795059134; x=1795663934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pAo0sgsxAqoikRuu4Qee0vGiWqDOqsoV6WEE8Ptn/HY=;
        b=Q9MkuLyr8HivpFVSdMlNZYOd03HcWkG+kRciZd7BSKv4rXm33N0LwNHdW95vCHxDI0
         ijcdWeJjc3Hm9QwGpzDTC+irApkfIQo6c30FdU2kp1FgmDLVKAncjPLWAJttEY0b/y+T
         ZkoGJqV8Z8fujvaj7ioPbBN9Q1QzHQTr+X7C5mb4oomlCNSZQyjJ7k7OrYRkMUQljyyL
         b6GMUQJwL+TBI8yLBJ9xdSna/LMmSB//ob/9H0jAoc1z3wMtslziGl9PkKtCtw0RaqEG
         dlMM4LnP9bPDPuV4MbG8GaLeYyeQtdpGyd3ErCTk0r805ayvuI7YI9I5Uh6aW+D3c7i1
         lGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059134; x=1795663934;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pAo0sgsxAqoikRuu4Qee0vGiWqDOqsoV6WEE8Ptn/HY=;
        b=BWpXFA+w16vrDgTOjMjltoaU/ZaLuHcaUM2pnTGFHbdfPGm/PqpkZBNFJcMK45bNM7
         PC8OLK7ylxHtQbtoawPKwH34mtXlglSJu51YAc4JG5UgZEB7wZ6JV4vCMKP9dJMlvZ4p
         GRgVsENgltsHkC8VwktZjIH363VjoPNvi7dWW0Xe5WuCImJt7XRHIUEyM4rAWltNmq+u
         NcgnZfI/4t1taN3VijZVfcO8bbdQ49EvH2YrEl0LIQrxlPgDYzQVXRuc7gpc8x6T659o
         C1KqxO4YmOsVZ8lyE0r3icq5I3UhxbgYLHHZTp/xwRtKc1DM+2+NXc5fq8YhauL2GtVE
         ScFw==
X-Forwarded-Encrypted: i=1; AL+hErFzPRaamt7IdE6CTUUb8RjUw+ZWprPC+QtqFbnsRQ63Eo3a17ZWPMT6Kgp49PYZnN7uDJxVZqs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6OC2R4/dZ00V0QiHgSST35j0FmYNRZD3ZvRM+LzvYnXNqf86i
	mjNNZbT8JSoJzOvFCU4PGOo8/2Io+eYVw0RUiMOTcpKUKzcvizWwVy4=
X-Gm-Gg: AYBFou1vTTZU25a68fnv86T1908bD87kPGcEdPvsDOYmcui+S/hTxDuqpmwGfAFCUpL
	2QCUOeqVgee3sBN9NMLl5x+NGDnyIG0NXmAN+WnKzhVSMTpsHcRsJqld4v+rCdddLu2FpDpEz1d
	61I+fNFKjtB7WBMXyBo0mGtWzElgkrMwxK00Fc94gz57yz+z3sXtiDEwINi3pyBXMvV/Uy0ODib
	IK5PX74HRjCc4rVk4qQ7oZgi5Zx6KQdMA0K4yYYGe8L/yZiO1vabwzY+BwVUaSpSC6f0ML4cWIB
	943OrenVg4RnaUhevCF/n2KR/y8DCWNVkxBds25yeKYNnlWDcGhCcIjEQgF4iN8r7wq5msn2lns
	GtXL95PtIDaldx2tR0FUImK5DwbVro5kaUJygI8PTLdrojIfNQnUozLydi4c4IQYEoW1M4eMvfE
	MuUoR06H5k9Rq1V14YQnhteuRVm7yJM4ubM+tq/h1ndUv+dAcpqCh5BRVhj5TPqEyNoLZjY7UIR
	0JFm0lMf0W/FM+p0mhooWYdiVVAhwRCyYzrftnJAI1q2Uk6gRAlrxgC9BuiVdxqcRaKpVdmMPz/
	cbWaGBl71yKA39035HWqsjpQAmlM63On7oRbsIxoBlzkNsUQKeYI15C2caWVEde1IT05UIwlBil
	byZqT
X-Received: by 2002:a05:600c:3e0c:b0:4b7:6b96:e431 with SMTP id 5b1f17b1804b1-4bb7da458eemr92432145e9.28.1795059134175;
        Wed, 18 Nov 2026 19:32:14 -0800 (PST)
Received: from [192.168.1.3] (p5b057d66.dip0.t-ipconnect.de. [91.5.125.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8532f1a9sm3566085e9.3.2026.11.18.19.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 19:32:13 -0800 (PST)
Message-ID: <8a4f9aed-be54-41a3-acd9-d25458885ea7@googlemail.com>
Date: Thu, 19 Nov 2026 04:32:13 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.3 0000/2651] 7.3.6-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261118150247.972732815@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261118150247.972732815@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 18.11.2026 um 15:20 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.3.6 release.
> There are 2651 patches in this series, all will be posted as a response
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
