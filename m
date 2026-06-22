Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCC534752E
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154676; cv=none; b=ON1vOqwpE9ct1L8duGwj7kSGk2ih/e+g94rHSCRnKxy4sPxD1F6UMQPUIEKxNlx6hyGXGtm26cLvI8eg/mlB85kLih7oSqOmKJ6XMQ1mXsJHxmd7s69PQFTEBO0vtp0FMkrdVmIltuyx7DSuXeplgp61Y56q+iaCYUwRjR1MzCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154676; c=relaxed/simple;
	bh=Eci/a/8tHg4tTZJiIfDpEB3IqM/YUJ/xXRXY7o2DXVc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=nzxwnNP1BzBQUWOuLoor0JIpdenTbwITkmXsCyxPh9hX+uNSlj4Lbo75F2WAaCiiVTtZXPdb0nsKeb1z1aSCrpvwc6DPYbxXR4lJbA1E8nJ4rqIoyziPxOQxCc7s7DFCGf0rJvgpNvU3Ykbs0W9+D3Bt9tPQb251xBsSsuDmH+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TKjSs/8X; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TKjSs/8X"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4629051c946so145508f8f.1
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 11:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782154673; x=1782759473; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brZs3+MH5gJMBhPZfGjHt4FXO3H2ccunenuS6LTLrkg=;
        b=TKjSs/8X4fyrzk4Qode7dCVl4Uyszpotigbr10WpOgJXCgOc2yJIf5k1acFWwlFmC0
         O1yPxyS6uBOkUVkQEroT6g48T86oTWGzzmjjeZNtYITGQlzgsqjaUUzP0QWEGWzrEBd9
         qn1FjtWm9AYz7GgrHhvAFytG5cf4cF2WPWuRgguXd2qXuwmtDN2FEPffgfFG/9SkAHLF
         4Ka2x/rxGYxu9PcTAXiWTnhUHfomyQA2G0kOjytt5+L3KqfpXicTtjJr2aw5LUIP3pLs
         8OnVRg8Tmlm+yIvK/iRvqqCQuTRMur3oinc3h5K9XsQlk0DjeI3fTiHqMAdVM3DHTmq/
         TS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154673; x=1782759473;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=brZs3+MH5gJMBhPZfGjHt4FXO3H2ccunenuS6LTLrkg=;
        b=eZqrpvE78n35B8Wu6CajQa20a1JQZr+1jxMQI8ZztWPCDxyREvKnYKm/HC1jYGlZHj
         eJD+ug97E2+G8LYMbe9Lf76X6DKWTAhCvcSSHj9qHpPlg/8ZqAi4e+tsyiQa8Kvqoo0W
         LlTEg7R6qf8XjmqHWZ05Ibnj6WLDoG9FFdBl4XKOfTZsvO4gPl9woBVzMkpAL9cgG/oK
         Cojk/xOxNzHwS5sgVXe8noNHc76p2fcH31OF5oYhLV6/5yazqGNZnuk8kk+QBp3YOb8Q
         +MvUyIFSKUjeh4Tu+NMy3bcGLhtXzn5oNEKwQb5lSs6sc0b6huA/LcmURDDU5tP9Qph7
         M6xg==
X-Forwarded-Encrypted: i=1; AHgh+Ron0oea3lz9KhxXE9+BuRGdSsnZ3PDxdoEXKrbCDcqiZTPRNmHMBX6XDxf2flYD/iU9wRr/j+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YypQkBRLCgqN55kEVs2hZOr2TmPDnavzrL3G/fzBjzrPq89z7uP
	ou92Uz+IGY8RsekX7Cl8L+sD5bQaWvvPlxGCg+nFO4zSAaWNnpyGmkfdGTpcLUFvtpw=
X-Gm-Gg: AfdE7cmDISloSSJAEMtTEbJ1DjiecSzX7M/xvFyvNU0lC+FTo/l+zYAXOiYLC9hdFrC
	rvc+uS+vEwuODkm5NcUK30XRMeVho0rWI5Dn7kTItu3OYYxh+PJSL/TRiNZ/htb2jGhW71EfgNV
	QDQLceKQS+Pp/FaRzKC6fXS4P3NrPNcofBtPIouB1uwl9rlBEjiMX7WAs/Ipje2YBPSKptVRdPB
	2EMQob4CU93KDCt20Qs4XTYXUfp3ixBac4ptDznRZH3DoNg9zYXMzb2vW1Dnt7PG3mvf6JVNmVS
	AD2fAbNj1NBe2KUIwsDEJ5ZXWSFclGSiiY4o3LdfnLCR46yHfPlZuldysu1vu43p8mIzje8lQrx
	hkxGSCk0NJQ4yhPjF9sH+eqD1+2QCussK4EYTIjiIDDtGLe5dehZBb7g8T0JZ3xNAtvGrGKnGoj
	FA2ZkimAOJGT70FVekua1Og4ysFVU5K/hTBXiCyTgrZZJJt1D6Ean0UQZmmSU1gIujT5GrZN+Nw
	UG8rJuFEucQ
