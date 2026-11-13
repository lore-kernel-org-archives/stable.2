Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794609127;
	b=SgeIfkINUVd99/UErm5jkY45qV5tWF2iGXQpAvGRL0ONN7QkZY9BustGLuuiWvFSNbUZ
	 ADlGD77KRQV4Fq+VSEcuVSoEBLKep5rBz4AcB1WYtdhayMvchFEGQl+XOktD2ocGOA3Kw
	 teE7XB7tT83gwbZ7hduFF42qiRjE1mfQCiANPGXwTW1Ulavf0yhnWYrTeKbfv0xKQ37BA
	 blpvFg4JszqRXSrKtXDPkldc10P0FdsxWIkssnt2YYw22JaIrA1j2YUTyR2gX8h9HmSLZ
	 c1qpo6bVYZjwtIRohqgOYvopP48tkoqrRMP8tjCRTKzFYZHwx4ixzisBuMlLFgwt93g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=onj0EjD6Aez/x0pUU0g9Id70lDTi0FHuQrAvFaAFFFo=;
	b=PutEkLvmIXOSdcOIiJhwnPWivy3OE0Qd+LN7kzA+mUh6coh8UKKu7vkqZB0g9ZXKlHhE
	 b99rR979hKMEpa4f2rnJYOx+p9fOY8x6aBHXxZCz1h8gt7EDimWep0FCthht9GQGGwmud
	 lR5b/bayFdWjHmzT3goyKjp//UtLET+JiMU/82qivFtYcbPRgPiQ6XbpueVoSbRBYhn4q
	 X2Zwn2FFC9xFzmGlJAxacOw+o7VHw49mpL5as6Jse6yxZWbgCyv1LDbM2QSQscarGudqt
	 i1uQlze0tHZFgHEgTjVMzcRpt0abke7Em7/Hs/BksRRKYdqrFYm9kUZDthn/TBfZikA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=futuring-girl.com;
	spf=pass smtp.mailfrom=futuring-girl.com;
	dkim=pass header.d=futuring-girl.com header.i=@futuring-girl.com header.a=rsa-sha256 header.s=google header.b=nkiC0DWD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF55606A8A9
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 22:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FF55606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=futuring-girl.com header.i=@futuring-girl.com header.a=rsa-sha256 header.s=google header.b=nkiC0DWD
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4d5b2db4bbso377596066b.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:32:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794609123; cv=none;
        d=google.com; s=arc-20260327;
        b=T7bFsCQQcDwSe652zvtBYd37ns2sPqZiEU/+0sOnT3N6hnI0CLos+oeiBPlBkhVmZi
         xuf/erzS9xMCz4ivkfeEZAi4zadE7XvXqtg7dRQ6V2cebBe0mTlb0lS+UPRMbgpICHuc
         49rS3N+Ob00SbB80yuf4YamIOc5EcLUO35MkYRQJH+8497o+5r5D7hMJeG4m8efwnsxQ
         UeidXvs3O7MbYMszArOxD7MjtXOXhRZ2JSSBHqsG9/2XTwunR4XxS+FaYLC7iTPqEw2Y
         7OAOeRW7UtHFSa38I0N7mC6sWz8zhU571fimUgKxSbxxozEGsJGEfYeOMfPGJH6cLwch
         oNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=onj0EjD6Aez/x0pUU0g9Id70lDTi0FHuQrAvFaAFFFo=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=jOmd28JP6S0wRxpz5jBbgC9No7cHI32AiY5XLVOylQYIXnvEev/3PFKcbSHFNYQiDc
         NP+gXy7Fj+BWvXffT5WleXuTYGLfBIN/6jGSyja0hrFZgTqT34ty7asOEX2BXJ4I55R1
         WFECT3w1SN2FM+tftAyhjTiRRh/iE0UCY5L8BNEp3bieB/jSbG+F/oE+juf5oM0PBU7H
         GxU1WJEXRRA7/a6MngbJadvi+oFyD6UksrLZWxueD3LAjUv9b84n/XKj7XmpnDLLfVUe
         miTDZ/BGWQLWH1ixCSUiO2aZ5oDxb+wk2wqz1T8TkVgiHaq+2AWRGpjOc6+t2TEdNokc
         Qjrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1794609123; x=1795213923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=onj0EjD6Aez/x0pUU0g9Id70lDTi0FHuQrAvFaAFFFo=;
        b=nkiC0DWDrptfLXBkeBp2grrrXnGx5j3vPzOVDRF6StKxui4FECzRIvlJZpTiS2c7YI
         xoJ/gfUWGpGP4IFckYurno+JAqCv+5ixngFokB6IucB0DYHEjaRa4dDMFTHKyk9EUWcO
         eMJgeJRtflKyzWlYZdEE/Ot5vE9l8PFfirZAmSDJwB51LP0Ww2Id0Pxy10RXCQXDSd9/
         Cptf+Gy7W+7T4+b0zkf3A0f5uESJCRuBO1Bf7k7f8hbDNkj/F1ay91POTM6sn2qFoJP8
         RWjLjqpNlZM1/KX2Kgh0xzBQHv4HV0oij1m5NtqXVd9bvQEbvC7P844ka31l0UXFAUH3
         aJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794609123; x=1795213923;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=onj0EjD6Aez/x0pUU0g9Id70lDTi0FHuQrAvFaAFFFo=;
        b=DcLiguKjSiqNruLofdGm6wiBGelABEhPheI8F3/5D/r/LIajtzRXtTHqPeAc/DnuXa
         YgeEshGYE1VtHF6rOX9o3krD+7nPcCqHlEzar350F25re8KF1HNWAo+Z/X6HxKmB9OIS
         xYbfyCnvSNpJ4SuxqDspazHh7wQQoDDuXv/Vxz3YtIIpab/AEIVCqOjgJ09yomhNNirP
         fTCsTzeBGTj9Cy9/D3xQS1TJmIQ0c4z06uPjh4nzGtNXX0jXrkJ5/Qiktj2rg4MoaJTk
         Xuf6Sy0nM2ljDnf9lM5D7Fq2BiufYwjdR9eZHPuCvH/AxUcicYpUoFYj7/t6yxt8FnCN
         THVw==
