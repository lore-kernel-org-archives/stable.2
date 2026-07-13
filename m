Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3FF3CF213
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955989; cv=pass; b=JAzRFm4dIKVnZbP0V/9oX8BQixLqqwBQzRHHoAKcyAzG3vuyNCiBcWMrDUdILPSZD1rFgo9FZ/clhtB2k8Wr8wOKrFCcHFtsR9GhvaaqLRluzYS/PdQT4OBeEH83xUwNRl4mpWG5ydVxPS1wohSFxxxiS4VZlxPAZC/uKy5CHcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955989; c=relaxed/simple;
	bh=cztgTTQFKjXX5TAy7SRyfnZPJ0Acz6gWoCC/Gtf5ItY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Odwk6Pz9nNzbxsGuPsfNYtzNpsHWkYyLGV4N2Dd7bkvNiS0a3H6ip4NKI5owTl+IO9x6xsOUlAxcZ4sse95owW9A4TCqwS9Bfl1lVH0zgqpCeQtJWvo79j0AGiAAFIYj+QJnkgj++t+MKLHJrU5HNngPIvHhX1yMCKN6PuRtp7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LBwS5OCo; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LBwS5OCo"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso5853a12.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 08:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783955986; cv=none;
        d=google.com; s=arc-20260327;
        b=bKXxeTWzyMUbw7fp5gXmlyQueSBauJ20m/Zm5fNPWS15f5DLsdginTG41yooWALXEt
         AyfOTNNAiNC5Vr67BygHztUz1whDB7QpsKmAr9Y1WceoP6GWCLvAeUvsyc2fwerE0sdI
         oO1RocguDXYF1DF4MIE64YKNa81tuo6awqJlqB6kYjrh/zJwHipYPGjFi8+Fitzi7JPp
         o6hVkGVj6sLIShaoRZpQPZGteWpYKPl5K/21e361fGveUIcMp9T8FiIAUBiEW1CuZW7C
         R5w90HISXL4K7DcR42r2msGx9/lNQis5tMM72evLrgbk6aIZPhWFlHRqcN3e3pD8cu5u
         5Sbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PlW85ZthPVYK+ZqbEqZBFSpb5hf+319IJ7QsaNTPeyE=;
        fh=tUsYnnqZwhvRMuT0abjged41PBfAZgaIZBM//KqaW7g=;
        b=SmDsahzmKMyPSndmrzYxCn0LnNhAWQW+sJ+KM7gIEnfncdICkYgZ98H5oUDlttp4gG
         0BiB/ISqE1aGYq21XYZDNxamMJR7p2Dvy3iIBxdT3MXHkj/aL/iwfJuig9RxoM+bMHil
         KhYKCqv8CO/r/jRS2+tTn9sq4MNTUseqmtfh9Dqgkd45iBhbG+mwxQgEyMkcK4HM79Tv
         VvH5tU5AtpJmETstCijv6XIqtZzf8kvwMD4CopgFX1FWThw0rbsXFv+sVmNGKgkSfYIH
         LbKqG3ro5vBELlWIA/JFV3gSL/EiZFl3gG0T/n0hlPBcbzu2jqdZqvVALFiLxfe3/vhG
         nZtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783955986; x=1784560786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PlW85ZthPVYK+ZqbEqZBFSpb5hf+319IJ7QsaNTPeyE=;
        b=LBwS5OCo3puiW5rivqXv/7ys44bNuZhyUlnN6Laz//4m0lMkDCD4gyq+1lXuUVmbdJ
         SjRXAG0DEuU1fzH6OpArc46H3QywTpVhpVpmlln1eDL30dO/VZuQgDzCE0qBXgpO9hV8
         Awil/+H3LbE/If8WQzQ8RGVob8n5U79GAJvwIEtYVIDlchOrhIXI/PmQLTOYjUkcBT3f
         FXdbT12QTAD/cO21GNSy4zN3zA60u+Xdx+nWSanuH/pTTAOvTSvORstDEM5sE/c7+Ii/
         qFJnYKUmXy3MxaV1AiRgFcjnD2iy4+J+AEKEcZQ2M4HroOJ4TattRlGhOcD3HabrgnMC
         lFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783955986; x=1784560786;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PlW85ZthPVYK+ZqbEqZBFSpb5hf+319IJ7QsaNTPeyE=;
        b=jb3hGagHuHgOQT361uUBGmiEEqC+4NEWrcTKhgE9DsCPDguJiCV1np23Eo/kN3RHcN
         hGCBPAC0ke2bdYKd0INBgMG0ntawYC5azBuSFKVhszF64SA1ZQTpY7AxAz0ObgprQ2vQ
         xnpp2duo2oICzMIQwtpf59MTi29dG1iVrOBqNIY6ShW420yFcLIjxmOiJjbZK9Er0bbv
         hCwR7H0n0rd+3FSDnY5s2vYqH/kGhrm5L3UAbbtjKxccty09dDElcfpei0aF0y6ncfAb
         ddPjUyB/xai4L9ULytcgWrJfkdoQVBUS9Y4Ng8hf1mqaiJuYfzVXx/skJB1wRRWim+95
         jeSQ==