X-Received: by 2002:a05:6000:220b:b0:46a:6474:839e with SMTP id ffacd0b85a97d-46a7e9f3eb8mr1087064f8f.4.1782154673472;
        Mon, 22 Jun 2026 11:57:53 -0700 (PDT)
Received: from localhost ([2.122.8.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c5413sm29609719f8f.11.2026.06.22.11.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 11:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 19:57:52 +0100
Message-Id: <DJFT3TXC0OJA.1ZK17YA2RSQXK@linaro.org>
To: "Peter Griffin" <peter.griffin@linaro.org>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, "Alim Akhtar"
 <alim.akhtar@samsung.com>, "Sam Protsenko" <semen.protsenko@linaro.org>,
 <linux-samsung-soc@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH 3/3] soc: samsung: exynos-pmu: fix error paths in
 cpuhotplug/idle states setup
From: "Alexey Klimov" <alexey.klimov@linaro.org>
X-Mailer: aerc 0.21.0
References: <20260605-exynos-pmu-cpuhp-idle-fixes-v1-0-0cd05c81a82d@linaro.org> <20260605-exynos-pmu-cpuhp-idle-fixes-v1-3-0cd05c81a82d@linaro.org> <CADrjBPq4fou5KWh4T=oNkUVPz5Jk-821OVe3j5sWrKnCtHYM6w@mail.gmail.com> <DJ5GP6VQJDHL.2V30K56ME95DO@linaro.org> <CADrjBPqF6GPRLNUZtzkGUHTUQ6NOPoaRvVvF1mUUj_DJ9As1dg@mail.gmail.com>
In-Reply-To: <CADrjBPqF6GPRLNUZtzkGUHTUQ6NOPoaRvVvF1mUUj_DJ9As1dg@mail.gmail.com>

Hi Peter,

On Thu Jun 11, 2026 at 8:07 AM BST, Peter Griffin wrote:
> Hi Alexey,
>
> On Wed, 10 Jun 2026 at 16:07, Alexey Klimov <alexey.klimov@linaro.org> wr=
ote:
>>
>> On Wed Jun 10, 2026 at 2:34 PM BST, Peter Griffin wrote:
>> > Hi Alexey,
>>
>> Hi Peter,
>>
>> > Thanks for your patch!
>> >
>> > On Fri, 5 Jun 2026 at 21:19, Alexey Klimov <alexey.klimov@linaro.org> =
wrote:
>> >>
>> >> The setup_cpuhp_and_cpuidle() initialisation sequence currently ignor=
es
>> >> the return values of cpuhp_setup_state(), cpu_pm_register_notifier(),=
 and
>> >> register_reboot_notifier(). If any of these registrations fail during
>> >> probe() routine, the driver returns 0, leaving the driver partially
>> >> configured.
>> >
>> > I originally made the failure non-fatal because the system still boots
>> > without the notifiers registered (and all other Arm64 Exynos SoCs
>> > upstream don't register notifiers and AFAICT have broken cpu hotplug
>> > and cpu idle).
>> >
>> > In hindsight, that seems like a mistake. I think your patch to fully
>> > unwind everything in case of failure makes more sense.  See small
>> > comment below about destroy_cpuhp_and_cpuidle()
>>
>> Wait, setup_cpuhp_and_cpuidle() should be non-fatal and shouldn't
>> return any errors?
>
> I suggest you re-read my above comment above ^^

Could you please clarify what specifically addresses my question about
notifiers?

Looking further into this, it seems that, for instance, if one of the
hotplug states fails to register then tracking of pmu_context->in_cpuhp
becomes broken.
If reboot notifier silently fails to be registered, then it is unclear how
this from gs101_cpu_pmu_offline() supposed to work:

/* Ignore CPU_PM_ENTER event in reboot or suspend sequence. */
if (pmu_context->sys_insuspend || pmu_context->sys_inreboot) {
	raw_spin_unlock(&pmu_context->cpupm_lock);
	return NOTIFY_OK;
}

If c2 idles are used during reboot/shutdown then they fail or what?

I am not saying that patch is correct and some rework is needed but I don't
get why we should completely ignore errors from hotplug states registration
and should not check registration of notifiers. At least warning should be
shown to user that pm functionality might be unreliable.

Best regards,
Alexey.

