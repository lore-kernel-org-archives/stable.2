Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793012115;
	b=eOAgmk04IzZdF81aXUOWhtEDqQKBoYCNztiPNyHNkBPeHF6NXj6dw0Ed71ybeHxuXLsP
	 x6w0b35hqbkeZLSEJUNwXvqRp1GIL4rvGE/7g/rmCxIXrQB6h/SGs9cbrbq0hpfm7lCyh
	 hV3nZRWaq3cUdA4es8Q+7pM5KyqCbdcXnHpkTkymcCpv7oZ0mcl00fD1wowllVhWpK/xH
	 PmVhyY+ewq4IeiDMQ+iyWT0LPwQYF+nWgCuJk+w3epZvm1AhTKaBWQTMc0LZWpH7t0Uwb
	 Z5Rqeg3iFyisZSPXI1IKcIk/Sj8bG2VHc9aDAg3dpXrzIHl+HYu35blj4Qoh2/rDExQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=DV6c1D/6Qzh64saIkUPZG84ARZMJ/aLNg7R2bPrZljs=;
	b=09OD7kilVOQRQ806970F4h7bAQcFGwgWZjXtjuQnfKoN3B8QA1wr9oQTtkzCH+Sn/cWO
	 ajdltZzE5b6JTElzapU3mo+n8YXaAKcFcsGdtWoxKPrzWkLF92luLRDUd5NarezohXfg0
	 Z7UlAA90UfM7areT2nKM0uzr0hI0PBX/RdvkMmIolD3u6m4y9YSUe/44RwfR7qw154XON
	 MsA5YCdALwdyzGkm2glUVQP/r0JUnUHH3CyqyaWQQg+ozAYERRuvT33GoM056jZ7t9RfO
	 YXmVphl5OFpIBclIgiFfIe69i7j4RqBH3FCcAfe/eK4umT5aY/4xMHVpN4WzMLqeKMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=futuring-girl.com;
	spf=pass smtp.mailfrom=futuring-girl.com;
	dkim=pass header.d=futuring-girl.com header.i=@futuring-girl.com header.a=rsa-sha256 header.s=google header.b=gO9QxkbU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541D7606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 541D7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=futuring-girl.com header.i=@futuring-girl.com header.a=rsa-sha256 header.s=google header.b=gO9QxkbU
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so4069277a12.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 03:55:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793012113; cv=none;
        d=google.com; s=arc-20260327;
        b=g3c9vVV6KnWC56QffEKFV7n0oDkAa7ikdfxM0ZIb7shDqqa6T8MMgCNLT806O7F+8s
         GlaiF27L3CUPfcSubzLi8xcxEkrlYsrvQuB8zHc5WBw6Ew3g+E9AY3EG+zBI8Pk4bBrt
         b7y/f5CnGwphTR98gYIjWQIoTqiFjyjlVUzejMCXUeCQ4K010sV35gUJ5JkYyigJhl2/
         fChjk73hYHYMOfI/Dk8NZT8HPPQWtGTe3RWPkMFcgk5aHmCqixsIAbt97vpfsmgQDJAR
         rk/CVkfjGVupJsHhN9xvOtiC3proSMFfq33IXECStn1Flv+3OOF4zOdGhFFb3NvOEgEK
         w09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DV6c1D/6Qzh64saIkUPZG84ARZMJ/aLNg7R2bPrZljs=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=h5fF45wp0wxbf/f50A/DmnFfPjvMc6xbG+CXMx9jU2mx1ZPioBG5Kvw+e9V6dM9TRY
         KKBtxyCh7COxeDJHhWABEEU6NfnK2gwfm16ULiEZGwA2Qbkeox8cvx6D18Ztyc1+cFWl
         mPc4siu9aVeWKiO8joMyEcTQrvYZ4keshvAwZqtaIg0XLfoq0Rb7hHAbATdH1C86bUEA
         juIidBrmUHcjkgIha4zOpSRvGr5bdhydTMGL/gAUrA8DXrdO+IU4gXVuoVX6lB8EUZvq
         L6iuFv8dyrEF5LzIVFvAJXSWMPkjCI0qjt3u8iqx58k/fVc/9OtFq/ZYfywJcYpc6fT7
         D6sQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1793012113; x=1793616913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DV6c1D/6Qzh64saIkUPZG84ARZMJ/aLNg7R2bPrZljs=;
        b=gO9QxkbUjDQdYzGYuh/z9FIpy587E9986cHZUbsQ95sEOS5Uqbh+txOIwSh9raHGUh
         SwSOSn++ihpEdc7jl3oP+iVComGWMmLfmEiYYRjifbC1jJ3fusu4a5qKSjsefqvrHjSZ
         3wOxpMrV92IaKDVoow2enrr1x1szTpjWj7hMlHV3b35F868CUWpjVLB7F4twuynEJzom
         FzXHuLFID7sUphr3+6jf4rKR7gzfn672s+PGRezC657WH8ApJ64qI1HzRhc6IfyytqfT
         iXaJaLmjn1kxFlVC4E336PekeYq1+sHJ62gfAapcc0kJ8Ydg9fGdhIqpMe35nE12awj4
         RECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793012113; x=1793616913;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DV6c1D/6Qzh64saIkUPZG84ARZMJ/aLNg7R2bPrZljs=;
        b=y2Er5457RHhLmDP+lukS+1Edf9LL0X1n7vaEu78UqkKFE7OiA0QXsC+Z+67vvcgUC6
         Kh6YpjoF2pVoI9dTFal8aPZ3GNuDo9Ce5MS2oqUUsPGwpur8pA4b3x66dHz+pni831ZS
         bd2yVrciFvHdfJGZc6dXL1NWupf1ya2weMBE306D5jPn7oGeQqymLi6MBHtj7xKAizzD
         UHWBEcGUbmxy2DEjBQY9PLonjVOFez5Dun+sMhFoolsPEHexteThb9dP1iX13FdQ/67Z
         l7sKUZk6esPSRmaUjrTpLVgOvBj48ev8UfNQPoRNJKVPkALlljqXdnKndIREbRnwTLur
         YRPQ==
