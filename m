Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FCF42BEA5
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173043; cv=pass; b=XIykMpv3Wc/fgxIXQfUUBFYGonLIEnt2ErUp97q1Od9csA0PGHTwKMZDiIYuRLKUtZ6Qx4aNAFPAS+4VNq7KxHB+oIEKRcwrVY4sJdpofxvp8BJKp+ntJmHDWqiOYXsU8X2TUnF8m6dok4O11mtR6eoYbQmT0O9fzy3LaAS2KX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173043; c=relaxed/simple;
	bh=RFTdxN+A+CbnUfmBngTBnf+DlDqpq3EClX2WjdzmUVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFfyTVSiE3q3z1xiVL7GltsqV+QVyXGoDbsI//9H8EL4GX2XcwxlEl5phJ+R3hbRPQwmXjWG7SPn1aM3VZUjObaVNH5Imjry6Jr+3GFi8ykv/LplUzMb+zkCYKER+NuEJfFHDUR0MK7RwgzX2l9SXJi9dk74Vd6KmJqLcmIYZ+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com; spf=pass smtp.mailfrom=juliahub.com; dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b=MJ5HAcGd; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juliahub.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b="MJ5HAcGd"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e5c9211d2so247190985a.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 10:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785173039; cv=none;
        d=google.com; s=arc-20260327;
        b=AqinLSCfJMPmPytjKCYT/Smav9jETztd1EOKjxS+aAWrKd08LWv1bJunfJMoqACVSX
         /6TrD0lTmbWlyeLZn9PzRv7bDvh7nofqNCYEvfA0fFx2R8WPvdjgQxpUoPlcsTEpJPq4
         m0dFp/Jyqoh1VUsbPimL8xmYf1/V8KAZHfsL/WJv2yKa6KXBulsGbYkrW6n+XFM69PCt
         BMaHlV3TFPmnBcV1ZxrwfNSn8+B8gJHrsY9rnnDUdmJJse1b3r7r5vHECxuq/nG9uwY/
         hJ0DWB5dQgh0kC2eAlAwG6cLBKg7K70eDfOXTearHVJTyqIibdOBLh/OJF51N8gMLZEE
         UCJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RFTdxN+A+CbnUfmBngTBnf+DlDqpq3EClX2WjdzmUVY=;
        fh=vrQDhJdvva3Zz38ZSYWQl63fUWnN7Xd92g9IRXAAyd8=;
        b=nq9GqNPQMX0AEawlmzwBuruMCQQK0oRcc3G+kFLhW658PVjIplqnA4NiUram0CX8tT
         AUyBhcQm0qP8kLBaSliSjls4+Q/BnjD0FHvPKJDqiAT0noAq7iguIORuLsIq9UGRRJ18
         +n8NYhi/u/Rx3pqqk0aOL+3wW+H6NhYP9BZT67RKzt/1qSxvzUjOOOtZ3kDKg+bnHL8G
         1cyM5qqSXV3gbBi1NHwrSVQ4Muf/PwrY6B7+cf9bEQKb6ZH06Ujn4bEUER7wzlN7HH86
         irko5R+6cxM+N4EJpzYiXBaVPLCnFczMSFKcR106o9Vicgv3Qmbtg02N1DmNcJ6BqR3i
         ixQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliahub.com; s=google; t=1785173039; x=1785777839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RFTdxN+A+CbnUfmBngTBnf+DlDqpq3EClX2WjdzmUVY=;
        b=MJ5HAcGds7LY24+D2AQtd0+3rCDc6wfFoGjAhBg/b/GUWSH6b7Uchb/k4vLXfzITKL
         BFAkp2VrWOTUYDEHbKpI6XLykHRNzklr3TbA7ycwDdSnqa5ZQY0ur4FMMYJagVPazGjM
         CG5tb5gkHq4fSJh416PcXIEddwaRNo5nTzl2appl7MJDryQVpnXOXUwg5k+d7ZwCXDUz
         EttNgK9p3Ro0onqSWB+rzdjY1h/rEtQuQvXwAd0pyB7vpw1NpcSWv1pXjD05XXI0lHre
         4ahwSjvAGDDUNSaFzq6AYzrb4DCuFehtCZfrjF9t8x+YmKYzczT2eTAeE5Buq423BGSY
         wC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785173039; x=1785777839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RFTdxN+A+CbnUfmBngTBnf+DlDqpq3EClX2WjdzmUVY=;
        b=R9RXMgZJiYDwdbFA0aZRS7Lw4rZsvlWWJun5zzFR9EizOLVh8leYVcFOgQeGLEB/zn
         O3eEcssKMbOA2qAsLPK6XtCIjAiku1fYhleNmd2mIMrA4wXwCPe7YswQuOlwSwektWMP
         1O7Jg/pNGnpDygHgB42GKkDh1w/eUdh/Kpcc2d+OyVTyVt25rKc49tHqqJAug3Aug597
         usk/efrw0SAlrHG2hYiV+JiysPDA7/MySRqTr+/IiXpE7Z9ylihCuukQDVxd6jJK2Cq+
         uK/Bihz1Xs5wWzMI66p09ilvP7KejVtMVgZYIRIJV+5pnYaB1HrSEfJ8fVIdDBy3H0FN
         i4Sg==
