Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E88449B3E
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756538; cv=none; b=YIhG5J7+5NsrdcKyi5txWzwdT/8ZtsVv/z6Q0JvikO4hhqA7FvRMmqATL+RDRGVTCh2n5APnR8WGxr2JGbdxEyKaW6WXTrIW1MI9yIScQ9lDIF2A6uGKy2evWhYMiPByG/VmN1TJvGIsFC89RUVB5DVyh/q/S8/aePa6HP4tjyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756538; c=relaxed/simple;
	bh=KqurwhfkeWH92vR01UEowYKyYippJ5kwR9uR9c31nvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0PAvXDBp3rYVffJGIPNe4mccMVtTqEpviSp4FqbEoj7zJkX1dFzzZi7Ekav5Jl5Sc9OnVt/n6aJQWRgnrB6xEC5qpgI7ttVCmi3F7ARthXT+0dsbOdFNzyQepF3UWJz2JIrv0OsdDAtUUv2SV9kdEE+g5CpZ5uTnWISwcd8NrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkHe2AHx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkHe2AHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8811F00ADE
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787756537;
	bh=NVcCvLmnWBybIlOyguyyeisqqYoOCyTYR0wcFtpqJQ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MkHe2AHxO4V2zC4q0ERqf4eKxoo1q5sNINN8mE0EZmFSgEzq29D/VmAfRQxdS1JIl
	 ZNpYNHojVJ/hTT8RCIHrC12yQgZXqKBYfbOGZDi2Xi8Y95d0Uj0a4ygnyMqobWpM/s
	 uHw1jXQ7hbFqnv5jni1qHq1+Er64dddEYvBLiWEP35Zftpi7x0NUDZ/EPn1AFwa62j
	 kDKxHiBOS5/+PMq2bIPPU7JIUJaaIeLt5w9W+l1rL2iHvHNdlREXQb73stom9t515S
	 6e2HZfq73TjQ9z3qizuXWG2KN8METmoqJ7OCxlBZDyH1oqzUNhRmWxFk5hoZfC550n
	 f5V52cNv43bDQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c20ce3c118aso217282266b.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:02:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoTDRHHxMh17P2s4fGhHYcIvFBf2NtEnqVadi59XxmGQhReANiSRL8P8w/StJWtHOB2SIqAV2Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kA07RozqYTXt5a5LPcwrZuXjl3Za67xkzPD6e+m7hKWfV3pfjK
	zWNmbaCA9/NcdEjX6YWCP9XZNJY60C+pYO2oG1N3Hwu2UGjj2dZWj8Zuw9F60pFkpM2mGBDv/yv
	1OWQP7PClY+ZwbMph5iMlxr7H21SDHnA=
X-Received: by 2002:a17:906:a352:20b0:c25:32b0:e56d with SMTP id
 a640c23a62f3a-c2532b0ef44mr124311666b.7.1787756536214; Wed, 26 Aug 2026
 08:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818123921.3600606-1-chenhuacai@loongson.cn>
 <20260818123921.3600606-5-chenhuacai@loongson.cn> <fed97fbc-7d78-4509-86c2-cb302d3957db@oss.qualcomm.com>
In-Reply-To: <fed97fbc-7d78-4509-86c2-cb302d3957db@oss.qualcomm.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 26 Aug 2026 23:02:13 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4BRGeZ48PMJcYNR_Nn2-=Emec=pXsD041ZwWzJ5vo8nQ@mail.gmail.com>
X-Gm-Features: AcwNN1XnWCZ_j5s24EXBjPnXvoyo6XOOKag1dVhQo6JOF7SB5LvAgfDgqDzhSps
Message-ID: <CAAhV-H4BRGeZ48PMJcYNR_Nn2-=Emec=pXsD041ZwWzJ5vo8nQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] cpufreq: loongson3: Use global physical CPU ID in
 get/target callbacks
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, loongarch@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org, 
	Hongliang Wang <wanghongliang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Zhongqiu,

