Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B96439320
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838325; cv=pass; b=WXnzPSWwqEpgmK8jHEbJckPzCjBLVUh0GMO+FN83j10a2RZg5GrdCSQYuB2LE77dGcvrpMuI5hqjx0gPWEkfSPBfL1Av5Iv2uzK3UXNEX3+leedXA7W+fxSCbxOwC9vEAYPAQDG/61U6dwJ6m+NSczh9+oZiO1EXLLTcvgjjnow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838325; c=relaxed/simple;
	bh=oteyxLemS+IHJBZ/U9bbowhrf6bbX8xAI+nDGXODOWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBlOg3gMElawL30h7ezYL3+lfAJ+6W1u2znFCLrJxGCUv0/7Jli4Zu0/JlLGfzYRUNSs/HPmfeTARe8P+PF4J56E8kvEufRvPh+GKctqtqKqz5Y4tiXncKuKGFtmr9sgXtMXeMtOihNKwx+H3Lg13xSl8LQ55tCQkKSbkHKuVjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r7JwPXxV; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r7JwPXxV"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1c52d920b8so626475266b.2
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 03:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785838321; cv=none;
        d=google.com; s=arc-20260327;
        b=IeF58G5FFm4PXZfkfmHszRCXvKJYx0d2thT4tPHQK0RZJmZF8r1CorkEZd43qNRHBO
         rofPHyyH2vO9aSK+xyDb3gFabFNcJklhwBQ84G7CtfJaraSqTEeLaz3AHMVlPFN2dJL5
         kYj2K+yVj3qs2aSgJXwVUzlMKXEl8j87NQLTwUz9h5+CgmzG+bhefWGawxIWYvqMVU07
         7agIYbfLSw0XVCOXp+UQ/K1Cg7q/qtPy8lKW5vukZvEJZV0jYlA56tgG8235ixKVCUDF
         lFncKe60fbnX1eHU+ibPwv7RHFfgG5eNcyHjtw7c3KsjtSURUjz/zeCpnZKjcm6lsl8z
         tImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3fT0yy7k6aVn8xwuYBWmP3Y+ZHenzu63FaqBq4B3FSs=;
        fh=rxaUpoQj2FHIUOvjMfobRzbxUDH21UDotKwnSu3fZDw=;
        b=icd5P9p1u5k5nlSzs5ccrvd1Izpn0GKKloE9IhFeY/U4KbgaPuDoyNueKEkpLM4gLc
         imA3GJsf+xoIsb/cWC0AF2NtOcmKIfoBMMwbug5EwT9IzdELA11w/Pm4QTBlE/b0cVLz
         fFpB7HOaD6EXDpGT0KBRlfYtFrVhlY8VgjRgko512srtpI4MqYmkKiSeD0QuVNGpuemU
         KhA/d3ygIounxypCvGJdDYt1wRxok7B6E8i6PWHnN4hP208vpf1toG0UE69BUAw79oVl
         5oFjzsu7mECkP3Mxw0383X1e0TPWngc2UgU4+Yr8EhMH53er0It09o7JrqyHYYLo9qua
         /zgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785838321; x=1786443121; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3fT0yy7k6aVn8xwuYBWmP3Y+ZHenzu63FaqBq4B3FSs=;
        b=r7JwPXxVMCfQthpB/MUMvM1dq5L67lRLFFsOPla7KLSVKKjLTLvRnmXnqqCp1DEfSN
         YZIGPl4nM0PWTG8fyYNz6x2EAold0oDelbihUtNWxRAFljd+Fmb+O8EgKe33w7cm1vJ9
         wK+YtIrJfuZvZj0SXA8Gts7Uwe6S0cwth0WaBW6Koak1eXXLH0oKj69IazR54bC0Oc4N
         pJwFkWUg2L+4NRdnYnToYpn68WlcDge8lZCC5mJ5Q6CWv4eQk79pu3uovzMnCcF+dtP5
         d3sdZ0sJE6Jmt8GQow0G1Qd1CEbjElFgp0sFoGWGyicFzFN3c2x6v2+zqgpPtublSKYY
         5QUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785838321; x=1786443121;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3fT0yy7k6aVn8xwuYBWmP3Y+ZHenzu63FaqBq4B3FSs=;
        b=DbpfLGUO7QnexFzmBMTsyLQ+7ZK+Ci44pX+ryMxzTAdQYn6DW8KNK6XmIJeUZyNJ28
         FvXKaAvxGi8KMug7Iy6MWt337Ti0NRP67YwsZi0QyOrdSs4SI3e4u1tZTmJ3veAO9c2c
         ogGen5aPuEgd3Uzrcu0b/neqOzjkV7RqKusomWm/2MjrUV5i1GV8ltWxI8hycFO/Ctcz
         EteEgza2PEWugz0GRgFA1He7JKCREQLUyCWcUq1/NVixP5NODZFlW501kJf1gJS+3k6o
         F/oO4SJWSFiOG5Lm1AKT5nIp8Tl758EyEaC1a/BRzU25urtUtueyDSNRUCKRo9pYYmUt
         pfBQ==
