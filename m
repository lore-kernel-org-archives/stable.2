Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18C023D2B1
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 01:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791681967; cv=pass; b=umc6ZwL4fXr8xNxsUYt6JCz+bNfLCLco2DnYRYPgqTJC+6TBlDyHHUwCFYRfnaIyWjTg8LZyh8O3cMKWP/x95DPmPohrgRFuTYBMxaQZxCokDXH/hkBOQh59CquQxjYF1SVqz4d+vY3g28Y+vZQMRMTq4QbI3fFBJ13czBNu48k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791681967; c=relaxed/simple;
	bh=4AOaTpaQq8Voh+cFkgg8oIDZlCp2f1Lf+Q3dWmXSF0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wo3NSQoChLSz/ANzIVGpxNlhl6BlsaaVK7N8eu+u8/T4uWmXm832OkkV+1dwhq6eDjx3l6rX+jkv8AbmW6x2jVzGeIxTMS7lgLpEA5XgujGwLbi70WOjNkvFgO3sKCPTkU3Syy9PVYKwdGgsR4k6eMz7sxa36+kUKC6VEtYXNSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=PPEEsLtD; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="PPEEsLtD"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-677c9e8ddb2so716025d50.2
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 18:26:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791681965; cv=none;
        d=google.com; s=arc-20260327;
        b=MfeHPMDRGKxJ07hCT+zvLHtd8m1X1bjSbReooLj7l7P8aKVejkbQz+kQkEhdtoBr/F
         ifW3wy+knbtxFczP4iCp+wJqqtvOBBTdotI/Fd1ampn19emF5+/p+0fA/Bocx65VfyhI
         riuY6arnfK8EuPBzlOULaw2UrYmH7Y6AyYQTK9+qZ18WrvxF1hhfJ4ebD8Uxb0COFgyx
         9O/yo5rUjDIllCzJw+Q/DumoYfohVPudhulxGsMQPdUJ9TBBXNTePRzejRMIkK9wAmdz
         76WjrvZWl0iWLAyQZhULtUcpHcQIpjVdTrnv7zLEdN2PbXQ+vDGe5kLPNO+D1kME50J4
         8Wiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z9yH2y3goTIlD1nGF+P4iDsFdwyaI9RVJU1CXJC3Tro=;
        fh=e7ggA/XE3PM0jnbsK1PyHaZymhGI04QauLNqJmdOFn4=;
        b=T5z7soqRW0oyq9HHvudEzQqA8JT/ZojRzSpSM9+uWsBxDQnTfwS7faC5KxDQH36z36
         nf7NC13wc5ZU/pXzv/GqjDofKx4BnlwuiQ1BIvPs0J/BirRkItK/3BU6IJ1fW51qZVwQ
         hHvPrYBFzqG3AB6wfpQAXjfrEx/V6ZARJMuorw41jOrcuGU8IxezmSdibG+21N/UqL5s
         L2hbuovljALSSVRvKq5cYwsx4lStOCVClMql8kYjoEgxVwu2SND/qi5P7XBsay5iCgqn
         DeV86ljIMBdqA1WDkAL3y4ifCeyQGjDsG5JgP/PPmLozeQ6EczADV1m1BtW6uFN+Cjcx
         oaYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1791681965; x=1792286765; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z9yH2y3goTIlD1nGF+P4iDsFdwyaI9RVJU1CXJC3Tro=;
        b=PPEEsLtDEYS1NxjCSgifjcobz2w2XdEVyzCziATjOsK9KoMWGiaeJNjZEl6OFFnB72
         jTOY1r/T3ZUGVve+WE6eTjle03pWL9prtucEQdRcnj5nrCs1MWQgVF2ZV45wfy5uQW4e
         APRLU1LW7ly35vjkJUnEjXsee4WEvO8g8zGi81biHckJHLJhdo2L+bNUwsx0ivEzBQBB
         x18MLZNe9j/sleqa0pM7SO6ezp35HjK2MEwTyAcsVX6mCkGxGUU0Xq8h93cTwGSKkwwY
         rHuQogj9GsK0UI2LoiQfWOxsLx5T4/LbPOIpF94Skph90SVxAoh0r7duPo5OV2jSADNy
         osXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791681965; x=1792286765;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z9yH2y3goTIlD1nGF+P4iDsFdwyaI9RVJU1CXJC3Tro=;
        b=QZ7QQA35hNXWLB7h0syiadokGr2NRFV4a39Fppe1wF+6aZ6ee7BP+3rMFECqp3Afyf
         Z7GIPYB76KNu5KCrEbwN/JjhWfLmEq6u6E3izxRRxQKaaIoZRAEuz6dTgqZKHIaNKNM7
         0u/nk/aX4uG3wjh/XRdQiAfXkgByAjXTxR0WBjymvW8BqgDkGcUESt5ZWmxVedtePz3d
         jUOJN25fwMJvuOAhzJue6cc/C/a8wsuTYiDMBkc1CJ8s8tMawBvoN9yCxVV5j0jPRwRh
         7d9KjxBg1GaJKLLKZKgU/JloMZaifVR9GF78aOn8Cz7T0UulhkhenhUoxz35vCIzhqFs
         eS2g==
