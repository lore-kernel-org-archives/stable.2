Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B14D2931ED
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 01:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792372631; cv=none; b=cILPlMjcXcJ+lvxXE1i1Bj2qTvEgkQ1ZeU5liBrtP+dZek1VRU7Uh6UgO/htQ8wzssiWexgea2MYPvsd0Dijy7h+ggTvs1K/C1Vd0wakXdsxPNnzeKLNJfXqgYdaHMMc5zRXRyQYn3VL59Ws/JP81RGSMbmhbA/QWc/fBmoVrb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792372631; c=relaxed/simple;
	bh=lHZqNYYXwhP6kUYddjnLkScGt2Qj0fv+ATQPgasBkTM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=q92apPqDCbjbHtrVZPiEUTSve28xv4ib5OSonoJoLS9WF8JepDuc5Dtdfr0VKHMCZHPEtGDWKMDMXenc656EWB4dzBQ9eybdC5SRyl7UI1+A5E2ImhnyvAxHFuwCQHBtABx/1GMy6MHTqg3vLKCNGvGreBCg9sd+WPZ0/STiDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuIFT9o2; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuIFT9o2"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-17bc533fda3so1714588c88.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 18:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792372629; x=1792977429; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GYcC1zpNIexSJ7Tb92Jn1IVQJ53RYnQjIQBtHmGKTjk=;
        b=MuIFT9o2xzQmtsPkAnK4pZuWyF13ir2Zz43lEYKp5iDRN2Ss+NknUBtFv87TNLMrmT
         0zdFUYxl1Ph6H29bnHzAy3q84wKGsc22nGNivfNIoLTfY7Orvnf8ugbNfNJT0cK8EDYG
         U2pg+kEAzyD8bI96KV2ZuwNP4Wtvy/awhajoCfuLnwzIYB9w4SpqwVTiIZc+n4v/5Ufb
         nARqyTNIwtqhuzW++qfpERVbWcKaVdAhz2P+6OT8RS2VWhveNVEL0ppkvJ+lHw8jdlQD
         fzGWIdKaXrXK+YENW8s4KobLpxmnzVUqPBjhatktUSfc349gFmgpoa+UjN0ORBdyW9dS
         7vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792372629; x=1792977429;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GYcC1zpNIexSJ7Tb92Jn1IVQJ53RYnQjIQBtHmGKTjk=;
        b=KhCtc03KhyQ8d0KWzKbEFoylEx8oA6UyHaLLDU6C7hybYH9olSU8g3ttB7YfSXl/c8
         hgdoJXmVfrN5rk+QivH+WGkIN2R3EU/zdHjjcg/qJUVb1BYftba+UgnVNKnC6obI0VoS
         kjcXTApFV9w63SArzdh/kzYEE6KHRIqSqArnLD9ocbn1yPa1PFIeq9nG2AnbI6gep0Gm
         28dFBqkp3qMcnWvSzRbNhQJS41rHT/iTa9b4VtIcP20j3L33Wdn6jo1akItB7VKHiqz0
         vHcoWokIM3eDDJDyxhltdxROa5vj4vPaxRzr+NVVXG5UlyyUkJ2LF7Tv07nIvpm6zaYB
         QLIg==
X-Forwarded-Encrypted: i=1; AKwUvBwQOt/EScVuWib6illEFDjvKtuw4ZNCzGq3MQRx94w5dsx5rcFwp/2GjoM0qBlpvq41L8nNqT8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2noluKHvSRwvWF3BYwhOxBOQ5EFr8Q3xRH8CDagLIiCRmBkRD
	F7wYW68nA0tQ74optx1sELj5u9zPAqPRzqBVYlXtDWx7cGRqmazy1bi8
X-Gm-Gg: AYBFou2d+u1fX/e6YC43BvArs8zhU7VFS7poy9VuaHlVmCIA3xfSnslXmI33QWxwmys
	gnEJ1itkRBQS+iunJJUAPUO3IKYkg5Rtg6CUQsAKnrzazYY2kQAsVsN8kQNwz5n22OW8W23LCI7
	Wgj9+82aIVO+8OjTe6tqgwmsBI6MnLuio33Po183TE62MOgahuUsxZW2Pb3Uanc9NndgzIT8zsh
	BKCHXMNVibiKFKQoEMq4XOzB3wwpxk7ANhyRhYjI3vK4BbFJR2Y2gpiEnjVTtZ163cNC4CiHyKH
	DV3ZH+qUXfhkZlr5OhyP32+fNwIRrQTZfKO6hcmcI5XfgwpeZI5J6iCtFPvVYrLsylfh2rns2sX
	jl0H56BRNTkucrDN2mLEoGg5iDi/j+9wbAUQKy2opKIIc1a5UtoGXVR7c7LWB7ZKT4aXh5BTukV
	/eKkl+WW6eCLrmqia4crI7xFq3ovnEBFrxUkWjQUafWSxCCLLnhd8cnpzKOlf8nR3ZvhaybKJYO
	RSROWngy74bPOocVluPF91Zh4nzewqqa0mocGsBAgqsXIXm3DWRT2m32QmlyTs0TcLF
X-Received: by 2002:a05:7022:b043:20b0:189:d6bf:7ec7 with SMTP id a92af1059eb24-189d6bf8278mr2830707c88.19.1792372629290;
        Sun, 18 Oct 2026 18:17:09 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c2e7bf4sm21803582c88.20.2026.10.18.18.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 18:17:09 -0700 (PDT)
