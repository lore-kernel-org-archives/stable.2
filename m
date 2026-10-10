Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46012286D5E
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791638968; cv=pass; b=F/ztmGHn2nLuTaMedT0X9eJ3cRYfcNxPfSLyyasMjhixdOKMBb7EGu1JSKwjvjUfP4EsXSzFMn846Kh64T2vmfY3XRxOtkrXI3glNYZwSucAyfBFfiJ/mbur5qBuuIqzjIgwMcnAQWZ5/zLe7P5EDltg0AYlH62LbuQSadiy1z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791638968; c=relaxed/simple;
	bh=0mOLJ1qbIO4bHtL723mklyC/FW/EWWw0glxLKNa5KhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNSlfQBPcwoV3vo1vB9MctDNbISQ1sEWzIqbwDnCF/aOsSoUCwVz/pAviRrYzJI7qrftCwC6JJXk+bB7waL+1M2/GiT3EUdPd8+ksOCOUeY0Gh9Z5UOXLNiBekZQV1k8kEDzVBkGrjTmMCMnZbmj64d/VVFZPQl5hFXS70C/DhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=ai352XnO; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="ai352XnO"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c29c6a3930bso81689066b.3
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 06:29:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791638965; cv=none;
        d=google.com; s=arc-20260327;
        b=QvlcWIuXvrEDuyLn3mTxeQTnu6Z/LLAB3kcnz/by8hqvoTNM90SZmS2O15nDafrUdm
         BKCAJrPKxE67zPbhE1QXEPWrJYQ8x3OsfcgYemQxqJ9UVVJah8n06froX6iRdl90C7kS
         iGCnV4thpVWr6T5RP0ttO21e2+iGH64SG/My1Dn5A/5C7lyne3ABYByas/nx/9pWLI9X
         9d5ieVGtlh0CMIPcZzYSFlhGRheEbWqY0rj9QIE3QBHwc48oKvH3FO4+79vbEVl73Gqj
         wL0Xa8SZEDT8zr+G2P65f84bvukyWQJA9d44LVYeyEi+lkkLRAEsN49Pol6kLa+8umJz
         4GaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6/nHQi/CMAK+j6F/l0YNH4Qaf56yMgapiWA9WJPD8E8=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=D/vAIo67Vu27GGx+zehKVgqIQS4MeoXOWHLRmY070nRWYF3mbrMJ7r8PHdEZpn+HJi
         hbz1JEnvthCkNS18NWdctORaRXv+EbbdVbkeEfK9DWc8/mMr1VosN7ilh+AKU3ottIZ9
         OnWA3nYelYDYB4e5RB7SnEchd23wCLF/Hmdw0qgwge8DywzgYr6QeaaERz0g2Q1Sya3s
         jU3BJlXs5f1XCdbKT+OfwKgFAX2RFDV36i/8hj7lZLSsssh23DsY+LROYROrQ5uVxqzd
         BPF2A+ery86mP2XfgwJi/7LmzNf5x6h458xCh/6nnWNSASwK0L6yZsCh5shJc5+F7oqf
         2Nfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1791638965; x=1792243765; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6/nHQi/CMAK+j6F/l0YNH4Qaf56yMgapiWA9WJPD8E8=;
        b=ai352XnOj9oJad83EhHSowwm2A3/Nku9MCiipuxmkASHamPsdOIzYHxc2Pm0zQpAKR
         ZIkh3ehe98ENou+5jWLJnIpd10hkzIdsKHZNifX2D7qlG6nHEzI1eT8Bqbklk5VFbcHQ
         fUz0T8VPIfrNJgFN3y95ztAJdkTwGhhCjD5XTRiyeNLySFoN2zGKXJfuVWBbHUiiIQx0
         gPWxb/fjjcjo/eNNhMY2Rnuf0qI3FF7pc0N10dE1fEjdc0OwlBpsHyjIZ6lZ1sogHMXT
         /2ly1nHP5e3DyJnn9S3Jz2hwkNpB5ec2yzPMv0yN5GDGtyI4R//6hgC7pqg/8flElwe7
         KYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791638965; x=1792243765;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6/nHQi/CMAK+j6F/l0YNH4Qaf56yMgapiWA9WJPD8E8=;
        b=Rwzrn3kDfZ+Bh5EwyqWcKWhlc4s0P6uLe+ooB4t9v9tYmBTvw8elHRAnnP2mGdoyM7
         w689IJLKpNZ2psKeB+oYJTNXbXtoqBPzKrtl+h/aOjzcviKEDEIjlj1qurF1fMsj8DCV
         Rz1aIvCDscNxQE+PmRXvXsBlGdIyJl0lz/WZ81tPu6XAieAT8QfDh5WeqrTSFPOBklxs
         6lnNQXpRT86tuwNpk68xT6fneOmFWXc8mbST/OqEXic+24Cex2ZjjqWBIa7L1MJ8tOca
         Y1SV/KAbrftDBx6rQktJhdcUlXnMBwzoENFYkmExtiw/T0mUP7HSpn6tckddGy+AteFA
         iavA==
X-Gm-Message-State: AFq9FYJebpZIvTrbMJm3L1Lw+Pj7104AclqwwyGz1LcmpFpdt9gn8dl/
	qPXVxN27ui+TzedHwJFmidwXU+Jm/pngQojZ5EgjOH7iFIpXWAuXG8mw9ebndi9egwdu0rKr/I2
	un5In0FIEcLm1OOB/zF5841Iwo0jHGyFt/MXOYNg4cA==
X-Gm-Gg: AYBFou3DkaoslVnq65Jz34lqYP2hUnyOH3JBpxAK0DsIVxTOyCkMRUqlcHCirQjHpu9
	j94owch5g9J+CQ10c61Nz91WHcGb3imJfKeCEYPC7+qvnMfaICcceF2GkElogNpouHtE2jnAbHZ
	zOWOiLRikb8iMsFUTro3MHGGex8J67LtkBfO4ibQqyEkBa64ZpWysGGGC+/tYpDvMGCcPw/KIso
	8EjIvK2kJ0c2n9nbOOYT3ZuxqaIp1u1fXo9IydorOe3ZbQ92bVwHldBLD9cpobznUemOzzTr4OU
	DYMr6cpjUC2OHWt17ZEqOc7dQbC0+c+mcn6iyEYpa2yqCQW0MIGl4lo=
X-Received: by 2002:a17:907:6e92:b0:c29:6400:ef8e with SMTP id
 a640c23a62f3a-c31aa0098a2mr468624466b.42.1791638965252; Sat, 10 Oct 2026
 06:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009140946.008206689@linuxfoundation.org>
In-Reply-To: <20261009140946.008206689@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 10 Oct 2026 22:29:08 +0900
X-Gm-Features: AclHuK9jyG7nhFSraKVNersbzp_MigR0JEtHr1nx66h6cqyz_SecNiHhQNS9bdk
Message-ID: <CAKL4bV57zkwfGiTzGvK5Ho9AWVJfMamrbzOctPh8RkNKZ3339Q@mail.gmail.com>
Subject: Re: [PATCH 7.2 000/428] 7.2.10-rc1 review
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

On Fri, Oct 9, 2026 at 11:24=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.2.10 release.
> There are 428 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 11 Oct 2026 14:08:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.2.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.2.10-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.2.10-rc1rv-g77b730c57839
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Sat Oct 10 21:48:22 JST 2026

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
