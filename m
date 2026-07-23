Received: from mail-ed2-f1.google.com (mail-ed2-f1.google.com [74.125.228.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14CB40B0F5
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796079; cv=none; b=iOuG3i5Zfo9H8K9FuSMvQH9ICHXROdu+5ABsnkz8pPS2xOLqwwDcHBIydlR6cE1J4KDY3vJ+p+/C6DK83frqXtHTWc6XF0RhkPUHUD0UgfTgNd205VNqxRXeqi/mbntb5+OObPpn/AD0WhVS8fuu0UZrqTxw0yLSEa8ImHIOOkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796079; c=relaxed/simple;
	bh=whGXzWRNyGUg9lALJflckiWEWTI5YxH/v3DKwvNZY+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SL/YBvsWBdPR+QG4Q4ISjwQe+CRi++ikGlT+Gqclr/z7QmDDP0ozJXFMPgBxNF41t8gkQJxYJdzAg7SmtgM4pp6ml901u5hBKWJhABsHw4+JZZgm0xDEy/hVKwxuYm1gTB/BJdjDiKsMgpx2NKNSYz3qbAnkXdwxq8PHhY5b+YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PKYXcORw; arc=none smtp.client-ip=74.125.228.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PKYXcORw"
Received: by mail-ed2-f1.google.com with SMTP id 4fb4d7f45d1cf-69850336c9cso214838a12.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 01:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784796076; x=1785400876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9fU44YJ6f6IUeZhmcIZ8UM5Hqjq3iEIvk9gqEu2Ui2A=;
        b=PKYXcORwEwhHEDNoHmzszRbjfv9JfIBN2cMwlxOAO97dO2G1+5k7+F8ib22hFFii8s
         5lpD7wnoa6GmHXxh+cUDdefNkr85rLXa/gR+ikduz68zrc6nyzDi1tDb6GiQKG9TT1/D
         4V3oOabh1Bf1hjrGNFCVFa2QIaGEXOsQzEN2r7Vnil2FyigYqOJSN6hj45udL0oIqjlW
         D49FSKLsYvkBeDyIJsru1ZytkGxP+CZNVF3hOQvg8u4CY/ZRPdQFLfPQf/STo1XD0uBe
         21uFeuNVaJWLxkm1qQN05bI5E5bI0bKTkuwyZueHUevJ1bhI17mn0bxA5mrbMINwmmFs
         OE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784796076; x=1785400876;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9fU44YJ6f6IUeZhmcIZ8UM5Hqjq3iEIvk9gqEu2Ui2A=;
        b=QOdEwiA+aBUyeO5ETyrLz5u4zseQ9mjIdIc/c6GsS5F8QaWQLBlpq8B5nYE33+aqcr
         b1/onJ3ehXZABKfxrOoXrhtZwp4QN6yL4Bklk/q56rtffkrQQxxEjsUAngOa0MyhPKyr
         OoMS1D2U5iks8hnn0n7t5XRTjPAfr8BXnUAZr9H3QDH4nZQWNIYJ3+nr5nrgO9/OnDIo
         WeLPa+FfxRIEkuLO/XFWc8ULPOMscSsjt8sxDXMgFigAf0ZGPAIgMwSDGvALG5SEuSXo
         pnjpJ6/Sdx52+7y2UX8UR7CM5mEUoYLrzY2CDdh6yBaAZpjPv7N6SZN8m47O/flE+Xzy
         oIcQ==
X-Gm-Message-State: AOJu0Yx2Ncf0gmH7Uq5u7TIzl6Tlyooqcb29NCTG6czbG4jXQKDTMKIM
	9Hu/UX2yjCkvrWPYM80cJ5+I2W1tI4S0MOtYdN1FQrlrHZbZ+5Jtda3mG8y/vrVZveg=
X-Gm-Gg: AR+sD11W4ejsEXbzYuvk1Drkvl4QHHlFKvOJPBPW14uRivuq466XtQmYMU4O9vCTl1+
	Ak1ecPE4+21jLb+RshCZDHPHz1lehIlfCtMhDagGzKdsDKhhgUqeyQhSl+WYcvTUWMLycsGmYSo
	YyMR/7KBeBvlBeYuFi0flg/jck9GzDk43q2dLpE02ky4qajXpsasDsrPqFI5cyt98lH08plx93W
	c+fQtI25BRLFBPJ0kY0PDrOcXTg1CLuQIl9ZcI7lJNiywXkmxg64xfMkfmzjFkbWTMuYbACMKkH
	PdHfPvcGzo8VTR+r2KQgGCrrWYRY0rN4Z3sseLXkGOePVJ8rrpXgcbMY+sWTzac0mLsCZuQC8oW
	gSC3AKLhEjaYkSIjc2+zPbTiYnDvV8xc1jlpLfBFEAAR3j1QJAxhjbOQoBMKKYh38QmIvnZl8/5
	8DDiIQrB6og2ZzPL1yKXaub6BAgT8XfQ==
X-Received: by 2002:a17:907:7b97:b0:c19:8408:5b54 with SMTP id a640c23a62f3a-c1c509e2830mr99412466b.60.1784796074695;
        Thu, 23 Jul 2026 01:41:14 -0700 (PDT)
Received: from u94a (27-53-97-40.adsl.fetnet.net. [27.53.97.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e6203sm30558485ad.44.2026.07.23.01.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 01:41:13 -0700 (PDT)
Date: Thu, 23 Jul 2026 16:41:05 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 0000/1202] 6.12.97-rc2 review
Message-ID: <amHTSIFxcb48ADsa@u94a>
References: <20260722142834.868902312@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722142834.868902312@linuxfoundation.org>

On Wed, Jul 22, 2026 at 04:31:38PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.97 release.
> There are 1202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Jul 2026 14:26:57 +0000.
> Anything received after that time might be too late.

BPF selftests compilation is currently broken. But with [1] applied it
will build, with test_progs, test_progs-no_alu32, test_progs-cpuv4,
test_maps, test_verifier in BPF selftests all passes[2] on x86_64 and
aarch64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://lore.kernel.org/stable/20260723071334.39630-1-shung-hsi.yu@suse.com/
2: https://github.com/kernel-patches/linux-stable/actions/runs/29986297264

[...]
