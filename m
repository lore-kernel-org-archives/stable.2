Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9565364E96
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 01:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784685066; cv=none; b=fTk4SmdkwaK1BpLicLM97ouaInQhSddXuThdOObKQd8XJYlF59QvBEXMHBPh5kJVW+upRKrsg9u4A20GYE0NyRox0vfffy8RdgF1ENxNlV3p1RJ8a08zcWMjGcENisOogaI4w3HuWIcNxyHyaUqL19muIXm286eN0rkhY7MNVCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784685066; c=relaxed/simple;
	bh=TXfB4ABh+89iwnKH/McCMIH4/ZFKUeUvf2Q9g7uVgX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhvNBenzC6NX9ZYyoKrEsyaxLlv8lY1eCtU1HqT6vu1aNxR4783eqyQmVYqFsUEge3Y5BSWHtK2S/7tYcnsnuvkeW9FnoNAQuR6KEXvkgXkgH1qDtC14i0RyjOz/8IRgcKcA6+Moz8AVQwcBaeOUKTm5L153uJrK4Gm/KG4E6h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bNGjuy2V; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bNGjuy2V"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f785467faso1872991f8f.2
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1784685063; x=1785289863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xBjB96HwVGtMp1ml2z9h2HsIvFpnCvmsF4SKp8ImWjo=;
        b=bNGjuy2Vw5p9rhE+mgIAz92gFcVkjzzh9cnqxFNNvGmMHNvyiYf6TkuXL0XuOBa0AY
         S0zNGIzeVQQcRiy855LIN8Bz/iJh8F52WHhvY68SKxLzF7ilkWfDxQaldJ4Lha+woc+H
         Cxh3qiTbH4Xz/TpYn0DFcOtP0zX4zAISolJnV/ZXrFjk8Jxr1nb9hUdkWUNswOxsqmh8
         vPjicWw8ZITEInB6DW7BAp6wJKc1OklGmlaGPUwSwJueDQHbx8eG82e5pMPkESEzKeXR
         Kn7TvPKj25prJyGhPlAhzLje05KiLQinGbrKuROj2/38WvMCGg1cYQLkW4vFgi/g71CY
         jvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784685063; x=1785289863;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xBjB96HwVGtMp1ml2z9h2HsIvFpnCvmsF4SKp8ImWjo=;
        b=FxeSTK+h/XEzW2UZ5eoGqm84dnECsZjmwmVo9zV39UBb1bXPEeQLDHxJORzoMGw9le
         AHMmB7G1g+a3B4QMwRyT3C9uZaoqFekSQ4xePxqu4OZzYkpX5O1Dwo8oT5PmBlrNeSiw
         3MwqaRIMOhicczdZ7IJfdpY6OCNnhzAHU7iZSVa9F8nQqFTAiZTRf8lpy2bsWVddul3w
         9k7qfVLTq5ZEh3SKF6Vsc7ebFKY+KMCdBUas8A5/cGfMeZXVUQdyRp0CQNK4CRABoym7
         F8lMD4KuXmvp4TDDO/4MImUmKu33DsR6jwn50QB/3Q2mwPtIVNIAjUjyrYOXnGkqWIdt
         eabA==
X-Forwarded-Encrypted: i=1; AHgh+RrZPJEcuHHSCH1XfKrIZ8xCPCHwaCuDw98SfZvGtQCwZLXaVu0b7EzGtaruUJgFA8gDQEM8it0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbR96uFAGes0VtPenDylWYeDPuz9ytfUeGXO6IdBrYO75qmW0h
	2L6fiyjlmcF6hKq/NXvo0ZoEEl2tzhuqSi6qaG1rf6PmWqyee6jlqhE=
X-Gm-Gg: AR+sD103EiUgiAMcnbCmGOI/AHxQc743J5/dZFFZ2lXGy3fioaa9aEHx7ECwXXhWhWi
	WWcnsNhAjt4jiuOHsfCmgNP+zrzYDfjT7EtFuH9aCfpWSDeQQP0dOiAGPZKRY78iYV7lkwYNIk7
	S7MOTqog3SnDpdxB2o4RbsPUxW4oMhcsztYLL9vGTlJVCfL/r5ojgPB2UP1r/LY7MoFamLuzpzK
	RjBaYc2jBmAcKKn2JMjQOyiqgYlLZcyd+y+v+9NrXPax0ZB8TGEIC8GwNk8R5WuvzpEbE7alE4q
	ojUGPFWyDEkqxT/9Q7EY2EHyrzR342CZRT2txFU0QEwny9s2Tt9V5XlZxlObxV+6xhJh9/GDONK
	mj9TVitXF17wTZt3J0A2H8P9I1t9LOdmU8qq7q2klvYNLDbwbArwDrYVEI23kAOYGae7dU31s7j
	ryv5pDaXMxmaHvOFl7yFYxvEDWfe5np9y9sAty4T+TcxHsxHmNN2OfQw==
X-Received: by 2002:a05:6000:220c:b0:47f:7c4c:8144 with SMTP id ffacd0b85a97d-47f7c4c82aemr10880687f8f.10.1784685062919;
        Tue, 21 Jul 2026 18:51:02 -0700 (PDT)
Received: from [192.168.1.3] (p5b05768a.dip0.t-ipconnect.de. [91.5.118.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a60asm1366024f8f.3.2026.07.21.18.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 18:51:02 -0700 (PDT)
Message-ID: <2dfd695c-cd5f-4949-9e8b-3a06e99aa47c@googlemail.com>
Date: Wed, 22 Jul 2026 03:51:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 0000/1067] 6.1.178-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260721152424.521567757@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260721152424.521567757@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.07.2026 um 17:10 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.178 release.
> There are 1067 patches in this series, all will be posted as a response
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
