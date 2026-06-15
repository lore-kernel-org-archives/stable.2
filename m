Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4848F35DA47
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781508630; cv=none; b=QAJEaaXxYEjrGejvgEjOf/mP3wMSDAtYEzfTb+HYO/LU6eOI7j934/LilgalpwTVhjVfEtBd1q6Idsf9l2M1LgKgkKTUFk5/FS+1woY5CuKV8cWJQD/vvJCo2jqQNfQkvizPLf7/lN+9J88m5+rId2nJ+ts3T7wScL0lD2rtmUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781508630; c=relaxed/simple;
	bh=BMnYvTueVRtOJzvnjMO5lxR98rDNHb6q/4GOeJb3Gc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WElMnycI0exGIC891FkIq8HbTqXvf6JrXLT8lpYm8veRVxWIPnT8h3WFGAuzTT1q32FOosTh22lsA01Vz3SjNgmz6t2BD4u9/NI6fJJBtEV0YzD22bHxXar7x67ItuXa0hn2hBFsXZ+f3jtR4bsK0n6IQPh8/arllpa5EAStw8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZRx3brE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZRx3brE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26E31F00A3A
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 07:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781508629;
	bh=BMnYvTueVRtOJzvnjMO5lxR98rDNHb6q/4GOeJb3Gc0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VZRx3brEk4ToV5li6Z0r9llW6TjsYgz0SfirLI24oodPtqzQwAXIBjY+V4tcXCF51
	 1Y7I1zF+SvGfC9Rtw+GEwokfWxtZ8yJNf5py+StAYv1bf4UoYkUTHDf6h/5//Jh0sW
	 JZYwqMunbrS5eRxOfa25el8heRGkfnE56o/iC867ASS98XBSxmD5YIdKBtbHWmmZEQ
	 IrwSJcWwLB1P9OSQ9LuK+wX/4anVtY646o7I54ATIsDdjHu74mHZ/uzkk19yQt7IkZ
	 JBGNuy8Tzp2BnsV6vA+Z4FQ9I1jtBFD+91Kss0LdBLRj0By4nACbML1wubAvQK3/lz
	 FAy96juYejLtw==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-68d234218bcso5236171a12.2
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 00:30:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8RmW9pIlRQc7Hcms/7s1Vy1al27r2+u5mi6CvieXsEch3484mHRMcSrJnVwfkrrCHUmei52S8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT08+vUo17cdbyRQ2Vmx/ZThxdeYLGNbOxHHVtHq4JsSSUy0Rt
	LTdgUon7OqhCV8rfiaWVaaXoaAiBwrVbXtQSFSd1T2ClOofJzsOi3pfWBRVn7y3rpcWdSxf7142
	gGljod0i6gHOmdL2jfuxxAkThcetfpqU=
X-Received: by 2002:a17:907:75c9:b0:bd3:32ce:8902 with SMTP id
 a640c23a62f3a-bff4cddb237mr270582966b.39.1781508627726; Mon, 15 Jun 2026
 00:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608093729.12111-1-jelonek.jonas@gmail.com>
 <CAAhV-H7vJ5YniUD8HhFWBbypNyWTo73M_vzw=Y-MZtR-b_RNfw@mail.gmail.com>
 <731bd6c4-0f70-45a2-8480-8fed315b82b4@gmail.com> <CAAhV-H6Va1VzpvdA-w5fX9KrZQArdX_Bjpg6t+4QNn3jHfgjmA@mail.gmail.com>
 <e9696d4d-7cd0-4d7f-af87-2b4631549475@gmail.com>
In-Reply-To: <e9696d4d-7cd0-4d7f-af87-2b4631549475@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 15 Jun 2026 15:30:48 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5psOJQey+frswdc5Q76UnhCkrHJ_jtqvxHsfmi-dskyw@mail.gmail.com>
X-Gm-Features: AVVi8Ce1-6Nnas-lwg4l-E-kfoY50D5BBxPn0_Azq9u1yR7Irvo3zkiiFXrM894
Message-ID: <CAAhV-H5psOJQey+frswdc5Q76UnhCkrHJ_jtqvxHsfmi-dskyw@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 3:16=E2=80=AFPM Jonas Jelonek <jelonek.jonas@gmail.=
com> wrote:
>
> Hi Huacai,
>
> On 15.06.26 09:09, Huacai Chen wrote:
> > On Mon, Jun 15, 2026 at 3:00=E2=80=AFPM Jonas Jelonek <jelonek.jonas@gm=
ail.com> wrote:
> >> Hi Huacai,
> >>
> >> sorry for the reply delay.
> >>
> >> On 10.06.26 08:05, Huacai Chen wrote:
> >>> [...]
> >>> In theory LoongArch has the same problem, but I cannot reproduce,
> >>> should I enable PREEMPT_RT? Or there are some special configurations?
> >> Sadly I cannot help with that. For MIPS, this seems to be the default
> >> behavior.
> > This patch fixes 91840be8f710, and 91840be8f710 adds synchronize_rcu()
> > in irq_work_sync(). Your problem is caused by this synchronize_rcu(),
> > right?
>
> Yes it is.
>
> > However, synchronize_rcu() only gets called in the
> > IS_ENABLED(CONFIG_PREEMPT_RT) case, so I think your configuration
> > needs PREEMPT_RT, right?
> >
> > You said this is the default behavior, but PREEMPT_RT is not enabled by=
 default.
>
> The condition where this is added has two parts, see [1]. While PREEMPT_R=
T
> isn't active for MIPS, arch_irq_work_has_interrupt gives false for MIPS (=
since
> there is no implementation and it falls back to the generic one). This th=
en
> also calls synchronize_rcu.
Sorry, this is my mistake, then what's your preemption model? There
are too many config files for MIPS now.

Huacai

>
> > Huacai
> >
>
> Best,
> Jonas
>
> [1] https://elixir.bootlin.com/linux/v7.1-rc7/source/kernel/irq_work.c#L2=
91-L302
