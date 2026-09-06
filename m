Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF47F33F5BE
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788737343; cv=none; b=oefppzTG5twTeo5RnxH65VOGEbLQOJSDfRrkpb1XWWSCo5BShRZ/WCpKdadLsB6QWqnoYOsyE/4DV3YqzjSZKlQGFSLSY7boG+fH2tcH78PbzLLpjcEIwfuHF6/pAGOVrwO2QxH6Ng2iLd7CM9VmRYwbEIJqs6NUkMAsM4WTiZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788737343; c=relaxed/simple;
	bh=IomXeuxLOFZ9NHavdsAZ0F8ckc7BZUscwt+2r9jm/Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KamNFTB2iDynK9Jsb3TeLIBqEu+hIOR6hCuy2ZPsVPXz7XW7Bz2AxMSHYt/GwdKmrF9ZKyAnRw3jlsZcMMQTqpMsvbrVm3x+60/E4U1+16KrqsqaU4J786++FPO9IEM1vGJybqStjH7ssuoXbcHRBRdmiZ/vVOzxptXrb9mGOJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPdXwh/c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPdXwh/c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788737340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0RXxc/fm/peHqnyfxHddH2UYu4f3BWPSw3qahcgCkuc=;
	b=IPdXwh/cpL0xMS8Ej84ss76Pp9whMVj7Wsn1Q7209ub27QWgTshjNTvaXsTBJN/nzMAxD2
	/Vnwiurea4kafp+3PWUX0qf8JB3+E5E8CD/6sg/AqhNhAbckiZd8tuzOrfZU56K+fveXWf
	2eQqB9PStrRWEYnXICu8XrpJl4Y3mo4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-uOLwg1EmOKyKerHAxXvMMA-1; Sun,
 06 Sep 2026 19:28:57 -0400
X-MC-Unique: uOLwg1EmOKyKerHAxXvMMA-1
X-Mimecast-MFC-AGG-ID: uOLwg1EmOKyKerHAxXvMMA_1788737335
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C38A51800C3C;
	Sun,  6 Sep 2026 23:28:54 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0131730002EF;
	Sun,  6 Sep 2026 23:28:50 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  7 Sep 2026 01:28:54 +0200 (CEST)
Date: Mon, 7 Sep 2026 01:28:49 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <ap33Mfki2YHT3lsx@redhat.com>
References: <20260905181551.738186850@kernel.org>
 <20260905185839.667208455@kernel.org>
 <8733vmatsi.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8733vmatsi.fsf@email.froward.int.ebiederm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 09/06, Eric W. Biederman wrote:
>
> Thomas Gleixner <tglx@kernel.org> writes:
>
> > @@ -1019,6 +1029,21 @@ static inline bool legacy_queue(struct s
> >  	return (sig < SIGRTMIN) && sigismember(&signals->signal, sig);
> >  }
> >
> > +/*
> > + * When PF_EXITING is set the task is on the way out and has t::pending
> > + * flushed already. Prevent queueing of PIDTYPE_PID signals as they would
> > + * be leaked.
> > + */
> > +static inline bool task_can_queue_signal(struct task_struct *t, enum pid_type type)
> > +{
> > +	lockdep_assert_held(&t->sighand->siglock);
> > +
> > +	if (!(t->flags & PF_EXITING))
> > +		return true;
> > +
>
> I don't know if we care but I just noticed that this disallows
> using tkill(..., SIGKILL) or tgkill(..., SIGKILL) to stop coredumps.

I think we do care, but the coredumping thread is not PF_EXITING ?

Oleg.

