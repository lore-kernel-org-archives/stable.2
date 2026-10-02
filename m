Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2755538E5C8
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790964902; cv=none; b=BcOXfF0moZtDEfyqTlkfsSUdQ8qB5MGu9q1xTZpJHyYhHAch/hZvoCT2+3nKVkRRV4Fuz7wLCd8hsd3CVD9APHahLDlr44bVTCIJLMt81GRiNyK10rBby1vye74orA7uoGfbbBitgNzkIFVxN2u458hu8CrTNuAeP0v76pYQywY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790964902; c=relaxed/simple;
	bh=+zeNufoCEFx4IFN75vfr8kfaUmsOW5mvJwQy3E7Va0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECAAllr/QfUQ/KLrbICbmwVpilKlRmAYlR1fPxHXQxGVCAUMokmMOyQTAlHntk7BpQPFIAzIOkcLx2jC49xiueW/tx8+qiN1PVDYentJ6wVigq1wkcTIBn2RH3bcGLJdEJ5aWrJi6tgRks9E+RsIlJA2AaRrJNDlI97OodCuHUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6yhMITU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6yhMITU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0459F1F00899
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 18:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790964900;
	bh=CcQIlSTNtz7AXnQHZXt4MlH12cLkMY7zH3MNyPhmnSw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=g6yhMITUI8JBv6O2XYwWvkgNtZVm3iuhQEaQVX4IeNIq4XcuWe6O7fjdJfV6jkLcs
	 yYD+O4U7lBZ9Y1ksp6soIg06pUmEqywUZIKfMBQ1LKcOoIb6vnHRynGs2u8RBnWKKk
	 9vmagtmvK+rWD9sGIA29BjL5g+rx62TR4FfDn+ozAUIpz17uPrpxjH5eX5HLuaWHDJ
	 DiVvjVgcJU6eBnBVf8eAPIrHO+bOOIE1BJIxxn6JEyO3+gODJyITm1RJhrT4JOjnsR
	 X7DhnIbnTfXJckrCbizrQ/xuAdd/5isSJAhq3NFrOfqthDzq7+CtfyDAe+hBZN7rUf
	 q0ylANa+2VUGw==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b8e986b8b1so8354718e87.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 11:14:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByeutbkf/A/7umsv9g/TUns75A1WaQ2n/bFFaaWCkEdYhTc7UY/IGLAu1TZTvQAUghjQtKZ59U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbn4tXnfEIujjlxjnwsrDMNX6rGjQLeAOQrSGUOq2Tch2qnwIV
	3kB1ZNfK0MbM9DtTEXeRuNvUaGma7JbaG7DWdXPfQe7tspsNfijs6ZRteVB/Kb3SH1cgziNKTCd
	UxcaLWaDVznRfiqFrkemxtu7CxYCfpsM=
X-Received: by 2002:a05:6512:ace:b0:5ae:bc65:5141 with SMTP id
 2adb3069b0e04-5bb9bb1a02amr1285277e87.11.1790964898390; Fri, 02 Oct 2026
 11:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001121254.883973-1-vaknins33@gmail.com> <ar-_BMp5cuPwDw5J@redhat.com>
 <CAJZ5v0g83_OCjh+RjG3H45mADE48vJdrEYahWGJShv62VAVvkA@mail.gmail.com> <ar_yoLIkXpEgwPFr@redhat.com>
In-Reply-To: <ar_yoLIkXpEgwPFr@redhat.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 2 Oct 2026 20:13:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jQgroKLxnyeKLedZvc9f7k0OLhHAwpHjvWK1E1BHDq2A@mail.gmail.com>
X-Gm-Features: AclHuK9qjeEeqXsnVzQb_E-5BjIROj2N8N80tO4elq8tG7GryJssE5Lf613NJiE
Message-ID: <CAJZ5v0jQgroKLxnyeKLedZvc9f7k0OLhHAwpHjvWK1E1BHDq2A@mail.gmail.com>
Subject: Re: [PATCH] pid_namespace: make zap_pid_ns_processes() freezable
To: Oleg Nesterov <oleg@redhat.com>, Aviv Vaknin <vaknins33@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 8:06=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 10/02, Rafael J. Wysocki (Intel) wrote:
> >
> > On Fri, Oct 2, 2026 at 4:26=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> =
wrote:
> > >
> > > > @@ -243,6 +244,11 @@ void zap_pid_ns_processes(struct pid_namespace=
 *pid_ns)
