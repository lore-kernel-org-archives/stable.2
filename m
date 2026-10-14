Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609D9485929
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792008811; cv=none; b=Xg3H/p4c4f4bdunWmQjkpcbZMTQ1xX4Qb/vycgDQkWkEFjazwkuZ90u/VBikVIF4CQfg/r3BFuaGT1SPL92b1bq+QRpPg5YTTtAH4aJgX4TBy8KeivsT2CJimiAMtAdo3nVeGN98LFODWHF4gxdad9kM9bX5A2vJRJ8Sp4RY4cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792008811; c=relaxed/simple;
	bh=9GlBUMY9Tt4evjQ4ULoWffGbTfu8IfA43snp9BZJV8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kv6qJqpFR69Z/xC2klTqwdEgJ0mYFW6A+v86YWwUSGUE04tcSVNvnpVssMsdFqOw3K4D3jNTrHu/HAJ1NHSMoCfuH2Ey9DOLfEjlmnIvLiDKoI9/JNeRsj3LXUpGe3Em1wX/2hamMiooEP2vfRvCircJGTLCJNbIce0StWAZsHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=RzFqpfz0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RzFqpfz0"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c4d870d54so2880244f8f.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 13:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1792008805; x=1792613605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fMcFVSFe2pDmfUyudYthyboJo6z1+8bv8RHgL8W6a6U=;
        b=RzFqpfz0zkZk/18iV+lRahB2FBBSf14OK25JLOLOT10ZfXSlDwJ5jC9bRLySjUYwNj
         XdnlMPnv7D2GKNyiK7i7IZY4Cvly8fgYO/Nos8FBTlG1Loq0KUiXt7+KISV/X+89zlOZ
         fKAc3QZG13Sjc48cVGvAZAZBLNWHmc9vsVdWpIKQ18PdG1D4t19o5b707LVjPZ0NN438
         eJzygHNFkzeHUSf71vslGXlWIpyxBYoAcnhRbhlVGPf3A1o2rNzg7G4Tnpu0LpVdGeKi
         cCcxVul7NJeVakAOj6bPmax9efgjTbGyvz2a7chQWWr5a75ArTpQGjvtilHiCwM4zwlQ
         Vikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792008805; x=1792613605;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fMcFVSFe2pDmfUyudYthyboJo6z1+8bv8RHgL8W6a6U=;
        b=seXBpLYcjDZ2KXx2a8SV+D5NdcW+BTYu6nm84b6+tJT5ou1lEZs6zZJANqRvvhYV4F
         NmY1JsDw2lgjVD9xmu2wSmolZggtfctJLy+hHnDe0hwfA/AkNlX9DLRDlZQV7pu332C3
         xvWrZe7PDVp2Wl0akwPovbB7vgeUwyaRFFC4s/MGont5yR7MkjfgUTJuB/npL1guc4Qy
         j2oWBfbJW5ropOvKRPkVYaQwOzTSNIJzuIY3WzWSt1iIBXhnfsMOYF0z5VyMUk0DVMEj
         KF1w/du/6V0PZndc6ZBHnpL5rdGnUXKFMdNvu6r3InrLrGO145UyuC6KehLVPUoqxDPE
         6wIQ==
X-Forwarded-Encrypted: i=1; AKwUvBywmLY9D8rApyX8IYbCN5yBAcyl9kPdOM2B3LsTcPsu667NnIOCIPPOFQ+t85cAenOLVGzLE3U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaefoShZNG/9119AS0E/A/Rxe3z1pe5P17TurPT//SNdbrd9dz
	Mwzr5DhJDpfd8Hy8A+kSl9yP8ky1+e7B757LFtYcgXTNi//IeEsE8OM=
X-Gm-Gg: AYBFou32OpgkVqBR8R8ZtRpgH+t5J5io1BZdv7jcJPFTqgs7RB27ybe0ONW3MSXJD5i
	mvMSeAkl+eGXhJ0nmJ2IApD0IzOe7AmfBn4YkD6c0edKPJ7yXXBWDXnOV0kIChxK3zE1s+0Usjo
	DMIpvgYwkasd2lLHNbkFzBnxLkiHzgmUwG/5nq/Px0kAxwygBaq7Ao0iB6ZiwlaotN5Npm7puCI
	ct0gfVIeV0HkfPI2+ZufzdxAXVvqZF3OGVJAdxzf0MLiIhmx51z2cCONVEgQEJnl7XopSWCtMXJ
	ADKcxlfu11opqqlWSvS/wlOociKL92ThkCYoNhQymwOFIXlLh3fsLBkasnjZuZQMHjKHpNcxRXp
	nCk7uFEfqMMzGUtzPAVhQtgwzgOkFx6rzTd/JNgjn5bybr7vVIyhPJQaAbSW/xcNwqwxrDFks5p
	Ky6eot6MWLwIvqzNzX9G6boG7CX9Dycvt/wN+jTgrBbMLAqA/JkKK/CC5loaiADrqBKYZ1B0WxG
	CJIl5AYmxMgVwhERHgoMbgBvBnJW+67edGhG1SmBCdQbaN7jIk=
X-Received: by 2002:a05:6000:2610:b0:48b:60a:760c with SMTP id ffacd0b85a97d-48dbacdbca4mr34058229f8f.31.1792008805303;
        Wed, 14 Oct 2026 13:13:25 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acf7e.dip0.t-ipconnect.de. [91.42.207.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab4e8csm13344281f8f.23.2026.10.14.13.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 13:13:24 -0700 (PDT)
Message-ID: <2ac348c8-1aa7-4d01-b189-9b7665cbfad8@googlemail.com>
Date: Wed, 14 Oct 2026 22:13:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.2 000/284] 7.2.11-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261014123758.782265692@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20261014123758.782265692@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 14.10.2026 um 14:50 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.2.11 release.
> There are 284 patches in this series, all will be posted as a response
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
