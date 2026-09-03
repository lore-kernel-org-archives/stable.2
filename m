Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7584BB7F6
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446449; cv=pass; b=GkZ9UHt/nZNKLh2fjHKnsy4T1xUiRZHVbbnNTNNuvHMju4VikE9Ls4sjPi9tBXrDhsQ6k6CNQVi1gD//7i12wONC2Qs+Mq74bJ/o2psIa4aFslNVx6Kr+JEEpOZ2giDnLr9fCyVODzp6vO1UrbSZmMgochwXN+A2xfJUSDZodGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446449; c=relaxed/simple;
	bh=DMcoFPAWdEiA47YKBPP9R2w1Up2IfyxuLdA+slJYpIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DtSbonHYmcETC+ZpZF3/YaBtOzGOjpxIto42ZLjTqsXOq6tijzKGuiRaJJ51GAgw32t6Ycrx0CakTyJpjsuC2kaMGqXsQkIX2qVpNQzY2uE7VNC/IFYyTRV21H36mv71fHXVafPPQm+f+tTfRXT0yQt55iaTxUcmh4ELXVEDT8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hvz++bd8; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hvz++bd8"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-867a943b149so38981847b3.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 07:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788446443; cv=none;
        d=google.com; s=arc-20260327;
        b=TLxCFQ69bREr7TPD57n8xsAO3VeWJq+JnD4ec6/yvhiqimBpPSEd4Aff4j8vA4RKRP
         Gl5rMGsqG0TVo5a5k3Rgr3dflCRGOCoed2Ru1SnXI4IXyA9VwnSHpV4n4Fo9cq7ZtYck
         5ss6ca20cfVpBDsjWJGcJxJ3pN4KgdjEBEbZN4O6S+pbXalgpqGcl6q/R37rAQtFLUfM
         Gkv3Cx3oiHZtHBQr1xypFAOKt3XPEf/lNgc8by97OfXPFFmvLktkDxkzPM82uT23uqGO
         MBIpyRSLobSu0JhkmVxWak5oMfT+tCMtSYBG3Fjz/KrbrtWEgbXhrYtIRHXlZMmY+F/i
         /2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DMcoFPAWdEiA47YKBPP9R2w1Up2IfyxuLdA+slJYpIs=;
        fh=k5+Dt1gq4JjI3Gc8B+H6i1zgHVh9l2UfCVN1v/kBZtY=;
        b=K/EImVugdlW30AGAqqxE/RzzeXP0UvSsIwIWlfMu1Ky6ea/KJRXps4cqqnzMgrzxBD
         dTIUdG89efsHvbNKgII2/exqv643S1FHqfoBdK6aPeG1vkXySKuST7yje8Ig6rfgRbEm
         8mwgJzr+RIM68db65FdGeJr/OWDbLAUJ5ttMekg2xl26TwdAGHwFYXn4KJHExXUEM9sH
         x63yRJEKbKe3ETwcY9XEbfk4sXYHpkt7GUVrSEelEDd0MzWh1gdmfcw7pqDR7E76bule
         cQwkV+nAR0z0WkpXznDOfHAo7PqzJt3kgF8D4eaaPzIJ0SjwjsVAoQA7SOL6UWzFvDSE
         X78g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446443; x=1789051243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DMcoFPAWdEiA47YKBPP9R2w1Up2IfyxuLdA+slJYpIs=;
        b=Hvz++bd8+eYQunNClH2gjduGXicxU7Dxf9RUQf91Lt7mmlCNFJBKNsC5TXFqAX2ksE
         KwP1DHKm0mpdNGAGNJgcDLmvLxrAf8KvNg2+oUqTjO7nSEKVjyJReCI4gAaHwfbYUSAw
         IHvyXLBr7UhhT2Q/4PCFEwo61s+0zXpm/p/2pUaMJq0IPc4UM7MZwd3YSqeS2IvhN2GF
         Cr9xZTW2ewL2WfKNfI85Oi/A3HRcMpQWKz9ST2POrBj7DvX+fQSd9K0WzFyGfhd85tt+
         eFZnM6vvgMEv1YHJAgHzmOML+iF1b+rgvY6mA3M0wUoEkS1iHy02lpQbNvuYBxYhiDRP
         X5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446443; x=1789051243;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DMcoFPAWdEiA47YKBPP9R2w1Up2IfyxuLdA+slJYpIs=;
        b=HUASJIzdKQvEul09qCMpEbmyp80U71dmW+ZA6lOiEqI+XcEAxgy878wISH19bWi9Qa
         OraztoINw76OYh45Ze8x8eXlbKAfammOKqNYW8cNTdp8eLhww9qzCDXkBuHcMsWh9Q5V
         uaHe85xE4ntquTSM45+vCBMO7iNO0EP23Mh5qVH93vSsF6P19YAgZB0gCSzUUv6rnN4I
         HT3oDfR34aGpzqOGJ1qBAlsAh8ay9+sA7oL8i2ouzPfiS660i/Q172/dl1//XHF5F+PR
         EP8LKQhHcC0t3K/V/y6ZpWkK0T2gSVfGsFEPIrOXWocyzzLrKlYncwWwHWQjZl2e6AAN
         Yg9g==
