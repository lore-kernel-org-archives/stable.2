Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366023A9610
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617445; cv=none; b=ipKu+g1XCgOjvNpW3yIdj8e2zf5Fqz1y5mZJmJNqw828e3bh+i75B1k80z6iLOvAoOajto3c9sRsamGHcG7JJ5qVps/BpIXKMsfTTBQmCIQnc03Rjd6wiXBMcHUgfQbvRngVWmVpOTwO0+JVjRaN4rCupPg3psTGThkSGF5Mdck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617445; c=relaxed/simple;
	bh=Q02uYC2+Oo7d80F6xEarjf2cGqMi3IYdCgyKNuiBPtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=klsu5oyCUvrCRx0fBNI2NnOu2J+TUdCo3LDwUMWrIh63VGdjo2+ox9Anm2tO0yuy8TZtGkuZ1U48SAwnEpGuKKBg2vtaEfDo9befFU63CPVxlXgm2GAPymuokUVTUM4BUmvgw2JWaVlyH4W23NKUkiLqPOYv3+tFtl6NY/J94pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSM9aUgW; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSM9aUgW"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f0b25dso4080285ad.2
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789617443; x=1790222243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j7GKqrSrkYaETKm4NogI8XRE0YV9sGlswvbwwq025+g=;
        b=XSM9aUgWx6OojLpCGHAY2U8+vsP3o5qQzRF6RXveM1Ea1et+FG1mgJw8rDSKnuRm1H
         5ynHLYILvlk2NMa2mrkeHmsYSCjRCjq47ZZf0BPvtj0OAJpbuYYTYkpnj35+u4aA1j9u
         rqC5gJzEHFoyoqTkTCPochDSl1Gcd7cvOmodWEh/1/8DKeRNn888dWcLSxudwO23E+ZK
         QIpgmsrYKds7ZQSxzp+SSsztKpvNI4MFJZW5Xyfs38AbXWE6gWGyAGPPNe3zC3w6LwQj
         AVWEvQr2vlOG1sAFSWqj1QjuKTmgBGSiRUaTv1P9/xU6KegP51Keg67e2U5ZNNXI3EZY
         m8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789617443; x=1790222243;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j7GKqrSrkYaETKm4NogI8XRE0YV9sGlswvbwwq025+g=;
        b=SjWvatw6qTR0v2daNst1r4NMqSaeBitVWMtamjFdOz1BlfMqL04y1gR+/59d4iJatD
         h9i4QXHCnrwtqJ54JdM2SAOBUQLyZG7Zt//u8xg2OMdHgmms/aPNgvJI1O8WfADP+1LH
         G/Zw74sniIUYwwTVbqG5OeGDBhpCCJNB3g1koJoZi3IL7wTqxmDwoa8pz/K6fuNSOdoF
         sw9nzsm1zhZf38fYbmhqvjeUJ2ytv9hd6AJvMUfjSufvf9JRTxthcSutu/rVlevnftlH
         lYhNB++haPhfYcLchnoomkBGrSgWaiDPgnCEOP80zbSss2eHMgnf11NzajyZ/13uZ30E
         4mLw==
X-Forwarded-Encrypted: i=1; AKwUvBwO2F0Sh9f4lMSQiPBDeBZDSfZFDo7mZzLiTsyirQ/3rDmm+RckVic5XkzOABQ/nafOGispgNQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nEF+FSqv7HWpukqV1sLTtuxPcA8wi8S48d1rlIo15aQKWtOwy4
	Jx5tn70tlV943OpIHjRZAwQ6rhWZqHO3RdkwJRM2zDpcpgBP137tjr6nh4QPvfRI
X-Gm-Gg: AYBFou2qs9yhNrtw7YdmtpCMfORv+vtokIzDc78i8scZOUkdHX4sbjsBMeEHr0OuPNK
	/Bn5NABCQkzL5nSUN4DdxV4uDRlc35SAsf5LzGAAJ/D8Z1KzUCZGtvi6DfeEHC+Vsx9rYC9bsK9
	3GoUPoh0+dnilwymgUleG+gMLnx0eD4xdbjYbiJC7tXCNl73xzr6Usjc6CDfVOn5JslJp5uHMJh
	MA269CzP22DBF4+zThrJYwuU6GAgCf/6TZ0Zv3XwveuLkTwb1/HcGNYDxcuNBgM4MwPVtultLBw
	pN9/sZ/aZ7Z4xOYzJ0CGAALkJlw9KU/Cx4XRzVucfbcfq0Ir6/RqbulLW8tlox7vWtBcVgBAASh
	CahnIJ/dIEkgAst/CtUbuFEXjXEjVTvRAtkBLxsu36YfYtsULMRTinTN3+Ap5pKVu0HG9YQ1Vpe
	gGrbAlwRobHxXrA97LrXvBPAMUhppC0VOOBowiMZuKhnvJ1r0M6B/i7SeafbMYrL2VHCV2iwg0S
	hXObXcanY1P4j3wUNxES+TE/yJQyEzgaG+qJdbRop47F5SGZYNR8wTvQn8=
X-Received: by 2002:a17:90b:582b:b0:39e:f1:b2de with SMTP id 98e67ed59e1d1-39e1e4c54fcmr12245530a91.20.1789617443370;
        Wed, 16 Sep 2026 20:57:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bfb05e604sm10462729eec.12.2026.09.16.20.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 20:57:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <82dc4e6a-0114-48ed-9fa1-1696cc5fdc08@roeck-us.net>
Date: Wed, 16 Sep 2026 20:57:21 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 1/3] hwmon: (asus_rog_ryujin) Rely on subsystem
 locking
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <2026091604-activism-jackpot-afcf@gregkh>
 <20260917015105.3705183-1-sashal@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260917015105.3705183-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/26 18:51, Sasha Levin wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> [ Upstream commit b4306c0c8e24f9e031185fb87de45391bc8c7fe9 ]
> 
> Attribute access is now serialized in the hardware monitoring core,
> so locking in the driver code is no longer necessary. Drop it.

No, it isn't, and if the patch introducing it ends up being backported
to 6.12.y it will trigger follow-up bugs in a couple of drivers.

NACK

... and commit 52dfb8be29d9 ("hwmon: (emc1403) Rely on subsystem locking")
should be reverted from 6.12.y.

Guenter

