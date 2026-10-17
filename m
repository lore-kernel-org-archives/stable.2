Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BEA4CF475
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 23:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792280310; cv=none; b=ETRIJhKYwjAwrsL5/hi0InvbcFdOe0gRQhdlhZsVLf+uFtseZYVDcV58On/d63YKz0tTg/QqeKtJx6KZLQyBTj2vRz7yWd+xEl8GeiVRgO+hLcoYnAHiUBwL6eED1FvPBsVjR7Yr/vmYNaCD39aQYhrZzsBHgOFfMtYeXxZe3lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792280310; c=relaxed/simple;
	bh=JVTsBkfayrBjFco43pfXEbz4LFu5+JkfJk9QW5Tz/vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KExnQDilUXnW0wZ/we+uG1rXmbB0RudMGuQs2qOxPj+pqne/FpaqXdpy/WoVC9hwzjK3dJn6jR5E1x7Famg++ErgOS5IMn8dLZktGm4CkIg5PfRt2OG2LBglo8JqFOmzSFmAAxga0BPN5VlnYzJmBBEurINjxb+EWOISDJe+1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ZztgYOtE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZztgYOtE"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1dfd49525so3037945e9.0
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 16:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1792280307; x=1792885107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wiwPMxdwxY4yPc3TWeM+k3SIkOD63HQmDE61mV/SD6Q=;
        b=ZztgYOtEfGLzfuT08RAgWIVm4ScmfMiNx9n2Vu5hDzX3/4sxQimTmCtlT/rXmJag+q
         bbvn0TLat+ML5LSBmi9tD/RNMV+LBtcq73KV4lZsXwGgEs2dX1GWjUi7T0WcfjaDY724
         8RZjswT9di3fo5Ghh/ipv71gWcP06DxYzezH9PlKBwZXi/IlqBULaMGT/EKwuVjQCYLE
         AOfzka34wMeTuCbcIQlZ+PY6DAHcwsCEMGpTg2mJjbMfi+8Tz8Mp2/UNli8MdIruIE1X
         +/aJp1ev8UPY+OL1R7HI/Asmi2HAEO7nqaP2sXCPMpvBc7h7YVNKxkz1peUCLDIv2gJc
         sSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792280307; x=1792885107;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wiwPMxdwxY4yPc3TWeM+k3SIkOD63HQmDE61mV/SD6Q=;
        b=YbMKHRSwOD/BnoL/0mTl4ig10if/FLY/C6oEBOAFra+dWHkTxWvu+LeLQbZoPyFOwV
         kJiIT8CE3uXS1TrZYd42r2693gH6E1ORw73Lh5ndwMQf46hHc+jVkmX3oPWWGHPHAfr8
         /Q/MjXpEvPv9zCD/EulbHmf5+vw49rAu6roee9ro4Cv8DfpcTVFKMd2ZKReTKIIhEOsV
         2fjo6Xr3AHiHKMnNVktRWBGncMujK05ea7HJv+jS2WTI+enbE1AkeCckFy7MPi4UGvIF
         PcWzGS4GQ5X1n7/bexfppYw1hOe3ij+xXISv+wj7fPJ55vkox57PkMe5kup7qFk1Ez1Z
         5n/w==
X-Forwarded-Encrypted: i=1; AKwUvBwSQmpjInXVIX/WriwaK3Ez7fuBqWXOD6uMujP+hW9SQGobsaM+JLxTYgAsgFdWE9vSlA+Mr10=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/yW+g4vVmqTlys6xFc9MGsH0Bb3hopNNwl6FL9uuoOMsiOeLy
	yvP6EjBSFuablur7n278Q/hC5qZWVBWOIwAxdOVDTf8fXjOyu5NFxcM=
X-Gm-Gg: AYBFou3t5f5lUtb7iLKVYPi0bi56jF6aDAf6dqbtvmBZipssqiRItSf2GHjMRkS9mCf
	CWFtSRIF7yByzC8EuGxmNsex20zdKwu0mmqEc0pPnKOlq2eP7ahyUpN5xb9gwGbgBysjAe3JlDJ
	Z9cGfc4vgAOG3ClW1QWHAhyrbURR9lhk6w8lMZSgQlJ9K3lCgQsJGs/Hxde/R/b3QMCI5Fa2Npc
	rSNsiaIdD2vJbSnGT0xWBfFtxGpqz7HWfPuFBHFUiWdp5w0cT1UpRgdDgg+IFb6IjTXX6nHwjt4
	M/SlXetmUmXkzTpKwdl7htyUc3PttcFe/DKV0rcPN6g4ign5T1AdJ57GC5LtsbaS4QQqdaCVqPZ
	TAD3YjbbQH7QOkZvYDm1+wEqaiDRXv3EsD9E9XKyvBl/6kgMXqJR7zdUJpRHuInndoY2CV+qqoM
	FhAxNkvW4ZFZ1IR+pEZ08zqWdgMYNr9Jz6GuVqlK9IEL5J4gh/NPTm1hvJ4NDJRi5S0Z37+J/4g
	cKdyxroDG6UxIreBQ6sgJfuU7PYsksXf46mH+2i1aVbMbki
X-Received: by 2002:a05:600c:3488:b0:4a1:dbb7:bb44 with SMTP id 5b1f17b1804b1-4a1dbb7bc9emr40963825e9.5.1792280307200;
        Sat, 17 Oct 2026 16:38:27 -0700 (PDT)
Received: from [192.168.1.3] (p5b057d26.dip0.t-ipconnect.de. [91.5.125.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce02d619sm106283035e9.3.2026.10.17.16.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 16:38:26 -0700 (PDT)
Message-ID: <b6a433cc-b00c-4ecd-8549-c382b790ac15@googlemail.com>
Date: Sun, 18 Oct 2026 01:38:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/869] 6.12.114-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261017160036.979869304@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261017160036.979869304@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.10.2026 um 17:47 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.114 release.
> There are 869 patches in this series, all will be posted as a response
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
