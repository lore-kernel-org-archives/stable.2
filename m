Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FEB448B97
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756407; cv=none; b=eLlRSEc9ICFTjPKqw/P/zQPicw4phDv7fsT2uH4h0vp6AxX8KyC59Nza7qePFTvgjv/9WdjvxOhLmNSc6PpO0EhcRman9ioSWN26IIW0NdHrEhJu+tibPNhqojCbch68tsiw1U5ah1r/h04YksCmzG4HTWuvxfHBLwhGXxAiais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756407; c=relaxed/simple;
	bh=Cr+7Ne5f/+TDyPcwHi4vwSzkvlW1HMxQzI1IA9R5QC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbfxbOn/taOz7lOCnZJGNUn/h4Fpm+kX1fKF5pQ1Mfa2uDaqxzlg4ynd8uxElT6zd4C3T3L+3Wffc3UGGHXAo9EUUm9MOEcWuTrWVyJIAT/MtsuE/qiypGPCZxP47kQ0x2WsV15DFAmaOGLqNX5gVTZqbPvAgufIVtakc7n1YHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjbJ9gGe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjbJ9gGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C391F00A3F
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787756406;
	bh=8gdTsLho+72ohCDvG38qUhOUx7W5mj8SHh5C721jzDg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jjbJ9gGeSxoRWF5ue+qImZsRG/2aOSoK65NUMcDjafKVif+hmnSUX6O8amQvzpFBV
	 8tyUVkxd/tySCEJdDGaaddziA74VGO8/ekB8x6fdpGyVZTB0SkqTM+gtQ6mKSITLQa
	 n9rziWcULM8p0y4Kp6wQ3/fO16XvudInC8ur3Zo8MGWhYOf/UJfxMO9QWp5cKObsvX
	 FKzvOqJyrA6euS0iSks1Tgq21BHnZpv8hzdRT8lHY900P67i7yATnfDJHpcsE2ZGwQ
	 XwinPO3Gkwrh6Ls6RSBaWhSa7m4yVc9Y4Ep3Y02MUKG1hM0Braqlj9QU59UMl/FI7s
	 E8Knnmc0QS/0g==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a3e145e1bfso1576656a12.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:00:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpU3+uvdA4T8NozPqfXw3ScYMu0A3/+4zDBtB8YGq3HyC3qefk0Xv7Hvrnu+is56YPWVrbMZRM=@vger.kernel.org
X-Gm-Message-State: AFuF++k1KWcl/2/CKGl26RmSgW8g0iWp6FXetTN2wPW9omDF13LFY8ue
	BPZ+X89x3PxPnWjTipoYET9l/zCJqVxx0lwY3+9ZgxCA9VDPdI9Fah24Tdf/3FtGn0HSgunSJck
	ZoUvJ7bMigzZfk8KICv5CCzwlonRf7DU=
X-Received: by 2002:a17:907:60cc:b0:c16:12ff:dc8d with SMTP id
 a640c23a62f3a-c250c2eecfcmr806398866b.14.1787756404651; Wed, 26 Aug 2026
 08:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818123921.3600606-1-chenhuacai@loongson.cn>
 <20260818123921.3600606-6-chenhuacai@loongson.cn> <a4b1ff9d-f71b-4cde-b225-70568ca8ba8b@oss.qualcomm.com>
In-Reply-To: <a4b1ff9d-f71b-4cde-b225-70568ca8ba8b@oss.qualcomm.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 26 Aug 2026 23:00:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5gbyo3CHj+b5YwwU1GZG47hThx3OJRAXCDEoJ2KKSnXw@mail.gmail.com>
X-Gm-Features: AcwNN1VQa6Afwkbnm682NTMRbPkMfilGFghS6Oo4UEUbtoAP764SK6DKLwFI0NI
Message-ID: <CAAhV-H5gbyo3CHj+b5YwwU1GZG47hThx3OJRAXCDEoJ2KKSnXw@mail.gmail.com>
Subject: Re: [PATCH 5/5] cpufreq: loongson3: Replace IOCSR read/write with
 MMIO ones
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, loongarch@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Zhongqiu,

