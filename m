Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94832EFD9B
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206673; cv=none; b=J4lsHiH3QzghrIP1Coyub5np8UcgwWbApgA9/xYpbJ6HjcguxCWFsyERjUME4KsQ3Txeggfq4oxh+XdsT1edS6R1f4Fb6MNeJZrLXZ8r+ZhMkFOre4zNA14gwRuw8dNQILYLX+xHyn/vXo3v7Q7XklFZHsNIPO+Z3enp79omYPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206673; c=relaxed/simple;
	bh=ms7AIU8iFFaoa0Ma9a1omLId+z2jTN6MXG5dawWMtgY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=a1D7uPShiEnokml4LaVogeZewcWxwh2BwLEPGDDz3Fo/0QNARRX4eJQL461EM8WbjVie026jpuTMQrS2e0OP3vkVr8robftznINndWZyezWIM9uqxmbS9zFgBmvGmgewxmVLfEK5pZ0udjfbPZeWrvehwbb7lPzzYTS5bJVP6wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jAcAcAuq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jAcAcAuq"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-475881b9a4bso3048800f8f.3
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 05:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784206669; x=1784811469; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0LYFgy4yfYQhPuAiPz9CB3wYdVuPpzUCUHrbqHln8gc=;
        b=jAcAcAuqmFZDp2BO+tdEPoUbfhKkQyvzes1jODCJv0PIynlz/YQ97EoaO2J01jCbVf
         PJUOS+8Pn52MdTXPpM5GOVUoj/q+YgHrTocxhbnTWVgsug3sckL8DpG3XvEOKQ5XizvZ
         L2rFYLjAHzk6wXeT9bsIIfpH4+Akwp7AkF5pqfxa04H2Mzmhcd25Z/PWov/J687fU+y6
         6e51yVQrLpLnYXNJxXa8TCa/32lyJej/j/0lq0dvlySvyFWEmAbCTLGVmPof6MGK4hlV
         nJy2v9KXSk7uy2dBY+LubmuF82XoM8L487JuVfEhlRWLkcOF7QM8dPbJG/5cf6Un5ua0
         vaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784206669; x=1784811469;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0LYFgy4yfYQhPuAiPz9CB3wYdVuPpzUCUHrbqHln8gc=;
        b=PfVBZwiUBYZPQB3/81X8GAA+q/4DFfpV4I3Ar8hg4CvQNoln7M/MSBlcbGflV7S7cu
         BCY+xwaIbimHF+jk6c/Eopk0CkS9V1nRFItVTSiquvBbDpN0PnXvVixMngFpQV+SHB1p
         ehCFotuXEiyp8zj8UAym+xuMJ1nHFyiKR8uQvqp0lTiCEib+s8MveUWmEb8piyWEufLx
         Xfem0pF/r0HJjC4OwULU2C9Px320YTnsY3UGuhdv4ATC25ctFBWofP3Nwt0Recr3SmGt
         UPrGzw+MMYWoAtx8y+5q5SAdZU4+sL1EKNGg/wp6lP9g/VyUKXHEjjbqjLxhLeDasXi6
         9MBg==
X-Forwarded-Encrypted: i=1; AHgh+RoTt2vaXuD6jaxrsgcmDh26FI4edm45yto+X24roj+RoB0uAGMPSOFET7Yj/owo16+dXVrLkJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2eBqAyxsrsndJZXpQ/hGSrzYovpfPefr/4p0KGuU+1CDtekV
	ZDZkaCrW+eLuaR2zcuNKHlFC3DZTLBL8FD5HDFXaX3/O/Ga65q85CUNan3B69wafJBOKceaYWa1
	cutCW
X-Gm-Gg: AfdE7ckhggp1n4CuRRqIdaH2T5frmXu28bGQm3JBzqAG6p7twrNbvkw6DbccUK8MU1g
	bUUJ9NLMsZM2Kwp9rxtmFt97ze+F50qlMAdEVjljJ3eS0VkTFntGRzgaB5iGgeu0BJdUykoag9W
	0CNboKKfeLc46NjqNcOyoNM/tXF9bTXJCEi5Agjv5GbE3SRPze8/+2xdAP6jXwtgWTe/FA27joA
	NxYOPRNYcH6pcl/UZ0ji8QYazoNzSXH67HkJSG006I0R5MyDdRwQNQ+6YJjPaarQ9KKRK7z1O+5
	mtZlsXuk7gBA7AxW1Zt3z+aQh4fQfWFxznXm4CvjBYT9AoSOCq3mw/WIiuGgKjzLJIOXrXHPBT+
	4Y8vcTjYA0yCVXFRIYyrl4JM+TGxUTadHelMWD3XZ3xo4EIsvKumRRXiGwf8LYxm6BrsvXrFHqt
	3mptzJWg05VFHvbO4/lwJpuDYofx8t/ghk9Bub7KyTvvU+MIzkV3PzzMv1VMen+hp7dJhL
X-Received: by 2002:a05:6000:1867:b0:473:1ccc:15cc with SMTP id ffacd0b85a97d-47f2da80da8mr24985592f8f.0.1784206669165;
        Thu, 16 Jul 2026 05:57:49 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:5e58:c548:d5e9:96bf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464b7e22sm23722294f8f.25.2026.07.16.05.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 05:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 13:57:47 +0100
