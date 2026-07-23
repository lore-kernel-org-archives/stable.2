Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2225B4252B1
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799242; cv=pass; b=QLqx4XWggq1dioE9u5WHGIk91eDmg0LFtLvGAD4Yx8qYDUVOiuEvqY2So2l6G2d8aeQKOve1lotgi2IAtfNVeGt/iNkFHME2EAft3Lyq5MBCIp67OZ5rZSMODjSPcaT6kHHzsHma5Dw82yctzFB1R+qT+L/1ZMkWNp45BLORrsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799242; c=relaxed/simple;
	bh=MR1+UGAksB0ZHbOjOtwK56UnQo1V61gGdQfz8WdaJ8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgvpo7bBn6sUSFZ3UiPTOhLmUrMMKE5BFOljFgQbPMl3JlrM7nJTapf91gFOjh7qSlleOAAPymTnoqgQLt8mwuC7Un6hs+to9na47cWdsa2Eo3853C8FLsM1Cy8sjEbHq9oczi1gHJi+O15RqFYiTOnhoNI3mPlCaIRhd8kBBcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oh4En0L9; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oh4En0L9"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-80bb41f7f3cso4042847b3.2
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:33:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784799238; cv=none;
        d=google.com; s=arc-20260327;
        b=WgKr8Q/ocvChFE2koVRPUKcPXRUdhGcPlgfXogbbz4PEc/Lam/b1v4V6z8TpwzAuwR
         T/uW7NXP3/GPeyMT58kb0qNh+tDon++KQMGVQMZNaZ9ETdsiRyhrKilho6A7vgGbZbPc
         Mq6IwUaDXNYZ7GXYkDsqPOyBOQL2/Kno0FWRQlNCZhofeFRs/XRWjWBXKyfaofvUYSRj
         FOSLi/nbIV0cKIsmyBYHq6SZn4WqgXSZSZ/r2pE/lmFU1S+3tvNejR+7Dd+KjovFpsnu
         vm6yMWn2Unj0SKx0rlFfocJFEWIWU6AOemmpHdr9oJuepbm9MkFr6xwo7bO+JynnZ24I
         JNRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A6pGsktlBQ5QmHb7ucHJtEWa4EMBUusAW9zHN8nzqx0=;
        fh=F3KDHO1l+u1y6NtTuXmgz5/JSj5so70xE1vss4qH1po=;
        b=fj0KQWTheFN9sIA5K1pO+qMGJxm76WHIHlKRVe3+WNiH4QppXV4GGY+bUL2XjNi5GK
         P5qzuxCe/d1+lx3dGIGNnNeCXA6lfgpBPSU4HMLD63Y8C51Y8X6QGnDu4vxvSsoThfdf
         zxSU9Posa7qUmYPCCPEs+RHNlIuIEEZf7EwL5ZzGoPm2ZYhIs9mFvFunp024NTzllD3o
         7fkmGuMHM7iZiG6EmkU6QEXdpaqmNB1BWeCBolcDnzRxi3Gznam3Ov9TYXN8dh25czQY
         jNiPMdf/tZ6PFu2gn7hVPEw2b/hmFCyUWcQ20I+qhP9zyY11xwakuTupbm65eDb3a49T
         /o2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784799238; x=1785404038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A6pGsktlBQ5QmHb7ucHJtEWa4EMBUusAW9zHN8nzqx0=;
        b=oh4En0L9oZncenrhYGdjQ/gsgtoCqcEp55z5/j1hySB2pmAbry0YPdt3hoeJhcS03p
         aUSY9mZ9h2uQ46k8NYXiugpqbsdHTTEu+KcPYEfu6OjUtTqoXCWXYOu91YCJ+V6opF+S
         2GbE2SB8VEnbugwsj9KGZPSS2VXbb4Tp6ajLoUX1tGbfQTwQctpLIFkDFy9sji4TXzGA
         uTOBp/Sa41ao3lDm1Hse/CgrAh8NGYWB+o+fi1mtFJT1sUVM0MvCfifZVLUYTNy4ngm2
         6NbY0KDSDiEfq/4rsLBEaKS47YY6w0CaAUdrDgCTW+1nCed8R73yB0HFCuOwwI7MdPmP
         edfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784799238; x=1785404038;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A6pGsktlBQ5QmHb7ucHJtEWa4EMBUusAW9zHN8nzqx0=;
        b=gjtAEfzDMaHqKfeUZUz19Hpw+FouiMvkxIzGGaSDw4rtiwEBxga/IY3JjDs1QvP0JS
         chFU95V9gJQR0ilhvKsvwkBY7ovnxBEOVTjUUwTWsY5vQ9mm5OdYwBt/2vMWsXbORbFK
         yAdX5+B1CCeItby+1e7LbHx/4o5bGJm/Wk9gMt4J+V8k7L5FwGYo2S9t+zmJOZ7tIHw8
         xUnb+Fhn/tJ04MxaP+NGd5nqrCvgBj8hE1fcif2BDjy1opjnTkuG6zrqpEliHpLZP8SH
         JG4SIvXaryM8R9QeqM28b5/dhM9q0qOGKbnSEb1uQDkk6X4ye/PuDX+Ou3OIupo+zObw
         UOnw==