X-Forwarded-Encrypted: i=1; AHgh+RogakCmPjunu8nLvhcgmOhP78BD5j4V1ZpsZH2AxRV+1PKB/6CwA/hxNDULsV/bj4B/RMJdLuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw4aPKk7PUJO4rIiqcM3k7nXMoCy/Dzsvz6WF02TX0wJkTnuZm
	6EOSGUziJ4NnqzgU2onwGKhno8JWr1UU5jCbsVdMuK/ZfGwI/+r0g6N3hfc2nIGQZAW0rhv9wFV
	aQ378GnWeexfHqEahuBTvhvSqo0iKlots9R/PV6oFDg==
X-Gm-Gg: AR+sD12cbwKodCmUzunCpgICiL9nvDqANJ+z+moKkXlCBcrgqAirq82OMxL80TnphDZ
	bVb+RgIyVrD/20CG9LrBRI7tsF0xrWCrOf7sFbdx9+uNd1drrHCEYTJWrnVGS8JDp60oDfDNLSM
	/KzqyR4dkY3aARqlJCjIUNRy4F31tnf4LsS0mI2s6+3jswS3uVX2GMQmzkbjGDTsW/mW6F6C8lK
	pFpdn0WlcHcNWZAtR9sYPhy8F/AqBKorDZsfy977p3yDY8jXtT+rEx2giWL7/xzTntSMBvecw/b
	/kfZbLqWGBb6pgxXNhvBLbItCnTzX+VgTl2LdUiYq4fNXqCsqZpHF7W2cmX6K4IvYmIUQeMxwMH
	g0xM=
X-Received: by 2002:a17:907:c007:b0:c15:dcc6:d06d with SMTP id
 a640c23a62f3a-c1fe7d11095mr1281460266b.0.1785838321130; Tue, 04 Aug 2026
 03:12:01 -0700 (PDT)
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
 <DJFT3TXC0OJA.1ZK17YA2RSQXK@linaro.org> <CADrjBPovA8Kpzjqwr5w0UvqYhpdGyBwpv=xkBLcGGuwZZoocPg@mail.gmail.com>
 <DK00H7RT3OUP.6XS03TKMIU34@linaro.org>
In-Reply-To: <DK00H7RT3OUP.6XS03TKMIU34@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 4 Aug 2026 11:11:49 +0100
X-Gm-Features: AUfX_mz5t_Pe04iy5Urjl5FLntfM2UaJUBsRQk-xp7uJxfwmN41IPr1rHKikzkY
Message-ID: <CADrjBPpk1beXfAJ7uhKHwYKo1wDPg+qxwfc-PQgZL6dcAN1CDA@mail.gmail.com>
Subject: Re: [PATCH 3/3] soc: samsung: exynos-pmu: fix error paths in
 cpuhotplug/idle states setup
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Alexey,

Apologies, I've been on vacation 2 of the last 3 weeks, but I thought
we had this all sorted.