> > > >       do {
> > > >               clear_thread_flag(TIF_SIGPENDING);
> > > >               rc =3D kernel_wait4(-1, NULL, __WALL, NULL);
> > > > +             /*
> > > > +              * The freezer's fake signal ends the wait with -ERES=
TARTSYS;
> > > > +              * freeze here, or one stuck pid namespace blocks sus=
pend.
> > > > +              */
> > > > +             try_to_freeze();
> > > >       } while (rc !=3D -ECHILD);
> > >
> > > Somehow I still think it would be better to change do_wait() to use
> > > TASK_INTERRUPTIBLE | TASK_FREEZABLE. Slightly less robust in theory,
> > > but I think should work in practice...
> > >
> > > Rafael, what do you think?
> >
> > Well, why exactly do you think that TASK_INTERRUPTIBLE would be better
> > than TASK_IDLE here?
>
> Hmm... it seems we don't understand each other. At least I certainly don'=
t
> understand your "than TASK_IDLE here".
>
> I don't see TASK_IDLE "here", I see that this patch adds try_to_freeze()
> "here". And this is fine. But, I was thinking about this change instead:
>
>         --- x/kernel/exit.c
>         +++ x/kernel/exit.c
>         @@ -1729,7 +1729,7 @@ static long do_wait(struct wait_opts *wo
>                 add_wait_queue(&current->signal->wait_chldexit, &wo->chil=
d_wait);
>
>                 do {
>         -               set_current_state(TASK_INTERRUPTIBLE);
>         +               set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZ=
ABLE);
>                         retval =3D __do_wait(wo);
>                         if (retval !=3D -ERESTARTSYS)
>                                 break;
>
> because IMO it makes sense anyway. This way try_to_freeze_tasks() -> __fr=
eeze_task()
> path can freeze the tasks sleeping in do_wait() without waiting until the=
y react to
> fake_signal_wake_up() and call get_signal() -> try_to_freeze().
>
> Plus this looks simpler,  zap_pid_ns_processes() doesn't need another try=
_to_freeze().
>
> Sorry if I missed your point...

No worries and thanks for the explanation!

Yes, it looks simpler and it should actually work.

Aviv, what do you think?

> > > >       for (;;) {
> > > > -             set_current_state(TASK_INTERRUPTIBLE);
> > > > +             /*
> > > > +              * TASK_IDLE: no hung task warning or load for a wait=
 that can
> > > > +              * last as long as a tracer keeps a zombie, and a pen=
ding signal
> > > > +              * (e.g. the freezer's fake one) can't turn it into a=
 busy loop.
> > > > +              * TASK_FREEZABLE: let the freezer freeze us while we=
 wait.
> > > > +              */
> > > > +             set_current_state(TASK_IDLE | TASK_FREEZABLE);
> > >
> > > This looks like overdocumentation to me. I guess it was added by AI. =
Other users
> > > of IDLE/FREEZABLE do not try to document the meaning of these task st=
ates.
> >
> > It looks a bit like a note for self TBH.
>
> True. But...
>
> Ok, firstly the comment about TASK_IDLE looks a bit misleading to me. I m=
ean the
> "as long as a tracer keeps a zombie" part. At this point the descedants t=
raced from
> the parent namespace have already gone. The huge comment above this loop =
tries to
> explain the reasons for this "wait for pid_allocated =3D=3D init_pids" in=
 more details.
>
> Secondly. The comment about TASK_FREEZABLE looks fine. But why should the=
 user,
> zap_pid_ns_processes(), explain the semantics of TASK_FREEZABLE? Probably=
 this
> documentation makes sense, but then it should be moved to sched.h. Just m=
y IMHO.
>
> > > But this is subjective, I won't insist.
> >
> > Same here.
>
> OK ;)
>
> Oleg.
>