Message-Id: <DK00H7RT3OUP.6XS03TKMIU34@linaro.org>
Subject: Re: [PATCH 3/3] soc: samsung: exynos-pmu: fix error paths in
 cpuhotplug/idle states setup
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Peter Griffin" <peter.griffin@linaro.org>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, "Alim Akhtar"
 <alim.akhtar@samsung.com>, "Sam Protsenko" <semen.protsenko@linaro.org>,
 <linux-samsung-soc@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260605-exynos-pmu-cpuhp-idle-fixes-v1-0-0cd05c81a82d@linaro.org> <20260605-exynos-pmu-cpuhp-idle-fixes-v1-3-0cd05c81a82d@linaro.org> <CADrjBPq4fou5KWh4T=oNkUVPz5Jk-821OVe3j5sWrKnCtHYM6w@mail.gmail.com> <DJ5GP6VQJDHL.2V30K56ME95DO@linaro.org> <CADrjBPqF6GPRLNUZtzkGUHTUQ6NOPoaRvVvF1mUUj_DJ9As1dg@mail.gmail.com> <DJFT3TXC0OJA.1ZK17YA2RSQXK@linaro.org> <CADrjBPovA8Kpzjqwr5w0UvqYhpdGyBwpv=xkBLcGGuwZZoocPg@mail.gmail.com>
In-Reply-To: <CADrjBPovA8Kpzjqwr5w0UvqYhpdGyBwpv=xkBLcGGuwZZoocPg@mail.gmail.com>

Hi Peter,

On Mon Jun 22, 2026 at 9:43 PM BST, Peter Griffin wrote:
> Hi Alexey,
>
> On Mon, 22 Jun 2026 at 19:57, Alexey Klimov <alexey.klimov@linaro.org> wr=
ote:
> [..]
>> >> >
>> >> > I originally made the failure non-fatal because the system still bo=
ots
>> >> > without the notifiers registered (and all other Arm64 Exynos SoCs
>> >> > upstream don't register notifiers and AFAICT have broken cpu hotplu=
g
>> >> > and cpu idle).
>> >> >
>> >> > In hindsight, that seems like a mistake. I think your patch to full=
y
>> >> > unwind everything in case of failure makes more sense.  See small
>> >> > comment below about destroy_cpuhp_and_cpuidle()
>> >>
>> >> Wait, setup_cpuhp_and_cpuidle() should be non-fatal and shouldn't
>> >> return any errors?
>> >
>> > I suggest you re-read my above comment above ^^
>>
>> Could you please clarify what specifically addresses my question about
>> notifiers?
>
> Sure, I was referring to this part of my previous reply:
>
>> >> > In hindsight, that seems like a mistake. I think your patch to full=
y
>> >> > unwind everything in case of failure makes more sense.
>
> [..]
>>
>> If c2 idles are used during reboot/shutdown then they fail or what?
>
> This followed similar logic to the Samsung downstream kernel drivers.
> I have no extra information about it beyond the downstream kernel
> source. It seemed reasonable though that CPU's will be hotplugged
> during suspend and reboot so you may wish to ignore these.
>
> The proper solution of course is a fully PSCI compliant firmware,
> which doesn't require these side channel hints.

It seems there is some misunderstanding, where we are not getting to the
point. I think I still do not see any comment about failed notifiers
and question about c2 idle states is kinda misdirected.
I also don't see any answers that clarify this from previous emails:

>Why do we need to have notifiers (say cpu_pm_register_notifier())
>registered if, for instance, cpuhp_setup_state() fails?

Let's jump to the details then to move it forward somewhere.

If one of the cpuhp_setup_state() fails and in the current sources
(without this patch) we don't check if it succeeds or not we may not
have properly working hotplug notifiers =3D>
{set,clear}_bit(cpu, pmu_context->in_cpuhp) may not be updated
correctly.

The if-check logic in cpuidle callback:

        if (test_bit(cpu, pmu_context->in_cpuhp)) {
                raw_spin_unlock(&pmu_context->cpupm_lock);
                return NOTIFY_BAD;
        }

relies on that and may not work reliably. As a result c2 idle states
may stop working or offlined CPU may be put into c2 idle state.

Going further, if register_reboot_notifier() fails and we don't
check its return value then

        /* Ignore CPU_PM_ENTER event in reboot or suspend sequence. */
        if (pmu_context->sys_insuspend || pmu_context->sys_inreboot) {
                raw_spin_unlock(&pmu_context->cpupm_lock);
                return NOTIFY_OK;
        }

a CPU can be put or at least attempted to be put into c2 idle state.
That's why there was a question:

>> If c2 idles are used during reboot/shutdown then they fail or what?

If it is fine to use c2 idle states during power off or reboot,
then why the code blocks them during power off/reboot?

>> I am not saying that patch is correct and some rework is needed but I do=
n't
>> get why we should completely ignore errors from hotplug states registrat=
ion
>> and should not check registration of notifiers. At least warning should =
be
>> shown to user that pm functionality might be unreliable.
>
> As mentioned above, and in my previous reply, I think your proposed
> patch is a good idea.

You mentioned, so far as I understood your replies, that _only_
destroy_cpuhp_and_cpuidle() is useful and setup_cpuhp_and_cpuidle()
should be non-fatal. I still think there are some needed error paths for
setup_cpuhp_and_cpuidle() as described above.

Best regards,
Alexey.

