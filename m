Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAF5432BF4
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755759; cv=none; b=m08gfTbpAA4xZ/gyH3e2Cz0wvCvM7Z825YHqXwlynZTfdvny1R+kMUqy7RQJTqbS8Jpjt2Gdq00VHwtji32gqeVo6rKmlseDnw2AoLMwrL+YyNH0bEqrUhXjvQBKV7mGM54F+5uIidOh3SSkxTAxRlyVVDJzHQZQ3UVE9ac2z0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755759; c=relaxed/simple;
	bh=MpOTDdeT3bZaQiGndCvq/Va6CUct8aokUQORS0TMbLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uN1WCqAMTiFSD4feCv4wRfzliLxtnq6qdbV0zTRpbErI6PfCLbVd+gK2xCZvuMoz9NsfikygD9Za2QBoNF3GpQ2dP86RSKj83w6ZDtR8tFVYK29pGLoo2aGVvjSJexwoeIM84YKiQ/qnTziyQ1mJwSq6hUNoPSPNF1VjyhoSAuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIDUneYj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIDUneYj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C5E1F000E9
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 14:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787755758;
	bh=rud/Q9HeSKhNKPTtAJCWQV5WiQ/mLprflA5WGwiU49E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UIDUneYj2xnutD2YIM6X6HmUbmPJJpE+W9eQ0yNjGrsGSY0lted3lMvY4Q5qnDlRg
	 PldyYwb5/M8+7Gfo6BqFQJCnCBYqP+4bkcxL5odA7ujiommtGehGh+SEbAWq/TqlEv
	 fy5jIilPzNsWYLneca20MPsTKGc2pOTeRCedTPwNOC0Ggq5SJ4DIvFM3jBr7DDaZhd
	 SiK9rBvCf0oFAgs7GIsiTV4cKIQMoWRFxSJzhUfnFWaQhBPVt5bSr8Y1WczbcZN7AP
	 tVD+Bw+1HZ9VI3x3+eCNXvjB/0A3iVTplj/sZWubqD5qGQb/79U1JYi1ooGHDw8acl
	 1juYRnaNRd+dg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c20e70a0962so155413466b.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 07:49:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr5M6XZgPYLSCmSce3FX7hX5YwsFbzWlFZZ7sEoqgkAZRKQllyer8RqtSii0SY9IKyU5mccpms=@vger.kernel.org
X-Gm-Message-State: AFuF++kSuuRndYwbeIjiqLosye560xMr03pc+FvcrDYWX4XYPhN1Rjo1
	CH4DHoB1raGp4Q8y1pIuTcb5xDI+yn8YgcKCfs+GsWELxCSSFnK5/9SKguh4ch5BUlBoXRKnHHK
	l5vGkeCkjLKIPJyErk2gHmSltSvqWiQc=
X-Received: by 2002:a17:907:1907:b0:c20:23f8:99a5 with SMTP id
 a640c23a62f3a-c250c2e9dd9mr941189066b.15.1787755756855; Wed, 26 Aug 2026
 07:49:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818123921.3600606-1-chenhuacai@loongson.cn>
 <20260818123921.3600606-4-chenhuacai@loongson.cn> <3f352680-7090-456a-ab08-2d3367641783@oss.qualcomm.com>
In-Reply-To: <3f352680-7090-456a-ab08-2d3367641783@oss.qualcomm.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 26 Aug 2026 22:49:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6bq7R_0YiAQwFeveZEW7xenEceixJDuZDmOKCihCTbXg@mail.gmail.com>
X-Gm-Features: AcwNN1XxNLvNZ4RDduvU0vO2hQJFT7eFm5aoCSIOk7FzLkC_iTiaUlOcaa7vqJY
Message-ID: <CAAhV-H6bq7R_0YiAQwFeveZEW7xenEceixJDuZDmOKCihCTbXg@mail.gmail.com>
Subject: Re: [PATCH 3/5] cpufreq: loongson3: Replace per-package mutex with per-node
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, loongarch@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org, 
	Hongliang Wang <wanghongliang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Zhongqiu,

On Thu, Aug 20, 2026 at 7:35=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> On 8/18/2026 8:39 PM, Huacai Chen wrote:
> > Our server productions (e.g. Loongson-3D6000/3E6000) can have multiple
> > nodes in one package and SMC mailboxes are also per-node. So replace th=
e
> > per-package mutex with per-node one.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   drivers/cpufreq/loongson3_cpufreq.c | 14 +++++++-------
> >   1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loon=
gson3_cpufreq.c
> > index 630f679aa739..e3cd78a5ab18 100644
> > --- a/drivers/cpufreq/loongson3_cpufreq.c
> > +++ b/drivers/cpufreq/loongson3_cpufreq.c
> > @@ -169,7 +169,7 @@ struct loongson3_freq_data {
> >       struct cpufreq_frequency_table table[];
> >   };
> >
> > -static struct mutex cpufreq_mutex[MAX_PACKAGES];
> > +static struct mutex cpufreq_mutex[MAX_NUMNODES];
> >   static struct cpufreq_driver loongson3_cpufreq_driver;
> >   static DEFINE_PER_CPU(struct loongson3_freq_data *, freq_data);
> >
> > @@ -177,14 +177,14 @@ static inline int do_service_request(u32 id, u32 =
info, u32 cmd, u32 val, u32 ext
> >   {
> >       int retries;
> >       unsigned int cpu =3D raw_smp_processor_id();
> > -     unsigned int package =3D cpu_data[cpu].package;
> > +     unsigned int nid =3D cpu_to_node(cpu);
> >       union smc_message msg, last;
> >
> > -     mutex_lock(&cpufreq_mutex[package]);
> > +     mutex_lock(&cpufreq_mutex[nid]);
> >
> >       last.value =3D iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
> >       if (!last.complete) {
> > -             mutex_unlock(&cpufreq_mutex[package]);
> > +             mutex_unlock(&cpufreq_mutex[nid]);
> >               return -EPERM;
> >       }
> >
> > @@ -208,11 +208,11 @@ static inline int do_service_request(u32 id, u32 =
info, u32 cmd, u32 val, u32 ext
> >       }
> >
> >       if (!msg.complete || msg.cmd !=3D CMD_OK) {
> > -             mutex_unlock(&cpufreq_mutex[package]);
> > +             mutex_unlock(&cpufreq_mutex[nid]);
> >               return -EPERM;
> >       }
> >
> > -     mutex_unlock(&cpufreq_mutex[package]);
> > +     mutex_unlock(&cpufreq_mutex[nid]);
>
> An optimization independent of this patch: considering to use
> guard(mutex)(xxx.lock)
This can be improved in the future, but not suitable in the bug fix patches=
.

Huacai

>
> >
> >       return msg.val;
> >   }
> > @@ -337,7 +337,7 @@ static int loongson3_cpufreq_probe(struct platform_=
device *pdev)
> >   {
> >       int i, ret;
> >
> > -     for (i =3D 0; i < MAX_PACKAGES; i++) {
> > +     for (i =3D 0; i < MAX_NUMNODES; i++) {
> >               ret =3D devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
> >               if (ret)
> >                       return ret;
>
>
> --
> Thx and BRs,
> Zhongqiu Han
