Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A67E1632E7
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 02:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781749332; cv=pass; b=jGBHT1IilNf7f4Wf55fu4BYOVfq8wFTyVKNFWD4mLZHxwH5/humVBK7/haVs6+GSezHPXeedEU5MzHLIe3RpKXaTujwb3l3MFUWKk9h2EMe08zOY0rF1tAkBXee5imIcIKHsXrJK3XO+DYMmifKkOa8/gBE9K0lJr/Nw32N1QCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781749332; c=relaxed/simple;
	bh=r6nGsSKBwNQZdHsTVUpLiXtBJUYztA0m6qq/c+j5McM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTD/fHx/siavjMskFYjHWTYVJeptgsqz3cV/rOvsWqXM1XkSbSw3jglCsTzjWGWv4wDgN5hbASz4X9h5x3kh9BwHsjyOETG0HueB7qRmLBICB18RqauvfT1s+mljuRy/8pk1r9+Sd+WhioqPrGuvcizuy2SN2E9TNJnBMdr4Ewg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sly5mJHq; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sly5mJHq"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1370417c01cso659424c88.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 19:22:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781749330; cv=none;
        d=google.com; s=arc-20240605;
        b=HfFKEV/8MrXnO8QIKmUeFtRgBZ+pDVaquSd+Bcl8fztE0Tk3YjdTLQSVwNcnFweGUi
         EKZyGyFT7RtOtfg2SPUwfmM+vkb6BPfByRbEvTBKtHfuLj6eH4zos5D8syfZk/48rPSb
         di/R98ke7ohH9QIfcX94HCvX3jubInuZ615F7kGI057LBUWHDJG5Y1N03FjFgkA8mINa
         Pr113V9veZ95xS3HR/TEtCv3cAU3iilDz6dpQurrw7jobTq2j2rMeVmu2FcQKeuggw4n
         7KZyo0P92or5ODyf21Gzh7mSneqGymwLRySp8aguLwW25ziMGSsLb++bXRJLkGVduGQT
         MTEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6BhtNKXQbB9g+x/H4y1Xpyn02WNds6Z9fb6W/0gEDz4=;
        fh=mbJguMzDt8Xhm72LYhpsVTzXhJT9gKuj1RSGfU48F1E=;
        b=lbmQYj01ekfvIiWc4IIVkgRkzPi7ayUKQbZz+XK3M2NSTK4FoblWuYVGiiT9ZgWGsq
         wyAO7BplXJ9C5klFdRgu+pBljQ4rwq3aPtgPzNP9f/YXG0vOmFjS3uPEXrOffGRLznkc
         PNfesExXI2eMV7Ev3eISjhx/o3dsX+7FTpJc26ovGa2XcAgYfQ32Mpp9TUPAaDkTfvl1
         0iGgqxGoVABELl/RVoZRnJjBYlxM8QXrrjrKHDD4EuljunKGe9wZhsPxd/uDFhOFs3ts
         HGNrZIeCjsDomYXQp6YLyhBQNas7ZPZukUanm78nzP3U3Ufw/Zr8/Ft/sM5z+fjeX0fQ
         Om5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781749330; x=1782354130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BhtNKXQbB9g+x/H4y1Xpyn02WNds6Z9fb6W/0gEDz4=;
        b=Sly5mJHqtqZDDFa24igPYzlWJfGWiaJq6jBbm0ZYF967Y81dLWr5VV1j/NNILQAo+g
         WKZQHAwnlBO1jybOJ2ttL3UWDI1saLRyOVrAaWcNu4JOYRsyl/UXOmErOHqNybFLBiV4
         Fz/Au7KnbKMQTFdVOYgOQ0pgZzW1yWwNwdtKSeY4YBvU7vxEyIN40Ak3Oj90C1bVanT6
         ZhA10YdCpe7ahi7rbuNNm7mkOAh4WeX32cnEwVOq/DrCjp3k+uNq+caL0UwdUvuZFHBC
         z6myZG4G1hpKbS6XimzHALhmSUiOcMQvlyQefXsa6XAcqxiJy53ErW+BTpU++3qB5HFa
         UlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781749330; x=1782354130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6BhtNKXQbB9g+x/H4y1Xpyn02WNds6Z9fb6W/0gEDz4=;
        b=dIWKUcaLy+WW59N3xAVYdTueZ/5OdNgeMDRjxAjvHPs6Xo2hyG2AWsYFdy5qKYW9MW
         +6axfrfuVMb6fBSstRH/u2E8cjtRz8bhY4hREj2bQdrRRjjCHyNlGMA1hFe2HfvcCmyb
         Dvx38C/VANYUlLOGKdiuS2RCI3CsakbfNq1bReCJV3HybCMC21D6rNlyFK2WZZeOuhsD
         iUcfblm85VQYvU1562CRsm6LzJrbZ4JBSNShfE96bXPJqm1tP/nyrNR4BaALoTZLZ310
         yrsOKfKxZH2hSivRJVk8TNmnQQoSaUgESmlNcByaSE0fM2m1ah75BuiC8ixoNi1yA8wV
         dG5Q==
