Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56802EC56E
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786152080; cv=none; b=QMCWMUTWKKv2NOa/BCam8fZGXO2/SiQRh+lclPF7bor977fzhsOhd5tAi5NUJpsIg92FFegrY/hmYBJDSopHNIfDhwXZr1OOorY72mSMhrYjcMpG3WF9VUAHmVDDOvyWKmsuU/5kNe2agT/bSTzkAf9hQcF/cb3csXNUnNMJLlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786152080; c=relaxed/simple;
	bh=rNkmRRpHkjSa3uaDe3c67+rPcGRwfoMM6FHkaO04Gd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjT36u1ae2JKCm+gCii9zSqZ619mtymP4Sw9m1K+0tiV4VC0rpAxPZYb8cWfHFkeYo9wc+EA2p+8GoQQpy/2Hnb/YupRaXDoKgc4WK/hRbPhZyCM5nDeFq5r1Is3C77jcMdBIyY5wLsjP5dOcNbUoLTq36YIPee2Pd+jcW6YR+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BAgYA4yO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BAgYA4yO"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47fe377a217so38622f8f.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 18:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1786152077; x=1786756877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8rcoxkqGpzG40Z3CfGl8roTFSAXZr79E6UUmvO3lWu4=;
        b=BAgYA4yOE6Z5L8Df/YxrR11vZJ1aqJGTBsOGgO4Dh5YLnY7Q6bqMVJH4UGkFlWK/aD
         GRNI+cuhTqVgRAQZJ7LQe1w+xFZZnG+9seauuyZAM+IrYWiyN5k8bh5GYaJsrTzttEU6
         xwZhC/lL8DaRINtQ3CPmj8Z9i8w2ad+ZaYNoZTl4ok4So0ivEJGUjZ35HkJ+LS5JHtdc
         8T9R6CNR8GF3OWPS2qpqstW771arpIv1VnztsXT6U1DXEDs/OwY3TVR/lrG/gLrknit5
         /MJOvMSM/V3u9AjmgcLcx4mCsTshrrAcGR24UHr3NwYfaV3P63+SQbMlJgOKLsSCpE1e
         DMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786152077; x=1786756877;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8rcoxkqGpzG40Z3CfGl8roTFSAXZr79E6UUmvO3lWu4=;
        b=ThE0/qYtieQYwMysYlxtae3+KoIZ3Z67NeJYOrgMx5k0NUO1DMXkFXz5vgMDXWQBUJ
         bXJRDbp6ch1EiFhrSCYI0y7l3xCMfdoKLdtAu1kIU4XU8+0mSXwWCgJOQNtTcJ8Nw/HS
         PioElzUOV2+0Q5agrXVYB//svwN1OOADxsLjiRhhnU9PYubpG4ZU31EWSiuNihH7ZBpg
         UFP8NrMhqzxdehWUSi6hWeY44iNiTOL8IBRA36ONkTYF+bNUvsRI7Iu7kKBFQMqZ076v
         TgUgklHDvi4ThusbVtNx81z2jaKWKq/FlzPaRetIxRPgnpyS4PEUes7pdLh3uIuIXKnG
         1xDg==
X-Forwarded-Encrypted: i=1; AHgh+RrcmT0ohTL2yA5LLADY8sV2ejQgb7iOKdyLtPTzR2KypHQ4Kzm5T61KtSjOX5B9YiUXtfZVrd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze6r1hZvwIr0EhN8n7PjwRxaHZwJk5KsCL0955ED0agnfDqafe
	iCHAWm7J2e5sHJ7iCnltYB94c6FCBwnMKl+RY/xvUnjnjWT7suNwlcU=
X-Gm-Gg: AR+sD10sgfEQlmKZyjd8X+rayAhDypQMMyVvA5Zo+/69HwBOQjsCzPfFtRE4mFeU6u8
	G+e08nL+Icw6W7j2EjH1C8UQwvdpIIrBjMJIgbvHnjA5o0vvsfp+6mYfluvqSLi/ymHF/VvocyU
	7WRsGw3aOswVmqS97Ns9HeLqbTCd1lB/DPE/BLC30JF9vGRn1RsOP41eVux4KUhSWufiSxskBDE
	Vb0hoc/qO2I32OS/0UI57MO1lvBEXAQgjHeIayxX9QKD6hbW/90Ngh5ElhrnJdm9djaPegh4doh
	qilEgsj08HsBkLGx8zOyRK0+OM9+lChXXyu2ysnoO8T7VDVn+LJ/2PAD3B5bontc24Q7Wc8YWTO
	9q54uf7IvI93nCpkPB7b6K/8qv/WOYa1VhZtGi4f8M4DQomjVcLxniSJoJw2+kULd7D+iP77Ukj
	ToItlMinkJq1lxIpbtGHp9If1FCqZRN3lRa6EcANhg9VTHUMTurou3zX1aNSzAQbBpcZ2Ly5Luw
	DcYgiJpZjWVzmhK59iI5YxF3jzKiNNhW/YFj6mE
X-Received: by 2002:a05:6000:29d5:b0:47f:2de3:b351 with SMTP id ffacd0b85a97d-47fec63538dmr30399389f8f.26.1786152076941;
        Fri, 07 Aug 2026 18:21:16 -0700 (PDT)
Received: from [192.168.1.3] (p5b0574f6.dip0.t-ipconnect.de. [91.5.116.246])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506desm10520745f8f.10.2026.08.07.18.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 18:21:16 -0700 (PDT)
Message-ID: <5392720e-f6bf-4ba7-8e44-fe20079c4c20@googlemail.com>
Date: Sat, 8 Aug 2026 03:21:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/261] 6.6.151-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260807143415.358597922@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260807143415.358597922@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.08.2026 um 16:35 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.151 release.
> There are 261 patches in this series, all will be posted as a response
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
