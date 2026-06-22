Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77196352014
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782161033; cv=pass; b=mQ1mUsd/RXBQq9qgpe698wMs+LXpX990NnQEuFGXPDfLHyr6PRGhZZdReDC5LbEjntT4K9duxRr6oHB2f2O55h4dy/a6NvLrT6DQcfppaf4L8OfAhqMs+oE4O6yl/GbvAWBVXfS1diFC/ZbdOHkAlkVmkuYZruoL+oaaSxyrIfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782161033; c=relaxed/simple;
	bh=PmY9a393FkPMi7cXE1kIXzUX+srKCbPNwHhnlFRxeaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tV0GuM+gxgyMAtCVOVe4WOD6BnqKX29t0Sa/IhuwAKuc61WXoBDZgoS7knKMaScP00ZyMkNpygdna7m9HlvkO24quTkswVj/MOqgsExC6AaPg74JhFEpjU26p13jlUlgz0yZG651+rJOSOY1A2hiJtkaEVFfV49o/8PFHoG6H1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=okXjPV0A; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="okXjPV0A"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6974a6e54dbso6211104a12.2
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:43:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782161031; cv=none;
        d=google.com; s=arc-20240605;
        b=N0sijhxeTy0Bx4hP2BDRYMgAyRYtsvwJmAflskPn/GQqUpCUxTQnbtff7vFHnZnmy4
         hpSCajGPOf17zirVU6ybolJabW01xy/5WMcWR/ottElyvD8+nHx4aG5OPoKVltF5LF9Z
         rMBooLrpi5Hp+GWWDf7s9ltWAAnnX1qpD+IWYbUye1W8QPjy4PUKJyHQ0CXdNA4ZGyh1
         8QqW2yGhk3TCr9FMG7d4VzZ61UEqMXcuDq52WtSSg1Y61pdNCuszPrrZDCXRBDwANIJe
         337du6SWImcFeoNwlBhmKQhyjnytRib3L8Z8sThTJu6lz5FugDxtnU0lCNQFIth3UIGV
         of/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LK9z00ubzec0E/FSX4Kl4K5PC+aZIx5IC8zFGof99gs=;
        fh=LDzpXBjl55ZQPVDfk1+qRirqMHolVXUx4WFk1dTv4sc=;
        b=Ev3JCjUAo+cbDhuSHxMlq6YT7pOwoCuUg1sy8PHpVu4+89pD6ztwQiFJqMri9xSb+I
         kfChCefW8iY1NuaIo5+mVvmFemKd+gS5s22NB777omgLgVyVB4JRaw1YHxYz5eIEZv76
         wZoLZQDOKTiPMXttyufBuSfSbtf0JMhc7AZwU+jbmWqKWbWqKB3OCLJnm2cTdJMhj5Yl
         qpAwA4DMhYFyhNhFncxXgqDz3uyGGkTeIqo7JDF4KrQ/kZJeKF2g9haNG2Tebxdtj+Rq
         uemMDhQJD9OEfdkfFxQlLOYZzvHluyj+GrxfTXms/dAyviV/jabFSueCtfYmymFM/Bbv
         FqjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782161031; x=1782765831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LK9z00ubzec0E/FSX4Kl4K5PC+aZIx5IC8zFGof99gs=;
        b=okXjPV0AOSJKvZm7tQjyO7uxpIS5W9igsAWDUnJxqXu4LGRBVY/BmykQWaUu0nL0bX
         +ph0Q9E2NzDsdY1Ec7GJ1MqWhEETd4a0PXQgeATcI/XYzznigwM04kKsH0nsAgG7wihn
         wdfplEWxQQ/M37Z7klWPJD6yHJscOskP9TF1/dKr5yYeqYoi6aQuQGux00hMEP+QDDQl
         4y7H4p5wKDE6VEIXhm6/qgOEPeJBHRN5i/WVzf/kKx1Cgp1zFqQjo+ANlqO+p01wWfAq
         Ff3a7lz4Yw6dUt3yoN4Uc4Elo43Dj1J7bL6q6dOM3LZf5GrN5B71k9Q21xZULv97DHLy
         a+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782161031; x=1782765831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LK9z00ubzec0E/FSX4Kl4K5PC+aZIx5IC8zFGof99gs=;
        b=ErxjOX6WRXZPmwzwaN/X8Ypu+GGLSlYrEqMDmXNgEhghG4g9iDvP+NqHNXInMA3SpP
         qPOEThdiAGCSOY7ywa3h27oMIFwpbfgXpq2MnemRaH6KUQnxUyIxrl2dE3aRoE+6dMBH
         OFPJjTOzhl9kONKcMFIJ0QSVdOdMz3Vra5YvSUGmp2H3neDEI/A4j9yNAvtH/wAU6fPP
         RlTx1hATzBHtaRJTrkMu/VvR6ZghRGBh8P1K++xLH1k5CkCKyOtIyFGWFyLvoxZiALVZ
         FaaZLd3E54JyZ7TR+8eNntr80G8MSiLGAoq5WqzfQtadiQ5UhG8f5LVmhvXNnti5GFr5
         4lLA==