X-Gm-Message-State: APuU4Z+QSn5E9W3JBrAsBoxIYOk1IeUZPmWDW7AyuDs/zed/YqTTaBso
	JU0AnTGZ8RiwEyBRDsq1+i2pRb4gBKp9TbtgVwqkH6UMkHgvI/DGjWsDkygOUbDxID/WTfu7Mgv
	CBOXkIPXRRIJNfbKU/8vxpd9cOEwxLbYNPf5M4HR9Iw==
X-Gm-Gg: AYBFou0OBSkwpe0JRZIyF9Y0wKa6cS2cYL8B+8QVawtwXebkTeE2uWTjWMgRRJbZCW7
	O8Z7oV0Jx9pp0ooHTPyCwM8K1HJc5QQJvMKbLasSUOe5yvn9wITiAzfqlflL208yZbaniKLk/qD
	zHKYe5QmKBfVVWSp7d+I0YqQfvPIT2qjuX7G3hLkGLqT6AhXoHt9Xcy5P1aXTpXmxI9v0JhqkMX
	tbewtBcxcxhBb6+XuhtjLRv6NGzLw2+EQL+qPSkiOtfufE8DTBMR3TCc0WebZR0bVG77B0jLvQV
	Th44ORfY6C8G3cIzHi8GG0DMXKg+u/0Q+7gc8us14FXXHomhoqhPBu5n1UxQPMlfc2aJe5GmmPc
	KSjJ8op1rTok27Qgvzp3D0qHD9xGpWKNaZ4I1
X-Received: by 2002:a17:907:6d20:b0:c3e:d0ca:d30a with SMTP id
 a640c23a62f3a-c50963163d1mr368073766b.4.1794609122655; Fri, 13 Nov 2026
 14:32:02 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113153753.358973689@linuxfoundation.org>
In-Reply-To: <20261113153753.358973689@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 14 Nov 2026 07:31:46 +0900
X-Gm-Features: AclHuK_KdfyMzEueRu1lFvcw1syUDZJwtEIuIcU0NsNDTyLYCMdVVceVeCzKY8I
Message-ID: <CAKL4bV6ENVk-ScbP=5MKkzvSUA2vkqa5aF38GG7XX5EC+zV5_w@mail.gmail.com>
Subject: Re: [PATCH 7.3 000/507] 7.3.5-rc1 review
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

On Sat, Nov 14, 2026 at 3:29=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.3.5 release.
> There are 507 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Nov 2026 15:36:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.3.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.3.5-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.3.5-rc1rv-g2a640ccd9d0b
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Sat Nov 14 06:49:53 JST 2026

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
