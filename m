Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287B14279E0
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755655; cv=none; b=tJknXrH7X7ekYJ8wacOoTXl5CMsLcb7seWEIeF/Azfr1jd3UYV3wV3uQWcoeGk38ND2Z1+0yb9yCLdu338c2KtgbBFP6LT3Ppfw9jvwC6RtGnK5D4dTtirCreZ4LOp7tC1BH6tOFpMRO5A6OcH3m7+fd9nLMUngSjidQ8Axj4V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755655; c=relaxed/simple;
	bh=bsb16MfJEJTafXvWBalO8wjWA2ZDIB3FNT1YYni/xf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DV9YKohdV4Z7iOc9pEPgTmE/Fd8BzhBOqGMxG5FJTg5N+II0TK42ddH3rMbU+HidAhZiktDYRjxt0kMJbhMWBmZQjtPo/MIYygj8bzE2uhY0tZ1y64KXAeoMuvs7Zj0jeI1cTJBDkzQkNyXnePsNEPlYtIUhhKBuRM9ff27yWj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLoZWgrg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLoZWgrg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32501F00A3A
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 14:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787755653;
	bh=/hkGLgOgCbSG4XlKrTJXG5o2tDCxM1rct+mIi4Fw+ao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BLoZWgrgJf6WCsdQ/qUF/S0H413ktVk/Wl03LqVX1PsdDl6J366J1afpb0dPIrVIz
	 QhdN9rzDTBT4yXuJSTR87m0hvLWefEz0jFYCPBw9OfXfp/7coDepzpGpQPcY65nUQ8
	 UrkqV531GfppFQO8lZEMtN3fv4gxyqtZA3EC+TAOEa74Wb0UwwMKfWrnV3U0eIRSGt
	 55Q/Up8BlxLJ4p51FowHVsAN04/B139YdUGga29BgCgfEhUfUJixZA/kU3ln9taw9g
	 /3oPLqnqIC4DnrzpOtkuq0K570AAHHsKeElx9dLFPkSMaQ4zQ2kVoC64w7sIrXhC9+
	 hHTm22tUtFlFQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2530cabcf4so51932466b.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 07:47:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rodlzk+DFgu8uq7Lg0TqnrEp43PABjQ8szp4M9bFgjOp/fwENHhAdV/v3TKsA55knW5bLM/M64=@vger.kernel.org
X-Gm-Message-State: AFuF++nTELtbj8L06XtMv550Ewb9PKYsortfshprpvUj+exHKbXfx0O2
	UVRyV6MXtmoJsT2odrji2riM+xHXMWaIR0EMp88bI0WllqKDRd7I2Wmk/LyiPa2d2g2BS4XZ82c
	WiUHbUAskSAQWpts04HUKs60P46bU4O8=
X-Received: by 2002:a17:907:7249:b0:c21:752f:c3f7 with SMTP id
 a640c23a62f3a-c250bc127b0mr922359666b.18.1787755652562; Wed, 26 Aug 2026
 07:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818123921.3600606-1-chenhuacai@loongson.cn>
 <20260818123921.3600606-3-chenhuacai@loongson.cn> <e07d3a93-390f-405e-85ec-21e5ad9a6738@oss.qualcomm.com>
In-Reply-To: <e07d3a93-390f-405e-85ec-21e5ad9a6738@oss.qualcomm.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 26 Aug 2026 22:47:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H62o3v+Bk=0AO7+C2VWb=AGPMZfv1L6XbZ0uUNq0Pc3bg@mail.gmail.com>
X-Gm-Features: AcwNN1VbsWACZ1FoGXrDjINZIB0qn-Xvk6-RmuNdwyO2LcHvD1ghERhIkxW0tVc
Message-ID: <CAAhV-H62o3v+Bk=0AO7+C2VWb=AGPMZfv1L6XbZ0uUNq0Pc3bg@mail.gmail.com>
Subject: Re: [PATCH 2/5] cpufreq: loongson3: Adjust the width of id and val in smc_message
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, loongarch@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org, 
	Hongliang Wang <wanghongliang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Zhongqiu,

On Thu, Aug 20, 2026 at 6:03=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> Hi Huacai,
>
> Please feel free to comment on the question below, or simply ignore it
> if you do not think it is worth addressing from an architectural
> perspective.
>
> On 8/18/2026 8:39 PM, Huacai Chen wrote:
> > The id field of smc_message is usually stand for the CPU ID. In the pas=
t
> > this driver was only tested for desktop and laptop productions so 4-bit=
s
> > are enough. But now we have servers that can have as many as 256 cores,
> > so we need 8-bits CPU ID.
> >
> > On the other hand, the val field is usually stand for CPU frequency so
> > 12-bits are enough to represent 4GHz, and for higher frequencies there
> > is an extra bit to extend (enough for 8GHz).
>
> The extra bit appears to be unused in the current implementation.
> Perhaps it would be better to enforce the limit explicitly for id and
> val bits, for example by using FIELD_MAX().
OK, we can do it in the future.

>
> >
> > In theory, this is a incompatible change, but fortunately the old SMC
> > firmwares are not widely shipped and can be updated on the air, thus we
> > can safely adjust the widths.
>
> Not sure if using CMD_GET_VERSION check can avoid such incompatible
> issue?
Since the original SMC firmware and the current one has the same
version number and the current one was shipped widely, we can no
longer use CMD_GET_VERSION here.

Huacai

>
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   drivers/cpufreq/loongson3_cpufreq.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loon=
gson3_cpufreq.c
> > index 1e8715ea1b77..630f679aa739 100644
> > --- a/drivers/cpufreq/loongson3_cpufreq.c
> > +++ b/drivers/cpufreq/loongson3_cpufreq.c
> > @@ -21,9 +21,9 @@
> >   union smc_message {
> >       u32 value;
> >       struct {
> > -             u32 id          : 4;
> > +             u32 id          : 8;
> >               u32 info        : 4;
> > -             u32 val         : 16;
> > +             u32 val         : 12;
> >               u32 cmd         : 6;
> >               u32 extra       : 1;
> >               u32 complete    : 1;
>
>
> --
> Thx and BRs,
> Zhongqiu Han
