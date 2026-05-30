Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DACF25783A
	for <stable@vger.kernel.org>; Sat, 30 May 2026 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780172315; cv=none; b=DBYPOZtdr091JbKpub3/Q6pd/JbKUjgpU5rVsMqr+7s6buC9zMRfmaJr1EaLP+FJkFsXJ+236bAugNCm5SZTelVOadhZCXe8srmpWGIvjlfACE655qwduUlGrgSqRBkhpJ6uhFg+Vn9asFK3dCzQveM3ngfDlxD3IqDeSpVYWhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780172315; c=relaxed/simple;
	bh=c4MdMrJlz0LtBQTvMhi7ix08vuegWMJPyFsqkFVkb0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hT7iTb8y4qi5Iup+j6UR05aGB6QoAiXoxc15JTVK83csE7dNL6zpwjJ023ucEY1l/hZOBSWE/fiGMPsFgrY+S9HXX3CJgiP/h+z9NfkF6EUIlXwAxl4w7IfoMVmgO2eK25yZsFGD4iUmy93vmF9MANSYkCKx0lBFSgbP+PNMa48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ZE6vObXI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZE6vObXI"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49050ff7cbdso77344825e9.2
        for <stable@vger.kernel.org>; Sat, 30 May 2026 13:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1780172313; x=1780777113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EjF7rZtP24/FVY8gGbj0C3I59Z8/71JmY+tNyNbwV3s=;
        b=ZE6vObXIEWkjJmF9+hrP110f/mUdiZzvp4rPftC7pDeodelmTWkfLX6BOy6FoHjMF5
         Lhv8sD+VM1cSX0bTxjDxeVeMsC0xAbJjtgRJ2RyT7CEqFLjFacbyHz/P8yyRGKE7iBfm
         m8YxjUMunes4h84nAbWIpWb7q/IPI3PrleO9/fUYvjHZ32nxUfrzc+6WN3f7ogxY+cWh
         mxkhLCCzVYnUWNj3FX3Wcp3k0Wq6pBwF/KaRsXMZY+Mpnmiat0ArpRCUljb6FiZHC00D
         HbhYLFuQlW7YmiRNuZBPnX96LDba4bY1G6xmviEWIDqIy+9SEKMkqOtPR1dmXJxYKOm5
         I4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780172313; x=1780777113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjF7rZtP24/FVY8gGbj0C3I59Z8/71JmY+tNyNbwV3s=;
        b=g05vEJGFWQBKqBSmhWX46FV8PDanf3FwHSUwiGhxVQGd6urt2EZeivxkFFts9krlD/
         83enx1Uu3M7l4Z+2Etq12UQKFvNGCNP0TeNEs/3cQt0Jo8jNLNjYS5bcj+XPUVxk3/zs
         JcYJW8J1fejrV5ikeF+kCJd92DCHCSBEv/ZNkjbebXXZT/rPKn89vGe5ScJjRrsDI4FF
         tQD9EEEyLr7E0jwamQEYPmRC8qD4Gl4FwbHqkMmyDO2nittfEb03Wz3d40Az8VYn99JT
         daA1dHRv0POBli7f2l7SdJuY8pDdLRhkP53Av0IaRwomJzFdc7z3r6vjxHlzw862ohMW
         HUqA==
X-Forwarded-Encrypted: i=1; AFNElJ+ElbY1H3YJVs1sMYDKPoBTxQC6cFAZfZ1qsxmcvxjSopnBMxSoBKgmqfmggtE/t1wf2JM6DpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPmKHdOjxlhkVGyl54hrl2gOHix+kP6UKygs6fDLeluZdlrN3L
	+VFTwHgZpELhS0ECApqJ6ZZeAYjFoy00CGukatOos8CVJPngZ9Ioibo=
X-Gm-Gg: Acq92OHl77mLpIpEJUUj2+Y9kMKTSLqW1p1Kl0RWRPRBEHZdXO9NBoqk8Ii3o9DApej
	nnkthzOROAogmZyiXJiB0RLjc0io4ZTA5pjpw1khD2/YVRpqry3jqTQKkSQmBLxhMLDqBP+thBU
	YCA0vrzxTHnr6J8CYa4Ys1ahaL7XNuaR1h5/jF/HLqwIwquB2Jy4n/H2THKL/w7lzNnJv19odtJ
	zNwZ08CReoyQ73Sqy8O8QMAkTfi/XJXqab3CHBrhcVG7ZIEZyGpRHoxlSy2BGhVhUC/v9BR90xl
	lmDlmKVRKWuA5yOp+/Kdh/UkOzEktlaw9zBx41B/if5k1/GNnO9EdnPHoeQreBc59rX6m7ik4kU
	lthajAxnre2BMC1KbF9Yr75+kyu0niVDCSAIWDZ6Un2ndVqjEo3iJsnxlRafp1WhaM5Jk7Eno7s
	tppRUiFT8sjavuq1zNqyibpYQn90aTuQXD/gbKcjtQ6hs1K16+AgOuPzt1M9nf40uey09F+Tdea
	mNG74GxuosG
X-Received: by 2002:a05:600d:644e:20b0:48a:53ea:140b with SMTP id 5b1f17b1804b1-490a296b260mr64789555e9.28.1780172312557;
        Sat, 30 May 2026 13:18:32 -0700 (PDT)
Received: from [192.168.1.3] (p5b057a22.dip0.t-ipconnect.de. [91.5.122.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909ca65f54sm126842335e9.5.2026.05.30.13.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 13:18:32 -0700 (PDT)
Message-ID: <3ff645dc-92a2-4b25-be85-88c733d004be@googlemail.com>
Date: Sat, 30 May 2026 22:18:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/969] 6.1.175-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260530160300.485627683@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.05.2026 um 17:52 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.175 release.
> There are 969 patches in this series, all will be posted as a response
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
