Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6103D092F
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084324; cv=pass; b=SFLmPqdM5gDB2VUTDi65wOa4xV+Cc5sqCoLlgW5wOek1caWqco+ZyVXYudNTP+uTK63CO7hUlMi7qDy6W0/B+i590Bo/09ub18tI66FfcyjbT6BOsExS/S+sB5XcHr6F7tlItIYzXAhCg3RoKvyr8JgVl8FA1z3r5l/FwpduqXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084324; c=relaxed/simple;
	bh=BZ2c/iqj6Fnv5DHCt4xFCrkQIdu6CJdZKHyHErvXts4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeoOonvbwczBOBcMEEaYEm02QLIdPDfzhedv9juEraWO15CwtIvkl4SBcZcP7ifxc9B8ao/onSm2sBJNQGD7zWPlptRC58B14kKXJCu8HwBDHe8yR8pLM0oNSNKFTIDpMpoAP3WEWlMMcHUeRRiYvNozv42sD5h5C0ocyX6T59M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=FXk9fmaY; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="FXk9fmaY"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2caea3f742bso2891425ad.0
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 06:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783084322; cv=none;
        d=google.com; s=arc-20260327;
        b=IW5UPinu8qQsWdAYi8PisdYDAvtynTWINrQ7ChclR+SEckPZR7QVY7kgJhCnKjZiUQ
         LOkEf83N2icD36U8/2tCgbYNrJUerwjQLJ6o665mjQlA49BmxDQtQWYwB86vdnd7PZGo
         Yyl0ufQPdT9cDWeyl4KIBMJncSNVC4yr/jscKVuyFjZ4GAgLDhLYn9zGke7nhRBQTJd9
         COkOQkjJc5V3iHnb/2yqwVAkmv2e7de3VQPhtAx/o+/vJwBEzcqYXPxp5Bu4gAnpT37A
         wlATbtlGNL+KHjRrRyP7oDOl4yrJwGs/2VilJgfu9ew6Qru5JIdxBiyiixnlRfJfCDXn
         sTtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X8lFHiTICcGdDsPowE7kwVw6KbJBWR6drjVQi7KGbu4=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=bOSYWtcUh9LuSZRHUOmJaht6Vv5nuPHIKZINxgdWROPo/5tMUfutOCwlVNyZicQNR9
         RKJ70o+lLZjnUF9x0avYm1z4i1OPiSXbu8ThrIg4sEvLTszIAw75iFdBiInIIQ09y/4b
         HRlhqJq36x5u5rjYjuCsBgN1SQulkr/q7OHvS8VvKGtKwByi7hpfaZe5nUixfpYnXb/E
         TE/oVDTvyZ3hV7sJef6N77oLkYpdSAjhSoBBSbccqKLypAaWhNFTd4Ur4IQ+I4VhP+NR
         8sGQDaFYS6NTvS4ka11EOjcRtq7LyStyYZgmh58j/A8a8imNi/ySkiR592RizcjtAr4Z
         V6rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1783084322; x=1783689122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8lFHiTICcGdDsPowE7kwVw6KbJBWR6drjVQi7KGbu4=;
        b=FXk9fmaYP2BnHkikIYr7tfH/WFAU5GERIb78x6Zfl9hANw3di+Fj6astqCqVwnf0Av
         e6sUxDQQYiGYBFw9Lqz2BvXTIXaSubIB7zSxYWtoP/7n2aI1hkegJ9ORnZjVKif8pEjF
         HYgIfR55mVPUOFHXB6d+ymu26/BY7A8zF+KS0U/iJMdv46STDB8nAk/KY7R8ucvD+V7R
         IZvDlLYjgJUxPzovbfRP8PqrEi5US3cJv4Ixw29G7+EFg7RWRJDmrrbj6ZaCrmFfLl6q
         emFID61ndBkIQZOB6BRRLs2eI4uwfeFFv6Z/3c4oBG0/AsYau1NVtRqPr8Eboo7IyEun
         RmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783084322; x=1783689122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X8lFHiTICcGdDsPowE7kwVw6KbJBWR6drjVQi7KGbu4=;
        b=FWvRiJPQ/mYEfAbQzm3qAhsYXtW0Xa3qlDs7r1LcDrYWaZoxbBppvVJOhomMrCf8vG
         yisvMHskZzXdzHGsK6e8N2SssdpBwgKHLPoci0pHKKZa7mMxcWWrWA8yguJA3wnbG0mR
         y9I0AJLktChpwLn43YtdBrMtFOsw6vsjmbOeh2sCK5KVSZAya14S8UHRGFsLv8YxRgft
         FUF2IBSa0WbgMgMd5DhiwKziqemu8oz7meMtdfVE3e5SkqOheNGoGpKnQyylt6z7GigD
         pExdspF3qfvj5qNub0V77C1CWdEVd/RgKbOWfhNMjPolE+edzJy4Hz04nQZg8x7SuPAN
         50pg==
X-Gm-Message-State: AOJu0Ywo36jcnxFyGVqts4J/kXgHWSdRVkp4WJsK+jDOdtqLT0HI+8hz
	G7phJy3oQEYAZABEjTpCGJbvO7rCmu6X2C4OLt7m1An6chFeIcnd+Ef6Kyi9UrMii9El35vT27J
	uqgApnTomAMvH3pojlIKk1rDkvba61PIz0a0XLbQ1Mw==
X-Gm-Gg: AfdE7ckCVI7rearw80Ziac246f6tCXYhoryQxjpJx9KRaetTU6zEJNvfesSfbcA502l
	24mcEiHsVTPybl+k2VfSpDb3W0HvIhrw8BJn3gAW5yJByPouLibprY4GociHoYZ7/fxlEZw7IWx
	lHjHQCm3pqIj2gT+fv5LL18KroCWMQLlrRZ8s8AR2DpI6mVdt/M8b4V9Z0JvW5lWTyOL3Qq39LZ
	eeG5vJUMUNAVb9MyRl7M2do/E/XBs93sBLmXGfeuhNA97QVc3ycOUR8k8aT2zQFV3GOVIzU5tgD
	dNMPjkjTDKNAfFbk2so1EAK+Wqgveg==
X-Received: by 2002:a17:903:28f:b0:2ca:4b7a:4a02 with SMTP id
 d9443c01a7336-2ca7e8c7cf2mr112714405ad.43.1783084322026; Fri, 03 Jul 2026
 06:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703072822.817328079@linuxfoundation.org>
In-Reply-To: <20260703072822.817328079@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 3 Jul 2026 22:11:44 +0900
X-Gm-Features: AVVi8Ce2RGM5T3Pwi8q1vaGDUDYf0lIKTSVCyW91KIzXyuDigHkXVvd2rgHcDD4
Message-ID: <CAKL4bV6CGp9+uzndeOmJtpOsda_iAp6Cpavdv6fXC1Ek3GWsYg@mail.gmail.com>
Subject: Re: [PATCH 7.1 000/121] 7.1.3-rc2 review
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

On Fri, Jul 3, 2026 at 4:38=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.1.3 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Jul 2026 07:28:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.1.3-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.1.3-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.1.3-rc2rv-g19dde9778fd8
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.1.1 20260625, GNU ld (GNU
Binutils) 2.46.1) #1 SMP PREEMPT_DYNAMIC Fri Jul  3 21:35:42 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