Date: Sun, 18 Oct 2026 18:17:09 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Rong Zhang <i@rong.moe>, Ike Panhc <ikepanhc@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, Hans de Goede <hansg@kernel.org>,
 =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/2=5D_platform/x86=3A_ideapad-lap?=
 =?US-ASCII?Q?top=3A_Fix_unexpected_charge=5Ftypes_on_probe?=
User-Agent: Thunderbird for Android
In-Reply-To: <e7e6423eb2a358faa0d2a26fddd0f992e3d03448.camel@rong.moe>
References: <20261018-ideapad-fix-charge-types-v1-0-db52e3bb061a@rong.moe> <DB59F3C0-040F-4663-9750-C387963DCFE3@gmail.com> <e7e6423eb2a358faa0d2a26fddd0f992e3d03448.camel@rong.moe>
Message-ID: <C49666E5-E76A-42E9-8CEA-6195D066A02B@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 18, 2026 7:19:33 AM PDT, Rong Zhang <i@rong=2Emoe> wrote:
>Hi Derek,
>
>Thanks for you information=2E
>
>On Sat, 2026-10-17 at 22:30 -0700, Derek J=2E Clark wrote:
>> On October 17, 2026 4:16:17 PM PDT, Rong Zhang <i@rong=2Emoe> wrote:
>> > It was reported [1] that some unfortunate combinations of BIOS and
>> > Lenovo utilities (e=2Eg=2E, Legion Go 2 + Legion Space) may enable Ra=
pid
>> > Charge and Conservation Mode at the same time, which is very out of
>> > sepc=2E
>> >=20
>> > If both are enabled during a previous Windows boot, ideapad-laptop wi=
ll
>> > see both bits set and correctly shout "unexpected charge_types"=2E
>> >=20
>> > A planned BIOS update will address this=2E Before that, if unexpected
>> > charge_types are encountered on probe, enforce [Long_Life] to prevent
>> > the device from operating in an out-of-spec state=2E On check or fix
>> > failure, skip registering the battery hook and the conservation_mode
>> > attribute=2E
>> >=20
>> > Note: the switches never enable themselves autonomously, so there is =
no
>> > need to fix it during runtime=2E
>> >=20
>>=20
>> Hi Rong,
>>=20
>> Note that this isn't strictly true=2E A known bug in multiple Lenovo de=
vices is that querying the EC too quickly can cause it to reset into an inv=
alid state=2E I=2Ee=2E some games run under wine for check the state of the=
 AC adapter multiple times a second=2E In such a case they can reset and th=
en report both modes on=2E=C2=A0
>>=20
>
>Could you confirm if it's a completely different issue compared to
>https://msgid=2Elink/58586fa666f09c209f9d7fe8c692a8bdda6d4410=2Ecamel@ron=
g=2Emoe
>(i=2Ee=2E, an ACPI mutex ABBA deadlock cause the GBMD method to return
>garbage data)?
>

I believe it is=2E The invalid state survives a power cycle and is precede=
d by a process hanging for a few seconds before the EC resets=2E It can be =
reproduced repeatedly by a simple bash loop that reads the state multiple t=
imes a second=2E

- Derek=20
>> I don't believe the device re-enumerates in this case=2E This is docume=
nted in the driver [1]=2E
>
>The comments and the relevant fix was added in a patch of mine=2E They ar=
e
>about yet another different issue, in which querying the EC with an
>interval < 50 *us* causes the EC to shut down the platform=2E
>
>Then the user must press the power button to power on the platform again=
=2E
>It's a cold boot=2E All kernel drivers are loaded from scratch, so the
>probe-time fix here takes effects=2E
>
>That being said, as far as I can recall, running into the issue doesn't
>set both modes to enabled=2E Besides, userspace checking the state of the
>AC adapter multiple times a second must have an interval much larger than
>50 us, so I don't think the issue you described is the same as the issue
>described in the comments either=2E
>
>>=20
>> Lenovo ha mentioned to me a BIOS fix for this issue will be coming for =
the Go S and Go 2 at some point as well, but this isn't exclusive to Go mod=
els=2E It may be prudent to fix any time an invalid state is detected=2E
>
>I am OK with the fix-whenever-seen approach, but in this manner it'd be
>better to wait until
>https://msgid=2Elink/20261018122348=2E679126-1-aliamemis@disroot=2Eorg is
>applied to solve the ABBA deadlock issue, so that false positives during
>runtime are reduced=2E
>
>Thanks,
>Rong
>
>>=20
>> Thanks,
>> - Derek
>>=20
>> [1] https://github=2Ecom/torvalds/linux/blob/32c52ec87d6245ee2d12ed5dd5=
09e40062939b50/drivers/platform/x86/lenovo/ideapad-laptop=2Ec#L286-L296
>>=20
>> > Fixes: 90430ea98f55 ("platform/x86: ideapad-laptop: Add charge_types:=
Fast (Rapid Charge)")
>> > Closes: https://github=2Ecom/ValveSoftware/SteamOS/issues/2876 [1]
>> > Signed-off-by: Rong Zhang <i@rong=2Emoe>
>> > ---
>> > Rong Zhang (2):
>> >      platform/x86: ideapad-laptop: Factor out charge_types methods fo=
r internal use
>> >      platform/x86: ideapad-laptop: Fix unexpected charge_types on pro=
be
>> >=20
>> > drivers/platform/x86/lenovo/ideapad-laptop=2Ec | 113 ++++++++++++++++=
++++-------
>> > 1 file changed, 84 insertions(+), 29 deletions(-)
>> > ---
>> > base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
>> > change-id: ef28eda4-ideapad-fix-charge-types-067d46d08945
>> >=20
>> > Thanks,
>> > Rong
>> >=20

