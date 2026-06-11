Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0423264D4
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161642; cv=pass; b=QrxCDzq9dOCTPS/xbxLhgul7CLz+BjwKtzJBCfycyeHKrTMKEriS3xL1M+8YK1zCatO8a1hBKdfQmDDrPCXUQmHhyeVOj44MOxDxqb/IPBQVtqTL8wkRxQUFa6uYueEUVKus/POPVLFOCBaek9fEMIZ3IztA62LTWuKy5BP6zJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161642; c=relaxed/simple;
	bh=xN2LpMjZu5K7DVB0JhBTnaF6qsi0f6S98BwkA4HP9IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xa3wHaY7g1lkDL+CRHsh6fvRrx95wVkZl2tQRZMHcFrpVZA1wW/rY7mX8VPWBH3LrBNzBw/krinJHmqPcDNbdHrZXz6r4RjuKCFvniumHaThXrYEkwp+ww4KUwv9vll4MmkbVNF0XygPi9/O2CjbwHIogAv+WFj6BegtofPjEFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uad1jsjg; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uad1jsjg"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-68bac6e24fdso10208551a12.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 00:07:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781161639; cv=none;
        d=google.com; s=arc-20240605;
        b=KEPGk5Ok3KycEk3H5gaxRQ4QVaFyU67qFI3zBIu9XDLMnUoMeXFl0GLJJZBRzZcC7X
         498oR6tlDOQ302X0G0Z1mPna9R7UgrvGlr/tpGGgFEhDEA0NmRaOjb/79YhsLbuSvSoM
         eYoisKqetUO7f6KzRxUlvBv0jT5B5yn9ClYIOqZCWBCjifPMgjSIYStcVvML+KhfM2Qp
         lezqrz9V7Cpz+5zMFUltJAOLWDVNNjvsXdG68a/KmzeLwafr9j3AQhGPsxuzOnvUvI5s
         oxVwda3PCCY+oCK6GRJ37JEqiyOBeOEkrFfs2GrQ01U1CNelIwMr7RP9L3Jw+h0BINSi
         pI7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AEpk5nvUQrP2hOPNfotCvTIhHCWOPoRQlVlTaAX6Z7w=;
        fh=kxTmNybD7oCcAjMADKa3Phk/wRFvq11wiDeBEhxB4wU=;
        b=kXccHATvYnfLerBy2prJhSVkoLkEJn2IYVqygbK48k8C8XjMDcnyrI2hinmc56zjZn
         cYDBrhT9CMIz47yM7o/p9tPD3iIN5ihXXjL7P2Qt/tj+jdOTDqek/Z1KiBJeSJaN+at1
         NUYRVmZ6YMcwvugbPkV9447iYpfKd9avfp0PqHGNOVz6cZHweDTy0yy53PXR+jxYh6eC
         CgeCW+xdSgT0fpTOOspuuUgAVtsDG3JJ+t/0mEFWmqwaeVbFV4XG4m1QaKxah/H8oLH3
         WmvQz3Y6KOy/ctToRVuAUq0sfiHSO0nxur2fc92oGcGIWBpZpO/+6mmkdEhpJu+EMxwN
         mL2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781161639; x=1781766439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AEpk5nvUQrP2hOPNfotCvTIhHCWOPoRQlVlTaAX6Z7w=;
        b=Uad1jsjgMMxeVF+rFkzhlnKhcxuqXiVxg6zHIdCYr1XJ5ZoyLoYzBoLyv6arGMfaqW
         AvpxpKVHWAhv5av/0ni6x7yhxPyrlm2gbZqJMLxcjtA9icDrqw9gry8Xxymr1zsaZRcB
         wrSthcZuHwjZlzq8X/XdGTX29WF7p/wrti9wwBFEk749XmRESjo+DqkhsunbqnfWQ0RX
         FrtBxVHtZse4ZN2UCsMvgf0faqIve8Jc2o5EEpnxzwlCaDz5F9SSKd/QDaBpRYrpDPte
         Hk+rKOb8dYlzHs4slCOnqi5iPA4SHyOXvP+xd2qRJsBJwwHn5JqlGoHmOta5dHmtoBAD
         ZHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161639; x=1781766439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEpk5nvUQrP2hOPNfotCvTIhHCWOPoRQlVlTaAX6Z7w=;
        b=lKtM4CU7YEAJpWBIrc8PrVTkHWVEAdREAivjiV+icpBKnrod7jVs/Cqx1Z5dSzqiii
         kz7yUIKN71vst/CSKuwG9UbYoDA2AJ+RFEiTky1QNMgAK5x9JwD1cydP+W+aNYNmkmOB
         q/X3y7lUn0amS+ibavXwUP4PCA4c1aNZzRec0z4N/aM+Nj30awSxWOwwxjFpka9e8ss5
         BhtqbTYWhRJVO8cCkqqiZKO3J0dEokLQXH99jsWVVTIyqaxmHUJnCFoOlwH+20t2uTUx
         I+js6L0Jjuz+eDhYSgutGsT5jdPyInCenP0JWDpsuc+jC6Rm9Yql4sRHJC/fV4XkJIpv
         5DnA==