X-Gm-Message-State: AFq9FYIPA08Vb5mWPF66riDONKqAVgduTcXnZ4v8oES0qUMc7TCTTv3f
	ZF1IsAPAugqNvxv5NIa/tFRYbC7TS/bUi5EWcOIEx5w7NtCtrkgq8m7AJdeK32+fglpW160LxTL
	IoeEF6yRWT8MlTqqH6DN+ZbraZa/vRvecMfQfE/P26poMEyaqcDE2xlc+r1wf5hsAkpFv5HZiQQ
	t4k92duCrD3vZzS02mw2aRETrPdEY=
X-Gm-Gg: AYBFou2VZ9rdEzhDp9zRoqKTRntDFZMwcJFhzz6s7SOROrQik/56T5a9eu+/jYQHlM8
	H6R+xmE/vLz37EqId+jwqgRTFwVtX9XwBOvL+/q3UOHk099NnM1z3UcoejDs4CESklmxECobEbd
	oi/VkqjDarr2NSd1Tj4wuBsS4K828BewxUp2OjxmVrdOnAKvVFnVLpLv0zAMoT1b5hO1dP30WLj
	xrBJDVstP/T1I/odcCZKCDPc2eMOI2SclqsIIAb4gT7t9U3VJOgDMw2CghmxxoO3OBKg+V6SXcQ
	hkMXWSSVlnfW6btthWRVmiVleZS1RPzv0lxoudNQlPV8427wqNnCOsScdKNkJgJ8lBBvNGOJuaL
	ihHpKibwSUZQ=
X-Received: by 2002:a05:690e:150d:b0:674:a7b:a07e with SMTP id
 956f58d0204a3-679362715a8mr1849655d50.29.1791681964629; Sat, 10 Oct 2026
 18:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009140946.008206689@linuxfoundation.org>
In-Reply-To: <20261009140946.008206689@linuxfoundation.org>
From: Slade Watkins <sr@sladewatkins.com>
Date: Sat, 10 Oct 2026 21:25:53 -0400
X-Gm-Features: AclHuK-mPjRKtEOxbIaB0PCNQlzkgcurHHS9ajfoSxGLwQ46ONA1zvOrJKTSiuM
Message-ID: <CAMC4fzKGfW=zuJYCYjh-i5Z7_1568SSB4k=HGWP2ObLfzsJyug@mail.gmail.com>
Subject: Re: [PATCH 7.2 000/428] 7.2.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rogueport-AntispamServ: glowwhale.rogueportmedia.com
X-Rogueport-AntispamVer: Reporting (SpamAssassin 4.0.2-sladew)

On Fri, Oct 9, 2026 at 10:14=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.2.10 release.
> There are 428 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 11 Oct 2026 14:08:23 +0000.
> Anything received after that time might be too late.

Hi Greg,

7.2.10-rc1 built and run on my aarch64 test system. No errors or regression=
s.

Tested-by: Slade Watkins <sr@sladewatkins.com>

Cheers,
Slade