On Thu, Aug 20, 2026 at 8:24=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> On 8/18/2026 8:39 PM, Huacai Chen wrote:
> > Our server productions (e.g. Loongson-3D6000/3E6000) can have discrete
> > global physical CPU IDs while the core ID inside the packages are alway=
s
> > continuous. In these cases we should use global physical CPU IDs to get
> > and set frequencies.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   drivers/cpufreq/loongson3_cpufreq.c | 20 +++++++++++---------
> >   1 file changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loon=
gson3_cpufreq.c
> > index e3cd78a5ab18..c75c0e30e881 100644
> > --- a/drivers/cpufreq/loongson3_cpufreq.c
> > +++ b/drivers/cpufreq/loongson3_cpufreq.c
> > @@ -219,38 +219,40 @@ static inline int do_service_request(u32 id, u32 =
info, u32 cmd, u32 val, u32 ext
> >
> >   static unsigned int loongson3_cpufreq_get(unsigned int cpu)
> >   {
> > -     int ret;
> > +     int ret, core =3D cpu_logical_map(cpu);
> >
> > -     ret =3D do_service_request(cpu, FREQ_INFO_TYPE_FREQ, CMD_GET_FREQ=
_INFO, 0, 0);
> > +     ret =3D do_service_request(core, FREQ_INFO_TYPE_FREQ, CMD_GET_FRE=
Q_INFO, 0, 0);
>
> As patch 5/5 changelog:
>
> "However, IOCSR read/write can only perform on the current node, while
> sometimes we want to perform on other nodes"
>
> However, patch 4/5 starts passing the global CPU number without updating
> do_service_request(), which is only changed in patch 5/5. Doesn't that
> mean patch 4/5 is broken on its own?
Cross-node accesses need the whole of this series. So:

For single node machines, with or without this patch are both correct.

For multi-nodes machines, this patch cannot solve all problems, but
doesn't make things worse.

>
> >
> >       return ret * KILO;
> >   }
> >
>
> A separate issue=EF=BC=8C do_service_request() can return errno such as -=
EPERM,
> it will cause .get() func return a large unsigned integer value.
Yes, we need "return (ret < 0) ? 0 : ret * KILO" here.


Huacai

>
>
> >   static int loongson3_cpufreq_target(struct cpufreq_policy *policy, un=
signed int index)
> >   {
> > -     int ret;
> > +     int ret, core =3D cpu_logical_map(policy->cpu);
> >
> > -     ret =3D do_service_request(cpu_data[policy->cpu].core,
> > -                              FREQ_INFO_TYPE_LEVEL, CMD_SET_FREQ_INFO,=
 index, 0);
> > +     ret =3D do_service_request(core, FREQ_INFO_TYPE_LEVEL, CMD_SET_FR=
EQ_INFO,
> > +                              index, 0);
> >
> >       return (ret >=3D 0) ? 0 : ret;
> >   }
> >
> >   static int configure_freq_table(int cpu)
> >   {
> > -     int i, ret, boost_level, max_level, freq_level;
> > +     int i, ret, core, boost_level, max_level, freq_level;
> >       struct platform_device *pdev =3D cpufreq_get_driver_data();
> >       struct loongson3_freq_data *data;
> >
> >       if (per_cpu(freq_data, cpu))
> >               return 0;
> >
> > -     ret =3D do_service_request(cpu, 0, CMD_GET_FREQ_LEVEL_NUM, 0, 0);
> > +     core =3D cpu_logical_map(cpu);
> > +
> > +     ret =3D do_service_request(core, 0, CMD_GET_FREQ_LEVEL_NUM, 0, 0)=
;
> >       if (ret < 0)
> >               return ret;
> >       max_level =3D ret;
> >
> > -     ret =3D do_service_request(cpu, 0, CMD_GET_FREQ_BOOST_LEVEL, 0, 0=
);
> > +     ret =3D do_service_request(core, 0, CMD_GET_FREQ_BOOST_LEVEL, 0, =
0);
> >       if (ret < 0)
> >               return ret;
> >       boost_level =3D ret;
> > @@ -263,7 +265,7 @@ static int configure_freq_table(int cpu)
> >       data->def_freq_level =3D boost_level - 1;
> >
> >       for (i =3D 0; i < freq_level; i++) {
> > -             ret =3D do_service_request(cpu, FREQ_INFO_TYPE_FREQ, CMD_=
GET_FREQ_LEVEL_INFO, i, 0);
> > +             ret =3D do_service_request(core, FREQ_INFO_TYPE_FREQ, CMD=
_GET_FREQ_LEVEL_INFO, i, 0);
> >               if (ret < 0) {
> >                       devm_kfree(&pdev->dev, data);
> >                       return ret;
>
>
> --
> Thx and BRs,
> Zhongqiu Han
>
