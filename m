Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795702895;
	b=DL782YXmfY7Gj4DxRkOjYUcKxfXxjZnxrbvlhPeIFLXfKFiB18UsWDf8b94ZBiArkqQO
	 dNyQemW9Kaw2Y/wlvBF/CcVlhvg3uq/0DyCdvcOE7mvC4HMpMw2jEbkTNKFKaq5eVrTOd
	 /peyI4Abf2lx48pBtcpk1uhT3EIUtlNKPKCPf0RwyvdZ08MALq4BDgdS6GwlBNb+AtP4q
	 qfcUAbO/uCnL9IBHXUdjlaW3lVmxqoQ3hnUCtICw2AWHR893tUkj4Kj4ETGP9/q0mj0NQ
	 uyKfeRBaDKvF6RUxXo6GEDk08kaqu1DrrES1i9fz719j7QK1JGd0NQozfD96Q2XHUWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702895;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=G5RY+0srkZ4dl/m2XGcBAxCwTBJactXCq+wpKVumJ4I=;
	b=3dZuCB5df2tSSoy6nOSwWAO7p+MCh6hwKNEH01yMViuKSOpNzrzHJTUfVL1Eb7cU9fMA
	 eN2F5ZnzeE92xPi6GKATA9805urFTNDXPtFYFDKOQCxomanhOByjPb7gaOwvLbWCq/wuo
	 3ljLeb0aT4PF+WpEICRDmx15CgUmwJw/1PEA4x//46LpamzH7+aSeLa0tbrP3oGnuEXoN
	 AK4uq29zuYB8d/H44GFFzYV/AqD+fpFhGT6XodzN2g3zSiuqziU6cd7gR66p/Al1tvVL6
	 Id/OSo5JlrTBGdoLd8ZZz+1IVtivr5LuTIvzISgCWAljiySLa+cg3rL6+BAMVeEegXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=futuring-girl.com;
	spf=pass smtp.mailfrom=futuring-girl.com;
	dkim=pass header.d=futuring-girl.com header.i=@futuring-girl.com header.a=rsa-sha256 header.s=google header.b=dk1PfrRF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0D0606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B0D0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.a=rsa-sha256 header.s=google header.b=dk1PfrRF
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4cac7a7d3cso1053443966b.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:21:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795702893; cv=none;
        d=google.com; s=arc-20260327;
        b=iW8LX3yhbhXEHjOEUnuFva3MJBHeb65jgo0VSuPa7RUF8oKbAiWR9/JTMRQ2zseRWt
         qOf455a8yTcS94hZxmE4raqSGsaMx0q9gLi+K2vUnHesFr/ozRMdQsUi9qgjQyo8PmHZ
         opvUatzL9k1EY9bdW01onUN2NaGE8uPhfXRGB9L+ZA+/gk8o3hPeHgWWMjiBVRcE99BU
         kKgIz/Czk53B3a2seJaSdRbLAnvI3UGgksYusAH5S/xIiMO9a2OewyBZNLH5zg1ScJrS
         ALcWGJW9atTEgZyPe4wuIbHuc4KBtArTvHBqQIa5CVPX3l6NnpQxNfiFUU+GM8fb0Y4Z
         Uk5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G5RY+0srkZ4dl/m2XGcBAxCwTBJactXCq+wpKVumJ4I=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=SZijEr8YMhjHd4Fdvkj2WSz/eKqpPA6Lla9IEeMk9V/4OjSjI9ch+RsZravxztHKHj
         URtF/m3j7+xJfyw8nYAH1rxE272wjPttMwVOFPMPGpctMHtZETG+1pd/tFRUJgKjVYUM
         4SR7fXyS8tip/mZQVRfvfOdMnm9g6Hg6cI5aMA05AI3S9UF9GeJ/IV9Ac2H1NzHLGnur
         GiH38kxp4o8If7x9Z2kjTMIOFxpNpIPx3VoAX3ipb7K3MPrfQLPhOHg0QYBbTz8V04TB
         mzBp2m+8jIHUO7CPcsDPeavZYzbH/sO+hxZG6B9fKD0iggWOawKYN5EjDhZe6xVBEt7P
         cTag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1795702893; x=1796307693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G5RY+0srkZ4dl/m2XGcBAxCwTBJactXCq+wpKVumJ4I=;
        b=dk1PfrRFkowNWEKu3GINuXpjpLOVyc4gXrjdp7mELO/8uGhXjBKUFc7yeYO2u0K1Xk
         kaP//g+oomq5BqAxmnIyg/vJVU+StPZITcbwUoiK0AJwNkMJ5b0nhkMNm6Sy6dDnL0fY
         FE7XVehBge+TzTEejHajpEOwfwZrhnk24WpJtLvsirwY/J8s7A/HrxKQ8sx7rJ/B/GNj
         qbQ/fjPXiMviW8fsWPFQM3TA1pCfM3TU+flIdlZVd4CAejmtCh8jGYLz0G1vrZu2vIeU
         v1QxdvbVxQIN2zVxfX3U9vRNFJLX5OjBKoe7AQunGZBKyj2Ki8wirBzmZcxcYEC6z4aZ
         xMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702893; x=1796307693;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G5RY+0srkZ4dl/m2XGcBAxCwTBJactXCq+wpKVumJ4I=;
        b=VQHaXEE3Lg4RdXf6E/uRjX2r1uHkt882ZwAYY0Du7Gza7YUXpifRONYo1L9KIlxj5G
         fRG3rtehG5CP9h85twuK486iqTNGuSg4/cwYliSpH9lYG7iiJPjArRtTHy+UJm2WZEe9
         TdGtxV+QNHUKG9q+hW1Ryr81O5x+9OQCNcSZuLxnjCh4C1OK30qNDYRysv7Y9GcJf5oz
         JmZVDZ4S4sut/mP8P+57kbuC7ckG3P036lhtTaajk1V5Q4fhXSVp3lgMh8mhvGfzpLjM
         TszBSn/0sBjmDqtCea1WzyzUb3ZpZLxMtq3rHK1TgnLNR2jsv+nf6ESIwbJysDl3xxBp
         V/yg==
