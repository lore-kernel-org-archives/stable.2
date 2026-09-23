Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9071F490BEC
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187665; cv=none; b=f2yXip/X4YEeD/FwHEH3WV4yNlMZfIMgFdZZ8eiAvY1LkIU5PadcViGMQnMJVpT3VKAWMfVq60TaGZtRQnEw3qZvTeH9P7Icl9vvxNw7YiJQ0i+atzYhBQ/3K2QP5UuvBuB4O5VjrGf07XE/XsmLe6aSQ+O0hynfnkN9UydWYQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187665; c=relaxed/simple;
	bh=v/4/l6++ZGNHEEzPofsFGmPRWxoaWfhxiTez96lpTYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKhcUwHRkY68+fGDXeAYdx6uLnSNWV/+6MSiI975Qoj2CtmVLHfFzUTRBvxY5rcDDkAXgcxs2tkCvkFFLwRPP7zEGThs7EcpUTH1M4+lEvOSOdR+sarkk6y2LQuk+r0+MpaFNyEwrlBwyNGG0mO5R9k0Y9x1SNQdGUzbOxx4e2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=DzEuGEPs; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DzEuGEPs"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso7226715e9.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 11:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1790187659; x=1790792459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YWjiKP/XBNIAbPzze1+HuDh+T/9ARwHn/3w9sXqhD7o=;
        b=DzEuGEPstwPJIU4KV+w6eUojFRniFFMarOnc3PtuA6RjlQtEH2meEiX9ywE7PTadPb
         K819+/y8k0237l74vgEflJhZ7NGLrKxA7Oh/nbKyiM08Auy5JgZ4mS9I5RTTHbvUuglf
         1cCt2SCzEkHc2sf5ZDqIZYQPvvgDqJI7sdZgNARXBM1VJ4OHwwk5xYpF1KNFannF54C2
         FzoHD/nvMlbsDyYINIIm1o4dVkLB2eIJ5JwechdJjFpwqUL+eyi4y6LfUGTlOuSED+fc
         NKBymkru0mX+ECbtVqLUbFFkRb92l251l3OgMiZbx+txTf76U3+LbsajzwPDbIiROjKQ
         MUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187659; x=1790792459;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YWjiKP/XBNIAbPzze1+HuDh+T/9ARwHn/3w9sXqhD7o=;
        b=cPxUBH+W9/fzkAYJIzBuH8txZ3GuVpBY0L7GqXExuTuPRJoGz1/oqPqlT24KocL9Ho
         y0CXvdaMGFsQqYZMsA63h6ohVYaIRSc6PJpU2sgGsBMfdl6C9yKYaIJg4zYLKoanzl66
         OFX6kviH+wXZ4h0FTVZwARsbnNsan+mI5qKHhsdOIkjqMD4XKsNrWeX5hHImaphhUvyh
         0PC6HhTCrdkhTBSLK9HOmksqDM6OW2XZbC0Ng4QKnSHgLZqYeXsN5H6p9voSfA3zQ0Fo
         4YPNaBG5zW/yZChtJZOCdR5vNu2T8RazvzAIQcskpQ1MrrBRbO0NcmnLJKmYX2nxQWQX
         HiNA==
X-Forwarded-Encrypted: i=1; AKwUvBxX9Gex34Hk5NfQqLIKg+zy4JOtuNfVIYN1lz7aHU1zjH+5aJ29Ntcev+bJOHw7Td84AQcMgkI=@vger.kernel.org
X-Gm-Message-State: AFuF++l9jV0FuRNK3ETyWu1oh2TTZlj7eUCUFz9qd/WDl4BiytPLgsWp
	/bk8xQwpj9T8s+2ZmTKkjwAyKE6qM0A7c7++g+GSI8RyOxvUKcP5Is8=
X-Gm-Gg: AYBFou265AhvrJwxYppbV5vUTBmU1t/Q14YkyrZ38Paf098rk7aYSU6MVpInwytOeJ3
	/5EYY2JgYkjOWvZ6rAqTXS4Ml77zu3EXIus4mm8dKGZuEh59RKPK3OGaoih2exrW4vuB3lgvm5c
	Sd/hCIzSy267PkziCq2l4vWlCbZx35JHhCzr7ScYixioXhesMnlt/XI2T82jVUUWMPWQGKIJFHy
	/B0bH8W2/oN7atV22DeMB0CkcWzkWAghCr2hUGOeutL4epe7m7zjSuhdwI4xAblw1J0MATvO7Or
	CfTGei/Ud4BfPMyQcYVlZTcYeBtNgr+YABavyokyh0TVOruW7Szz7tM134LTMUd3H1djRMkFmpU
	Fc2K5uffSaFQkUHK1tDUL8ZqhhE0e5SObwCZbqEF+VJE/LKlVv+d56IY0Kjwx4BqknsVAlUH6xV
	BIKFCfaq5XAEWfpR65HYyioULBvzhEDsTk9vpb529ShRaaxrLAMQbEGGu5bUYpPugAMXcDzHJH6
	uATYFkq4lTjA9TpL7xpVRXBTk+3prHRcT/y71Wy+2QokXIJ
X-Received: by 2002:a05:600c:4e93:b0:49d:243a:e4f9 with SMTP id 5b1f17b1804b1-49fe66d0727mr1180475e9.10.1790187658768;
        Wed, 23 Sep 2026 11:20:58 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b415d.dip0.t-ipconnect.de. [91.43.65.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5dfa6a7sm5734535e9.12.2026.09.23.11.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 11:20:58 -0700 (PDT)
Message-ID: <cfc18ad7-dffc-4386-a7b7-a152ce1d8a8d@googlemail.com>
Date: Wed, 23 Sep 2026 20:20:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.2 000/438] 7.2.8-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260923140644.756254324@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260923140644.756254324@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 23.09.2026 um 16:00 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.2.8 release.
> There are 438 patches in this series, all will be posted as a response
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