X-Gm-Message-State: AFq9FYJQjTYDt71CsKNXLuWQH7X3yXaz4/D3JUvB3sCZ8okbDRndUyKK
	8hKqaonPqmUueK9YWiOcICvL9TKDmcK8fd8VkqIgiPYKqBXxcWLYGAvSwsAn5dyMTCRtVnQkn1N
	A0dMf/F/J3Tn8GQint0SHB87ZoDPhj2hPht/SvLpkCw==
X-Gm-Gg: AYBFou0MDoKjBa5GrwQ94IVk0xod8OfwSpDFdbqUOO8v9NdcKlNefWgoy7406K7dZ6I
	MMQnj3zn879azK2JjYoUcbNjdlE5sG+lwnwWA6eEgTGZmaLwdySWwxF5cI9wIpk5Ofp+DdIr2iT
	cj7kJFfiRyz9vspKkAD+fQ3M6/yPxSh/6QgVJ+DSu3AaJIVbzfbM9Hu24bNc3xXRIWKpEhNvdFh
	GN7b7YCFdqXrEQFv+M4ZVvo+zJsP+X1wRo2WgwYz2Wwk0ntS3cMnPzjPgEvYeq8SWcxWKa4zrdt
	BMg1pW0z057ngOsb5a9MgeJNkC6RdOh8wOFevDUMEVrxstR+0Qb5D8Mdu1C94H2NyxlChLpHTT6
	3wYCgmtnJe7UYv/ekNKZqghFvaxdn9TsDyz+MQ3OILWaVX/AjXRY+ERLZaWL6F/MHXPSVWFNYnL
	47RYMpytESsBr/y4c=
X-Received: by 2002:a17:907:868c:b0:c2d:c98f:4824 with SMTP id
 a640c23a62f3a-c46bdd91e31mr719992566b.30.1793012112537; Mon, 26 Oct 2026
 03:55:12 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025125805.309934791@linuxfoundation.org>
In-Reply-To: <20261025125805.309934791@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Mon, 26 Oct 2026 19:54:55 +0900
X-Gm-Features: AclHuK8segfbyZOPLnD6APqICZs0xovJLP7DGUxjOh2pTrAodUPaMgSRzdULPng
Message-ID: <CAKL4bV68WauVRiggnG_WNr74+L=RHpaG2L=hr=D3TMn-Ht4YkA@mail.gmail.com>
Subject: Re: [PATCH 7.2 000/231] 7.2.13-rc3 review
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

On Sun, Oct 25, 2026 at 9:59=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.2.13 release.
> There are 231 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 27 Oct 2026 12:57:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.2.13-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.2.13-rc3 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.2.13-rc3rv-g638c94931487
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Mon Oct 26 19:31:51 JST 2026

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