X-Gm-Message-State: APuU4Z9438TJc+kHeJLuK8HGfHEJwUkrq5GOQ10Z4cyziRwFJ2Lci1+R
	v0Avid6EUpWGXyLcGlllknps+wYQgOERgRZwFLoYYyV7htx4fhZr0aqm5MMhbBxrWs7kfbmxcdM
	w7py23P79CHhKQLtkFkIwjMo2RiWF6EFixeGZdt+XQQ==
X-Gm-Gg: AZFdTZe3zEwKFX4khUV4RutJG9yHTmfszhDCCYkGwUjQdMIx+zC4UvJf9QW/aT67okS
	TejaHxomztGo4OToQJIzB8U889BESBV0U+EWpqWVfuNEvEyHlUSP+Fzu2o59x+prbF+Eez9mi5n
	yjuTDJmY4rwg0ADSdBwa7ebpKxqMTCtpdp9FGw9ykm2G6etDWx+iBf8dAgwR8wzZKfqdNW8kBQG
	8f7TvjVDuDVxs0T7ODgg14iE77QjFq0HvYOqConux06480xJlETD5DIsKwjJlWi3EU6omelzSAt
	eMBjTgu6pzK+N1hAx8AZ3XQaV2Ar/a5p7O8e6XqjGk/PCwivSDE5ILvb0HZY65srYlJzq4xunSa
	TKsk0EWhq47YK7r1YTAKaj6fY/3bJPyfj6urD
X-Received: by 2002:a17:906:9c10:b0:c50:e9b4:3c9f with SMTP id
 a640c23a62f3a-c513a88bd77mr1318692766b.14.1795702892675; Thu, 26 Nov 2026
 06:21:32 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126105729.110697432@linuxfoundation.org>
In-Reply-To: <20261126105729.110697432@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 26 Nov 2026 23:21:14 +0900
X-Gm-Features: Aa3M54rDhX9gPPGUUPqGNn55Em1IdriVZL7YAVT3nsPcx51a8eHytUToqjQjQi0
Message-ID: <CAKL4bV7H4EgWB0j-0KsD1bxNWwaad94Gvg86+vNVNDh5vR+ZZA@mail.gmail.com>
Subject: Re: [PATCH 7.3 0000/1002] 7.3.7-rc2 review
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

On Thu, Nov 26, 2026 at 7:58=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.3.7 release.
> There are 1002 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 28 Nov 2026 10:55:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.3.7-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.3.7-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.3.7-rc2rv-gce73b94700e6
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Thu Nov 26 22:44:37 JST 2026

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
