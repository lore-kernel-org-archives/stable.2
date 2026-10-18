Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6082B45038
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 05:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792301459; cv=none; b=Bj1vk9XqBfoUsw5taXP7qqGekC6zC1/i+D3YmzeZvSxD+Xmi1d3QnmsP/KsVsxD+Y7fGYtzjG4UF74jp7+U8twYJZ063a/2smdG5tnxd5RhTmOVo1tlbPkoDzeDw3RC0+Ta1ihZDiIDRv1D5M5+osDyYCZ/uOr+3v5kQ3u85KbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792301459; c=relaxed/simple;
	bh=FcZ9RRO/SMMWE81u2/SJIHoGw8K+8+ypQ8z6uh8xyk4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=piS2fCeY4OVf3S7xpOePqyaEl4UAlfhGcmrFeYuApnAh0yCLII3tFHnPKXF7tgACnpKE2FEB4XFjZ3BtCGMlKniyb2wNV/RHuoR4/ciNvpsmiEv8/npjGVMYH+BjkWFjD+r6A2azaGdY6mWY94SKjtK1UQQtX4XlAR41rzuQi3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw1eMSaT; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw1eMSaT"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3514b90bb89so2879607eec.1
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 22:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792301457; x=1792906257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9FP8MReeBZgusLeHETDjLoA5Qgo2lDJdxzRHhcUPREg=;
        b=bw1eMSaTR35xn1IJIA/Pm1bAWDCuhQijcvlS+bYxSIX3mQ6+TRlusZmpZ8xpTP1VIw
         /ayqYSjy9H4zeVcCg03g7FAfbqgfXAqiIgu5gS3PXtL++3aO/d6E6C9wQDazH01oc9FH
         giP8BAeOABs8PmLvm7q3ZfzI9fy4eEnSMAVWZAiuzDy/VUoCuOovYviGLxeesfvJFCTA
         LncMc5OToy5rm2U+rQ4jlgKeShe5r5+vM7Ky3OcmMttCjkhQG7twyT9XPOK8ZaZ+KJuA
         g1i3NwiH4jYcGgFTUcDURBTtMJeqXID1upigaLyKYOrT1kVm/t8kPa4n87UUoFXNs65I
         wArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792301457; x=1792906257;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9FP8MReeBZgusLeHETDjLoA5Qgo2lDJdxzRHhcUPREg=;
        b=GqGkNFdlaf2tiirgwVukcx8Dl0VBjxC0siG3KlYD5Jmuvi9CPYPEs4V+1Nfq7ca1gN
         16lQH6Jjbz7VHrpTBndAivNGNZBxqP8jWSRGpKCJ3e12GGDwzPe24fjZpmGrwoBRznil
         hl1MKfMxxDTz2Ik8X5neVZ6Xt/0oon3QQCd50oZ9Sq6FIRJdP45gK9/QHBX3813PHLQx
         vesKhjyWpk8/CVFyxALrUDUyE5hbluzp074xgLlkgebNNfbfipL/Row7DG64qEQFBMtF
         7vT2zIQzi1h2ttPVmHloSTc9bNTJKjVGAcd+OjrG+IrHXxx2Hb2ErmRCb2fQL159ESpb
         Mkkw==
X-Forwarded-Encrypted: i=1; AKwUvBzr4WCGSxyCPbou3i3jWYSJwYllS0Fsf1TaQm/t2Flq8tr/C76XsLbDJGQCn/D4CiCXWXVmZrM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUpc3KAE1S4pSlGk9ngAslUiLMoqSP3Dbp5eh7qCrBltAh3T6d
	zHX6kX2BhRvGthkhBUXMWs0g3djL0CiEFjQr/n0tznPWJ1283HTEVn7J
