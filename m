Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322695;
	b=zZ+DHHyt8dXmxSEQaHEaDICc45wVGyaTrvXVXkV3f1V8iNVB+LJ0679qRGSfis733q0M
	 CgbhnQPeaIH/ktn8Liwp/qksUPctdvFJEYb4QSYcMbY1DFwOLHmccMS2YRkivrjNzLtSX
	 E9+rpI2rCjkixsxyIRPRHelyf+JRsE97zeMx9rkbR8LlevkAGf1GsAhgNrn02w5unnhSS
	 6T1rpm5Ib6D0ByaPCIDuxyvGOWjBjMFNdzpz/tjfyUXrgjBxJAHG3dM1mgQRAtbx70n6q
	 7rUhgphJxfyIjKBmoZmFn+fKoSrzxzTuFBJeSREWC9dCdmtlddVw+CiC+au1daI/uSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322695;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WnkJ8LXf/bgZJNIPyQGBBjaA78zgoKgnkLMT97HZ4hM=;
	b=tWArq+DvAIknX9tts1DeOz/fKERrJ10WeeCnDt75pbP31XM42iocLzTjwf6B1EOGKjql
	 8QUOG3syRnV312bBw+1FjNjlxywxH3iUpQc4QeUsHqZQ7HLnozy9cMr8a4z/jTQb+ifc1
	 1GrjfSHztTnU4yQNs8IW0DTc19HR36ipvjG6uhVQjQrVLFMT9TAtlpZ7C8QgrejS/nelN
	 rBQKWHnxEhTYKdNHUeeuuWdMspSCTLLrWvMJaqPa5zKKaeRlKJUTeiJj0E4QOHYig/9G8
	 WQ4aIxxcC/eq5m2YaEhHqUEW57bRu63kfL7SCsiZumMSVMo8K4oc3NWxCND1LEaXJ0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvPtbBbp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6126C606A33E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvPtbBbp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8151F00903
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322694;
	bh=WnkJ8LXf/bgZJNIPyQGBBjaA78zgoKgnkLMT97HZ4hM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EvPtbBbpY0MjDrJNm/qEfHVLVqDPeNiRukmRUFa4wWsRoo6sCSQw+dMYY0H3/TdIo
	 5rGBDNsi9o8CXMflRBCr3XSY0eF6h4mL4dZFLwCe5xGnvbOpH/4YndZsn5IZLaOa/v
	 iSkQ6Pr18uxngCNjGJnx8fe5XPUSAgFwzndWaN99yG0r66WVa89QAHjROZqlQzesFL
	 r9DBjPRvtBZwST8/tzlm/7BHBGo04X2tKXGG+JlIRHGIigH/76hZVR4S8c5eLr/mn8
	 cb7I1uW2JG21uHuTSx4xq5fmw1kzmKwZfpeEni0vRhWxHbjyov7ZyTXy3mat1NnXKT
	 ymgwxGi3mFHHA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a1f628b1d1so17330661fa.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:58:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErESHAcc6L8Cs16Xu5AW0hcRoZaweNeu6wPZzdMTm7dXeL14IZ4w3KlpL2XX0hpMAQ53Slc/sEs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xXUhIVxTyfRoQIzLS/575u04kZBXZPm/pUNxt3xMqgJWtK6my
	oioUnDednPMHrHKxPyisjwuucxZuw7CxGXY0kRjkfho22THjx2w9JjUpzR7+8kGjYQmD5jGW/IQ
	wzTYHZoJw86kdOeVWYsbStoOqB+TpeHI=
X-Received: by 2002:a2e:a9a5:0:b0:3ab:4f5e:3edc with SMTP id
 38308e7fff4ca-3ae09632513mr5987871fa.15.1794322692389; Tue, 10 Nov 2026
 06:58:12 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110101246.3665797-1-sumitg@nvidia.com> <09209b48-a469-4bd9-8d43-845f709353ca@arm.com>
