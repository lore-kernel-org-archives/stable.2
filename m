Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F0346D2C1
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042068; cv=pass; b=FR5yuxNGDrKd1VdSiuq/Rt96voitumYurmZxRz0Z+NMWahSFM66zDGEES2nG4m4IqzpX5Crbwv2puPNftMtAxms/LBgKlGjomI5aDz8SWDKDdTDI8KFj63HggpaFHKzYB/l9vJXaGlBqf+5prNry/oZkDJ4rqe+22Gn3lEazobw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042068; c=relaxed/simple;
	bh=tSzuqoYB9TXawK7iVxpqBGLCSAEWlfbPZXo1ULqmVg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJUTSeY5uwVamPq2KhqNpiA9//jXrGlPcr6Z3v+72JQYb6e69om92XbIjdhGN4FQHHKyu0ltH70OxIKYXvWNGzW/ygapyU4uMjwkn88IV9s6tddlpiNGw3osTFKQ3PGhFowGi4bQ2EkCBjV62qTt1nt4YCaNwQLJGG80wA7O4Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEZJ7RxE; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEZJ7RxE"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b6188a2c0eso885544e87.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 05:07:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789042064; cv=none;
        d=google.com; s=arc-20260327;
        b=DTlZUf49FsLU1ZwJhXueR3/ZgaiGhPKlSQxbef+UAj8Ni4kuBzury+nd7gcBHIkDTN
         qwrElotWBCxThznT9G4OL4HO6oGrfYvsjptBeGnRScD/lFa+3E5HqQAOerEc+dRKJ4Rk
         ljZEZHt39xaEV+4pAz/RY1NsV8YLxQmlOg19qx2CYc90CD5UXmKjWNx/TN9Zdcu5xGO5
         emAAwglcSSWhl8CA+onfgvxjG5bXdQcAkT/bfNqGjy7mXX98a5hR9JeCAiJGqcQKxH8w
         C1vAAv/QGPTjD20C7gRsKSGwddZPZFgW4bwuHrDJPy6BoKCyGk60zFsAehd919rvF2Dj
         vCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/nSVcwff+CVcVUGrv8pukezXki6t7yHP2l4nc4EnAh4=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=I66nxjCFYG0W9JiChvwk58hbarj7O138u0nWUrExKZUTu4OjjSEvBTgS8hhRIgOl5Q
         IQkx8c/gg9qm3cDG5b5pdywCgLZLnX+ppiVcQXMoI7dc/bak63JSAI+S+wwy/odBH5k7
         WJgaiJUn6rT+og5l1Y0yibY8bF0IQFpDxR48t66t/iCqX1d4Tk6WhMIX+dqQMrTAanzg
         ZB9IHRCqGAtOlS7lliHpxBZLJFTCD4GFijFFJ3LCn5WRTwMGsZpx4U387KOmSTX8X8Sl
         y6OGDedHLIhb+EcP0vV3uirWF2d/Vaaci5d8jVc9inxOvARXOlttDhsZ0aliJeT3oIHj
         pCDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789042064; x=1789646864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/nSVcwff+CVcVUGrv8pukezXki6t7yHP2l4nc4EnAh4=;
        b=PEZJ7RxEjMNv/tPHD5CtnOhfntcTrmL2Y/VEpmM7XeGisRFdGXOSjK9e2PXN46eLzJ
         uMhJAIEcMhevU5NwZwWmI1vWLPoX+ayOyY1jWVXEUEBB7OrbD46D/vg6DJgN9aX1r23x
         ZNz7m90jpOX4bIkYCQuYXtJEVb2vLfheS4XDteLVELEPwVvu0v/uzevTRBoUHXInGjjR
         VFPcI9BFexevmZ4JXMxBuozraZrRnUSQSyzc4v0ZLQNYOSg/L/p/MRBBDUx4mTHr/iRm
         gM1gEWYHYQ2AdoDfjDhupZlyRrIMi4Fuzu5h2TiDchtPdcIYH5cOShNqybw6BDoN+gu0
         TQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789042064; x=1789646864;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/nSVcwff+CVcVUGrv8pukezXki6t7yHP2l4nc4EnAh4=;
        b=p0iDw6eNZVKm6KLu7gte/ixelkS0yX2+fsY5KrUFt1LeKfzElBPTQnYg5u+MGK8He9
         xD97xZD4burmgmSYYmhJ7JF9KIrXIZl/7GogLpdKofnuhdfo9S0M9/ZMSDRxaOCPmHBg
         7Wy8e/yV/nGsU/r3JvvB2S3JPJ6dIA+oE2Ds6/c1vbHwymex/sO3uLLLCjBZU68woUq+
         An0K4Wd4KqgigX+lN8URsw232FiabDfx9pYllILtFsSZPO2JwDmu6LiTDGTBJs38wLE7
         zDywSIpgrOsSt0cGvmfdwCgeC9BaT9T3vGLiHO3MSl20JwQvsB9oc+IObnfuruxzlan/
         v8ag==
