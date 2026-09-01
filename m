Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9110738F259
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266389; cv=none; b=qmjp+VhQZiuFMpVSL9dE5I8Rsg8fnQBxphXchMz8aegujr1YV/AyP7Oj/gHwqvI6wvgUE5P6K2kRyvQAL7op9mkZssKkwjy1glOv/KmvYoe3uHvxNKh9zVPMt9FpxNVqHZhXp0o4O/cShn7ISx3Cc4JC5DJLoNdTrX2+76kTsXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266389; c=relaxed/simple;
	bh=R6OTu3ZLedqJvq4H6JK1yo9FBxwZF+raP0p8sBoRneM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1gpBQC8NpsZlyVNFU3O/Rbf4dlrmmoyOmiWXQsWzAeXjx1lknOBlPQCYMXA4nNgaPYVXvHR5HP6U+rOmvi7kT2F0pX+hDnOpVagPjr9uW3U4X3fv76oopCxfNJvr9EcdZOtM3D47KE4U7mFhHhOdimT4BNCywNJuYcxC6pn1gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=S3E2e7Ry; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="S3E2e7Ry"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso9114695e9.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 05:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1788266386; x=1788871186; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U7Q7YynkXMl4i7Q6YSpnO6DndhGuxWYKw0DWUs4lEJo=;
        b=S3E2e7RyTZy/1VUayaRy2ZjaFnk9wcL6oMz6gSI35YQHblI8j9HWX3ABRCA9H0mtsJ
         l4FHZTW1SMQJzv4EIhWx2ciWSNnWwgN2yN00GxSd9uoA0jErPN91sTt+dM+Ox711ilrL
         v/wSjFIV3L4Jn0mnIBLe2LpWtGX/MIFzL9+pzJFD//h3NV0ECJvY81m1ZpVstVaRU9Wk
         iVjowRJmrnIGaaUrQil0WWSoHQEi/seTzw0qNcerhq94avmXW7+No8bRPGQ98xrDWIla
         tF1TTiK5xyiwwGXXNTRQZ5JWcOJ1TqVLmnqIK2LT509imHpoOTahDXuEY/pYZjy69IdD
         JWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788266386; x=1788871186;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U7Q7YynkXMl4i7Q6YSpnO6DndhGuxWYKw0DWUs4lEJo=;
        b=VcsGSayiG3lihZt01ILHJe94hY25ChaswBY9p5faTMf9pelxIJJT23ssXSp/EzQVO1
         Bmx2LihxNf7x5U2dzlFJfrCZ0ybhw3W7vbdzraaHRN1W8vQe3Nf3WLFjeMMmelG1Os1Z
         ZdNUilt56PQiT1MkfpH/gaVLOFEF9GLmlt/0N9Iz76N8BJwP9KCHpgSMWwQpuM7RpFW0
         7JjBGldU/cvKQNQQfqTK+3K3WwNVWfmg1ogK8NOG0qhDWccBKSD19mOh9p1J+ZzoYT1s
         FLYZSYshd+JzTjTEH3dsR2icSuXjPWSzyTnRcLSUFrSL0jhrACO5xTjJntXhRXl34c8K
         FQsw==
X-Forwarded-Encrypted: i=1; AHgh+Rriih23B6517o1KcY8JeyZZ2oOQ7L+4cvek7mIjzYkVpZFWdulzkQgxNx/7ZCByPvBjE2pbQXk=@vger.kernel.org
X-Gm-Message-State: AFuF++leCqEFuOR7J53BB0mVAgxyoePO5vl4x2h7l0+jSBEWaqThOtC9
	rSBrepOXavTtklbSVKuvWPHsXXX+WqYbE2iLt6umKDYsV31gRd5xlXY=
X-Gm-Gg: AR+sD13nOKDjR5QRig+RuKG+6nmmzRGf2CpI+WthjsNhg+qNNOi1TqBLqCpVQG+oMwz
	BkojsUL4tRMOLaqvRjoSVwEZwpqGlTU+c0tVEmvmY8s5OcRojtRt+KFqaK2j8DYavBwcrtlfNqg
	tubmue0wUG3hxtRN0SeMhyr8VD9682VqqjPz/q+fhgz0eGBslZoWviiv8Zq+BvNbmqueAnhvYJ7
	8+VdB/DwoAXdfNqc5Gf3y2m95gxFgm7UBgySqoTZeOuoeLqgEnUOmsYY7U6aQWEagqKGccJq3x3
	4smj1RLmmubO7M2QJmwo4CJtNDWdseazrG0p+pkZ3OTddYrh8kbpuxpabQXe+lus4zmPPHjc6KT
	yHZp6wYITCdkvIqNVtP4L1nXlOx63hFvSicNo39jkpkBu2x1X7vayJ1Nw4pAq2hn/lLSAfTCbZ8
	Ew89ueS7oxiiAfCXu5ZXUK4KfzjjVZHKeHjHgUpRGcVDSvquyAvUWzg1DYR/SJd954fSxXD/04m
	85SdPauPde/2l7JbbE0ILfBTcpz6XhB8gWCgGJkKb0jx/qLGAY=
X-Received: by 2002:a05:600c:4fcb:b0:499:db27:7b1 with SMTP id 5b1f17b1804b1-49b91c62d9bmr508038395e9.15.1788266385542;
        Tue, 01 Sep 2026 05:39:45 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac7f5.dip0.t-ipconnect.de. [91.42.199.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d3b86dsm4584243f8f.11.2026.09.01.05.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 05:39:45 -0700 (PDT)
Message-ID: <e2926b70-c2cb-4a7b-a02e-b027f731b968@googlemail.com>
Date: Tue, 1 Sep 2026 14:39:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.2 00/71] 7.2.3-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260831133359.055927882@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260831133359.055927882@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 31.08.2026 um 15:33 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.2.3 release.
> There are 71 patches in this series, all will be posted as a response
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