X-Forwarded-Encrypted: i=1; AFNElJ9TXDt8u5egBMwNICEPWEUCclZQMVgahjnhRvG43JIhUtEtfFkFZZvG/5rJ16pI9q0enjECpSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwzYIMdcpdzlXN+MYsf+ylYraVHHmLYpLaae6D8RoTXEiRed/y
	5Nj/rysylWQsthZkUkIvY9s4Mst63Jo/eTpbDb63C76eV7RpryMdTjzdOWN3O/y4ivqq1HF6kVA
	ce2FaZ5FxRpte5rdxSS/3n/ZymyNGeLY=
X-Gm-Gg: AfdE7ckkviDjqDVjHoqm44YnehW6atgE/HPPGD+53kkZnvKnCeFskFoHSXS2nfos89n
	56IQ6M2mOWN+MkStePICDqFzS3SCxlVcN4YPZIiplUMaHvwpUj0QLuPPkJW2zfXBx3Sg9nlL48g
	uPDFC1Xe/kkrhCGngiMyJL8LA5wTfJeF79l5QlFvsNhdJWlkwTm/Ltuw3lUnr//n24SqY7IK8BY
	w8J37e8JW2/gGHlG2aijB96XPrdXOfOC5WUfD/VRHqYOtKkyMyL8F3g+pGRPZyPgzup6CeAszVj
	UR40aTT82i+V4y5KiEqaStN6t6b0d9+nF2F+XjEVVr0of0lVsKZJsMH2+Co5guAroExpItdqqvG
	2DTghfedXqFBF/6BIizPaPjczl+qxT4cJ+/exaDCdDw40L8XRcGYOtyu8z4mGGzTgiB3kK885A+
	EFj/fmu7R2
X-Received: by 2002:a05:7301:1298:b0:304:cefc:5fd7 with SMTP id
 5a478bee46e88-30bca0edb63mr3334390eec.32.1781749330035; Wed, 17 Jun 2026
 19:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616145523.335696673@linuxfoundation.org> <a937041f-31f6-40b3-83f1-1cac8deb1f50@googlemail.com>
In-Reply-To: <a937041f-31f6-40b3-83f1-1cac8deb1f50@googlemail.com>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Thu, 18 Jun 2026 04:21:56 +0200
X-Gm-Features: AVVi8Cfh5qmuvb8xKYlr8Hjdy0-Qs1PdSrej3d9CtH3-6LxQsVhaqCxNe20N9vo
Message-ID: <CADo9pHjMSqn_FH9vrDVtqUW2iLZFy6CpuLHEfebxzsP8e7urSQ@mail.gmail.com>
Subject: Re: [PATCH 7.1 0/8] 7.1.1-rc1 review
To: Peter Schneider <pschneider1968@googlemail.com>, Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Work on my laptop Dell Latitude 7390 with Intel(R) Core(TM) i5-8350U
CPU @ 1.70GHz and Arch Linux

Tested-by: Luna Jernberg <droidbittin@gmail.com>

Den ons 17 juni 2026 kl 21:55 skrev Peter Schneider
<pschneider1968@googlemail.com>:
>
> Am 16.06.2026 um 16:58 schrieb Greg Kroah-Hartman:
> > This is the start of the stable review cycle for the 7.1.1 release.
> > There are 8 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
>
> Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server.=
 No dmesg oddities or regressions found.
>
> Tested-by: Peter Schneider <pschneider1968@googlemail.com>
>
>
> Beste Gr=C3=BC=C3=9Fe,
> Peter Schneider
>
> --
> Climb the mountain not to plant your flag, but to embrace the challenge,
> enjoy the air and behold the view. Climb it so you can see the world,
> not so the world can see you.                    -- David McCullough Jr.
>
> OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
> Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
> https://keys.mailvelope.com/pks/lookup?op=3Dget&search=3Dpschneider1968@g=
ooglemail.com
> https://keys.mailvelope.com/pks/lookup?op=3Dget&search=3Dpschneider1968@g=
mail.com
>
