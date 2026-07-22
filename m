Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529DB40BCAB
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 04:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784695350; cv=none; b=iz6ZEGx5TIvw8zvzD6yuSxm7X3B/en7IXhKN+ngdcPangIx+mJE0W0tM15FwElMbcXdzWEvMp+VKwhqxw3r6uXRqqet2Bnh/oxoAslsHUpZifbT0AgcVUZD1DFDv5jvd9OsoJIZqyQnPSYbdD31b3xX9G8LBxhuK7SFnE/Jl6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784695350; c=relaxed/simple;
	bh=UDwEITqIh//cs/uc6EAZsKevx3PgNN5PHdWvOK5FIXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQm+thiTMgLaysED642n5ww5+YE83H2SJfuDn0HDdg1a6zaeEBxPKYTq9kqVju915p9Ns/xUvI3rZfUUA0TfqY/1w5DGb4xCmbFRs5t7cf3GWzj9CnL0XREjz9E531OxJgFsVWHhTKVnvYWGHxS+SuiuZL/9c3Pt1bbyAI1rsaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LZP65Rna; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LZP65Rna"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954c0833b4so30895995e9.1
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 21:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1784695346; x=1785300146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HtEJofhzLlm02HKE+RTIuX6GzjO7GsDV1sElIk6QVJo=;
        b=LZP65RnaZ/IuGxS3VYDZwKbXWPRNukATUwcJb5qqCdxe3TgmmC/YbM/2HLETNa7MZW
         b6lk1WMBt4l7HxtY4ybllAcXrmTS249cswd3+8xeMDtAc/Q2NWi13Q7WHcgLbtgThjdE
         tCsYC8iCTGkJ7wVbL2BuuygLdWV6pOfyMkAoBqrtdmHaai9CpMiLdBqcc8/wugPNbpLg
         g7sUy8oKudtHED/4Iw5mi/Z/WpKX1sTEnJtqEnHU6VpENk7oR/13YfjrAyylQBKdnzA7
         kuSpaIl5jR/w5xcOy7/6eM7kVk0rPoUHDOgtlNsSNmvvGs/BpKD51dLreSQw1PvvL8yX
         44oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784695346; x=1785300146;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HtEJofhzLlm02HKE+RTIuX6GzjO7GsDV1sElIk6QVJo=;
        b=MStOnL0hLJ6AVeVd+XL6XUbjBoielCCi6bz1GyD8Xy5EeRPVBLF3WDx43hIB46EpUZ
         C0KxA9ALMv24a1RJQ992tG/3JtMlHFw2L8zo52/s9TultkB5q43aSzpwIvdJqts0JCzb
         xSay2XO5LEkyIBGYSEkKuQ1k/0M60p5ul2ygu/UvP2kC7BfQQCNCK3EC+901YqHL0z8N
         H2s+omQz3voQDb0gn3+HSwXIbVzdF+IxU4/CXYVSFvccapZA79TDdFc8qaHACs4LVSWl
         ssYvsP1rSoiye8nCEtrILapDFSP0UY0rKs0aCzGPNF12X3akdgGgMJU3sGeAErbpbMbr
         WQcA==
X-Forwarded-Encrypted: i=1; AHgh+RosPhVlgb2M5pGaYzssOjHFVHXj/2Q2hjg9kYStl7CqGPwoqX2erFNB9TqTWzV0RMeREN1bsms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJLPmiqzDhUqSdvHMCnHJO2YKJU5aHZ+AjCHSxkuqr588lnjYt
	R2bdeS9xhY+/ixkOeMzSeJTwWkXOwxJ+hF6zYk/DosHD/Lt/qxV0Gwc=
X-Gm-Gg: AR+sD10YwDFnju1Hb/IXhwmCFq4sXBmjMjC3cHfZXwQ8uchU/uLqT1TG2H4Vx3lvPVp
	nQWTZgnxvPGpSt94pQnbQCl+ioStio9rIkMQ371x2R9kUM/re4Kg8lkOw0sAOoHQrke6ozgn53T
	sos7vZrNlOy2KDl/qsLfXCIfUnsHgl3/Op05ppbQbQf7K6X+wKaO4N623f2jLLiw+2XUG8Utyau
	StDFscOMeZ87rfnuSJgU+ny2kQN59ElLFzdh74Com/KEmfNeW6kLW/tCbJRkFpYF9aI7oT6Wg7z
	8Ci0FEPfOyx4NVg/NNq7JNjGdrILrj5rHdriFyyU5Zbx+mi7S8n9YER+Qa6iMuV25/6tlxuOmyq
	DDH2CMXqCg+LVD+8VFpG+dckPhR503ovwTmpAQQhMMIZ2gS1xPAxW0mcxvQn6Wk8fwDO+Lm+Qz+
	wVQ5GNUZNaEkJI9byl4kwjJCxPFNeNQdKTuL1vrLzNzUNJ1yes8uCIBzMFcjAJGoJh
X-Received: by 2002:a05:6000:402c:b0:47f:7759:89df with SMTP id ffacd0b85a97d-47f77598aeamr14551185f8f.3.1784695346324;
        Tue, 21 Jul 2026 21:42:26 -0700 (PDT)
Received: from [192.168.1.3] (p5b0575c3.dip0.t-ipconnect.de. [91.5.117.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb5127sm2524047f8f.10.2026.07.21.21.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 21:42:26 -0700 (PDT)
Message-ID: <74b89e01-4a1f-4c0d-9d52-ebda6e980548@googlemail.com>
Date: Wed, 22 Jul 2026 06:42:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.1 0000/2077] 7.1.5-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260721152552.646164743@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260721152552.646164743@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.07.2026 um 16:54 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.1.5 release.
> There are 2077 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Wow, 2077 patches? That must have been the biggest stable RC patchset I have ever seen... Yet I found no problems 
testing it on my machine:

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
