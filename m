Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508243DA7F3
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316348; cv=none; b=AMUhA9Q9m294I4D/gHKllfIAlG28vuVYkzmVuo6shoXGq6AOv4wcvzmftjRiQSEzbMzuRYMDAtbWEpS3wyKPT8+m+XVunzeTH6206/EQVIxw3SNj2ae7acOF6fGIVXnOUtjNyKCn3uOdsBKxQeJdt0fxEYpR3XeK/lcnqcP7cnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316348; c=relaxed/simple;
	bh=bIHPCHPeTWyLWSSLg2Wih8mmuE/8TdUsbfVXadmZQoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0o2MTExJQ0JOaZQ9eZFRiRhCu3tJF0Lg10v4+efeA5V1zAEUUOmy/IdAg69bYqqVqY7dw1OqWIG58OyujHLmlEbHVe8Af3jKQzj0AgEO2nMDuw/HvB5yysSs25Zm6UAVC9U3GJr5E8zxaVvavDU49hidhbWnsQqyS96dcbTSuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nql89Uxo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nql89Uxo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782316345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MDwgsSpIaXJqcgTFTiBzchXG7H7XwgMajj+pitRMm8Y=;
	b=Nql89UxoPMGg6mB6nbq8Ei3W2U9LI8or1Nztr0Rl/PZjBodddWR1RvBMUvcuk3Vu3Fb0jM
	+37MyyOgq3cgXzr03JEazCo4ITmwDrGMJfnKzB6cPuzevZdgWy++pxDlgGOV62FdIjXavN
	8WikqJXRFE6ciUCwCAr9vryRv6oDpkY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-HQ8F8BMCMzKPj9Y2QCZbEA-1; Wed,
 24 Jun 2026 11:52:21 -0400
X-MC-Unique: HQ8F8BMCMzKPj9Y2QCZbEA-1
X-Mimecast-MFC-AGG-ID: HQ8F8BMCMzKPj9Y2QCZbEA_1782316339
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0D1B1805C05;
	Wed, 24 Jun 2026 15:52:18 +0000 (UTC)
Received: from fedora (unknown [10.44.33.191])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 99FD41956042;
	Wed, 24 Jun 2026 15:52:11 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 24 Jun 2026 17:52:18 +0200 (CEST)
Date: Wed, 24 Jun 2026 17:52:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Bradley Morgan <include@grrlz.net>,
	Christian Brauner <brauner@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Marco Elver <elver@google.com>,
	Aleksandr Nogikh <nogikh@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] signal: avoid shared siginfo namespace rewrites
Message-ID: <ajv9KWlTGqNV_yi_@redhat.com>
References: <20260622164029.11474-1-include@grrlz.net>
 <86a8857d58d43ee26a8b365b837fd24830343494.1782159692.git.include@grrlz.net>
 <ajpv5bW01_xtlZ6R@redhat.com>
 <87bjd0c5xk.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjd0c5xk.fsf@email.froward.int.ebiederm.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 06/24, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > Add Eric.
> >
> > OK, I agree, it seems we need a simple fix.
> >
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> >
> > -------------------------------------------------------------------------
> > But let me add some "offtopic" notes... Why do we actually need this fix?
> >
> > kill_something_info(). But at first glance sys_kill/kill_something_info
> > can simply use SEND_SIG_NOINFO? If yes, this makes sense anyway, I will
> > re-check...

....

> So I think tracing the basic kill syscall is interesting.
>
> It uses an explicit siginfo.  It does that so it can choose
> between setting si_code to SI_TKILL and SI_USER.
>
> If the signal number is -1 it sends to every process in the
> system (or at least the pid namespace).
>
> That will require translation.

Most probably I was wrong, I didn't try to re-check yet.

But at first glance kill_something_info() never use SI_TKILL, and
__send_signal_locked(SEND_SIG_NOINFO) will do the necessary translation,
in this case si_pid/si_uid are the current task's pid/uid.

But again, I am not sure. Didn't have to to actually look at this code.

> I suspect just fixing send_signal_locked looks the easiest,
> especially if you make the siginfo parameter const.

Yes, agreed, and I have already acked this patch.

I think we can improve this unconditional rewrite later, on top of this fix.

Oleg.