X-Forwarded-Encrypted: i=1; AFNElJ9Tv7XTKCP2V6GO/b17plIpBhbIC5JIMO2LpDieX2wOYe9kgx9KAzBCdVNqBCaLXGzVJxA7/qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYik9dJOSbp3Y5lUR25MP69UQ5zLfpDFKWkUb+4Y3PKaTn0q/j
	M7iW7RsSnGMe7gWiIwkum2pq4wSk4qlmAnVTIJEQqwCrKvIxe3XoQDSnN36XiEU5STiCf4LUzCB
	xdBK49yh5QbsdaHzkpeIL5jrjKgvxTmgPQDANcHzONA==
X-Gm-Gg: Acq92OFr3aafBZtD8Flul4pmyABWx2bEj5IYMXVZ27pYjljdxUHf3bkipj3ieBqmgpa
	YTx0rG2w1d2JduBJAjTnbSL01qKdWAj6AMCzcIVWv1G+mbi1ADMYOGI6NJkPpCg4X1IotWMCGof
	WrER136tBRozGqNLKVWx6TjVRXgNG3/d0WGgdSPJH5E/Y8uJMK9klLAhmRCKE4Edw4z60o2hJ60
	qrzs71EG5XN9DeViXb7qKmoX4iA40uOHOG+fUoljWHK1iiiXzwLGXM0aNM5cJe04BZEmVPdF6fu
	qMft2gay66jVXQDcsetWzhGnqE6bQIvZLOeKVgF2KD4nwVZTKRK6
X-Received: by 2002:a05:6402:440a:b0:68d:623a:bc77 with SMTP id
 4fb4d7f45d1cf-6930e282296mr669421a12.8.1781161639285; Thu, 11 Jun 2026
 00:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605-exynos-pmu-cpuhp-idle-fixes-v1-0-0cd05c81a82d@linaro.org>
 <20260605-exynos-pmu-cpuhp-idle-fixes-v1-3-0cd05c81a82d@linaro.org>
 <CADrjBPq4fou5KWh4T=oNkUVPz5Jk-821OVe3j5sWrKnCtHYM6w@mail.gmail.com> <DJ5GP6VQJDHL.2V30K56ME95DO@linaro.org>
In-Reply-To: <DJ5GP6VQJDHL.2V30K56ME95DO@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 11 Jun 2026 08:07:07 +0100
X-Gm-Features: AVVi8Ce9AFTdn5GgI4FGeBsq66vruRZqhouaV1W8cJvhIjXpfYGWOCqf13Hq8Oo
Message-ID: <CADrjBPqF6GPRLNUZtzkGUHTUQ6NOPoaRvVvF1mUUj_DJ9As1dg@mail.gmail.com>
Subject: Re: [PATCH 3/3] soc: samsung: exynos-pmu: fix error paths in
 cpuhotplug/idle states setup
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Alexey,

On Wed, 10 Jun 2026 at 16:07, Alexey Klimov <alexey.klimov@linaro.org> wrote:
>
> On Wed Jun 10, 2026 at 2:34 PM BST, Peter Griffin wrote:
> > Hi Alexey,
>
> Hi Peter,
>
> > Thanks for your patch!
> >
> > On Fri, 5 Jun 2026 at 21:19, Alexey Klimov <alexey.klimov@linaro.org> wrote:
> >>
> >> The setup_cpuhp_and_cpuidle() initialisation sequence currently ignores
> >> the return values of cpuhp_setup_state(), cpu_pm_register_notifier(), and
> >> register_reboot_notifier(). If any of these registrations fail during
> >> probe() routine, the driver returns 0, leaving the driver partially
> >> configured.
> >
> > I originally made the failure non-fatal because the system still boots
> > without the notifiers registered (and all other Arm64 Exynos SoCs
> > upstream don't register notifiers and AFAICT have broken cpu hotplug
> > and cpu idle).
> >
> > In hindsight, that seems like a mistake. I think your patch to fully
> > unwind everything in case of failure makes more sense.  See small
> > comment below about destroy_cpuhp_and_cpuidle()
>
> Wait, setup_cpuhp_and_cpuidle() should be non-fatal and shouldn't
> return any errors?

I suggest you re-read my above comment above ^^

Peter.