In-Reply-To: <09209b48-a469-4bd9-8d43-845f709353ca@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 15:58:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jgUnFO5FsDU64bE9ArzTQaGcU=2ocRJ2QpsJb_octG8w@mail.gmail.com>
X-Gm-Features: AclHuK8X5hMi8jD3gHPYYnsPSCyrp4PzOzFf8JJiGs5yNkckX-k7Tw8xtv2KRhU
Message-ID: <CAJZ5v0jgUnFO5FsDU64bE9ArzTQaGcU=2ocRJ2QpsJb_octG8w@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: CPPC: Set CPPC Enable register in cpu_init
To: Christian Loehle <christian.loehle@arm.com>, Sumit Gupta <sumitg@nvidia.com>
Cc: viresh.kumar@linaro.org, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	jbenc@redhat.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	mochs@nvidia.com, bbasu@nvidia.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 11:58=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/10/26 10:12, Sumit Gupta wrote:
> > As per ACPI 6.x s8.4.6.1.4 (CPPC Enable Register):
> >   "If supported by the platform, OSPM writes a one to this register
> >    to enable CPPC on this processor. If not implemented, OSPM assumes
> >    the platform always has CPPC enabled."
> >
> > The driver never writes this register. CPPC therefore stays disabled
> > on platforms such as NVIDIA GB10 that wait for OSPM to enable it.
> >
> > Call cppc_set_enable() in cppc_cpufreq_cpu_init(). Fail init if
> > enabling CPPC fails. If init fails after CPPC is enabled, disable it
> > again. The register is optional, so -EOPNOTSUPP is not an error.
> >
> > This relies on commit ab482f1bac6b ("ACPI: CPPC: Refactor register
> > value get and set ABIs") from v6.16. Before it, cppc_set_enable()
> > returned -EFAULT instead of -EOPNOTSUPP when the Enable register is
> > not implemented. On an older kernel this change would make init fail
> > on every platform without the register, so the stable range starts
> > at v6.16.
> >
> > Fixes: 5477fb3bd1e8 ("ACPI / CPPC: Add a CPUFreq driver for use with CP=
PC")
> > Cc: stable@vger.kernel.org # v6.16+
> > Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Applied as 7.4-rc material, thanks!

> > ---
> > v1 -> v2:
> > - Fail init if enabling CPPC fails and disable CPPC again if init
> >   fails after enabling it (Christian).
> > - Move enable after the policy->shared_type check, so cppc_set_perf()
> >   is the only failure after it.
> > - Mention NVIDIA GB10 in the commit message (Christian).
> >
> > v1: https://lore.kernel.org/lkml/20261105123244.3132560-1-sumitg@nvidia=
.com/
> >
> >  drivers/cpufreq/cppc_cpufreq.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpuf=
req.c
> > index 957fa7775260..b2af24ae5008 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -714,7 +714,17 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_po=
licy *policy)
> >               pr_debug("Unsupported CPU co-ord type: %d\n",
> >                        policy->shared_type);
> >               ret =3D -EFAULT;
> > -             goto out;
> > +             goto out_put;
> > +     }
> > +
> > +     /*
> > +      * Enable CPPC. The Enable register is optional - some platforms
> > +      * may not support it.
> > +      */
> > +     ret =3D cppc_set_enable(cpu, true);
> > +     if (ret && ret !=3D -EOPNOTSUPP) {
> > +             pr_err("Failed to enable CPPC for CPU%u (%d)\n", cpu, ret=
);
> > +             goto out_put;
> >       }
> >
> >       policy->fast_switch_possible =3D cppc_allow_fast_switch(policy->c=
pus);
> > @@ -742,6 +752,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_pol=
icy *policy)
> >       return 0;
> >
> >  out:
> > +     cppc_set_enable(cpu, false);
> > +out_put:
> >       cppc_cpufreq_put_cpu_data(policy);
> >       return ret;
> >  }
>