On Thu, Aug 20, 2026 at 8:57=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> On 8/18/2026 8:39 PM, Huacai Chen wrote:
> > Our server productions (e.g. Loongson-3D6000/3E6000) can have multiple
> > nodes in one package and SMC mailboxes are also per-node. However, IOCS=
R
> > read/write can only perform on the current node, while sometimes we wan=
t
> > to perform on other nodes (e.g. when switch governor, the get and targe=
t
> > callbacks are not run on target core). So replace IOCSR read/write with
> > MMIO ones.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   drivers/cpufreq/loongson3_cpufreq.c | 31 ++++++++++++++++++++++------=
-
> >   1 file changed, 24 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loon=
gson3_cpufreq.c
> > index c75c0e30e881..e5062cd62390 100644
> > --- a/drivers/cpufreq/loongson3_cpufreq.c
> > +++ b/drivers/cpufreq/loongson3_cpufreq.c
> > @@ -164,6 +164,12 @@ union smc_message {
> >
> >   #define FREQ_MAX_LEVEL                      16
> >
> > +#define MMIO_SMCMBX(node) \
> > +     ((void __iomem *)(IO_BASE | (u64)(node) << NODE_ADDRSPACE_SHIFT |=
 LOONGSON_REG_BASE | LOONGARCH_IOCSR_SMCMBX))
> > +
> > +#define MMIO_MISC_FUNC(node) \
> > +     ((void __iomem *)(IO_BASE | (u64)(node) << NODE_ADDRSPACE_SHIFT |=
 LOONGSON_REG_BASE | LOONGARCH_IOCSR_MISC_FUNC))
> > +
> >   struct loongson3_freq_data {
> >       unsigned int def_freq_level;
> >       struct cpufreq_frequency_table table[];
> > @@ -176,13 +182,25 @@ static DEFINE_PER_CPU(struct loongson3_freq_data =
*, freq_data);
> >   static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 v=
al, u32 extra)
> >   {
> >       int retries;
> > -     unsigned int cpu =3D raw_smp_processor_id();
> > -     unsigned int nid =3D cpu_to_node(cpu);
> > +     unsigned int cpu, nid;
> >       union smc_message msg, last;
> >
> > +     switch (cmd) {
> > +     case CMD_GET_FREQ_INFO:
> > +     case CMD_SET_FREQ_INFO:
> > +     case CMD_GET_FREQ_LEVEL_NUM:
> > +     case CMD_GET_FREQ_LEVEL_INFO:
> > +     case CMD_GET_FREQ_BOOST_LEVEL:
> > +             cpu =3D cpu_number_map(id);
>
> cpu_number_map() is undefined when CONFIG_SMP=3Dn. Wouldn't that result i=
n
> a build failure?
Yes, part of the code should be guarded by CONFIG_SMP here.

>
>
> > +             break;
> > +     default:
> > +             cpu =3D raw_smp_processor_id();
> > +     }
> > +     nid =3D cpu_to_node(cpu);
> > +
> >       mutex_lock(&cpufreq_mutex[nid]);
> >
> > -     last.value =3D iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
> > +     last.value =3D readl(MMIO_SMCMBX(nid));
> >       if (!last.complete) {
> >               mutex_unlock(&cpufreq_mutex[nid]);
> >               return -EPERM;
> > @@ -195,12 +213,11 @@ static inline int do_service_request(u32 id, u32 =
info, u32 cmd, u32 val, u32 ext
> >       msg.extra       =3D extra;
> >       msg.complete    =3D 0;
> >
> > -     iocsr_write32(msg.value, LOONGARCH_IOCSR_SMCMBX);
> > -     iocsr_write32(iocsr_read32(LOONGARCH_IOCSR_MISC_FUNC) | IOCSR_MIS=
C_FUNC_SOFT_INT,
> > -                   LOONGARCH_IOCSR_MISC_FUNC);
> > +     writel(msg.value, MMIO_SMCMBX(nid));
> > +     writel(readl(MMIO_MISC_FUNC(nid)) | IOCSR_MISC_FUNC_SOFT_INT, MMI=
O_MISC_FUNC(nid));
> >
> >       for (retries =3D 0; retries < 10000; retries++) {
> > -             msg.value =3D iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
> > +             msg.value =3D readl(MMIO_SMCMBX(nid));
> >               if (msg.complete)
> >                       break;
> >
>
>
> Please ignore this comments if you do not think it is worth addressing:
>
> A separate issue, it seems that DVFS and Boost feature is set in
> loongson3_cpufreq_probe(), what if about on other nodes (non-boot cpu
> node) and what if cpu hotplug?
Interesting question. After discussion with the firmware team, They
told me that CMD_SET_FEATURE is a global command, the SMC firmware
will align the settings for all nodes.

Huacai

>
> static int loongson3_cpufreq_probe(struct platform_device *pdev)
> {
>         int i, ret;
>
>         for (i =3D 0; i < MAX_PACKAGES; i++) {
>                 ret =3D devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
>                 if (ret)
>                         return ret;
>         }
>
>         ret =3D do_service_request(0, 0, CMD_GET_VERSION, 0, 0);
>         if (ret <=3D 0)
>                 return -EPERM;
>
>         ret =3D do_service_request(FEATURE_DVFS, 0, CMD_SET_FEATURE,
>                                  FEATURE_DVFS_ENABLE | FEATURE_DVFS_BOOST=
, 0);
>         if (ret < 0)
>                 return -EPERM;
>
> ......
>
> }
>
>
> --
> Thx and BRs,
> Zhongqiu Han
