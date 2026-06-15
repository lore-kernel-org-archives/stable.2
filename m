Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7097713AA2D
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507350; cv=none; b=eKRXUVVUcn6xkshpvWMCTBGdMpSrK4gC2Z+vOzq9t9tE4HPINBKAy0Uu1pOReFN4m6FejFjmNz2XyfbV0RjPtIKWFSYxfYdc/OPGjID8R2WrfkC9O+gGr47ONTI6fZseOUODVIRdVDR3Br8r+0wPvKXfEfG2SXUYU28voV7c8UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507350; c=relaxed/simple;
	bh=Pw30Cg2ID5sZL3rtyqO0peejxUwoMLJGIabKQ+hgHKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zu07Mhb6T7elwUgFjkdOxq5aJ4XTRNGq8bXYQufIBGplBp+JQsAyd0qy7JgcCnCephRzRYLccjMj9a5MG/YkSx9qEjjTBuEXbbrEob5Dc4rf+r8Le/k0fIhs8vkJvHWMt1w8GSWXQyYCEOd45z/Y3bAsGwGxlou0Ym+61L8CNbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIu4cA6u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIu4cA6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586B31F00AC4
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 07:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781507349;
	bh=aMrYrifzAfDa/YgH0QBb/Gf0s0+C55KO5sVK6U8S2YU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HIu4cA6um9p7I9S44zPfge0r4P3WkNqhCq7tsMLnfGCHP+slh9+4Uw2Re2XXEtyIT
	 SySVJR8W9rwgDXmdsDMO1TamJ0pDmfEvlVBnEra1uP0az3T8FMmBAyV7Vl90FIfbS7
	 x0MT+l+XMKmYgyjjkClWVXA9tCvIcE7Qe1Zodbc4yO9ZEJZlMQCekF4mXuRJQ0dpou
	 iL4GRXf6pSlz9tvWWBbphPTOl/Rk/BDd9J+lDTkUvUoL/YZUKGttFQsMsXp2iIZaTE
	 5vioPa+Q29/iq8Yu+P/b8Fm5ixXh0OuFdlFd4Qk7KrcMK+152/pxT0g7MyZfP50WQ5
	 Y2khzhrLrO58g==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68c3421b009so6028108a12.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 00:09:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+YQtNtb4/YYBzKYSYWqnitB8SG1eOZWV9Z7MBfkl7Nx4bPCW3jzR64D8hyw84yayER2Gzjv1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQtfw9iEnrIII6psLHIv1JV/CU58lJpmmT2pUbwXENumbMDfzv
	f4DCrYays7vO/aqwuptCCmcR4We0RP3MeoW165hZNuFK+QGpgWOK+zG4YDqdxZZ81J1IU3DAWKd
	OTTKs9BC7jd1b5Bs25PFpa3xz4s+bOY4=
X-Received: by 2002:a17:907:6d1e:b0:bc1:9d5d:e020 with SMTP id
 a640c23a62f3a-bfde279da40mr559925266b.10.1781507348044; Mon, 15 Jun 2026
 00:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608093729.12111-1-jelonek.jonas@gmail.com>
 <CAAhV-H7vJ5YniUD8HhFWBbypNyWTo73M_vzw=Y-MZtR-b_RNfw@mail.gmail.com> <731bd6c4-0f70-45a2-8480-8fed315b82b4@gmail.com>
In-Reply-To: <731bd6c4-0f70-45a2-8480-8fed315b82b4@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 15 Jun 2026 15:09:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Va1VzpvdA-w5fX9KrZQArdX_Bjpg6t+4QNn3jHfgjmA@mail.gmail.com>
X-Gm-Features: AVVi8CeoZiCXh_iaiNOAdCzLnp4qE8NmR13eNXcLxV_r3rfRWyydEG7ciK48TeU
Message-ID: <CAAhV-H6Va1VzpvdA-w5fX9KrZQArdX_Bjpg6t+4QNn3jHfgjmA@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 3:00=E2=80=AFPM Jonas Jelonek <jelonek.jonas@gmail.=
com> wrote:
>
> Hi Huacai,
>
> sorry for the reply delay.
>
> On 10.06.26 08:05, Huacai Chen wrote:
> > [...]
> > In theory LoongArch has the same problem, but I cannot reproduce,
> > should I enable PREEMPT_RT? Or there are some special configurations?
>
> Sadly I cannot help with that. For MIPS, this seems to be the default
> behavior.
This patch fixes 91840be8f710, and 91840be8f710 adds synchronize_rcu()
in irq_work_sync(). Your problem is caused by this synchronize_rcu(),
right?

However, synchronize_rcu() only gets called in the
IS_ENABLED(CONFIG_PREEMPT_RT) case, so I think your configuration
needs PREEMPT_RT, right?

You said this is the default behavior, but PREEMPT_RT is not enabled by def=
ault.

Huacai

>
> > Huacai
> >
> >> This issue was noticed on several Realtek MIPS switch SoCs (MIPS
> >> interAptiv) and came up during kernel bump downstream in OpenWrt from
> >> 6.18.33 to 6.18.34, after the backport of the patch to the 6.18 stable
> >> branch. The patch also has been backported all the way back to 6.1.
> >>
> >> Call rcutree_report_cpu_dead() once interrupts are disabled, mirroring=
 the
> >> generic CPU-hotplug offline path, so RCU stops waiting on the parked C=
PUs
> >> and grace periods can still complete. MIPS shuts down all CPUs here
> >> without going through the CPU-hotplug mechanism, so this report is not
> >> otherwise issued. Reporting a dying CPU to RCU outside the regular hot=
plug
> >> offline path is not unprecedented: arm64 does the same in cpu_die_earl=
y().
> >> There it is an exception for a CPU that was coming online and is abort=
ing
> >> bringup, rather than the default shutdown action as on MIPS.
> >>
> >> Fixes: 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single(=
) on PREEMPT_RT")
> >> CC: stable@vger.kernel.org
> >> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> >>
> >> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> >> index 4868e79f3b30..0f28b4a62e72 100644
> >> --- a/arch/mips/kernel/smp.c
> >> +++ b/arch/mips/kernel/smp.c
> >> @@ -20,6 +20,7 @@
> >>  #include <linux/sched/mm.h>
> >>  #include <linux/cpumask.h>
> >>  #include <linux/cpu.h>
> >> +#include <linux/rcupdate.h>
> >>  #include <linux/err.h>
> >>  #include <linux/ftrace.h>
> >>  #include <linux/irqdomain.h>
> >> @@ -422,6 +423,7 @@ static void stop_this_cpu(void *dummy)
> >>         set_cpu_online(smp_processor_id(), false);
> >>         calculate_cpu_foreign_map();
> >>         local_irq_disable();
> >> +       rcutree_report_cpu_dead();
> >>         while (1);
> >>  }
> >>
> >> --
> >> 2.51.0
> >>
> >>
>
> Best,
> Jonas
