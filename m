Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30FE418A37
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798141; cv=none; b=CzyMisnOWsc/e3wQ77ubRuyw7Q+PyoWnNrPM+D4haoak4g8DMFVx9dgoH4riWe+0lCBDKSJcCnEaqbI47lrHAJjMhuam1D4wsGp9f3bZTqSS1Yp6Bvg7BY5u2gXtGgElpFzSyuNB3bxZw0fY9OPFBYeJdecvh409d3+EvGtEta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798141; c=relaxed/simple;
	bh=KWjnOX6HCuU0QAatYa7MDqIzVHf1BPZonkGs89BihyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUnbkZ5vfTkPx7C+QdO9TsigAipGOnsCLQ9WA2btLnVsZQF327OS5BHUTQaySL64uTDnQaIXg69+lAcnQEFsdQ3YRKKbfblZl9bjL3E+JUmmsfjPzFJV1WYjC+Nz1qEsa3DAheaF60xqi7ci/Hx4+IzpcWbapz09rwHwq9oTuFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=K4C6JqC9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="K4C6JqC9"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49553515a8bso4435945e9.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1784798137; x=1785402937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OdJj2BO7wpVY5lLG5+abPgagT826JqDJiVNrLTie0kA=;
        b=K4C6JqC9iutkpnSCeGuYFIqCsNGyn6YpQaCsvvsXvVj55DPclpSMZHIAvTumgU5VJT
         S52dSpGFX5Pii+EPWwPhZPGWTwabZpSpRpCzxPY7qXd/6g97nSaqbXTyhKjCGGRLVoyN
         qCUmB15a4oAVu5P7oghs5hCLiHhQjUAdcenQWH0OALfjv5tyTgnBcRnlvmFYtAsmAqc8
         ogt1HsHT/wekxaPlrS+UaJGGc1G6lvgBp/gpR2NqY6G0156d2LcR5AsBVe3MrPj2JADs
         6dkiw47Mr38fr8vvvsgCmTB7KeLqJKBP5U1lXy34BYe5m2nzCiKJ4fO3/VwFRHO6u3Wt
         vZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784798137; x=1785402937;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OdJj2BO7wpVY5lLG5+abPgagT826JqDJiVNrLTie0kA=;
        b=fhR2JeO04GmFmrxgZ4W5vICepjY0Dc+F0tVpqBYCzVq1cP7O6UpbzbMpfzkZUn8eo4
         4W8QZWHSJ1wwc1vFfOBRp4XmoczhwOGPafN73yNELbKdl1zvBEpGOk+0DY4axa2HXFC6
         hZeNYB+MXOn2F3EquiyyHiIDPUd/6tAuYehJtYoWN4rBJ5OhRweIAvBFxU68gjrAYdVI
         GDRrRk2vatx0E6FTG1kxfgVQqPNqpzmCZ9R+VRF4320t1lAc5KyaldXF0J0vn7e36euV
         P2K1+3IzEJwqNNiZDkMq2j2+AnOogzyVrtt2kjBrnosLRrV731gIoRm4W1JnK2r+7VIF
         bLow==
X-Forwarded-Encrypted: i=1; AHgh+Rqk18M3cne4ZqmDl6on0PvSyD/Sg68ncO158y8Ez4v9eJdVJyDUyDaTaTS+um4AnIYOlocUvC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcm0agH4EAk4AtC5Pl6niBAzLftmcd5XJp1niRmFHiOTFcqhS7
	ik9MwoFXxoFyd3ejYxI+FzH7+Vx595UJpfoOkn/L7b9uKzKQWxEnVY0=
X-Gm-Gg: AR+sD12UtutHPrG+CeZEktSYfGBaMyZC1mYpJBABSAusztEPy4l+LfCmJsH3ZYUuPjW
	E/BGlt6ww05Dz6LqbIrQUEuQ4RG3PZFI+XuXAPpUcJNP/xdWT+iyug3sZDkNCv9FDC8ykeM86OH
	3Lg555IUAC4pZ5nTm6IOBPXzz0a6Z9Ker26M8GVN78exI3+PX6JYws2/5MwXnGhNvYk/2dzpwlm
	lJ5xOSvd/hE1V77hgPGNrHT9zariNLDHsQakBafa7CrZuhH566NmqAII0Qy5fxFffl7qMobSZg8
	Pql8TK/xF7koXrMar7o53Q7jkmNtqgiacCmDkl9powwmV7wbGBTkua0ScHm6PjOBaNck4YxH9xJ
	wSfbx5CLqQJ2HGNhOWi8jFwroHKOFHhKYa6YTsdirCv0jPpE6WQCoiIPWMJputa7EyuEU7bJsRq
	TeuY8S4lB6IGQSJERAmgxni4YSTv8Nb66hfxJBn/06TpbEzA92TMxRc7Q=
X-Received: by 2002:a05:600c:46ca:b0:493:e97c:216e with SMTP id 5b1f17b1804b1-49573d26d00mr21155505e9.39.1784798136492;
        Thu, 23 Jul 2026 02:15:36 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acb97.dip0.t-ipconnect.de. [91.42.203.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a4f9a11sm125801275e9.4.2026.07.23.02.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 02:15:36 -0700 (PDT)
Message-ID: <3f610185-9d50-4c48-b20e-212b3cb73192@googlemail.com>
Date: Thu, 23 Jul 2026 11:15:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 0000/1624] 6.18.40-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260722142910.893804136@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260722142910.893804136@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.07.2026 um 16:31 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.40 release.
> There are 1624 patches in this series, all will be posted as a response
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
