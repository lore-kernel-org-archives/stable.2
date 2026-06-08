Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC83C3AE6E4
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955604; cv=none; b=P9ChjsYb/wPiMNmKGhYXWAZ0iCQQX9H83GWLFLAVgEf27VYL4Ijk5MGvAWxposEyAdf8Xd2gbzJSn2DDy3dW9RwDPsB/gZQBpagCFSSipXyScze1SCXs3ObcBUm6J3IzHlYhc3GAWK1WruD5r8hv6eBjC1SZ4MAQJ/YOJxAatS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955604; c=relaxed/simple;
	bh=Juxb26ldXOFarDgZU/fCdttEflHVZH3q1oRndyT2/q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5SzvBlO8IAVVoRfRm8D2qPJbD/HayV7Q37THCLUzOQeIq8quyIhaqUtIVEwxnfJQuHNvU0lWTA9jzSxEbw7YTilIABdkI7DpLFWWvFxq7jAX0FQLe6n3TPLjOD0s+b93Sy2iUpTwtJedzode8J4oDPaorpz8XFFOm3+9UknRdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=VBBGdN+i; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="VBBGdN+i"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1363fe80fe8so6946580c88.0
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 14:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1780955602; x=1781560402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EoYFOw7ak7HsB04OfAmg+EGUR7pul8Hb3G9gCGfENs8=;
        b=VBBGdN+ieSsCAA6S5YFUy3vtLcqZncO798VuMsGYGUNCprcX5JLqVwMX1fYGci73XZ
         ogwfiBcW/cuJES0QCINF5uGvycxYjFcowylYa5ng2B93VQG1UXwkai4LOQ/t22J6xpZ/
         Bnh+emDnRW1jlouBeLOgOB1LGf6jbMTR4+X3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780955602; x=1781560402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EoYFOw7ak7HsB04OfAmg+EGUR7pul8Hb3G9gCGfENs8=;
        b=D3haaVxndvhhDAgHliTKiFZ1P3Wq2e7Zyb8dctdOvoh5zrZIV5NbFtTYsJRg3aGVHW
         fbO9zMI+FNuFd/NZmUQFY0rSrhRWiGUL7ZHQ7y0KxNelryQZWYHlDWYhsB4ZxZLQRuhj
         WoW+DEQ67b+Y8+4S8esvOsCnJEoTfJRw+du4bi6OvQUlWfRqbUzCmOAZ+xUILCCHReR2
         vrml5w6300fcPFzPdM1bbnWsr9MjXrzrCW98eZRNx9ALtN1nrxli4RasFjmCoT+LDaVQ
         1NqG8ZN+hEug0XJt78jGch+a09VVOltU4IbOm0t5JFC++ArBnA/u+9XRETjs+r70uYFn
         zhsg==
X-Gm-Message-State: AOJu0Yya+v1rVYAXpdo1zAS1U5R6tiICtwOrvLKzO2lSw2hykzGqUqct
	pTZxokFkyjuRAljR7HaO+lpJ7b88COXmDYMTJT7dB1L/elvdqfEQzsIk6TvCK0U1WA==
X-Gm-Gg: Acq92OHgK2lnB3/lfoLOmnWa+GT2xhQ0knMPQ8DlOO34FeqUd+tlEjijLe4dcVB4NGJ
	HvK27/80U9Lj1pNq62akR7st63SQV6RKPdVdHB/c/QVZzyYVgsAETMys3fKa8C5qx0RMLyk0miw
	KcgR1SutjsSMvEif3ss8SpHbrVsZuIVs+9a4LhkdkJpoKifZuxiJEYxVuZ3B0WxL5/fHitY7oWe
	obsJ2b5WntZ5BJvpns/CuhapkckdaCT/GeX/unaYm7wtvOFtZWnCposEjA6bz5A2+Bb6H6sB98r
	jkS1HlDnlK8QMcIefNfgHGMctjAsa7l5DQhdgku/qLXQXdI64iE/pfFyGWPl/XGhb643sUEZVQR
	bRgaFlhjDh6UtRA8iIxkIX080fAfANxEQtLf6msStrGMJYswPvR0oahVE/C4YfiBGzmof8GZzkA
	yA/o0+FgaBZ4VW+fShylEqi+Oq4qSv41YKtq1WpYnRTpgVLc2pQBIa
X-Received: by 2002:a05:7300:2327:b0:304:5db8:da95 with SMTP id 5a478bee46e88-3077b7855c1mr9162330eec.23.1780955601933;
        Mon, 08 Jun 2026 14:53:21 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.105.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db528dcsm22171093eec.3.2026.06.08.14.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:53:20 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 8 Jun 2026 15:53:17 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 7.0 000/332] 7.0.12-rc1 review
Message-ID: <aic5zUJBp3i6jCin@fedora64.linuxtx.org>
References: <20260607095728.031258202@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>

On Sun, Jun 07, 2026 at 11:56:09AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.12 release.
> There are 332 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Jun 2026 09:56:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