X-Forwarded-Encrypted: i=1; AKwUvBxdnLXSTFnWRlOptd41WHVqf05zhrjNAppT2NdzNUQWkI8sXZxYbRnc7YgrfxD/GYwlcal66XQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n+NFyyZCfWbV/o1H3UJIJ6rnFwxlol8z+SUt7GEpq/brBc78pm
	IBxW5e5DZW3YIdscffRgWvakx2dvQmbcK1vMJgRgS0hbvjHpu5ZQEDU2qYdnUK9IYK1SGmus7M5
	0keutQTKcJIJb5otI9II5/CjTmUul+Cs=
X-Gm-Gg: AYBFou3TWy9u3p3tQilhyQltQe2ouK66iLXtdYe1YpAw2oJSoybp9PfrwIZ4+qdKiLj
	Rcu4y/HLmbm4OOFvXMguUwni92nfWcUWRb8zRuRrAcrl2S7O6JWNRB31AaoWRJVDG0F5vqzZowo
	1NIm/mQd+aX20giUsKUNfhicf0woxKHAtHSPjr4DW9KoRUqVNhTchP0EZGPE+0DqNcu6TZzDmgS
	l3Xop8Jp35Lh6vDTZ6H1HaGNHJtOTNI3OmzbU13rkCJN7vrkzznPDAb14XDUw6MgBjAkMnyU4md
	rwDBhDsiiaDGBNB1St8G3vf1kuhEbYupTk0I2Us/3YPoSldCp+D/8Z2FSn8Vt0kitNnpz+706WT
	pLdF3uBXiqx9nPlr30gXHEkrJs87o9P8=
X-Received: by 2002:a05:690c:e211:10b0:80c:5ce9:8f1a with SMTP id
 00721157ae682-86c54b242fbmr50652107b3.34.1788446442940; Thu, 03 Sep 2026
 07:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5be7vkmpzmizgmvqxyefubgi3epnlo2uf7mabcgsapvia4ckpm@ixwfppk5z5e5> <A4C1EAB3A67613DC+20260903132714.2538118-1-raoxu@uniontech.com>
In-Reply-To: <A4C1EAB3A67613DC+20260903132714.2538118-1-raoxu@uniontech.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 3 Sep 2026 10:40:31 -0400
X-Gm-Features: AcwNN1W2_JiObyW5To0IffDILn7tLdHOJXWxugOC4ExywC4Uofa9xPpYfNG3_Bo
Message-ID: <CABBYNZL2QcodKofLFbHbDJZBcjA+mRDSYi2QFZ_XvyphJYg_yg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btqcomsmd: destroy RPMsg endpoints before
 freeing hci_dev
To: raoxu <raoxu@uniontech.com>
Cc: dmitry.baryshkov@oss.qualcomm.com, brgl@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xu,

On Thu, Sep 3, 2026 at 9:27=E2=80=AFAM raoxu <raoxu@uniontech.com> wrote:
>
> Hi Luiz, Marcel,
>
> A gentle ping on this fix.
>
> It has already received:
>
> Reviewed-by: Dmitry Baryshkov
> Acked-by: Bartosz Golaszewski
>
> and the Bluetooth CI passed. The original teardown ordering is still
> present in the current Bluetooth tree.
>
> Please let me know if any further changes or testing are needed.

Please resend.

--=20
Luiz Augusto von Dentz
