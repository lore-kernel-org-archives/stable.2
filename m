Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03592F290A
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724060; cv=pass; b=jUOezjrq/HoSNB2ors9SZP3wdjbopV3SHz2FulhJJTbDMaZltBwoxohhZaBsiSzjpLxa23oQLJK0yCuhif/8/Uw4+fSKDnLVNI8b+Ex23cI6eDNMztIHft3v9CXWlwpDlTMLdCgrTn0T2i6YKJdL7Hhvr6dR7Z/1uP310g5Ljdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724060; c=relaxed/simple;
	bh=pZ1WDIDZlnd78tAWM6ujRUwRrnJmwqrdqQUCDuW1oZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yy/joivCDlr6aL25ab2fKwOkWbQY/MO93lqsNqb5P0ez/HVwQTQK4m9vGnLGNpa9aP+VCbx8c9mjCmSOsEX9XgSh7zPiXDjCFfJOfCLaYxd3793P1thK9tcLkaoqX1aVZ1JuBxwnSdyMz86ouGzmPs2Yjmelc/ADVmrLMFTMmY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=EMqklI0e; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="EMqklI0e"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so8086131a91.2
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 05:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784724059; cv=none;
        d=google.com; s=arc-20260327;
        b=cYd2p/3B/q7BcW0HN0RtGwc0Lgq2b8I/KTeEQSUuBLkKqyyiSGRtJhB3q1usYgOwCK
         0kzXNkl50eoi2Q7V7rpdeiCiU1yANim5jLhhkXWy0ijMdcXsER1PVWBFIvOCeEF5Sevh
         dUkE6Nff/KjRicuV50fdBH52J655bhfedQFAIs1v3Fl1qV9b/amJ0VPiapV/gp2hzpGm
         Bx3qqK1w9l6wH/Rwqp0O/78cOkfZ0cAxll5GmNEAhjXJmBa04xgWWSmRKYTb6jsmtz9+
         WcNGqo3Ty0XxDj/A5uZNIIVmwTH04IrjonCcfMkJCEZ52U6hHccK1+/bRRW7w3c1pRTP
         AU3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kj0y7vGSTuWcIMCDEdm/LDUzje6wFVBCY0Bt2MWRjlU=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=f9HkFpjpCzPjPTfUsGVrbdx/GDFajZneDiVbw17UEX3STC/+Wp2vFRhXlxE7CcRmkB
         yeeOWe06Gsz/aROUmBM5+NyMGi6PmE/Gq3dPrV2c+tTKehn6MEDN8lKEwQMi/kKzSN4i
         CEYs6SjDcgNDqSnQ9Tt/sVmnfsrwQJs9+1j0QHqErqyLRvPgKAd1OhwwwPLpb8FOA12w
         tMfxztJe+8MUDEwcKQq0SWmi0VH40NooyOtC9m1zB/DbgnxO/9lHbmE/pxxXD5C6VmnY
         oH1H+kzmOWRqPgt034PU5gNnChsuXwMl2WPP1V7BdIlLCKpgj2FLUM1or3Aq2EXZWD7W
         27kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1784724059; x=1785328859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kj0y7vGSTuWcIMCDEdm/LDUzje6wFVBCY0Bt2MWRjlU=;
        b=EMqklI0eB2X+IcyWzwoqeG65TdKp11jcz3F7X8w2bmvsEkzQ28hKNvzrP0fFqDCC0u
         BciCmMBpaDBKq09UlI7t4O/vpTSa7cb4xYaKBUcG21bcR1ad1R04of+ZsDhoCDafB7Wv
         OyqGvyx+WyS0mqN0k2bXu2fgTjJZdSwEe0E9MSwze3GMI3S3ZABjWdf7JgjqI8ylO/Zf
         zzeMI3ZbvGTAhice1fS5KIxYbPIuEBIXZcwyocvWb4foU5aVdK079HQGM6HgU0GyqyxZ
         eO7NTzrc7DPH5GTYH7yWAkmYuEdtg6tdeWijygHAFZ8MPzrt+6ZyAF2lxYKRi1Ks4PjC
         JIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784724059; x=1785328859;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kj0y7vGSTuWcIMCDEdm/LDUzje6wFVBCY0Bt2MWRjlU=;
        b=PE+40QmH7Ytu4xE2zyPN3BocAz5m9HY/rMOP2UwiUgQJJPBf2JHApFVDmW16vO4y3Y
         e0x86n1VYThA591D9IW3kBnBuGVrsDxp6wN3taC9vSvXi3tIXli6lx/aou7lNrQuOOvD
         yrgKf+b0x+NiYNmwEd02KIl+1rK7DK4Z8R7TwGyvAWjWdPWOsdGgQ1pk5cYDoF6vfbPR
         Md5l9LCzaYHn8R4Y7VLk0HX0xXFebT3P3/3ZO3Zzh+HZeI5UpOoYvBGtEUnzcjpHRXW4
         YZ5anqctK6NY0tCmmzQ9XAIRZWhsONc0b69mKyfQm4uILNJy0Q7GGyEYOxwca0Mz1dlI
         bm6w==
X-Gm-Message-State: AOJu0Yw6wGwXKtQ936EJQUh0QgVDWXpVcNUKTheXVvW74+RCqBiEdPgk
	4ShU5xo50Hopo1NAoR0+tdYgsQMME5ujCAkLVTDP1dEz4hli//tEJ7AXs8dBgQrnM/eMoEsZkyP
	WG6VrTO2WkWjiY/wghCHYZkIxyPcq06VpPWaZ7dc98A==
X-Gm-Gg: AR+sD10cWDAEpR2EOvK3+wCptK0GIEllqQBiyUJgeElKeG33ZL7U3D1g50W04QN5rDs
	uPDItvpS2jqangPICJsLOn9o9HelbFHA+0SO1j0dSDOfOWYYgWdBxAeE1H8u9oEfNWi8h+quNzu
	2/Jtk0GzSxm1+AfI0mjldHqoU33FA2kl2jyZDGP/qzcuaUDCUh5FGzfKxu8IseKk3DADF3zKbnV
	KIJ+sHOl8Mdpaibd2QeJkorCzApC1e5Vt4kSy4i1+RPIcY0gImk7h2xrP7KSyQ=
X-Received: by 2002:a17:90b:5583:b0:38e:9279:468c with SMTP id
 98e67ed59e1d1-38e92794f00mr7560875a91.25.1784724058833; Wed, 22 Jul 2026
 05:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721152552.646164743@linuxfoundation.org>
In-Reply-To: <20260721152552.646164743@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 22 Jul 2026 21:40:42 +0900
X-Gm-Features: AUfX_mzcdC9Ws3AbYBQOMw16woTbrgc2td07tn2v7gcAQhw0UDcwjcOFa7D-zSo
Message-ID: <CAKL4bV6dCGx_KK=8i7MqXVDPvyjRN6c-rhi2Axum0bOQ-GXLWg@mail.gmail.com>
Subject: Re: [PATCH 7.1 0000/2077] 7.1.5-rc1 review
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

On Wed, Jul 22, 2026 at 12:32=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.1.5 release.
> There are 2077 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 23 Jul 2026 15:23:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.1.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.1.5-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.1.5-rc1rv-g06ed1e6c413d
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.1.1 20260625, GNU ld (GNU
Binutils) 2.46.1) #1 SMP PREEMPT_DYNAMIC Wed Jul 22 21:13:10 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