On Thu, 16 Jul 2026 at 13:57, Alexey Klimov <alexey.klimov@linaro.org> wrote:
>
> Hi Peter,
>
> On Mon Jun 22, 2026 at 9:43 PM BST, Peter Griffin wrote:
> > Hi Alexey,
> >
> > On Mon, 22 Jun 2026 at 19:57, Alexey Klimov <alexey.klimov@linaro.org> wrote:
> > [..]
> >> >> >
> >> >> > I originally made the failure non-fatal because the system still boots
> >> >> > without the notifiers registered (and all other Arm64 Exynos SoCs
> >> >> > upstream don't register notifiers and AFAICT have broken cpu hotplug
> >> >> > and cpu idle).
> >> >> >
> >> >> > In hindsight, that seems like a mistake. I think your patch to fully
> >> >> > unwind everything in case of failure makes more sense.  See small
> >> >> > comment below about destroy_cpuhp_and_cpuidle()
> >> >>
> >> >> Wait, setup_cpuhp_and_cpuidle() should be non-fatal and shouldn't
> >> >> return any errors?
> >> >
> >> > I suggest you re-read my above comment above ^^
> >>
> >> Could you please clarify what specifically addresses my question about
> >> notifiers?
> >
> > Sure, I was referring to this part of my previous reply:
> >
> >> >> > In hindsight, that seems like a mistake. I think your patch to fully
> >> >> > unwind everything in case of failure makes more sense.
> >
> > [..]
> >>
> >> If c2 idles are used during reboot/shutdown then they fail or what?
> >
> > This followed similar logic to the Samsung downstream kernel drivers.
> > I have no extra information about it beyond the downstream kernel
> > source. It seemed reasonable though that CPU's will be hotplugged
> > during suspend and reboot so you may wish to ignore these.
> >
> > The proper solution of course is a fully PSCI compliant firmware,
> > which doesn't require these side channel hints.
>
> It seems there is some misunderstanding, where we are not getting to the
> point.

From my point of view your proposed patch looks good, as I mentioned
in my earlier replies. The only reason for not sending a reviewed-by
tag was the outstanding piece of feedback regarding only calling
destroy_cpuhp_and_cpuidle() for platforms that called
setup_cpuhp_and_cpuidle(). Currently it is only gs101 that calls
setup_cpuhp_and_cpuidle() but in your patch you call
destroy_cpuhp_and_cpuidle() unconditionally. Will that cause issues
for other SoCs?

> I think I still do not see any comment about failed notifiers
> and question about c2 idle states is kinda misdirected.
> I also don't see any answers that clarify this from previous emails:

As I understand it your proposed patch fixes all the issues you are
asking questions about? Is there some outstanding point that your
patch hasn't already addressed?

>
> >Why do we need to have notifiers (say cpu_pm_register_notifier())
> >registered if, for instance, cpuhp_setup_state() fails?
>
> Let's jump to the details then to move it forward somewhere.
>
> If one of the cpuhp_setup_state() fails and in the current sources
> (without this patch) we don't check if it succeeds or not we may not
> have properly working hotplug notifiers =>
> {set,clear}_bit(cpu, pmu_context->in_cpuhp) may not be updated
> correctly.
>
> The if-check logic in cpuidle callback:
>
>         if (test_bit(cpu, pmu_context->in_cpuhp)) {
>                 raw_spin_unlock(&pmu_context->cpupm_lock);
>                 return NOTIFY_BAD;
>         }
>
> relies on that and may not work reliably. As a result c2 idle states
> may stop working or offlined CPU may be put into c2 idle state.
>
> Going further, if register_reboot_notifier() fails and we don't
> check its return value then
>
>         /* Ignore CPU_PM_ENTER event in reboot or suspend sequence. */
>         if (pmu_context->sys_insuspend || pmu_context->sys_inreboot) {
>                 raw_spin_unlock(&pmu_context->cpupm_lock);
>                 return NOTIFY_OK;
>         }
>
> a CPU can be put or at least attempted to be put into c2 idle state.
> That's why there was a question:
>
> >> If c2 idles are used during reboot/shutdown then they fail or what?
>
> If it is fine to use c2 idle states during power off or reboot,
> then why the code blocks them during power off/reboot?
>
> >> I am not saying that patch is correct and some rework is needed but I don't
> >> get why we should completely ignore errors from hotplug states registration
> >> and should not check registration of notifiers. At least warning should be
> >> shown to user that pm functionality might be unreliable.
> >
> > As mentioned above, and in my previous reply, I think your proposed
> > patch is a good idea.
>
> You mentioned, so far as I understood your replies, that _only_
> destroy_cpuhp_and_cpuidle() is useful and setup_cpuhp_and_cpuidle()
> should be non-fatal.

I don't know how you reached that conclusion from my replies, as I
never said either of those things. The only outstanding point for me
in your patch was about calling destroy_cpuhp_and_cpuidle()
unconditionally for platforms that never called
setup_cpuhp_and_cpuidle(). I was expecting either a new version or
some justification as to why that's OK.

Peter
