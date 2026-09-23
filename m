Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06485476EF
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181570; cv=none; b=eLS43Zv0HZdNNZXfasb3Q6Wv2F3/yeagdYLTiAXBI/tkdVUzUorjxlA/Ct5qyzY89Rp3BU1stWVRuqasgJWsOaRt7MKNXw03B2c+40WiwHjKLEn7nFn8Y3yELxQtT8njGBhbPnNFIjvsuvqi0MUJV051/uuuAC/rWxaa/d2xbJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181570; c=relaxed/simple;
	bh=zYxOn8CFswfpD8cee+TTJhFQQ7s8ryaLPNHNoZMqIQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8HJ/rf0oVmHa/lxl5xLjtibkatufvTbBq/fEagzl6qGkeErYJlDr2cIOaO54/y2lpPEH0ViYfU2ZQ/2Ogn3PZY5l+a5NbAhFaPqjV9lylXkMoVhaLe1WBLle22Ebar1c/iTBlY6L9dATR2+MK0yqG3FunqCp6L4fAewMxcZnJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=OrzCl/TR; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OrzCl/TR"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b2522so956996f8f.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1790181559; x=1790786359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8nVHudn9MO9aguepD2cEijWmATUMlOFCYM2H17+Txec=;
        b=OrzCl/TROgo7dyGKqEfouwLyZEhr/eryRukpc1tPtJowoV56W+IFnA4vRxG1XpXKIG
         4nzGk7v4hcDX6ROqOvqUcTJSpDiYBRpE7sbK90Qph2JdPQU2/NW1FlOeVBeqeVIlNV84
         sxDn0GoUPEuYRAUitst5wG/zQ1UadMTfiMJtGY9eJdxFJi+sgyDKRX3tNYFskUFUtaLM
         IegrfmAIdemFygQCfANG1S1LAhPK+SuhNqsaCNboVW6EKeLMeTrrMVu4Hq/ErzX6QCHA
         fO5UjOG/CnRNLVZxJ6SaG9/eCRYpBqvGBQ55VRlle5jVHV8UuvBXQQ9LWUqeJ8DC/NKG
         m1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790181559; x=1790786359;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8nVHudn9MO9aguepD2cEijWmATUMlOFCYM2H17+Txec=;
        b=gyRCYgNx5t760ZlAa4B0wHyvH+1mwKnkXSuUyCHOR2oDjISGv5u7FSKPZ6gzaE3aCY
         XI8Q2lQRszZb6WFNcM7f+Fju3Xjg1tj3c0pOxZ4G5EC7XNhWIshMqCU1nzJTyRFOJWCZ
         BESyKeUK1yY/xAUjM0Zs/03GuL4jtJuhBP7JqUPgDESwm6TIJp1NidQjOURihcXce6UT
         7WhLIknBfze85iEMdsoYXsLmfB5DUw56SkTMBB1Jb4THIa57C9JLXFtTkOZwBlsiMlbY
         QRQevCDUPo2PZ8SyC/twLOs/xzhz3pNYIyoczvxZdR+NN0eW2CGy7D1Xh/gvacAmyM9S
         zuZg==
X-Forwarded-Encrypted: i=1; AKwUvBzdg67I6Cm7wGTWwn1+dSydFgu+zRYWrikwCezNFWNUS9r/qZnzt6y4qpFW8W40XyFdUbl5ftA=@vger.kernel.org
X-Gm-Message-State: AFuF++mt1LbaCWGPD0Bi9bD+nxr+OwrHeIySOroM45DncFPB//dIPuCW
	a2G8M+s4dqOwsFlPnsC2fJQNwRRBMxU5ZooyGaRpZN+S0Kg47vzq3lM=
X-Gm-Gg: AYBFou0f+76394w8qW3OHf16mL93erkWgaWknRydrmb7mYO65F/sdDPCMBYBSPgWgSA
	+KdhquKBGy0s9s438cd2IMAGctwQE/FbRJpXJNHhCPn3St1fcBXwVAcftCJOMTSqmW2MsPAZ/US
	dPAwHXJ2Oh8t6VlkP055k82Pinb6teVymoBjKH8Ahpp4QQ5/DEZ1g27z9ilOopVxh809kQmoR8A
	DSzE/M7lyoyXGCQ2ff5t7RJi7/XewdmluwIS1O1AMT/EB+ZlbXvTwmeweHxSBSOXyG/PO/e4lXG
	jkMdpZAsFbzIf32I56feh++Kxz7YMPC9sRCb0OsN4QMhvUdZTfXi58rSQYwSpGxbkigvW5gNh6+
	PkL8cePkRNmU37H30B9tf4ME1s+UxuwU4HSxETGcoxTnb+qjVm1kPyGJ2nrknt7yLZnxsly6O9a
	tg04auwHg23uqw1hjFut6Q8HxjADDk3N2bVtKokP1SLNiyQbCixz7A6WwCEr0if3dwCulKp62OX
	rKFPdBz39jKr7RTeuhIizJ7BxxIxnFb0yNlWsagRuoCka2V
X-Received: by 2002:a05:6000:4023:b0:486:f17d:14dc with SMTP id ffacd0b85a97d-4886705f8fdmr5813748f8f.12.1790181559089;
        Wed, 23 Sep 2026 09:39:19 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b415d.dip0.t-ipconnect.de. [91.43.65.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868886e45sm8363363f8f.31.2026.09.23.09.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 09:39:18 -0700 (PDT)
Message-ID: <aabce146-96d1-4556-9e30-540cdabc8a1f@googlemail.com>
Date: Wed, 23 Sep 2026 18:39:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/398] 6.18.54-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260923140643.441954610@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260923140643.441954610@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 23.09.2026 um 16:01 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.54 release.
> There are 398 patches in this series, all will be posted as a response
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