X-Gm-Gg: AYBFou24Z4M+iln5AtfOk83uZY5f9HgfqxHUXaqpI1cyEw9RJutI3alR7luP0c7AMbX
	925Atx7GXNSdxYC5Mi+NYpacsLAYOY3TrUylTJURyx43DUR0W0wl2VDLJoXLxeq3DWeqWgaXOY5
	ktDCL805nHzkP0PZDTn9TJ75HBiUX67hSikWk/6PngigVgI1cFDgyiLkiMbjaFR64SoSGeYr4BV
	CHNdqaPwEwZbww0bhzjPZN1F2dryWllEza9m2f8q/cUcp8GhgH6/PD1y7umE8TejgRojosE9Fjz
	jCt4MkjdP/T0gWnAosJj47eZBDIIo42UOXVxFj8Yc6sCfrDgCKKYa/wNWK/OOrPbZxwqITHRi5U
	8Nox6bSfjfvNKquHfYuTP9YapfwIUvcNM0f7HYvs6s4V+0D9dLIlXLwfvLdZ3F8/47tN6oO/P2q
	TySyDqBmM8usEAzmvLCEnZ5ZDV8RO5dWv1uAlEWm+dnHrkj3UjZfrdzNVGlu7PLBpt0b1w6Nee7
	GkJiWwauiSlJSR1JFcfRclGZuPHHygOaQ4a3Z6a8YCr+OopbIjjVfj7VOdBcq0Akyuvtk4j7pir
	4T0=
X-Received: by 2002:a05:701b:2618:b0:143:297c:276c with SMTP id a92af1059eb24-18513107afdmr6091679c88.33.1792301457336;
        Sat, 17 Oct 2026 22:30:57 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18319d3b880sm17356480c88.10.2026.10.17.22.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 22:30:56 -0700 (PDT)
Date: Sat, 17 Oct 2026 22:30:58 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Rong Zhang <i@rong.moe>, Ike Panhc <ikepanhc@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, Hans de Goede <hansg@kernel.org>,
 =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/2=5D_platform/x86=3A_ideapad-lap?=
 =?US-ASCII?Q?top=3A_Fix_unexpected_charge=5Ftypes_on_probe?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261018-ideapad-fix-charge-types-v1-0-db52e3bb061a@rong.moe>
References: <20261018-ideapad-fix-charge-types-v1-0-db52e3bb061a@rong.moe>
Message-ID: <DB59F3C0-040F-4663-9750-C387963DCFE3@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 17, 2026 4:16:17 PM PDT, Rong Zhang <i@rong=2Emoe> wrote:
>It was reported [1] that some unfortunate combinations of BIOS and
>Lenovo utilities (e=2Eg=2E, Legion Go 2 + Legion Space) may enable Rapid
>Charge and Conservation Mode at the same time, which is very out of
>sepc=2E
>
>If both are enabled during a previous Windows boot, ideapad-laptop will
>see both bits set and correctly shout "unexpected charge_types"=2E
>
>A planned BIOS update will address this=2E Before that, if unexpected
>charge_types are encountered on probe, enforce [Long_Life] to prevent
>the device from operating in an out-of-spec state=2E On check or fix
>failure, skip registering the battery hook and the conservation_mode
>attribute=2E
>
>Note: the switches never enable themselves autonomously, so there is no
>need to fix it during runtime=2E
>

Hi Rong,

Note that this isn't strictly true=2E A known bug in multiple Lenovo devic=
es is that querying the EC too quickly can cause it to reset into an invali=
d state=2E I=2Ee=2E some games run under wine for check the state of the AC=
 adapter multiple times a second=2E In such a case they can reset and then =
report both modes on=2E I don't believe the device re-enumerates in this ca=
se=2E This is documented in the driver [1]=2E

Lenovo ha mentioned to me a BIOS fix for this issue will be coming for the=
 Go S and Go 2 at some point as well, but this isn't exclusive to Go models=
=2E It may be prudent to fix any time an invalid state is detected=2E

Thanks,
- Derek

[1] https://github=2Ecom/torvalds/linux/blob/32c52ec87d6245ee2d12ed5dd509e=
40062939b50/drivers/platform/x86/lenovo/ideapad-laptop=2Ec#L286-L296

>Fixes: 90430ea98f55 ("platform/x86: ideapad-laptop: Add charge_types:Fast=
 (Rapid Charge)")
>Closes: https://github=2Ecom/ValveSoftware/SteamOS/issues/2876 [1]
>Signed-off-by: Rong Zhang <i@rong=2Emoe>
>---
>Rong Zhang (2):
>      platform/x86: ideapad-laptop: Factor out charge_types methods for i=
nternal use
>      platform/x86: ideapad-laptop: Fix unexpected charge_types on probe
>
> drivers/platform/x86/lenovo/ideapad-laptop=2Ec | 113 +++++++++++++++++++=
+-------
> 1 file changed, 84 insertions(+), 29 deletions(-)
>---
>base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
>change-id: ef28eda4-ideapad-fix-charge-types-067d46d08945
>
>Thanks,
>Rong
>

