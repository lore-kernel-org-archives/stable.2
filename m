Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6C91A6800
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 04:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786248488; cv=none; b=hZbx7uHNuiaaJ8ulG2XwigG+qaPukrcyCHJLz6JhYPIU6cDNg84k/Z7HWLtr+tVddhkJNUkga42BvCFZR4Qh9RTfJll2efSQiKOCynXCwfE8dcCQeB7VNioU1ydMZJBeIqHhz0A9N3y02zspeUsKTkSOIf/qo9vUUnSVPzGf2uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786248488; c=relaxed/simple;
	bh=DVH4IDH2JUFbfAJKtvWhR0yvk9oI7f1Wb+9Vj/W7N4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lwur3+Ee2LeAgMwbtmv/xxeoHFpu5O6O4p1HxAqSWoDgNW61Dzq8TPvROA8C8no/3q9mgD9rrW+pq3lmjUqeCpBSwjTMnF5cvZe39pU76VlWOEfuUQN341mWDzi9X/I7yyewtDpqeXThHOfczAFfDkiibEsnRUWOFW+XHh40mho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRe3qLM6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRe3qLM6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B424C1F00A3F
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 04:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786248486;
	bh=NDH0BIVJ0y5dH9ibs+UCIn1aXnjt6eR+IBwhFsTvFwA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RRe3qLM6pJM0LFqPF+FhY1yGyD7psQIxZDB37j0WF7NNse9hC3hFIwxBIrjyK4nKT
	 /v81OERaQ1w4LjnSuWozm5KQTSIObaku1RjLq/BoI269frZCtZnoXPJyeSWObfWiSX
	 5zeHyE5TEgDQ3OVxYt+4GQP35cHTNYY5AB10qPeuz5lzmUIDgupEQjBhfud8Dbb6mr
	 h2nytOVuH7X5momwGiIYELjS5Hc3n/uDH7d6DAQHLRuaQgsTj9q1Sxjv05E7p8wIm9
	 OMOFLJ1fgGurncNZxJZwehjZNdyTpavTmHPDLxonPqMXX1SG7KYpf15JihURavjsDy
	 CAwknTdWdmrjw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a063d211ebso869472a12.3
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 21:08:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrD+wn8I9j2qAvPhhJLV9s8/1k69AeCTu4Gts/DH1q/irIMbhd5FvWxfN9iklSjd+fw4NYqhwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqPOiZ0GGozJhihk4TRPnBqaXJSEOeMUB/s+ZzqhqUyK1hkiJ9
	y7+4YZW2lUA0rIWdIkGBMq+/hS2+AUnVUdvWAikZNigt7UP8T/fmB1/QTXDMfHzSCuUwucZhKPS
	mMwJ7jlHHabjyQoBGYjCY4oZTouNGiPw=
X-Received: by 2002:a05:6402:1f8d:b0:6a0:927e:39e2 with SMTP id
 4fb4d7f45d1cf-6a14f0c5762mr16676115a12.5.1786248485411; Sat, 08 Aug 2026
 21:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804075719.1137338-1-maobibo@loongson.cn> <1793132c-dd25-4ee0-bc66-f3636522164a@linux.dev>
In-Reply-To: <1793132c-dd25-4ee0-bc66-f3636522164a@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 9 Aug 2026 12:07:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7900J7RwUHnJFN7nXb+_SZzoA-xZ1aUGF_6OrjTr1D6w@mail.gmail.com>
X-Gm-Features: AUfX_mx-xYcnVUraXPcSrpDm5aEi4WRq8y2uR6OZvN7rbDLMbbNmWrUUKydL1iw
Message-ID: <CAAhV-H7900J7RwUHnJFN7nXb+_SZzoA-xZ1aUGF_6OrjTr1D6w@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix acpi_package_ids array overflow
To: Tao Cui <cui.tao@linux.dev>
Cc: Bibo Mao <maobibo@loongson.cn>, WANG Xuerui <kernel@xen0n.name>, 
	Rong Bao <rong.bao@csmantle.top>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 4:57=E2=80=AFPM Tao Cui <cui.tao@linux.dev> wrote:
>
>
>
> =E5=9C=A8 2026/8/4 15:57, Bibo Mao =E5=86=99=E9=81=93:
> > With LoongArch virt machine, one typical setting is one core per socket=
,
> > there will max 256 sockets on one VM. With PPTT acpi table, array
> > acpi_package_ids will be overflowed.
> >
> > Here change array size of acpi_package_ids with max value of
> > MAX_PACKAGES and KVM_MAX_VCPUS.
> >
> > Fixes: 4e8f58620f67 ("LoongArch: Retrieve CPU package ID from PPTT when=
 available")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> > ---
> >  arch/loongarch/kernel/acpi.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.=
c
> > index 873e90990771..cb454ee92b20 100644
> > --- a/arch/loongarch/kernel/acpi.c
> > +++ b/arch/loongarch/kernel/acpi.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/export.h>
> >  #include <linux/irq.h>
> >  #include <linux/irqdomain.h>
> > +#include <linux/kvm_host.h>
> >  #include <linux/memblock.h>
> >  #include <linux/of_fdt.h>
> >  #include <linux/serial_core.h>
> > @@ -202,7 +203,7 @@ static void __init acpi_process_madt(void)
> >
> >  int pptt_enabled;
> >  static int acpi_nr_packages;
> > -static int acpi_package_ids[MAX_PACKAGES];
> > +static int acpi_package_ids[MAX(MAX_PACKAGES, KVM_MAX_VCPUS)];
> >
> >  int __init parse_acpi_topology(void)
> >  {
> >
> > base-commit: 075b74841bd0065a3bda3440873c747938e69b68
> Reviewed-by: Tao Cui <cuitao@kylinos.cn>
Applied, thanks.

Huacai
>