X-Forwarded-Encrypted: i=1; AHgh+RqDXIxCdYozvSw/2Dq3oO9wyNJTvBvyNdNNpxgRKG8HZ3yY6MfayD8XFDtAnY08UusTl7gBG3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcQZuPM6NtRcmSD8DuG39wSpo9Ez3KkT1qvKXWmiPwS+x0QKeS
	EMj3+aXiiiuhsB++kydqz3Xy9XkkU1bEOrDNxIYmKCDyc5meqh6qkt1lLsrf1BwJaNNy77fG6eX
	dAR2OJpHcxzu0r8mnOm+KWlBp1WOaLMr+cFqjgJVLFw==
X-Gm-Gg: AR+sD1348gtC49YIFQ+qXUu62/lLYLc4ILcM+JyDE0TK87sHz6GDfFgdvTcWLoLk/xV
	UkdgbLe4PL0SV35IUwQm7DamQoDeA50Qf7mM2I1h6LE3E4XsLooTcAYe9hON7jCZtGaZbo8wOAc
	hDAXShnT/N3wlNXCM0h1WMbgVTj+QHPjTcT78RA0J+1JAtnwbuU7sAAiXYs++/N8qkf+NVegQC3
	6/e5L1Ik0xxxPo4hdpnPgMSzbzF3Ovi09tvG/4reg9w6hhqi4W+/YwKAwXWVqWYnQEWXIzGXDGR
	ZhL1RpQ7ZjQ58/KxNA==
X-Received: by 2002:a05:620a:730a:20b0:932:e9c2:f4fc with SMTP id
 af79cd13be357-932e9c2f722mr472227385a.16.1785173039335; Mon, 27 Jul 2026
 10:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
 <87bjc0led9.ffs@fw13> <CABV8kRwDhwa_OoQ9zx4sv3tDATZc0Yy-mYGObRXw59DO0cDfLw@mail.gmail.com>
 <87v7a7jeav.ffs@fw13> <CABV8kRz5c4opGVA3CPdALWxjUH_DkLf_tBLdefajsSevfHFYpQ@mail.gmail.com>
 <87zezdiiyg.ffs@fw13> <CABV8kRz1nLxUDAgCSKHB2oqME74M6PyxB-t+u1it=6eYo5cFAQ@mail.gmail.com>
 <87ldawinki.ffs@fw13>
In-Reply-To: <87ldawinki.ffs@fw13>
From: Keno Fischer <keno@juliahub.com>
Date: Mon, 27 Jul 2026 13:23:22 -0400
X-Gm-Features: AUfX_mypmbsksVNeK6osrFhcXqUyH75uyUqC-AlKU4P942SIxXO_umwR6F6Yo8o
Message-ID: <CABV8kRw92-0sx6Mi=z5pzCA9gEE9nnBbTjwKHzEr35DpSk6keg@mail.gmail.com>
Subject: Re: [PATCH] futex: Prevent robust futex exit race more
To: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Yang Tao <yang.tao172@zte.com.cn>, Yi Wang <wang.yi59@zte.com.cn>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
	Florian Weimer <fweimer@redhat.com>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 9:12=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> w=
rote:
> Reworked version below.

Patch looks good and passes all my local tests! Thanks!

Keno
