Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE724E322A
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958367; cv=none; b=ErkHyrYzPAUuOhn/twYU1j8Wy+R3bTmN+Op70wO9aIIgjGvDVs3sOJnV6CJtjhelErJlOh+eRyISLOkQo2vRzo03Fgu+Bo8gVdXNrTp47xTLSR2g11ZJ5AM2nUd+Y8MQEr+s92O+DvIU1qmRsDxe18ktmpUVc18KZRdpw6NO/lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958367; c=relaxed/simple;
	bh=E/bK6JmvxNUPBhX/YKGnGQI1gaFIzi/30hyJ4QEaBRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UH3CM1H6C2swedLLto5lWy4VsL5xx1aoK4/l6V79JzdW4Be/gn4UPRWEmU/mco1ood657vE+JmKShAxzr0nI660ZNMhQScnNULX9t1/4syoE/eF7SQppT1X2oMNzrk50DZboyDLq4uL17eEOeyf5mbqDfOsfPJtvQiWE+ukdaT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nh/ndIhr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nh/ndIhr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8351F0089C
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 16:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790958366;
	bh=1u4WTfoAF+tJH5NIKKMsUxrMmhds7yxTYPKhABsnG5M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nh/ndIhr7cfe0iSsa/h0hIBnfKnYxumfNGKrxifj9ofE3Y0/GlphLGCIp0ayHDUVX
	 votSY7A+gW0/iM0Ccg2Wsrr5pikG3qLIsDyX5oxCDeiqPDbdcYZfKhPJiL+JlE4n3N
	 W6NmRNZDZubuloGJ5d/lUM3pKCAMuM00dJE6qxHX/xQ9h0SaBhGMBaj+lcSOglDDFC
	 Vsx0ewpv5W/6J+qEuBrCaFebpxXOERgOQNYQz9Z6HgYcOTPCDnBJBI+WAmp28O7BTz
	 Ys39ps63vklxvVlPcYAD+j3NtbG4VNOc0tRxAcml9FvtU4NgB1sb22TPnfNTwXppZi
	 fTeolg1cA5vJg==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba3d90ac37so1262801e87.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 09:26:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxhnYJqh+ao4r/zpG3e3cdtcu5uw4SSA3H+r8p1KnbuzELRi9SQhK4eGcSi+OcYUCeIe8SpKrI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuoMOFHNfJ3X33g5V1KyKBrhNx9sheVFCKuDU7Y8Cv22vhUFi/
	7VHDAzrHB3tkHUdCVFIedLiHTIc7R4on+30wRHazFIHfD7c9wxnCOLweAHDnGNKKxDME+ctyDz3
	77wLngGkz3fYG+p91KKEpAwThac8WFfw=
X-Received: by 2002:a05:6512:23eb:b0:5b8:f4d4:8004 with SMTP id
 2adb3069b0e04-5bb9bb17a90mr930310e87.15.1790958364579; Fri, 02 Oct 2026
 09:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001121254.883973-1-vaknins33@gmail.com> <ar-_BMp5cuPwDw5J@redhat.com>
In-Reply-To: <ar-_BMp5cuPwDw5J@redhat.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 2 Oct 2026 18:24:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g83_OCjh+RjG3H45mADE48vJdrEYahWGJShv62VAVvkA@mail.gmail.com>
X-Gm-Features: AclHuK_pQGLSXLsWBAHI4U3-hkRk4Dsc0o3eWWG0Nb1LyeqIXVnJw1V3NULcaY0
Message-ID: <CAJZ5v0g83_OCjh+RjG3H45mADE48vJdrEYahWGJShv62VAVvkA@mail.gmail.com>
Subject: Re: [PATCH] pid_namespace: make zap_pid_ns_processes() freezable
To: Oleg Nesterov <oleg@redhat.com>
Cc: Aviv Vaknin <vaknins33@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 4:26=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 10/01, Aviv Vaknin wrote:
> >
> > Fixes: 3eb07c8c8adb ("pid namespaces: destroy pid namespace on init's d=
eath")
> > Fixes: b9a985db9896 ("pid_ns: Sleep in TASK_INTERRUPTIBLE in zap_pid_ns=
_processes")
> > Cc: stable@vger.kernel.org # 6.1+
> > Assisted-by: Claude:claude-opus-5-5
> > Signed-off-by: Aviv Vaknin <vaknins33@gmail.com>
>
> OK, since Rafael agrees with this patch
>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
>
>
> but see below...
>
> > @@ -243,6 +244,11 @@ void zap_pid_ns_processes(struct pid_namespace *pi=
d_ns)
> >       do {
> >               clear_thread_flag(TIF_SIGPENDING);
> >               rc =3D kernel_wait4(-1, NULL, __WALL, NULL);
> > +             /*
> > +              * The freezer's fake signal ends the wait with -ERESTART=
SYS;
> > +              * freeze here, or one stuck pid namespace blocks suspend=
.
> > +              */
> > +             try_to_freeze();
> >       } while (rc !=3D -ECHILD);
>
> Somehow I still think it would be better to change do_wait() to use
> TASK_INTERRUPTIBLE | TASK_FREEZABLE. Slightly less robust in theory,
> but I think should work in practice...
>
> Rafael, what do you think?

Well, why exactly do you think that TASK_INTERRUPTIBLE would be better
than TASK_IDLE here?

> >       for (;;) {
> > -             set_current_state(TASK_INTERRUPTIBLE);
> > +             /*
> > +              * TASK_IDLE: no hung task warning or load for a wait tha=
t can
> > +              * last as long as a tracer keeps a zombie, and a pending=
 signal
> > +              * (e.g. the freezer's fake one) can't turn it into a bus=
y loop.
> > +              * TASK_FREEZABLE: let the freezer freeze us while we wai=
t.
> > +              */
> > +             set_current_state(TASK_IDLE | TASK_FREEZABLE);
>
> This looks like overdocumentation to me. I guess it was added by AI. Othe=
r users
> of IDLE/FREEZABLE do not try to document the meaning of these task states=
.

It looks a bit like a note for self TBH.

> But this is subjective, I won't insist.

Same here.
