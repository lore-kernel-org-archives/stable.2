Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC49F347BD9
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790857358; cv=pass; b=b2QJjslR9UCYmDlAhF2RV1ER7ve5zgM7yYczqB2Rf/gzOAw23E7d5L1qAEhL7IIpWqQyXQB1qrTS/XoO/mgExZLTGF5Gxe6LtspHYuqO5efVYLvTt0gc0hFsHuqQaop1nHM4paETOWggThA22s+PwoZOK7Yt6UD5apeYKM2StW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790857358; c=relaxed/simple;
	bh=5MZo0uMLkAcHNoAjZEUVtpUF8aIbDuyDpkqwL/p8XWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBICZB4MbljloDo63dyru4w47i8SDU7J5CneKfOTH41eQGE23i41x604yIP2izfVVPaHVxsHSbLUBEcN8pzy06IKHAPQjyUzQkwStGTJ2PE3h57cX7cejLFn5quhsgEyAPwXi5sMjB7WVwJWF/Qer5aTGCQOUfflhPEA8U1m1YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=GGZrES1A; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="GGZrES1A"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e27d11f43so102078766b.0
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 05:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790857355; cv=none;
        d=google.com; s=arc-20260327;
        b=SM4LMS1ZnKlQn2flXhuZNqdTuLhBf7u39HcxNgLqozWpNyU0m3doO7xpRlaJZY71cl
         aYDasw+GNTNUuuByCvE27wnhd682alahcr78XyJjekwhoNVnim+XCiKTdq6yqXGeJEw7
         mF0MNOxEa8TZW4Ulm/2MeI4DHu34nQ6LnsF60XaftGLYmcIlxJ9uYRU17U0/KEe0C4mB
         KPABFdCxlLofpQ8k5wK6fgjEBFUtnvbpJXVRUteqSRGmClj/aszTTO0TKWemZwKGYkoR
         gmKm6M/EyBpgAJWIw7HVgg42B5kipaxinwVhMRUIeubUQclYCPpmsw9OFUU+M2r3BhQj
         ydmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=be9cOIj4BNOmbbuy02A5g3aPL+QaTK1UPmL/Hb75rMM=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=sFM4ZCdYBDUYCBhseYgFgIUU1yqSI0rtbSxnWYYjo1Ax6GF5UOnmQa561thcbg8j0J
         XPR0rdKRylhYtovOXEiBcnA81Rx3iJXf5z0vXiO4WIAzTDk0moWb8Q2hrSBR4bgfAk/o
         kRKsHYdZpz7/HEaCpFgnZMufQ5uty8DqVkmZh4MwqUVltmo5BMWpxfJhQnekxUfoTy/w
         SNV8OxWfYgf4DiELmMrxOhLKdXUqDDcJ2/PLI7HcVbXDhKPugV3jYZ/rYZavtYOI/YZt
         uLsAstLvHDQ5DRP/vf1TwNGNOFjFuHOkKscChFB/y69/JP4s/89raDFZfXU3j3vhpEEy
         w7sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1790857355; x=1791462155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=be9cOIj4BNOmbbuy02A5g3aPL+QaTK1UPmL/Hb75rMM=;
        b=GGZrES1ALdikbo7RktLSixs5ZyblqZYJp4qHTPRbmycw4Czd2bOvCG680jLtVaJRVs
         OUNhHU/2m5YmK48LeZ9YygYGPhMCoKw7DqzosWswbI7fi8cfGaNxa6R7txOZJBAQCHg8
         tQA8lIw1aCUfV8LmbNPQ5rdmpB2nUtXOowchStkPuCjMcPVWVd2HukrLlR6diqlp9LIY
         35PIs0kSCyH6UIJWQTTHtVYP0rOmZz8Agu/1BQlZEn32eeSorQPNOpioxpH8lGPRQrFW
         qw3Vn1BVdQR1vwCguZucb86vkA6RQ9/AgrPTnmTpgPewF8bXtQ3Xi7z5vnKQ7H1+cMaa
         runw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790857355; x=1791462155;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=be9cOIj4BNOmbbuy02A5g3aPL+QaTK1UPmL/Hb75rMM=;
        b=lIqBFOKYKO4FJocqUX15mH7nB4vJ6uEwdF2NPs6p1AHEk6az7FvA4Rcd8poqVKcbju
         q5s+keEJeZD/hI8m2P3vi4QYUJN7MUdMPP25G6I6JxnQdUFX42GdQS1/CKEHG7DCtV79
         NUZ9Wl/lthRuvAPIfRQjNvZUpdPdS3JUAuk8kksf48z/fbvejf4+i34GiHaLL42Vhnql
         uu8DkcoL9rVt9JLWwZGA9C1L9WTYkb/u03W7WCwWXYcP2HV5fDFUzEgsz4BWonbQiEgZ
         r8VDyLpAOCC4yROa6bMH2e8v2tVMvzPUD5E4l/jY5l44V2qJQR97N1TZy1pVJOwlaEJZ
         OchA==
X-Gm-Message-State: AFuF++ngN+sQmJIQTiDUS+H10pYhWP6nQxVc+SK8uDkS0GJEvg0C7BUL
	yAAEcqYt1YkkjLQPQ975BvGLxZD8zUMdRcJY/6v8ghRaWR0Ondcvtcx3dYvYfsJ+GYqQfDbHkDK
	BjIbTpJHlJFtvcBfKx4uLz52P3uCWBj6M5c68AkeRWA==
X-Gm-Gg: AYBFou3oZW/YTDLDE7MksaFdWR/V4VXKA0XVIusSBE/DKIPY4NvvDSRUw5pyBJkm4Rj
	PfE0mrYJMtyUOfc5CIOdnMBAhtHjatZdzXRnLxQVt3sqkRjqJXVwibOvw2h3sCwjZmBe6V/WX8I
	xz5XDv4jYcDgbOhmt2NUSDHqM4YBxwGLpMm/tll8BuG0czc0xn2G0oUcm1OJDsfCHmggvNMJpna
	7htVuRiR4dRzhs9ArZ3c7hvddErL/7LqDCqUxqyxKwKc/nwwdqHjVlEe518q+DU1kvYd8xryQ9c
	lzyJbtMul6pBtPaU/v/SkhMO3CmbYPxiGsO03X/YsbZ2gmUwBOEdixhNdiVhDaL6iQ==
X-Received: by 2002:a17:907:6d11:b0:c2d:c80e:8366 with SMTP id
 a640c23a62f3a-c2e337bdea7mr263545766b.0.1790857354896; Thu, 01 Oct 2026
 05:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930152346.024115587@linuxfoundation.org>
In-Reply-To: <20260930152346.024115587@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 1 Oct 2026 21:22:18 +0900
X-Gm-Features: AclHuK-sbcaaYjsuOzxj2bOVAT_AE9dB5VOsaeOyAhBrmdCFSdt1ZFzdcdgvrb8
Message-ID: <CAKL4bV61LvdiYKD0EXR1tMOcsLufHJiecdCPnUtt524DpJSFfw@mail.gmail.com>
Subject: Re: [PATCH 7.2 000/457] 7.2.9-rc1 review
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

On Thu, Oct 1, 2026 at 3:18=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.2.9 release.
> There are 457 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 02 Oct 2026 15:23:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.2.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.2.9-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.2.9-rc1rv-g815c1e68a78f
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Thu Oct  1 19:40:07 JST 2026

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
