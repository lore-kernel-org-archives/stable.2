Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED494E73CF
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731841; cv=pass; b=NI7pz5Q08k6G22xa2WbwzLuSE+BkFwrx/Bt95TJ60WXQQOzA3wzzIeUl0i8UL+puvSOjhbur0VNnAVofmtfw3U+4TYT50G139ZWICVCXxwG00Cf/XTMAKc66juv5oPA+8irdfmXHFD6dEHZCmeL8lyoHq8VPSQwDe6pf0KMeyaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731841; c=relaxed/simple;
	bh=7YChWHA/9zL79y+NcFgTh/UhwmYRTNb0NTKwCE5ZPiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtpj5siN/JFwUWVhr4GY0mSzODKO5RM08azOn8Huf8xvIoq17dxsUuwt4PDVqzjTpvX/cNRmLKUYjWLVL8L8HnmpStEULfndGYy/Dt6GTqF0lnR10Z2jBDC5ltUewlVEaq9Yio4qNOe7CnbAVcKn4FdFnpAQwEsbMEElIfPq8xA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=s59GE/IM; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="s59GE/IM"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb796so85127466b.2
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 04:43:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789731837; cv=none;
        d=google.com; s=arc-20260327;
        b=Fqjst9kvWAfOlZO0X+pz8029ocbwVCArJt8inZbh1xxJJRXNqAMJ3sEa9PaKLftZOC
         6V1j50XQJH0wgNQ+sTs2BXRMTzL7p40Hv5kyGyNtPd+DS6WrK2javCXwIEpOeEYwbIN4
         URp3PfXGRKzArnck7hFKpus+G/ZA86u//nmqFe4nDrVkA7awv4JjVMk0BojjbvrXuKtW
         H28PlhdY1im4smA169htHBxOr8O2cUSMUZuZ/1TBlohNZ3ZXVGfXVGZ8qXoaX7Bio1kC
         JLlou3eCRPIdFEKc974WvvuocCzlbCf6v1YUH71XczBW7zyXBW1YpDw3PLsZtptAWEn3
         /M4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dA6vCQLul8Tx4ZGiErd+xrb4iMlZVj0qj1da7dMX2dc=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=dpgZpXDCNWnADBk9qXCXP0ZyLMGIMaCcaKVJ5NRW9ROxukWTA6s6a1WBXIFe52p+pG
         LQBUJE9dQIeYg/2nBk9RNvSb2N0LAILBTC99c1qandgqVsJYa3BvmtFPXEa+L8KfAT2A
         yZTPfnliOjGOzEleCLpKZq+7y2HGY+/Ig40HdJEIeHagwHqdjcdvA7pW2wKgLumbbW97
         6top23tdWUEKq2MRIPl9IDbF1V2pUfwqpEa97rp5x2uNR/FQdmcpiHTUiIFbZ1ZugIU7
         Sr3cGEiXQpXBR+HrLpTgm622jKTX9lA6hlcuvJgzNDqs1U522y72vdLKBFdoO2+QIr+h
         Cv7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1789731837; x=1790336637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dA6vCQLul8Tx4ZGiErd+xrb4iMlZVj0qj1da7dMX2dc=;
        b=s59GE/IMjZMml4lH3UIQsPnVnyW1/VfJi1460mzb18VOnjlX0b3Tvf3HBnOfdQa2yR
         iKTONSyNujv65B54HMS9koiMwvsDFPh3K2OorV0YKTxFJgVH8vamlxpeKCRVjHZPI8X5
         Ly5M9HMZlu3fuWt6hY5cw3fbiQqBHdh0HXRvJkqGDP6/QNeZGhK8v21cAuS4sfXLiP5+
         HkDCEhsOPtjAH/zMS65kGZHXn/Fow+mYtF/GwBwcYduTG7cQRMtY0yGFpZIInuGQCGhY
         c/JRj9PoUwFC5OW3e76C/mf6hC+exiFaLiH5k/i30pM4Ro5GWaXr9R60jL95JXGgydRj
         j9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789731837; x=1790336637;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dA6vCQLul8Tx4ZGiErd+xrb4iMlZVj0qj1da7dMX2dc=;
        b=sy/PzRjl1MNysu8R+J3oy437ZDNlc6wM78GWCBJtqnJN5aoJwPUeWVVJ35sFT+LM7A
         0G5qhR8YRLU3DW2W9Ml3GEu3pPRgEvhu55uDHzlQqrplZ6XI28M/qYNVo5Wq4dlqjcBn
         20XTbyilqfCl75w0g4jMvMicdm2QPZzjdr8T+8L5mqgmycKVLDODIM4ePqS6jqep6GRN
         oCYAFJrH5syf3gZw8qdWuEHuie8MOvRIQSh8ejCGbzZSRobqC/AO49Dww7C68T0aYsuk
         28FlHrplWY/fXmDEGCQMMBxlpbO3HE5Px9fyhGnCLTfNeYS4dkxhAn7jZypaEzneYL5a
         JIDg==
X-Gm-Message-State: AFuF++nd6wT0JUWA9b/ewwkkXAX5Jkb0WjxhQtOyj4nrRqmN9llhxguW
	EXIU2v4zFMHeDDNwNYgidgHZefzWu6i7pHaTYgkb7Xk80b19bacCxWWY0NCvXxL33jCCv+07pJM
	MqU3r5KdmYtxmuHtNQ/ktiaOJY24rHhP23Dve2rHbMA==
X-Gm-Gg: AYBFou1WwjuO9reWgiZzQGUXhWk2fq45IcOu61DjnSHe8qQYht6/2RLyAM1RlYsYcm1
	EQybjKSZ7da1pSONx2dCMraFTJSRA3k6I8tU6ZQjY3a+3HVRfxUbinDe1dgcxwZCJetzrv2/owB
	JiaM+MlrV8UEaVSkxzQPpwo+QuHA8fRrjlNddeMZlaxCC2JeFZX8cWgo1G1uw4kdcPEBDVbT4n3
	2cr6PlTovviO8TLme0c2YDeLIU2wsWsAvDc5OWj1FTb3zinTnenfmZwS1yattft0jAt3t19Z8rl
	A/VoldTKntydts0zBslWmVSbNihMjze8XOZqC62Djcs+8LYbFqnLBcjXtw==
X-Received: by 2002:a17:906:9f96:b0:c29:dd71:7521 with SMTP id
 a640c23a62f3a-c2a159ad211mr257665166b.13.1789731837170; Fri, 18 Sep 2026
 04:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917151350.597953846@linuxfoundation.org>
In-Reply-To: <20260917151350.597953846@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 18 Sep 2026 20:43:40 +0900
X-Gm-Features: AcwNN1V6GXuA7B8FEhCBQCqFU7EygjeCV0Wpnd9XyhRDhPC2vNktE2fyei7DI0M
Message-ID: <CAKL4bV7ZN6mZMySE5tAwDwPEAYaXu5Bx3dQc-gieRheB8vGJXA@mail.gmail.com>
Subject: Re: [PATCH 7.2 000/733] 7.2.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Fri, Sep 18, 2026 at 12:35=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.2.7 release.
> There are 733 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 19 Sep 2026 15:12:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.2.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.2.7-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.2.7-rc1rv-gb4c9ab9b68c7
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Fri Sep 18 19:56:17 JST 2026

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