X-Forwarded-Encrypted: i=1; AHgh+RrcY7qphZlyqzmXT4WIvDMwtrQF2Zhle0UfV3SRoLHHZlHEMBwKGracloKvHBZ+CmSS9M5anWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2PZ4u2O8JQDeqWj5B6Zbzyw76Jdt947ZLA8UU6ELDQZu1lOr6
	5HIVByV0T5Wi4vnlVBjR67hDgj5Mj5ykhMxGfGXFPptncg2xjPo55X69sKuo4zVtzB1IYI6ljZL
	O9jOisoq3RdiMcsuraRjcy/tbq4gvcSJnL7CLgb6E
X-Gm-Gg: AfdE7clH5QN9LKkEWlScq4/jwV4BnHVDfiJWe2r6bArD1dWpndogzPSUrzHZvWqkVk1
	SpsDnAxVr9MMkURMH6J0JZw/COr45bhCEJ/uXd7yKBWqtuYbtjftonXzMhPHdMU2dH3iQR1oAcH
	5avi4aOv9GwEuHZssx7iybcSBGP8RAvEq0ly9tHxEyvqZwInGLhtu1dWpSB+MpqPwQ3QlJvs8CA
	9V78D72HHFmegaEo3T9hYMTjRBvkSWRxhk74b8HveubedleRSvy1wSeJEJAKERtKt1fC1M=
X-Received: by 2002:a05:6402:14da:b0:69c:3005:12aa with SMTP id
 4fb4d7f45d1cf-69ccf0cfb26mr24416a12.6.1783955985293; Mon, 13 Jul 2026
 08:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712174619.3553231-1-tj@kernel.org> <20260712174619.3553231-3-tj@kernel.org>
 <20260713105655.GC276793@cmpxchg.org> <CAJuCfpEocgh+s_R_C6K25ESaSub=-vx6ZwqE-5HJddfBPMt7NA@mail.gmail.com>
In-Reply-To: <CAJuCfpEocgh+s_R_C6K25ESaSub=-vx6ZwqE-5HJddfBPMt7NA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 13 Jul 2026 08:19:32 -0700
X-Gm-Features: AUfX_mxGk_ykJQVoQ6GijNCWPdkmagBjFjBbdAci75lut8r9PEZbC2gUZjRpWQw
Message-ID: <CAJuCfpFcqmWnaUe4d8q1UNRpww6QLh40MX-C3-ajgDRjzBLM9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/psi: Shut down rtpoll_timer in psi_cgroup_free()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>, Matt Fleming <matt@readmodwrite.com>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Peter Zijlstra <peterz@infradead.org>, 
	Edward Adam Davis <eadavis@qq.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>, "ziwei . dai" <ziwei.dai@unisoc.com>, 
	"ke . wang" <ke.wang@unisoc.com>, Matt Fleming <mfleming@cloudflare.com>, sched-ext@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team@cloudflare.com, Sashiko AI <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 7:07=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Jul 13, 2026 at 3:56=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Sun, Jul 12, 2026 at 07:46:19AM -1000, Tejun Heo wrote:
> > > psi_schedule_rtpoll_work() is called locklessly from the scheduler ho=
tpath
> > > and can race psi_trigger_destroy() taking down the last rtpoll trigge=
r under
> > > rtpoll_trigger_lock:
> > >
> > >   psi_schedule_rtpoll_work()        psi_trigger_destroy()
> > >
> > >   rcu_read_lock();
> > >   task =3D rcu_dereference(rtpoll_task);
> > >                                     rcu_assign_pointer(rtpoll_task, N=
ULL);
> > >                                     timer_delete(&rtpoll_timer);
> > >   mod_timer(&rtpoll_timer, ...);
> > >   rcu_read_unlock();
> > >                                     synchronize_rcu();
> > >                                     kthread_stop(task_to_destroy);
> > >
> > > The group can then be freed with the re-armed timer still pending, an=
d
> > > poll_timer_fn() runs on freed memory.
> > >
> > > 461daba06bdc ("psi: eliminate kthread_worker from psi trigger schedul=
ing
> > > mechanism") deleted the timer synchronously after the synchronize_rcu=
(),
> > > which prevented this but raced trigger creation instead: the deletion=
 could
> > > cancel the timer that a new trigger set armed during the grace period=
 and,
> > > as creation also reinitialized the timer at the time, corrupt it.
> > > 8f91efd870ea ("psi: Fix race between psi_trigger_create/destroy") mov=
ed the
> > > initialization into group_init() and the deletion into the locked sec=
tion,
> > > trading the creation races for the window above.
> > >
> > > Neither placement in the destruction path works. A pending timer firi=
ng
> > > while the group is alive is harmless though. poll_timer_fn() just wak=
es the
> > > rtpoll waitqueue and doesn't re-arm itself. Bind the timer to the gro=
up's
> > > lifetime instead and shut it down in psi_cgroup_free(). Nothing can a=
rm it
> > > by then. timer_shutdown_sync() because the timer is never armed again=
.
> > >
> > > Fixes: 8f91efd870ea ("psi: Fix race between psi_trigger_create/destro=
y")
> > > Cc: stable@vger.kernel.org # v5.10+
> > > Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> > > Closes: https://lore.kernel.org/all/20260711000434.36C4A1F000E9@smtp.=
kernel.org/
> > > Signed-off-by: Tejun Heo <tj@kernel.org>
> >
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Suren Baghdasaryan <surenb@google.com>


> >
> > Both these patches look good to me, but Suren can you please also take
> > a look?
>
> Yes, I'm on it. Need some time to remind myself of all the details of
> the implementation.