X-Forwarded-Encrypted: i=1; AHgh+RoX8w2KC3nTOufZyF58CPcplIhAzqrDY2MDPKMV8ravSd5XSKkBFboovbkhRM+Y/9hq05XCt7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHGkASfJO6bLypAbKHxdXSvLdlWNUJ8htnrQW9YZAtek9SR5on
	Sw0JrgHweQEm+ar/RwpHBu75K46vjOQPDolL8/kzkSKPaDC6OsDbkzjzalyyK8+s5YzSGzuk/i9
	z4KiFaPAywIiORJEv8gWuG/DbO8yiMHI=
X-Gm-Gg: AR+sD1209/601+8HGbYzaFgQioIS7eAp9Ne0bi8kIQHD8REeNxnPlVHpO4ONzicqsJf
	gHW5kOCEMHYzTVqqBPZgcdC0ZWYlTpWyUM5aRgPrMx7kIwbgwkZ/dV2S17nTme6pHy6E4Sbl4Ro
	61cjfZwYZzwIIA45lgkzyZmmHNWW9kHkWqTaPBL0bQ+mZ7uPWJHcsboCasKGNADiBc2p/UFYbge
	ijAW1twFP8Y9t2S4FgH467mf1opggoIX0EDkKabdsQ1kR8byviAjt0JEMOQTA==
X-Received: by 2002:a05:690c:6187:b0:81e:b2d1:e3f5 with SMTP id
 00721157ae682-81f4c2daf48mr6691777b3.51.1784799238005; Thu, 23 Jul 2026
 02:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722143258.264584003@linuxfoundation.org> <88255dcb-acac-4a74-a086-b686aaf15eca@web.de>
 <2026072333-creed-overbite-b2a9@gregkh>
In-Reply-To: <2026072333-creed-overbite-b2a9@gregkh>
From: =?UTF-8?B?VG9tw6HFoSBHbG96YXI=?= <tglozar@gmail.com>
Date: Thu, 23 Jul 2026 11:33:46 +0200
X-Gm-Features: AUfX_mw4RSJwhEaYdWWTmVo28OC60dIXrfiSaGtxUXk-C_Nwj5ZxbMfl8z0vj34
Message-ID: <CAHtyXDeQ5UBrZ7xB+AyTGzHgwc6Ozjo7nxrV_3kCzi84Wb2wDw@mail.gmail.com>
Subject: Re: [PATCH 6.6 0000/1226] 6.6.145-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Frank Scheiner <frank.scheiner@web.de>, stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com, cc@epic-linux.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 23. 7. 2026 v 11:27 odes=C3=ADlatel Greg Kroah-Hartman
<gregkh@linuxfoundation.org> napsal:
> >
> > Can this be included for linux-6.6.y, so it continues to build for
> > ia64 as is?
>
> Sure, I'll queue it up.  Does anyone still actually use ia64 anymore?  I
> thought those systems were long dead.
>
> thanks,
>
> greg k-h

I have been doing various experiments with the architecture in the
past 5 years, and co-maintaining an out-of-tree patchset for the past
3 years. This patch also originally comes from there [1] - that's why
it has my signoff, too.

[1] https://github.com/linux-ia64/linux-ia64/commit/a4085ca68e49f49f962ddff=
46a901ff3468574b8

Tomas