X-Gm-Message-State: AFuF++mhqpdhQgjObSgkFhVaiNK0gKt7QfTq0YJdzfxHDvWeY+kdfg93
	hCySJLT6CXAGS0YTd9lXMioAMtwjzCacdfMHHKXGuwfA3m/vEu62UYch66lMGpcsZdfRO3k4swq
	rd1LnZaW8bc83IcJMurcj5m+jPvX0r/lSFzDF
X-Gm-Gg: AYBFou3EhM0EhRIulVAQjYk+gvDpY5G4VoTK8Nf+Kim1Trg8i+svEIAIp+zF7rWyKsQ
	+QmaA7xDKsTuVCa8JjnZ2kifaDLO0AgvZmulNtUVysPXLywH5mAwq/NQCIOdHviNWTLyUesC4ns
	iylgU13+s2x+OWlqQEMAR2l7otYbrxXzppGnKgPiO/gXJDf5RL4/KOxItRQTc8fqc1JdfoAITKY
	tcA7ge+uygo8/AVZi5hRddJpnzmxUZvxX9+CMmjPsTAVJLJsQSfEMqlic/hued96D3jpqddK8mN
	kz1iNR6s8wX+qpbXO98O2bbGDsY8MlnQKFlVoc8JYhUHZz/Rtdiw2nio68CRwiWIdT3ottzdGo5
	9fgCXS3kdSn2Sig==
X-Received: by 2002:a05:6512:224b:b0:5b6:1a7c:fd8b with SMTP id
 2adb3069b0e04-5b61a7cfeebmr7039690e87.49.1789042063842; Thu, 10 Sep 2026
 05:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909134230.441546314@linuxfoundation.org>
In-Reply-To: <20260909134230.441546314@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Thu, 10 Sep 2026 17:37:31 +0530
X-Gm-Features: AcwNN1VDrzOq3YTtrG0etUeC6fialLxE7RZyO0hylbbPOfOu-9j4MEH0Rj6kjX4
Message-ID: <CAC-m1rrWxAUSOw3H8jiztm5DbXFk--LopHmhyB040WA5ieAtMQ@mail.gmail.com>
Subject: Re: [PATCH 7.2 000/556] 7.2.5-rc1 review
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

On Wed, Sep 9, 2026 at 7:48=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.2.5 release.
> There are 556 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Sep 2026 13:40:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.2.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
tested Linux stable-rc 7.2.5-rc1 on both x86_64 and arm64.

The kernel built successfully and booted successfully under QEMU
on both architectures. I also checked the dmesg output after boot
and did not find any regressions.

Kernel version: 7.2.5-rc1
Configurations tested: x86_64_defconfig, defconfig
Architectures tested: x86_64, arm64
Kernel source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: e01c81012950bb7454e595765197025a0fcbc0d5

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu.
