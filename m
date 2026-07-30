Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C2384233
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442488; cv=none; b=hDUDFKB9GRQrfymmx+cXo1wqYZDLWNmZMCxx4U6dRZD1a2JonFQ7EGxOnXRC+6tHd4PASZQU0iF8602nODr2+Hi5rHBWtH8hCg1JHQ1xw7z8MHLcS8K9C7vPFCWjxZkbtBKcnm6nXX8rmWe/SUNezvb18IH2QjlE2E/iz9/rhsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442488; c=relaxed/simple;
	bh=WRhaPGbZ8uKf9RtnzlLml2+viY6SidF1GRHdMJeiG0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKUBc+ldWl90nVcW9h1WhQJm+7WnswSGpizmocihQddOTacAIhEF4tvak+rPsZOKp9yt4ygKbdybULQXMfoaEV3CQRWk/jHweuO+rq5uv0STbWH7dHA2f3KS3yP71EP1Co6JYoV2jKqn2xBhTaQBf84Jn5P57717VnUj6qudvuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=korvezE8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="korvezE8"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495635a85d2so1520955e9.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 13:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1785442474; x=1786047274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SdxFevHxl3sOyQXhH0oN7UW70ptjCIsSCK1K7cuk/88=;
        b=korvezE86btyuIagoCqLovdrQmCXfk4zJXj3utcEv0glrka1haqCNjtbartfcJTZmj
         0VIASZO18UE5Q4rHlrWYeagG0J7jT6PfjSV0c8PedYCbnbQxEKow4leDLSdmPDucSqbV
         6EMvBExCFzf1a6KSm6Ko+49Vn79lg6BM9olwQPnQIPsFT3fdc1xf4eoJJnM1iHmRkjnI
         fEa7yLH6rBS4YVGDC7y6lBl5o+z+0Ow5tTV1QgS7nfBc30+avr0E5U5e7NTgM+zXbZBo
         4SnNFd8NUJjXV8u3vHRLXTCUxWAxq9verDw3DzRzJ7lnIl52D9ugt3s4ZXr3M8PIJsQX
         ezGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785442474; x=1786047274;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SdxFevHxl3sOyQXhH0oN7UW70ptjCIsSCK1K7cuk/88=;
        b=ODRzfKtQzutE4OhcwNAu5cbGVMVq0k6hrFg7L99cIhDNGDsvlmLknrb1uPyrZgTXH9
         NwHFzX47faOBvrxTg9fYlNaNWfU+8RkzuUQoXhQXws6v3B1T99ym6VDGGFmH9TXzheoj
         ZvB3+BKzoWs2f6FpOY1aDOe91XBZ8Oa9Gb2tyxsBG1eTht6scnxpkqvkUz/j2mFtk8iY
         VDLI4wMGAwuiX/amY3PzUT7NNPHuAgmZ3QnXxbhOhl6ZmNM8ArU3mvW33kFFmGiUps2S
         4qVhz3moU202PVcpJt2G4sbPIBIXLn5lLlmWqCTKi6ZLunxChQ8DQN+8l5bxsHWyBNdN
         aLfA==
X-Forwarded-Encrypted: i=1; AHgh+RrBh4BdXLTQ7t8yoOnAoiaWFAaotqp0M7UTYWlEBhr6CsmBJI5b5AOYiiinL6ZIlhvX5di3Fo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YypF7Qnxl/94o9dg3jO68uoEC4c4wVALv35ANQbIZ7BLxMNVc/d
	6ZXX2xfb1sFQ3webkAXvluwsOqVcpIf1OuiAVW1iZW3CGaUqE2Xxx+k=
X-Gm-Gg: AR+sD10vulwselT1aSdSvwWgck8+4l6D9vvN1aA73ajUTmSgD4CR+M7JQ4FHYp/k9hO
	JqQMMUqV1VYfOizr4dqzypidMfzO9UZNqL2lYnmdmMJ+dPf/pQuUx3WAjA/RVXvuvEChd2/OUs8
	zX+2m3bUCl+WYFk+JT7MnH85xe3CB8bGFLFgt3gmUEuO37C6BD4UrJZxL3TO/P78SoFWr+mgFoa
	zh9X4lJCnHaNA7gHPk3W66bkMjhgEvGWN+uDnb1s/nJzbF+3R16osPlhb9cwMP9GJP8yFLXEPvi
	yrWqfKRIsixVDfg5/Yf13Kht3d5ZUpBnz2H8MTbPz/zeOczxuiTX9Cz+4uBZEfpeprEnOwfDEsx
	vxBdSn8SJfNd8KQtBw89g/U8rMJrELXmezkqBRC277dgvPxxcQZ7oYa8MCeuOs3cMnlgzRKlUJp
	DBzF4vaTKCGWVNl5HRmY6O7NMeBNZva2KJzMu8OAWJzpZLQLQWCncZ1Mnexio4xJl+5LrJKobn+
	6TwTDiC0LEzFQBAdKGQ9ebavWLTE0MSEojgrzUsCUKrE7VVAs17
X-Received: by 2002:a05:600c:55d8:b0:492:4a50:41fe with SMTP id 5b1f17b1804b1-49800ebf6c6mr40512225e9.22.1785442474199;
        Thu, 30 Jul 2026 13:14:34 -0700 (PDT)
Received: from [192.168.1.3] (p5b2aca7f.dip0.t-ipconnect.de. [91.42.202.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49805d76bddsm5117405e9.2.2026.07.30.13.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 13:14:33 -0700 (PDT)
Message-ID: <6b5cf099-63c1-4dfa-9095-cac2d11f3eea@googlemail.com>
Date: Thu, 30 Jul 2026 22:14:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/675] 6.18.42-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260730141445.110192266@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260730141445.110192266@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.07.2026 um 16:05 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.42 release.
> There are 675 patches in this series, all will be posted as a response
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