X-Forwarded-Encrypted: i=1; AFNElJ8C/5XXsAaiEMKPXwrVas5+xboMg8HjQAn4BYahPlYtIdNX+Z3S1AF0mRxKEf3ndfew2Zwy5J0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9yoWmV189WeAcU6OLr9hLZIP89ke+xPSF1xPt30ws/2ccaCRj
	cUgfg7DKF9BX5kPtl5BxPszF6qD4+Ch85rrdw0Gf6GafcgCdYTWSTMBUdODuEhOXfWov1mQ3Gob
	Cqs0NC3m7iI5aDt32IOI6fD4pMmgtSg/vmXDFE4phZdAvVsjdK3qnrJGNvQ==
X-Gm-Gg: AfdE7ckN0VN5smtI9rl+E3tJ2Sb138ZGCzTGa+UxRoLh+/u2rk05JItBt/++tBbuJ+7
	RJ4CGvE5TkVzkIc5MYzBcAjAsm4bJrsjtf/uh6Fb0tjbLf+EXJ6AmsGA+0hhjacCY4qcvZbXGIe
	SQl89wxMk3bHnFp1xdPbZVHiTRkpyu3+/nhw5ui64rkDF0ZqgY3AEy0vpyq1ivlNP0TP2adNthx
	uCuakJRasa60AwBh1L4XiWQRIJUZLCL13bHn/4+Qh4uNQ86CjEisVu+lO3LuRBwxGy9JJFWxFpm
	aGyquy/CLw98IGzGZtxg39mTn4NGJX0=
X-Received: by 2002:a05:6402:5203:b0:68d:d511:4a9f with SMTP id
 4fb4d7f45d1cf-6970f7bb394mr10422389a12.18.1782161030519; Mon, 22 Jun 2026
 13:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605-exynos-pmu-cpuhp-idle-fixes-v1-0-0cd05c81a82d@linaro.org>
 <20260605-exynos-pmu-cpuhp-idle-fixes-v1-3-0cd05c81a82d@linaro.org>
 <CADrjBPq4fou5KWh4T=oNkUVPz5Jk-821OVe3j5sWrKnCtHYM6w@mail.gmail.com>
 <DJ5GP6VQJDHL.2V30K56ME95DO@linaro.org> <CADrjBPqF6GPRLNUZtzkGUHTUQ6NOPoaRvVvF1mUUj_DJ9As1dg@mail.gmail.com>
 <DJFT3TXC0OJA.1ZK17YA2RSQXK@linaro.org>
In-Reply-To: <DJFT3TXC0OJA.1ZK17YA2RSQXK@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 22 Jun 2026 21:43:39 +0100
X-Gm-Features: AVVi8CcSJhlsiEYo8DbJV4KtarpnAeTWxw-4zzSg6pxbzuPPjnCW8fducZqtX0Y
Message-ID: <CADrjBPovA8Kpzjqwr5w0UvqYhpdGyBwpv=xkBLcGGuwZZoocPg@mail.gmail.com>
Subject: Re: [PATCH 3/3] soc: samsung: exynos-pmu: fix error paths in
 cpuhotplug/idle states setup
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Alexey,

On Mon, 22 Jun 2026 at 19:57, Alexey Klimov <alexey.klimov@linaro.org> wrote:
[..]
> >> >
> >> > I originally made the failure non-fatal because the system still boots
> >> > without the notifiers registered (and all other Arm64 Exynos SoCs
> >> > upstream don't register notifiers and AFAICT have broken cpu hotplug
> >> > and cpu idle).
> >> >
> >> > In hindsight, that seems like a mistake. I think your patch to fully
> >> > unwind everything in case of failure makes more sense.  See small
> >> > comment below about destroy_cpuhp_and_cpuidle()
> >>
> >> Wait, setup_cpuhp_and_cpuidle() should be non-fatal and shouldn't
> >> return any errors?
> >
> > I suggest you re-read my above comment above ^^
>
> Could you please clarify what specifically addresses my question about
> notifiers?

Sure, I was referring to this part of my previous reply:

> >> > In hindsight, that seems like a mistake. I think your patch to fully
> >> > unwind everything in case of failure makes more sense.

[..]
>
> If c2 idles are used during reboot/shutdown then they fail or what?

This followed similar logic to the Samsung downstream kernel drivers.
I have no extra information about it beyond the downstream kernel
source. It seemed reasonable though that CPU's will be hotplugged
during suspend and reboot so you may wish to ignore these.

The proper solution of course is a fully PSCI compliant firmware,
which doesn't require these side channel hints.

>
> I am not saying that patch is correct and some rework is needed but I don't
> get why we should completely ignore errors from hotplug states registration
> and should not check registration of notifiers. At least warning should be
> shown to user that pm functionality might be unreliable.

As mentioned above, and in my previous reply, I think your proposed
patch is a good idea.

regards,

Peter
