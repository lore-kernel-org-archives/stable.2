Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5153EBF01
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782477344; cv=pass; b=pYjWKenesvXq+M9H9O7jER1Y0s2fT2Naad9lRcomD5RXcpB/QQwyV0vIu+uaOSGX9RJu74GhjptzIqoTDS90P+8sRJP2SfbNb2bxrd8HlXeDSBFX8f/wJQC9qCDlSHohVdH99cWXBklOOmVdUt6RBLEqoXeuBrfYmjvfaWZiIgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782477344; c=relaxed/simple;
	bh=3fJVQ4hYkFu5L5b945wwzNUsQFPabfYbMhAcKfbJfNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVoPOOrlrTpB4fEP1EjdLItxEq51c5G7CeLnRVtE3ohi5A03KqDHaWukpqldbt0HSAH1Lu6T1KFMN/LgalSyMvlMWsAvpH4UONAfC4KmDH9DMqAVaf9KI60OBM2Phojd4bvN26KwDhx/QCVzL4D+4qyCaEat2e1oQW8mKqLO414=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=tpND7uIZ; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="tpND7uIZ"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-139aff562e1so1355597c88.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 05:35:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782477341; cv=none;
        d=google.com; s=arc-20260327;
        b=GMZr3a7XfNeC3NbKRFr1103dNoAU5axyTvogmlvPVkA20HKJZ6nZJXu3wfxmtF1NtC
         fzwGGslgdvkei/E3WvYtwAQGTUa37VzOVDy2JHGkqjWWYR7nbsxE0s+hxAI47P5/TYLB
         m/ZgnDG7WIM9+q0sVaNm6kTcCD7BThuFokTCMxVqPokglkobebFFhdCstQhjuuytTTw4
         xE73yk+7exMJO7htlYDD4asZqOwSkmc3WwhoQNt2PP1DGZuDPvKV/IYcvfjkm2q+UAYx
         J8livveIUanvEqfxMuLXGZtVDITcn6pyRS0lmk5kVckRwk7RdswaOf2SkNUnVaXZQOYh
         ZFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sauy/FC8sN43A8h45utURrQh4BHMaX663sXIYi1uAOs=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=UdalIwgh6wLapPgGn/Nb4A2ot88+bWxPT4QT4C7BWDgIMSUxAvuROpVhvf/hr/N4kC
         iSbK8O2NW4UWjXNeybMqffeKNWqzAlrygEk152KTrVjR8/h6oWfJvIasWKzlHncMv0Ve
         wnlGolHN+OPxiNAIvdaT22K2Pf2jgg3M3Otz5vPsk07p63tub2jaItm6k5zVAxP7edXX
         tA2UODLOhZgnJHrXv8Pg/tCDX+t8zLvKAp0UjpMXg9yNYJkhnFDThd+OKcv/G2/IBFmB
         hLgNG2PgxkzXQFpoUJHP6zAwPZGgAxWORvZWZhQdvWL2PSJMbgy3VECtCc8pp++0iFSY
         miow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1782477341; x=1783082141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sauy/FC8sN43A8h45utURrQh4BHMaX663sXIYi1uAOs=;
        b=tpND7uIZNLA6EBqYvyiUTVf+fyS1wT08WXgdYXlipU7UagElDteYQrO496xo8825Wd
         oTV+ewIoDK/oF6hw0LHvXHAVqzU8UyrfM8BQ7J5zJ+fZgw6YUXAf0ZzuQlk96vjgNJnV
         3JYuBJCIyKQQUcOwNOGUbp0zNa0rIgFrUGMG/bR38vrQMm+gV33dKhJZXNCej2UhtU1n
         BGjraQLNQgJODLYGj6AhJWs7lf5Ipc0ZqAJBg29j+7+nMvgWqFp1tC+RYHzvH/c8+gXz
         elZl3DTmKoALPOw0ynMYyimWWI2T4EGSoMsep+yNvVWaZL81wzAAveyjIkFOw1p5iN8H
         x4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782477341; x=1783082141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sauy/FC8sN43A8h45utURrQh4BHMaX663sXIYi1uAOs=;
        b=kxZU37b5AVt/GIJ9pqA+uyP4siufluWw/gYsAfwjiNHbiZL5+ynyteV7PQYEDKRnPb
         4Pabzwf3aANhN3VApev77SsjEyfJhXbphOruTE69f//6v/hebSm0zWNa7I14xXgZxcHN
         Re2Cbvq5Gg3UileQVAunjZPWG3i8M0i9NdToPzm0iGzfw21GoR1ROiQ1NtZ+8+0wsfrP
         6h1wsTvkem7ad9wyv1PqFGPNgsSzmvzx7uo0Q0DjXh7AHknc5tanSwx482k94MRRMeYy
         VrQbeC9EWhQjDyW3oYWlHU0gSX1u5tGsKTjz9MSL+HEAUHehHytH29IknOgMfyXb2tnR
         vImA==
X-Gm-Message-State: AOJu0YypvLPimdD9FYK2PbhDEzF+g0BmBgtXi+Lr9b2zdvrCVXlC8N6P
	qYvpgpDptOBB0bhliNwZ0h3kzWv8N+edcHXRo2S5NFZWzMUX9zfPQmV8TV+F4vyLR/ZD8Rnbdb8
	Db3IlwWHJX4JN3S0TfOM4sp3MY1jTEYxM8l/Z0BNGng==
X-Gm-Gg: AfdE7ckOZiYrQ/1p5Japk7P/NMqPwe7G84zoCDB5Vce+hn0GfiYIX2T4O9THcJSUDZc
	H5lcl9IvJr+HnBfpNsA9ODkL2zqluUobQUAfMEeMVZB90yNcJRaE/VFOVX+mz3Ogjs2iO6etwz0
	21bDc2QOP03UXC45g0ooC3fkPXKbqpEeHi/t01UtanIqeZOfd5CUnEt0VCEM2CKY35qquKZ5hp7
	j+49vpdeCxjzdApeJD630IlQ0/zZy8yMwPTswfqph7S5WU9KrJybVh9cYsK9Do416fxpQdNsA==
X-Received: by 2002:a05:7022:fa4:b0:138:3d7:e8b1 with SMTP id
 a92af1059eb24-139dba109camr6933862c88.10.1782477341059; Fri, 26 Jun 2026
 05:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625125613.243729608@linuxfoundation.org>
In-Reply-To: <20260625125613.243729608@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 26 Jun 2026 21:35:23 +0900
X-Gm-Features: AVVi8Cf6RN527hwRseWGpkGeRx863oAedheFSfxwak-FDDbXyPxrsCxB8-Tep7A
Message-ID: <CAKL4bV5NEHdEEGXyTCO73QMOnQyJfNoKk2pPb3Cg5zJJ9gKZ3w@mail.gmail.com>
Subject: Re: [PATCH 7.1 00/21] 7.1.2-rc1 review
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

On Thu, Jun 25, 2026 at 10:15=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.1.2 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Jun 2026 12:54:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.1.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Linux version 7.1.2-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.1.2-rc1rv-gecd7772bf738
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.1.1 20260430, GNU ld (GNU
Binutils) 2.46.0) #1 SMP PREEMPT_DYNAMIC Fri Jun 26 20:21:58 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
