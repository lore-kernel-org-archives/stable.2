Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D4C4EDCC8
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790964410; cv=none; b=bEjiX2+P7F013hGDtmDElFXKfjb5up5YDHcHL+nWDyKd/AkC5CTLiqGQui4Sx5hkiW6XLOf7L0DIFTwHfD2NSo7dP//3NmwFC1IUSa9EbqYKWtjF3dNuIq16EvE/wEsV8OYJMddiKArSudFLgB+GC9pyI3MtQsyjEmqh2xlp+zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790964410; c=relaxed/simple;
	bh=OqWunBFonzFz/63IcyALvpqF6E3rDMPGhS2REZMmq90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLkj3iIpCqWmXzrG0fISwTld3MAnYQGz1FtNpHdTJZZI938xJiYD3/PgnDwgGmG9wg6qAO+pw/fARJUS5Yv2nNo8MYGIMea48F0+RnRoeHRJ1B2NsU+97aHfizaT1rHxK5otpYcG29lfb2BuL1r04LOwhv+KnmU4Fi2HgN3Lydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2DcB9si; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2DcB9si"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790964397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+y4nrr+vSZo4aY+irLc+P3ev4CCpk/jC+sMPXWLgv/w=;
	b=N2DcB9sicSZ5mFYjERoHp+w6Ykl17lUy+iMsVZmJ3epBedT4jXIRHngYsZZNsaCkLNOqh3
	r7ZqxubbK5r1e6kHLZ1fAcbqsDSFpRVkQkRKUucrGuzJ9g0+00KthEVct60qTznmlOD+2i
	u6tb3jrwo3M9ei9AVnSJdHhler3BHO0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-UVfbMVUlO1iSoFqW0Dz6zA-1; Fri,
 02 Oct 2026 14:06:31 -0400
X-MC-Unique: UVfbMVUlO1iSoFqW0Dz6zA-1
X-Mimecast-MFC-AGG-ID: UVfbMVUlO1iSoFqW0Dz6zA_1790964388
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 775121844BF5;
	Fri,  2 Oct 2026 18:06:28 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3D7EE180049F;
	Fri,  2 Oct 2026 18:06:26 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Fri,  2 Oct 2026 20:06:28 +0200 (CEST)
Date: Fri, 2 Oct 2026 20:06:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Aviv Vaknin <vaknins33@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] pid_namespace: make zap_pid_ns_processes() freezable
Message-ID: <ar_yoLIkXpEgwPFr@redhat.com>
References: <20261001121254.883973-1-vaknins33@gmail.com>
 <ar-_BMp5cuPwDw5J@redhat.com>
 <CAJZ5v0g83_OCjh+RjG3H45mADE48vJdrEYahWGJShv62VAVvkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g83_OCjh+RjG3H45mADE48vJdrEYahWGJShv62VAVvkA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 10/02, Rafael J. Wysocki (Intel) wrote:
>
> On Fri, Oct 2, 2026 at 4:26 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > @@ -243,6 +244,11 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
> > >       do {
> > >               clear_thread_flag(TIF_SIGPENDING);
> > >               rc = kernel_wait4(-1, NULL, __WALL, NULL);
> > > +             /*
> > > +              * The freezer's fake signal ends the wait with -ERESTARTSYS;
> > > +              * freeze here, or one stuck pid namespace blocks suspend.
> > > +              */
> > > +             try_to_freeze();
> > >       } while (rc != -ECHILD);
> >
> > Somehow I still think it would be better to change do_wait() to use
> > TASK_INTERRUPTIBLE | TASK_FREEZABLE. Slightly less robust in theory,
> > but I think should work in practice...
> >
> > Rafael, what do you think?
>
> Well, why exactly do you think that TASK_INTERRUPTIBLE would be better
> than TASK_IDLE here?

Hmm... it seems we don't understand each other. At least I certainly don't
understand your "than TASK_IDLE here".

I don't see TASK_IDLE "here", I see that this patch adds try_to_freeze()
"here". And this is fine. But, I was thinking about this change instead:

	--- x/kernel/exit.c
	+++ x/kernel/exit.c
	@@ -1729,7 +1729,7 @@ static long do_wait(struct wait_opts *wo
		add_wait_queue(&current->signal->wait_chldexit, &wo->child_wait);
	 
		do {
	-		set_current_state(TASK_INTERRUPTIBLE);
	+		set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
			retval = __do_wait(wo);
			if (retval != -ERESTARTSYS)
				break;

because IMO it makes sense anyway. This way try_to_freeze_tasks() -> __freeze_task()
path can freeze the tasks sleeping in do_wait() without waiting until they react to
fake_signal_wake_up() and call get_signal() -> try_to_freeze().

Plus this looks simpler,  zap_pid_ns_processes() doesn't need another try_to_freeze().

Sorry if I missed your point...

> > >       for (;;) {
> > > -             set_current_state(TASK_INTERRUPTIBLE);
> > > +             /*
> > > +              * TASK_IDLE: no hung task warning or load for a wait that can
> > > +              * last as long as a tracer keeps a zombie, and a pending signal
> > > +              * (e.g. the freezer's fake one) can't turn it into a busy loop.
> > > +              * TASK_FREEZABLE: let the freezer freeze us while we wait.
> > > +              */
> > > +             set_current_state(TASK_IDLE | TASK_FREEZABLE);
> >
> > This looks like overdocumentation to me. I guess it was added by AI. Other users
> > of IDLE/FREEZABLE do not try to document the meaning of these task states.
>
> It looks a bit like a note for self TBH.

True. But...

Ok, firstly the comment about TASK_IDLE looks a bit misleading to me. I mean the
"as long as a tracer keeps a zombie" part. At this point the descedants traced from
the parent namespace have already gone. The huge comment above this loop tries to
explain the reasons for this "wait for pid_allocated == init_pids" in more details.

Secondly. The comment about TASK_FREEZABLE looks fine. But why should the user,
zap_pid_ns_processes(), explain the semantics of TASK_FREEZABLE? Probably this
documentation makes sense, but then it should be moved to sched.h. Just my IMHO.

> > But this is subjective, I won't insist.
>
> Same here.

OK ;)

Oleg.

